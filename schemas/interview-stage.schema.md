# Interview Stage Schema

The Interview Stage record is the structured output of [Framework 03](../frameworks/03-interview-stage-framework.md). It describes where the candidate is right now in a specific hiring process.

## Stage

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `current_stage` | enum: `Recruiter / HR Screen`, `Hiring Manager`, `Technical Coding`, `Practical Coding / Pair Programming`, `System Design`, `Behavioral`, `Technical Deep Dive`, `Take-Home Assignment`, `Final Interview`, `Executive Interview`, `Offer Stage`, `Unknown` | Required | Per [Framework 03 Supported Stages](../frameworks/03-interview-stage-framework.md#supported-stages). | `"System Design"` |
| `stage_confidence` | enum: `High`, `Medium`, `Low`, `Unknown` | Required | | `"High"` |
| `stage_signal_evidence` | list of strings | Optional | The statement(s) that identified the stage. | `["Recruiter said 'architecture interview'"]` |

## Stage Objectives

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `stage_goal` | string | Required | Per [Framework 03 Stage Objectives](../frameworks/03-interview-stage-framework.md#stage-objectives). | `"Evaluate architecture, scaling, and trade-off reasoning"` |
| `expected_evaluation_areas` | list of strings | Required | | `["Requirements", "Trade-offs", "Observability"]` |
| `preparation_priorities` | ordered list of strings | Required | | `["Payment workflow design"]` |
| `likely_questions` | list of strings | Optional | | `["Design a payment reconciliation system"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `open_questions` | list of strings | Optional | | `["How long is the system design round?"]` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Interview Stage Rules

1. Always identify the current stage before generating a preparation plan.
2. If the stage is unknown, ask only if it materially changes the preparation.
3. Known stage information overrides generic hiring-process assumptions.
4. Optimize for the next interview, not the entire process.
5. Use previous interview feedback when available.

## Related documents

- [`../frameworks/03-interview-stage-framework.md`](../frameworks/03-interview-stage-framework.md)
- [`interview-process.schema.md`](interview-process.schema.md)
- [`../workflows/identify-interview-stage.md`](../workflows/identify-interview-stage.md)
