# Knowledge Manifest

Defines what should be connected or uploaded as Project Knowledge for the Interview Journey Claude Project, and what should not.

## Recommended shared knowledge

These files hold the platform-independent methodology and are safe to share across every user of a Project built on this repository. Connect them as read-only shared Knowledge:

- [`core/product-definition.md`](../core/product-definition.md)
- [`core/terminology.md`](../core/terminology.md)
- [`core/scope-and-non-goals.md`](../core/scope-and-non-goals.md)
- [`core/workflow.md`](../core/workflow.md)
- [`core/orchestration-policy.md`](../core/orchestration-policy.md)
- [`core/evidence-policy.md`](../core/evidence-policy.md)
- [`core/accuracy-policy.md`](../core/accuracy-policy.md)
- [`core/context-priority.md`](../core/context-priority.md)
- [`core/quality-gates.md`](../core/quality-gates.md)
- [`core/output-contracts.md`](../core/output-contracts.md)
- [`core/offer-negotiation-preparation.md`](../core/offer-negotiation-preparation.md)
- [`core/state-management.md`](../core/state-management.md)
- All fifteen files in [`frameworks/`](../frameworks/)
- [`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)
- [`workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md)

## What Project Knowledge is for

Project Knowledge is a second, optional channel for the same canonical methodology already present in the installed Skill — useful on surfaces where Knowledge retrieval and Skill execution complement each other, or where a user wants the underlying rules visible and citable in chat. It is not a replacement for the Skill, and it is not a place for personal data.

- **Do not duplicate the Skill package wholesale into Project Knowledge.** The Skill (`claude/skill/`) is the execution methodology layer — it already adapts these canonical files for progressive, in-conversation use. Uploading the entire Skill package as Knowledge on top of installing it as a Skill creates redundant, potentially divergent copies of the same rules.
- Project Knowledge contains shared methodology only — never personal candidate, role, or interviewer records.
- Private user context may be added by the user to their own Project's Knowledge (for example, their own resume) — that is the user's choice for their own workspace, not something this manifest recommends by default or something a shared/team Project should include.
- Do not assume every Knowledge file is loaded into every response. Treat Knowledge the same way the Skill treats its own references: consult what the current request actually needs.
- The Skill remains the execution methodology layer — the source of routing, field lists, and output contracts. Knowledge supplements it; it does not supersede it.

## Optional private workspace files

A user may choose to add their own in-progress preparation artifacts to their own Project as private context, so a conversation can resume from them. These are user-specific, never shared, and never checked into this repository:

- `role-intelligence.md`
- `resume-intelligence.md`
- `interview-process.md`
- `interview-journey-state.md`
- `preparation-strategy.md`
- `mock-interview-scorecard.md`
- `post-interview-debrief.md`

## Privacy and retention

Privacy and retention for both shared Knowledge and any private workspace files are controlled by the underlying Claude platform and by the Project owner's configuration — not by this repository or by the Skill. This manifest recommends what to connect and what to keep private; it does not implement, guarantee, or override the platform's actual storage or access controls.
