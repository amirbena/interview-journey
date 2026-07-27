# Mock Interview Excerpt — System Design (Synthetic)

> Fully fictional simulated session, produced by [Framework 12](../../frameworks/12-mock-interview-framework.md) for demonstration only. Mode: Full Interview.

**Interviewer (simulated):** "Design a billing event pipeline that can't double-charge a customer. Let's start with requirements — what do you need to clarify?"

**Maya (candidate):** "First, what's the expected event volume and are we optimizing for a single region or multi-region from day one?"

**Interviewer:** "Assume single-region today, but the company wants to be ready to expand. What's your data model for the payment event?"

**Maya:** *(proposes an event schema with a unique idempotency key, an outbox table, and a Kafka topic for downstream consumers)*

**Interviewer:** "What happens if the consumer crashes after writing to the ledger but before publishing the event?"

**Maya:** *(explains the outbox pattern closes this gap — the event publish is derived from the same transaction as the ledger write)*

**Interviewer:** "Good. Now — your primary region goes down mid-transaction. Walk me through what happens."

**Maya:** *(reasons through failover, replica promotion, and idempotency-key-based dedup on replay)*

## Scorecard Excerpt

| Area | Rating |
|---|---|
| Architecture | Strong |
| Failure Handling | Strong |
| Communication | Acceptable — could tighten the initial requirements-gathering pace |

**Key Risk:** Slightly slow to move from clarification to design; watch the clock in the real interview.

**Preparation Plan:** One more timed 45-minute run-through focused on moving to a first design faster.
