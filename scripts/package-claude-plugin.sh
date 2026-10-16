#!/usr/bin/env bash
#
# Packages the Interview Journey Claude Plugin into
# dist/interview-journey-claude-plugin.zip using an explicit allowlist
# (.claude-plugin/plugin.json and the canonical skills/interview-journey/
# Skill: SKILL.md, references/, templates/).
#
# Optional RELEASE_VERSION (unset keeps the committed manifest version)
# stamps that version into the packaged plugin manifest.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"

SKILL_SOURCE_DIR="${REPO_ROOT}/skills/interview-journey"
MANIFEST="${REPO_ROOT}/.claude-plugin/plugin.json"
DIST_DIR="${REPO_ROOT}/dist"
BUILD_DIR="${REPO_ROOT}/.build/claude-plugin-package"
PACKAGE_NAME="interview-journey-claude-plugin"
OUTPUT_ZIP="${DIST_DIR}/${PACKAGE_NAME}.zip"

fail() { echo "error: $1" >&2; exit 1; }

command -v zip >/dev/null 2>&1 || fail "the 'zip' command is required but was not found on PATH."
[ -f "${MANIFEST}" ] || fail "required file not found: ${MANIFEST}"
[ -f "${SKILL_SOURCE_DIR}/SKILL.md" ] || fail "required file not found: ${SKILL_SOURCE_DIR}/SKILL.md"
[ -d "${SKILL_SOURCE_DIR}/references" ] || fail "required directory not found: ${SKILL_SOURCE_DIR}/references"
[ -d "${SKILL_SOURCE_DIR}/templates" ] || fail "required directory not found: ${SKILL_SOURCE_DIR}/templates"

rm -rf -- "${BUILD_DIR}"
PACKAGE_ROOT="${BUILD_DIR}/${PACKAGE_NAME}"
SKILL_DEST="${PACKAGE_ROOT}/skills/interview-journey"
mkdir -p -- "${PACKAGE_ROOT}/.claude-plugin" "${SKILL_DEST}/references" "${SKILL_DEST}/templates"

if [ -n "${RELEASE_VERSION:-}" ]; then
  [[ "${RELEASE_VERSION}" =~ ^[0-9]+\.[0-9]+\.[0-9]+([-+][0-9A-Za-z.-]+)?$ ]] || fail "RELEASE_VERSION must be a semantic version, got: ${RELEASE_VERSION}"
  sed -E "s/(\"version\"[[:space:]]*:[[:space:]]*)\"[^\"]*\"/\1\"${RELEASE_VERSION}\"/" "${MANIFEST}" > "${PACKAGE_ROOT}/.claude-plugin/plugin.json"
else
  cp -- "${MANIFEST}" "${PACKAGE_ROOT}/.claude-plugin/plugin.json"
fi

cp -- "${SKILL_SOURCE_DIR}/SKILL.md" "${SKILL_DEST}/SKILL.md"
cp -- "${SKILL_SOURCE_DIR}"/references/*.md "${SKILL_DEST}/references/"
cp -- "${SKILL_SOURCE_DIR}"/templates/*.md "${SKILL_DEST}/templates/"

find "${BUILD_DIR}" -type f \( -name ".DS_Store" -o -name "Thumbs.db" \) -delete

mkdir -p -- "${DIST_DIR}"
rm -f -- "${OUTPUT_ZIP}"
( cd "${BUILD_DIR}" && zip -r -X -q "${OUTPUT_ZIP}" "${PACKAGE_NAME}" )
rm -rf -- "${BUILD_DIR}"

[ -f "${OUTPUT_ZIP}" ] || fail "packaging failed: ${OUTPUT_ZIP} was not created"
echo "Packaged Claude Plugin: ${OUTPUT_ZIP}"
echo ""
echo "Packaged files:"
unzip -Z1 "${OUTPUT_ZIP}" | sort
