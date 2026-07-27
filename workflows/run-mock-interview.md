# Workflow: Run Mock Interview

Adapts [Framework 12 — Mock Interview Framework](../frameworks/12-mock-interview-framework.md) into a callable module.

## Purpose

Simulate a realistic interview tailored to the specific role, stage, candidate background, and preparation objective, using evidence from Documents 01–11 rather than generic random questions.

## Required Inputs

An explicit request to run a mock interview and a selected mode: Full Interview, Coaching Interview, Lightning Round, Deep Dive, Executive Interview, or Panel Interview.

## Optional Inputs

Role Intelligence, Resume Intelligence, Interview Stage, Fit & Gap Analysis, Interview Intelligence, Question Predictions, Interview Hypotheses.

## Preconditions

Prefer the full `01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 12` route from [`core/orchestration-policy.md`](../core/orchestration-policy.md#objective-routing-table) so questions are evidence-driven rather than generic (MI-003).

## Procedure

1. Confirm the session mode and interview flow (Greeting → Introduction → Warm-up → Core interview → Deep follow-ups → Candidate questions → End → Evaluation).
2. Behave like the interviewer unless Coaching Interview mode was explicitly selected (MI-001).
3. Ask one question at a time, escalate follow-up depth per performance, and never reveal remaining questions (MI-004, MI-007).
4. Provide feedback after each answer only in Coaching Interview mode; otherwise defer feedback to the end (MI-008).
5. Score the session using the [Evaluation Rubric](../frameworks/12-mock-interview-framework.md#evaluation-rubric).

## Outputs

A [Mock Interview Session](../schemas/mock-interview-session.schema.md) record, presented via [`outputs/mock-interview-scorecard-template.md`](../outputs/mock-interview-scorecard-template.md).

## State Updates

`mock_interview_status` moves Not Started → Draft → Completed.

## Quality Gates

Apply the [Framework 12 Validation Checklist](../frameworks/12-mock-interview-framework.md#validation-checklist) — questions matched role and stage, difficulty appropriate, feedback evidence-based.

## Uncertainty Handling

If Role/Resume Intelligence or Interview Intelligence is unavailable, run with available context and disclose that questions are more generic than an evidence-driven session would produce.

## Explicit Non-Actions

- Never reveal remaining questions mid-session.
- Never inflate scores or ignore weak answers.
- Never coach during the answer unless Coaching Interview mode is explicitly selected.

## Related documents

- [`../frameworks/12-mock-interview-framework.md`](../frameworks/12-mock-interview-framework.md)
- [`../schemas/mock-interview-session.schema.md`](../schemas/mock-interview-session.schema.md)
- [`generate-interview-hypotheses.md`](generate-interview-hypotheses.md)
- [`predict-interview-questions.md`](predict-interview-questions.md)
