#!/usr/bin/env bash
# Keep every marketplace-visible version in step with the release version.
#
#   sync-versions.sh sync <version> [--dry-run] [dir]   write <version> into manifests
#   sync-versions.sh check [<version>] [dir]            verify manifests agree
#   sync-versions.sh list [dir]                         print discovered manifests
#
# Manifests are discovered, not listed: marketplace.json / plugin.json inside a
# .claude-plugin, .codex-plugin or .agents/plugins directory. Only version
# fields that already exist are touched (.version, .metadata.version,
# .plugins[].version); none are added. Without <version>, `check` only requires
# all discovered versions to be equal. Finding no manifests is not an error, so
# this is safe before the plugin packages exist. Needs: jq.
set -euo pipefail

mode="${1:-}"; shift || true
version=""; dry=0
for a in "$@"; do
  case "$a" in
    --dry-run) dry=1 ;;
    *) if [ -z "$version" ] && [[ "$a" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then version="$a"; else dir="$a"; fi ;;
  esac
done
dir="${dir:-$(git rev-parse --show-toplevel)}"
command -v jq >/dev/null || { echo "error: jq is required." >&2; exit 1; }

manifests() {
  (cd "$dir" && find . \( -name .git -o -name node_modules -o -name dist -o -name worktrees \) -prune -o \
    -type f \( -name plugin.json -o -name marketplace.json \) \
    \( -path '*/.claude-plugin/*' -o -path '*/.codex-plugin/*' -o -path '*/.agents/plugins/*' \) -print | sed 's|^\./||' | sort)
}
versions_in() { # file -> one version per line
  jq -r '[.version?, .metadata?.version?, (.plugins[]?.version?)] | map(select(. != null)) | .[]' "$dir/$1"
}

files="$(manifests)"
case "$mode" in
  list) [ -z "$files" ] || printf '%s\n' "$files" ;;
  sync)
    [ -n "$version" ] || { echo "usage: $0 sync <x.y.z> [--dry-run] [dir]" >&2; exit 2; }
    [ -n "$files" ] || { echo "No marketplace/plugin manifests to sync."; exit 0; }
    while IFS= read -r f; do
      cur="$(versions_in "$f" | sort -u | paste -sd, -)"
      [ -n "$cur" ] || { echo "skip $f (no version field)"; continue; }
      [ "$cur" = "$version" ] && { echo "ok   $f already $version"; continue; }
      if [ "$dry" = 1 ]; then echo "[dry-run] would sync $f: $cur -> $version"; continue; fi
      tmp="$(mktemp)"
      jq --arg v "$version" '
        (if has("version") then .version = $v else . end)
        | (if (.metadata? | type) == "object" and (.metadata | has("version")) then .metadata.version = $v else . end)
        | (if (.plugins? | type) == "array" then .plugins |= map(if has("version") then .version = $v else . end) else . end)
      ' "$dir/$f" > "$tmp"
      cat "$tmp" > "$dir/$f"; rm -f "$tmp"
      echo "sync $f: $cur -> $version"
    done <<<"$files"
    ;;
  check)
    [ -n "$files" ] || { echo "No marketplace/plugin manifests to check."; exit 0; }
    rc=0; all=""
    while IFS= read -r f; do
      vs="$(versions_in "$f" | sort -u)"
      all+="$vs"$'\n'
      if [ -n "$version" ] && [ -n "$vs" ] && [ "$vs" != "$version" ]; then
        echo "error: $f has version $(paste -sd, - <<<"$vs"), expected $version." >&2; rc=1
      fi
    done <<<"$files"
    n="$(printf '%s' "$all" | grep -v '^$' | sort -u | wc -l | tr -d ' ')"
    if [ -z "$version" ] && [ "$n" -gt 1 ]; then
      echo "error: manifest versions disagree: $(printf '%s' "$all" | grep -v '^$' | sort -u | paste -sd, -)" >&2; rc=1
    fi
    [ "$rc" = 0 ] && echo "Manifest versions agree${version:+ with $version}."
    exit "$rc"
    ;;
  *) echo "usage: $0 sync <x.y.z> [--dry-run] [dir] | check [x.y.z] [dir]" >&2; exit 2 ;;
esac
