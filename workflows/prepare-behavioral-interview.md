# Workflow: Prepare Behavioral Interview

Adapts [Framework 11 — Behavioral Interview Framework](../frameworks/11-behavioral-interview-framework.md) into a callable module.

## Purpose

Help the candidate communicate real experience clearly and convincingly across behavioral competencies, without inventing stronger stories.

## Required Inputs

Resume Intelligence or a description of real candidate projects/experiences, from which stories are discovered — per [Framework 11 Story Discovery Process](../frameworks/11-behavioral-interview-framework.md#story-discovery-process).

## Optional Inputs

Role Intelligence's behavioral expectations (to prioritize which competencies matter most), Interview Stage.

## Preconditions

Prefer the `01 → 02 → 03 → 04 → 06 → 11` route from [`core/orchestration-policy.md`](../core/orchestration-policy.md#objective-routing-table); Resume Intelligence in particular should exist before story discovery begins.

## Procedure

1. Build a reusable evidence library: for every project, extract Situation, Technical challenge, Business challenge, ownership, decisions, obstacles, trade-offs, collaboration, result, and lessons learned.
2. Structure answers with STAR+ (Situation, Task, Actions, Results, Reflection, Future improvement).
3. Map competencies to stories per [Behavioral Competencies](../frameworks/11-behavioral-interview-framework.md#behavioral-competencies), reusing one strong story across multiple competencies where appropriate (Story Mapping).
4. Apply the [Story Quality Checklist](../frameworks/11-behavioral-interview-framework.md#story-quality-checklist) and challenge weak or unsupported stories (BI-007).

## Outputs

A [Candidate Answer](../schemas/candidate-answer.schema.md) record (`answer_domain: Behavioral`) and a Behavioral Story Map, presented via [`outputs/behavioral-story-map-template.md`](../outputs/behavioral-story-map-template.md).

## State Updates

`behavioral_preparation_status` moves Not Started → Draft → Completed.

## Quality Gates

Apply the [Framework 11 Validation Checklist](../frameworks/11-behavioral-interview-framework.md#validation-checklist) — every story must be real, ownership clear, results measurable where claimed, reflection present.

## Uncertainty Handling

When a competency has no strong supporting story, report it as a Missing Story rather than fabricating one.

## Explicit Non-Actions

- Never fabricate projects, leadership, failures, or impact (BI-002).
- Never avoid discussing real mistakes — Failure stories are required content, not optional polish.

## Related documents

- [`../frameworks/11-behavioral-interview-framework.md`](../frameworks/11-behavioral-interview-framework.md)
- [`../schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md)
- [`coach-interview-answer.md`](coach-interview-answer.md)
