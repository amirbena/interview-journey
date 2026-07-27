# Interview Hypothesis Schema

The Interview Hypothesis record is the structured output of [Framework 08](../frameworks/08-interview-hypothesis-framework.md).

## Hypotheses

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `hypotheses` | list of Hypothesis objects | Required | Each has the fields below. | See example. |

Each Hypothesis object contains:

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `hypothesis` | string | Required | | `"The interviewer will test whether the candidate truly owned the Kafka consumer redesign."` |
| `hypothesis_type` | enum: `Technical Depth`, `Ownership`, `Architecture`, `Production Readiness`, `Seniority`, `Domain Fit`, `Resume Verification`, `Risk Resolution` | Required | Per [Framework 08 Common Hypothesis Types](../frameworks/08-interview-hypothesis-framework.md#common-hypothesis-types). | `"Resume Verification"` |
| `why_likely` | string | Required | | `"Resume claims sole ownership of a production redesign; strong resumes are commonly probed."` |
| `supporting_evidence` | list of strings | Required | | `["Resume: 'Redesigned Kafka consumer pipeline'"]` |
| `confidence` | enum: `High`, `Medium`, `Low`, `Unknown` | Required | | `"Medium"` |
| `likely_validation_method` | string | Optional | | `"Deep-dive follow-up questions on the redesign decision"` |
| `preparation_implication` | string | Required | | `"Prepare a detailed ownership narrative with trade-offs and metrics."` |
| `disproving_evidence` | string | Optional | What would disprove the hypothesis. | `"If the interviewer never returns to resume projects"` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `open_questions` | list of strings | Optional | | `[]` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Interview Hypothesis Rules

1. Every hypothesis must be supported by evidence.
2. Prefer fewer high-value hypotheses over many weak ones.
3. The current interview stage has the highest operational weight.
4. A hypothesis must identify what the interviewer is trying to validate, not only what question may be asked.
5. Update hypotheses whenever new interview intelligence becomes available.
6. Preserve uncertainty — do not present hypotheses as facts.

## Related documents

- [`../frameworks/08-interview-hypothesis-framework.md`](../frameworks/08-interview-hypothesis-framework.md)
- [`interview-intelligence.schema.md`](interview-intelligence.schema.md)
- [`question-prediction.schema.md`](question-prediction.schema.md)
