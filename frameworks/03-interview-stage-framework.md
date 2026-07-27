# Interview Stage Intelligence Framework

**Document ID:** 03
**Version:** 1.0
**Depends on:** 01 — Role Intelligence Decision Engine

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Determine **where the candidate is in the hiring process** and adapt all preparation accordingly.

The interview stage is a stronger predictor of preparation than generic company interview patterns.

---

# Core Rules

## ISI-001
Always identify the current interview stage before generating a preparation plan.

## ISI-002
If the stage is unknown, ask only if it materially changes the preparation.

## ISI-003
Known interview-stage information overrides generic hiring assumptions.

## ISI-004
Optimize for the **next** interview, not the entire process.

## ISI-005
Use previous interview feedback when available.

---

# Supported Stages

1. Recruiter / HR Screen
2. Hiring Manager
3. Technical Coding
4. Practical Coding / Pair Programming
5. System Design
6. Behavioral
7. Technical Deep Dive
8. Take-Home Assignment
9. Final Interview
10. Executive Interview
11. Offer Stage
12. Unknown

---

# Stage Objectives

## Recruiter

Focus on: Resume story, Motivation, Role fit, Communication, Salary, Logistics.

## Hiring Manager

Focus on: Ownership, Business impact, Decision making, Project discussions, Technical depth, Team fit.

## Coding

Focus on: Problem solving, Data structures, Algorithms, Communication while coding, Complexity analysis.

## Practical Coding

Focus on: Production-quality code, Clean architecture, Testing, Trade-offs.

## System Design

Focus on: Requirements, Architecture, Scaling, Reliability, Trade-offs, Bottlenecks, Observability.

## Behavioral

Focus on: STAR stories, Ownership, Conflict resolution, Leadership, Failure, Learning.

## Technical Deep Dive

Focus on: Resume projects, Architecture, Production decisions, Trade-offs, Debugging, Domain knowledge.

## Take-Home

Focus on: Correctness, Readability, Documentation, Testing, Maintainability.

## Final Interview

Focus on: Closing gaps, Consistency, Company motivation, Long-term ownership.

---

# Stage Signals

Examples:

Recruiter says "Team fit" → HR / Hiring Manager
"Live coding" → Coding
"Architecture interview" → System Design
"Walk through your projects" → Technical Deep Dive
"Home assignment" → Take-Home

---

# Preparation Priority

Each stage should produce: Primary objective, Topics to emphasize, Topics to de-emphasize, Common mistakes, Success criteria.

---

# Required Output

1. Current Stage
2. Confidence
3. Stage Goal
4. Expected Evaluation Areas
5. Preparation Priorities
6. Likely Questions
7. Open Questions (if needed)

See [`schemas/interview-stage.schema.md`](../schemas/interview-stage.schema.md) and [`workflows/identify-interview-stage.md`](../workflows/identify-interview-stage.md).

---

# Validation Checklist

- Current stage identified
- Stage confidence assigned
- Preparation aligned to stage
- Previous interview intelligence incorporated
- Generic advice removed

---

# Final Principle

Always prepare the candidate for **the next interview**, using the current stage as the primary optimization signal.

## Related documents

- [`01-role-intelligence-framework.md`](01-role-intelligence-framework.md)
- [`05-interview-intelligence-framework.md`](05-interview-intelligence-framework.md)
- [`schemas/interview-stage.schema.md`](../schemas/interview-stage.schema.md)
