#!/usr/bin/env bash
#
# Deterministically generates the 3 ChatGPT Custom GPT Knowledge bundles
# under chatgpt/knowledge/ from an explicit allowlist of canonical
# repository sources. See chatgpt/knowledge-manifest.md for the full
# bundle-to-source mapping and rationale.
#
# Each bundle carries a deterministic provenance header (bundle position,
# ordered source list, and a sha256 Content-Digest).
#
# Digest normalization contract (identical in build-chatgpt-knowledge.ps1):
#   Digest input is the ordered concatenation of each listed source's raw
#   bytes with every CR (0x0D) byte removed. No other bytes are added,
#   removed, or normalized — a source's final-LF presence or absence is
#   preserved. The digest depends only on source content (no timestamp, no
#   commit), so rebuilding from unchanged sources produces byte-identical
#   output. The bundle body embeds the same CR-stripped bytes.
#
# Never edit a file under chatgpt/knowledge/ directly — rebuild it here.
# tests/validate-repository.sh rebuilds the bundles into a temporary
# directory and fails if the committed files differ in any byte.
#
# Usage: build-chatgpt-knowledge.sh [output_dir]
#   output_dir defaults to <repo>/chatgpt/knowledge. A non-default value is
#   used only by validation to render into a scratch directory.
#
# Works when invoked from inside or outside the repository root, since all
# paths are resolved relative to this script's own location.

set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"

KNOWLEDGE_DIR="${1:-${REPO_ROOT}/chatgpt/knowledge}"

fail() {
  echo "error: $1" >&2
  exit 1
}

# sha256 of stdin -> bare lowercase hex, portable across macOS/Linux.
sha256_hex() {
  if command -v shasum >/dev/null 2>&1; then
    shasum -a 256 | awk '{print $1}'
  elif command -v sha256sum >/dev/null 2>&1; then
    sha256sum | awk '{print $1}'
  else
    fail "no sha256 tool found (need 'shasum' or 'sha256sum' on PATH)."
  fi
}

# Explicit bundle -> source allowlist. One "bundle:source1,source2,..." entry
# per generated file, in generation order. Source paths are repo-root-relative.
# Every core/*.md, frameworks/NN-*.md, and the three schema/workflow sources
# appear in exactly one bundle. Boundaries follow the methodology's natural
# layers so semantically related content stays co-located for retrieval.
BUNDLES=(
  "01-product-orchestration-and-quality.md:core/product-definition.md,core/terminology.md,core/scope-and-non-goals.md,core/workflow.md,core/orchestration-policy.md,core/state-management.md,schemas/interview-journey-state.schema.md,frameworks/15-interview-journey-intelligence-framework.md,core/evidence-policy.md,core/accuracy-policy.md,core/context-priority.md,core/quality-gates.md,core/output-contracts.md,core/offer-negotiation-preparation.md"
  "02-role-resume-and-strategy.md:frameworks/01-role-intelligence-framework.md,frameworks/02-resume-intelligence-framework.md,frameworks/03-interview-stage-framework.md,frameworks/04-role-fit-gap-analysis-framework.md,frameworks/05-interview-intelligence-framework.md,frameworks/06-preparation-strategy-framework.md,schemas/public-research-evidence.schema.md,workflows/research-current-interview-intelligence.md,frameworks/07-question-prediction-framework.md,frameworks/08-interview-hypothesis-framework.md"
  "03-interview-execution.md:frameworks/09-coding-interview-decision-engine.md,frameworks/10-system-design-framework.md,frameworks/11-behavioral-interview-framework.md,frameworks/12-mock-interview-framework.md,frameworks/13-answer-coaching-framework.md,frameworks/14-post-interview-debrief-framework.md"
)

BUNDLE_COUNT="${#BUNDLES[@]}"

# Validate every canonical source exists before generating anything.
for entry in "${BUNDLES[@]}"; do
  sources="${entry#*:}"
  IFS=',' read -ra SRC_LIST <<< "${sources}"
  for src in "${SRC_LIST[@]}"; do
    [ -f "${REPO_ROOT}/${src}" ] || fail "required canonical source not found: ${REPO_ROOT}/${src}"
  done
done

mkdir -p -- "${KNOWLEDGE_DIR}"

# Remove stale generated files not on the current allowlist.
ALLOWED_NAMES=()
for entry in "${BUNDLES[@]}"; do
  ALLOWED_NAMES+=("${entry%%:*}")
done
if [ -d "${KNOWLEDGE_DIR}" ]; then
  while IFS= read -r -d '' existing; do
    name="$(basename -- "${existing}")"
    keep=0
    for allowed in "${ALLOWED_NAMES[@]}"; do
      [ "${name}" = "${allowed}" ] && keep=1 && break
    done
    if [ "${keep}" -eq 0 ]; then
      rm -f -- "${existing}"
    fi
  done < <(find "${KNOWLEDGE_DIR}" -maxdepth 1 -type f -name '*.md' -print0)
fi

# Generate each bundle deterministically.
bundle_index=0
for entry in "${BUNDLES[@]}"; do
  bundle_index=$((bundle_index + 1))
  bundle_name="${entry%%:*}"
  sources="${entry#*:}"
  IFS=',' read -ra SRC_LIST <<< "${sources}"
  out_path="${KNOWLEDGE_DIR}/${bundle_name}"
  tmp_path="${out_path}.tmp"
  src_count="${#SRC_LIST[@]}"

  # Content-Digest: sha256 over the ordered concatenation of each source's
  # raw bytes with every CR (0x0D) removed — nothing else added or removed.
  # `tr -d '\r'` (unlike `sed`) never appends a missing final newline and
  # removes a lone CR identically to the PowerShell implementation.
  digest="$(
    for src in "${SRC_LIST[@]}"; do
      tr -d '\r' < "${REPO_ROOT}/${src}"
    done | sha256_hex
  )"

  {
    printf '<!--\n'
    printf 'Generated from canonical Interview Journey repository sources.\n'
    printf 'Do not edit this file manually.\n'
    printf 'Rebuild it using the ChatGPT Knowledge build script\n'
    printf '(scripts/build-chatgpt-knowledge.sh or .ps1).\n'
    printf '\n'
    printf 'Bundle: %s (%d of %d)\n' "${bundle_name}" "${bundle_index}" "${BUNDLE_COUNT}"
    printf 'Sources (in order):\n'
    for src in "${SRC_LIST[@]}"; do
      printf '  %s\n' "${src}"
    done
    printf 'Content-Digest (sha256, sources concatenated in order, CR bytes removed): %s\n' "${digest}"
    printf '%s\n\n' '-->'
    printf '# %s\n\n' "${bundle_name%.md}"
    idx=0
    for src in "${SRC_LIST[@]}"; do
      idx=$((idx + 1))
      printf '## Source: `%s`\n\n' "${src}"
      # Embed the same CR-stripped bytes that feed the digest — no other rewriting.
      tr -d '\r' < "${REPO_ROOT}/${src}"
      if [ "${idx}" -lt "${src_count}" ]; then
        printf '\n\n---\n\n'
      else
        printf '\n'
      fi
    done
  } > "${tmp_path}"

  mv -- "${tmp_path}" "${out_path}"
done

echo "Generated ChatGPT Knowledge bundles in: ${KNOWLEDGE_DIR}"
echo ""
echo "Generated files:"
for name in "${ALLOWED_NAMES[@]}"; do
  echo "chatgpt/knowledge/${name}"
done
