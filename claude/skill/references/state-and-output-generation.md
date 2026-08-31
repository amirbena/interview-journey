# State and Output Generation

Canonical sources: [`core/state-management.md`](../../../core/state-management.md), [`core/output-contracts.md`](../../../core/output-contracts.md), [`schemas/interview-journey-state.schema.md`](../../../schemas/interview-journey-state.schema.md), [`outputs/`](../../../outputs/).

## Interview Journey State

Preserves: candidate identity/profile reference, current target company/role, Role and Resume Intelligence, current interview stage, known process, completed/upcoming stages, recruiter/interviewer signals, previous questions/answers/feedback, current fit strengths/gaps, preparation priorities, question predictions, interview hypotheses, completed practice, mock interview evaluations, debrief findings, recurring strengths/weaknesses, relevant offer/negotiation context and position, next actions, freshness metadata.

Distinguishes: Confirmed facts, User observations, Inferred conclusions, Open questions, Outdated intelligence.

Supports: Start a new journey, Resume an existing journey, Run one focused task, Update an existing journey with new evidence, Debrief a completed interview, Prepare for the next stage.

No background automation or hidden persistent data storage — state is represented explicitly through user-provided files, Project Knowledge, conversation context, or generated artifacts.

## Canonical outputs

Sixteen canonical outputs are defined in [`core/output-contracts.md`](../../../core/output-contracts.md), including Offer and Negotiation Preparation, plus the Interview Journey State itself. Use [`offer-and-negotiation-preparation.md`](offer-and-negotiation-preparation.md) and [`../templates/offer-negotiation-preparation.md`](../templates/offer-negotiation-preparation.md) for that output; do not reconstruct its field rules here.

## Universal output rules

Produce only the outputs the user's objective actually requires. Use Unknown rather than inventing a value. Confidence stays claim-specific. Every output's lifecycle status (Draft, Confirmed, Stale) stays visible on the output itself. Output generation creates no new evidence. A partial output must be clearly labeled as partial. Match the user's requested output depth (Quick, Standard, Professional).
