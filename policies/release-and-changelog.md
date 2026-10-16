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
- Release assets are the Skill, External Kit, and ChatGPT GPT ZIPs plus the
  Claude plugin and ChatGPT plugin ZIPs (`interview-journey-claude-plugin.zip`,
  `interview-journey-chatgpt-plugin.zip`, built by `scripts/package-claude-plugin.sh`
  and `scripts/package-chatgpt-plugin.sh`). A plugin ZIP is attached only when
  the tagged revision contains its packager. All are built by the packaging
  scripts from the tagged revision, with `RELEASE_VERSION` set to the release
  version, after `tests/validate-repository.sh` passes on that commit. The
  release fails if any manifest inside a built archive carries a version other
  than the tag's.
- **Version synchronization:** `scripts/release/sync-versions.sh` writes the
  release version into every discovered marketplace/plugin manifest
  (`marketplace.json` and `plugin.json` under `.claude-plugin/`, `.codex-plugin/`
  or `.agents/plugins/`; existing `version`, `metadata.version` and
  `plugins[].version` fields only). The change goes into the same
  `chore(release)` commit as `CHANGELOG.md`, and no commit is made when nothing
  changed. Humans and agents do not bump these versions in ordinary PRs.
  `sync-versions.sh check` (also run by `tests/validate-repository.sh`) fails
  when manifest versions disagree. It requires `jq`.
- GitHub Release ZIPs are the distribution channel for now. Do not assume they
  are consumed by Claude or Codex marketplaces; marketplace distribution is a
  separate decision.

## Release setup and permissions

Releases use the existing `Skill Release Automation` GitHub App; do not create
another. Nothing secret is committed.

- **App installation:** installed on this repository with repository
  permissions `Contents: Read and write` (release commit, tag, Release,
  assets), `Pull requests: Read-only` (reading merged PRs' `release:` labels),
  and `Metadata: Read-only` (implicit). No other permissions.
- **Environment `release`:** secrets `RELEASE_APP_ID` and
  `RELEASE_APP_PRIVATE_KEY`. The workflow requests a short-lived token from
  them and uses it for checkout, push, and `gh`. The job's own
  `GITHUB_TOKEN` stays read-only.
- **Ruleset on `main`:** the App is a bypass actor, so its `chore(release)`
  changelog and manifest-version commit can be pushed directly. Humans still merge through PRs.
- **Loop guard:** the workflow skips runs triggered by the App's own push, so
  release commits never start a redundant release job.

## Retries and manual recovery

`scripts/release/release.sh` is idempotent. Re-running it never duplicates a
tag, changelog section, or asset, and it recovers a Release or assets that are
missing for the latest tag (for example after a failed upload). To retry, re-run
the failed workflow run; runs are serialized by a `concurrency` group.

- **Dry run:** run the workflow manually (it defaults to dry run) or run
  `scripts/release/release.sh --dry-run`. It prints the next version, the
  changelog diff, the planned manifest version syncs, and what it would tag or
  upload, without changing anything.
- **Manual release:** from an up-to-date `main` with `gh` authenticated and
  permission to push, run `scripts/release/release.sh`. If the workflow or App
  is unavailable, the packaging scripts in `scripts/` still build the ZIPs into
  `dist/` and can be attached to a Release with `gh release create`.
