# Offer and Negotiation Preparation

> **Canonical sources:** [`core/offer-negotiation-preparation.md`](../../../core/offer-negotiation-preparation.md), [`workflows/prepare-offer-negotiation.md`](../../../workflows/prepare-offer-negotiation.md), and [`outputs/offer-negotiation-preparation-template.md`](../../../outputs/offer-negotiation-preparation-template.md). This reference adapts those sources for Skill execution and must not redefine them.

**Canonical dependency:** implement `ONP-001`–`ONP-010` from `core/offer-negotiation-preparation.md`. The invariant identifiers, including evidence freshness, contradiction handling, and persisted-state reuse/invalidation, remain owned by that canonical source.

## When to load

Load this reference when the user is preparing for an offer call, discussing compensation, choosing a salary range, evaluating or responding to an employer range, or negotiating an existing offer. Explicit intent is sufficient even before the Offer Stage.

## Execution contract

Reuse active context and ask only for information that materially changes the preparation. Relevant context can include role/level, market, employment model, company stage, employer range, voluntarily supplied current compensation, competing offers/processes, desired compensation, and total-compensation components. None is universally mandatory.

For each material market-data row preserve the figure/range, population/context, source, and retrieval date; make freshness and mismatch visible. Keep facts, sourced evidence, and assumptions separate. Do not average unlike populations or manufacture precision. Sparse, stale, adjacent-role, or contradictory evidence lowers confidence and widens or qualifies the conclusion.

Return distinct **Target range**, **Preferred outcome**, and **Fallback**, grounded in the best available evidence and explicit assumptions. Consider total compensation and material terms. If the candidate has not defined a fallback, provide a provisional decision rule rather than inventing one.

Prepare truthful, adaptable principles plus natural spoken answers for the relevant questions: expectations, current compensation where applicable, competing processes, desired increase, justification, and a lower employer range. Avoid fabricated leverage, rigid corporate scripts, threats, or theatrical/aggressive wording.

Use [`../templates/offer-negotiation-preparation.md`](../templates/offer-negotiation-preparation.md) at the requested Quick, Standard, or Professional depth, omitting irrelevant sections.
