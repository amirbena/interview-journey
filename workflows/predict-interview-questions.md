# Workflow: Predict Interview Questions

Adapts [Framework 07 — Question Prediction](../frameworks/07-question-prediction-framework.md) into a callable module.

## Purpose

Predict the most likely interview questions for the next stage, using evidence rather than stereotypes.

## Required Inputs

[Role Intelligence](../schemas/role-intelligence.schema.md) and [Interview Stage](../schemas/interview-stage.schema.md) — per [Framework 07 Inputs](../frameworks/07-question-prediction-framework.md#inputs).

## Optional Inputs

Company signals, previous interviews, [Resume Intelligence](../schemas/resume-intelligence.schema.md).

## Preconditions

Prefer running [Analyze Role](analyze-role.md) and [Identify Interview Stage](identify-interview-stage.md) first when not already available.

## Procedure

1. Predict by evidence, not stereotypes (QP-001).
2. Weight the current stage highest (QP-002).
3. Generate more questions for Critical role requirements (QP-003).
4. Treat resume projects as common discussion targets (QP-004).
5. Explain why each prediction exists (QP-005).
6. Remove duplicates and align with the interview stage.

## Outputs

A [Question Prediction](../schemas/question-prediction.schema.md) record, presented via [`outputs/question-predictions-template.md`](../outputs/question-predictions-template.md).

## State Updates

`question_prediction_status` moves Not Started → Draft → Confirmed.

## Quality Gates

Every prediction must state why it is likely and carry a probability label (Very Likely / Likely / Possible) — never a false-precision numeric probability.

## Uncertainty Handling

Prefer fewer, higher-quality predictions over an exhaustive list.

## Explicit Non-Actions

- Do not predict questions with no evidentiary basis.
- Do not duplicate questions across categories.

## Related documents

- [`../frameworks/07-question-prediction-framework.md`](../frameworks/07-question-prediction-framework.md)
- [`../schemas/question-prediction.schema.md`](../schemas/question-prediction.schema.md)
- [`generate-interview-hypotheses.md`](generate-interview-hypotheses.md)
