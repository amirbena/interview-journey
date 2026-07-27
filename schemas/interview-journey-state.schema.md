# Interview Journey State Schema

The Interview Journey State record is a logical representation of a candidate's overall preparation journey, based on the context available to the running platform. It exists to prevent unnecessary repetition and to support resuming work within the context the platform makes available. See [`core/state-management.md`](../core/state-management.md) for the governing principles and [Context Boundary](../core/state-management.md#context-boundary).

Interview Journey State is not a storage mechanism and is not guaranteed to survive across conversations.

## Identity

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `journey_id` | string | Required | A logical identifier for this journey. | `"journey-2026-07-20-dana-levi-northbridge"` |
| `candidate_reference` | string | Optional | Reference to the candidate's identity or profile. | `"Dana Levi"` |
| `target_company` | string | Optional | | `"Northbridge Payments"` |
| `target_role` | string | Optional | | `"Senior Backend Engineer"` |
| `created_at` | timestamp | Required | | `"2026-07-10T09:00:00Z"` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T10:30:00Z"` |

## Current Status

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `journey_mode` | enum: `Full Interview Journey`, `Focused Task`, `Resume Interview Journey` | Required | | `"Focused Task"` |
| `overall_status` | enum: `Not Started`, `In Progress`, `Blocked`, `Completed`, `Stale` | Required | | `"In Progress"` |
| `current_interview_stage` | reference to [`interview-stage.schema.md`](interview-stage.schema.md) | Optional | | `"System Design"` |

## Framework Statuses

Each framework status uses: `Not Started`, `Draft`, `Completed`, `Confirmed`, `Stale`, `Not Requested`.

| Field | Type | Required | Description |
|---|---|---|---|
| `role_intelligence_status` | enum | Required | Status of Framework 01 output. |
| `resume_intelligence_status` | enum | Required | Status of Framework 02 output. |
| `interview_stage_status` | enum | Required | Status of Framework 03 output. |
| `fit_gap_analysis_status` | enum | Required | Status of Framework 04 output. |
| `interview_intelligence_status` | enum | Required | Status of Framework 05 output. |
| `preparation_strategy_status` | enum | Required | Status of Framework 06 output. |
| `question_prediction_status` | enum | Required | Status of Framework 07 output. |
| `interview_hypothesis_status` | enum | Required | Status of Framework 08 output. |
| `coding_preparation_status` | enum | Required | Status of Framework 09 output(s). |
| `system_design_preparation_status` | enum | Required | Status of Framework 10 output(s). |
| `behavioral_preparation_status` | enum | Required | Status of Framework 11 output(s). |
| `mock_interview_status` | enum | Required | Status of Framework 12 output(s). |
| `answer_coaching_status` | enum | Required | Status of Framework 13 output(s). |
| `post_interview_debrief_status` | enum | Required | Status of Framework 14 output(s). |

Framework names align with [`core/workflow.md#frameworks`](../core/workflow.md#frameworks).

## Recurring Signals

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `recurring_strengths` | list of strings | Optional | Aggregated across debriefs, per [Framework 14 Trend Detection](../frameworks/14-post-interview-debrief-framework.md#trend-detection). | `["Strong coding performance"]` |
| `recurring_weaknesses` | list of strings | Optional | | `["System Design repeatedly weak on failure handling"]` |

## Progress and Continuation

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `completed_stages` | list of strings | Optional | | `["Recruiter Screen"]` |
| `upcoming_stage` | string | Optional | | `"System Design"` |
| `next_actions` | ordered list of strings | Optional | | `["Run a system design mock interview"]` |
| `open_questions` | list of strings | Optional | | `[]` |
| `refresh_required` | boolean | Optional | | `false` |
| `refresh_reason` | string | Optional | | `""` |

## Interview Journey State Rules

1. Confirmed work should not be repeated automatically.
2. A focused task should execute only the required frameworks.
3. A resumed journey should begin from the latest valid state.
4. Interview intelligence may become stale independently of Role/Resume Intelligence.
5. A single new piece of evidence should not invalidate unrelated, stable candidate facts.
6. A framework may be `Not Requested` without blocking the journey.
7. No state value may imply scheduled or background monitoring.
8. Every refresh follows an explicit user request.
9. Superseded records must not silently replace confirmed records without traceability.
10. Real candidate data must never be written into shared repository files — see [`core/state-management.md`](../core/state-management.md#context-boundary).

## Example Record

```text
journey_id: "journey-2026-07-20-dana-levi-northbridge"
target_company: "Northbridge Payments"
target_role: "Senior Backend Engineer"
journey_mode: "Focused Task"
overall_status: "In Progress"
role_intelligence_status: "Confirmed"
resume_intelligence_status: "Confirmed"
interview_stage_status: "Confirmed"
system_design_preparation_status: "Draft"
upcoming_stage: "System Design"
```

## Related documents

- [`../core/state-management.md`](../core/state-management.md)
- [`../core/workflow.md`](../core/workflow.md)
- [`../workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md)
- [`../outputs/interview-journey-state-template.md`](../outputs/interview-journey-state-template.md)
