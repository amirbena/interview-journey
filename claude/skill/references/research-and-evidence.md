# Research and Evidence Reference

> Condensed Skill reference for current-research gating, freshness, provenance, privacy, and evidence handoff. This file adapts the canonical policy documents for in-Skill use. It does not redefine the canonical rules — it summarizes them for progressive loading.
>
> Canonical sources: [`core/evidence-policy.md`](../../../core/evidence-policy.md), [`core/context-priority.md`](../../../core/context-priority.md), [`schemas/public-research-evidence.schema.md`](../../../schemas/public-research-evidence.schema.md), [`workflows/research-current-interview-intelligence.md`](../../../workflows/research-current-interview-intelligence.md).

---

## When to Run Current Research

**Run** current research when the request depends on present-day facts the user has not supplied:
- Current JD or role (not provided).
- Current interviewer or hiring-manager role and context.
- Current interview process at the target company.
- Recent company engineering developments affecting preparation focus.
- Words like "current," "latest," "recent," or "today" about the company, team, or process.

**Optionally run** when research would materially change the answer:
- Company context is incomplete and signals might fill a preparation gap.
- Interviewer background could target a mock interview more precisely.

**Do not run** for:
- Coding drills, answer review, behavioral-story discovery.
- Debriefs based on user-provided evidence.
- Generic practice not tied to a specific company.
- Preparation fully determined by confirmed user-supplied information.

---

## Research Scope Constraint

Research only: company, role, team, interviewer (public context only), hiring manager (public context only), interview process.

Never: recruiter discovery, job-opportunity prospecting, outreach ranking, monitoring, or tracking.

---

## Evidence Classification

Apply `core/evidence-policy.md` classification to all research findings:

| Evidence Class | Description |
|---|---|
| `public_research_unverified` | Retrieved from public source; not corroborated by user-supplied evidence |
| `corroborated_public_research` | Corroborated by user's recruiter/JD/hiring-manager statement, or by multiple independent reliable sources |

Public research never becomes Confirmed regardless of source specificity.

---

## Freshness Rules (condensed)

| Claim Type | Freshness Requirement |
|---|---|
| Current employment / open role | Current — stale if retrieved weeks ago without corroboration |
| Current interview process | Fast-changing — prefer multiple current sources |
| Team ownership / structure | Moderate — label older sources |
| Company product domain | Slow-changing — older sources useful with staleness label |
| General interview patterns for role type | Stable — general guidance class applies |

- Evidence without `retrieved_at` must be treated as unknown freshness.
- Unknown freshness = general interview guidance confidence at most.

---

## Source Reliability (condensed)

| Source Type | Reliability |
|---|---|
| Official company website, careers page, engineering blog | high |
| LinkedIn company page, public profile of interviewer | medium |
| Reputable job board, public posts | medium |
| Candidate interview reports (Glassdoor, Blind) | low — possibility signals only |
| Search-result snippets | low — require corroboration |

---

## Privacy Constraints

**Allowed:** current professional role, company biography, public technical writing, public talks, official engineering material, publicly stated hiring responsibility, public interview-process descriptions.

**Prohibited:** private contact information, personal family data, sensitive personal attributes, private accounts, psychological profiling, manipulation strategies, hidden monitoring, persistent storage of personal research, sending candidate's private data into research tools.

Research findings are session evidence only — they must not be written into shared Skill files, templates, or repository assets.

---

## Context Priority (condensed)

Public research is always lower priority than user-supplied evidence:

1. Current user clarification
2. Confirmed interview-specific intelligence (user-supplied)
3. Current interview stage
4. Verified Role Intelligence (user-supplied)
5. Resume Intelligence
6. Corroborated current public research
7. Unverified current public research
8. General knowledge

Contradictions between priorities must be preserved, not silently resolved.

---

## Evidence Handoff

After research, pass findings through Framework 05 (merge intelligence) before using them in Frameworks 07 (question prediction) or 08 (hypotheses).

Interview Journey produces the final preparation output. Research findings inform preparation — they do not replace it.

---

## Related References

- [`stage-fit-and-interview-intelligence.md`](stage-fit-and-interview-intelligence.md) — Framework 05 merge
- [`question-prediction-and-hypotheses.md`](question-prediction-and-hypotheses.md) — QP-006–011, IH-007–010
- [`accuracy-and-quality.md`](accuracy-and-quality.md) — accuracy policy
