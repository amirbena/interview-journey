# Orchestration Policy

This document is the platform-independent adaptation surface for [Framework 15 — Interview Journey Intelligence Framework](../frameworks/15-interview-journey-intelligence-framework.md), the master orchestrator. Framework 15 defines the actual routing logic; this document restates it as the operational contract that [`claude/skill/SKILL.md`](../claude/skill/SKILL.md), the Claude Project instructions, and `chatgpt/instructions.md` must all implement identically, without redefining it.

## The master orchestrator decides

1. Which of Documents 01–14 should run.
2. In what order.
3. Which existing intelligence can be reused (see [`context-priority.md`](context-priority.md)).
4. What information is still missing.
5. What the final response should optimize for.

## Objective routing table

This table is copied verbatim in meaning from [Framework 15, Objective Routing](../frameworks/15-interview-journey-intelligence-framework.md#objective-routing). It must not drift between platform adaptations.

| User objective | Frameworks run, in order |
|---|---|
| Resume review | 02 → 04 |
| Role analysis | 01 |
| Gap analysis | 01 → 02 → 04 |
| Coding preparation | 01 → 02 → 03 → 04 → 06 → 09 |
| System design preparation | 01 → 02 → 03 → 04 → 06 → 10 |
| Behavioral preparation | 01 → 02 → 03 → 04 → 06 → 11 |
| Mock interview | 01 → 02 → 03 → 04 → 05 → 06 → 07 → 08 → 12 |
| Answer review | 13 |
| Post-interview debrief | 14 |
| Full Interview Journey | Every framework, only as needed — never all fourteen unconditionally |

## Skip rule

The system must skip any stage whose valid output already exists in the active Interview Journey State (see [`state-management.md`](state-management.md)) or in the current conversation context. It must reuse approved intelligence rather than repeatedly analyzing the raw resume or Job Description — see [Framework 15 IJ-003 and IJ-004](../frameworks/15-interview-journey-intelligence-framework.md#guiding-principles) and [Role Intelligence Decision Rules](../frameworks/01-role-intelligence-framework.md#decision-rules) ("never re-read the raw JD or resume unless new information is provided").

## Output depth

Every response operates at one of three depths, defined once in [Framework 15, Output Modes](../frameworks/15-interview-journey-intelligence-framework.md#output-modes) and reused by [`core/output-contracts.md`](output-contracts.md):

- **Quick** — only essential conclusions.
- **Standard** — balanced detail.
- **Professional** — maximum depth.

## Clarification policy

Ask questions only when they change the preparation:

- Good: "Which interview stage is this?" / "Do you already have a Job Description?"
- Bad: repeating information already available; asking for details that won't affect the response.

## Response structure

Every response should include only the sections relevant to the user's objective. Avoid dumping every intermediate analysis. Prefer concise outputs unless Professional mode is requested.

## Validation before responding

Before any orchestrated response is returned, verify:

- The correct objective was identified.
- Only necessary frameworks were used.
- Existing intelligence was reused.
- No framework duplicated another.
- The final response directly supports interview success.

## Final operating principle

Interview Journey is a coordinated decision system, not a collection of independent frameworks. The success metric is:

> Help the candidate perform better in the next interview with the least unnecessary work.

## Related documents

- [`../frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md)
- [`workflow.md`](workflow.md)
- [`context-priority.md`](context-priority.md)
- [`output-contracts.md`](output-contracts.md)
- [`../workflows/focused-task-routing.md`](../workflows/focused-task-routing.md)
