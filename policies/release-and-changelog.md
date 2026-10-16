# Release and Changelog Policy

Repository-maintenance policy. It governs CI, release classification, the
changelog, and GitHub Releases. It is not part of the Interview Journey
methodology and must not appear in `core/`, `frameworks/`, the Skill, or
Project instructions. Shared agent rules live in [`AGENTS.md`](../AGENTS.md).

## CI

`.github/workflows/ci.yml` runs on every pull request, on a Linux runner,
with Bash only. It runs `tests/validate-repository.sh` and the release-label
check. CI does not install or invoke the Claude CLI or PowerShell and does not
build packages. The PowerShell parity checks inside the validator skip
themselves when `pwsh` is absent.

## Release classification

Every PR carries exactly one label:

| Label | Use for |
| --- | --- |
| `release: major` | Backward-incompatible change to a distributed package or contract |
| `release: minor` | New user-visible capability |
| `release: patch` | Backward-compatible fix or improvement to distributed behavior |
| `release: none` | No release warranted: CI, policies, docs, tests, internal refactors |

- The authoring agent proposes a label in the PR's *Release impact* section.
  The reviewer makes the final decision and sets the label.
- Repository-maintenance changes legitimately use `release: none`.
- Use Conventional Commit PR titles (`feat:`, `fix:`, `docs:`, `refactor:`,
  `chore:`; `!` or a `BREAKING CHANGE:` footer for breaking changes).
  `scripts/validate-pr-release.sh` rejects a label lower than the title implies
  and a `release: major` without a breaking-change marker. A higher label than
  the title implies is allowed.

## Changelog

- `CHANGELOG.md` has one section per released version, written by the release
  automation from merged PRs. Do not edit released sections by hand.
- An entry is one concise line describing a user-visible or meaningful
  technical change. It does not restate the PR description, list files, or
  narrate review follow-ups.
- `release: none` changes produce no entry.

## Releases

- A release is cut only from `main` by the release workflow, using the merged
  PRs' `release:` labels since the last tag and semantic versioning. The
  first release is the `v1.0.0` baseline.
- Release assets are the existing Skill, External Kit, and ChatGPT GPT ZIPs,
  built by the existing packaging scripts from the tagged revision after
  `tests/validate-repository.sh` passes on that commit. Package contents and
  filenames do not change.
- GitHub Release ZIPs are the distribution channel for now. Do not assume they
  are consumed by Claude or Codex marketplaces; marketplace distribution is a
  separate decision.
