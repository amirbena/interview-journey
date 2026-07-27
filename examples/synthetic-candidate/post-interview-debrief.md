# Post-Interview Debrief — Solstice Cloud System Design Round (Synthetic)

> Fully fictional, produced by [Framework 14](../../frameworks/14-post-interview-debrief-framework.md) for demonstration only.

## Interview Summary

System Design round at Solstice Cloud, 2026-07-29, with Jordan T. (fictional Staff Engineer).

## Strengths

Clear idempotency-key design; strong ownership narrative for the real pipeline redesign; correctly applied the outbox pattern without prompting.

## Weaknesses

Spent too long on requirements clarification before proposing a first design; the cross-region failure-handling answer was reasonable but not proactively raised.

## Root Causes

- Time management — no root cause in knowledge; candidate simply needs more timed practice.
- The cross-region gap: this was a genuine Resume Evidence Gap flagged in advance (see [`role-fit-gap-analysis.md`](role-fit-gap-analysis.md)) — root cause is missing preparation depth in that specific area, not a knowledge gap in general system design.

## Recurring Patterns

None yet — this is the candidate's first tracked interview in this journey.

## Updated Interview Intelligence

New evidence: this interviewer (Jordan T.) explicitly tests failure scenarios by asking "what happens if X fails mid-transaction" as a standard follow-up — record this for future Solstice Cloud rounds.

## Updated Preparation Plan

For the next stage (Behavioral, with the team lead): emphasize a tightened, timed narrative style; carry forward the ownership story already validated as strong.

## Next Interview Priorities

1. Practice pacing — move to a first design within 10 minutes of any future system-design practice session.
2. Prepare the Finance-collaboration story flagged as a Partial Match, in case the behavioral round probes it.
