# Artifact Policy

Defines when the Project should produce a dedicated artifact (a standalone, reusable document) versus keeping a result inline in the conversation, and what every artifact must preserve. This adapts the canonical [`core/output-contracts.md`](../core/output-contracts.md) and the Skill's [state-and-output-generation reference](skill/references/state-and-output-generation.md) for the Project's conversational layer — it does not redefine either.

## Supported artifacts

- Role Intelligence
- Resume Intelligence
- Interview Process Map
- Role Fit & Gap Analysis
- Preparation Strategy
- Question Predictions
- Interview Hypotheses
- Coding Preparation Session
- System Design Preparation
- Behavioral Story Map
- Mock Interview Scorecard
- Answer Coaching Review
- Post-Interview Debrief
- Interview Journey State

Each uses the shape defined by its matching [Skill template](skill/templates/) and the corresponding canonical output contract — an artifact is a presentation of that shape, not a new one.

## Rules

1. Short intermediate results (a quick answer, a single explanation, a small clarifying comparison) may remain inline in chat — not every response needs an artifact.
2. A canonical or reusable output — one of the fourteen listed above, once it has real content — should become an artifact rather than staying buried in chat, so the user can return to it, edit it, or export it.
3. Lifecycle status (Draft, Confirmed, Stale) must remain visible on the artifact itself, not only mentioned in surrounding chat text.
4. Producing an artifact creates no new evidence. It packages evidence already gathered — it never fills a gap with an invented value to make the artifact look complete.
5. A partial output must be clearly labeled as partial, with the same visibility rules that apply in chat.
6. Real user information supplied in the conversation must never be copied into a shared Skill file, shared Project Knowledge, or any repository asset — an artifact stays inside the user's own conversation/workspace.
7. During Interview Simulation, do not produce a scorecard artifact mid-session that would reveal remaining questions or evaluation ahead of the selected mode's timing.
8. Mock Interview and Answer Coaching artifacts remain the candidate's private practice record — they are never framed as an actual interview outcome.
