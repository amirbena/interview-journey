# ChatGPT Plugin Configuration

The skills-only ChatGPT Plugin is the primary ChatGPT distribution target. The Custom GPT is deprecated and kept only as a temporary migration safeguard until the plugin is verified; see [`../docs/chatgpt-migration.md`](../docs/chatgpt-migration.md).

- Manifest and listing metadata: [`plugin/plugin.json`](plugin/plugin.json).
- Behavior: [`plugin/SKILL.header.md`](plugin/SKILL.header.md) (frontmatter) plus the canonical [`instructions.md`](instructions.md), assembled by `scripts/package-chatgpt-plugin.sh` / `.ps1`. Nothing is duplicated in the repository.
- References: the generated Knowledge bundles in [`knowledge/`](knowledge/) and [`capability-policy.md`](capability-policy.md). Do not edit generated bundles by hand.
- Allowed contents and exclusions (no MCP servers, Actions, Apps, hooks, external APIs, background automation): see [`capability-policy.md`](capability-policy.md).

## Manifest limits (OpenAI-documented; checked by `tests/validate-repository.sh` where noted)

`interface.displayName` and `interface.shortDescription` ≤ 30 characters, at most 3 `defaultPrompt` entries of ≤ 128 characters (all checked); `description` ≤ 4000 characters.

## Verification status

- Package builds from Bash: verified. PowerShell twin: written, not executed (`pwsh` unavailable).
- Installation in Codex CLI and ChatGPT Desktop: **unverified** — neither was available. Archive root layout (`plugin.json` at the top of the zip's package directory) and `interface.category` follow the Career Targeting Intelligence plugin and are unconfirmed against OpenAI's dashboard.
