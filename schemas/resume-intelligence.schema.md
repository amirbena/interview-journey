# Resume Intelligence Schema

The Resume Intelligence record is the structured output of [Framework 02](../frameworks/02-resume-intelligence-framework.md). It describes what the candidate can actually demonstrate — never a summary of the resume text.

## Identity

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `candidate_name` | string | Optional | The candidate's name, if supplied. | `"Dana Levi"` |
| `source_type` | enum: `Master Resume`, `Tailored Resume`, `LinkedIn`, `Portfolio`, `GitHub`, `Project documentation`, `User clarification` | Required | Per [Framework 02 Inputs](../frameworks/02-resume-intelligence-framework.md#inputs). | `"Master Resume"` |

## Capability Matrix

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `capabilities` | list of Capability objects | Required | Each has: `capability_name`, `source_technology`, `depth_level` (0–4, per [Framework 02 §Capability Depth](../frameworks/02-resume-intelligence-framework.md#capability-depth)), `ownership_level`, `evidence`. | `{"capability_name":"Event-driven architecture","source_technology":"Kafka","depth_level":3,"ownership_level":"Owned"}` |

## Production and Business Impact

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `production_signals` | list of strings | Optional | Per [Framework 02 §Production Signals](../frameworks/02-resume-intelligence-framework.md#production-signals). | `["On-call", "Incidents"]` |
| `business_impact` | list of `{problem, action, result}` | Optional | Per [Framework 02 §Business Impact](../frameworks/02-resume-intelligence-framework.md#business-impact). | `{"problem":"High latency","action":"Added caching layer","result":"Reduced p99 latency by 40%"}` |
| `leadership_signals` | list of strings | Optional | Mentoring, standard-setting, technical leadership evidence. | `["Mentored 2 junior engineers"]` |

## Risks and Gaps

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `resume_risks` | list of strings | Optional | Only when evidence-supported, per [Framework 02 §Resume Risks](../frameworks/02-resume-intelligence-framework.md#resume-risks). | `["Tool lists only in one role"]` |
| `open_questions` | list of strings | Optional | Missing information worth clarifying. | `["Was the caching redesign owned solo or with a team?"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `confidence_assessment` | enum: `High`, `Medium`, `Low`, `Unknown` | Required | Overall confidence in this record. | `"Medium"` |
| `record_status` | enum: `Draft`, `Confirmed`, `Stale` | Required | | `"Draft"` |
| `last_updated_at` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Resume Intelligence Rules

1. Never invent experience (see [Framework 02 RIE-001](../frameworks/02-resume-intelligence-framework.md#core-rules)).
2. Treat every resume claim as evidence, not fact.
3. Convert technologies into capabilities — never leave a bare tool list.
4. Unknown is better than guessing.
5. Prefer measurable achievements over technology lists.

## Related documents

- [`../frameworks/02-resume-intelligence-framework.md`](../frameworks/02-resume-intelligence-framework.md)
- [`../outputs/resume-intelligence-template.md`](../outputs/resume-intelligence-template.md)
- [`../workflows/analyze-resume.md`](../workflows/analyze-resume.md)
- [`fit-gap-analysis.schema.md`](fit-gap-analysis.schema.md)
