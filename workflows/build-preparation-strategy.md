# Workflow: Build Preparation Strategy

Adapts [Framework 06 — Preparation Strategy](../frameworks/06-preparation-strategy-framework.md) into a callable module.

## Purpose

Build the shortest, highest-impact preparation plan for the user's stated objective.

## Required Inputs

The user's objective (Coding, System Design, Behavioral, Mock Interview, Resume Review, Company Research, or Mixed Preparation) — per [Framework 06 Supported Objectives](../frameworks/06-preparation-strategy-framework.md#supported-objectives).

## Optional Inputs

[Role Intelligence](../schemas/role-intelligence.schema.md), [Resume Intelligence](../schemas/resume-intelligence.schema.md), [Fit & Gap Analysis](../schemas/fit-gap-analysis.schema.md), [Interview Stage](../schemas/interview-stage.schema.md), [Interview Intelligence](../schemas/interview-intelligence.schema.md).

## Preconditions

None strictly required, but a strategy built without Fit & Gap Analysis will be lower-confidence and more generic — prefer running [Analyze Role Fit and Gaps](analyze-role-fit-and-gaps.md) first when time allows.

## Procedure

1. Confirm the user's objective controls the output (PS-001).
2. Prioritize Critical then High gaps (PS-002).
3. Exclude topics unrelated to the next interview (PS-003).
4. Favor transferable knowledge (PS-004).
5. Optimize for interview ROI (PS-005).

## Outputs

A [Preparation Strategy](../schemas/preparation-strategy.schema.md) record, presented via [`outputs/preparation-strategy-template.md`](../outputs/preparation-strategy-template.md).

## State Updates

`preparation_strategy_status` moves Not Started → Draft → Confirmed.

## Quality Gates

The user's stated objective must control scope; do not pad with unrelated study topics.

## Uncertainty Handling

If gaps are entirely unknown (no Fit & Gap Analysis available), build the strategy from Role Intelligence's Preparation Implications and the Interview Stage's priorities instead, and label the strategy as less targeted.

## Explicit Non-Actions

- Do not recommend unnecessary study.
- Do not generate a study plan detached from the current interview stage.

## Related documents

- [`../frameworks/06-preparation-strategy-framework.md`](../frameworks/06-preparation-strategy-framework.md)
- [`analyze-role-fit-and-gaps.md`](analyze-role-fit-and-gaps.md)
- [`predict-interview-questions.md`](predict-interview-questions.md)
