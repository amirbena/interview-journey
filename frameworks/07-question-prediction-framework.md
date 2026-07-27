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
- QP-006: Public reports of previous interview questions must never be presented as guaranteed future questions. One candidate report is weak evidence. Multiple recent independent reports may increase confidence but do not create certainty.
- QP-007: Company-wide engineering information must not be presented as interviewer-specific intent. An interviewer authoring a talk on distributed systems does not confirm that topic will appear in the interview.
- QP-008: When current company evidence is absent, label predictions as role-pattern based rather than company-specific. State the basis explicitly.
- QP-009: Stale or unknown-date research reduces confidence. When public research evidence is stale or has no `retrieved_at`, lower the prediction confidence and make the basis visible in the prediction rationale.
- QP-010: Interviewer public writing may suggest areas of technical interest, but must not be used to psychologically profile or manipulate — it informs preparation topics, not conversation tactics.
- QP-011: Predictions must remain professional and preparation-oriented. Do not infer personal motivations, biases, or interview styles beyond what evidence supports.

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
