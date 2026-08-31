# Synthetic Offer and Negotiation Scenarios

All roles, companies, ranges, and circumstances below are fictional test inputs. Numbers test decision behavior only and are not current-market claims. Each `Requires` line maps the scenario to stable invariants owned by [`core/offer-negotiation-preparation.md`](../../core/offer-negotiation-preparation.md); the focused validator checks the exact required mapping and verifies that each identifier resolves to a canonical rule.

## SCN-STRONG — Strong market evidence

- **Input:** Senior Software Engineer; multiple recent, comparable fictional sources.
- **Requires:** `ONP-002`, `ONP-005`
- **Expected:** Show attributable, fresh evidence rows and derive an actionable Target range, Preferred outcome, and candidate-defined Fallback without mathematical certainty.

## SCN-SPARSE — Sparse market evidence

- **Input:** Specialist role in a small market; one adjacent-role source.
- **Requires:** `ONP-003`, `ONP-007`
- **Expected:** Label the adjacent population, lower confidence, widen or qualify the recommendation, avoid fake precision, and proceed without requiring every optional field.

## SCN-CONTRADICTORY — Contradictory evidence

- **Input:** Two fictional sources cover different company segments and materially disagree.
- **Requires:** `ONP-002`, `ONP-004`
- **Expected:** Preserve both attributed rows, explain the population mismatch, and use a conditional position rather than naïvely averaging.

## SCN-BELOW-TARGET — Employer range below target

- **Input:** Employer supplies a range below the evidence-grounded target.
- **Requires:** `ONP-005`, `ONP-008`, `ONP-009`
- **Expected:** Preserve the position and prepare a natural, constructive lower-range response without threats or invented leverage.

## SCN-TOTAL-COMP — Total compensation changes the recommendation

- **Input:** Lower base includes a material fictional bonus/equity package with stated risk and terms.
- **Requires:** `ONP-005`, `ONP-006`
- **Expected:** Compare total value, vesting, liquidity, risk, and terms; allow package components to change the recommendation rather than choosing on base alone.

## SCN-OPTIONAL — Missing optional information

- **Input:** Role, market, and employer range are known; current compensation and competing offers are omitted.
- **Requires:** `ONP-001`, `ONP-007`, `ONP-010`
- **Expected:** Reuse known context, do not require optional facts, proceed with explicit assumptions, and preserve reusable state without rebuilding unrelated context.

No fixture value may be presented as real or current salary evidence.
