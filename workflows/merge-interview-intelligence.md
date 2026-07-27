# Workflow: Merge Interview Intelligence

Adapts [Framework 05 — Interview Intelligence](../frameworks/05-interview-intelligence-framework.md) into a callable module.

## Purpose

Continuously enrich preparation with new recruiter, interviewer, and feedback evidence as it becomes available.

## Required Inputs

At least one new item: a recruiter conversation, a hiring-manager comment, a previous interview question, feedback, take-home assignment content, or a user observation.

## Preconditions

None — this workflow only runs when genuinely new evidence exists (per II-004); it must not re-run on unchanged evidence.

## Procedure

1. Capture the new evidence with its source and date.
2. Classify it (per [Framework 05 Sources](../frameworks/05-interview-intelligence-framework.md#sources)).
3. Update [Interview Hypotheses](generate-interview-hypotheses.md) affected by the new evidence.
4. Update [Question Predictions](predict-interview-questions.md) affected by the new evidence.
5. Update preparation priorities in the [Preparation Strategy](build-preparation-strategy.md).

## Outputs

An updated [Interview Intelligence](../schemas/interview-intelligence.schema.md) record.

## State Updates

`interview_intelligence_status` updates; `last_updated_at` refreshes; any downstream hypothesis/prediction/strategy statuses that changed are marked accordingly.

## Quality Gates

New evidence must override generic assumptions (II-001); chronology must be preserved (II-002).

## Uncertainty Handling

Never ignore recruiter hints (II-003), even weak ones — record them with appropriate confidence rather than discarding them.

## Explicit Non-Actions

- Never overwrite historical evidence entries — append, don't replace.
- Never fabricate recruiter statements, feedback, or previous questions not actually reported.

## Related documents

- [`../frameworks/05-interview-intelligence-framework.md`](../frameworks/05-interview-intelligence-framework.md)
- [`../schemas/interview-intelligence.schema.md`](../schemas/interview-intelligence.schema.md)
- [`generate-interview-hypotheses.md`](generate-interview-hypotheses.md)
- [`predict-interview-questions.md`](predict-interview-questions.md)
