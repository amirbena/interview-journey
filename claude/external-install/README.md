# Interview Journey — External Self-Install Kit

This kit lets someone outside the creator's Claude organization install Interview Journey as their own private Claude Project, using a single distributable archive.

## What's inside `dist/interview-journey-claude-kit.zip`

```
interview-journey-claude-kit/
  README.md
  installation-checklist.md
  knowledge-files.md
  conversation-starters.md
  verification-guide.md
  privacy-guide.md
  project-instructions.md          (compact instructions, copied byte-for-byte)
  skill/
    interview-journey.skill.zip     (the built Skill ZIP, embedded unchanged)
  knowledge/
    product-definition.md
    terminology.md
    scope-and-non-goals.md
    workflow.md
    orchestration-policy.md
    evidence-policy.md
    accuracy-policy.md
    context-priority.md
    quality-gates.md
    output-contracts.md
    offer-negotiation-preparation.md
    state-management.md
```

## Install flow

1. Unzip the kit.
2. Create your own Claude Project.
3. Install the Skill from `skill/interview-journey.skill.zip` into your Project.
4. Paste `project-instructions.md` into your Project's Instructions field.
5. Upload every file under `knowledge/` as Project Knowledge.
6. Optionally add your own resume, target-role JD, or in-progress Interview Journey State as private workspace files — never as shared Knowledge.
7. Start from one of the prompts in `conversation-starters.md`.
8. Run the smoke tests in `verification-guide.md` to confirm the Skill is active.

See [`installation-checklist.md`](installation-checklist.md) for the step-by-step checklist and [`privacy-guide.md`](privacy-guide.md) for what never belongs in a shared asset.

## Why this exists

Claude Project sharing is scoped to a single organization. Anyone outside that organization needs their own Skill installation and their own Project — this kit packages everything required to do that without needing access to this source repository.
