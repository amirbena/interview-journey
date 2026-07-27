# Candidate Answer Schema

The Candidate Answer record is a logical structure shared by the Coding ([Framework 09](../frameworks/09-coding-interview-decision-engine.md)), System Design ([Framework 10](../frameworks/10-system-design-framework.md)), Behavioral ([Framework 11](../frameworks/11-behavioral-interview-framework.md)), and Answer Coaching ([Framework 13](../frameworks/13-answer-coaching-framework.md)) frameworks. It represents one submitted answer, solution, or design under review or practice.

## Identity

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `answer_domain` | enum: `Coding`, `System Design`, `Behavioral` | Required | | `"Coding"` |
| `prompt` | string | Required | The question or problem being answered. | `"Given an array of integers, return indices of the two numbers that add up to a target."` |
| `operating_mode` | enum: `Guided Practice`, `Interview Simulation`, `Coaching Interview`, `Full Explanation`, `Solution / Answer Review`, `Pattern Drill`, `Debugging Drill`, `Practical Coding` | Required | Per [`core/workflow.md#interview-mode-boundaries`](../core/workflow.md#interview-mode-boundaries). | `"Guided Practice"` |

## Coding-specific fields

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `pattern` | string | Optional | Per [Coding Framework §7](../frameworks/09-coding-interview-decision-engine.md#7-pattern-recognition-engine). | `"Hash Map / Hash Set"` |
| `hint_level_reached` | integer, 0–9 | Optional | Per [Coding Framework §9](../frameworks/09-coding-interview-decision-engine.md#9-hint-escalation-engine). | `2` |
| `complexity_time` | string | Optional | | `"O(n)"` |
| `complexity_space` | string | Optional | | `"O(n)"` |
| `error_classification` | list of enum values from [Coding Framework §13](../frameworks/09-coding-interview-decision-engine.md#13-error-classification-engine) | Optional | | `["Boundary Error"]` |

## System-design-specific fields

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `functional_requirements` | list of strings | Optional | | `["Users can submit a payment"]` |
| `non_functional_requirements` | list of strings | Optional | | `["Idempotent under retry"]` |
| `bottlenecks_identified` | list of strings | Optional | | `["Single database write path under peak load"]` |

## Behavioral-specific fields

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `competency` | enum, see [Behavioral Framework §Behavioral Competencies](../frameworks/11-behavioral-interview-framework.md#behavioral-competencies) | Optional | | `"Ownership"` |
| `star_structure_present` | boolean | Optional | | `true` |
| `reflection_present` | boolean | Optional | | `true` |

## Evaluation

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `evaluation_scores` | map of dimension to 1–5 score | Optional | Dimensions per the relevant framework's rubric. | `{"communication": 4}` |
| `overall_recommendation` | enum: `Strong Hire Signal`, `Hire Signal`, `Borderline`, `No Hire Signal` | Optional | Coding/mock context only; never a blind average. | `"Hire Signal"` |
| `coaching_feedback` | list of strings | Optional | Per [Answer Coaching Framework](../frameworks/13-answer-coaching-framework.md). | `["Missing quantified result — add the latency improvement figure."]` |

## Candidate Answer Rules

1. Never invent experience, achievements, or code the candidate did not produce.
2. Classify errors by the correct class before coaching (see [Coding Framework CI-009](../frameworks/09-coding-interview-decision-engine.md#3-core-operating-principles)).
3. Do not reveal a full solution outside Full Explanation mode or an explicit user request.
4. Overall recommendation must never be a blind average of dimension scores.
5. Behavioral answers must be based on real experience only.

## Related documents

- [`../frameworks/09-coding-interview-decision-engine.md`](../frameworks/09-coding-interview-decision-engine.md)
- [`../frameworks/10-system-design-framework.md`](../frameworks/10-system-design-framework.md)
- [`../frameworks/11-behavioral-interview-framework.md`](../frameworks/11-behavioral-interview-framework.md)
- [`../frameworks/13-answer-coaching-framework.md`](../frameworks/13-answer-coaching-framework.md)
- [`mock-interview-session.schema.md`](mock-interview-session.schema.md)
