# Preparation Strategy — Maya Chen (Synthetic)

> Fully fictional, produced by [Framework 06](../../frameworks/06-preparation-strategy-framework.md) for demonstration only.

## Objective

System Design preparation for the upcoming round at Solstice Cloud.

## Priorities

1. Idempotency and retries under payment/event replay (Critical).
2. Cross-region / multi-datacenter consistency (Critical — Resume Evidence Gap, needs generic reasoning practice).
3. Trade-off articulation under follow-up questioning (High).

## Study Plan

- Review the outbox pattern and idempotency-key design.
- Review cross-region replication and failover trade-offs (strong vs. eventual consistency).
- Rehearse a 60-second ownership narrative for the invoicing pipeline redesign.

## Practice Tasks

- Design a billing event pipeline that survives a regional outage without double-charging customers.
- Practice explaining the real idempotency-key incident as a System Design and Behavioral crossover story.

## Expected Outcomes

Confidently justify consistency and idempotency trade-offs, including for the untested cross-region scenario, under follow-up pressure.
