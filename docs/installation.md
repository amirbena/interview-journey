# Installation

Interview Journey has one canonical Skill, [`skills/interview-journey/`](../skills/interview-journey/), distributed through several surfaces. Each command below is labeled **verified** (run during issue #25 work) or **unverified** (not yet run in a clean environment; confirm after the change is merged to `main`).

## Any skills-compatible agent (`npx skills`)

```bash
npx skills add amirbena/interview-journey
npx skills add amirbena/interview-journey -a cursor -y
```

- Local discovery of the Skill from a checkout (`npx skills add <path> --list`): **verified** — finds exactly one skill, `interview-journey`.
- Installing from GitHub (`amirbena/interview-journey`) and the Cursor variant: **unverified** until the layout is on `main`.

## Claude Code plugin marketplace

```text
/plugin marketplace add amirbena/interview-journey
/plugin install interview-journey@interview-journey
```

- `claude plugin validate .` passes: **verified**.
- Adding and installing from GitHub: **unverified** until the layout is on `main`.

## Codex

Codex reads the same marketplace.

```bash
codex plugin marketplace add amirbena/interview-journey
```

**Unverified** — the Codex CLI was not available when this was implemented. After install, confirm that `references/` and `templates/` are present and that a basic workflow runs.

## Claude Skill ZIP (claude.ai)

```bash
./scripts/package-claude-skill.sh   # or .\scripts\package-claude-skill.ps1
```

Upload `dist/interview-journey.skill.zip` in Claude **Settings → Capabilities → Skills**. Package build: **verified**; upload flow unchanged from before.

## Claude Project (external kit)

```bash
./scripts/package-claude-external-kit.sh   # or .ps1
```

Follow [`claude/external-install/README.md`](../claude/external-install/README.md). Package build: **verified**.

## ChatGPT

- **ChatGPT Plugin (skills-only, primary):** `./scripts/package-chatgpt-plugin.sh` produces `dist/interview-journey-chatgpt-plugin.zip`. Package build: **verified**. Installation into Codex CLI and ChatGPT Desktop: **unverified** (neither was available); see [`chatgpt/plugin-config.md`](../chatgpt/plugin-config.md). Keep using the Custom GPT until the plugin is verified.

See [packaging](packaging.md) for how each artifact is built.

The legacy Custom GPT is deprecated and transitional; see [ChatGPT migration](chatgpt-migration.md).
