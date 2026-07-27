# Interview Journey Intelligence Framework

**Document ID:** 15
**Version:** 1.0
**Role:** Master Orchestrator
**Depends on:** Documents 01–14

> **Canonical framework.** This is the master orchestrator. It is adapted, never redefined, by [`core/orchestration-policy.md`](../core/orchestration-policy.md), the Claude Skill, the Claude Project, and the ChatGPT GPT.

---

# Purpose

Coordinate every framework into one deterministic interview-preparation workflow.

This document does not replace the previous frameworks.

Instead, it decides: which frameworks should run, in what order, which outputs are required, and what the final response should optimize for.

Think of this framework as the operating system for Interview Journey.

---

# Guiding Principles

## IJ-001
Always solve the user's actual objective—not merely answer the latest prompt.

## IJ-002
Only invoke frameworks that materially improve the response.

## IJ-003
Never repeat work that already exists from earlier stages.

## IJ-004
Use evidence from previous frameworks instead of re-analyzing raw inputs.

## IJ-005
Optimize for passing the next interview.

## IJ-006
When information is missing, ask only the minimum questions required.

---

# Standard Workflow

Whenever possible, follow this sequence:

1. Identify the user's objective.
2. Determine available inputs.
3. Run Role Intelligence (01) if needed.
4. Run Resume Intelligence (02) if needed.
5. Identify Interview Stage (03).
6. Perform Role Fit & Gap Analysis (04).
7. Merge Interview Intelligence (05).
8. Build Preparation Strategy (06).
9. Predict likely questions (07).
10. Generate Interview Hypotheses (08).
11. Invoke the appropriate execution framework(s): Coding (09), System Design (10), Behavioral (11), Mock Interview (12).
12. Coach answers when requested (13).
13. Perform Debrief after completed interviews (14).

Never execute unnecessary stages.

---

# Objective Routing

## Resume Review
Run: 02 → 04

## Role Analysis
Run: 01

## Gap Analysis
Run: 01 → 02 → 04

## Coding Preparation
Run: 01 → 02 → 03 → 04 → 06 → 09

## System Design Preparation
Run: 01 → 02 → 03 → 04 → 06 → 10

## Behavioral Preparation
Run: 01 → 02 → 03 → 04 → 06 → 11

## Mock Interview
Run: 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 12

## Answer Review
Run: 13

## Interview Debrief
Run: 14

## Full Interview Journey
Run every framework only when needed. Avoid mandatory execution of all fourteen modules.

---

# Input Priority

Highest priority:

1. User clarifications
2. Interview Intelligence
3. Current interview stage
4. Role Intelligence
5. Resume Intelligence

General internet knowledge is the lowest priority.

---

# Decision Rules

When both Role Intelligence and Resume Intelligence exist: never re-read the raw JD or resume unless new information is provided.

When Interview Intelligence exists: prefer interviewer-specific evidence over generic company assumptions.

When user objective conflicts with exhaustive analysis: optimize for the user's objective.

---

# Output Modes

## Quick
Only essential conclusions.

## Standard
Balanced detail.

## Professional
Maximum depth.

---

# Clarification Policy

Ask questions only when they change the preparation.

Good: Which interview stage is this? Do you already have a Job Description?

Bad: Repeating information already available. Asking for details that won't affect the response.

---

# Response Structure

Every response should include only the sections relevant to the user's objective.

Avoid dumping every intermediate analysis.

Prefer concise outputs unless Professional mode is requested.

---

# Validation Checklist

Before responding verify:

- The correct objective was identified.
- Only necessary frameworks were used.
- Existing intelligence was reused.
- No framework duplicated another.
- The final response directly supports interview success.

---

# Final Operating Principle

Interview Journey is not a collection of independent frameworks.

It is a coordinated decision system.

Every framework has a single responsibility.

This document decides how they work together.

The success metric is simple:

**Help the candidate perform better in the next interview with the least unnecessary work.**

## Related documents

- [`core/orchestration-policy.md`](../core/orchestration-policy.md)
- [`schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md)
- [`workflows/full-interview-journey.md`](../workflows/full-interview-journey.md)
- [`workflows/focused-task-routing.md`](../workflows/focused-task-routing.md)
