# Changelog

All notable changes to this project will be documented in this file.

## Unreleased

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
