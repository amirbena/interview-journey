# Workflow: Run Post-Interview Debrief

Adapts [Framework 14 — Post-Interview Debrief Framework](../frameworks/14-post-interview-debrief-framework.md) into a callable module.

## Purpose

Turn a completed interview into structured learning that improves preparation for the next one.

## Required Inputs

A report from the candidate of a completed interview: at minimum company, role, stage, and what was asked/discussed.

## Preconditions

The interview must have actually occurred — this workflow does not run pre-interview.

## Procedure

Follow the [Debrief Workflow](../frameworks/14-post-interview-debrief-framework.md#debrief-workflow): collect interview information → identify interview stage → record questions asked → record candidate answers → record difficult areas → record interviewer reactions → identify recurring themes → update Interview Intelligence → update Preparation Strategy.

Apply [Root Cause Analysis](../frameworks/14-post-interview-debrief-framework.md#root-cause-analysis) to every weakness, avoiding generic conclusions.

## Outputs

An [Interview Debrief](../schemas/interview-debrief.schema.md) record, presented via [`outputs/post-interview-debrief-template.md`](../outputs/post-interview-debrief-template.md), plus updates to [Interview Intelligence](../schemas/interview-intelligence.schema.md) and [Preparation Strategy](../schemas/preparation-strategy.schema.md).

## State Updates

`post_interview_debrief_status` moves Not Started → Draft → Completed; `interview_intelligence_status` and `preparation_strategy_status` update accordingly; `completed_stages` and `recurring_weaknesses`/`recurring_strengths` on the Interview Journey State update.

## Quality Gates

Apply the [Framework 14 Validation Checklist](../frameworks/14-post-interview-debrief-framework.md#validation-checklist) — facts separated from assumptions, root causes specific, lessons reusable.

## Uncertainty Handling

Never assume rejection reasons without evidence (PD-005) — if the outcome is unknown, say so explicitly.

## Explicit Non-Actions

- Never invent interviewer reactions the candidate did not report.
- Never silently discard a previous debrief — preserve historical interview data (PD-006).

## Related documents

- [`../frameworks/14-post-interview-debrief-framework.md`](../frameworks/14-post-interview-debrief-framework.md)
- [`../schemas/interview-debrief.schema.md`](../schemas/interview-debrief.schema.md)
- [`merge-interview-intelligence.md`](merge-interview-intelligence.md)
- [`build-preparation-strategy.md`](build-preparation-strategy.md)
