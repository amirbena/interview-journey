# Workflow: Identify Interview Stage

Adapts [Framework 03 — Interview Stage Intelligence](../frameworks/03-interview-stage-framework.md) into a callable module.

## Purpose

Determine where the candidate currently is in a specific hiring process and adapt preparation priorities accordingly.

## Required Inputs

Any recruiter/interviewer statement, calendar invitation, or candidate report referencing the process — per [Framework 03 Stage Signals](../frameworks/03-interview-stage-framework.md#stage-signals).

## Preconditions

None — if no stage signal exists, the stage is `Unknown` and the workflow proceeds with reduced interview-focus precision rather than blocking (per ISI-002).

## Procedure

1. Scan available evidence for stage signals (e.g., "live coding" → Coding; "architecture interview" → System Design).
2. Assign the current stage from the [Supported Stages](../frameworks/03-interview-stage-framework.md#supported-stages) enum with a confidence label.
3. Derive stage objectives, expected evaluation areas, preparation priorities, and likely questions per [Stage Objectives](../frameworks/03-interview-stage-framework.md#stage-objectives).
4. Incorporate any previous interview feedback relevant to this stage.

## Outputs

An [Interview Stage](../schemas/interview-stage.schema.md) record.

## State Updates

`interview_stage_status` moves Not Started → Draft → Confirmed; `current_interview_stage` updates on the Interview Journey State.

## Quality Gates

Apply the [Framework 03 Validation Checklist](../frameworks/03-interview-stage-framework.md#validation-checklist).

## Uncertainty Handling

If the stage is unknown, ask only if it materially changes the preparation (ISI-002) — otherwise proceed generically and label the limitation.

## Explicit Non-Actions

- Do not invent an interview process not evidenced by a source.
- Do not override a confirmed stage with a generic company pattern (ISI-003).

## Related documents

- [`../frameworks/03-interview-stage-framework.md`](../frameworks/03-interview-stage-framework.md)
- [`../schemas/interview-stage.schema.md`](../schemas/interview-stage.schema.md)
- [`../schemas/interview-process.schema.md`](../schemas/interview-process.schema.md)
