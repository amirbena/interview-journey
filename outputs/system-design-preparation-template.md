# System Design Preparation Template

Markdown presentation template for a System Design Preparation session, built from a [Candidate Answer record](../schemas/candidate-answer.schema.md) (`answer_domain: System Design`) per [Framework 10](../frameworks/10-system-design-framework.md). All values below are synthetic.

## Disclaimer

> Complexity is added only to solve a named requirement or bottleneck — not for its own sake.

## Required Sections

Following the [Standard Design Sequence](../frameworks/10-system-design-framework.md#standard-design-sequence): Problem Clarification, Functional Requirements, Non-Functional Requirements, Scale Estimate, API/Contracts, Data Model, High-Level Design, Main Flow, Bottlenecks, Applied Patterns, Failure Handling, Consistency & Concurrency, Scaling, Observability, Trade-off Summary.

## Synthetic Example

### Problem
Design a payment reconciliation system for Northbridge Payments.

### Non-Functional Requirements
Idempotent under retry; eventual consistency acceptable for reconciliation reports; strong consistency required for the ledger write.

### Applied Patterns
Outbox pattern (ledger write + event publication consistency); idempotency keys on the payment API.

### Trade-off Summary
Chose eventual consistency for reporting to reduce coupling; the ledger itself stays strongly consistent because financial correctness outweighs latency here.

## Related documents

- [`../schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md)
- [`../frameworks/10-system-design-framework.md`](../frameworks/10-system-design-framework.md)
- [`mock-interview-scorecard-template.md`](mock-interview-scorecard-template.md)
