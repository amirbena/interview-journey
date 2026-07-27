# Question Prediction Schema

The Question Prediction record is the structured output of [Framework 07](../frameworks/07-question-prediction-framework.md).

## Predictions

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `predictions` | list of Prediction objects | Required | Each has the fields below. | See example. |

Each Prediction object contains:

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `question` | string | Required | | `"How would you make payment retries idempotent?"` |
| `category` | enum: `Resume`, `Coding`, `System Design`, `Architecture`, `Behavioral`, `Domain`, `Company`, `Leadership` | Required | Per [Framework 07 Categories](../frameworks/07-question-prediction-framework.md#categories). | `"System Design"` |
| `why_likely` | string | Required | | `"Idempotency is a Critical requirement per Role Intelligence and the current stage is System Design."` |
| `probability` | enum: `Very Likely`, `Likely`, `Possible` | Required | | `"Very Likely"` |
| `preparation_focus` | string | Required | | `"Review idempotency keys, dedup strategies, retry/backoff design."` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Question Prediction Rules

1. Predict by evidence, not stereotypes.
2. Current stage has highest weight.
3. Critical role requirements generate more questions.
4. Resume projects are common discussion targets.
5. Explain why each prediction exists.
6. Remove duplicate questions.

## Related documents

- [`../frameworks/07-question-prediction-framework.md`](../frameworks/07-question-prediction-framework.md)
- [`interview-hypothesis.schema.md`](interview-hypothesis.schema.md)
- [`../outputs/question-predictions-template.md`](../outputs/question-predictions-template.md)
