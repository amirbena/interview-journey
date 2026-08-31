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

## Cross-package delivery

The methodology is distributed through three supported package surfaces:
the ChatGPT Custom GPT, the Claude Skill, and the Claude Project.

- Each user-facing capability or workflow is defined once, canonically,
  in `core/` and `frameworks/`. Packages adapt that definition; they do
  not restate or re-derive it.
- A capability that applies to end users is not complete until it is
  exposed through all three surfaces. Trigger points, scope, required
  inputs, outputs, and methodology must stay equivalent across them.
- Platform-specific wording, formatting, and presentation may differ to
  fit each platform's constraints. Behavioral drift between packages
  must not.
- Issues and Acceptance Criteria for a cross-package capability must
  reflect this: one canonical definition, exposure in the ChatGPT
  package, the Claude Skill, and the Claude Project, and validation that
  behavior is equivalent across the three.
- This requirement does not apply to work that ships no user-facing
  capability: repository maintenance, CI/tooling, documentation or
  release infrastructure, research without a shipped capability, and
  internal refactors that do not change distributed behavior.

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
- Keep the Knowledge file count small — it is the manual publish-step count, since no supported OpenAI API deploys Custom GPT Knowledge. Every canonical `core/`, `frameworks/`, and referenced schema/workflow source must map to exactly one bundle.
- Each generated bundle carries a deterministic provenance header (bundle position, ordered source list, and a `Content-Digest`). The digest normalization contract — identical in the Bash and PowerShell builders — is: sha256 over the ordered concatenation of each source's raw bytes with every CR (`0x0D`) removed, nothing else added or removed (final-LF presence preserved). The digest must depend only on source content, so rebuilds stay byte-identical across platforms. `tests/validate-repository.sh` rebuilds the bundles into a throwaway directory and fails on any byte difference, checks the normalization rule against edge-case fixtures, and compares Bash vs PowerShell output when `pwsh` is available.
- The ChatGPT packaging script emits `deployment-release.json` (repository commit, `git describe`, commit date, per-bundle digests; UTF-8 without BOM from either builder) into the archive. It is a generated build artifact, never hand-edited or committed.
- `chatgpt/publishing-knowledge.md` is the authoritative publish procedure and record of supported vs unsupported deployment mechanisms; keep it in sync with the scripts.
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

#### Admin merge fallback

When squash merging a PR, if GitHub rejects the normal merge solely
because of a required-review or equivalent branch/ruleset requirement,
`--admin` may be used automatically without requesting additional user
confirmation, provided all of the following are true:

- the user has already requested or authorized the merge
- the PR has been reviewed
- the PR is mergeable
- there are no merge conflicts
- required CI/checks are passing, or no required checks exist
- the reviewed remote diff has not changed unexpectedly
- there are no unresolved review comments or known blocking issues
- the only remaining blocker is the required-review/ruleset restriction
- squash merge remains the intended merge method

In that case, retry with:

```bash
gh pr merge <PR> --squash --admin
```

without stopping for another confirmation. State plainly in the final
report that the required-review gate was bypassed.

`--admin` must NOT be used automatically to bypass:

- failing required checks
- merge conflicts
- unresolved code-review findings
- unexpected new commits or changed scope
- failed validation
- security or policy findings
- an explicit instruction not to merge
- uncertainty about why GitHub rejected the merge

If the merge failure reason is unclear, investigate first rather than
bypassing it.

A previous instruction to perform the merge is sufficient authorization
to use the admin fallback when the only blocker is the known
required-review ruleset — `--admin` does not itself require a second
confirmation in that case. However, general implementation permission
is never permission to merge: there must still be an explicit merge
task or instruction from the user before any merge is attempted.

Preferred merge flow:

```text
review
→ verify remote diff/checks/mergeability
→ attempt normal squash merge
→ if blocked only by required-review ruleset:
     retry squash merge with --admin
→ verify MERGED
→ sync local main
→ delete merged branches
→ safe cleanup
```

If the repository is known in advance to require the admin bypass
consistently, it is acceptable to use `--admin` directly once all merge
gates above are satisfied.

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

### Write Issues and PRs for humans, not for templates

`.github/ISSUE_TEMPLATE/engineering-task.yml` and
`.github/pull_request_template.md` provide the structure. This rule
governs how the prose inside that structure is written.

When creating or drafting Engineering Tasks or Pull Request descriptions:

- write for the engineer who needs to understand and act on the work;
- use natural, concise prose; explain the problem, intent, and reasoning,
  not just the file diff;
- do not mechanically narrate every changed file or implementation step;
- keep the description proportionate to the change — prefer a few useful
  paragraphs or focused bullets over long generated reports;
- do not repeat the same information across sections, and omit optional
  sections that add no value;
- still preserve scope, constraints, acceptance criteria, risks, and
  validation details when they materially help execution or review.

For Issues / Engineering Tasks specifically:

- one Issue represents one independently closable outcome; split
  independently closable work into separate Issues rather than a large
  catch-all ticket;
- describe the problem before prescribing implementation where possible;
- keep Scope and Acceptance Criteria focused and non-duplicative;
- do not turn the Issue into a design document unless the task genuinely
  needs that depth.

For PR descriptions specifically:

- summarize what changed and why in human-readable language;
- highlight non-obvious decisions and reviewer-relevant context;
- include validation concisely; do not produce file-by-file changelogs or
  dump test logs, command output, or exhaustive implementation
  inventories unless they are needed to understand risk or correctness;
- keep the Notes section optional.

Conciseness must not remove information needed to execute the task
correctly, understand important architectural decisions, review
risk/correctness, or verify completion. Prefer useful density, not
maximum brevity. This complements — and does not weaken — the mandatory
[Final response report](#final-response-report) and
[Before completion](#before-completion) checks.

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
