# Core Workflow

This document defines how Interview Journey routes and executes preparation work across the [frameworks](../frameworks/), the [Interview Journey State model](state-management.md), and [`context-priority.md`](context-priority.md). It is platform-independent — [`orchestration-policy.md`](orchestration-policy.md) adapts the master orchestrator (Framework 15) into concrete routing rules; this document describes the operating modes those rules run inside.

## Operating modes

### Full Interview Journey

The complete, ordered path defined in [Framework 15, Standard Workflow](../frameworks/15-interview-journey-intelligence-framework.md#standard-workflow):

```text
Identify Objective
        ↓
Role Intelligence (01)
        ↓
Resume Intelligence (02)
        ↓
Interview Stage (03)
        ↓
Role Fit & Gap Analysis (04)
        ↓
Interview Intelligence (05)
        ↓
Preparation Strategy (06)
        ↓
Question Predictions (07)
        ↓
Interview Hypotheses (08)
        ↓
Execution Framework (09 / 10 / 11 / 12)
        ↓
Answer Coaching (13, if requested)
        ↓
Post-Interview Debrief (14, after a completed interview)
```

See [`workflows/full-interview-journey.md`](../workflows/full-interview-journey.md) for the per-stage definition. Never execute unnecessary stages — see [Framework 15 IJ-002 and IJ-003](../frameworks/15-interview-journey-intelligence-framework.md#guiding-principles).

### Focused Task

The default for most requests. Enter a specific module directly when sufficient context is already available — for example: analyze a role, review a resume, predict questions for an already-known stage, run a coding drill, or debrief a single completed interview.

See [`workflows/focused-task-routing.md`](../workflows/focused-task-routing.md) for the full routing table. Offer and compensation-negotiation requests use the focused [`prepare-offer-negotiation.md`](../workflows/prepare-offer-negotiation.md) workflow and the canonical [`offer-negotiation-preparation.md`](offer-negotiation-preparation.md) contract.

### Resume Interview Journey

Continue from the latest valid Interview Journey State available in the active platform context. Resuming does not assume cross-conversation persistence — see [Context Boundary](state-management.md#context-boundary). A journey may only be resumed from context the platform actually provides; when no prior context is available, the product proceeds as a fresh Full Journey or Focused Task instead of pretending to remember one.

See [`workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md) for details.

## Routing principle

> Use the minimum required frameworks needed to satisfy the current request while preserving all applicable evidence, accuracy, and quality-gate rules.

This principle governs all three operating modes:

- a focused task never triggers unrelated frameworks;
- a resumed journey never rebuilds approved, still-fresh work;
- even a Full Interview Journey may skip a stage when its preconditions are already satisfied by valid, non-stale state — see [Interview Journey State Schema Rules](../schemas/interview-journey-state.schema.md#interview-journey-state-rules).

## Interview mode boundaries

Separate from the workflow-routing modes above, every execution framework (09–12) additionally operates inside one of these interview-mode boundaries:

- **Guided Practice** — the system teaches and provides gradual hints.
- **Interview Simulation** — the system acts as the interviewer; it asks one question at a time, avoids coaching during the answer, challenges unsupported reasoning, avoids revealing future questions, preserves realistic pacing, and provides evaluation only after the response or at the end (per the selected simulation mode).
- **Coaching Interview** — the system may pause and coach during the simulation.
- **Full Explanation** — the system may provide a complete walkthrough.
- **Solution / Answer Review** — the system evaluates already-submitted work.

The system must not behave as both interviewer and tutor unless Coaching Interview mode is explicitly selected — see [Coding Framework CI-010](../frameworks/09-coding-interview-decision-engine.md#3-core-operating-principles) and [Mock Interview Framework MI-001](../frameworks/12-mock-interview-framework.md#core-rules).

## Frameworks

Each framework below is documented independently in [`frameworks/`](../frameworks/) and refers back to the schemas and evidence/accuracy policy it applies — it does not redefine them.

| Framework | File | Applies |
|---|---|---|
| Role Intelligence | [`frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md) | [`schemas/role-intelligence.schema.md`](../schemas/role-intelligence.schema.md) |
| Resume Intelligence | [`frameworks/02-resume-intelligence-framework.md`](../frameworks/02-resume-intelligence-framework.md) | [`schemas/resume-intelligence.schema.md`](../schemas/resume-intelligence.schema.md) |
| Interview Stage | [`frameworks/03-interview-stage-framework.md`](../frameworks/03-interview-stage-framework.md) | [`schemas/interview-stage.schema.md`](../schemas/interview-stage.schema.md) |
| Role Fit & Gap Analysis | [`frameworks/04-role-fit-gap-analysis-framework.md`](../frameworks/04-role-fit-gap-analysis-framework.md) | [`schemas/fit-gap-analysis.schema.md`](../schemas/fit-gap-analysis.schema.md) |
| Interview Intelligence | [`frameworks/05-interview-intelligence-framework.md`](../frameworks/05-interview-intelligence-framework.md) | [`schemas/interview-intelligence.schema.md`](../schemas/interview-intelligence.schema.md) |
| Preparation Strategy | [`frameworks/06-preparation-strategy-framework.md`](../frameworks/06-preparation-strategy-framework.md) | [`schemas/preparation-strategy.schema.md`](../schemas/preparation-strategy.schema.md) |
| Question Prediction | [`frameworks/07-question-prediction-framework.md`](../frameworks/07-question-prediction-framework.md) | [`schemas/question-prediction.schema.md`](../schemas/question-prediction.schema.md) |
| Interview Hypothesis | [`frameworks/08-interview-hypothesis-framework.md`](../frameworks/08-interview-hypothesis-framework.md) | [`schemas/interview-hypothesis.schema.md`](../schemas/interview-hypothesis.schema.md) |
| Coding Interview | [`frameworks/09-coding-interview-decision-engine.md`](../frameworks/09-coding-interview-decision-engine.md) | [`schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md) |
| System Design | [`frameworks/10-system-design-framework.md`](../frameworks/10-system-design-framework.md) | [`schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md) |
| Behavioral | [`frameworks/11-behavioral-interview-framework.md`](../frameworks/11-behavioral-interview-framework.md) | [`schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md) |
| Mock Interview | [`frameworks/12-mock-interview-framework.md`](../frameworks/12-mock-interview-framework.md) | [`schemas/mock-interview-session.schema.md`](../schemas/mock-interview-session.schema.md) |
| Answer Coaching | [`frameworks/13-answer-coaching-framework.md`](../frameworks/13-answer-coaching-framework.md) | [`schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md) |
| Post-Interview Debrief | [`frameworks/14-post-interview-debrief-framework.md`](../frameworks/14-post-interview-debrief-framework.md) | [`schemas/interview-debrief.schema.md`](../schemas/interview-debrief.schema.md) |
| Interview Journey Intelligence (master orchestrator) | [`frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md) | [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md) |

## Related documents

- [`orchestration-policy.md`](orchestration-policy.md)
- [`context-priority.md`](context-priority.md)
- [`state-management.md`](state-management.md)
- [`../workflows/full-interview-journey.md`](../workflows/full-interview-journey.md)
- [`../workflows/focused-task-routing.md`](../workflows/focused-task-routing.md)
- [`../workflows/resume-interview-journey.md`](../workflows/resume-interview-journey.md)
- [`../schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md)
