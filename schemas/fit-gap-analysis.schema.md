# Fit & Gap Analysis Schema

The Fit & Gap Analysis record is the structured output of [Framework 04](../frameworks/04-role-fit-gap-analysis-framework.md), comparing [Role Intelligence](role-intelligence.schema.md) against [Resume Intelligence](resume-intelligence.schema.md).

## Overall

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `overall_role_fit` | enum: `Strong`, `Good`, `Moderate`, `Weak`, `Unclear` | Required | | `"Good"` |
| `top_strengths` | list of strings | Required | | `["Strong distributed systems ownership"]` |

## Matches

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `strong_matches` | list of Match objects | Optional | Each has `requirement`, `evidence`. | `{"requirement":"Distributed reliability","evidence":"Owned Kafka consumer redesign in production"}` |
| `partial_matches` | list of Match objects | Optional | | `{"requirement":"Kafka messaging","evidence":"RabbitMQ production experience, no direct Kafka"}` |

## Gaps

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `critical_gaps` | list of Gap objects | Optional | Each has `requirement`, `gap_type` (Knowledge/Experience/Production/Scale/Architecture/Leadership/Communication/Domain/Resume Evidence Gap), `priority`. | `{"requirement":"Idempotent payment retries","gap_type":"Experience Gap","priority":"Critical"}` |
| `high_priority_preparation_topics` | list of strings | Optional | | `["Idempotency and retry handling"]` |
| `resume_evidence_gaps` | list of strings | Optional | Gaps that are about missing proof, not missing ability. | `["Ownership of the caching redesign is unclear on the resume"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `open_questions` | list of strings | Optional | | `[]` |
| `confidence` | enum: `High`, `Medium`, `Low`, `Unknown` | Required | | `"Medium"` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Fit & Gap Analysis Rules

1. Compare capabilities, not technology names.
2. Evidence outweighs assumptions.
3. Missing evidence is not proof of missing ability.
4. Prioritize business-critical gaps.
5. Current interview stage may change preparation priority, but not the gap itself.

## Related documents

- [`../frameworks/04-role-fit-gap-analysis-framework.md`](../frameworks/04-role-fit-gap-analysis-framework.md)
- [`role-intelligence.schema.md`](role-intelligence.schema.md)
- [`resume-intelligence.schema.md`](resume-intelligence.schema.md)
- [`preparation-strategy.schema.md`](preparation-strategy.schema.md)
