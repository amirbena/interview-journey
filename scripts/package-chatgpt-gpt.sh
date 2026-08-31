#!/usr/bin/env bash
#
# Packages the Interview Journey ChatGPT Custom GPT deployment archive into
# dist/interview-journey-chatgpt.zip.
#
# Runs the Knowledge builder first, then assembles the archive around its
# output plus the deployment documentation, using an explicit allowlist.
#
# Works when invoked from inside or outside the repository root, since all
# paths are resolved relative to this script's own location.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"

CHATGPT_DIR="${REPO_ROOT}/chatgpt"
KNOWLEDGE_DIR="${CHATGPT_DIR}/knowledge"

DIST_DIR="${REPO_ROOT}/dist"
BUILD_DIR="${REPO_ROOT}/.build/chatgpt-gpt-package"
PACKAGE_NAME="interview-journey-chatgpt"
OUTPUT_ZIP="${DIST_DIR}/${PACKAGE_NAME}.zip"

fail() {
  echo "error: $1" >&2
  exit 1
}

command -v zip >/dev/null 2>&1 || fail "the 'zip' command is required but was not found on PATH. Install zip and re-run this script."

# Required deployment documentation.
DOCS=(README.md instructions.md builder-config.md conversation-starters.md builder-setup.md capability-policy.md testing-guide.md sharing-and-publishing.md publishing-knowledge.md knowledge-manifest.md)
for doc in "${DOCS[@]}"; do
  [ -f "${CHATGPT_DIR}/${doc}" ] || fail "required file not found: ${CHATGPT_DIR}/${doc}"
done

# Build the Knowledge bundles first — the archive embeds their output unchanged.
[ -x "${SCRIPT_DIR}/build-chatgpt-knowledge.sh" ] || fail "required build script not found or not executable: ${SCRIPT_DIR}/build-chatgpt-knowledge.sh"
"${SCRIPT_DIR}/build-chatgpt-knowledge.sh" >/dev/null

KNOWLEDGE_FILES=(01-product-orchestration-and-quality.md 02-role-resume-and-strategy.md 03-interview-execution.md)
for kf in "${KNOWLEDGE_FILES[@]}"; do
  [ -f "${KNOWLEDGE_DIR}/${kf}" ] || fail "Knowledge build did not produce: ${KNOWLEDGE_DIR}/${kf}"
done

# Only remove the dedicated build/staging directory — never an arbitrary path.
rm -rf -- "${BUILD_DIR}"
mkdir -p -- "${BUILD_DIR}"

PACKAGE_ROOT="${BUILD_DIR}/${PACKAGE_NAME}"
mkdir -p -- "${PACKAGE_ROOT}/knowledge"

# Explicit allowlist copy — never a recursive repository copy.
for doc in "${DOCS[@]}"; do
  cp -- "${CHATGPT_DIR}/${doc}" "${PACKAGE_ROOT}/${doc}"
done
for kf in "${KNOWLEDGE_FILES[@]}"; do
  cp -- "${KNOWLEDGE_DIR}/${kf}" "${PACKAGE_ROOT}/knowledge/${kf}"
done

# Release metadata — ties the packaged bundles to a repository commit so a
# deployed Custom GPT can be traced back to a repository version. dist/ is
# gitignored; this file is a build artifact, not a committed source.
REL_COMMIT="$(git -C "${REPO_ROOT}" rev-parse HEAD 2>/dev/null || echo unknown)"
REL_DESCRIBE="$(git -C "${REPO_ROOT}" describe --tags --always --dirty 2>/dev/null || echo unknown)"
REL_COMMIT_DATE="$(git -C "${REPO_ROOT}" show -s --format=%cI HEAD 2>/dev/null || echo unknown)"
REL_PACKAGED_AT="$(date -u +%Y-%m-%dT%H:%M:%SZ)"

RELEASE_JSON="${PACKAGE_ROOT}/deployment-release.json"
{
  printf '{\n'
  printf '  "package": "%s",\n' "${PACKAGE_NAME}"
  printf '  "repository": {\n'
  printf '    "commit": "%s",\n' "${REL_COMMIT}"
  printf '    "describe": "%s",\n' "${REL_DESCRIBE}"
  printf '    "commit_date": "%s"\n' "${REL_COMMIT_DATE}"
  printf '  },\n'
  printf '  "packaged_at": "%s",\n' "${REL_PACKAGED_AT}"
  printf '  "knowledge_bundles": [\n'
  kf_total="${#KNOWLEDGE_FILES[@]}"
  kf_i=0
  for kf in "${KNOWLEDGE_FILES[@]}"; do
    kf_i=$((kf_i + 1))
    bundle_file="${PACKAGE_ROOT}/knowledge/${kf}"
    digest="$(grep -m1 '^Content-Digest (sha256' "${bundle_file}" | sed 's/^.*: //')"
    printf '    {\n'
    printf '      "file": "knowledge/%s",\n' "${kf}"
    printf '      "content_digest_sha256": "%s",\n' "${digest}"
    printf '      "sources": [\n'
    src_lines=()
    while IFS= read -r line; do
      src_lines+=("${line}")
    done < <(sed -n '/^Sources (in order):/,/^Content-Digest/p' "${bundle_file}" | grep '^  ' | sed 's/^  //')
    src_total="${#src_lines[@]}"
    src_i=0
    for s in "${src_lines[@]}"; do
      src_i=$((src_i + 1))
      if [ "${src_i}" -lt "${src_total}" ]; then
        printf '        "%s",\n' "${s}"
      else
        printf '        "%s"\n' "${s}"
      fi
    done
    if [ "${kf_i}" -lt "${kf_total}" ]; then
      printf '      ]\n    },\n'
    else
      printf '      ]\n    }\n'
    fi
  done
  printf '  ]\n'
  printf '}\n'
} > "${RELEASE_JSON}"

# Strip platform artifacts if any slipped in via the source tree.
find "${BUILD_DIR}" -type f \( -name ".DS_Store" -o -name "Thumbs.db" \) -delete
find "${BUILD_DIR}" -type d -name "__MACOSX" -exec rm -rf -- {} + 2>/dev/null || true

mkdir -p -- "${DIST_DIR}"
rm -f -- "${OUTPUT_ZIP}"

(
  cd "${BUILD_DIR}"
  zip -r -X -q "${OUTPUT_ZIP}" "${PACKAGE_NAME}"
)

rm -rf -- "${BUILD_DIR}"

[ -f "${OUTPUT_ZIP}" ] || fail "packaging failed: ${OUTPUT_ZIP} was not created"

echo "Packaged ChatGPT Custom GPT: ${OUTPUT_ZIP}"
echo ""
echo "Packaged files:"
unzip -Z1 "${OUTPUT_ZIP}" | sort

echo ""
echo "== Deployment checklist (see chatgpt/publishing-knowledge.md) =="
echo "Repository commit: ${REL_COMMIT}"
echo "Repository describe: ${REL_DESCRIBE}"
echo "Replace exactly these ${#KNOWLEDGE_FILES[@]} Knowledge files in the GPT editor,"
echo "then Save/Update and Publish:"
for kf in "${KNOWLEDGE_FILES[@]}"; do
  bundle_file="${KNOWLEDGE_DIR}/${kf}"
  digest="$(grep -m1 '^Content-Digest (sha256' "${bundle_file}" | sed 's/^.*: //')"
  echo "  - knowledge/${kf}  sha256:${digest}"
done
