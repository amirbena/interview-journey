# Package Manifest

Describes the exact contents of `dist/interview-journey-chatgpt.zip`, built by `scripts/package-chatgpt-gpt.sh` (or `.ps1`).

## Package identity

- **Package name:** `interview-journey-chatgpt`
- **Top-level directory inside the ZIP:** `interview-journey-chatgpt/`

## Included files (explicit allowlist)

```
interview-journey-chatgpt/
  README.md
  instructions.md
  builder-config.md
  conversation-starters.md
  builder-setup.md
  capability-policy.md
  testing-guide.md
  sharing-and-publishing.md
  knowledge-manifest.md
  knowledge/
    01-product-orchestration-and-state.md
    02-role-intelligence.md
    03-resume-stage-and-fit.md
    04-interview-intelligence-and-strategy.md
    05-question-prediction-and-hypotheses.md
    06-coding-interviews.md
    07-system-design-interviews.md
    08-behavioral-and-answer-coaching.md
    09-mock-interviews-and-debrief.md
    10-output-contracts-and-quality.md
```

## Intentionally excluded

- `.git/`, `.DS_Store`, `Thumbs.db`, `__MACOSX/`
- `examples/synthetic-candidate/`
- `frameworks/`, `core/`, `schemas/`, `workflows/`, `outputs/` (their content is embedded inside the generated `knowledge/` bundles, not duplicated as raw files)
- `tests/`, `scripts/`, `.build/`, any previous `*.zip` output
- Any real candidate, role, or interviewer data
- No Actions, Apps, or API credential files — this GPT configures none

## Build order

1. `build-chatgpt-knowledge.sh` (or `.ps1`) generates the ten bundles under `chatgpt/knowledge/` from the explicit source allowlist in [`knowledge-manifest.md`](knowledge-manifest.md).
2. `package-chatgpt-gpt.sh` (or `.ps1`) validates all required documentation files exist, rebuilds the Knowledge bundles, and assembles the package archive around them in a dedicated staging directory.

## Validation

After building, unzip the package and confirm: exactly one top-level directory; the file list matches this manifest exactly; each `knowledge/*.md` file starts with the generated-content notice and lists its canonical sources; no personal data or forbidden files are present.
