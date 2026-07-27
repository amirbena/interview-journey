# Interview Process Schema

The Interview Process record captures the known or inferred stages of one specific hiring process — separate from the [Interview Stage record](interview-stage.schema.md), which describes where the candidate currently is within this process.

## Identity

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `company_name` | string | Required | | `"Northbridge Payments"` |
| `role_title` | string | Required | | `"Senior Backend Engineer"` |
| `process_source` | enum: `Recruiter Statement`, `Interview Invitation`, `Candidate Report`, `Unknown` | Required | | `"Recruiter Statement"` |

## Stages

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `known_stages` | ordered list of Stage objects | Optional | Each has: `stage_name` (from the enum in [`interview-stage.schema.md`](interview-stage.schema.md#stage)), `status` (`Upcoming`, `Completed`, `Unknown`), `date`, `confidence`. | `[{"stage_name":"Recruiter Screen","status":"Completed"}]` |
| `total_stages_confirmed` | boolean | Required | Whether the full stage count is confirmed or still partial. | `false` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `open_questions` | list of strings | Optional | e.g., "How many stages remain after the technical round?" | `[]` |
| `record_status` | enum: `Draft`, `Confirmed`, `Stale` | Required | | `"Draft"` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Interview Process Rules

1. Stage names/order are Confirmed only when explicitly stated by the candidate or recruiter.
2. Never invent an interview process not evidenced by a source (see [`core/evidence-policy.md`](../core/evidence-policy.md)).
3. Update incrementally — do not require the full process to be known before recording any stage.
4. A missing stage count does not block preparation for the next known stage.

## Related documents

- [`interview-stage.schema.md`](interview-stage.schema.md)
- [`interview-journey-state.schema.md`](interview-journey-state.schema.md)
- [`../outputs/interview-process-template.md`](../outputs/interview-process-template.md)
