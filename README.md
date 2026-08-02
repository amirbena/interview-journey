# Interview Journey

Interview Journey is an evidence-driven interview preparation system. It prepares candidates for technical hiring processes using every piece of available interview information — the target role, the candidate's real resume evidence, the current interview stage, company and team context, previous recruiter conversations, previous interview questions, previous feedback, technical assessments, interviewer information, candidate observations, and lessons from earlier stages.

## Problem

Generic interview prep ("here are 50 common questions") ignores what actually matters for a specific candidate in a specific hiring process at a specific stage. There is no lightweight, repeatable method for turning a target role, a real resume, and scattered interview signals into a focused plan for the very next interview.

## Intended users

Individual candidates preparing for technical interviews — engineers at any seniority — who want a structured, on-demand preparation assistant that adapts to their real background and their actual hiring process, rather than a generic study guide.

## Planned product surfaces

- **Claude Skill** — an installable Skill adapting the shared methodology for execution inside Claude.
- **Claude Project** — a guided conversational interface over the Skill and shared Knowledge.
- **ChatGPT Custom GPT** — a conversational interface to the same methodology, built for the ChatGPT ecosystem.

All three surfaces are thin, platform-specific wrappers. The methodology itself lives once, in `frameworks/` and `core/`.

## Core architectural principle

```text
Shared methodology (frameworks/, core/, schemas/, workflows/, outputs/)
        ↓
Platform-independent core
        ↓
Claude Skill / Claude Project / ChatGPT GPT
```

`core/` and `frameworks/` are the canonical source of product behavior. Platform folders (`claude/`, `chatgpt/`) only adapt that shared definition to a specific product surface; they must never redefine or duplicate business rules. This repository reuses the architectural pattern of Career Targeting Intelligence — canonical methodology, platform adapters, explicit packaging allowlists, deterministic cross-platform scripts — while its actual content is built around technical interview preparation, not career/company targeting.

## Repository structure

```text
interview-journey/
├── core/            platform-independent product definition, policy, and workflow
├── frameworks/       01–15, the canonical methodology (15 is the master orchestrator)
├── schemas/          structured records for every framework's output
├── workflows/        orchestration and task-specific flow adapters
├── outputs/          canonical output contract templates
├── claude/           Claude Skill, Claude Project, and external-install packaging
├── chatgpt/          ChatGPT Custom GPT instructions, Knowledge, and packaging
├── scripts/          deterministic packaging/build scripts (Bash + PowerShell)
├── examples/         a fully synthetic worked example
├── tests/            repository validation
└── dist/             generated packages (git-ignored)
```

## Framework model

Fifteen frameworks define the methodology, each with a single responsibility:

| # | Framework | Responsibility |
|---|---|---|
| 01 | [Role Intelligence](frameworks/01-role-intelligence-framework.md) | Structured hiring-intent analysis of a target role |
| 02 | [Resume Intelligence](frameworks/02-resume-intelligence-framework.md) | What the candidate can actually demonstrate |
| 03 | [Interview Stage](frameworks/03-interview-stage-framework.md) | Where the candidate is in the hiring process |
| 04 | [Role Fit & Gap Analysis](frameworks/04-role-fit-gap-analysis-framework.md) | Role Intelligence vs. Resume Intelligence |
| 05 | [Interview Intelligence](frameworks/05-interview-intelligence-framework.md) | Continuous enrichment from new interview evidence |
| 06 | [Preparation Strategy](frameworks/06-preparation-strategy-framework.md) | The shortest, highest-impact preparation plan |
| 07 | [Question Prediction](frameworks/07-question-prediction-framework.md) | Evidence-based likely questions |
| 08 | [Interview Hypothesis](frameworks/08-interview-hypothesis-framework.md) | What the interviewer is likely trying to validate |
| 09 | [Coding Interview Decision Engine](frameworks/09-coding-interview-decision-engine.md) | Coding preparation, simulation, and evaluation |
| 10 | [System Design Framework](frameworks/10-system-design-framework.md) | System-design preparation, simulation, and review |
| 11 | [Behavioral Interview Framework](frameworks/11-behavioral-interview-framework.md) | Real-experience-based behavioral preparation |
| 12 | [Mock Interview Framework](frameworks/12-mock-interview-framework.md) | Full realistic interview simulation |
| 13 | [Answer Coaching Framework](frameworks/13-answer-coaching-framework.md) | Structured feedback on a submitted answer |
| 14 | [Post-Interview Debrief Framework](frameworks/14-post-interview-debrief-framework.md) | Structured learning from a completed interview |
| 15 | [Interview Journey Intelligence Framework](frameworks/15-interview-journey-intelligence-framework.md) | Master orchestrator — decides which frameworks run, in what order |

Document 15 does not replace 01–14; it decides how they work together. See [`core/orchestration-policy.md`](core/orchestration-policy.md).

## Workflow routing

- [`core/workflow.md`](core/workflow.md) — the three operating modes (Full Interview Journey, Focused Task, Resume Interview Journey) and the routing principle.
- [`workflows/full-interview-journey.md`](workflows/full-interview-journey.md) — the complete, ordered end-to-end path.
- [`workflows/focused-task-routing.md`](workflows/focused-task-routing.md) — routing a specific request to the minimum required frameworks.
- [`workflows/resume-interview-journey.md`](workflows/resume-interview-journey.md) — continuing from the latest valid Interview Journey State.

## State handling

[`core/state-management.md`](core/state-management.md) and [`schemas/interview-journey-state.schema.md`](schemas/interview-journey-state.schema.md) define the Interview Journey State model. State is a **logical** record, not a storage mechanism: no background automation or hidden persistent data storage is implemented or implied. State is represented explicitly through user-provided files, Project Knowledge, conversation context, or generated artifacts.

## Claude Skill

- [`claude/skill/SKILL.md`](claude/skill/SKILL.md) — the Skill entry point.
- [`claude/skill-manifest.md`](claude/skill-manifest.md) — package contents and canonical source mappings.
- [`claude/packaging.md`](claude/packaging.md) — the packaging guide.

```bash
./scripts/package-claude-skill.sh
```

```powershell
.\scripts\package-claude-skill.ps1
```

Both produce `dist/interview-journey.skill.zip`.

## Claude Project experience

- [`claude/project-instructions.md`](claude/project-instructions.md) — full Project Instructions.
- [`claude/project-instructions.compact.md`](claude/project-instructions.compact.md) — compact Project Instructions.
- [`claude/project-setup.md`](claude/project-setup.md) — setup guide.
- [`claude/knowledge-manifest.md`](claude/knowledge-manifest.md) — recommended Project Knowledge.

For teammates outside the creator's Claude organization, a portable [external self-install kit](claude/external-install/README.md) packages the Skill, Instructions, and approved Knowledge into `dist/interview-journey-claude-kit.zip`, built with `./scripts/package-claude-external-kit.sh` or `.\scripts\package-claude-external-kit.ps1`.

## ChatGPT Custom GPT

- [`chatgpt/instructions.md`](chatgpt/instructions.md) — deployment-ready GPT Instructions.
- [`chatgpt/builder-config.md`](chatgpt/builder-config.md) — Builder configuration.
- [`chatgpt/knowledge-manifest.md`](chatgpt/knowledge-manifest.md) — Knowledge bundle-to-source mapping.
- [`chatgpt/builder-setup.md`](chatgpt/builder-setup.md), [`chatgpt/testing-guide.md`](chatgpt/testing-guide.md), [`chatgpt/sharing-and-publishing.md`](chatgpt/sharing-and-publishing.md), [`chatgpt/package-manifest.md`](chatgpt/package-manifest.md).

```bash
./scripts/build-chatgpt-knowledge.sh
./scripts/package-chatgpt-gpt.sh
```

```powershell
.\scripts\build-chatgpt-knowledge.ps1
.\scripts\package-chatgpt-gpt.ps1
```

Both produce `dist/interview-journey-chatgpt.zip`. This package configures no Actions, Apps, or external APIs.

## Synthetic example

A complete, fully fictional worked example — candidate, company, recruiter, interviewers, questions, and feedback — demonstrates the frameworks, schemas, and output contracts working together end to end:

- [`examples/synthetic-candidate/`](examples/synthetic-candidate/)

## Limitations

- No background monitoring, no scheduled research, no automatic persistence.
- No ChatGPT Actions, no Claude MCP servers, no external APIs, no databases.
- The product cannot guarantee cross-conversation memory beyond what the underlying platform itself retains.
- Missing source frameworks are never fabricated — see [`core/evidence-policy.md`](core/evidence-policy.md).

## Privacy boundaries

The product may only analyze information explicitly provided by the user. It must never invent candidate experience, interview process details, or interviewer information, and it must never copy real personal data into shared repository files, Skill packages, or Knowledge bundles — see [`core/state-management.md#context-boundary`](core/state-management.md#context-boundary).

## Further reading

- [`ROADMAP.md`](ROADMAP.md)
- [`CHANGELOG.md`](CHANGELOG.md)
- [`AGENTS.md`](AGENTS.md)
- [`CLAUDE.md`](CLAUDE.md)
- [`core/product-definition.md`](core/product-definition.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md)
