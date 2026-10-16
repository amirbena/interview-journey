# Packaging and Delivery Rules

Detailed cross-package delivery, Claude Skill/Project/external-kit,
ChatGPT packaging, and data-privacy rules. Moved verbatim from
`AGENTS.md`; the entry point is [../AGENTS.md](../AGENTS.md).

## Cross-package delivery

The methodology is distributed through three supported package surfaces:
the ChatGPT Plugin, the Claude Skill (and Claude Plugin), and the Claude Project.
The ChatGPT Custom GPT is deprecated and transitional (see below).

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

- `skills/interview-journey/` is the single canonical, installable Skill source. Claude marketplace, `npx skills`, Codex, and the Skill ZIP all consume it directly; no symlinks, copies, or generation layer.
- The Claude description in `skills/interview-journey/SKILL.md` must not exceed 2,400 characters. Validate generated or edited description content before completion. This ceiling is not a target; when shortening is necessary, remove duplication with canonical framework and Knowledge files before weakening required behavior.
- `core/`, `frameworks/`, `schemas/`, `workflows/`, and `outputs/` remain canonical — the Skill adapts them, it does not redefine them.
- Packaging uses an explicit allowlist (`SKILL.md`, `references/`, `templates/`), never a recursive repository copy followed by exclusions.
- Never recursively package the whole repository.
- The macOS/Linux and Windows packaging scripts must remain logically equivalent (same allowlist, same output filename, same top-level directory, same normalized file list).
- Real candidate data and the synthetic example must never enter the Skill ZIP.
- Packaging scripts must work when invoked from outside the repository root.
- Every Skill change must validate package contents before completion.

## Plugin and marketplace rules

- `.claude-plugin/marketplace.json` and `.claude-plugin/plugin.json` point at `./skills/interview-journey`; validate with `claude plugin validate .`.
- Plugin packagers (`package-claude-plugin`, `package-chatgpt-plugin`) use explicit allowlists, keep Bash/PowerShell parity, and accept an optional `RELEASE_VERSION`; unset keeps the committed manifest version.
- Document an install command as working only after verifying it; label the rest unverified in `docs/installation.md`.

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

- `chatgpt/instructions.md` is the single canonical ChatGPT behavior source, written platform-neutrally (it refers to bundled "reference files", not to Custom GPT fields or attached Knowledge). The ChatGPT Plugin is the primary target; the Custom GPT is deprecated, kept only as a temporary migration safeguard until the plugin is verified, and must not be extended or gain separately maintained instructions.
- Deployment-ready Custom GPT Instructions must not exceed 8,000 characters. Validate generated or edited Instructions before completion. This ceiling is not a target; when shortening is necessary, remove duplication with canonical Knowledge and framework files before weakening required behavior.
- GPT Instructions define behavior; Knowledge defines reference material.
- Generated Knowledge bundles must not be edited manually — rebuild them with the build scripts.
- Knowledge bundles derive only from explicit canonical source allowlists.
- Keep the Knowledge file count small — it is the manual publish-step count, since no supported OpenAI API deploys Custom GPT Knowledge. Every canonical `core/`, `frameworks/`, and referenced schema/workflow source must map to exactly one bundle.
- Each generated bundle carries a deterministic provenance header (bundle position, ordered source list, and a `Content-Digest`). The digest normalization contract — identical in the Bash and PowerShell builders — is: sha256 over the ordered concatenation of each source's raw bytes with every CR (`0x0D`) removed, nothing else added or removed (final-LF presence preserved). The digest must depend only on source content, so rebuilds stay byte-identical across platforms. `tests/validate-repository.sh` rebuilds the bundles into a throwaway directory and fails on any byte difference, checks the normalization rule against edge-case fixtures, and compares Bash vs PowerShell output when `pwsh` is available.
- The ChatGPT packaging script emits `deployment-release.json` (repository commit, `git describe`, commit date, per-bundle digests; UTF-8 without BOM from either builder) into the archive. It is a generated build artifact, never hand-edited or committed.
- `chatgpt/publishing-knowledge.md` is the authoritative publish procedure and record of supported vs unsupported deployment mechanisms; keep it in sync with the scripts.
- Do not upload the synthetic example or personal records as shared GPT Knowledge.
- The GPT must not claim unavailable memory, browsing, storage, or automation.
- A ChatGPT Plugin is allowed only as a skills-only package: `plugin.json`, one `SKILL.md`, and `references/` assembled from canonical `chatgpt/` sources (generated Knowledge bundles, `capability-policy.md`). It must contain no MCP servers, Actions, Apps (`.app.json`), hooks, external APIs, or background automation, and no duplicated Knowledge bundles. The Custom GPT package is retained only until the plugin is verified, then removed.
- Actions, Apps, external APIs, monitoring, and automated outreach/scheduling remain out of scope.
- macOS/Linux and Windows builders and packagers must remain logically equivalent.

## Data and privacy rules

- Use synthetic data only in any example or test fixture.
- Never place real candidate, role, interviewer, or recruiter data in repository files.
- Document assumptions explicitly when source information is incomplete.
