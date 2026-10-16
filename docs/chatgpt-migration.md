# ChatGPT migration: Custom GPT → ChatGPT Plugin

The skills-only ChatGPT Plugin is the primary ChatGPT distribution target. The Custom GPT is **deprecated** and kept only as a temporary safeguard until the plugin is verified; it is then removed. Its packaging is not being extended, and there is no permanent dual maintenance.

## One instruction source

[`chatgpt/instructions.md`](../chatgpt/instructions.md) is the single canonical source. It is written platform-neutrally and refers to bundled reference files (`references/`). The plugin packager uses it as the body of the plugin `SKILL.md`; the transitional Custom GPT pastes it unedited, and its attached Knowledge files play the role of `references/`.

## Plugin contents

`plugin.json`, `skills/interview-journey/SKILL.md`, and `references/` (the three generated Knowledge bundles plus `capability-policy.md`). No MCP servers, Actions, Apps, hooks, external APIs, or background automation. Details: [`chatgpt/plugin-config.md`](../chatgpt/plugin-config.md).

## Status

- Plugin package build and contents: verified (Bash).
- Plugin install in Codex CLI and ChatGPT Desktop: **unverified**.
- Removal of the Custom GPT package follows verification of the plugin.
