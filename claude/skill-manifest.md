# Claude Skill Manifest

This manifest describes the packaged Claude Skill for Interview Journey: what it contains, how it maps back to the canonical repository, and how to build the installable ZIP.

## Two distinct artifacts

This repository builds two separate packages, and they are not interchangeable:

- **Skill ZIP** (`interview-journey.skill.zip`, documented in this file) — the execution package: `SKILL.md`, progressive references, and templates. It is what gets installed as a Claude Skill.
- **External Kit ZIP** (`interview-journey-claude-kit.zip`, documented in [`external-install/package-manifest.md`](external-install/package-manifest.md)) — a distribution and Project-setup package for users outside the creator's Claude organization. It embeds the Skill ZIP unchanged and adds compact Project Instructions, a fixed Knowledge allowlist, and installation documentation around it.

Neither package may contain personal data, and the External Kit never redefines or forks the Skill — it packages the same Skill ZIP this file describes.

## Skill identity

- **Skill name:** `interview-journey`
- **Version:** 1.0.0
- **Package root (source):** [`claude/skill/`](skill/)
- **Top-level directory inside the ZIP:** `interview-journey/`

## Included files

Everything under `claude/skill/` is Skill source and enters the package:

```
claude/skill/
  SKILL.md
  references/
    product-and-orchestration.md
    role-and-resume-intelligence.md
    stage-fit-and-interview-intelligence.md
    preparation-strategy.md
    question-prediction-and-hypotheses.md
    coding-interviews.md
    system-design-interviews.md
    behavioral-interviews.md
    mock-interviews.md
    answer-coaching.md
    post-interview-debrief.md
    offer-and-negotiation-preparation.md
    research-and-evidence.md
    state-and-output-generation.md
    accuracy-and-quality.md
  templates/
    role-intelligence.md
    resume-intelligence.md
    interview-process.md
    role-fit-gap-analysis.md
    preparation-strategy.md
    question-predictions.md
    interview-hypotheses.md
    coding-preparation.md
    system-design-preparation.md
    behavioral-story-map.md
    mock-interview-scorecard.md
    answer-coaching.md
    post-interview-debrief.md
    offer-negotiation-preparation.md
    interview-journey-state.md
```

## Intentionally excluded files

The package uses an explicit allowlist (`SKILL.md`, `references/`, `templates/`), so everything else is excluded by construction, including:

- `.git/`, `.github/`
- `.DS_Store`, `Thumbs.db`, `__MACOSX/`
- The repository root `README.md`, `ROADMAP.md`, `CHANGELOG.md`, `AGENTS.md`, `CLAUDE.md`
- `core/`, `frameworks/`, `schemas/`, `workflows/`, `outputs/`
- `examples/` (including the synthetic-candidate golden journey — it is a repository development asset, not Skill content, and must never enter the package)
- `tests/`
- `claude/skill-manifest.md`, `claude/packaging.md` (documentation about the package, not part of it)
- `scripts/` (the packaging scripts themselves)
- Any previous `*.skill.zip` output, temporary build folders, or caches

## Canonical source mappings

Every reference file in `claude/skill/references/` adapts specific canonical repository files rather than redefining them. See the "Canonical sources" note at the top of each reference file for the exact mapping. Summary:

| Reference file | Canonical sources |
|---|---|
| `product-and-orchestration.md` | `core/product-definition.md`, `core/workflow.md`, `core/orchestration-policy.md`, `frameworks/15-*.md` |
| `role-and-resume-intelligence.md` | `frameworks/01-*.md`, `frameworks/02-*.md`, `schemas/role-intelligence.schema.md`, `schemas/resume-intelligence.schema.md` |
| `stage-fit-and-interview-intelligence.md` | `frameworks/03-*.md`, `frameworks/04-*.md`, `frameworks/05-*.md` |
| `preparation-strategy.md` | `frameworks/06-*.md` |
| `question-prediction-and-hypotheses.md` | `frameworks/07-*.md`, `frameworks/08-*.md` |
| `coding-interviews.md` | `frameworks/09-*.md` |
| `system-design-interviews.md` | `frameworks/10-*.md` |
| `behavioral-interviews.md` | `frameworks/11-*.md` |
| `mock-interviews.md` | `frameworks/12-*.md` |
| `answer-coaching.md` | `frameworks/13-*.md` |
| `post-interview-debrief.md` | `frameworks/14-*.md` |
| `offer-and-negotiation-preparation.md` | `core/offer-negotiation-preparation.md`, `workflows/prepare-offer-negotiation.md`, `outputs/offer-negotiation-preparation-template.md` |
| `research-and-evidence.md` | `core/evidence-policy.md`, `core/context-priority.md`, `schemas/public-research-evidence.schema.md`, `workflows/research-current-interview-intelligence.md` |
| `state-and-output-generation.md` | `core/state-management.md`, `core/output-contracts.md`, `schemas/interview-journey-state.schema.md`, `outputs/*` |
| `accuracy-and-quality.md` | `core/evidence-policy.md`, `core/accuracy-policy.md`, `core/quality-gates.md`, `core/context-priority.md` |

Templates in `claude/skill/templates/` mirror the placeholder structure of the matching file in `outputs/*-template.md`, with all synthetic example content stripped — templates ship as clean, reusable placeholders only.

## Expected ZIP structure

```
interview-journey.skill.zip
└── interview-journey/
    ├── SKILL.md
    ├── references/
    │   └── ... (15 files)
    └── templates/
        └── ... (15 files)
```

Exactly one top-level directory. No other files or directories at the ZIP root.

## Installation outline

1. Download or build `dist/interview-journey.skill.zip` (see [`packaging.md`](packaging.md)).
2. In the target Claude surface's Skill management UI, upload the ZIP as a new Skill (or extract it to the location that surface expects a Skill package to live).
3. Confirm the Skill is named `interview-journey` and that its description matches the frontmatter in `SKILL.md`.
4. No further configuration is required — the Skill has no external dependencies and does not require API keys, credentials, or connected accounts.

## Packaging commands

macOS / Linux:

```bash
./scripts/package-claude-skill.sh
```

Windows PowerShell:

```powershell
.\scripts\package-claude-skill.ps1
```

Both produce `dist/interview-journey.skill.zip`. See [`packaging.md`](packaging.md) for full documentation.

## Supported operating systems

- macOS (Bash 3.2+ via the system `zip` utility, or a newer Bash)
- Linux (Bash with `zip` available)
- Windows (Windows PowerShell 5.1 or PowerShell 7+, using built-in .NET ZIP support)

## Known limitations

- The packaging scripts require a standard `zip` command (macOS/Linux) or built-in PowerShell/.NET compression cmdlets (Windows) — no third-party packaging dependency is bundled or installed.
- ZIP files produced on different operating systems are not guaranteed to be byte-for-byte identical, because each platform's `zip` implementation writes different archive metadata. The normalized internal file list and the contents of each file are guaranteed to match; the raw archive bytes and hash are not.
- The Skill package contains no example data. Users who want to see the methodology applied end-to-end should read the synthetic candidate golden journey in [`examples/synthetic-candidate/`](../examples/synthetic-candidate/) directly in the repository — it is intentionally not shipped inside the Skill package.
