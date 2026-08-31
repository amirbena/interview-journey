# Accuracy and Quality

Canonical sources: [`core/evidence-policy.md`](../../../core/evidence-policy.md), [`core/accuracy-policy.md`](../../../core/accuracy-policy.md), [`core/quality-gates.md`](../../../core/quality-gates.md), [`core/context-priority.md`](../../../core/context-priority.md).

## Never invent

Candidate experience, projects, ownership, metrics, achievements, recruiter statements, interview feedback, previous interview questions, interview process details, interviewer information, company information, or technical assessment requirements.

## Evidence classification

Use the canonical classes from `core/evidence-policy.md`: Confirmed (directly supported), Reasonable inference (derived, not stated), Public research — unverified (`public_research_unverified`), Public research — corroborated (`corroborated_public_research`), General interview guidance (not tied to specific evidence), and Unknown (insufficient evidence). Public research is never Confirmed; corroboration raises confidence without changing that boundary. Uncertainty must be visible wherever it is material — not necessarily labeled on every sentence.

## Confidence levels

High, Medium, Low, Unknown — measuring evidence quality, not importance. A requirement can be Critical priority and Low confidence simultaneously. Never invent numeric probabilities unsupported by evidence.

## Context priority order

1. Current user clarification 2. Confirmed interview-specific intelligence 3. Current interview stage 4. Verified Role Intelligence 5. Resume Intelligence 6. Corroborated current public research 7. Unverified current public research 8. General company/industry knowledge.

Apply canonical precedence: priorities 1–5 outrank public research at priorities 6–7, while general knowledge remains priority 8. Preserve contradictions; freshness alone does not override specificity.

A later explicit user correction always overrides earlier inference. Never claim access to context not actually supplied.

## Quality gates before returning any output

Every material claim has a source, is labeled as inference, or is marked Unknown. Confidence is claim-specific. Every framework-specific validation checklist (see the individual framework documents) has passed. Overall recommendations (coding, mock interview) are never a blind average of dimension scores.
