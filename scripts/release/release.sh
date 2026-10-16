#!/usr/bin/env bash
# Compute the next semantic version since the last tag from each merged PR's
# `release:` label (falling back to Conventional Commits), update CHANGELOG.md,
# tag, and publish a GitHub Release with the Skill, External Kit, ChatGPT GPT
# and (when the tagged revision has their packagers) Claude plugin and ChatGPT
# plugin ZIPs attached. The release version is also written into every
# marketplace/plugin manifest (scripts/release/sync-versions.sh) in the single
# chore(release) commit. The ZIPs are built by the existing packaging scripts
# from the tagged revision, with RELEASE_VERSION exported, after
# tests/validate-repository.sh passes on it; the version inside each archive
# must match the tag.
# Safe to re-run: existing tags, changelog sections and release assets are
# never duplicated, and a missing Release or missing assets for the latest tag
# are recovered. Manual recovery: run this script locally (see
# policies/release-and-changelog.md).
#
# Usage: scripts/release/release.sh [--dry-run]
# Needs: git, zip, unzip, jq; gh + GH_TOKEN when publishing.
# Optional: GIT_USER_NAME / GIT_USER_EMAIL for the release commit identity.
set -euo pipefail

DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

cd "$(git rev-parse --show-toplevel)"
BASELINE="1.0.0"
ASSETS=(
  interview-journey.skill.zip
  interview-journey-claude-kit.zip
  interview-journey-chatgpt.zip
)
# Packages added by the plugin distribution work (#25). Published only when the
# tagged revision contains their packager, so older tags stay recoverable.
# Asset and script names must match #25's entry points; confirm on integration.
OPTIONAL_ASSETS=(
  interview-journey-claude-plugin.zip
  interview-journey-chatgpt-plugin.zip
)
packager_for() { # asset -> packaging script, run from the tagged revision
  case "$1" in
    interview-journey.skill.zip) echo package-claude-skill.sh ;;
    interview-journey-claude-kit.zip) echo package-claude-external-kit.sh ;;
    interview-journey-chatgpt.zip) echo package-chatgpt-gpt.sh ;;
    interview-journey-claude-plugin.zip) echo package-claude-plugin.sh ;;
    interview-journey-chatgpt-plugin.zip) echo package-chatgpt-plugin.sh ;;
  esac
}
assets_for() { # $1=git rev; required assets plus optional ones whose packager exists there
  local a
  printf '%s\n' "${ASSETS[@]}"
  for a in "${OPTIONAL_ASSETS[@]}"; do
    git cat-file -e "$1:scripts/$(packager_for "$a")" 2>/dev/null && printf '%s\n' "$a"
  done
  return 0
}
# Fail unless every marketplace/plugin manifest inside an archive carries the
# release version.
check_archive_version() { # $1=zip $2=version
  local x; x="$(mktemp -d)"
  unzip -q "$1" -d "$x"
  scripts/release/sync-versions.sh check "$2" "$x" >/dev/null \
    || { rm -rf "$x"; echo "error: $(basename "$1") contains manifests whose version is not $2." >&2; exit 1; }
  rm -rf "$x"
}
WT=""
trap '[ -z "$WT" ] || git worktree remove --force "$WT" >/dev/null 2>&1 || true' EXIT
if [ "$DRY_RUN" = 0 ]; then  # identity for the release commit and the annotated tag
  git config user.name "${GIT_USER_NAME:-github-actions[bot]}"
  git config user.email "${GIT_USER_EMAIL:-41898282+github-actions[bot]@users.noreply.github.com}"
fi
LAST_TAG="$(git describe --tags --abbrev=0 --match 'v[0-9]*' 2>/dev/null || true)"

# Release notes = the version's CHANGELOG.md section (without its heading).
notes_for() { # $1=version
  awk -v h="## $1 " 'index($0,h)==1 {f=1; next} f && /^## /{exit} f' CHANGELOG.md
}

# Create the Release if missing and upload any missing assets, building the
# ZIPs from the tagged revision so they match the published version. The
# tagged revision must pass the repository validator first.
ensure_release() { # $1=version
  local tag="v$1" notes missing=() have a files=() pk want=()
  if [ "$DRY_RUN" = 1 ]; then
    # In a dry run the tag may not exist yet; plan from HEAD.
    local rev="HEAD"; git rev-parse -q --verify "refs/tags/$tag" >/dev/null && rev="refs/tags/$tag"
    while IFS= read -r a; do want+=("$a"); done < <(assets_for "$rev")
    echo "[dry-run] would ensure Release $tag with assets: ${want[*]}"; return 0
  fi
  while IFS= read -r a; do want+=("$a"); done < <(assets_for "refs/tags/$tag")
  notes="$(mktemp)"; notes_for "$1" > "$notes"
  [ -s "$notes" ] || echo "Release $tag" > "$notes"
  if have="$(gh release view "$tag" --json assets -q '.assets[].name' 2>/dev/null)"; then
    for a in "${want[@]}"; do grep -qxF "$a" <<<"$have" || missing+=("$a"); done
    [ "${#missing[@]}" -eq 0 ] && { echo "Release $tag is complete."; return 0; }
  else
    missing=("${want[@]}")
  fi
  WT="$(mktemp -d)"
  git worktree add --detach "$WT" "refs/tags/$tag" >/dev/null
  "$WT/tests/validate-repository.sh" >/dev/null \
    || { echo "error: $tag failed tests/validate-repository.sh; not publishing." >&2; exit 1; }
  for a in "${missing[@]}"; do
    pk="$(packager_for "$a")"
    [ -x "$WT/scripts/$pk" ] || { echo "error: $tag has no scripts/$pk; cannot build $a." >&2; exit 1; }
    (cd "$WT" && RELEASE_VERSION="$1" "scripts/$pk" >/dev/null)
    [ -f "$WT/dist/$a" ] || { echo "error: $pk did not produce $a." >&2; exit 1; }
    (cd "$WT" && scripts/release/sync-versions.sh check "$1" >/dev/null) \
      || { echo "error: $tag manifests do not all carry version $1." >&2; exit 1; }
    check_archive_version "$WT/dist/$a" "$1"
    files+=("$WT/dist/$a")
    # deployment-release.json must trace to this tag, not a stray commit.
    if [ "$a" = interview-journey-chatgpt.zip ]; then
      unzip -p "$WT/dist/$a" '*/deployment-release.json' | grep -q "\"describe\": \"$tag\"" \
        || { echo "error: ChatGPT deployment-release.json does not describe $tag." >&2; exit 1; }
    fi
  done
  if gh release view "$tag" >/dev/null 2>&1; then
    gh release upload "$tag" "${files[@]}" --clobber
  else
    gh release create "$tag" "${files[@]}" --title "$tag" --notes-file "$notes" --verify-tag
  fi
  git worktree remove --force "$WT"; WT=""
}

tag_and_ensure() { # $1=version  $2=commit to tag
  local tag="v$1"
  if ! git rev-parse -q --verify "refs/tags/$tag" >/dev/null; then
    if [ "$DRY_RUN" = 1 ]; then echo "[dry-run] would tag $tag at $2"; ensure_release "$1"; return 0; fi
    git tag -a "$tag" "$2" -m "Release $tag"
    git push origin "refs/tags/$tag"
  else
    echo "Tag $tag already exists."
  fi
  ensure_release "$1"
}

# Validate the current checkout before creating any commit or tag, so a
# failing revision never gets a version.
validate_head() {
  tests/validate-repository.sh >/dev/null \
    || { echo "error: HEAD failed tests/validate-repository.sh; no release." >&2; exit 1; }
}

# First release: the existing changelog content is the baseline.
if [ -z "$LAST_TAG" ]; then
  echo "No tags found; cutting baseline v$BASELINE at HEAD."
  grep -q "^## $BASELINE" CHANGELOG.md || { echo "CHANGELOG.md lacks a '## $BASELINE' section" >&2; exit 1; }
  validate_head
  tag_and_ensure "$BASELINE" HEAD
  exit 0
fi

# Release level a commit's merged PR declared with a `release: <level>` label
# (see scripts/validate-pr-release.sh). Prints major|minor|patch|none, or
# nothing when the lookup succeeded and found no PR or no release label;
# callers then fall back to the Conventional Commit subject. A failed lookup
# (API error, missing permission) returns 1 so the release stops instead of
# silently ignoring labels. Without gh a dry run says so and uses subjects
# only; a real release needs gh anyway.
HAVE_GH=1
if ! command -v gh >/dev/null 2>&1; then
  [ "$DRY_RUN" = 1 ] || { echo "error: gh is required to read PR release labels." >&2; exit 1; }
  echo "note: gh not found; dry run uses commit subjects only." >&2; HAVE_GH=0
fi
pr_level() { # $1=commit sha
  [ "$HAVE_GH" = 1 ] || return 0
  local labels
  labels="$(gh api "repos/{owner}/{repo}/commits/$1/pulls" --jq '.[].labels[].name')" \
    || { echo "error: PR label lookup failed for ${1:0:7}. Check the release App's Pull requests: read permission and GH_TOKEN." >&2; return 1; }
  { grep -E '^release: (major|minor|patch|none)$' <<<"$labels" || true; } | head -n1 | sed 's/^release: //'
}

raise_bump() { # $1=level; keep the highest of major > minor > patch
  case "$1" in
    major) bump="major" ;;
    minor) [ "$bump" = major ] || bump="minor" ;;
    patch) [ -n "$bump" ] || bump="patch" ;;
  esac
}

# Classify commits since the last tag: the merged PR's release label when it
# has one, else the Conventional Commit subject (bodies for BREAKING CHANGE).
bump=""; feats=""; fixes=""; breaks=""
while IFS= read -r -d $'\x1e' rec; do
  rec="${rec#"${rec%%[![:space:]]*}"}"
  [ -z "$rec" ] && continue
  sha="$(printf '%s' "$rec" | head -n1)"
  subject="$(printf '%s' "$rec" | sed -n 2p)"
  body="$(printf '%s' "$rec" | tail -n +3)"
  re='^([a-z]+)(\([^)]*\))?(!)?: (.+)$'
  type=""; bang=""; desc="$subject"
  if [[ "$subject" =~ $re ]]; then type="${BASH_REMATCH[1]}"; bang="${BASH_REMATCH[3]}"; desc="${BASH_REMATCH[4]}"; fi
  desc="$(printf '%s' "$desc" | sed -E 's/ \(#[0-9]+\)$//')"
  level="$(pr_level "$sha")" || exit 1
  if [ -n "$level" ]; then
    case "$level" in
      none) continue ;;
      major) breaks+="- $desc"$'\n' ;;
      minor) feats+="- $desc"$'\n' ;;
      patch) fixes+="- $desc"$'\n' ;;
    esac
    raise_bump "$level"; continue
  fi
  [ -n "$type" ] || continue
  if [ -n "$bang" ] || printf '%s' "$body" | grep -qE '^BREAKING[ -]CHANGE:'; then
    breaks+="- $desc"$'\n'; raise_bump major; continue
  fi
  case "$type" in
    feat) feats+="- $desc"$'\n'; raise_bump minor ;;
    fix)  fixes+="- $desc"$'\n'; raise_bump patch ;;
  esac
done < <(git log "$LAST_TAG..HEAD" --format='%H%n%s%n%b%x1e')

if [ -z "$bump" ]; then
  echo "No release-worthy commits since $LAST_TAG; no new release."
  ensure_release "${LAST_TAG#v}"   # recovery: a missing Release/assets for the latest tag
  exit 0
fi

cur="${LAST_TAG#v}"; IFS=. read -r MA MI PA <<<"$cur"
case "$bump" in
  major) MA=$((MA+1)); MI=0; PA=0 ;;
  minor) MI=$((MI+1)); PA=0 ;;
  patch) PA=$((PA+1)) ;;
esac
NEW="$MA.$MI.$PA"

notes="$(mktemp)"
{
  [ -n "$breaks" ] && printf '### Breaking changes\n\n%s\n' "$breaks"
  [ -n "$feats" ]  && printf '### Features\n\n%s\n' "$feats"
  [ -n "$fixes" ]  && printf '### Fixes\n\n%s\n' "$fixes"
} > "$notes"

echo "Last tag: $LAST_TAG  ->  next: v$NEW ($bump)"
echo "---- changelog section ----"; cat "$notes"

# Idempotent: skip the file edit if the section is already present.
if ! grep -q "^## $NEW " CHANGELOG.md; then
  section="$(mktemp)"
  { printf '## %s - %s\n\n' "$NEW" "$(date -u +%F)"; cat "$notes"; } > "$section"
  out="$(mktemp)"
  # Insert before the first version heading.
  awk -v sec="$section" '!d && /^## /{while((getline l < sec)>0) print l; d=1} {print}' CHANGELOG.md > "$out"
  if [ "$DRY_RUN" = 1 ]; then diff -u CHANGELOG.md "$out" || true; else cp "$out" CHANGELOG.md; fi
fi

# Marketplace/plugin manifests carry the release version in the same commit.
if [ "$DRY_RUN" = 1 ]; then
  scripts/release/sync-versions.sh sync "$NEW" --dry-run
  tag_and_ensure "$NEW" HEAD; echo "[dry-run] done"; exit 0
fi
scripts/release/sync-versions.sh sync "$NEW"

validate_head
scripts/release/sync-versions.sh check "$NEW" >/dev/null
release_files=(CHANGELOG.md)
while IFS= read -r f; do [ -z "$f" ] || release_files+=("$f"); done < <(scripts/release/sync-versions.sh list)
if ! git diff --quiet -- "${release_files[@]}"; then  # nothing changed -> no commit
  git add -- "${release_files[@]}"
  git commit -m "chore(release): v$NEW"
  git push origin HEAD
fi
# Tag the release commit (recovers a run that pushed the commit but not the tag).
target="$(git log -1 --format=%H --grep="^chore(release): v$NEW\$")"
tag_and_ensure "$NEW" "${target:-HEAD}"
