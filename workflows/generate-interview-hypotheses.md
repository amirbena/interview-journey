# Workflow: Generate Interview Hypotheses

Adapts [Framework 08 — Interview Hypothesis](../frameworks/08-interview-hypothesis-framework.md) into a callable module.

## Purpose

Convert Role Intelligence, Resume Intelligence, Interview Stage, and Interview Intelligence into a small set of testable hypotheses about what the interviewer is most likely trying to validate.

## Required Inputs

The highest-priority role requirements, the current interview stage, the candidate's strongest evidence, known gaps and open questions, and recruiter/interviewer signals — per [Framework 08 Hypothesis Workflow](../frameworks/08-interview-hypothesis-framework.md#hypothesis-workflow).

## Preconditions

At minimum, [Role Intelligence](../schemas/role-intelligence.schema.md) should exist; richer inputs (Resume Intelligence, Interview Intelligence) sharpen the hypotheses but are not strictly required.

## Procedure

1. Load the highest-priority role requirements.
2. Load the current interview stage.
3. Load the candidate's strongest evidence.
4. Load known gaps and open questions.
5. Load recruiter and interviewer signals.
6. Generate candidate hypotheses.
7. Rank by relevance and evidence.
8. Keep only the strongest hypotheses.
9. Convert them into preparation actions.

## Outputs

An [Interview Hypothesis](../schemas/interview-hypothesis.schema.md) record, presented via [`outputs/interview-hypotheses-template.md`](../outputs/interview-hypotheses-template.md).

## State Updates

`interview_hypothesis_status` moves Not Started → Draft → Confirmed.

## Quality Gates

Every hypothesis must be evidence-backed and stage-specific; weak duplicates removed; uncertainty visible (per the [Framework 08 Validation Checklist](../frameworks/08-interview-hypothesis-framework.md#validation-checklist)).

## Uncertainty Handling

Prefer fewer high-value hypotheses over many weak ones (IH-002).

## Explicit Non-Actions

- Do not present hypotheses as facts.
- Do not invent an interview process to justify a hypothesis.

## Related documents

- [`../frameworks/08-interview-hypothesis-framework.md`](../frameworks/08-interview-hypothesis-framework.md)
- [`../schemas/interview-hypothesis.schema.md`](../schemas/interview-hypothesis.schema.md)
- [`predict-interview-questions.md`](predict-interview-questions.md)
- [`run-mock-interview.md`](run-mock-interview.md)
