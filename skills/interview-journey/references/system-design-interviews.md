# System Design Interviews

Canonical source: [`frameworks/10-system-design-framework.md`](../../../frameworks/10-system-design-framework.md).

## Standard design sequence

Clarify the problem → functional requirements → non-functional requirements → scale estimation (only when useful) → API/contract design → data model → simplest high-level design → trace main flow → identify bottlenecks → add patterns to solve named bottlenecks → failure handling → consistency/concurrency → scaling → observability → trade-off summary.

## Core rules

Begin with functional and non-functional requirements (SD-001); start with the simplest viable design (SD-003); add components only to solve a named bottleneck or requirement (SD-004); explain trade-offs for major decisions (SD-005); do not treat named technologies as architecture justification (SD-009); end with bottlenecks, observability, and future scaling (SD-010).

## Architecture patterns

Load Balancer, Cache (key/TTL/invalidation/staleness), Queue/Stream (delivery semantics/ordering/DLQ), Database Replication, Sharding, CDN, Rate Limiting, Outbox Pattern, Saga, Idempotency.

## Interview modes

Guided Practice, Interview Simulation, Design Review, Full Walkthrough — see [`core/workflow.md#interview-mode-boundaries`](../../../core/workflow.md#interview-mode-boundaries) for the shared mode-boundary rules.

## Validation

Requirements clarified; design started simple; every component has a reason; bottlenecks identified; failures addressed; consistency/concurrency addressed where relevant; scaling evidence-based; observability included; trade-offs explicit.
