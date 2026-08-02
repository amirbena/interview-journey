# Repository Instructions for Coding Agents

`AGENTS.md` is the canonical, provider-neutral source of repository-wide
policy for this repository. It applies to every coding agent working here
(Claude Code, Codex, Gemini, or any other agent).

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

## Git and PR workflow

### Implementation branch rule

Every implementation task that changes repository files must use a
dedicated task branch. This includes: features, fixes, refactoring,
scripts, tests, configuration, prompts, skill behavior, committed
documentation changes, and generated repository artifacts intended for
commit.

Read-only analysis/review does not require a branch unless files will be
modified. Never implement directly on `main`.

### Up-to-date main rule

Every new implementation branch must start from the current remote
`main`. Before creating the task branch:

- fetch remote state
- update local `main`
- verify local `main == origin/main`
- resolve divergence before implementation

Do not create implementation branches from stale `main`. If valid work
already exists on an active feature branch, preserve it rather than
recreating it unnecessarily.

### Pre-edit gate

Before the first repository modification:

```text
- main is updated
- working tree is clean or fully understood
- dedicated task branch is active
- active branch is not main
```

Read-only inspection may occur before branch creation. File creation,
modification, deletion, formatting, or generated committed output may
not.

### Merge strategy

Prefer squash merge into `main`. Default flow: review → squash merge →
one focused commit on `main`. Use a different merge strategy only when
there is a clear repository-specific reason to preserve multiple
commits. Do not rewrite or force-push `main`.

### Post-merge synchronization

After a PR is successfully merged:

1. fetch latest remote state
2. switch local checkout to `main`
3. update local `main` from `origin/main`
4. verify local `main == origin/main`
5. verify the merged commit is present
6. delete the merged local task branch
7. delete the merged remote branch when appropriate

Because squash merge may make `git branch -d` refuse deletion, verify
the PR work is represented on `main` before using `git branch -D`. Never
force-delete first and verify afterward.

### Safe local cleanup

After merge, inspect `git status --short`. Remove only known-safe
disposable artifacts associated with the completed task (scratch files,
transient generated output, temporary task-specific artifacts,
reproducible build/test leftovers). Do not blindly remove unknown
untracked files.

Preserve: unrelated work, user-created files, credentials/secrets,
intentional local configuration, and another active task's artifacts.

Do not use broad destructive cleanup such as `git clean -fd` unless
every affected file has been explicitly inspected and confirmed safe.

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

- When a rule applies to all coding agents, update `AGENTS.md` only.
- Update `CLAUDE.md` (or another agent-specific file) only when the rule is genuinely specific to that agent.
- Do not copy shared `AGENTS.md` rules into an agent-specific file for convenience.
- If both files need to mention the same topic, the agent-specific file should reference the canonical rule in `AGENTS.md` and only add agent-specific specialization.

## Related documents

- [`README.md`](README.md)
- [`CLAUDE.md`](CLAUDE.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md)
