# Repository Instructions for Claude Code

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

## Claude Skill packaging rules

- `claude/skill/` is the installable Skill source.
- `core/`, `frameworks/`, `schemas/`, `workflows/`, and `outputs/` remain canonical — the Skill adapts them, it does not redefine them.
- Packaging uses an explicit allowlist (`SKILL.md`, `references/`, `templates/`), never a recursive repository copy followed by exclusions.
- Never recursively package the whole repository.
- The macOS/Linux and Windows packaging scripts must remain logically equivalent (same allowlist, same output filename, same top-level directory, same normalized file list).
- Real candidate data and the synthetic example must never enter the Skill ZIP.
- Packaging scripts must work when invoked from outside the repository root.
- Every Skill change must validate package contents before completion.

## Claude Project experience rules

- Project Instructions orchestrate; they do not duplicate the Skill.
- Full and compact Project Instructions must remain behaviorally aligned.
- Shared Project Knowledge must contain methodology only.
- Personal records belong only in user-controlled context.
- Platform persistence must not be reimplemented in prompts.
- Project files must not redefine canonical frameworks, schemas, evidence states, or output contracts.

## Claude external kit rules

- External kits use an explicit allowlist.
- External Instructions are copied from the canonical compact source during packaging.
- Knowledge deployment files come from canonical repository sources.
- External kits contain no synthetic example or personal records.
- Skill ZIP and External Kit ZIP are distinct artifacts.
- macOS/Linux and Windows kit packagers must remain logically equivalent.

## ChatGPT packaging rules

- `chatgpt/instructions.md` is the canonical Custom GPT behavior source.
- GPT Instructions define behavior; Knowledge defines reference material.
- Generated Knowledge bundles must not be edited manually — rebuild them with the build scripts.
- Knowledge bundles derive only from explicit canonical source allowlists.
- Keep the Knowledge file count within the current GPT limit.
- Do not upload the synthetic example or personal records as shared GPT Knowledge.
- The GPT must not claim unavailable memory, browsing, storage, or automation.
- Actions, Apps, APIs, monitoring, and automated outreach/scheduling remain out of scope.
- macOS/Linux and Windows builders and packagers must remain logically equivalent.

## Data and privacy rules

- Use synthetic data only in any example or test fixture.
- Never place real candidate, role, interviewer, or recruiter data in repository files.
- Document assumptions explicitly when source information is incomplete.

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

## Related documents

- [`README.md`](README.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md)
