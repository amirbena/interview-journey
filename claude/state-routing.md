# State Routing

Defines how the Project uses available active context — conversation history, uploaded files, and any Interview Journey State the user supplies — to decide what to run and what to reuse. This adapts the Skill's [product-and-orchestration reference](skill/references/product-and-orchestration.md) and the canonical [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md) for the Project's conversational layer; it does not redefine either.

## Rules

1. Use information already available in the current conversation, uploaded files, or Project context. Do not re-derive what is already stated.
2. Do not ask again for information already available.
3. An explicit user correction overrides prior inference, even if the inference came from the same conversation.
4. Do not claim access to prior conversations, external accounts, or monitoring data that were not actually supplied in the active context.
5. Resume only from an Interview Journey State actually present in the active context (pasted, uploaded, or otherwise supplied this conversation). Never assume one exists because a prior journey seems likely.
6. After a single new piece of evidence (e.g., a stage change, one piece of interviewer feedback), run only the frameworks that evidence actually affects — not the whole journey.
7. Refresh stale interview intelligence (recruiter signals, feedback, previous questions) without rebuilding stable candidate facts (resume capabilities, seniority) that have not changed.
8. A focused task may proceed without a full saved journey when the user's current message supplies sufficient input on its own (for example, "review this coding answer" needs no prior Role Intelligence to answer).

## Routing table

| Situation | Routing |
|---|---|
| New user, no prior context, role/resume pasted or described | Full Interview Journey or Focused Task per the request — start with Role/Resume Intelligence if the request implies more than one stage |
| Existing (in-context) Role/Resume Intelligence, stage just changed | Focused Task: Identify Interview Stage → reuse existing Role Fit & Gap Analysis if still valid → Build Preparation Strategy for the new stage |
| Role and Resume Intelligence already provided, requesting a gap analysis | Focused Task: Analyze Role Fit and Gaps, reusing the existing records |
| "Why is this a Critical requirement?" | Explain the existing Role Intelligence scoring — no framework re-run |
| One new piece of interview intelligence (a recruiter comment, a piece of feedback) | Merge Interview Intelligence only, then update only the affected hypotheses/predictions/priorities — not the whole journey |
| User asks to run a mock interview | Run Mock Interview, reusing Role Intelligence, Resume Intelligence, Fit & Gap Analysis, and Interview Intelligence if already available |
| User reports a completed interview | Run Post-Interview Debrief — no other framework re-run unless the debrief itself surfaces new evidence that should feed forward |

This table mirrors the Skill's [routing table](skill/references/product-and-orchestration.md#objective-routing-table) at the conversational-request level; it does not add new routing logic the Skill doesn't already define.
