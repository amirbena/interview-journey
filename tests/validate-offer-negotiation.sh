#!/usr/bin/env bash

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"
cd "${REPO_ROOT}"

FAILURES=0
check() {
  local description="$1"
  local condition="$2"
  if eval "${condition}"; then
    echo "PASS: ${description}"
  else
    echo "FAIL: ${description}"
    FAILURES=$((FAILURES + 1))
  fi
}

CANONICAL="core/offer-negotiation-preparation.md"
SCENARIOS="tests/fixtures/offer-negotiation-scenarios.md"

canonical_ids=$(grep -oE '^\| `ONP-[0-9]{3}`' "${CANONICAL}" | grep -oE 'ONP-[0-9]{3}' | sort)
expected_ids=$(printf 'ONP-%03d\n' $(seq 1 10))
check "canonical contract owns ONP-001 through ONP-010 exactly once" \
  "[ \"${canonical_ids}\" = \"${expected_ids}\" ]"

SCENARIO_MAP=(
  "SCN-STRONG:ONP-002,ONP-005"
  "SCN-SPARSE:ONP-003,ONP-007"
  "SCN-CONTRADICTORY:ONP-002,ONP-004"
  "SCN-BELOW-TARGET:ONP-005,ONP-008,ONP-009"
  "SCN-TOTAL-COMP:ONP-005,ONP-006"
  "SCN-OPTIONAL:ONP-001,ONP-007,ONP-010"
)
check "scenario fixture is explicitly synthetic" "grep -qi 'fictional test inputs' '${SCENARIOS}'"
for spec in "${SCENARIO_MAP[@]}"; do
  scenario="${spec%%:*}"
  expected="${spec#*:}"
  block=$(awk -v heading="## ${scenario} " '
    index($0, heading) == 1 { capture=1 }
    capture && /^## / && index($0, heading) != 1 { exit }
    capture { print }
  ' "${SCENARIOS}")
  actual=$(printf '%s\n' "${block}" | grep -oE 'ONP-[0-9]{3}' | paste -sd ',' -)
  check "${scenario} maps to its required canonical invariants" "[ '${actual}' = '${expected}' ]"
  IFS=',' read -ra mapped_ids <<< "${expected}"
  for invariant in "${mapped_ids[@]}"; do
    check "${scenario} resolves ${invariant} to a canonical rule" \
      "grep -qF '| \`${invariant}\` |' '${CANONICAL}'"
  done
done

STATE_SCHEMA="schemas/interview-journey-state.schema.md"
STATE_POLICY="core/state-management.md"
for field in offer_negotiation_preparation_status offer_negotiation_preparation artifact_reference source_context_reference employer_compensation_range candidate_compensation_priorities target_range preferred_outcome fallback total_compensation_context market_evidence_retrieved_at market_evidence_freshness invalidation_inputs last_updated_at; do
  check "state schema represents ${field}" "grep -qF '${field}' '${STATE_SCHEMA}'"
done
for lifecycle in "No preparation" "In progress" "Reusable" "Material change" "Evidence aging"; do
  check "state policy defines lifecycle: ${lifecycle}" "grep -qF '**${lifecycle}:**' '${STATE_POLICY}'"
done
check "valid negotiation state is explicitly reused/skipped" \
  "grep -qF 'Reuse it and skip rebuilding' '${STATE_POLICY}'"
check "material changes stale only negotiation preparation" \
  "grep -qE 'changes only .*offer_negotiation_preparation_status.*Stale' '${STATE_SCHEMA}'"
check "Skill state adapter consumes canonical schema" \
  "grep -qF 'schemas/interview-journey-state.schema.md' claude/skill/references/state-and-output-generation.md"
check "Skill state template uses canonical negotiation object" \
  "grep -qF 'offer_negotiation_preparation_status:' claude/skill/templates/interview-journey-state.md"

check "ChatGPT depends on canonical ONP invariant set" \
  "grep -qE 'Canonical negotiation dependency.*ONP-001.*ONP-010' chatgpt/instructions.md"
check "Claude Skill reference depends on canonical ONP invariant set" \
  "grep -qE 'Canonical dependency.*ONP-001.*ONP-010' claude/skill/references/offer-and-negotiation-preparation.md"
for project in claude/project-instructions.md claude/project-instructions.compact.md; do
  check "${project} depends on canonical ONP invariant set" \
    "grep -qE 'ONP-001.*ONP-010' '${project}'"
  check "${project} preserves freshness, contradiction, and state lifecycle dependency" \
    "tr '\n' ' ' < '${project}' | grep -qiE 'freshness.*contradiction.*reuse/invalidation'"
done

package_ok=1
bash scripts/package-claude-skill.sh >/dev/null 2>&1 || package_ok=0
bash scripts/package-claude-external-kit.sh >/dev/null 2>&1 || package_ok=0
bash scripts/package-chatgpt-gpt.sh >/dev/null 2>&1 || package_ok=0
check "all three package artifacts build" "[ '${package_ok}' = '1' ]"

if [ "${package_ok}" = "1" ]; then
  skill_expected=$(cd claude/skill && find . -type f -name '*.md' | sed 's#^./#interview-journey/#' | sort)
  skill_actual=$(unzip -Z1 dist/interview-journey.skill.zip | grep -v '/$' | sort)
  check "Skill ZIP normalized file set matches authoritative Skill source set" \
    "[ \"${skill_actual}\" = \"${skill_expected}\" ]"
  check "Skill ZIP contains negotiation reference" \
    "printf '%s\n' \"${skill_actual}\" | grep -qx 'interview-journey/references/offer-and-negotiation-preparation.md'"
  check "Skill ZIP contains negotiation template" \
    "printf '%s\n' \"${skill_actual}\" | grep -qx 'interview-journey/templates/offer-negotiation-preparation.md'"

  check "external-kit ZIP contains canonical negotiation Knowledge" \
    "unzip -Z1 dist/interview-journey-claude-kit.zip | grep -qx 'interview-journey-claude-kit/knowledge/offer-negotiation-preparation.md'"
  kit_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t ijofferkit)
  unzip -q dist/interview-journey-claude-kit.zip -d "${kit_tmp}"
  check "external-kit negotiation Knowledge matches canonical source" \
    "cmp '${CANONICAL}' '${kit_tmp}/interview-journey-claude-kit/knowledge/offer-negotiation-preparation.md'"
  rm -rf -- "${kit_tmp}"

  chatgpt_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t ijoffergpt)
  unzip -q dist/interview-journey-chatgpt.zip -d "${chatgpt_tmp}"
  chatgpt_knowledge_file="${chatgpt_tmp}/interview-journey-chatgpt/knowledge/01-product-orchestration-and-quality.md"
  check "ChatGPT package Knowledge embeds canonical negotiation source" \
    "grep -qF 'core/offer-negotiation-preparation.md' '${chatgpt_knowledge_file}'"
  check "ChatGPT package Knowledge carries complete invariant boundary" \
    "grep -qF 'ONP-001' '${chatgpt_knowledge_file}' && grep -qF 'ONP-010' '${chatgpt_knowledge_file}'"
  rm -rf -- "${chatgpt_tmp}"
fi

check "Bash external-kit allowlist contains canonical negotiation Knowledge" \
  "grep -qF 'offer-negotiation-preparation.md:offer-negotiation-preparation.md' scripts/package-claude-external-kit.sh"
check "PowerShell external-kit allowlist contains canonical negotiation Knowledge" \
  "grep -qF 'Src = \"offer-negotiation-preparation.md\"; Dest = \"offer-negotiation-preparation.md\"' scripts/package-claude-external-kit.ps1"

reference_count=$(find claude/skill/references -maxdepth 1 -type f -name '*.md' | wc -l | tr -d ' ')
check "Skill source contains 15 references" "[ '${reference_count}' = '15' ]"
check "Skill manifest documents research-and-evidence.md" \
  "grep -qF 'research-and-evidence.md' claude/skill-manifest.md"
check "Skill manifest declares 15 reference files" \
  "grep -qF '... (15 files)' claude/skill-manifest.md"

if [ "${FAILURES}" -gt 0 ]; then
  echo "Offer/negotiation validation failed: ${FAILURES} check(s)."
  exit 1
fi

echo "Offer/negotiation validation passed."
