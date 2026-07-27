# Interview Intelligence Framework

**Document ID:** 05
**Depends on:** 01–04

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Continuously enrich preparation using new interview information.

---

# Sources

- Recruiter conversations
- Hiring manager comments
- Previous interview questions
- Feedback
- Take-home assignments
- User observations
- Public company, team, role, interviewer, hiring-manager, or interview-process research (see [`workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md) and [`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md))

---

# Rules

## II-001
New interview evidence overrides generic assumptions.

## II-002
Preserve chronology.

## II-003
Never ignore recruiter hints.

## II-004
Convert every new insight into preparation actions.

## II-005
Keep historical context; don't overwrite it.

## II-006
Public research evidence requires source provenance and retrieval metadata. Every public research finding must include a source identifier, `retrieved_at` timestamp, and reliability classification before it enters the evidence model. A finding without these fields must not be merged.

## II-007
Chronology must be represented by timestamps, not only by narrative order. "The recruiter said…" is not sufficient — the approximate date of the recruiter conversation, where available, determines its position relative to other evidence.

## II-008
Public research must be classified as `public_research_unverified` or `corroborated_public_research` per [`core/evidence-policy.md`](../core/evidence-policy.md). It must never be treated as Confirmed.

## II-009
User-reported direct interview evidence outranks conflicting unverified public research. When a conflict exists, preserve both sides explicitly rather than silently discarding the lower-priority finding.

## II-010
Official current role-specific material (a current JD, current careers page, current team page) may corroborate public research findings, elevating their classification from unverified to corroborated.

## II-011
Missing retrieval dates reduce confidence. Public research evidence with no `retrieved_at` must be treated as unknown freshness and classified accordingly.

## II-012
Stale employment or role claims must not be presented as current. A public LinkedIn profile title retrieved today does not confirm the person still holds that role if the profile appears outdated or unverified.

---

# Workflow

1. Capture new evidence (including public research if supplied).
2. Classify it — assign evidence class, source provenance, and freshness per `core/evidence-policy.md`.
3. Update interview hypotheses.
4. Update question predictions.
5. Update preparation priorities.

---

# Output

- New Evidence
- Updated Hypotheses
- Changed Priorities
- Risks
- Recommended Actions

See [`schemas/interview-intelligence.schema.md`](../schemas/interview-intelligence.schema.md) and [`workflows/merge-interview-intelligence.md`](../workflows/merge-interview-intelligence.md).

---

# Principle

Every interview should make the next interview preparation smarter.

## Related documents

- [`03-interview-stage-framework.md`](03-interview-stage-framework.md)
- [`08-interview-hypothesis-framework.md`](08-interview-hypothesis-framework.md)
- [`07-question-prediction-framework.md`](07-question-prediction-framework.md)
- [`14-post-interview-debrief-framework.md`](14-post-interview-debrief-framework.md)
- [`../schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)
- [`../workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md)
- [`../core/evidence-policy.md`](../core/evidence-policy.md)
