# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

### Skill routing and bounded research (feature/fresh-research-routing)

- Added Primary Objective Ownership and Negative Trigger Conditions section to `claude/skill-trigger-policy.md`: Interview Journey owns preparation sessions regardless of recruiter/interviewer/company keywords; co-activation resolution rule prevents wrong-skill ownership when multiple Skills match.
- Narrowed `job-hunt` Skill triggers (external repository `/Users/amirbena/Desktop/claude-skills/job-hunt/SKILL.md`): removed overlapping interview-preparation triggers ("prepare me for the interview", "what will they ask", "mock interview") and added explicit deferral rule to Interview Journey Skill when available.
- Created `workflows/research-current-interview-intelligence.md`: bounded 10-step research workflow defining when current research is required, optional, or not required; adapted source hierarchy; claim-type freshness table; scope constraints preventing recruiter discovery or outreach.
- Created `schemas/public-research-evidence.schema.md`: structured evidence handoff contract between the research workflow and Interview Journey's preparation frameworks; defines `research_objective`, `subject_type`, `retrieved_at`, `research_status`, per-finding `reliability`/`freshness`/`evidence_status`/`confidence`; rules preventing research layer from producing preparation implications.
- Added two new evidence classes to `core/evidence-policy.md`: "Public research — unverified" and "Public research — corroborated"; public research rules section; related document links.
- Extended `core/context-priority.md` with priorities 6 (corroborated public research) and 7 (unverified public research), updated priority-5 label to "Verified Role Intelligence", and added public research priority rules (freshness-vs-specificity, contradiction preservation).
- Extended `frameworks/05-interview-intelligence-framework.md`: added public research as seventh source type; added rules II-006 through II-012 covering source provenance, timestamp-based chronology, evidence classification, user-evidence priority over public research, corroboration logic, missing-date confidence reduction, and stale employment claim prohibition.
- Extended `frameworks/01-role-intelligence-framework.md`: updated RI-002 recency rule to clarify freshness is evaluated with specificity; added new section "32b. Source Freshness and Provenance Rules" with rules RI-077 through RI-082 covering retrieval time, publication date, specificity priority, unknown-date evidence, archived sources, and claim-type freshness table.
- Added rules QP-006 through QP-011 to `frameworks/07-question-prediction-framework.md`: public interview reports as weak evidence, no company-wide-to-interviewer inference, role-pattern labeling when evidence is absent, confidence reduction for stale research, profiling prohibition, professional preparation focus.
- Added rules IH-007 through IH-010 to `frameworks/08-interview-hypothesis-framework.md`: pattern-label requirement when evidence is absent, stale research confidence reduction, interviewer profiling prohibition, single-report low-confidence rule; extended validation checklist.
- Created `claude/skill/references/research-and-evidence.md`: condensed Skill reference for research gating, freshness, source reliability, evidence classification, context priority, and evidence handoff.
- Updated `claude/skill/SKILL.md` progressive reference loading table: added three research-backed preparation rows and "Recruiter discovery or outreach → outside scope" row.
- Updated `claude/project-instructions.md` intent-detection section and added dedicated "Public research privacy boundaries" section.
- Updated `claude/project-instructions.compact.md` with "Skill ownership" section and extended non-actions to prohibit claiming explicit Skill-to-Skill invocation.
- Updated `chatgpt/knowledge-manifest.md` bundle 04 source mapping to include `schemas/public-research-evidence.schema.md` and `workflows/research-current-interview-intelligence.md`.
- Updated both Knowledge build scripts (`scripts/build-chatgpt-knowledge.sh`, `.ps1`) to add new sources to bundle 04.
- Extended `tests/validate-repository.sh` from 133 to 180 checks: 12 new sections verifying trigger policy ownership rules, no explicit Skill-to-Skill invocation claims, schema fields, research workflow structure, Framework 05/07/08 rules, Skill reference, evidence policy classes, context priority tiers, packaging isolation, and routing scenario coverage.

### Role Intelligence refinements (feature/build-structure f06bd3a)

- Fixed Framework 01 §32 worked example: renamed heading from "Critical Requirements" to "Top Requirements" and labeled the score-88 item "High" (§17.2 threshold 75–89) rather than implying "Critical" (90–100).
- Split ChatGPT Knowledge bundle 02 (`02-role-resume-stage-and-fit.md`, 1,894 lines, four frameworks) into two focused bundles: `02-role-intelligence.md` (Framework 01 only) and `03-resume-stage-and-fit.md` (Frameworks 02–04). Renumbered bundles 03–09 → 04–10, producing ten total. Updated both build scripts (Bash + PowerShell), both packager scripts (Bash + PowerShell), and all four `chatgpt/` documentation files.
- Added formula-drift validation to `tests/validate-repository.sh`: verifies all seven priority-scoring component names and their weights in both `frameworks/01-role-intelligence-framework.md` and `claude/skill/references/role-and-resume-intelligence.md`; verifies all four threshold boundaries (90, 75, 50, 25) in both files; verifies exactly ten Knowledge bundles exist, the stale bundle name is absent, and bundle-content integrity (02 embeds Framework 01, 03 embeds Framework 02).

### Initial build (feature/build-structure 24a42cd)

- Initialized the Interview Journey repository: project structure, working rules, and high-level scope, reusing the architectural pattern of Career Targeting Intelligence (canonical methodology → platform-independent core → platform adapters) without copying its domain content.
- Added the platform-independent core (`core/`): product definition, terminology, scope and non-goals, workflow (operating modes and interview mode boundaries), orchestration policy (adapting the master orchestrator), evidence policy, accuracy policy, context priority, quality gates, output contracts, and state management.
- Added the fifteen canonical frameworks (`frameworks/01`–`15`) transcribed from the provided reference specifications, each with a canonical-source header and a cross-linked "Related documents" footer. Framework 15 (Interview Journey Intelligence) is the master orchestrator.
- Added thirteen structured record schemas (`schemas/`) for Role Intelligence, Resume Intelligence, Interview Process, Interview Stage, Interview Intelligence, Fit & Gap Analysis, Preparation Strategy, Interview Hypothesis, Question Prediction, Candidate Answer (shared by coding/system-design/behavioral), Mock Interview Session, Interview Debrief, and Interview Journey State.
- Added seventeen workflow adapters (`workflows/`) covering full/focused/resume journey routing and one adapter per framework's callable procedure, each referencing its framework and schema rather than duplicating them.
- Added fourteen canonical output templates (`outputs/`) with required sections and synthetic examples, one per output contract defined in `core/output-contracts.md`.
- Added the installable Claude Skill (`claude/skill/`): `SKILL.md` with progressive reference-loading routing, thirteen grouped reference files, and fourteen clean (non-synthetic) output templates.
- Added the Claude Project Experience: full and compact Project Instructions, Skill trigger policy, state routing, knowledge manifest, artifact policy, conversation starters, project setup guide, Skill manifest, and packaging guide.
- Added the Claude external self-install kit (`claude/external-install/`) with installation checklist, knowledge-files guide, privacy guide, verification guide, conversation starters, and package manifest.
- Added the ChatGPT Custom GPT package (`chatgpt/`): deployment-ready GPT Instructions, Builder configuration, capability policy, conversation starters, knowledge manifest, package manifest, builder setup guide, testing guide, and sharing/publishing guide.
- Added deterministic macOS/Linux (Bash) and Windows (PowerShell) scripts for all four packaging operations: `package-claude-skill`, `package-claude-external-kit`, `build-chatgpt-knowledge`, `package-chatgpt-gpt` — each using an explicit allowlist, a dedicated staging directory, and platform-artifact stripping.
- Added a complete, fully fictional synthetic candidate journey (`examples/synthetic-candidate/`) demonstrating every framework's output end to end.
- Added a repository-native validation script (`tests/validate-repository.sh`) checking required canonical files, framework numbering, Skill package structure, forbidden files, and synthetic-example labeling.
- Added root documentation: `README.md`, `CLAUDE.md`, `ROADMAP.md`, this `CHANGELOG.md`, and `.gitignore`.
