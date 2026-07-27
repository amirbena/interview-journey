# Interview Debrief Schema

The Interview Debrief record is the structured output of [Framework 14](../frameworks/14-post-interview-debrief-framework.md).

## Logistics

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `company_name` | string | Required | | `"Northbridge Payments"` |
| `role_title` | string | Required | | `"Senior Backend Engineer"` |
| `interview_date` | timestamp | Required | | `"2026-07-20T00:00:00Z"` |
| `interview_stage` | enum, see [`interview-stage.schema.md`](interview-stage.schema.md#stage) | Required | | `"System Design"` |
| `interviewers` | list of strings | Optional | | `["Alex R. (Staff Engineer)"]` |

## Content Captured

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `questions_asked` | list of strings | Required | | `["Design a payment reconciliation system"]` |
| `candidate_answers_summary` | list of strings | Required | | `["Proposed outbox pattern with idempotency keys"]` |
| `difficult_areas` | list of strings | Optional | | `["Cross-region consistency trade-offs"]` |
| `interviewer_reactions` | list of strings | Optional (only when observed) | | `["Interviewer pushed back on eventual consistency choice"]` |
| `candidate_reflection` | Reflection object: `strong_answers`, `weak_answers`, `surprises`, `missed_opportunities`, `confidence_level` | Required | | `{"weak_answers":["Failure handling for cross-region write"]}` |

## Root Cause Analysis

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `root_causes` | list of `{weakness, root_cause}` | Optional | `root_cause` is one of: Knowledge gap, Communication issue, Time management, Stress, Missing preparation, Resume evidence gap, Interview misunderstanding. | `{"weakness":"Cross-region trade-offs","root_cause":"Knowledge gap"}` |
| `recurring_patterns` | list of strings | Optional | | `["System Design repeatedly weak on failure handling"]` |

## Updates Produced

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `updated_interview_intelligence_entries` | list of references to [Interview Intelligence](interview-intelligence.schema.md) entries | Optional | | `[]` |
| `updated_preparation_plan` | reference to [Preparation Strategy](preparation-strategy.schema.md) | Optional | | `"preparation-strategy:v2"` |
| `next_interview_priorities` | ordered list of strings | Required | | `["Practice cross-region failure-handling designs"]` |

## Interview Debrief Rules

1. Capture details immediately after the interview.
2. Separate facts from assumptions.
3. Record both strengths and weaknesses.
4. Never assume rejection reasons without evidence.
5. Preserve historical interview data — do not overwrite prior debriefs.
6. Root causes must be specific, not generic.

## Related documents

- [`../frameworks/14-post-interview-debrief-framework.md`](../frameworks/14-post-interview-debrief-framework.md)
- [`interview-intelligence.schema.md`](interview-intelligence.schema.md)
- [`preparation-strategy.schema.md`](preparation-strategy.schema.md)
- [`../outputs/post-interview-debrief-template.md`](../outputs/post-interview-debrief-template.md)
