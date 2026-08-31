# Workflow: Focused Task Routing

A Focused Task lets the user enter directly into specific frameworks when sufficient context is already available, instead of running the [Full Interview Journey](full-interview-journey.md) end to end. This adapts [Framework 15, Objective Routing](../frameworks/15-interview-journey-intelligence-framework.md#objective-routing) and [`core/orchestration-policy.md`](../core/orchestration-policy.md#objective-routing-table).

## Routing Table

| User request | Frameworks run |
|---|---|
| "Analyze this role / JD" | 01 (Role Intelligence) |
| "Review my resume" | 02 → 04 |
| "Where do I have gaps for this role?" | 01 → 02 → 04 |
| "Help me prep for the coding round" | 01 → 02 → 03 → 04 → 06 → 09 |
| "Help me prep for the system design round" | 01 → 02 → 03 → 04 → 06 → 10 |
| "Help me build my behavioral stories" | 01 → 02 → 03 → 04 → 06 → 11 |
| "Run a mock interview with me" | 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 12 |
| "Review this answer I wrote" | 13 (Answer Coaching) only |
| "Debrief my interview from yesterday" | 14 (Post-Interview Debrief) only |
| "Prepare me for the offer call / help me negotiate compensation" | [Offer and Negotiation Preparation](../core/offer-negotiation-preparation.md), reusing existing 01 and 03 outputs when relevant |
| "Why did you predict this question?" | Explain existing prediction only — no framework re-run |

This table is illustrative, not exhaustive. The [Routing Principle](../core/workflow.md#routing-principle) governs any request not listed: use the minimum required frameworks to satisfy the request.

## Prerequisite Behavior

- Use existing context where available — see [`core/context-priority.md`](../core/context-priority.md).
- Do not ask again for known information.
- Ask only when a missing input blocks correct execution.
- Use a clearly labeled assumption when the missing detail is non-blocking.
- Do not silently trigger unrelated frameworks — a request scoped to Answer Coaching must not cause Role Intelligence, Resume Intelligence, or any other framework to run.

## Worked Examples

**"Why did you predict this question?"**
No framework runs. The system explains the existing prediction using the reasoning already recorded against [Question Prediction](../schemas/question-prediction.schema.md) — it does not re-run Question Prediction or any upstream framework.

**"I just got moved to the system design round — help me prep"**
[Identify Interview Stage](identify-interview-stage.md) updates to `System Design`; [Role Fit and Gap Analysis](analyze-role-fit-and-gaps.md) is reused if still valid (not re-run); [Build Preparation Strategy](build-preparation-strategy.md) and [Prepare System Design Interview](prepare-system-design-interview.md) run.

**"Review this answer I wrote about a production incident"**
Only [Coach Interview Answer](coach-interview-answer.md) runs. Role Intelligence, Resume Intelligence, and Interview Stage are not re-derived unless genuinely needed to judge relevance.

**"The recruiter gave me a range below my target — what should I say?"**
Run [Prepare for an Offer or Negotiation](prepare-offer-negotiation.md). Reuse the known role, market, employer range, and candidate priorities; do not require a resume analysis or a full journey. Preserve attributable market evidence and prepare a natural response plus Target range, Preferred outcome, and Fallback.

## Related documents

- [`../core/workflow.md`](../core/workflow.md)
- [`../core/orchestration-policy.md`](../core/orchestration-policy.md)
- [`full-interview-journey.md`](full-interview-journey.md)
- [`resume-interview-journey.md`](resume-interview-journey.md)
