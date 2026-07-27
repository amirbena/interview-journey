# Research Current Interview Intelligence

**Workflow ID:** WF-RCII-01
**Depends on:** Framework 01, Framework 05, Framework 07, Framework 08
**Schema:** [`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)

> This workflow extends Interview Journey with bounded current-research capability. It does not replace interview preparation with a research operation. Interview Journey remains the primary orchestrator and produces the final preparation output.

---

## When to Run This Workflow

### Research Required

Run this workflow when the request depends on present-day facts that the candidate has not already supplied, such as:

- The current Job Description (no JD provided by the user).
- A current interviewer or hiring-manager role and professional context.
- A current interview process at the target company.
- Recent company engineering developments affecting technical focus areas.
- Recent company or team changes affecting the hiring context.
- Recently reported interview topics at the target company.
- A current technical assignment brief not yet supplied.
- Current product or organizational priorities relevant to the role.
- Any request containing the words "current," "latest," "recent," or "today"
  about the company, team, interviewer, or interview process.

### Research Optional

Consider running this workflow when it would materially change the preparation:

- Role or company context is incomplete and public signals might fill the gap.
- Public company signals could improve question prediction confidence.
- The interviewer's public technical background could improve targeting for a
  mock interview.
- Recent engineering material may significantly alter the preparation focus.

Run it only when the research would change the answer in a material way. Do
not run it speculatively.

### Research Not Required

Do not run this workflow for:

- Coding drills and algorithm practice.
- Answer review and coaching.
- Behavioral-story discovery and STAR refinement.
- Post-interview debriefs based entirely on user-provided evidence.
- Generic system-design practice not tied to a specific company or team.
- Resume walkthrough practice.
- Preparation fully determined by confirmed recruiter or role information the
  candidate has already supplied.

---

## Scope Constraint

This workflow researches only:

- The target company, team, or role.
- The identified interviewer or hiring manager (public professional context only).
- The target company's interview process as publicly described.
- Technical areas publicly associated with the company's engineering work.

This workflow must never become:

- Recruiter discovery or outreach research.
- Job-opportunity prospecting.
- Ranking or prioritizing companies or contacts.
- Monitoring or tracking of any person or organization.

---

## Workflow Steps

### Step 1 — Identify the exact research objective

State the research objective in one sentence before proceeding.

Example: "Identify the current interview process at Company X for a senior
backend engineering role."

Reject vague objectives like "find out more about the company." Narrow to a
specific preparation-relevant question.

### Step 2 — Restrict the subject

Confirm the subject falls within allowed scope:

- company
- role
- team
- interviewer (public professional context only)
- hiring manager (public professional context only)
- interview process

If the research subject is outside this list, stop and explain why the
research falls outside Interview Journey scope.

### Step 3 — Use available current-research tools directly

Use any research tool available in the active environment to find current
public information.

Prefer direct and official sources (see adapted source hierarchy below).
Record the source title, source type, and retrieval timestamp for every
finding.

If no current-research tools are available, proceed with general knowledge
and explicitly label all findings as based on training data with an unknown
retrieval date.

### Step 4 — Record sources and dates

For every finding, capture:

- The source title or description.
- The source type (official website, careers page, public profile, public
  post, reputable job board, business database, secondary source, search
  snippet, or unknown).
- The date the source was published or observed (`published_at`), when
  visible.
- The date the source was retrieved (`retrieved_at`).

Do not proceed to normalization for any finding without a `retrieved_at`
timestamp.

### Step 5 — Normalize findings into the public-research evidence schema

Produce a structured evidence package using the fields defined in
[`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md).

Assign each finding:

- `specificity` — how closely the finding is scoped to the role, team, company,
  or industry.
- `reliability` — derived from source type (see Adapted Source Hierarchy below).
- `freshness` — derived from `retrieved_at` and `published_at` relative to the
  claim type (see Claim-Type Freshness below).
- `evidence_status` — `public_research_unverified` unless corroborated by a
  current recruiter statement, hiring-manager statement, the current JD, or
  multiple independent reliable sources.
- `confidence` — a single label reflecting source quality, specificity,
  reliability, and freshness together.

### Step 6 — Reject unsupported claims

Do not include a finding in the evidence package if it lacks:

- A source (even a general one).
- A `retrieved_at` timestamp.
- A reliability assessment.

Do not present inferred conclusions as directly sourced facts. If the claim
is a supported inference, label it as such.

### Step 7 — Merge evidence through Framework 05

Pass the evidence package to the Framework 05 merge workflow
([`workflows/merge-interview-intelligence.md`](merge-interview-intelligence.md)).

Apply Framework 05 rules:

- User-supplied direct interview evidence outranks conflicting unverified
  public research.
- Chronological order must be preserved using timestamps.
- Contradictions between user-supplied and research evidence must be preserved
  explicitly.

### Step 8 — Apply Framework 01 source precedence

When public research evidence is used in role analysis, apply Framework 01
source precedence. Public research evidence occupies tier 8 ("Reliable public
company information") by default.

Role-specific findings (e.g., a job post for the exact role) may occupy tier
6 ("Current company careers page") or tier 7 ("Current team or product page")
when the source directly describes the target role or team.

### Step 9 — Apply Frameworks 07 and 08 after confidence and freshness assessment

Pass normalized evidence to question prediction (Framework 07) and interview
hypothesis generation (Framework 08) only after the evidence package has been
assessed for confidence and freshness.

Apply the constraints defined in those frameworks:

- Label predictions as role-pattern based when current company evidence is
  absent.
- Reduce prediction confidence when research is stale or unverified.
- Never present public interview reports as guaranteed future questions.

### Step 10 — Return control to the user's objective

Research is complete when the normalized evidence package is ready.

Return to the user's original Interview Journey objective (question
prediction, mock interview, preparation strategy, etc.) using the enriched
evidence.

Do not present the research results as the final response. The final response
belongs to Interview Journey's preparation output.

---

## Adapted Source Hierarchy

Derived from the shared methodology, adapted for interview preparation context:

| Tier | Source Type | Reliability | Interview Use |
|---|---|---|---|
| 1 | Official company website | high | Company identity, product description |
| 2 | Official company careers page | high | Current role, team, hiring signal |
| 3 | Official company LinkedIn page | medium–high | Company identity, size signal |
| 4 | Public LinkedIn profile of interviewer or hiring manager | medium | Current title, employer, public background |
| 5 | Public post by the interviewer or hiring manager | medium | Authored interests, role mentions |
| 6 | Official engineering blog, public talk, open-source repo | medium–high | Technical domain, team priorities |
| 7 | Reputable job board | medium | Role availability signal |
| 8 | Candidate interview reports (Glassdoor, Blind, Levels.fyi) | low | Possibility signals only — not proof of future questions |
| 9 | Search-result snippet only | low | Starting point only — must be corroborated |
| 10 | Inaccessible or private content | none | Must not be used |

---

## Claim-Type Freshness

| Claim Type | Freshness Expectation |
|---|---|
| Current employment or open role | Current evidence required; stale if no `retrieved_at` or `published_at` within a recent period |
| Current interview process | Fast-changing; corroborate across multiple sources |
| Team ownership or structure | Moderately changing; prefer recent team-specific sources |
| Company product domain or technical area | Slow-changing; older sources still useful with a staleness label |
| General interview methodology | Stable; general interview guidance class applies |
| Interviewer public writing or talks | Prefer recent; older material still useful for topic signals with lower confidence |

For time-sensitive claims (current employment, open role, current process),
missing `published_at` lowers reliability from medium to unknown. Missing
`retrieved_at` excludes the finding from the evidence package.

---

## Privacy Constraints

Allowed public research subjects:

- Current professional role and employer (public profile).
- Company biography and product description.
- Public technical writing and engineering blog posts.
- Public conference talks and recordings.
- Official engineering material published by the company or its teams.
- Publicly stated hiring responsibility.
- Public interview-process descriptions from the company or candidates.

Prohibited research:

- Private contact information.
- Personal family information.
- Sensitive personal attributes.
- Private or restricted social accounts.
- Psychological profiling or personality analysis.
- Manipulation strategies targeting the interviewer.
- Any form of hidden monitoring or persistent tracking.
- The candidate's own private resume, interview history, or personal data sent
  into public research tools.

Research findings are session evidence only. They must not be stored as
persistent candidate records or written into shared Skill files, templates,
or repository documentation.

---

## Related Documents

- [`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)
- [`core/evidence-policy.md`](../core/evidence-policy.md)
- [`core/context-priority.md`](../core/context-priority.md)
- [`frameworks/05-interview-intelligence-framework.md`](../frameworks/05-interview-intelligence-framework.md)
- [`frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
- [`frameworks/07-question-prediction-framework.md`](../frameworks/07-question-prediction-framework.md)
- [`frameworks/08-interview-hypothesis-framework.md`](../frameworks/08-interview-hypothesis-framework.md)
- [`workflows/merge-interview-intelligence.md`](merge-interview-intelligence.md)
