# Role Fit & Gap Analysis Framework

**Document ID:** 04
**Version:** 1.0
**Depends on:** 01 – Role Intelligence, 02 – Resume Intelligence, 03 – Interview Stage Intelligence

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Compare what the company needs with what the candidate can demonstrate.

This framework must identify: Strong matches, Partial matches, Missing evidence, Preparation priorities.

It must never rewrite the resume or generate interview answers.

---

# Inputs

Required: Role Intelligence (01), Resume Intelligence (02).

Optional: Interview Stage (03), Recruiter information, Interview feedback, User clarifications.

---

# Core Rules

## GAP-001
Compare capabilities, not technology names.

## GAP-002
Evidence outweighs assumptions.

## GAP-003
Missing evidence is not proof of missing ability.

## GAP-004
Prioritize business-critical gaps.

## GAP-005
Current interview stage may change preparation priority, but not the gap itself.

---

# Matching Process

1. Load Critical and High role requirements.
2. Load candidate capabilities.
3. Match capabilities.
4. Measure evidence strength.
5. Detect missing evidence.
6. Score each gap.
7. Prioritize preparation.

---

# Match Levels

## Strong Match
Candidate has production evidence directly supporting the requirement.

## Partial Match
Transferable capability exists, but evidence is weaker.

## Weak Match
Limited or indirect evidence.

## Unknown
Insufficient information.

## Gap
Required capability lacks supporting evidence.

---

# Gap Classification

Every gap should be tagged as: Knowledge Gap, Experience Gap, Production Gap, Scale Gap, Architecture Gap, Leadership Gap, Communication Gap, Domain Gap, Resume Evidence Gap.

---

# Gap Priority

Score using: Business impact, Interview relevance, Requirement priority (Document 01), Candidate evidence strength, Time required to improve.

Priority: Critical, High, Medium, Low.

---

# Transferable Skills

Prefer transferable capabilities over exact tool matching.

Example: RabbitMQ experience may partially satisfy Kafka messaging expectations. Node.js backend experience may partially satisfy Java backend ownership expectations.

Do not require exact technology matches unless the role clearly does.

---

# Resume Evidence Gaps

If the candidate likely has the experience but the resume does not prove it:

Mark: **Resume Evidence Gap**

Recommend collecting stronger examples rather than learning a new skill.

---

# Preparation Recommendations

For every Critical or High gap identify: What should be studied, Whether evidence already exists, Whether clarification is needed, Whether the gap is acceptable.

Do not recommend unnecessary study.

---

# Required Output

1. Overall Role Fit
2. Top Strengths
3. Strong Matches
4. Partial Matches
5. Critical Gaps
6. High Priority Preparation Topics
7. Resume Evidence Gaps
8. Open Questions
9. Confidence

See [`schemas/fit-gap-analysis.schema.md`](../schemas/fit-gap-analysis.schema.md) and [`workflows/analyze-role-fit-and-gaps.md`](../workflows/analyze-role-fit-and-gaps.md).

---

# Validation Checklist

Before completing:

- Compared capabilities instead of tools
- Used evidence from Resume Intelligence
- Used priorities from Role Intelligence
- Distinguished unknown from missing
- Avoided inventing candidate experience
- Preparation focuses only on meaningful gaps

---

# Final Principle

Role Fit & Gap Analysis answers one question:

**"What is the shortest path between this candidate and success in the next interview?"**

## Related documents

- [`01-role-intelligence-framework.md`](01-role-intelligence-framework.md)
- [`02-resume-intelligence-framework.md`](02-resume-intelligence-framework.md)
- [`06-preparation-strategy-framework.md`](06-preparation-strategy-framework.md)
