# Interview Journey — ChatGPT Custom GPT (deprecated, transitional)

> **Deprecated.** The primary ChatGPT target is the skills-only plugin ([`plugin-config.md`](plugin-config.md)). This Custom GPT package is kept only as a temporary migration safeguard until the plugin is verified, and is not being extended. See [`../docs/chatgpt-migration.md`](../docs/chatgpt-migration.md).

This directory contains everything needed to deploy Interview Journey as a ChatGPT Custom GPT.

- [`instructions.md`](instructions.md) — the single canonical instruction source, used by both the plugin and (pasted unedited) the transitional Custom GPT, where the attached Knowledge files serve as the `references/`.
- [`builder-config.md`](builder-config.md) — Name, Description, and paste-ready Builder fields.
- [`builder-setup.md`](builder-setup.md) — step-by-step setup guide.
- [`capability-policy.md`](capability-policy.md) — behavior when optional capabilities are/aren't available.
- [`conversation-starters.md`](conversation-starters.md) — starter prompts.
- [`knowledge-manifest.md`](knowledge-manifest.md) — the three Knowledge bundles and their canonical sources.
- [`knowledge/`](knowledge/) — the generated Knowledge bundles (build with `scripts/build-chatgpt-knowledge.sh` / `.ps1`).
- [`testing-guide.md`](testing-guide.md) — smoke tests to run before sharing.
- [`sharing-and-publishing.md`](sharing-and-publishing.md) — visibility guidance.
- [`publishing-knowledge.md`](publishing-knowledge.md) — supported-capability limits and the procedure for updating a published GPT's Knowledge.
- [`package-manifest.md`](package-manifest.md) — the deployable archive's exact contents.

## Build the deployable package

```bash
./scripts/build-chatgpt-knowledge.sh
./scripts/package-chatgpt-gpt.sh
```

```powershell
.\scripts\build-chatgpt-knowledge.ps1
.\scripts\package-chatgpt-gpt.ps1
```

Both produce `dist/interview-journey-chatgpt.zip`. This package configures no Actions, Apps, or external APIs.
