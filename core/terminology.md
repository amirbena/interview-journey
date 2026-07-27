# Terminology

Canonical, platform-independent definitions used throughout Interview Journey. Every platform adaptation (`claude/`, `chatgpt/`) must use these terms with these meanings rather than inventing synonyms.

## Core concepts

- **Role Intelligence** — the structured, evidence-based interpretation of a role's hiring intent, produced by [Framework 01](../frameworks/01-role-intelligence-framework.md).
- **Resume Intelligence** — the structured account of what a candidate can demonstrate, produced by [Framework 02](../frameworks/02-resume-intelligence-framework.md).
- **Interview Stage** — where the candidate currently is in a specific hiring process, per [Framework 03](../frameworks/03-interview-stage-framework.md).
- **Role Fit & Gap Analysis** — the comparison between Role Intelligence and Resume Intelligence, per [Framework 04](../frameworks/04-role-fit-gap-analysis-framework.md).
- **Interview Intelligence** — the accumulating record of recruiter, interviewer, and feedback evidence, per [Framework 05](../frameworks/05-interview-intelligence-framework.md).
- **Preparation Strategy** — the prioritized, objective-driven study plan, per [Framework 06](../frameworks/06-preparation-strategy-framework.md).
- **Question Predictions** — evidence-based likely interview questions, per [Framework 07](../frameworks/07-question-prediction-framework.md).
- **Interview Hypothesis** — a testable claim about what an interviewer is trying to validate, per [Framework 08](../frameworks/08-interview-hypothesis-framework.md).
- **Interview Journey State** — the logical record of a candidate's preparation journey; see [`state-management.md`](state-management.md) and [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md).

## Evidence and confidence terms

- **Confirmed** — directly supported by a source the candidate provided or a verified statement.
- **Reasonable inference** — a conclusion drawn from evidence but not directly stated.
- **General interview guidance** — generic advice not tied to specific evidence about this role, resume, or process.
- **Unknown** — insufficient evidence exists; must never be silently guessed. See [`evidence-policy.md`](evidence-policy.md).

## Interview mode terms

- **Guided Practice** — the system teaches and provides gradual hints.
- **Interview Simulation** — the system acts as the interviewer; no coaching mid-answer.
- **Coaching Interview** — the system may pause and coach during simulation.
- **Full Explanation** — the system provides a complete walkthrough.
- **Solution / Answer Review** — the system evaluates already-submitted work.

See [`workflow.md`](workflow.md#interview-mode-boundaries) for the full mode-boundary rules.

## Output-depth terms

- **Quick** — only essential conclusions.
- **Standard** — balanced detail.
- **Professional** — maximum depth.

## Related documents

- [`product-definition.md`](product-definition.md)
- [`evidence-policy.md`](evidence-policy.md)
- [`workflow.md`](workflow.md)
- [`state-management.md`](state-management.md)
