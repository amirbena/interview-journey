# Interview Intelligence Schema

The Interview Intelligence record is the structured output of [Framework 05](../frameworks/05-interview-intelligence-framework.md). It accumulates recruiter, interviewer, and feedback evidence across the whole journey — it never overwrites prior evidence.

## Evidence Log

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `evidence_entries` | ordered list of Evidence objects | Optional | Each has: `entry_id`, `source` (`Recruiter conversation`, `Hiring manager comment`, `Previous interview question`, `Feedback`, `Take-home assignment`, `User observation`), `date`, `content_summary`, `classification`. Chronology must be preserved. | `{"source":"Feedback","date":"2026-07-18","content_summary":"Interviewer noted strong coding, weak system design depth"}` |

## Derived State

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `updated_hypotheses` | list of strings | Optional | References to hypotheses changed by new evidence. | `["Elevated: Production Readiness hypothesis"]` |
| `changed_priorities` | list of strings | Optional | | `["System design study elevated to Critical"]` |
| `risks` | list of strings | Optional | | `["Interviewer previously flagged shallow Kafka depth"]` |
| `recommended_actions` | list of strings | Optional | | `["Practice a Kafka-based system design problem"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Interview Intelligence Rules

1. New interview evidence overrides generic assumptions.
2. Preserve chronology — never reorder or discard prior entries.
3. Never ignore recruiter hints.
4. Convert every new insight into a preparation action.
5. Keep historical context; don't overwrite it.

## Related documents

- [`../frameworks/05-interview-intelligence-framework.md`](../frameworks/05-interview-intelligence-framework.md)
- [`interview-hypothesis.schema.md`](interview-hypothesis.schema.md)
- [`question-prediction.schema.md`](question-prediction.schema.md)
- [`interview-debrief.schema.md`](interview-debrief.schema.md)
