# Output Contracts

This document defines the canonical outputs produced by Interview Journey, downstream of the [frameworks](../frameworks/), the [schemas](../schemas/), the [workflow](workflow.md), and the [quality gates](quality-gates.md). Each output has a dedicated template in [`outputs/`](../outputs/).

## Canonical outputs

At least the following sixteen outputs are defined. Each entry states purpose, required inputs, required sections, confirmed-versus-inferred handling, update behavior, validation rules, when it should be persisted, and when it should not be generated.

### 1. Role Intelligence
- **Purpose:** Present the structured hiring-intent analysis of a target role.
- **Required inputs:** A Job Description, Role Intelligence artifact, or substantial recruiter description (see [Framework 01, Section 5](../frameworks/01-role-intelligence-framework.md#5-required-inputs)).
- **Required sections:** See [Framework 01, Section 7](../frameworks/01-role-intelligence-framework.md#7-required-output-schema) and [`outputs/role-intelligence-template.md`](../outputs/role-intelligence-template.md).
- **Confirmed vs inferred:** Every conclusion carries a confidence label; the Hiring Hypothesis is explicitly inference.
- **Update behavior:** Re-run only when the role, JD, or company context materially changes — not on every request.
- **Validation:** [Framework 01 Validation Checklist](../frameworks/01-role-intelligence-framework.md#30-validation-checklist).
- **Persist when:** The user is analyzing a specific target role they intend to interview for.
- **Do not generate when:** The user's request does not involve a specific role (e.g., a pure coding drill unrelated to any target role).

### 2. Resume Intelligence
- **Purpose:** Present what the candidate can actually demonstrate.
- **Required inputs:** A resume, LinkedIn export, portfolio, or equivalent (see [Framework 02](../frameworks/02-resume-intelligence-framework.md#inputs)).
- **Required sections:** [`outputs/resume-intelligence-template.md`](../outputs/resume-intelligence-template.md).
- **Confirmed vs inferred:** Capability depth and ownership level are inferences from resume evidence; must remain labeled as such.
- **Update behavior:** Refresh only when the resume changes or new evidence is supplied.
- **Validation:** [Framework 02 Validation Checklist](../frameworks/02-resume-intelligence-framework.md#validation-checklist).
- **Persist when:** A resume or equivalent background has been supplied.
- **Do not generate when:** No resume or background evidence exists yet — ask, do not fabricate.

### 3. Interview Process Map
- **Purpose:** Capture the known or inferred stages of this specific hiring process.
- **Required inputs:** Recruiter communication, interview invitations, or user-reported stages.
- **Required sections:** [`outputs/interview-process-template.md`](../outputs/interview-process-template.md).
- **Confirmed vs inferred:** Stage names/order are Confirmed only when explicitly stated; otherwise labeled Reasonable inference or Unknown.
- **Update behavior:** Update incrementally as new stages are confirmed.
- **Persist when:** More than one interview stage is known or expected.
- **Do not generate when:** Only a single, immediate task is requested with no broader process context.

### 4. Interview Stage
- **Purpose:** Identify where the candidate is right now and the stage's objectives.
- **Required sections:** [Framework 03, Required Output](../frameworks/03-interview-stage-framework.md#required-output).
- **Validation:** [Framework 03 Validation Checklist](../frameworks/03-interview-stage-framework.md#validation-checklist).

### 5. Role Fit & Gap Analysis
- **Purpose:** Compare Role Intelligence against Resume Intelligence.
- **Required inputs:** Role Intelligence and Resume Intelligence (see [Framework 04](../frameworks/04-role-fit-gap-analysis-framework.md#inputs)).
- **Required sections:** [`outputs/role-fit-gap-analysis-template.md`](../outputs/role-fit-gap-analysis-template.md).
- **Validation:** [Framework 04 Validation Checklist](../frameworks/04-role-fit-gap-analysis-framework.md#validation-checklist).
- **Do not generate when:** Either Role Intelligence or Resume Intelligence is entirely absent and cannot be reasonably inferred from the conversation.

### 6. Interview Intelligence
- **Purpose:** Continuously enrich preparation using new interview evidence.
- **Required sections:** [Framework 05, Output](../frameworks/05-interview-intelligence-framework.md#output).
- **Update behavior:** Append new evidence; never overwrite prior evidence (see [Framework 05 Rule II-005](../frameworks/05-interview-intelligence-framework.md#rules)).

### 7. Preparation Strategy
- **Purpose:** The shortest, highest-impact preparation plan for the user's stated objective.
- **Required sections:** [`outputs/preparation-strategy-template.md`](../outputs/preparation-strategy-template.md).
- **Validation:** User objective must control scope (see [Framework 06 Rule PS-001](../frameworks/06-preparation-strategy-framework.md#rules)).

### 8. Question Predictions
- **Purpose:** Evidence-based likely questions for the next interview.
- **Required sections:** [`outputs/question-predictions-template.md`](../outputs/question-predictions-template.md).
- **Validation:** [Framework 07 Validation rules](../frameworks/07-question-prediction-framework.md#validation).

### 9. Interview Hypotheses
- **Purpose:** A small set of testable claims about what the interviewer is trying to validate.
- **Required sections:** [`outputs/interview-hypotheses-template.md`](../outputs/interview-hypotheses-template.md).
- **Validation:** [Framework 08 Validation Checklist](../frameworks/08-interview-hypothesis-framework.md#validation-checklist).

### 10. Coding Preparation Session
- **Purpose:** Guided practice, simulation, review, or full explanation for a coding problem.
- **Required sections:** [Framework 09, Section 21](../frameworks/09-coding-interview-decision-engine.md#21-required-outputs) and [`outputs/coding-preparation-template.md`](../outputs/coding-preparation-template.md).
- **Do not generate when:** The user has not supplied or requested a specific coding problem, topic, or code to review.

### 11. System Design Preparation
- **Purpose:** Guided practice, simulation, review, or walkthrough for a system-design problem.
- **Required sections:** [`outputs/system-design-preparation-template.md`](../outputs/system-design-preparation-template.md).
- **Validation:** [Framework 10 Validation Checklist](../frameworks/10-system-design-framework.md#validation-checklist).

### 12. Behavioral Story Map
- **Purpose:** A reusable map of the candidate's real stories against behavioral competencies.
- **Required sections:** [`outputs/behavioral-story-map-template.md`](../outputs/behavioral-story-map-template.md).
- **Validation:** [Framework 11 Validation Checklist](../frameworks/11-behavioral-interview-framework.md#validation-checklist).

### 13. Mock Interview Scorecard
- **Purpose:** The result of a simulated interview session.
- **Required sections:** [`outputs/mock-interview-scorecard-template.md`](../outputs/mock-interview-scorecard-template.md).
- **Do not generate when:** No mock interview was actually run in the current conversation.

### 14. Answer Coaching Review
- **Purpose:** Structured feedback on a submitted answer.
- **Required sections:** [`outputs/answer-coaching-template.md`](../outputs/answer-coaching-template.md).
- **Do not generate when:** No candidate answer was supplied to review.

### 15. Post-Interview Debrief
- **Purpose:** Structured learning from a completed interview.
- **Required sections:** [`outputs/post-interview-debrief-template.md`](../outputs/post-interview-debrief-template.md).
- **Do not generate when:** No interview has actually occurred yet.

### 16. Offer and Negotiation Preparation
- **Purpose:** Prepare an evidence-grounded compensation position and natural responses for an offer or negotiation conversation.
- **Required inputs:** Explicit offer/compensation intent plus enough known role, market, employer-range, or candidate-priority context to make a useful recommendation. No individual context field is universally mandatory.
- **Required sections:** Context and assumptions; attributable market evidence; Target range; Preferred outcome; Fallback or provisional decision rule; reasoning and total-compensation trade-offs; relevant natural spoken answers; material risks/unknowns. See [`offer-negotiation-preparation.md`](offer-negotiation-preparation.md) and [`outputs/offer-negotiation-preparation-template.md`](../outputs/offer-negotiation-preparation-template.md).
- **Confirmed vs inferred:** User/employer facts, sourced market evidence, and assumptions remain distinct. Every material market row preserves figure/range, population/context, source, and retrieval date. Public evidence never becomes Confirmed candidate/employer fact merely because it is published.
- **Update behavior:** Refresh when the offer, employer range, candidate priorities, comparable evidence, or material package terms change.
- **Validation:** Apply the canonical [Offer and Negotiation Preparation checklist](offer-negotiation-preparation.md#validation-checklist).
- **Do not generate when:** The request is unrelated to compensation or offer preparation.

### Interview Journey State
- **Purpose:** The running, logical record of a candidate's preparation journey.
- **Required sections:** [`outputs/interview-journey-state-template.md`](../outputs/interview-journey-state-template.md) and [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md).
- **Update behavior:** Updated after any meaningful new evidence or completed stage — see [`state-management.md`](state-management.md).

## Universal rules

1. Produce only the outputs the user's objective actually requires — see [`orchestration-policy.md`](orchestration-policy.md).
2. Use Unknown rather than inventing a value.
3. Confidence must remain claim-specific, never blanket.
4. Do not dump every intermediate analysis when the user asked for a focused result.
5. Every output's lifecycle status (Draft, Confirmed, Stale) must remain visible on the output itself.
6. Output generation creates no new evidence — it packages evidence already gathered.
7. A partial output must be clearly labeled as partial.
8. Match the user's requested output depth (Quick, Standard, Professional) — see [Framework 15, Output Modes](../frameworks/15-interview-journey-intelligence-framework.md#output-modes).

## Related documents

- [`workflow.md`](workflow.md)
- [`quality-gates.md`](quality-gates.md)
- [`state-management.md`](state-management.md)
- [`../outputs/`](../outputs/)
- [`../schemas/`](../schemas/)
