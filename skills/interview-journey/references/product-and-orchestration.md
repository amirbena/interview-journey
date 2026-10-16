# Product and Orchestration

Canonical sources: [`core/product-definition.md`](../../../core/product-definition.md), [`core/scope-and-non-goals.md`](../../../core/scope-and-non-goals.md), [`core/workflow.md`](../../../core/workflow.md), [`core/orchestration-policy.md`](../../../core/orchestration-policy.md), [`frameworks/15-interview-journey-intelligence-framework.md`](../../../frameworks/15-interview-journey-intelligence-framework.md), [`core/context-priority.md`](../../../core/context-priority.md).

## Product purpose

Interview Journey is an evidence-driven interview preparation system that tailors preparation to the target role, the candidate's real resume evidence, the current interview stage, company and team context, previous recruiter conversations, previous interview questions and feedback, technical assessments, interviewer information, candidate observations, and lessons from earlier stages.

## Objective routing table

| User objective | Frameworks run, in order |
|---|---|
| Resume review | 02 → 04 |
| Role analysis | 01 |
| Gap analysis | 01 → 02 → 04 |
| Coding preparation | 01 → 02 → 03 → 04 → 06 → 09 |
| System design preparation | 01 → 02 → 03 → 04 → 06 → 10 |
| Behavioral preparation | 01 → 02 → 03 → 04 → 06 → 11 |
| Mock interview | 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 12 |
| Answer review | 13 |
| Post-interview debrief | 14 |
| Offer / negotiation preparation | [`offer-and-negotiation-preparation.md`](offer-and-negotiation-preparation.md), reusing existing Role/Stage outputs when relevant |
| Full Interview Journey | Every framework, only as needed |

## Skip rule

Skip any framework whose valid output already exists in the active Interview Journey State or conversation context. Never re-read the raw JD or resume unless new information is provided.

## Input priority

1. Current user clarification
2. Confirmed interview-specific intelligence
3. Current interview stage
4. Role Intelligence
5. Resume Intelligence
6. Corroborated current public research (`corroborated_public_research`)
7. Unverified current public research (`public_research_unverified`)
8. General company or industry knowledge

Priorities 1–5 outrank public research at priorities 6–7, while general knowledge remains priority 8. Public research is never Confirmed, and contradictions remain visible.

## Output depth

Quick (essential conclusions only), Standard (balanced detail), Professional (maximum depth). Ask which depth is wanted only when it materially changes the response; otherwise default to Standard.

## Clarification policy

Ask questions only when they change the preparation. Never repeat information already available; never ask for details that won't affect the response.

## Validation before responding

Before returning any orchestrated response, verify: the correct objective was identified; only necessary frameworks were used; existing intelligence was reused; no framework duplicated another; the response directly supports interview success.
