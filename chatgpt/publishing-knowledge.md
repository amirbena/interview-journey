# Publishing Knowledge to the Custom GPT

The authoritative, reproducible procedure for updating the live Interview
Journey Custom GPT's Knowledge from repository-generated artifacts. The
repository is the source of truth; the live GPT is a deployment target.

## Supported capabilities and limitations

Researched against OpenAI's GPT documentation, Help Center, and developer
community (current as of 2026-08).

- **No supported programmatic deployment exists.** OpenAI exposes no API,
  CLI, connector, or deploy hook that creates or updates a Custom GPT or its
  Knowledge files. Custom GPTs are built and edited only in the ChatGPT GPT
  editor. The editor is the only supported surface.
- **The Assistants API / Responses API `file_search` + vector stores are a
  different product.** They attach retrieval files to *your own* API
  assistants/responses. They do not read or write a Custom GPT's Knowledge,
  so they are not a deployment path for this GPT. (The Assistants API is also
  scheduled for retirement on 2026-08-26.)
- **GPT Actions are outbound only** — the GPT calling an external API. They
  cannot push Knowledge into a GPT and are out of scope for this package.
- **Undocumented ChatGPT web-app endpoints** (e.g. `backend-api/gizmos/...`)
  can edit a GPT, but they are private, unversioned, authentication-fragile,
  and Terms-of-Service-risky. This repository does not use or depend on them.
- **Browser automation** of the GPT editor is intentionally not provided. It
  is brittle against ChatGPT UI changes and is a non-goal for this project.

**Consequence:** the final publish step is manual. The workflow's job is to
make that step as small, deterministic, and verifiable as the platform
allows — three files, stable names, content-digest verification, and a
recorded commit.

## What the build produces

`scripts/build-chatgpt-knowledge.sh` (or `.ps1`) regenerates exactly three
Knowledge bundles under `chatgpt/knowledge/`:

1. `01-product-orchestration-and-quality.md`
2. `02-role-resume-and-strategy.md`
3. `03-interview-execution.md`

Each bundle begins with a deterministic provenance header: its position
(`Bundle: … (n of 3)`), its ordered source list, and a
`Content-Digest (sha256 of concatenated LF-normalized sources)`. The digest
depends only on source content, so an unchanged methodology rebuilds to
byte-identical bundles. See [`knowledge-manifest.md`](knowledge-manifest.md)
for the full bundle-to-source mapping.

`scripts/package-chatgpt-gpt.sh` (or `.ps1`) rebuilds the bundles, assembles
`dist/interview-journey-chatgpt.zip`, and adds `deployment-release.json` at
the package root:

```json
{
  "package": "interview-journey-chatgpt",
  "repository": { "commit": "…", "describe": "…", "commit_date": "…" },
  "packaged_at": "…",
  "knowledge_bundles": [
    { "file": "knowledge/01-product-orchestration-and-quality.md",
      "content_digest_sha256": "…",
      "sources": ["core/product-definition.md", "…"] }
  ]
}
```

`repository.commit` is the repository version the package represents.
`packaged_at` is wall-clock and informational only — the release identity is
the commit plus the per-bundle digests.

## Publish procedure

1. From a clean checkout at the commit you intend to ship:

   ```bash
   ./scripts/package-chatgpt-gpt.sh
   ```

   ```powershell
   .\scripts\package-chatgpt-gpt.ps1
   ```

2. Record `repository.commit` and the three `content_digest_sha256` values
   from `dist/interview-journey-chatgpt/deployment-release.json` (the script
   also prints them as a deployment checklist).

3. In the ChatGPT GPT editor → **Configure** → **Knowledge**:
   - Remove the three existing Knowledge files.
   - Upload the three files from
     `dist/interview-journey-chatgpt/knowledge/` (filenames are stable across
     builds, so the set to remove and the set to add always match by name).

4. Confirm the editor lists exactly those three filenames and nothing else,
   then **Save** / **Update** and **Publish** at the existing visibility
   (see [`sharing-and-publishing.md`](sharing-and-publishing.md)).

5. Record the deployed `repository.commit` where your team tracks releases
   (the PR description or a `CHANGELOG.md` entry). This is what makes the
   live GPT's version knowable.

## Verifying what is deployed

- Open any Knowledge file in the GPT editor and read its
  `Content-Digest` header line. Match it against
  `deployment-release.json` from the packaged build, or find the commit
  directly:

  ```bash
  git log -S "<digest>" -- chatgpt/knowledge/
  ```

- If a digest does not match any committed build, the live GPT is carrying a
  hand-edited or stale bundle and should be re-published from a fresh
  package.

## Multi-package release compatibility

This is the ChatGPT leg of the repository's three-package release model
alongside the Claude Skill (`dist/interview-journey.skill.zip`) and the
Claude Project / external kit (`dist/interview-journey-claude-kit.zip`).
Build all three from the same commit to keep them aligned; the
`repository.commit` in `deployment-release.json` is the shared anchor for a
coordinated release.

## Related documents

- [`builder-setup.md`](builder-setup.md)
- [`builder-config.md`](builder-config.md)
- [`knowledge-manifest.md`](knowledge-manifest.md)
- [`package-manifest.md`](package-manifest.md)
- [`sharing-and-publishing.md`](sharing-and-publishing.md)
