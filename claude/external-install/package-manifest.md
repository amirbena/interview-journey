# External Kit Package Manifest

Describes the exact contents of `dist/interview-journey-claude-kit.zip`, built by `scripts/package-claude-external-kit.sh` (or `.ps1`).

## Package identity

- **Package name:** `interview-journey-claude-kit`
- **Top-level directory inside the ZIP:** `interview-journey-claude-kit/`

## Included files (explicit allowlist)

```
interview-journey-claude-kit/
  README.md                          (from claude/external-install/README.md)
  installation-checklist.md          (from claude/external-install/installation-checklist.md)
  knowledge-files.md                 (from claude/external-install/knowledge-files.md)
  conversation-starters.md           (from claude/external-install/conversation-starters.md)
  verification-guide.md              (from claude/external-install/verification-guide.md)
  privacy-guide.md                   (from claude/external-install/privacy-guide.md)
  project-instructions.md            (from claude/project-instructions.compact.md, byte-for-byte)
  skill/
    interview-journey.skill.zip      (the built Skill ZIP, embedded unchanged)
  knowledge/
    product-definition.md            (from core/product-definition.md)
    terminology.md                   (from core/terminology.md)
    scope-and-non-goals.md           (from core/scope-and-non-goals.md)
    workflow.md                      (from core/workflow.md)
    orchestration-policy.md          (from core/orchestration-policy.md)
    evidence-policy.md               (from core/evidence-policy.md)
    accuracy-policy.md               (from core/accuracy-policy.md)
    context-priority.md              (from core/context-priority.md)
    quality-gates.md                 (from core/quality-gates.md)
    output-contracts.md              (from core/output-contracts.md)
    state-management.md              (from core/state-management.md)
```

## Intentionally excluded

- `.git/`, `.DS_Store`, `Thumbs.db`, `__MACOSX/`
- `examples/synthetic-candidate/` (a repository development asset, never shipped in the kit)
- `frameworks/`, `schemas/`, `workflows/`, `outputs/` (covered in depth by the Skill ZIP already embedded; not duplicated separately as flat Knowledge here beyond the eleven `core/` files above)
- `tests/`, `scripts/`, `.build/`, any previous `*.zip` output
- Any real candidate, role, or interviewer data

## Build order

1. `package-claude-skill.sh` (or `.ps1`) builds `dist/interview-journey.skill.zip`.
2. `package-claude-external-kit.sh` (or `.ps1`) validates all required sources, rebuilds the Skill ZIP, and assembles the kit archive around it in a dedicated staging directory.

## Validation

After building, unzip the kit and confirm: exactly one top-level directory; the file list matches this manifest exactly; `skill/interview-journey.skill.zip` is present and itself valid (see [`../skill-manifest.md`](../skill-manifest.md)); `project-instructions.md` matches `claude/project-instructions.compact.md` byte-for-byte; every `knowledge/` file matches its canonical `core/` source byte-for-byte; no personal data or forbidden files are present.
