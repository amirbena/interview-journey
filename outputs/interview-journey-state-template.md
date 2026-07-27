# Interview Journey State Template

Markdown presentation template for the Interview Journey State output, built from an [Interview Journey State record](../schemas/interview-journey-state.schema.md) per [`core/state-management.md`](../core/state-management.md). All values below are synthetic.

## Disclaimer

> This state is a snapshot of the current conversation/workspace context, not a guarantee of cross-conversation memory. See [Context Boundary](../core/state-management.md#context-boundary).

## Required Sections

Identity, Current Status, Framework Statuses, Recurring Signals, Progress and Continuation.

## Synthetic Example

```text
journey_id: "journey-2026-07-20-dana-levi-northbridge"
target_company: "Northbridge Payments"
target_role: "Senior Backend Engineer"
journey_mode: "Focused Task"
overall_status: "In Progress"
role_intelligence_status: "Confirmed"
resume_intelligence_status: "Confirmed"
interview_stage_status: "Confirmed"
fit_gap_analysis_status: "Confirmed"
system_design_preparation_status: "Draft"
upcoming_stage: "System Design"
next_actions:
  - "Run a system design mock interview"
```

## Related documents

- [`../schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md)
- [`../core/state-management.md`](../core/state-management.md)
- [`../workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md)
