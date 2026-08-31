# Offer and Negotiation Preparation

This document defines the canonical, platform-independent contract for preparing a candidate for compensation conversations and offer negotiation. [Framework 15](../frameworks/15-interview-journey-intelligence-framework.md) routes into this capability; ChatGPT, the Claude Skill, and the Claude Project adapt it without redefining it.

## Stable contract invariants

These identifiers name durable behavior for cross-package and scenario validation. They are intentionally broader than individual paragraphs.

| ID | Invariant |
|---|---|
| `ONP-001` | Explicit offer or compensation-negotiation intent routes to this canonical capability without forcing unrelated workflows. |
| `ONP-002` | Material market evidence is attributable by figure/range, population/context, source, retrieval date, and freshness/fit. |
| `ONP-003` | Sparse, stale, or adjacent-population evidence lowers confidence and widens or qualifies the recommendation without fake precision. |
| `ONP-004` | Contradictory or unlike sources remain visible and are not naïvely averaged. |
| `ONP-005` | The position distinguishes Target range, Preferred outcome, and candidate-defined Fallback or a provisional decision rule. |
| `ONP-006` | Total compensation, risk, timing, and material terms can change the recommendation. |
| `ONP-007` | Optional context is reused when available but does not block safe, useful preparation when absent. |
| `ONP-008` | A lower employer range receives a truthful, constructive response without threats or fabricated leverage. |
| `ONP-009` | Prepared answers are concise, conversational, truthful, and adaptable rather than rigid scripts. |
| `ONP-010` | Negotiation state is reusable when valid and becomes stale when material employer terms, candidate priorities, position inputs, or evidence freshness change. |

## Trigger

Run this capability when the user's objective is to prepare for an offer call, discuss compensation, decide what salary range to give, evaluate or respond to an employer range, or negotiate an existing offer. An identified `Offer Stage` is a strong signal, but explicit negotiation intent is sufficient at any stage. Do not disturb unrelated routing.

## Context and clarification

Reuse relevant active context before asking a question. Consider, when available:

- role/title and seniority;
- location and employment market;
- employment model;
- company type or stage when it affects compensation structure;
- known employer compensation range;
- current compensation, only when the candidate chooses to provide it and it is relevant;
- competing offers or active processes;
- desired compensation;
- total-compensation components such as base, bonus, equity, pension, benefits, sign-on, review timing, and vesting or liquidity conditions.

No field is universally mandatory. Ask only for a missing fact that materially changes the recommendation. Otherwise proceed with a visible assumption and identify what could change the position. Never pressure the candidate to disclose current compensation.

## Market evidence contract

Market figures presented as facts must be attributable. Every material salary-data row must preserve:

| Field | Requirement |
|---|---|
| Figure or range | Include currency, period, and whether it is base or total compensation. |
| Population/context | State role/title, seniority, location, employment model, company segment, and sample scope when known. |
| Source | Name and link or supplied-source reference. |
| Retrieval date | Record the date the evidence was accessed. |
| Freshness/fit | Explain material age or population mismatch. |

Prefer current, role- and market-specific evidence. Keep sourced evidence, user-provided facts, and assumptions distinct. Do not invent precision, silently average unlike populations, or present public research as Confirmed candidate/employer fact. When sources disagree, expose the disagreement and explain which evidence is more comparable and why.

If current research tools are unavailable, use supplied evidence and general principles, clearly label the market range as unresolved, and do not fabricate benchmarks.

## Negotiation position

Produce an actionable position with three distinct elements:

- **Target range** — the defensible range the candidate can communicate, grounded in the best comparable evidence and total-compensation context.
- **Preferred outcome** — the realistic package the candidate would be pleased to accept, including material non-base components.
- **Fallback** — the minimum acceptable package or decision boundary, defined by the candidate rather than inferred as an objective market fact.

Derive the position from available evidence and explicitly stated assumptions. Explain the reasoning without implying mathematical certainty. Never invent a fallback when the candidate has not supplied enough preference information; provide a provisional decision rule instead. Compare packages on total value, risk, timing, and terms where those factors are material—not base salary alone.

## Natural answer preparation

Prepare principles plus adaptable, candidate-ready spoken answers for the questions relevant to the situation, including at least:

1. “What are your salary expectations?”
2. Questions about current compensation, where applicable and lawful/relevant.
3. Competing offers or interview processes.
4. Desired increase.
5. “Why do you think this range is justified?”
6. A response when the employer gives a lower range.

Answers must be truthful, concise, conversational, and adaptable to the candidate's voice. Avoid corporate scripts, fabricated leverage, theatrical language, threats, and unnecessary aggression. Prefer a principle followed by a natural example answer over a rigid script. A candidate may redirect from current compensation toward role scope and market value without disclosing information they do not wish to share.

## Sparse, stale, or contradictory evidence

- **Very little data:** reduce confidence, use a wider or qualified range, and emphasize employer range discovery and package trade-offs.
- **Different populations:** do not combine them as equivalent; state each population and use only genuinely comparable evidence to anchor the position.
- **Material contradiction:** show the conflicting rows, assess comparability and reliability, and use a conditional position rather than an unexplained average.
- **Stale evidence:** make its age visible, downgrade confidence, and avoid treating it as a current benchmark.
- **No reliable exact-title benchmark:** use carefully labeled adjacent-role or level evidence, explain the mapping, and widen the conclusion.

Uncertainty changes the confidence and width of the conclusion; it never licenses a manufactured precise range.

## Output depth

- **Quick:** essential assumptions, position, one short evidence summary, and the immediately needed answer.
- **Standard:** the normal output contract below.
- **Professional:** deeper source comparison, package scenarios, trade-offs, risks, and a broader answer set.

## Normal output contract

A Standard result includes only relevant sections:

1. Context and assumptions.
2. Market evidence table, with source and retrieval date per material row.
3. Target range, preferred outcome, and fallback.
4. Reasoning, including total-compensation trade-offs.
5. Natural spoken-answer preparation.
6. Risks, unknowns, and facts that could change the position.

## Validation checklist

- Negotiation intent or Offer Stage triggered the capability.
- Existing context was reused and optional gaps did not cause over-questioning.
- Every material market row includes figure, population/context, source, and retrieval date.
- Evidence freshness, mismatches, and contradictions remain visible.
- Target range, preferred outcome, and fallback are distinct and evidence/assumption grounded.
- Total compensation is considered when relevant.
- Relevant compensation questions have natural, truthful spoken answers.
- Sparse or stale evidence reduces confidence and precision.
- Output depth matches the user's need.
- Negotiation state reuse and invalidation follow `ONP-010` and [`state-management.md`](state-management.md#offer-and-negotiation-state-lifecycle).

## Related documents

- [`orchestration-policy.md`](orchestration-policy.md)
- [`context-priority.md`](context-priority.md)
- [`evidence-policy.md`](evidence-policy.md)
- [`output-contracts.md`](output-contracts.md)
- [`../workflows/prepare-offer-negotiation.md`](../workflows/prepare-offer-negotiation.md)
- [`../outputs/offer-negotiation-preparation-template.md`](../outputs/offer-negotiation-preparation-template.md)
