# Git and PR Workflow

Detailed branch, merge, and Issue/PR-writing policy. Moved verbatim from
`AGENTS.md`; the entry point is [../AGENTS.md](../AGENTS.md).

## Implementation branch rule

Every implementation task that changes repository files must use a
dedicated task branch. This includes: features, fixes, refactoring,
scripts, tests, configuration, prompts, skill behavior, committed
documentation changes, and generated repository artifacts intended for
commit.

Read-only analysis/review does not require a branch unless files will be
modified. Never implement directly on `main`.

### Branch naming

Implementation branches must use `feat/`, `fix/`, `refactor/`, or
`docs/` followed by a short, descriptive kebab-case suffix. Use `feat/`
for new user-facing or repository capabilities, `fix/` for defect
corrections, `refactor/` for behavior-preserving structural
improvements, and `docs/` for documentation-only work. Examples:
`feat/offer-negotiation-prep`, `fix/skill-package-manifest`,
`refactor/instruction-packaging`, `docs/update-contributor-guide`. Do
not invent additional prefixes for normal implementation work unless
repository policy adds them.

Branch names describe the work, not the coding agent or provider. Never
create an implementation branch with `codex/` or an equivalent
agent/provider-owned prefix. Do not rename an already-active valid task
branch solely to apply this convention unless branch normalization is
part of the task.

## Up-to-date main rule

Every new implementation branch must start from the current remote
`main`. Before creating the task branch:

- fetch remote state
- update local `main`
- verify local `main == origin/main`
- resolve divergence before implementation

Do not create implementation branches from stale `main`. If valid work
already exists on an active feature branch, preserve it rather than
recreating it unnecessarily.

## Pre-edit gate

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

## Merge strategy

Prefer squash merge into `main`. Default flow: review → squash merge →
one focused commit on `main`. Use a different merge strategy only when
there is a clear repository-specific reason to preserve multiple
commits. Do not rewrite or force-push `main`.

### Admin merge fallback

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

## Post-merge synchronization

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

## Safe local cleanup

After merge, inspect `git status --short`. Remove only known-safe
disposable artifacts associated with the completed task (scratch files,
transient generated output, temporary task-specific artifacts,
reproducible build/test leftovers). Do not blindly remove unknown
untracked files.

Preserve: unrelated work, user-created files, credentials/secrets,
intentional local configuration, and another active task's artifacts.

Do not use broad destructive cleanup such as `git clean -fd` unless
every affected file has been explicitly inspected and confirmed safe.

## Write Issues and PRs for humans, not for templates

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
Final response report and Before completion checks in
[../AGENTS.md](../AGENTS.md).
