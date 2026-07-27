# Workflow: Coach Interview Answer

Adapts [Framework 13 — Answer Coaching Framework](../frameworks/13-answer-coaching-framework.md) into a callable module.

## Purpose

Improve an already-submitted interview answer through structured, evidence-based coaching — without rewriting the candidate's actual experience.

## Required Inputs

A candidate-submitted answer (behavioral, technical explanation, or written response) to review.

## Preconditions

The answer itself must be supplied — this workflow does not generate a first draft from nothing.

## Procedure

Follow the [Review Workflow](../frameworks/13-answer-coaching-framework.md#review-workflow): read the answer → identify the interview objective → check whether the question was actually answered → evaluate structure → evaluate technical correctness → evaluate ownership → evaluate business impact → evaluate communication quality → suggest improvements → produce an improved version only if requested.

## Outputs

A [Candidate Answer](../schemas/candidate-answer.schema.md) coaching review, presented via [`outputs/answer-coaching-template.md`](../outputs/answer-coaching-template.md).

## State Updates

`answer_coaching_status` moves Not Started → Draft → Completed.

## Quality Gates

Apply the [Framework 13 Validation Checklist](../frameworks/13-answer-coaching-framework.md#validation-checklist) — feedback must be evidence-based and actionable; no fabricated experience.

## Uncertainty Handling

Explain *why* an answer is weak (AC-006) rather than only stating that it is weak.

## Explicit Non-Actions

- Never invent experiences or achievements to strengthen the answer (AC-001).
- Never produce a rewritten answer unless the user requests one (per Review Workflow step 10).

## Related documents

- [`../frameworks/13-answer-coaching-framework.md`](../frameworks/13-answer-coaching-framework.md)
- [`../schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md)
- [`prepare-behavioral-interview.md`](prepare-behavioral-interview.md)
