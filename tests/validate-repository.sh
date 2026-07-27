#!/usr/bin/env bash
#
# Repository-native validation for Interview Journey. No external test
# runtime or framework — plain Bash and standard system tools only.
#
# Works when invoked from inside or outside the repository root.

set -uo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd -P)"
REPO_ROOT="$(cd -- "${SCRIPT_DIR}/.." >/dev/null 2>&1 && pwd -P)"
cd "${REPO_ROOT}"

FAILURES=0
PASS_COUNT=0

check() {
  local description="$1"
  local condition="$2"
  if eval "${condition}"; then
    PASS_COUNT=$((PASS_COUNT + 1))
  else
    echo "FAIL: ${description}"
    FAILURES=$((FAILURES + 1))
  fi
}

echo "== Interview Journey repository validation =="

# 1. Required canonical top-level files exist.
for f in README.md CLAUDE.md ROADMAP.md CHANGELOG.md .gitignore; do
  check "root file exists: ${f}" "[ -f '${f}' ]"
done

# 2. Required core files exist.
for f in product-definition.md terminology.md scope-and-non-goals.md workflow.md orchestration-policy.md evidence-policy.md accuracy-policy.md context-priority.md quality-gates.md output-contracts.md state-management.md; do
  check "core/${f} exists" "[ -f 'core/${f}' ]"
done

# 3. Framework numbering is complete and unique (01-15).
for i in $(seq -w 1 15); do
  match_count=$(find frameworks -maxdepth 1 -type f -name "${i}-*.md" | wc -l | tr -d ' ')
  check "frameworks/${i}-*.md exists exactly once" "[ '${match_count}' = '1' ]"
done
total_frameworks=$(find frameworks -maxdepth 1 -type f -name "*.md" | wc -l | tr -d ' ')
check "exactly 15 framework files" "[ '${total_frameworks}' = '15' ]"

# 4. Schemas, workflows, outputs directories are non-empty.
for d in schemas workflows outputs; do
  count=$(find "${d}" -maxdepth 1 -type f -name "*.md" | wc -l | tr -d ' ')
  check "${d}/ contains markdown files" "[ '${count}' -gt 0 ]"
done

# 5. Skill frontmatter is present and valid (has --- delimited YAML with name/description).
SKILL_MD="claude/skill/SKILL.md"
check "SKILL.md exists" "[ -f '${SKILL_MD}' ]"
if [ -f "${SKILL_MD}" ]; then
  first_line=$(head -n1 "${SKILL_MD}")
  check "SKILL.md starts with frontmatter delimiter" "[ '${first_line}' = '---' ]"
  check "SKILL.md frontmatter has name field" "grep -q '^name:' '${SKILL_MD}'"
  check "SKILL.md frontmatter has description field" "grep -q '^description:' '${SKILL_MD}'"
fi

# 6. All 13 reference files and 14 templates referenced by SKILL.md exist.
REFS=(product-and-orchestration role-and-resume-intelligence stage-fit-and-interview-intelligence preparation-strategy question-prediction-and-hypotheses coding-interviews system-design-interviews behavioral-interviews mock-interviews answer-coaching post-interview-debrief state-and-output-generation accuracy-and-quality)
for r in "${REFS[@]}"; do
  check "claude/skill/references/${r}.md exists" "[ -f 'claude/skill/references/${r}.md' ]"
done
TEMPLATES=(role-intelligence resume-intelligence interview-process role-fit-gap-analysis preparation-strategy question-predictions interview-hypotheses coding-preparation system-design-preparation behavioral-story-map mock-interview-scorecard answer-coaching post-interview-debrief interview-journey-state)
for t in "${TEMPLATES[@]}"; do
  check "claude/skill/templates/${t}.md exists" "[ -f 'claude/skill/templates/${t}.md' ]"
done

# 7. No forbidden files / artifacts anywhere in the tracked tree (excluding .git and dist/.build).
check "no .DS_Store files present" "[ -z \"\$(find . -name '.DS_Store' -not -path './.git/*' 2>/dev/null)\" ]"
check "no Thumbs.db files present" "[ -z \"\$(find . -name 'Thumbs.db' -not -path './.git/*' 2>/dev/null)\" ]"
check "no __MACOSX directories present" "[ -z \"\$(find . -type d -name '__MACOSX' -not -path './.git/*' 2>/dev/null)\" ]"
check "no .env or credential files present" "[ -z \"\$(find . -maxdepth 2 -name '.env*' -not -path './.git/*' 2>/dev/null)\" ]"

# 8. Bash scripts are executable; PowerShell mirrors exist.
for base in package-claude-skill package-claude-external-kit build-chatgpt-knowledge package-chatgpt-gpt; do
  check "scripts/${base}.sh is executable" "[ -x 'scripts/${base}.sh' ]"
  check "scripts/${base}.ps1 exists" "[ -f 'scripts/${base}.ps1' ]"
done

# 9. Synthetic example exists and is clearly labeled synthetic.
check "examples/synthetic-candidate/README.md exists" "[ -f 'examples/synthetic-candidate/README.md' ]"
if [ -f "examples/synthetic-candidate/README.md" ]; then
  check "synthetic example README labels itself fictional" "grep -qi 'fictional' 'examples/synthetic-candidate/README.md'"
fi
non_labeled=0
for f in examples/synthetic-candidate/*.md; do
  [ "$(basename "$f")" = "README.md" ] && continue
  grep -qi 'synthetic\|fictional' "$f" || non_labeled=$((non_labeled + 1))
done
check "every synthetic example file is labeled synthetic/fictional" "[ '${non_labeled}' = '0' ]"

# 10. ChatGPT knowledge manifest source mappings resolve.
if [ -f "chatgpt/knowledge-manifest.md" ]; then
  # Extract backtick-quoted paths that look like repo files and check they exist.
  missing=0
  while IFS= read -r path; do
    [ -f "${path}" ] || missing=$((missing + 1))
  done < <(grep -oE '`(core|frameworks|schemas|workflows|outputs)/[a-zA-Z0-9_./-]+\.md`' chatgpt/knowledge-manifest.md | tr -d '`' | sort -u)
  check "all chatgpt/knowledge-manifest.md source paths resolve" "[ '${missing}' = '0' ]"
fi

echo ""
echo "== Summary =="
echo "Passed: ${PASS_COUNT}"
echo "Failed: ${FAILURES}"

if [ "${FAILURES}" -gt 0 ]; then
  exit 1
fi
exit 0
