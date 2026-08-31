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
SURFACES=(chatgpt/instructions.md claude/skill/SKILL.md claude/project-instructions.md claude/project-instructions.compact.md)

check "canonical contract exists" "[ -f '${CANONICAL}' ]"
for term in "Target range" "Preferred outcome" "Fallback" "retrieval date" "total compensation" "salary expectations" "current compensation" "competing offers" "desired increase" "range is justified" "lower range" "Very little data" "Different populations" "Material contradiction" "Stale evidence" "conversational"; do
  check "canonical contract covers: ${term}" "grep -qiF '${term}' '${CANONICAL}'"
done

for surface in "${SURFACES[@]}"; do
  check "${surface} recognizes offer/negotiation preparation" "grep -qiE 'offer.*negotiat|negotiat.*offer' '${surface}'"
  check "${surface} routes to canonical capability/reference" "grep -q 'offer-negotiation-preparation.md\|offer-and-negotiation-preparation.md' '${surface}'"
done

check "Skill reference preserves evidence attribution" "grep -qi 'figure/range.*population/context.*source.*retrieval date' claude/skill/references/offer-and-negotiation-preparation.md"
check "Skill reference preserves sparse/contradictory behavior" "grep -qi 'Sparse, stale.*contradictory' claude/skill/references/offer-and-negotiation-preparation.md"
check "Skill reference requires natural spoken answers" "grep -qi 'natural spoken answers' claude/skill/references/offer-and-negotiation-preparation.md"
check "scenario fixture is explicitly synthetic" "grep -qi 'fictional test inputs' tests/fixtures/offer-negotiation-scenarios.md"
for scenario in "Good coverage" "Sparse role/location" "Contradictory sources" "Employer range below target" "Total compensation changes result" "Missing optional information"; do
  check "scenario covered: ${scenario}" "grep -qF '${scenario}' tests/fixtures/offer-negotiation-scenarios.md"
done

if [ "${FAILURES}" -gt 0 ]; then
  echo "Offer/negotiation validation failed: ${FAILURES} check(s)."
  exit 1
fi

echo "Offer/negotiation validation passed."
