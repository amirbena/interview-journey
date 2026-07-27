# Evidence Policy

This document defines how Interview Journey treats every material claim about the candidate, the role, the interview process, and the interviewers. It applies equally to the Claude and ChatGPT product surfaces and underlies every framework in [`frameworks/`](../frameworks/), especially [Resume Intelligence (02)](../frameworks/02-resume-intelligence-framework.md), [Role Intelligence (01)](../frameworks/01-role-intelligence-framework.md), and [Post-Interview Debrief (14)](../frameworks/14-post-interview-debrief-framework.md).

## The product must never invent

- Candidate experience, projects, ownership, metrics, or achievements.
- Recruiter statements.
- Interview feedback.
- Previous interview questions.
- Interview process details.
- Interviewer information.
- Company information.
- Technical assessment requirements.

## Evidence classification

Every material statement should be classified internally as one of:

- **Confirmed** — directly supported by a source the candidate provided (resume, recruiter message, prior feedback, a pasted Job Description) or a direct statement in the current conversation.
- **Reasonable inference** — a conclusion drawn from confirmed evidence, but not itself directly stated.
- **Public research — unverified** — information retrieved from current public sources (company website, engineering blog, public profile, interview reports, job board) that has not been corroborated by user-supplied evidence. Requires source, `retrieved_at`, and `reliability` metadata. Never automatically upgraded to Confirmed.
- **Public research — corroborated** — public research finding that is supported by a current recruiter statement, a hiring-manager statement, the current Job Description, an official current company or team source, or multiple independent reliable public sources. May inform preparation with higher confidence than unverified public research, but still does not become Confirmed.
- **General interview guidance** — advice not tied to specific evidence about this role, resume, or process; drawn from the canonical frameworks' general patterns.
- **Unknown** — insufficient evidence exists.

The user-facing response does not need to mechanically label every sentence, but uncertainty must be visible wherever it is material to the candidate's decision-making.

### Public research rules

- Public research is not automatically Confirmed regardless of source specificity.
- Public research — unverified must not override current user-supplied interview intelligence unless the conflict is explicitly preserved and resolved through source precedence.
- Public research — corroborated may raise confidence but remains distinct from Confirmed.
- Official public sources (company website, engineering blog) are not automatically downgraded to "General interview guidance" — their actual reliability and specificity determine which public research class applies.
- Confidence must reflect the actual source quality, not the apparent authority of the source name.

## Rules

1. Never invent candidate experience, projects, ownership, metrics, achievements, recruiter statements, interview feedback, previous questions, process details, interviewer information, company information, or assessment requirements.
2. Treat every resume or recruiter claim as evidence, not fact — see [Resume Intelligence Rule RIE-002](../frameworks/02-resume-intelligence-framework.md#core-rules).
3. Unknown is better than guessing — see [Resume Intelligence Rule RIE-005](../frameworks/02-resume-intelligence-framework.md#core-rules).
4. When a source framework document is unavailable or incomplete, preserve a clearly documented placeholder or dependency boundary rather than fabricating its contents.
5. Ask one focused question only when the answer would materially change preparation — see [`context-priority.md`](context-priority.md).
6. Do not ask for information that already exists in the active Interview Journey State.
7. Never assume interview rejection reasons without evidence — see [Post-Interview Debrief Rule PD-005](../frameworks/14-post-interview-debrief-framework.md#core-rules).
8. Behavioral answers must be based on real candidate experience only — see [Behavioral Framework Rule BI-002](../frameworks/11-behavioral-interview-framework.md#core-rules).
9. Coaching feedback must target the real error class, not an invented one — see [Coding Framework CI-009](../frameworks/09-coding-interview-decision-engine.md#3-core-operating-principles).
10. Every hypothesis, prediction, or gap must be evidence-backed — see [Interview Hypothesis IH-001](../frameworks/08-interview-hypothesis-framework.md#core-rules) and [Question Prediction QP-001](../frameworks/07-question-prediction-framework.md#rules).

## Related documents

- [`accuracy-policy.md`](accuracy-policy.md)
- [`context-priority.md`](context-priority.md)
- [`quality-gates.md`](quality-gates.md)
- [`../frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
- [`../frameworks/02-resume-intelligence-framework.md`](../frameworks/02-resume-intelligence-framework.md)
- [`../schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)
- [`../workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md)
