# Mock Interview Session Schema

The Mock Interview Session record is the structured output of [Framework 12](../frameworks/12-mock-interview-framework.md).

## Session

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `session_mode` | enum: `Full Interview`, `Coaching Interview`, `Lightning Round`, `Deep Dive`, `Executive Interview`, `Panel Interview` | Required | Per [Framework 12 Supported Modes](../frameworks/12-mock-interview-framework.md#supported-modes). | `"Full Interview"` |
| `panel_perspectives` | list of strings | Optional (Panel Interview only) | | `["Engineering Manager", "Senior Engineer"]` |
| `questions_asked` | ordered list of Candidate Answer references | Required | Each references a [Candidate Answer](candidate-answer.schema.md) record. | `[]` |

## Scorecard

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `competency_scores` | map: Technical Knowledge, Problem Solving, Architecture, Ownership, Communication, Behavioral, Confidence, Business Thinking → rating | Required | Ratings: `Outstanding`, `Strong`, `Acceptable`, `Needs Improvement`, `Weak`. Per [Framework 12 Evaluation Rubric](../frameworks/12-mock-interview-framework.md#evaluation-rubric). | `{"Architecture": "Strong"}` |
| `overall_recommendation` | enum: `Outstanding`, `Strong`, `Acceptable`, `Needs Improvement`, `Weak` | Required | | `"Strong"` |
| `strengths` | list of strings | Required | | `["Clear invariant explanation"]` |
| `weaknesses` | list of strings | Required | | `["Underspecified failure handling"]` |
| `missed_opportunities` | list of strings | Optional | | `["Did not mention observability"]` |
| `estimated_interview_readiness` | string | Required | | `"Ready for a System Design round with light additional prep on failure handling."` |

## Lifecycle

| Field | Type | Required | Description | Example |
|---|---|---|---|---|
| `session_date` | timestamp | Required | | `"2026-07-20T09:00:00Z"` |

## Mock Interview Session Rules

1. Behave like the interviewer unless the user requests coaching.
2. Do not reveal future questions.
3. Evaluate both technical accuracy and communication.
4. Feedback is given after the answer unless coaching mode is selected.
5. Never inflate scores or ignore weak answers.

## Related documents

- [`../frameworks/12-mock-interview-framework.md`](../frameworks/12-mock-interview-framework.md)
- [`candidate-answer.schema.md`](candidate-answer.schema.md)
- [`../outputs/mock-interview-scorecard-template.md`](../outputs/mock-interview-scorecard-template.md)
