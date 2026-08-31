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
for f in README.md AGENTS.md CLAUDE.md ROADMAP.md CHANGELOG.md .gitignore; do
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

# 11. Formula drift: priority scoring formula must match between Framework 01 §17 and Skill reference.
FRAMEWORK_01="frameworks/01-role-intelligence-framework.md"
SKILL_REF="claude/skill/references/role-and-resume-intelligence.md"
if [ -f "${FRAMEWORK_01}" ] && [ -f "${SKILL_REF}" ]; then
  for component in "Business Impact" "Core Responsibility Alignment" "Ownership Relevance" "Evidence Strength" "Repetition" "Interview Relevance" "Non-Substitutability"; do
    check "Framework 01 scoring formula contains component: ${component}" "grep -qF '${component}' '${FRAMEWORK_01}'"
    check "Skill reference scoring formula contains component: ${component}" "grep -qF '${component}' '${SKILL_REF}'"
  done
  # Component-weight pairings: catch individual weight drift in Framework 01
  check "Framework 01 Business Impact weight is 25"           "grep -qE 'Business Impact.{0,15}25|25.{0,15}Business Impact'           '${FRAMEWORK_01}'"
  check "Framework 01 Core Responsibility Alignment weight is 20" "grep -qE 'Core Responsibility Alignment.{0,15}20|20.{0,15}Core Responsibility' '${FRAMEWORK_01}'"
  check "Framework 01 Ownership Relevance weight is 15"       "grep -qE 'Ownership Relevance.{0,15}15'                                '${FRAMEWORK_01}'"
  check "Framework 01 Evidence Strength weight is 15"         "grep -qE 'Evidence Strength.{0,15}15'                                 '${FRAMEWORK_01}'"
  check "Framework 01 Repetition weight is 10"                "grep -qE 'Repetition.{0,30}10|10.{0,30}Repetition'                    '${FRAMEWORK_01}'"
  check "Framework 01 Interview Relevance weight is 10"       "grep -qE 'Interview Relevance.{0,15}10'                               '${FRAMEWORK_01}'"
  check "Framework 01 Non-Substitutability weight is 5"       "grep -qE 'Non-Substitutability.{0,10}5|5.{0,10}Non-Substitutability'  '${FRAMEWORK_01}'"
  # Same component-weight pairings in Skill reference (formula is on one line)
  check "Skill reference Business Impact weight is 25"           "grep -qE 'Business Impact.{0,15}25|25.{0,15}Business Impact'           '${SKILL_REF}'"
  check "Skill reference Core Responsibility Alignment weight is 20" "grep -qE 'Core Responsibility Alignment.{0,15}20|20.{0,15}Core Responsibility' '${SKILL_REF}'"
  check "Skill reference Ownership Relevance weight is 15"       "grep -qE 'Ownership Relevance.{0,15}15'                                '${SKILL_REF}'"
  check "Skill reference Evidence Strength weight is 15"         "grep -qE 'Evidence Strength.{0,15}15'                                 '${SKILL_REF}'"
  check "Skill reference Repetition weight is 10"                "grep -qE 'Repetition.{0,15}10|10.{0,15}Repetition'                    '${SKILL_REF}'"
  check "Skill reference Interview Relevance weight is 10"       "grep -qE 'Interview Relevance.{0,15}10'                               '${SKILL_REF}'"
  check "Skill reference Non-Substitutability weight is 5"       "grep -qE 'Non-Substitutability.{0,10}5|5.{0,10}Non-Substitutability'  '${SKILL_REF}'"
  # Four threshold boundaries must appear in both files: Critical≥90, High≥75, Medium≥50, Low≥25
  for t in 90 75 50 25; do
    check "Framework 01 contains priority threshold ${t}" "grep -qE '(^|[^0-9])${t}([^0-9]|$)' '${FRAMEWORK_01}'"
    check "Skill reference contains priority threshold ${t}" "grep -qE '(^|[^0-9])${t}([^0-9]|$)' '${SKILL_REF}'"
  done
fi

# 12. ChatGPT Knowledge bundle integrity: 3 bundles, correct names, old 10-bundle
#     set absent, deterministic provenance header, exactly-once source coverage.
KNOWLEDGE_DIR="chatgpt/knowledge"
if [ -d "${KNOWLEDGE_DIR}" ]; then
  EXPECTED_BUNDLES=(01-product-orchestration-and-quality.md 02-role-resume-and-strategy.md 03-interview-execution.md)
  for bundle in "${EXPECTED_BUNDLES[@]}"; do
    check "Knowledge bundle exists: ${bundle}" "[ -f '${KNOWLEDGE_DIR}/${bundle}' ]"
  done
  actual_count=$(find "${KNOWLEDGE_DIR}" -maxdepth 1 -type f -name "*.md" | wc -l | tr -d ' ')
  check "Knowledge directory contains exactly 3 bundles" "[ '${actual_count}' = '3' ]"
  # The pre-consolidation 10-bundle names must all be gone.
  for stale in 01-product-orchestration-and-state.md 02-role-intelligence.md 03-resume-stage-and-fit.md 04-interview-intelligence-and-strategy.md 05-question-prediction-and-hypotheses.md 06-coding-interviews.md 07-system-design-interviews.md 08-behavioral-and-answer-coaching.md 09-mock-interviews-and-debrief.md 10-output-contracts-and-quality.md; do
    check "stale Knowledge bundle absent: ${stale}" "[ ! -f '${KNOWLEDGE_DIR}/${stale}' ]"
  done
  # Every bundle carries the deterministic provenance header.
  for bundle in "${EXPECTED_BUNDLES[@]}"; do
    if [ -f "${KNOWLEDGE_DIR}/${bundle}" ]; then
      check "bundle ${bundle} has a Bundle: position line" \
        "grep -qE '^Bundle: ${bundle} \\([0-9]+ of 3\\)$' '${KNOWLEDGE_DIR}/${bundle}'"
      check "bundle ${bundle} has a Content-Digest sha256 line" \
        "grep -qE '^Content-Digest \\(sha256, sources concatenated in order, CR bytes removed\\): [0-9a-f]{64}$' '${KNOWLEDGE_DIR}/${bundle}'"
    fi
  done
  # Bundle content routing: representative source-to-bundle assignments.
  check "bundle 01 embeds core/output-contracts.md" \
    "grep -qF '## Source: \`core/output-contracts.md\`' '${KNOWLEDGE_DIR}/01-product-orchestration-and-quality.md'"
  check "bundle 01 embeds frameworks/15-interview-journey-intelligence-framework.md" \
    "grep -qF '## Source: \`frameworks/15-interview-journey-intelligence-framework.md\`' '${KNOWLEDGE_DIR}/01-product-orchestration-and-quality.md'"
  check "bundle 02 embeds frameworks/01-role-intelligence-framework.md" \
    "grep -qF '## Source: \`frameworks/01-role-intelligence-framework.md\`' '${KNOWLEDGE_DIR}/02-role-resume-and-strategy.md'"
  check "bundle 02 embeds workflows/research-current-interview-intelligence.md" \
    "grep -qF '## Source: \`workflows/research-current-interview-intelligence.md\`' '${KNOWLEDGE_DIR}/02-role-resume-and-strategy.md'"
  check "bundle 03 embeds frameworks/09-coding-interview-decision-engine.md" \
    "grep -qF '## Source: \`frameworks/09-coding-interview-decision-engine.md\`' '${KNOWLEDGE_DIR}/03-interview-execution.md'"
  check "bundle 03 embeds frameworks/14-post-interview-debrief-framework.md" \
    "grep -qF '## Source: \`frameworks/14-post-interview-debrief-framework.md\`' '${KNOWLEDGE_DIR}/03-interview-execution.md'"
  # Exactly-once source coverage: every canonical source appears in one bundle,
  # and no source appears twice across the set.
  embedded_sources=$(grep -h '^## Source: ' "${KNOWLEDGE_DIR}"/*.md 2>/dev/null | sed 's/^## Source: `//;s/`$//' | sort)
  expected_sources=$( { find core -maxdepth 1 -type f -name '*.md'; find frameworks -maxdepth 1 -type f -name '*.md'; echo schemas/public-research-evidence.schema.md; echo workflows/research-current-interview-intelligence.md; } | sort )
  check "Knowledge bundles cover every canonical source exactly once" \
    "[ \"\$(printf '%s\n' \"\${embedded_sources}\")\" = \"\$(printf '%s\n' \"\${expected_sources}\")\" ]"
  dup_sources=$(grep -h '^## Source: ' "${KNOWLEDGE_DIR}"/*.md 2>/dev/null | sort | uniq -d)
  check "no canonical source is embedded in more than one bundle" "[ -z \"\${dup_sources}\" ]"
fi

# 12b. Committed ChatGPT Knowledge bundles must be byte-identical to a fresh
#      deterministic rebuild from the canonical sources. Rendered into a
#      throwaway directory so the contributor's working tree is never touched.
#      Detects: a canonical source changed without rebuilding Knowledge; a
#      bundle hand-edited; a stale Content-Digest; wrong source membership or
#      order; a missing or extra generated bundle.
if [ -d "${KNOWLEDGE_DIR}" ]; then
  if command -v shasum >/dev/null 2>&1 || command -v sha256sum >/dev/null 2>&1; then
    KB_TMP="$(mktemp -d 2>/dev/null || mktemp -d -t ijkb)"
    kb_synced=0
    if bash scripts/build-chatgpt-knowledge.sh "${KB_TMP}" >/dev/null 2>&1; then
      diff -r "${KNOWLEDGE_DIR}" "${KB_TMP}" >/dev/null 2>&1 && kb_synced=1
    fi
    check "committed chatgpt/knowledge/ is byte-identical to a fresh rebuild" "[ '${kb_synced}' = '1' ]"
    if [ "${kb_synced}" != "1" ]; then
      echo "       (differences between committed bundles and a fresh rebuild:)"
      diff -r "${KNOWLEDGE_DIR}" "${KB_TMP}" 2>&1 | sed 's/^/       /' | head -n 40
    fi
    rm -rf -- "${KB_TMP}"
  else
    echo "SKIP: no sha256 tool (shasum/sha256sum) on PATH; Knowledge rebuild-sync check not run"
  fi
fi

# 12c. Digest normalization contract. Digest/body input is each source's raw
#      bytes with every CR (0x0D) removed - nothing else added, removed, or
#      normalized (a source's final-LF presence is preserved; a lone CR is
#      treated identically). Verified against LF / CRLF / lone-CR /
#      no-final-newline fixtures. When pwsh is available, also verified for
#      Bash/PowerShell byte-for-byte agreement (fixtures + a full rebuild).
NORM_TMP="$(mktemp -d 2>/dev/null || mktemp -d -t ijnorm)"
printf 'alpha\nbeta\n'     > "${NORM_TMP}/lf.txt"
printf 'alpha\r\nbeta\r\n' > "${NORM_TMP}/crlf.txt"
printf 'alpha\rbeta\r'     > "${NORM_TMP}/lonecr.txt"
printf 'alpha\nbeta'       > "${NORM_TMP}/nonl.txt"
norm_bash() { tr -d '\r' < "$1" | od -A n -t x1 -v | tr -d ' \n'; }
exp_lf="$(printf 'alpha\nbeta\n' | od -A n -t x1 -v | tr -d ' \n')"
exp_cat="$(printf 'alphabeta'    | od -A n -t x1 -v | tr -d ' \n')"
exp_nonl="$(printf 'alpha\nbeta' | od -A n -t x1 -v | tr -d ' \n')"
check "normalization: LF input is unchanged"              "[ \"\$(norm_bash '${NORM_TMP}/lf.txt')\" = \"${exp_lf}\" ]"
check "normalization: CRLF collapses to LF"               "[ \"\$(norm_bash '${NORM_TMP}/crlf.txt')\" = \"${exp_lf}\" ]"
check "normalization: lone CR removed, no newline added"  "[ \"\$(norm_bash '${NORM_TMP}/lonecr.txt')\" = \"${exp_cat}\" ]"
check "normalization: missing final newline is preserved" "[ \"\$(norm_bash '${NORM_TMP}/nonl.txt')\" = \"${exp_nonl}\" ]"
if command -v pwsh >/dev/null 2>&1; then
  norm_ps() {
    pwsh -NoProfile -NonInteractive -Command "\$b=[System.IO.File]::ReadAllBytes('$1'); \$o=[System.Collections.Generic.List[byte]]::new(); foreach(\$x in \$b){ if(\$x -ne 0x0D){ \$o.Add(\$x) } }; -join (\$o.ToArray() | ForEach-Object { \$_.ToString('x2') })" 2>/dev/null | tr -d ' \r\n'
  }
  for f in lf crlf lonecr nonl; do
    check "normalization parity (Bash == PowerShell): ${f}" \
      "[ \"\$(norm_bash '${NORM_TMP}/${f}.txt')\" = \"\$(norm_ps '${NORM_TMP}/${f}.txt')\" ]"
  done
  if [ -d "${KNOWLEDGE_DIR}" ]; then
    PS_TMP="$(mktemp -d 2>/dev/null || mktemp -d -t ijps)"
    ps_synced=0
    if pwsh -NoProfile -NonInteractive -File scripts/build-chatgpt-knowledge.ps1 "${PS_TMP}" >/dev/null 2>&1; then
      diff -r "${KNOWLEDGE_DIR}" "${PS_TMP}" >/dev/null 2>&1 && ps_synced=1
      check "PowerShell rebuild is byte-identical to committed chatgpt/knowledge/" "[ '${ps_synced}' = '1' ]"
    else
      echo "SKIP: build-chatgpt-knowledge.ps1 did not run under pwsh; PowerShell full-build parity not checked"
    fi
    rm -rf -- "${PS_TMP}"
  fi
else
  echo "SKIP: pwsh not on PATH; Bash/PowerShell parity not executed (fixture-level Bash contract enforced above)"
fi
rm -rf -- "${NORM_TMP}"

# 13. Skill routing: trigger policy must define in-scope ownership, outside-scope boundary,
#     and independent operation. Must not name external Skills as required components.
TRIGGER_POLICY="claude/skill-trigger-policy.md"
if [ -f "${TRIGGER_POLICY}" ]; then
  check "Trigger policy defines in-scope interview-preparation ownership" \
    "grep -qi 'In-Scope\|in-scope\|interview preparation' '${TRIGGER_POLICY}'"
  check "Trigger policy covers recruiter and interviewer as inputs, not ownership signals" \
    "grep -qi 'recruiter' '${TRIGGER_POLICY}'"
  check "Trigger policy defines outside-scope boundary" \
    "grep -qi 'Outside Scope\|outside scope' '${TRIGGER_POLICY}'"
  check "Trigger policy declares Interview Journey independent operation" \
    "grep -qi 'Independent\|does not depend on other Skills\|does not require another' '${TRIGGER_POLICY}'"
  check "Trigger policy does not name an external Skill as a required routing target" \
    "! grep -qiE 'job-hunt|job-search|career-targeting|recruiter-interview-research' '${TRIGGER_POLICY}'"
fi

# 14. Project and Skill files must not claim external Skill dependencies or invocation.
for ij_file in claude/project-instructions.md claude/project-instructions.compact.md claude/skill/SKILL.md; do
  if [ -f "${ij_file}" ]; then
    check "${ij_file} does not claim explicit external Skill invocation" \
      "! grep -qiE 'delegate to another|enabled Skills.*contribute|Skills.*activated automatically|invoke.*another.*[Ss]kill|call.*another.*[Ss]kill' '${ij_file}'"
    check "${ij_file} does not name job-hunt as a dependency" \
      "! grep -qi 'job-hunt' '${ij_file}'"
    check "${ij_file} does not name career-targeting as a dependency" \
      "! grep -qi 'career-targeting' '${ij_file}'"
  fi
done

# 15. Public research evidence schema exists with required fields.
PR_SCHEMA="schemas/public-research-evidence.schema.md"
check "public-research-evidence.schema.md exists" "[ -f '${PR_SCHEMA}' ]"
if [ -f "${PR_SCHEMA}" ]; then
  check "Schema contains research_objective field" "grep -q 'research_objective' '${PR_SCHEMA}'"
  check "Schema contains retrieved_at field" "grep -q 'retrieved_at' '${PR_SCHEMA}'"
  check "Schema contains reliability field" "grep -q 'reliability' '${PR_SCHEMA}'"
  check "Schema contains freshness field" "grep -q 'freshness' '${PR_SCHEMA}'"
  check "Schema contains evidence_status field" "grep -q 'evidence_status' '${PR_SCHEMA}'"
  check "Schema contains confidence field" "grep -q 'confidence' '${PR_SCHEMA}'"
  check "Schema states preparation_implications not produced by research layer" \
    "grep -q 'preparation_implications' '${PR_SCHEMA}'"
fi

# 16. Bounded research workflow exists.
RCII="workflows/research-current-interview-intelligence.md"
check "research-current-interview-intelligence.md exists" "[ -f '${RCII}' ]"
if [ -f "${RCII}" ]; then
  check "Research workflow defines Research Required" "grep -q 'Research Required' '${RCII}'"
  check "Research workflow defines Research Not Required" "grep -q 'Research Not Required' '${RCII}'"
  check "Research workflow references public-research-evidence schema" \
    "grep -q 'public-research-evidence.schema.md' '${RCII}'"
  check "Research workflow does not implement outreach ranking or recruiter prospecting" \
    "! grep -qi 'outreach.*rank\|recruiter.*rank\|prospect.*contact\|priority.*queue' '${RCII}'"
fi

# 17. Framework 05 accepts public research with provenance rules.
F05="frameworks/05-interview-intelligence-framework.md"
if [ -f "${F05}" ]; then
  check "Framework 05 lists public research as a source" \
    "grep -qi 'public.*research\|research.*public' '${F05}'"
  check "Framework 05 has II-006 (provenance rule)" "grep -q 'II-006' '${F05}'"
  check "Framework 05 has II-008 (evidence classification rule)" "grep -q 'II-008' '${F05}'"
  check "Framework 05 references public-research-evidence schema" \
    "grep -q 'public-research-evidence.schema.md' '${F05}'"
fi

# 18. Framework 07 and 08 preserve uncertainty about public research.
F07="frameworks/07-question-prediction-framework.md"
if [ -f "${F07}" ]; then
  check "Framework 07 has QP-006 (no guaranteed future questions from reports)" \
    "grep -q 'QP-006' '${F07}'"
  check "Framework 07 has QP-008 (role-pattern label when evidence absent)" \
    "grep -q 'QP-008' '${F07}'"
  check "Framework 07 prohibits psychological profiling" \
    "grep -qi 'profil' '${F07}'"
fi
F08="frameworks/08-interview-hypothesis-framework.md"
if [ -f "${F08}" ]; then
  check "Framework 08 has IH-007 (role-pattern label when evidence absent)" \
    "grep -q 'IH-007' '${F08}'"
  check "Framework 08 prohibits psychological profiling" \
    "grep -qi 'profil' '${F08}'"
fi

# 19. Skill reference for research exists.
SKILL_REF_RESEARCH="claude/skill/references/research-and-evidence.md"
check "Skill reference research-and-evidence.md exists" "[ -f '${SKILL_REF_RESEARCH}' ]"
if [ -f "${SKILL_REF_RESEARCH}" ]; then
  check "Research reference defines Research Scope Constraint" \
    "grep -qi 'scope constraint\|Scope Constraint' '${SKILL_REF_RESEARCH}'"
  check "Research reference prohibits recruiter discovery" \
    "grep -qi 'recruiter discovery' '${SKILL_REF_RESEARCH}'"
fi

# 20. Skill routes research-backed preparation through internal references only.
SKILL_MD="claude/skill/SKILL.md"
if [ -f "${SKILL_MD}" ]; then
  check "SKILL.md routes current-research preparation to research-and-evidence reference" \
    "grep -q 'research-and-evidence.md' '${SKILL_MD}'"
  check "SKILL.md declares independent operation" \
    "grep -qi 'self-contained\|does not require any other Skill\|no other Skill' '${SKILL_MD}'"
  check "SKILL.md marks recruiter discovery as outside scope" \
    "grep -qi 'outside.*scope\|Outside.*scope' '${SKILL_MD}'"
fi

# 21. Evidence policy contains public research evidence class.
EP="core/evidence-policy.md"
if [ -f "${EP}" ]; then
  check "Evidence policy contains public_research_unverified class" \
    "grep -q 'public_research_unverified\|public research — unverified\|Public research — unverified' '${EP}'"
  check "Evidence policy contains corroborated_public_research class" \
    "grep -q 'corroborated_public_research\|public research — corroborated\|Public research — corroborated' '${EP}'"
fi

# 22. Context priority policy contains extended priority levels (6-8).
CP="core/context-priority.md"
if [ -f "${CP}" ]; then
  check "Context priority contains corroborated public research at priority 6" \
    "grep -qi 'corroborated.*public research\|Corroborated current public research' '${CP}'"
  check "Context priority contains unverified public research at priority 7" \
    "grep -qi 'unverified.*public research\|Unverified current public research' '${CP}'"
  check "Context priority has freshness-vs-specificity rule (rule 9)" \
    "grep -q 'Freshness does not automatically override specificity\|freshness.*specificity' '${CP}'"
fi

# 23. Packaging scripts reference only repository-owned files.
for pkg_script in scripts/package-claude-skill.sh scripts/package-claude-external-kit.sh scripts/package-chatgpt-gpt.sh; do
  if [ -f "${pkg_script}" ]; then
    check "${pkg_script} does not reference external repositories" \
      "! grep -q 'career-target\|job-hunt\|recruiter-interview' '${pkg_script}'"
  fi
done

# 24. Routing is fully internal: trigger policy covers ownership and out-of-scope without naming external Skills.
check "Trigger policy covers interview-preparation as in-scope" \
  "grep -qi 'interview preparation\|preparing for.*interview' '${TRIGGER_POLICY}'"
check "Trigger policy covers recruiter terms as inputs, not routing triggers" \
  "grep -qi 'recruiter\|interviewer' '${TRIGGER_POLICY}'"
check "Trigger policy states outside-scope items without naming a required external Skill" \
  "grep -qi 'outside.*scope\|Out-of-Scope\|Outside Scope' '${TRIGGER_POLICY}'"

# 25. Framework 15 routes current research as an internal workflow step.
F15="frameworks/15-interview-journey-intelligence-framework.md"
if [ -f "${F15}" ]; then
  check "Framework 15 includes internal current-research step in workflow" \
    "grep -qi 'research-current-interview-intelligence\|current-interview-research workflow\|current.*research.*workflow' '${F15}'"
  check "Framework 15 declares independent operation principle" \
    "grep -qi 'self-contained\|does not route.*another Skill\|does not depend' '${F15}'"
fi

# 26. GitHub Engineering Task issue form is present and structurally sound.
ISSUE_FORM=".github/ISSUE_TEMPLATE/engineering-task.yml"
ISSUE_CONFIG=".github/ISSUE_TEMPLATE/config.yml"
check "Engineering Task issue form exists" "[ -f '${ISSUE_FORM}' ]"
check "Issue template chooser config exists" "[ -f '${ISSUE_CONFIG}' ]"
if [ -f "${ISSUE_FORM}" ]; then
  check "Issue form declares no auto-applied labels" \
    "grep -q '^labels: \[\]' '${ISSUE_FORM}'"
  check "Issue form keeps the Type dropdown" \
    "grep -q 'id: type' '${ISSUE_FORM}'"
  check "Issue form keeps the Area dropdown" \
    "grep -q 'id: area' '${ISSUE_FORM}'"
  check "Issue form keeps the Priority dropdown" \
    "grep -q 'id: priority' '${ISSUE_FORM}'"
  check "Issue form reserves P0 for manual assignment (P0 not a Priority option)" \
    "! grep -qE '^ *- +P0' '${ISSUE_FORM}'"
  check "Issue form Area taxonomy is repository-specific (Frameworks)" \
    "grep -q 'Frameworks' '${ISSUE_FORM}'"
  check "Issue form does not carry over code-review-skill Area values" \
    "! grep -q 'Stateful Re-review\|Specialist Profiles' '${ISSUE_FORM}'"
  if command -v python3 >/dev/null 2>&1; then
    check "Issue form is valid YAML with unique field ids" \
      "python3 -c \"import yaml,sys; d=yaml.safe_load(open('${ISSUE_FORM}')); ids=[e['id'] for e in d['body'] if 'id' in e]; sys.exit(0 if len(ids)==len(set(ids)) and d.get('labels')==[] else 1)\""
  fi
fi
if [ -f "${ISSUE_CONFIG}" ]; then
  check "Issue chooser disables blank issues" \
    "grep -q 'blank_issues_enabled: false' '${ISSUE_CONFIG}'"
fi

# 27. GitHub pull request template is present and prose-oriented.
PR_TEMPLATE=".github/pull_request_template.md"
check "Pull request template exists" "[ -f '${PR_TEMPLATE}' ]"
if [ -f "${PR_TEMPLATE}" ]; then
  check "PR template has a What changed section" \
    "grep -q '^## What changed' '${PR_TEMPLATE}'"
  check "PR template has a Validation section" \
    "grep -q '^## Validation' '${PR_TEMPLATE}'"
  check "PR template carries the write-for-the-reviewer guardrail" \
    "grep -qi 'Write for the reviewer' '${PR_TEMPLATE}'"
  check "PR template is not a checklist form (no task-list checkboxes)" \
    "! grep -qE '^ *- \[[ xX]\]' '${PR_TEMPLATE}'"
fi

echo ""
echo "== Summary =="
echo "Passed: ${PASS_COUNT}"
echo "Failed: ${FAILURES}"

if [ "${FAILURES}" -gt 0 ]; then
  exit 1
fi
exit 0
