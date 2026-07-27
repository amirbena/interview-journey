# Question Predictions Template

Markdown presentation template for the Question Predictions output, built from a [Question Prediction record](../schemas/question-prediction.schema.md) per [Framework 07 Output](../frameworks/07-question-prediction-framework.md#output). All values below are synthetic.

## Disclaimer

> Predictions are evidence-based estimates, not confirmed questions from the interviewer.

## Required Columns

| Question | Category | Why It's Likely | Probability | Preparation Focus |
|---|---|---|---|---|
| How would you make payment retries idempotent? | System Design | Idempotency is Critical per Role Intelligence and the current stage is System Design | Very Likely | Idempotency keys, dedup, retry/backoff |
| Walk me through the Kafka consumer redesign on your resume | Resume | Resume claims sole ownership of a production redesign | Likely | Ownership narrative with trade-offs and metrics |

## Ordering

1. Probability, descending (Very Likely → Likely → Possible)
2. Category

## Related documents

- [`../schemas/question-prediction.schema.md`](../schemas/question-prediction.schema.md)
- [`../frameworks/07-question-prediction-framework.md`](../frameworks/07-question-prediction-framework.md)
- [`interview-hypotheses-template.md`](interview-hypotheses-template.md)
