# Preparation Strategy Schema

The Preparation Strategy record is the structured output of [Framework 06](../frameworks/06-preparation-strategy-framework.md).

## Objective

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `objective` | enum: `Coding`, `System Design`, `Behavioral`, `Mock Interview`, `Resume Review`, `Company Research`, `Mixed Preparation` | Required | Per [Framework 06 Supported Objectives](../frameworks/06-preparation-strategy-framework.md#supported-objectives). | `"System Design"` |

## Plan

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `priorities` | ordered list of strings | Required | Critical gaps first, then High. | `["Idempotency and retries", "Cross-region consistency"]` |
| `study_plan` | list of strings | Required | | `["Review outbox pattern", "Review saga pattern"]` |
| `practice_tasks` | list of strings | Required | | `["Design a payment reconciliation system"]` |
| `expected_outcomes` | list of strings | Required | | `["Confidently justify consistency trade-offs"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Preparation Strategy Rules

1. User objective determines the output.
2. Prioritize Critical then High gaps.
3. Do not study topics unrelated to the next interview.
4. Favor transferable knowledge.
5. Optimize for interview ROI.

## Related documents

- [`../frameworks/06-preparation-strategy-framework.md`](../frameworks/06-preparation-strategy-framework.md)
- [`fit-gap-analysis.schema.md`](fit-gap-analysis.schema.md)
- [`../outputs/preparation-strategy-template.md`](../outputs/preparation-strategy-template.md)
