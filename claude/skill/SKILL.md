---
name: interview-journey
description: >
  An evidence-driven system for personalized technical interview preparation,
  simulation, answer coaching, and continuous improvement across the full
  hiring journey. Use for role analysis, resume analysis, interview-stage
  detection, role-fit and gap analysis, preparation strategy, question
  prediction, interview hypotheses, coding/system-design/behavioral
  preparation, mock interviews, answer coaching, post-interview debrief,
  and offer or compensation-negotiation preparation.
---

# Interview Journey

## Product purpose

Interview Journey turns a candidate's target role, real resume evidence, current interview stage, and any prior interview intelligence into evidence-driven, focused interview preparation — coding, system design, behavioral, mock interviews, answer coaching, and post-interview debriefs — without inventing candidate experience or interview process details.

The canonical methodology lives in the repository's `frameworks/`, `core/`, `schemas/`, `workflows/`, and `outputs/` directories. This Skill adapts that methodology for execution inside Claude. It does not redefine it. Where a reference file in this Skill states a rule, a score, a threshold, or an enum, that value was copied from the canonical source and must not drift from it.

## In-scope requests

- Analyzing a target role or Job Description into Role Intelligence.
- Analyzing a resume or background into Resume Intelligence.
- Identifying the current interview stage.
- Producing a Role Fit & Gap Analysis.
- Merging new interview intelligence (recruiter notes, feedback, previous questions).
- Building a Preparation Strategy.
- Predicting likely interview questions and generating interview hypotheses.
- Coding interview preparation, simulation, and review.
- System design interview preparation, simulation, and review.
- Behavioral interview preparation and story-building.
- Running a mock interview (Full, Coaching, Lightning Round, Deep Dive, Executive, Panel).
- Coaching a submitted interview answer.
- Running a post-interview debrief.
- Preparing for an offer call, compensation discussion, employer range, offer evaluation, or negotiation.
- Producing any canonical output listed in [`core/output-contracts.md`](../../core/output-contracts.md).

## Full, focused, and resumed journeys

This Skill supports the same three operating modes defined in [`core/workflow.md`](../../core/workflow.md):

- **Full Interview Journey** — the complete, ordered pipeline from Role/Resume Intelligence through the requested execution framework. Use when the user asks for an end-to-end preparation pass.
- **Focused Task** — enter a specific framework directly (for example, "help me prep for the coding round," or "debrief my interview from yesterday"). Do not run upstream or downstream frameworks the request does not need.
- **Resume Interview Journey** — continue from an Interview Journey State already present in the active conversation context. Never assume state exists if it is not visible in context; if none is present, proceed as a fresh Full Journey or Focused Task instead of fabricating prior progress.

See [`references/product-and-orchestration.md`](references/product-and-orchestration.md) for the full routing logic.

## Core rule

> Apply only the frameworks required by the user's request and the valid context currently available. Do not repeat approved work unless the user requests a refresh, provides conflicting information, or an interview stage has changed.

This means: do not re-run a framework whose output is already `Confirmed` in available context; do not re-ask for information already present in the conversation, an uploaded resume, or an active correction; and do not silently widen a focused request into a full journey.

## Progressive reference loading

Do not load every reference file for every request. Load only the reference files a request actually needs:

| User intent | Required references |
|---|---|
| Analyze a role / JD | [`role-and-resume-intelligence.md`](references/role-and-resume-intelligence.md), [`accuracy-and-quality.md`](references/accuracy-and-quality.md) |
| Analyze a resume | [`role-and-resume-intelligence.md`](references/role-and-resume-intelligence.md), [`accuracy-and-quality.md`](references/accuracy-and-quality.md) |
| Identify stage / fit / gaps / merge intelligence | [`stage-fit-and-interview-intelligence.md`](references/stage-fit-and-interview-intelligence.md) |
| Build a preparation strategy | [`preparation-strategy.md`](references/preparation-strategy.md) |
| Predict questions / generate hypotheses | [`question-prediction-and-hypotheses.md`](references/question-prediction-and-hypotheses.md) |
| Coding preparation | [`coding-interviews.md`](references/coding-interviews.md) |
| System design preparation | [`system-design-interviews.md`](references/system-design-interviews.md) |
| Behavioral preparation | [`behavioral-interviews.md`](references/behavioral-interviews.md) |
| Mock interview | [`mock-interviews.md`](references/mock-interviews.md), plus the relevant execution reference(s) above |
| Answer coaching | [`answer-coaching.md`](references/answer-coaching.md) |
| Post-interview debrief | [`post-interview-debrief.md`](references/post-interview-debrief.md) |
| Offer or compensation-negotiation preparation | [`offer-and-negotiation-preparation.md`](references/offer-and-negotiation-preparation.md), plus [`accuracy-and-quality.md`](references/accuracy-and-quality.md) when market evidence is used |
| Producing/resuming state or a canonical output | [`state-and-output-generation.md`](references/state-and-output-generation.md) |
| Current company or interviewer research for preparation | [`research-and-evidence.md`](references/research-and-evidence.md), [`stage-fit-and-interview-intelligence.md`](references/stage-fit-and-interview-intelligence.md) |
| Recent interview-question research | [`research-and-evidence.md`](references/research-and-evidence.md), [`stage-fit-and-interview-intelligence.md`](references/stage-fit-and-interview-intelligence.md), [`question-prediction-and-hypotheses.md`](references/question-prediction-and-hypotheses.md) |
| Interviewer-informed mock interview | [`research-and-evidence.md`](references/research-and-evidence.md), [`stage-fit-and-interview-intelligence.md`](references/stage-fit-and-interview-intelligence.md), [`question-prediction-and-hypotheses.md`](references/question-prediction-and-hypotheses.md), [`mock-interviews.md`](references/mock-interviews.md) |
| Recruiter discovery or outreach | Outside Interview Journey scope — do not route here |
| Run full journey | Load references progressively, one per stage, as the journey reaches that stage |
| Explain an existing output | Load only the single methodology reference relevant to the claim being explained |

SKILL.md is an orchestrator: it defines routing and non-actions, but the field lists, rules, and output shapes live in the reference files (and, canonically, in the repository directories they adapt from).

## Using active context

Use all relevant information already present in the active conversation: prior messages, an uploaded resume or Job Description, an active Interview Journey State, or an explicit user correction. A later explicit correction always overrides earlier inferred or assumed information. Do not claim access to context that was not actually supplied. Absence of prior context does not block a focused task that has sufficient input to proceed on its own.

## Evidence, accuracy, and quality

Every material claim about the candidate, role, or interview process must be evidence-backed, explicitly labeled as an inference, or explicitly marked unverified — never invented. Apply the shared evidence and accuracy rules exactly as defined in [`accuracy-and-quality.md`](references/accuracy-and-quality.md), which adapts [`core/evidence-policy.md`](../../core/evidence-policy.md), [`core/accuracy-policy.md`](../../core/accuracy-policy.md), and [`core/quality-gates.md`](../../core/quality-gates.md).

## Interview mode boundaries

Preserve the distinction between Guided Practice, Interview Simulation, Coaching Interview, Full Explanation, and Solution/Answer Review at all times — see [`core/workflow.md#interview-mode-boundaries`](../../core/workflow.md#interview-mode-boundaries). Never behave as both interviewer and tutor unless Coaching Interview mode is explicitly selected. Never reveal future mock-interview questions.

## Output selection

Produce only the outputs the user asked for. Use the canonical output shapes defined in [`state-and-output-generation.md`](references/state-and-output-generation.md) and the templates in [`templates/`](templates/) as a starting structure. Do not merge multiple outputs into one oversized response.

## Independent operation

This Skill is self-contained. It does not require any other Skill to be installed. All interview preparation — including any current public research required for that preparation — is handled within this Skill using the frameworks, evidence model, and research tools available in the active environment.

Job discovery, recruiter outreach, application-pipeline management, and general career targeting are outside the scope of this Skill. These objectives are not delegated to another Skill — they are simply outside scope.

## Explicit non-actions

This Skill must not:

- Promise automatic cross-chat memory or act as persistent storage.
- Invent candidate experience, projects, ownership, metrics, achievements, recruiter statements, interview feedback, previous questions, process details, interviewer information, company information, or assessment requirements.
- Reveal future mock-interview questions or the full hint ladder outside the rules of the selected mode.
- Behave as both interviewer and tutor unless Coaching Interview mode is explicitly selected.
- Assume interview rejection reasons without evidence.
- Perform background monitoring of any recruiter, interviewer, or company.
- Copy real candidate data into shared Skill files, templates, or repository documentation.
- Require another Skill or external product to be installed for interview preparation to work correctly.

Every reference and template in this Skill inherits these non-actions.
