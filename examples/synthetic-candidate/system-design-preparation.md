# System Design Preparation — Billing Event Pipeline (Synthetic)

> Fully fictional practice session, produced by [Framework 10](../../frameworks/10-system-design-framework.md) for demonstration only.

## Problem

Design a billing event pipeline for Solstice Cloud that processes payment events reliably and never double-charges a customer, even under retries or a regional outage.

## Functional Requirements

Ingest payment events; generate invoices; support retries without duplication; support reconciliation reporting.

## Non-Functional Requirements

Idempotent under retry (Critical); strong consistency for the ledger write; tolerable eventual consistency for reconciliation reports; survive a single-region outage without data loss.

## Applied Patterns

Outbox pattern (ledger write + event publication consistency); idempotency keys on the payment-event API; cross-region async replication with a documented RPO/RTO trade-off for the reconciliation store.

## Failure Handling

If the primary region fails mid-transaction, the ledger write must not have committed without its corresponding event being durably queued (outbox guarantees this); a failover promotes the replica region, and idempotency keys prevent replaying already-applied events from re-charging customers.

## Trade-off Summary

Chose eventual consistency for cross-region reconciliation to avoid coupling every write to a slow cross-region round trip; the ledger itself stays strongly consistent within a region because financial correctness outweighs latency there. This directly extends the real idempotency-key pattern Maya already implemented in production, generalized to the untested cross-region scenario flagged as a gap.
