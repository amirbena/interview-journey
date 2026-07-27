# Resume Intelligence Engine Specification

**Document ID:** 02
**Version:** 1.0
**Depends on:** Document 01 — Role Intelligence Decision Engine

> **Canonical framework.** Platform adaptations (`claude/skill/references/`, `chatgpt/knowledge/`) must reference this document rather than redefine its rules. See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Transform a resume into structured Resume Intelligence.

Do **not** summarize the resume.

Instead, determine:

- What the candidate can prove.
- The depth of every capability.
- Production ownership.
- Business impact.
- Technical strengths.
- Open questions.

This document provides evidence that will later be compared against Role Intelligence (Document 01) inside the Role Fit and Gap Analysis Framework (Document 04).

---

# Inputs

Preferred sources (highest to lowest):

1. Master Resume
2. Tailored Resume
3. LinkedIn
4. Portfolio
5. GitHub
6. Project documentation
7. User clarifications

---

# Core Rules

## RIE-001
Never invent experience.

## RIE-002
Treat every resume claim as evidence, not fact.

## RIE-003
Prefer measurable achievements over technology lists.

## RIE-004
Extract capabilities, not just tools.

## RIE-005
Unknown is better than guessing.

---

# Resume Analysis Workflow

1. Parse work experience.
2. Extract projects.
3. Extract measurable achievements.
4. Identify ownership.
5. Group technologies into capabilities.
6. Estimate capability depth.
7. Detect production experience.
8. Detect leadership signals.
9. Detect business impact.
10. Detect resume risks.
11. Generate Resume Intelligence.

---

# Capability Extraction

Convert technologies into capabilities.

Example:

Kafka → Event-driven architecture, Messaging, Delivery guarantees, Consumer design, Retry handling, DLQ, Scaling.

Redis → Caching, Session management, Performance optimization, Distributed coordination.

Never stop at the technology name.

---

# Capability Depth

Classify each capability.

Level 0 — Mentioned only
Level 1 — Used
Level 2 — Worked independently
Level 3 — Owned in production
Level 4 — Expert / Organization-level influence

---

# Ownership Classification

Identify ownership level: Contributed, Implemented, Designed, Owned, Led, Standardized, Mentored.

Ownership is more important than years of experience.

---

# Production Signals

Increase confidence when evidence includes: Production systems, On-call, Monitoring, Scaling, Incidents, Reliability, Customers, Revenue, Performance improvements.

---

# Business Impact

For every achievement identify: Problem, Action, Result.

Prefer quantified evidence.

Examples: Reduced latency, Reduced MTTR, Increased throughput, Reduced infrastructure cost, Improved developer productivity.

---

# Resume Signals

Look for: Architecture, Scale, Distributed Systems, AI, Security, Cloud, Reliability, Leadership, Product Thinking, Cross-functional work.

---

# Resume Risks

Common risks: Buzzwords without evidence, No measurable impact, Tool lists only, Weak ownership, Missing production experience, Missing business outcomes, Inconsistent seniority signals.

Do not assume these risks exist—report only when supported.

---

# Required Output

Every Resume Intelligence analysis should produce:

1. Resume Snapshot
2. Core Technical Strengths
3. Capability Matrix
4. Ownership Profile
5. Production Experience
6. Business Impact Summary
7. Leadership Signals
8. Resume Risks
9. Open Questions
10. Confidence Assessment

See [`schemas/resume-intelligence.schema.md`](../schemas/resume-intelligence.schema.md) and [`outputs/resume-intelligence-template.md`](../outputs/resume-intelligence-template.md).

---

# Validation Checklist

Before completing the analysis verify:

- Every major conclusion has evidence.
- Technologies were converted into capabilities.
- Ownership was identified.
- Business impact was extracted.
- Resume risks are evidence-based.
- Unknowns remain marked as Unknown.
- No experience was invented.

---

# Final Principle

Resume Intelligence exists to answer one question:

**"What can this candidate actually demonstrate?"**

Everything in later frameworks must be based on that evidence rather than assumptions.

## Related documents

- [`01-role-intelligence-framework.md`](01-role-intelligence-framework.md)
- [`04-role-fit-gap-analysis-framework.md`](04-role-fit-gap-analysis-framework.md)
- [`schemas/resume-intelligence.schema.md`](../schemas/resume-intelligence.schema.md)
- [`workflows/analyze-resume.md`](../workflows/analyze-resume.md)
