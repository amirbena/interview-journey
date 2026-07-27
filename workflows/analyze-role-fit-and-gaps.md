# Workflow: Analyze Role Fit and Gaps

Adapts [Framework 04 — Role Fit & Gap Analysis](../frameworks/04-role-fit-gap-analysis-framework.md) into a callable module.

## Purpose

Compare what the company needs (Role Intelligence) with what the candidate can demonstrate (Resume Intelligence).

## Required Inputs

[Role Intelligence](../schemas/role-intelligence.schema.md) and [Resume Intelligence](../schemas/resume-intelligence.schema.md) — see [Framework 04 Inputs](../frameworks/04-role-fit-gap-analysis-framework.md#inputs).

## Optional Inputs

Interview Stage, recruiter information, interview feedback, user clarifications.

## Preconditions

Both required inputs must exist or be reasonably derivable from the current conversation; if either is entirely absent, run [Analyze Role](analyze-role.md) and/or [Analyze Resume](analyze-resume.md) first rather than guessing.

## Procedure

Follow the [Matching Process](../frameworks/04-role-fit-gap-analysis-framework.md#matching-process): load Critical/High role requirements → load candidate capabilities → match capabilities → measure evidence strength → detect missing evidence → score each gap → prioritize preparation.

## Outputs

A [Fit & Gap Analysis](../schemas/fit-gap-analysis.schema.md) record, presented via [`outputs/role-fit-gap-analysis-template.md`](../outputs/role-fit-gap-analysis-template.md).

## State Updates

`fit_gap_analysis_status` moves Not Started → Draft → Confirmed.

## Quality Gates

Apply the [Framework 04 Validation Checklist](../frameworks/04-role-fit-gap-analysis-framework.md#validation-checklist).

## Uncertainty Handling

Missing evidence is not proof of missing ability (GAP-003) — mark as Unknown rather than as a Gap when evidence is merely absent from the resume but plausible.

## Explicit Non-Actions

- Never rewrite the resume or generate interview answers here.
- Never require exact technology matches when a transferable capability exists (see Transferable Skills).

## Related documents

- [`../frameworks/04-role-fit-gap-analysis-framework.md`](../frameworks/04-role-fit-gap-analysis-framework.md)
- [`analyze-role.md`](analyze-role.md)
- [`analyze-resume.md`](analyze-resume.md)
- [`build-preparation-strategy.md`](build-preparation-strategy.md)
