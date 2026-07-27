# Knowledge Manifest

Defines the ten Knowledge bundles for the Interview Journey Custom GPT: what each contains, which canonical repository files it's generated from, and what Knowledge must never contain. A Custom GPT currently accepts up to 10 Knowledge files — this package uses all 10.

Knowledge bundles are generated, not hand-written. Rebuild them with [`../scripts/build-chatgpt-knowledge.sh`](../scripts/build-chatgpt-knowledge.sh) (or `.ps1`) — never edit a file under `chatgpt/knowledge/` directly.

## What Knowledge contains

- The full canonical frameworks (methodology, rules, rubrics).
- Schemas and output contracts.
- Core policy (evidence, accuracy, context priority, quality gates, state management).

## What Knowledge must not contain

- Behavioral instructions that belong in [`instructions.md`](instructions.md) (routing, clarification policy, non-actions).
- Personal candidate, role, or interviewer records.
- The synthetic-candidate golden journey content.
- Repository-development rules (`CLAUDE.md`, working rules, commit conventions).
- Packaging scripts.
- `CHANGELOG.md` or `ROADMAP.md`.
- Any promise of persistence.

## Bundle source mapping

### `01-product-orchestration-and-state.md`
- `core/product-definition.md`
- `core/terminology.md`
- `core/scope-and-non-goals.md`
- `core/workflow.md`
- `core/orchestration-policy.md`
- `core/state-management.md`
- `frameworks/15-interview-journey-intelligence-framework.md`

### `02-role-intelligence.md`
- `frameworks/01-role-intelligence-framework.md`

### `03-resume-stage-and-fit.md`
- `frameworks/02-resume-intelligence-framework.md`
- `frameworks/03-interview-stage-framework.md`
- `frameworks/04-role-fit-gap-analysis-framework.md`

### `04-interview-intelligence-and-strategy.md`
- `frameworks/05-interview-intelligence-framework.md`
- `frameworks/06-preparation-strategy-framework.md`

### `05-question-prediction-and-hypotheses.md`
- `frameworks/07-question-prediction-framework.md`
- `frameworks/08-interview-hypothesis-framework.md`

### `06-coding-interviews.md`
- `frameworks/09-coding-interview-decision-engine.md`

### `07-system-design-interviews.md`
- `frameworks/10-system-design-framework.md`

### `08-behavioral-and-answer-coaching.md`
- `frameworks/11-behavioral-interview-framework.md`
- `frameworks/13-answer-coaching-framework.md`

### `09-mock-interviews-and-debrief.md`
- `frameworks/12-mock-interview-framework.md`
- `frameworks/14-post-interview-debrief-framework.md`

### `10-output-contracts-and-quality.md`
- `core/evidence-policy.md`
- `core/accuracy-policy.md`
- `core/context-priority.md`
- `core/quality-gates.md`
- `core/output-contracts.md`

## Integrity expectations

- Every canonical source above appears in exactly one bundle.
- Rebuilding the bundles from unchanged sources must produce identical file contents — the build scripts are deterministic.
- No personal data, golden-journey content, or GPT behavioral instructions may enter a bundle.
