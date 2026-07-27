# Question Prediction Framework

**Document ID:** 07 | **Depends on:** 01–06

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

## Purpose
Predict the most likely interview questions.

## Inputs
- Role Intelligence
- Interview Stage
- Company signals
- Previous interviews
- Resume Intelligence

## Rules
- QP-001: Predict by evidence, not stereotypes.
- QP-002: Current stage has highest weight.
- QP-003: Critical role requirements generate more questions.
- QP-004: Resume projects are common discussion targets.
- QP-005: Explain why each prediction exists.

## Categories
- Resume
- Coding
- System Design
- Architecture
- Behavioral
- Domain
- Company
- Leadership

## Output
For each prediction:
- Question
- Why it is likely
- Probability (Very Likely / Likely / Possible)
- Preparation Focus

See [`schemas/question-prediction.schema.md`](../schemas/question-prediction.schema.md) and [`workflows/predict-interview-questions.md`](../workflows/predict-interview-questions.md).

## Validation
- Remove duplicate questions.
- Align with interview stage.
- Prioritize evidence-backed predictions.

## Principle
Predict fewer, higher-quality questions instead of exhaustive lists.

## Related documents

- [`08-interview-hypothesis-framework.md`](08-interview-hypothesis-framework.md)
- [`05-interview-intelligence-framework.md`](05-interview-intelligence-framework.md)
