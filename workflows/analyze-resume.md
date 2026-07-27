# Workflow: Analyze Resume

Adapts [Framework 02 — Resume Intelligence Engine](../frameworks/02-resume-intelligence-framework.md) into a callable module.

## Purpose

Produce a [Resume Intelligence](../schemas/resume-intelligence.schema.md) record describing what the candidate can actually demonstrate.

## Required Inputs

A resume, LinkedIn export, portfolio, GitHub profile, or project documentation — per [Framework 02 Inputs](../frameworks/02-resume-intelligence-framework.md#inputs).

## Preconditions

None. If only a partial background is supplied, proceed with reduced confidence and explicit Unknowns rather than blocking.

## Procedure

Follow the [Resume Analysis Workflow](../frameworks/02-resume-intelligence-framework.md#resume-analysis-workflow): parse work experience → extract projects → extract measurable achievements → identify ownership → group technologies into capabilities → estimate capability depth → detect production experience → detect leadership signals → detect business impact → detect resume risks → generate Resume Intelligence.

## Outputs

A [Resume Intelligence](../schemas/resume-intelligence.schema.md) record, presented via [`outputs/resume-intelligence-template.md`](../outputs/resume-intelligence-template.md).

## State Updates

`resume_intelligence_status` moves Not Started → Draft → Confirmed.

## Quality Gates

Apply the [Framework 02 Validation Checklist](../frameworks/02-resume-intelligence-framework.md#validation-checklist).

## Uncertainty Handling

Unknown is preferred over guessing (RIE-005) — mark ambiguous ownership or depth as Unknown rather than assuming the strongest interpretation.

## Explicit Non-Actions

- Do not rewrite or "improve" the resume text — this workflow only analyzes it.
- Do not invent experience, projects, or metrics not present in the source.
- Do not compare against a role here — that belongs to [Analyze Role Fit and Gaps](analyze-role-fit-and-gaps.md).

## Related documents

- [`../frameworks/02-resume-intelligence-framework.md`](../frameworks/02-resume-intelligence-framework.md)
- [`../schemas/resume-intelligence.schema.md`](../schemas/resume-intelligence.schema.md)
- [`analyze-role-fit-and-gaps.md`](analyze-role-fit-and-gaps.md)
