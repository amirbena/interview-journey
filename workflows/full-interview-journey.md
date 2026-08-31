# Workflow: Full Interview Journey

The complete, ordered path from an initial candidate/role input to execution-ready preparation, per [Framework 15, Standard Workflow](../frameworks/15-interview-journey-intelligence-framework.md#standard-workflow) and [`core/workflow.md`](../core/workflow.md#full-interview-journey).

## Purpose

Run every framework the user's end-to-end request actually needs, in the canonical order, without forcing frameworks whose valid output already exists.

## Required Inputs

At least one of: a Job Description / target role description, a resume/background description, or an existing [Interview Journey State](../schemas/interview-journey-state.schema.md).

## Preconditions

None — a Full Interview Journey may start cold. Missing inputs reduce confidence and completeness (per [`core/evidence-policy.md`](../core/evidence-policy.md)) rather than blocking the journey.

## Procedure

1. Identify the user's objective (see [`core/orchestration-policy.md`](../core/orchestration-policy.md)).
2. Determine available inputs and existing Interview Journey State.
3. Run [Role Intelligence](analyze-role.md) if a Role Intelligence record does not already exist or is stale.
4. Run [Resume Intelligence](analyze-resume.md) if a Resume Intelligence record does not already exist or is stale.
5. Run [Identify Interview Stage](identify-interview-stage.md).
6. Run [Analyze Role Fit and Gaps](analyze-role-fit-and-gaps.md).
7. Run [Merge Interview Intelligence](merge-interview-intelligence.md) if any new interview evidence exists.
8. Run [Build Preparation Strategy](build-preparation-strategy.md).
9. Run [Predict Interview Questions](predict-interview-questions.md) when useful.
10. Run [Generate Interview Hypotheses](generate-interview-hypotheses.md) when useful.
11. Invoke the relevant execution workflow: [Coding](prepare-coding-interview.md), [System Design](prepare-system-design-interview.md), [Behavioral](prepare-behavioral-interview.md), or [Mock Interview](run-mock-interview.md).
12. Run [Coach Interview Answer](coach-interview-answer.md) if the user supplies an answer to review.
13. Run [Run Post-Interview Debrief](run-post-interview-debrief.md) after a completed interview.

## Outputs

Any subset of the sixteen canonical outputs in [`core/output-contracts.md`](../core/output-contracts.md), as actually produced by the stages run.

## State Updates

Update [Interview Journey State](../schemas/interview-journey-state.schema.md) statuses for every stage run.

## Quality Gates

Apply [`core/quality-gates.md`](../core/quality-gates.md) for each stage's specific output before presenting it.

## Uncertainty Handling

Mark any skipped stage as `Not Requested` rather than silently omitting it from the state.

## Explicit Non-Actions

- Do not run all fourteen frameworks unconditionally — see [Framework 15 IJ-002](../frameworks/15-interview-journey-intelligence-framework.md#guiding-principles).
- Do not re-analyze a raw resume or JD when valid Resume/Role Intelligence already exists.
- Do not perform background or scheduled research between conversations.

## Related documents

- [`../core/workflow.md`](../core/workflow.md)
- [`../core/orchestration-policy.md`](../core/orchestration-policy.md)
- [`focused-task-routing.md`](focused-task-routing.md)
- [`resume-interview-journey.md`](resume-interview-journey.md)
