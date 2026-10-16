# Repository Instructions for Coding Agents

`AGENTS.md` is the canonical, provider-neutral entry point for
repository-wide policy. It applies to every coding agent working here
(Claude Code, Codex, Gemini, or any other agent). Detailed policy lives
in the linked documents below; every rule has one home.

## Canonical instruction architecture

```text
AGENTS.md
  = canonical repository-wide source of truth

CLAUDE.md
  = Claude-specific extension (does not duplicate AGENTS.md)

Nested AGENTS.md / CLAUDE.md
  = narrower directory-specific instructions where applicable
```

**Invariant:** `AGENTS.md` is canonical for shared repository policy.
`CLAUDE.md` must not duplicate it wholesale, and must reference shared
rules rather than copy them. This prevents instruction drift between
Claude, Codex, Gemini, and other agents.

## Repository purpose and scope

This repository is the Interview Journey methodology and packaging
system. See [`README.md`](README.md) and
[`core/scope-and-non-goals.md`](core/scope-and-non-goals.md) for product
scope and non-goals.

## Working rules

- Always inspect the repository before changing files.
- Start feature work from the latest `main`.
- Create one dedicated branch per task.
- Do not modify unrelated files.
- Treat `core/` and `frameworks/` as the platform-independent source of truth.
- Keep `claude/` and `chatgpt/` platform-specific.
- Do not duplicate methodology across platform folders when it belongs in `core/` or `frameworks/`.
- Prefer small, focused changes.
- Do not add an application backend, database, external API, ChatGPT Action, Claude MCP server, browser automation, or LinkedIn/recruiter-platform automation unless a future task explicitly requests it.
- Do not push, open a PR, merge, or delete branches unless explicitly requested.

## Framework and methodology rules

- Do not invent missing framework rules. When a source framework document is unavailable or incomplete, preserve a clearly documented placeholder or dependency boundary rather than fabricating its contents.
- Document 15 (`frameworks/15-interview-journey-intelligence-framework.md`) is the master orchestrator; documents 01–14 are specialized modules. Changes to routing logic belong in Document 15 and `core/orchestration-policy.md`, not scattered across individual frameworks.
- Platform adaptations (Skill references, GPT Knowledge) must not silently change canonical rules, scoring formulas, or enums defined in `frameworks/` and `core/`.

## Where the detailed rules live

Responsibilities are separate: `core/` and `frameworks/` hold the product
methodology, `policies/` holds the rules agents follow when changing
this repository, and `docs/`-style human documentation lives alongside
the relevant top-level files (e.g. `README.md`).

| Topic | Document |
| --- | --- |
| Branch naming, up-to-date `main`, pre-edit gate, merge strategy, admin merge fallback, post-merge sync, safe local cleanup, Issue and PR writing | [policies/git-workflow.md](policies/git-workflow.md) |
| Cross-package delivery, Claude Skill packaging, Claude Project experience, Claude external kit, ChatGPT packaging, data and privacy rules | [policies/packaging-rules.md](policies/packaging-rules.md) |
| Product scope and non-goals | [core/scope-and-non-goals.md](core/scope-and-non-goals.md) |

Read the Git workflow before your first change, and the packaging rules
before touching `claude/` or `chatgpt/` packaging or any cross-package
capability.

## Before completion

- Inspect the final diff.
- Verify relative Markdown links.
- Confirm only expected files changed.
- Run all relevant checks (see `tests/`) before declaring completion.
- Commit the work.

## Final response report

Every task's final response must include:

- Branch name
- Commit hash
- Changed files
- Validation performed
- Remaining limitations

## Preventing instruction drift

- When a rule applies to all coding agents, update the canonical document that owns it (this file or a linked policy document) only.
- Update `CLAUDE.md` (or another agent-specific file) only when the rule is genuinely specific to that agent.
- Do not copy shared rules into an agent-specific file for convenience.
- If both files need to mention the same topic, the agent-specific file should reference the canonical rule and only add its own specialization.

## Related documents

- [`README.md`](README.md)
- [`CLAUDE.md`](CLAUDE.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md)
- [`policies/git-workflow.md`](policies/git-workflow.md)
- [`policies/packaging-rules.md`](policies/packaging-rules.md)
