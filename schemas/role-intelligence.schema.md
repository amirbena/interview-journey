# Role Intelligence Schema

The Role Intelligence record is the structured output of [Framework 01](../frameworks/01-role-intelligence-framework.md). It describes a target role's hiring intent — not the candidate. See [core/data-model principles in state-management.md](../core/state-management.md) for how this logical record relates to platform persistence.

## Identity

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `role_title` | string | Required | The role title as stated. | `"Senior Backend Engineer"` |
| `company_name` | string | Optional | The hiring company. | `"Northbridge Payments"` |
| `source_type` | enum: `Job Description`, `Recruiter Message`, `Hiring Manager Statement`, `Mixed` | Required | The primary evidence source. | `"Job Description"` |
| `input_completeness` | enum: `Complete`, `Partial`, `Minimal`, `Insufficient` | Required | Per [Framework 01 §5.3](../frameworks/01-role-intelligence-framework.md#53-input-completeness-classification). | `"Partial"` |

## Business Context

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `product_context` | list of strings | Optional | Per [Framework 01 §10.1](../frameworks/01-role-intelligence-framework.md#101-product-context). | `["FinTech"]` |
| `customer_context` | string | Optional | Per [Framework 01 §10.2](../frameworks/01-role-intelligence-framework.md#102-customer-context). | `"Enterprise customers"` |
| `business_risk_context` | list of strings | Optional | Per [Framework 01 §10.5](../frameworks/01-role-intelligence-framework.md#105-business-risk-context). | `["Revenue", "Compliance"]` |

## Hiring Hypothesis

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `hiring_hypothesis` | string | Required | Business-first hypothesis per [Framework 01 §11](../frameworks/01-role-intelligence-framework.md#11-hiring-hypothesis-engine). | See worked example in Framework 01 §32. |
| `hiring_hypothesis_confidence` | enum: `High`, `Medium`, `Low`, `Unknown` | Required | Per [`core/accuracy-policy.md`](../core/accuracy-policy.md). | `"Medium"` |

## Archetype and Seniority

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `primary_archetype` | enum, see [Framework 01 §12](../frameworks/01-role-intelligence-framework.md#12-role-archetype-classification) | Required | The dominant archetype. | `"FinTech Backend"` |
| `secondary_archetypes` | list, max 2 | Optional | Supporting archetypes. | `["Product Backend"]` |
| `seniority_dimension_scores` | map of 8 dimensions, 0–4 each | Required | Per [Framework 01 §13.1](../frameworks/01-role-intelligence-framework.md#131-dimensions). | `{"technical_scope": 3, ...}` |
| `seniority_total` | integer, 0–32 | Required | Sum of the eight dimensions. | `21` |
| `seniority_interpretation` | enum: `Junior`, `Mid-Level`, `Senior`, `Senior Plus / Lead`, `Staff or Principal` | Required | Per [Framework 01 §13.2](../frameworks/01-role-intelligence-framework.md#132-suggested-interpretation). | `"Senior"` |

## Requirements

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `requirements` | list of Requirement objects | Required | Each has: `name`, `category`, `priority_score` (0–100), `priority_label`, `confidence`, `score_explanation`. Per [Framework 01 §16–17](../frameworks/01-role-intelligence-framework.md#16-requirement-classification). | See worked example. |

## Interview Focus and Risk

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `likely_interview_focus` | list of `{area, probability}` | Optional | Per [Framework 01 §21](../frameworks/01-role-intelligence-framework.md#21-interview-focus-prediction). | `[{"area":"System Design","probability":"Very Likely"}]` |
| `candidate_risk_categories` | list of strings | Optional | Role-level hiring concerns, per [Framework 01 §22](../frameworks/01-role-intelligence-framework.md#22-candidate-risk-categories). | `["Production ownership risk"]` |
| `preparation_implications` | ordered list of strings | Optional | Per [Framework 01 §23](../frameworks/01-role-intelligence-framework.md#23-preparation-implications). | `["Idempotency and retry handling"]` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `open_questions` | list of strings | Optional | Highest-value missing questions. | `["What is the current interview stage?"]` |
| `record_status` | enum: `Draft`, `Confirmed`, `Stale` | Required | Per [`core/output-contracts.md`](../core/output-contracts.md). | `"Draft"` |
| `last_updated_at` | timestamp | Required | When this record was last produced or refreshed. | `"2026-07-20T09:00:00Z"` |

## Role Intelligence Rules

1. Never score requirements before identifying business context (see [Framework 01 RI-008](../frameworks/01-role-intelligence-framework.md#8-mandatory-analysis-sequence)).
2. Do not assign more than one primary and two secondary archetypes.
3. Confidence measures evidence quality, not importance.
4. Preserve contradictions rather than silently resolving them.
5. Never invent an interview process not evidenced by a source.

## Related documents

- [`../frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
- [`../outputs/role-intelligence-template.md`](../outputs/role-intelligence-template.md)
- [`../workflows/analyze-role.md`](../workflows/analyze-role.md)
- [`fit-gap-analysis.schema.md`](fit-gap-analysis.schema.md)
