# Features

Interview Journey prepares you for a specific interview using your real evidence: the target role, your resume, your current stage, and anything you know about the process. It works only from information you provide. Each capability below is defined once in [`frameworks/`](../frameworks/) and routed by [`core/workflow.md`](../core/workflow.md); see [`docs/architecture.md`](architecture.md) for the framework model.

| Capability | What you get | Workflow |
| --- | --- | --- |
| Role analysis | Hiring intent and requirements of the target role | [`analyze-role`](../workflows/analyze-role.md) |
| Resume analysis | What your resume can actually demonstrate | [`analyze-resume`](../workflows/analyze-resume.md) |
| Interview stage | Where you are in the hiring process | [`identify-interview-stage`](../workflows/identify-interview-stage.md) |
| Role fit and gaps | Role requirements compared with your evidence | [`analyze-role-fit-and-gaps`](../workflows/analyze-role-fit-and-gaps.md) |
| Interview intelligence | Enrichment from recruiter notes, past questions, and feedback | [`merge-interview-intelligence`](../workflows/merge-interview-intelligence.md), [`research-current-interview-intelligence`](../workflows/research-current-interview-intelligence.md) |
| Preparation strategy | The shortest, highest-impact plan for your next interview | [`build-preparation-strategy`](../workflows/build-preparation-strategy.md) |
| Question prediction and hypotheses | Likely questions and what the interviewer is trying to validate | [`predict-interview-questions`](../workflows/predict-interview-questions.md), [`generate-interview-hypotheses`](../workflows/generate-interview-hypotheses.md) |
| Coding, system design, behavioral | Preparation grounded in your real experience | [`prepare-coding-interview`](../workflows/prepare-coding-interview.md), [`prepare-system-design-interview`](../workflows/prepare-system-design-interview.md), [`prepare-behavioral-interview`](../workflows/prepare-behavioral-interview.md) |
| Mock interviews | Realistic simulation with a scorecard | [`run-mock-interview`](../workflows/run-mock-interview.md) |
| Answer coaching | Structured feedback on an answer you submit | [`coach-interview-answer`](../workflows/coach-interview-answer.md) |
| Natural Answer Mode | Natural, conversational answers instead of heavily structured ones; opt-in, off by default | [`natural-answer-mode`](natural-answer-mode.md) |
| Post-interview debrief | Structured lessons from a completed interview | [`run-post-interview-debrief`](../workflows/run-post-interview-debrief.md) |
| Offer and negotiation preparation | Preparing an offer call, range, evaluation, or negotiation | [`prepare-offer-negotiation`](../workflows/prepare-offer-negotiation.md) |

## Modes

- **Full Interview Journey** — the complete ordered path: [`full-interview-journey`](../workflows/full-interview-journey.md).
- **Focused Task** — only the modules a request needs: [`focused-task-routing`](../workflows/focused-task-routing.md).
- **Resume Interview Journey** — continue from a saved state: [`resume-interview-journey`](../workflows/resume-interview-journey.md).
- **Natural Answer Mode** — natural, conversational interview answers you could say out loud, instead of heavily structured, document-style responses. It is opt-in and disabled by default; see [`natural-answer-mode`](natural-answer-mode.md) for how to turn it on and off.

## Boundaries

No backend, database, Action, MCP server, or background automation, and no invented experience or interview details. State is carried through your files and conversation. See [`core/scope-and-non-goals.md`](../core/scope-and-non-goals.md).
