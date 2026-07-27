# Packaging the Claude Skill

This document explains how to build the installable Interview Journey Claude Skill ZIP from `claude/skill/`. For what the package contains and why, see [`skill-manifest.md`](skill-manifest.md).

## Commands

### macOS / Linux

```bash
./scripts/package-claude-skill.sh
```

### Windows PowerShell

```powershell
.\scripts\package-claude-skill.ps1
```

Both scripts:

- Resolve all paths relative to their own location, so they work whether invoked from the repository root, from `scripts/`, or from any other working directory, including one outside the repository.
- Validate that `claude/skill/SKILL.md`, `claude/skill/references/`, and `claude/skill/templates/` exist before doing any packaging work, and fail with an actionable message if any are missing.
- Copy only the explicit package allowlist — `SKILL.md`, `references/`, `templates/` — into a dedicated staging directory. Neither script performs a recursive copy of the repository followed by exclusions; both start from an empty staging directory and add only allowed content.
- Wrap the staged content in a single top-level directory named `interview-journey/`.
- Strip platform artifacts (`.DS_Store`, `Thumbs.db`, `__MACOSX/`) if encountered in the source tree.
- Write the archive to `dist/interview-journey.skill.zip`, replacing any existing file at that path deterministically.
- Print the final package path and the packaged file list on success.
- Exit with a non-zero status and an actionable error message on failure.

## Expected output

```
dist/interview-journey.skill.zip
```

Containing exactly one top-level directory: `interview-journey/` — see [`skill-manifest.md#expected-zip-structure`](skill-manifest.md#expected-zip-structure) for the full file list.

## Cross-platform parity

The macOS/Linux script and the Windows script are logically equivalent — they share the output package filename, the top-level directory name inside the archive, the explicit package allowlist, the required-source validation checks, the exclusion of platform artifacts, their staging behavior, and the final logical file list inside the archive.

**ZIP byte hashes may legitimately differ between the two scripts and between runs on different operating systems.** What must match is the **normalized internal path list** and the **contents of each packaged file**.

## Validating a package

After running either script:

1. Unzip `dist/interview-journey.skill.zip` to a temporary location.
2. Confirm exactly one top-level directory exists: `interview-journey/`.
3. Confirm the internal file list matches the expected output in [`skill-manifest.md`](skill-manifest.md) exactly — no extra files, no missing files.
4. Confirm no forbidden files (see [`skill-manifest.md#intentionally-excluded-files`](skill-manifest.md#intentionally-excluded-files)) are present anywhere in the archive.
5. Spot-check that `SKILL.md` has valid frontmatter and that every file a reference links to under `references/` and `templates/` actually exists in the package.
6. Run the packaging command a second time and confirm the archive does not accumulate stale files from a previous run.

## Packaging the External Self-Install Kit

A second, separate archive — the External Kit — bundles the Skill ZIP above together with compact Project Instructions, a fixed Knowledge allowlist, and installation documentation, for distribution to users outside the creator's Claude organization. See [`external-install/package-manifest.md`](external-install/package-manifest.md) for its full structure.

### Commands

```bash
./scripts/package-claude-external-kit.sh
```

```powershell
.\scripts\package-claude-external-kit.ps1
```

Both scripts build the Skill ZIP first (by invoking `package-claude-skill.sh` / `.ps1`), then assemble `dist/interview-journey-claude-kit.zip` around it, using the same conventions as the Skill packager.

### The two archives are distinct

- `dist/interview-journey.skill.zip` — the Skill execution package. Install this as a Claude Skill.
- `dist/interview-journey-claude-kit.zip` — the distribution package for external self-install. It contains the Skill ZIP above (embedded, unchanged) plus Project Instructions, Knowledge, and setup documentation.
