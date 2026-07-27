# Workflow: Prepare Coding Interview

Adapts [Framework 09 — Coding Interview Decision Engine](../frameworks/09-coding-interview-decision-engine.md) into a callable module.

## Purpose

Run coding-interview preparation, simulation, evaluation, or coaching using the deterministic decision engine in Framework 09.

## Required Inputs

At least one of: a coding problem, a target coding interview, a requested algorithmic topic, a request for mock coding practice, or candidate code for review — per [Framework 09 §4.1](../frameworks/09-coding-interview-decision-engine.md#41-minimum-inputs).

## Optional Inputs

Role seniority, interview stage, target language, company style, known weak areas, previous feedback, candidate hint preference — per [Framework 09 §4.2](../frameworks/09-coding-interview-decision-engine.md#42-contextual-inputs).

## Preconditions

Prefer Role Intelligence, Resume Intelligence, Interview Stage, and Fit & Gap Analysis already available (per the `01 → 02 → 03 → 04 → 06 → 09` route in [`core/orchestration-policy.md`](../core/orchestration-policy.md#objective-routing-table)) to calibrate difficulty and relevance; a standalone coding drill may still proceed without them.

## Procedure

1. Select the operating mode per [Framework 09 §4.3 Missing Input Rules](../frameworks/09-coding-interview-decision-engine.md#43-missing-input-rules) and [§23 Deterministic Decision Summary](../frameworks/09-coding-interview-decision-engine.md#23-deterministic-decision-summary).
2. Calibrate difficulty per [§10 Difficulty Calibration Engine](../frameworks/09-coding-interview-decision-engine.md#10-difficulty-calibration-engine).
3. Move through the [Standard Problem-Solving State Machine](../frameworks/09-coding-interview-decision-engine.md#6-standard-problem-solving-state-machine) (States 1–10) inside Guided Practice or Interview Simulation.
4. Apply the [Hint Escalation Engine](../frameworks/09-coding-interview-decision-engine.md#9-hint-escalation-engine) one level at a time when blocked.
5. On a submitted solution, apply the [Candidate Evaluation Rubric](../frameworks/09-coding-interview-decision-engine.md#11-candidate-evaluation-rubric) and [Error Classification Engine](../frameworks/09-coding-interview-decision-engine.md#13-error-classification-engine).

## Outputs

A [Candidate Answer](../schemas/candidate-answer.schema.md) record (`answer_domain: Coding`), presented via [`outputs/coding-preparation-template.md`](../outputs/coding-preparation-template.md), in the required output shape (Guided Practice / Full Explanation / Review / Practice Plan per [Framework 09 §21](../frameworks/09-coding-interview-decision-engine.md#21-required-outputs)).

## State Updates

`coding_preparation_status` moves Not Started → Draft → Completed.

## Quality Gates

Apply the [Framework 09 Validation Checklist](../frameworks/09-coding-interview-decision-engine.md#22-validation-checklist) — dry run and complexity are mandatory before a solution is considered complete.

## Uncertainty Handling

If target language or difficulty is missing, apply the [Missing Input Rules](../frameworks/09-coding-interview-decision-engine.md#43-missing-input-rules) rather than blocking.

## Explicit Non-Actions

- Never dump a full solution outside Full Explanation mode or an explicit user request (AP-001).
- Never behave as both interviewer and tutor unless Coaching Interview mode is explicitly selected (CI-010).
- Never penalize valid non-idiomatic syntax as a seniority failure (AP-008).

## Related documents

- [`../frameworks/09-coding-interview-decision-engine.md`](../frameworks/09-coding-interview-decision-engine.md)
- [`../schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md)
- [`coach-interview-answer.md`](coach-interview-answer.md)
- [`run-mock-interview.md`](run-mock-interview.md)
