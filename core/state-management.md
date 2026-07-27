# State Management

This document defines the canonical Interview Journey State model and its context boundary, adapted from the [Career Targeting Intelligence data-model pattern](../README.md#core-architectural-principle) and specialized for Interview Journey. It is platform-independent — see [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md) for the full field list.

## What the state preserves

- Candidate identity or profile reference.
- Current target company and role.
- Role Intelligence and Resume Intelligence (or references to them).
- Current interview stage, known interview process, completed stages, upcoming stage.
- Recruiter signals and interviewer signals.
- Previous questions, previous answers, previous feedback.
- Current fit strengths and gaps.
- Preparation priorities, question predictions, interview hypotheses.
- Completed practice and mock interview evaluations.
- Debrief findings, recurring strengths, recurring weaknesses.
- Next actions.
- Freshness/update metadata.

## Confirmed vs. inferred vs. open

The state must distinguish:

- **Confirmed facts** — directly stated by the candidate or a supplied document.
- **User observations** — the candidate's own subjective account of what happened.
- **Inferred conclusions** — model-derived interpretations, always labeled as such.
- **Open questions** — unresolved items that would materially change preparation if answered.
- **Outdated intelligence** — evidence whose relevance has expired (e.g., a resume version since updated, or interview feedback superseded by a later stage).

## Supported operations

The product must support:

- Start a new journey.
- Resume an existing journey.
- Run one focused task.
- Update an existing journey with new evidence.
- Debrief a completed interview.
- Prepare for the next stage.

See [`workflow.md`](workflow.md) for how these map to operating modes, and [`../workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md) for the resume procedure.

## Context boundary

Interview Journey State is a **logical** record, not a storage mechanism.

- No background automation or hidden persistent data storage is implemented or implied by this specification.
- State is represented explicitly through user-provided files, Project Knowledge, conversation context, or generated artifacts — never through an undocumented backend.
- The product may use prior context only when the running platform (Claude Project, ChatGPT conversation, uploaded file) actually makes that context available.
- When no prior context is available, the product proceeds as a fresh journey or focused task instead of pretending to remember one.
- Personal candidate information must never be written into shared repository files, shared Skill/Knowledge assets, or Golden Journey examples — see [`examples/synthetic-candidate/`](../examples/synthetic-candidate/) for the only permitted (fully synthetic) worked example.

## Rules

1. Use all relevant information already available in the active context.
2. Do not ask again for information already available in that context.
3. Explicit user corrections override model inference — see [`context-priority.md`](context-priority.md).
4. Do not claim access to context the platform has not provided.
5. Do not promise automatic memory or persistence.
6. Do not place real user records inside shared prompts, Skills, Knowledge assets, examples, or repository documentation.
7. Shared product assets define logic and methodology only.
8. Platform-specific adapters may describe how users supply context, but may not redefine the canonical state model.
9. Absence of prior context does not block a focused task when the user supplies sufficient input.
10. No state rule may imply background monitoring or scheduled execution.

## Related documents

- [`context-priority.md`](context-priority.md)
- [`workflow.md`](workflow.md)
- [`../schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md)
- [`../workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md)
