# Workflow: Prepare System Design Interview

Adapts [Framework 10 — System Design Interview Framework](../frameworks/10-system-design-framework.md) into a callable module.

## Purpose

Prepare the candidate to solve system-design interviews through a structured, requirement-driven process, in Guided Practice, Interview Simulation, Design Review, or Full Walkthrough mode.

## Required Inputs

A system-design problem or target scenario, or an existing design to review.

## Optional Inputs

Role Intelligence (for seniority and complexity calibration), Interview Stage, known gaps.

## Preconditions

Prefer the `01 → 02 → 03 → 04 → 06 → 10` route from [`core/orchestration-policy.md`](../core/orchestration-policy.md#objective-routing-table) when preparing for a specific target role; a standalone design drill may proceed without it.

## Procedure

Follow the [Standard Design Sequence](../frameworks/10-system-design-framework.md#standard-design-sequence): clarify the problem → functional requirements → non-functional requirements → scale estimation where useful → APIs/contracts → data model → simplest high-level design → trace main flow → identify bottlenecks → add patterns to solve named bottlenecks → failure handling → consistency/concurrency → scaling → observability → trade-off summary.

## Outputs

A [Candidate Answer](../schemas/candidate-answer.schema.md) record (`answer_domain: System Design`), presented via [`outputs/system-design-preparation-template.md`](../outputs/system-design-preparation-template.md).

## State Updates

`system_design_preparation_status` moves Not Started → Draft → Completed.

## Quality Gates

Apply the [Framework 10 Validation Checklist](../frameworks/10-system-design-framework.md#validation-checklist) — every major component must have a named reason; trade-offs must be explicit.

## Uncertainty Handling

State assumptions explicitly (SD-002) when requirement information is missing, rather than blocking the design.

## Explicit Non-Actions

- Do not jump directly to complex architecture (SD-003).
- Do not treat a named technology as architecture justification (SD-009).
- Do not perform scale calculations when scale is not relevant (SD-008).

## Related documents

- [`../frameworks/10-system-design-framework.md`](../frameworks/10-system-design-framework.md)
- [`../schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md)
- [`coach-interview-answer.md`](coach-interview-answer.md)
- [`run-mock-interview.md`](run-mock-interview.md)
