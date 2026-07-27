# Workflow: Analyze Role

Adapts [Framework 01 — Role Intelligence Decision Engine](../frameworks/01-role-intelligence-framework.md) into a callable module.

## Purpose

Produce a [Role Intelligence](../schemas/role-intelligence.schema.md) record from the strongest available role evidence.

## Required Inputs

At least one of: a Role Intelligence artifact, a Job Description, or a substantial recruiter description — per [Framework 01 §5.2](../frameworks/01-role-intelligence-framework.md#52-minimum-input-set).

## Optional Inputs

Current interview stage, recruiter/interviewer intelligence, company/team information, previous interview questions or feedback, take-home assignment content.

## Preconditions

None. Classify [Input Completeness](../frameworks/01-role-intelligence-framework.md#53-input-completeness-classification) and reduce confidence accordingly when inputs are weak.

## Procedure

Follow the [Mandatory Analysis Sequence](../frameworks/01-role-intelligence-framework.md#8-mandatory-analysis-sequence) exactly: parse sources → extract evidence → tag evidence → detect contradictions → identify business context → generate hiring hypothesis → classify archetype → assess seniority → extract outcomes/technical/behavioral expectations → assess ownership → assess complexity → score requirements → predict interview focus → identify risks → generate preparation implications → validate → assign confidence → present.

## Outputs

A [Role Intelligence](../schemas/role-intelligence.schema.md) record, presented via [`outputs/role-intelligence-template.md`](../outputs/role-intelligence-template.md) at the requested output depth (Quick/Standard/Professional).

## State Updates

`role_intelligence_status` moves Not Started → Draft → Confirmed.

## Quality Gates

Apply the [Framework 01 Validation Checklist](../frameworks/01-role-intelligence-framework.md#30-validation-checklist) before presenting.

## Uncertainty Handling

Under Failure Modes A–H (see [Framework 01 §28](../frameworks/01-role-intelligence-framework.md#28-failure-modes)), proceed with a labeled, reduced-confidence analysis rather than blocking.

## Explicit Non-Actions

- Do not perform full candidate matching here — that belongs to [Analyze Role Fit and Gaps](analyze-role-fit-and-gaps.md).
- Do not generate preparation recommendations before the role has been analyzed (RI-007).
- Do not invent an interview process not evidenced by a source.

## Related documents

- [`../frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
- [`../schemas/role-intelligence.schema.md`](../schemas/role-intelligence.schema.md)
- [`analyze-role-fit-and-gaps.md`](analyze-role-fit-and-gaps.md)
