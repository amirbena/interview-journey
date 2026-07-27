# Accuracy Policy

This document defines how Interview Journey expresses confidence and precision, complementing [`evidence-policy.md`](evidence-policy.md) (what may be claimed) with rules on how it is worded and scored.

## Confidence levels

Every major conclusion (a Role Intelligence requirement score, a gap priority, an interview hypothesis, a question prediction) should carry one of:

- **High** — directly stated by a strong source, confirmed across multiple sources, or strongly demonstrated by assignment/interview behavior.
- **Medium** — supported by one strong source, inferred from repeated signals, or consistent with role structure.
- **Low** — inferred from limited evidence, based on a generic pattern, or contradicted by another source.
- **Unknown** — evidence is insufficient.

These mirror [Role Intelligence Section 24](../frameworks/01-role-intelligence-framework.md#24-confidence-framework) and apply identically to every other framework's conclusions.

## Rules

1. Confidence measures evidence quality, not importance — a requirement can be Critical priority and Low confidence at the same time.
2. When confidence is Low, explain why.
3. Avoid false precision — do not invent numeric probabilities or scores unsupported by evidence (see [Role Intelligence RI-061](../frameworks/01-role-intelligence-framework.md#213-probability-labels)).
4. Preserve contradictions explicitly rather than silently resolving them (see [Role Intelligence RI-005 and RI-071](../frameworks/01-role-intelligence-framework.md#6-source-precedence)).
5. Score requirements, gaps, and questions using the same consistent model every time — never re-derive an ad hoc scale mid-conversation.
6. Complexity, seniority, and requirement-priority scores must use the exact scoring dimensions and bands defined in [Framework 01](../frameworks/01-role-intelligence-framework.md), never a simplified restatement.
7. Coding-interview complexity claims must be justified, not memorized (see [Coding Framework CI-007](../frameworks/09-coding-interview-decision-engine.md#3-core-operating-principles)).
8. Mock interview evaluation must never be a blind average — a critical correctness failure outweighs strong style (see [Mock Interview Framework, Overall Evaluation](../frameworks/12-mock-interview-framework.md)).
9. Never present an assumption as fact, in any framework, at any output depth.
10. Match the requested output depth (Quick, Standard, Professional) without diluting the underlying accuracy rules — see [`output-contracts.md`](output-contracts.md).

## Related documents

- [`evidence-policy.md`](evidence-policy.md)
- [`context-priority.md`](context-priority.md)
- [`quality-gates.md`](quality-gates.md)
- [`../frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
