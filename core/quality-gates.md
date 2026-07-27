# Quality Gates

This document defines the minimum checks that must pass before returning each canonical output. It is downstream of [`evidence-policy.md`](evidence-policy.md) and [`accuracy-policy.md`](accuracy-policy.md), and applies to the outputs described in [`output-contracts.md`](output-contracts.md).

## Role Intelligence

Before returning, confirm: the objective was identified before scoring; business context precedes requirement scoring; every Critical/High requirement is briefly justified; confidence is assigned per conclusion; contradictions are preserved, not hidden. See [Role Intelligence Validation Checklist](../frameworks/01-role-intelligence-framework.md#30-validation-checklist).

## Resume Intelligence

Before returning, confirm: every major conclusion has evidence; technologies were converted into capabilities, not left as a tool list; ownership was identified; business impact was extracted where present; resume risks are evidence-based; unknowns remain marked Unknown. See [Resume Intelligence Validation Checklist](../frameworks/02-resume-intelligence-framework.md#validation-checklist).

## Interview Stage

Before returning, confirm: current stage identified with a confidence label; preparation is aligned to that stage; previous interview intelligence was incorporated; generic advice was removed. See [Interview Stage Validation Checklist](../frameworks/03-interview-stage-framework.md#validation-checklist).

## Role Fit & Gap Analysis

Before returning, confirm: capabilities were compared, not tool names; Resume Intelligence evidence and Role Intelligence priorities were both used; unknown was distinguished from missing; no candidate experience was invented; preparation recommendations focus only on meaningful gaps. See [Fit & Gap Validation Checklist](../frameworks/04-role-fit-gap-analysis-framework.md#validation-checklist).

## Preparation Strategy / Question Predictions / Interview Hypotheses

Before returning, confirm: the user's stated objective controls scope; only Critical/High gaps are prioritized; predictions and hypotheses are evidence-backed and stage-specific; weak duplicates were removed; uncertainty is visible.

## Coding / System Design / Behavioral preparation

Before returning, confirm the framework-specific validation checklist:
- [Coding Interview Validation Checklist](../frameworks/09-coding-interview-decision-engine.md#22-validation-checklist)
- [System Design Validation Checklist](../frameworks/10-system-design-framework.md#validation-checklist)
- [Behavioral Validation Checklist](../frameworks/11-behavioral-interview-framework.md#validation-checklist)

## Mock Interview

Before returning, confirm: questions matched role and stage; difficulty was appropriate and adaptive; follow-ups were realistic; feedback is evidence-based; the overall recommendation is not a blind average. See [Mock Interview Validation Checklist](../frameworks/12-mock-interview-framework.md#validation-checklist).

## Answer Coaching

Before returning, confirm: feedback is evidence-based; no fabricated experience was introduced; advice is actionable; any improved answer preserves authenticity. See [Answer Coaching Validation Checklist](../frameworks/13-answer-coaching-framework.md#validation-checklist).

## Post-Interview Debrief

Before returning, confirm: facts are separated from assumptions; root causes are identified per weakness, not generically; an improvement plan exists; Interview Intelligence was updated; lessons are reusable for the next interview. See [Post-Interview Debrief Validation Checklist](../frameworks/14-post-interview-debrief-framework.md#validation-checklist).

## Universal final check

Every material claim about the candidate, the role, or the interview process must either have supporting evidence, be explicitly labeled as inference, or be marked Unknown — never invented.

## Related documents

- [`evidence-policy.md`](evidence-policy.md)
- [`accuracy-policy.md`](accuracy-policy.md)
- [`output-contracts.md`](output-contracts.md)
- [`../frameworks/`](../frameworks/)
