# Knowledge Manifest

Defines the three Knowledge bundles for the Interview Journey Custom GPT:
what each contains, which canonical repository files it's generated from, and
what Knowledge must never contain. A Custom GPT accepts well more than three
Knowledge files; this package deliberately uses three so the manual
publish step (see [`publishing-knowledge.md`](publishing-knowledge.md)) is as
small as the platform allows — there is no supported API to deploy Knowledge.

Knowledge bundles are generated, not hand-written. Rebuild them with
[`../scripts/build-chatgpt-knowledge.sh`](../scripts/build-chatgpt-knowledge.sh)
(or `.ps1`) — never edit a file under `chatgpt/knowledge/` directly.

## What Knowledge contains

- The full canonical frameworks (methodology, rules, rubrics).
- Schemas and output contracts.
- Core policy (evidence, accuracy, context priority, quality gates, state management).

## What Knowledge must not contain

- Behavioral instructions that belong in [`instructions.md`](instructions.md) (routing, clarification policy, non-actions).
- Personal candidate, role, or interviewer records.
- The synthetic-candidate golden journey content.
- Repository-development rules (`AGENTS.md`, `CLAUDE.md`, working rules, commit conventions).
- Packaging scripts.
- `CHANGELOG.md` or `ROADMAP.md`.
- Any promise of persistence.

## Provenance header

Every generated bundle starts with a deterministic provenance block:

```
Bundle: 02-role-resume-and-strategy.md (2 of 3)
Sources (in order):
  frameworks/01-role-intelligence-framework.md
  ...
Content-Digest (sha256, sources concatenated in order, CR bytes removed): <hex>
```

**Digest normalization contract** (identical in `build-chatgpt-knowledge.sh`
and `.ps1`): the digest input is the ordered concatenation of each listed
source's raw bytes with every CR (`0x0D`) byte removed. Nothing else is
added, removed, or normalized — a source's final-LF presence or absence is
preserved, and a lone CR is removed the same way on every platform. The
bundle body embeds those same CR-stripped bytes. Because the digest depends
only on source content — no timestamp, no commit — rebuilding from unchanged
sources yields byte-identical bundles on Bash and PowerShell alike.

`tests/validate-repository.sh` enforces this: it rebuilds the bundles into a
throwaway directory and fails if any committed file differs by a single byte
(catching a source changed without rebuilding, a hand-edited bundle, a stale
digest, or wrong source membership/order), checks the normalization rule
against LF / CRLF / lone-CR / no-final-newline fixtures, and — when `pwsh` is
present — additionally compares the Bash and PowerShell output byte for byte.

The packaging step additionally records these digests against a repository
commit in `deployment-release.json` (UTF-8, no BOM); see
[`publishing-knowledge.md`](publishing-knowledge.md).

## Bundle source mapping

### `01-product-orchestration-and-quality.md`

How the product runs, plus the quality and output contracts every response
is held to.

- `core/product-definition.md`
- `core/terminology.md`
- `core/scope-and-non-goals.md`
- `core/workflow.md`
- `core/orchestration-policy.md`
- `core/state-management.md`
- `schemas/interview-journey-state.schema.md`
- `frameworks/15-interview-journey-intelligence-framework.md`
- `core/evidence-policy.md`
- `core/accuracy-policy.md`
- `core/context-priority.md`
- `core/quality-gates.md`
- `core/output-contracts.md`
- `core/offer-negotiation-preparation.md`

### `02-role-resume-and-strategy.md`

Analysis and preparation planning: role and resume intelligence, stage and
fit, interview intelligence, preparation strategy, question prediction, and
hypotheses.

- `frameworks/01-role-intelligence-framework.md`
- `frameworks/02-resume-intelligence-framework.md`
- `frameworks/03-interview-stage-framework.md`
- `frameworks/04-role-fit-gap-analysis-framework.md`
- `frameworks/05-interview-intelligence-framework.md`
- `frameworks/06-preparation-strategy-framework.md`
- `schemas/public-research-evidence.schema.md`
- `workflows/research-current-interview-intelligence.md`
- `frameworks/07-question-prediction-framework.md`
- `frameworks/08-interview-hypothesis-framework.md`

### `03-interview-execution.md`

Per-interview-type execution: coding, system design, behavioral, mock
interviews, answer coaching, and post-interview debrief.

- `frameworks/09-coding-interview-decision-engine.md`
- `frameworks/10-system-design-framework.md`
- `frameworks/11-behavioral-interview-framework.md`
- `frameworks/12-mock-interview-framework.md`
- `frameworks/13-answer-coaching-framework.md`
- `frameworks/14-post-interview-debrief-framework.md`

## Integrity expectations

- Every `core/*.md`, every `frameworks/NN-*.md` (01–15), and all three
  `schemas/interview-journey-state.schema.md`,
  `schemas/public-research-evidence.schema.md`, and
  `workflows/research-current-interview-intelligence.md` appear in exactly
  one bundle.
- Rebuilding the bundles from unchanged sources must produce identical file
  contents — the build scripts are deterministic, and the `Content-Digest`
  header makes that verifiable.
- Bundle boundaries follow the methodology's natural layers, so semantically
  related content stays co-located and retrieval quality is preserved when
  the grouping changes.
- No personal data, golden-journey content, or GPT behavioral instructions
  may enter a bundle.
