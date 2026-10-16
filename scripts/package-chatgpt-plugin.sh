#!/usr/bin/env bash
#
# Packages the Interview Journey ChatGPT Plugin (skills-only) into
# dist/interview-journey-chatgpt-plugin.zip.
#
# Layout: plugin.json, skills/interview-journey/SKILL.md (frontmatter from
# chatgpt/plugin/SKILL.header.md + body from the canonical
# chatgpt/instructions.md), and skills/interview-journey/references/
# (the generated Knowledge bundles + chatgpt/capability-policy.md).
# Nothing is duplicated in the repository: the archive is assembled from
# canonical sources. No MCP servers, Actions, hooks, or external APIs.
#
# Optional RELEASE_VERSION (unset keeps the committed manifest version).

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"

CHATGPT_DIR="${REPO_ROOT}/chatgpt"
PLUGIN_SRC="${CHATGPT_DIR}/plugin"
DIST_DIR="${REPO_ROOT}/dist"
BUILD_DIR="${REPO_ROOT}/.build/chatgpt-plugin-package"
PACKAGE_NAME="interview-journey-chatgpt-plugin"
OUTPUT_ZIP="${DIST_DIR}/${PACKAGE_NAME}.zip"
KNOWLEDGE_FILES=(01-product-orchestration-and-quality.md 02-role-resume-and-strategy.md 03-interview-execution.md)

fail() { echo "error: $1" >&2; exit 1; }

command -v zip >/dev/null 2>&1 || fail "the 'zip' command is required but was not found on PATH."
for f in "${PLUGIN_SRC}/plugin.json" "${PLUGIN_SRC}/SKILL.header.md" "${CHATGPT_DIR}/instructions.md" "${CHATGPT_DIR}/capability-policy.md"; do
  [ -f "$f" ] || fail "required file not found: $f"
done

[ -x "${SCRIPT_DIR}/build-chatgpt-knowledge.sh" ] || fail "required build script not found or not executable: ${SCRIPT_DIR}/build-chatgpt-knowledge.sh"
"${SCRIPT_DIR}/build-chatgpt-knowledge.sh" >/dev/null
for kf in "${KNOWLEDGE_FILES[@]}"; do
  [ -f "${CHATGPT_DIR}/knowledge/${kf}" ] || fail "Knowledge build did not produce: ${kf}"
done

rm -rf -- "${BUILD_DIR}"
PACKAGE_ROOT="${BUILD_DIR}/${PACKAGE_NAME}"
SKILL_DEST="${PACKAGE_ROOT}/skills/interview-journey"
mkdir -p -- "${SKILL_DEST}/references"

if [ -n "${RELEASE_VERSION:-}" ]; then
  [[ "${RELEASE_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.-]+)?$ ]] || fail "RELEASE_VERSION must be a semantic version, got: ${RELEASE_VERSION}"
  sed -E "s/(\"version\"[[:space:]]*:[[:space:]]*)\"[^\"]*\"/\1\"${RELEASE_VERSION}\"/" "${PLUGIN_SRC}/plugin.json" > "${PACKAGE_ROOT}/plugin.json"
else
  cp -- "${PLUGIN_SRC}/plugin.json" "${PACKAGE_ROOT}/plugin.json"
fi

{ cat "${PLUGIN_SRC}/SKILL.header.md"; printf '\n'; cat "${CHATGPT_DIR}/instructions.md"; } > "${SKILL_DEST}/SKILL.md"
for kf in "${KNOWLEDGE_FILES[@]}"; do
  cp -- "${CHATGPT_DIR}/knowledge/${kf}" "${SKILL_DEST}/references/${kf}"
done
cp -- "${CHATGPT_DIR}/capability-policy.md" "${SKILL_DEST}/references/capability-policy.md"

find "${BUILD_DIR}" -type f \( -name ".DS_Store" -o -name "Thumbs.db" \) -delete

mkdir -p -- "${DIST_DIR}"
rm -f -- "${OUTPUT_ZIP}"
( cd "${BUILD_DIR}" && zip -r -X -q "${OUTPUT_ZIP}" "${PACKAGE_NAME}" )
rm -rf -- "${BUILD_DIR}"

[ -f "${OUTPUT_ZIP}" ] || fail "packaging failed: ${OUTPUT_ZIP} was not created"
echo "Packaged ChatGPT Plugin: ${OUTPUT_ZIP}"
echo ""
echo "Packaged files:"
unzip -Z1 "${OUTPUT_ZIP}" | sort
