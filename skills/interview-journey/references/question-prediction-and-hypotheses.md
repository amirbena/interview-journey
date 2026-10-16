# Question Prediction and Interview Hypotheses

Canonical sources: [`frameworks/07-question-prediction-framework.md`](../../../frameworks/07-question-prediction-framework.md), [`frameworks/08-interview-hypothesis-framework.md`](../../../frameworks/08-interview-hypothesis-framework.md), [`schemas/question-prediction.schema.md`](../../../schemas/question-prediction.schema.md), [`schemas/interview-hypothesis.schema.md`](../../../schemas/interview-hypothesis.schema.md).

## Question Prediction

Categories: Resume, Coding, System Design, Architecture, Behavioral, Domain, Company, Leadership. Predict by evidence, not stereotypes (QP-001); current stage has the highest weight (QP-002); explain why each prediction exists (QP-005). Probability labels: Very Likely, Likely, Possible — never a false-precision numeric probability. Remove duplicates.

## Interview Hypotheses

A hypothesis identifies what the interviewer is trying to validate, not only what question may be asked (IH-004). Types: Technical Depth, Ownership, Architecture, Production Readiness, Seniority, Domain Fit, Resume Verification, Risk Resolution. Confidence: High, Medium, Low, Unknown. Prefer fewer high-value hypotheses over many weak ones (IH-002). Preserve uncertainty — never present a hypothesis as fact (IH-006).

## Output shapes

Question Predictions: Question, Category, Why It's Likely, Probability, Preparation Focus. Interview Hypotheses: Hypothesis, Why Likely, Supporting Evidence, Confidence, Likely Validation Method, Preparation Implication, Disproving Evidence.
