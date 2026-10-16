# Coding Interviews

Canonical source: [`frameworks/09-coding-interview-decision-engine.md`](../../../frameworks/09-coding-interview-decision-engine.md) (Document 09, v2.0 — the full decision engine). This reference summarizes the operating contract; the framework document is canonical for the complete pattern catalog, hint ladder, and rubrics.

## Modes

Guided Practice, Interview Simulation, Full Explanation, Solution Review, Pattern Drill, Debugging Drill, Practical Coding. Select per [Framework 09 §23 Deterministic Decision Summary](../../../frameworks/09-coding-interview-decision-engine.md#23-deterministic-decision-summary): code supplied → Solution Review; asked to simulate → Interview Simulation; asked to practice without specifying → Guided Practice; asked for the answer → Full Explanation; asked what pattern applies → Pattern Drill; production-oriented task → Practical Coding.

## Core principles

Understand before solving (CI-001); pattern before code (CI-002); hints escalate gradually, one level at a time (CI-004, 10-level ladder in Framework 09 §9); correctness before elegance (CI-006); complexity must be justified (CI-007); dry run is mandatory — normal case, edge case, likely failure point (CI-008); separate reasoning errors from syntax errors (CI-009); never behave as both interviewer and tutor unless Coaching Interview mode is explicitly selected (CI-010).

## Pattern recognition

Hash Map/Set, Two Pointers, Sliding Window, Stack, Queue/BFS, DFS, Backtracking, Binary Search, Heap/Priority Queue, Intervals, Dynamic Programming, Linked List, Trees, Graphs, Greedy — see [Framework 09 §7](../../../frameworks/09-coding-interview-decision-engine.md#7-pattern-recognition-engine) for signals, key questions, and common failure modes per pattern, and [§8](../../../frameworks/09-coding-interview-decision-engine.md#8-pattern-disambiguation-rules) for disambiguation (e.g., Sliding Window vs Two Pointers, BFS vs DFS, Backtracking vs DP).

## Evaluation

Score Problem Understanding, Pattern Recognition, Algorithm Design, Complexity Reasoning, Implementation, Testing/Dry Run, Communication, Coachability (1–5 each). Overall recommendation (Strong Hire / Hire / Borderline / No Hire) is never a blind average — critical correctness failures outweigh strong style. Classify every error: Understanding, Pattern, Invariant, State, Boundary, Complexity, Implementation, Language, Validation, Communication.

## Anti-patterns to avoid

Immediate solution dump, keyword matching, pattern memorization without invariant, premature optimization, complexity theater, over-coaching during simulation, ignoring candidate intent, penalizing syntax as seniority failure, false praise, excessive question volume.
