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

chatgpt_offer_route_ok() {
  local file="$1"
  grep -qF 'Recognize offer and negotiation intent' "${file}" &&
    grep -qF 'Route it to Knowledge source `core/offer-negotiation-preparation.md`' "${file}"
}

skill_offer_route_ok() {
  local file="$1"
  grep -qF '| Offer or compensation-negotiation preparation | [`offer-and-negotiation-preparation.md`](references/offer-and-negotiation-preparation.md)' "${file}"
}

project_full_offer_route_ok() {
  local file="$1"
  grep -qF "Preparing for an offer call, compensation discussion, employer range, offer evaluation, or negotiation through the Skill's" "${file}" &&
    grep -qF '[`offer-and-negotiation-preparation.md`](skill/references/offer-and-negotiation-preparation.md) adaptation of the canonical contract' "${file}"
}

project_compact_offer_route_ok() {
  local file="$1"
  local flattened
  flattened=$(tr '\n' ' ' < "${file}")
  grep -qF "Route offer calls, compensation expectations, employer ranges, offer evaluation, and negotiation through the Skill's offer-and-negotiation-preparation.md reference and canonical contract" <<< "${flattened}"
}

project_negotiation_dependencies_ok() {
  local file="$1"
  local flattened
  flattened=$(tr '\n' ' ' < "${file}")
  grep -qiE 'freshness.*contradiction.*reuse/invalidation' <<< "${flattened}"
}

extract_bundle_source() {
  local source="$1"
  local bundle="$2"
  local destination="$3"
  awk -v header="## Source: \`${source}\`" '
    $0 == header { capture=1; next }
    capture && $0 == "---" {
      while (count > 0 && lines[count] == "") count--
      start = (count > 0 && lines[1] == "") ? 2 : 1
      for (i = start; i <= count; i++) print lines[i]
      exit
    }
    capture { lines[++count]=$0 }
  ' "${bundle}" > "${destination}"
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
check "ChatGPT routes offer intent to canonical negotiation Knowledge" \
  "chatgpt_offer_route_ok chatgpt/instructions.md"
check "Claude Skill reference depends on canonical ONP invariant set" \
  "grep -qE 'Canonical dependency.*ONP-001.*ONP-010' claude/skill/references/offer-and-negotiation-preparation.md"
check "Claude Skill routes offer intent to its negotiation reference" \
  "skill_offer_route_ok claude/skill/SKILL.md"
for project in claude/project-instructions.md claude/project-instructions.compact.md; do
  check "${project} depends on canonical ONP invariant set" \
    "grep -qE 'ONP-001.*ONP-010' '${project}'"
  check "${project} preserves freshness, contradiction, and state lifecycle dependency" \
    "project_negotiation_dependencies_ok '${project}'"
done
check "Claude Project full instructions route offer intent through the Skill reference" \
  "project_full_offer_route_ok claude/project-instructions.md"
check "Claude Project compact instructions route offer intent through the Skill reference" \
  "project_compact_offer_route_ok claude/project-instructions.compact.md"

routing_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t ijofferrouting)
sed 's/Recognize offer and negotiation intent/Recognize general career intent/' chatgpt/instructions.md > "${routing_tmp}/chatgpt.md"
sed 's/Offer or compensation-negotiation preparation/General career preparation/' claude/skill/SKILL.md > "${routing_tmp}/skill.md"
sed 's/Preparing for an offer call/Documenting an offer call/' claude/project-instructions.md > "${routing_tmp}/project-full.md"
sed 's/Route offer calls/Describe offer calls/' claude/project-instructions.compact.md > "${routing_tmp}/project-compact.md"
check "ChatGPT routing assertion rejects a missing offer-intent trigger" \
  "! chatgpt_offer_route_ok '${routing_tmp}/chatgpt.md'"
check "Claude Skill routing assertion rejects a missing offer-intent route" \
  "! skill_offer_route_ok '${routing_tmp}/skill.md'"
check "Claude Project full routing assertion rejects a missing offer-intent route" \
  "! project_full_offer_route_ok '${routing_tmp}/project-full.md'"
check "Claude Project compact routing assertion rejects a missing offer-intent route" \
  "! project_compact_offer_route_ok '${routing_tmp}/project-compact.md'"
rm -rf -- "${routing_tmp}"

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
    "grep -qx 'interview-journey/references/offer-and-negotiation-preparation.md' <<< \"${skill_actual}\""
  check "Skill ZIP contains negotiation template" \
    "grep -qx 'interview-journey/templates/offer-negotiation-preparation.md' <<< \"${skill_actual}\""

  kit_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t ijofferkit)
  unzip -Z1 dist/interview-journey-claude-kit.zip > "${kit_tmp}/archive-listing.txt"
  check "external-kit ZIP contains canonical negotiation Knowledge" \
    "grep -qx 'interview-journey-claude-kit/knowledge/offer-negotiation-preparation.md' '${kit_tmp}/archive-listing.txt'"
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
  check "ChatGPT package Knowledge embeds the canonical journey-state schema" \
    "grep -qF 'schemas/interview-journey-state.schema.md' '${chatgpt_knowledge_file}'"
  packaged_state_schema="${chatgpt_tmp}/packaged-state-schema.md"
  extract_bundle_source "${STATE_SCHEMA}" "${chatgpt_knowledge_file}" "${packaged_state_schema}"
  check "ChatGPT packaged journey-state schema matches the canonical source" \
    "cmp '${STATE_SCHEMA}' '${packaged_state_schema}'"
  packaged_state_schema_count=$(grep -h '^## Source: ' "${chatgpt_tmp}"/interview-journey-chatgpt/knowledge/*.md | grep -cF "${STATE_SCHEMA}")
  check "ChatGPT package maps the journey-state schema exactly once" \
    "[ '${packaged_state_schema_count}' = '1' ]"
  for field in offer_negotiation_preparation_status artifact_reference source_context_reference target_range preferred_outcome fallback market_evidence_freshness invalidation_inputs; do
    check "ChatGPT packaged state schema carries ${field}" \
      "grep -qF '${field}' '${chatgpt_knowledge_file}'"
  done
  rm -rf -- "${chatgpt_tmp}"
fi

check "Bash Knowledge mapping includes the canonical journey-state schema" \
  "grep -qF 'core/state-management.md,schemas/interview-journey-state.schema.md,frameworks/15-interview-journey-intelligence-framework.md' scripts/build-chatgpt-knowledge.sh"
check "PowerShell Knowledge mapping includes the canonical journey-state schema" \
  "grep -qF 'core/state-management.md\",\"schemas/interview-journey-state.schema.md\",\"frameworks/15-interview-journey-intelligence-framework.md' scripts/build-chatgpt-knowledge.ps1"

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
