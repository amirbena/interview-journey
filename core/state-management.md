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
- Offer/negotiation context and the latest preparation position when relevant, including employer range, candidate priorities, total-compensation terms, and freshness of material market evidence.
- Freshness/update metadata.

## Offer and negotiation state lifecycle

The optional `offer_negotiation_preparation` object in the canonical [Interview Journey State schema](../schemas/interview-journey-state.schema.md#offer-and-negotiation-preparation-state) is the compact state representation for canonical invariant `ONP-010`. It stores a reference/provenance summary and the latest decision-relevant position; it is not a second copy of the full preparation output.

- **No preparation:** `offer_negotiation_preparation_status` is absent (for backward-compatible older state), `Not Requested`, or `Not Started`; the object may be absent. An absent status must be interpreted as `Not Requested`, never as completed work.
- **In progress:** status is `Draft`; the object may be partial and must expose material open questions.
- **Reusable:** status is `Completed` or `Confirmed`, the referenced artifact/context is available, and none of the recorded invalidation inputs has materially changed. Reuse it and skip rebuilding the preparation unless the user requests a refresh.
- **Material change:** a changed employer range or package terms, candidate priorities, Target/Preferred/Fallback inputs, role/market context, or newer conflicting evidence makes the negotiation preparation `Stale`. Preserve the prior artifact reference and state why refresh is required rather than silently overwriting it.
- **Evidence aging:** compare `market_evidence_retrieved_at` and `market_evidence_freshness` with the decision being made. When evidence is no longer sufficiently current or comparable, mark the preparation `Stale` or refresh the evidence-dependent portion; do not invalidate unrelated confirmed candidate facts.

An updated artifact may return the status to `Draft`, `Completed`, or `Confirmed` only after recording refreshed provenance and `last_updated_at`.

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
