# Public Research Evidence Schema

**Schema ID:** public-research-evidence
**Version:** 1.0
**Used by:** [`workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md), Framework 05, Framework 01

> This schema defines the structured evidence package produced by the bounded research workflow. It is consumed by Framework 05 (Interview Intelligence merge), Framework 01 (Role Intelligence source precedence), and Frameworks 07–08 (question prediction and hypotheses). It is not an output format — it is an internal evidence handoff contract between the research workflow and the preparation frameworks.

---

## Required Fields

```yaml
research_objective: >
  # One-sentence statement of what was researched and why it matters for
  # the current preparation objective.

subject: >
  # The specific company, role, team, person, or interview process researched.

subject_type:
  # One of:
  - company
  - role
  - team
  - recruiter
  - interviewer
  - hiring_manager
  - interview_process
  - technical_assignment

retrieved_at: >
  # ISO 8601 timestamp of when this research package was assembled.
  # Required — a package without retrieved_at must not enter the evidence model.

research_status:
  # One of:
  - complete       # reliable findings were retrieved for all stated objectives
  - partial        # some objectives yielded findings; others did not
  - no_reliable_findings  # research ran but no findings met the reliability threshold
```

---

## Findings

```yaml
findings:
  - claim: >
      # The specific factual claim supported by this source.
      # Must be a single, falsifiable statement.
      # Do not bundle multiple claims into one finding.

    source_title: >
      # A short human-readable description of the source
      # (e.g., "Official company careers page", "Interviewer LinkedIn profile").

    source_reference: >
      # URL or description sufficient to locate the source.
      # If the source was inaccessible or only a snippet, state that explicitly.

    source_type:
      # One of (in decreasing reliability order):
      # official_website | careers_page | official_linkedin | person_linkedin |
      # person_public_post | engineering_blog | job_board |
      # candidate_interview_report | search_snippet | unknown

    published_at: >
      # Date the source was published or last updated, when visible.
      # Use null when not available — missing published_at reduces confidence.

    observed_at: >
      # Date the relevant content was observed on the source (e.g., date a post
      # was seen, distinct from its publish date). Use when published_at is
      # unavailable but the observation date is known.

    retrieved_at: >
      # Date this specific finding was retrieved. Required per finding.
      # A finding without retrieved_at must not enter the evidence package.

    specificity:
      # One of (most specific first):
      - role_specific     # directly about the target role
      - team_specific     # about the team hosting the role
      - company_specific  # about the company generally
      - industry_general  # general industry or domain knowledge

    reliability:
      # One of, derived from source_type:
      - high      # official website, careers page, engineering blog
      - medium    # LinkedIn profile, public post, job board
      - low       # candidate interview report, search snippet
      - unknown   # source inaccessible, private, or not assessed

    freshness:
      # One of, derived from published_at / observed_at / retrieved_at
      # relative to claim_type freshness expectations:
      - current   # retrieved recently; claim type is current or slow-changing
      - recent    # retrieved within a period appropriate to the claim type
      - aging     # older than preferred but not stale for this claim type
      - stale     # older than acceptable for the claim's freshness requirement
      - unknown   # no date information available

    evidence_status:
      # One of:
      - public_research_unverified
          # Retrieved from a public source; not corroborated by user-supplied evidence.
      - corroborated_public_research
          # Corroborated by: a current recruiter statement, a hiring-manager
          # statement, the current JD, an official current company/team source,
          # or multiple independent reliable sources.

    relevance_to_current_stage: >
      # Short statement of why this finding matters for the user's current
      # interview stage and preparation objective.
      # Required. Do not leave as generic — tie to the actual stage.

    confidence:
      # One of, reflecting source quality, specificity, reliability, and
      # freshness together:
      - high      # specific, reliable, current, corroborated
      - medium    # reasonably specific, medium reliability, recent
      - low       # low reliability, stale, general, or unverified
      - unknown   # insufficient information to assess
```

---

## Contradictions

```yaml
contradictions:
  - claim_a: >       # First conflicting claim (with its source)
    claim_b: >       # Conflicting claim (with its source)
    resolution: >    # How the conflict was resolved, or "preserved — cannot be resolved"
    impact_on_preparation: >  # What this means for the preparation output
```

---

## Open Questions

```yaml
open_questions:
  - question: >     # A specific information gap that research could not close
    impact: >       # Why this gap matters for preparation
    recommended_action: >  # How the candidate or Interview Journey should handle it
```

---

## Schema Rules

1. `research_objective`, `subject`, `subject_type`, `retrieved_at`, and
   `research_status` are required. A package missing any of these must not be
   merged into the Interview Intelligence evidence model.

2. Each finding requires: `claim`, a source identifier, `retrieved_at`,
   `reliability`, `freshness`, `evidence_status`, and `confidence`.

3. `preparation_implications` are not produced by this schema. Final
   preparation implications belong to Interview Journey's preparation
   frameworks (Frameworks 06–12), not to the research evidence layer.

4. Unsupported or source-free claims must not appear as findings. If a claim
   cannot be sourced, record it under `open_questions`.

5. Duplicate findings must be merged by claim and primary source. Do not
   produce multiple findings for the same claim from the same source.

6. When a newer role-specific finding conflicts with an older general finding,
   the newer role-specific finding takes precedence — but the older finding
   must remain traceable under `contradictions`.

7. `evidence_status` must not be set to `corroborated_public_research` unless
   at least one corroborating source outside public research exists (user-
   supplied recruiter statement, JD, hiring-manager statement, or multiple
   independent reliable public sources).

8. A `research_status` of `no_reliable_findings` does not block preparation.
   Interview Journey must proceed using confirmed user-supplied intelligence
   and general interview guidance. The absence of findings must be surfaced to
   the user when it materially affects preparation quality.

---

## Evidence Classification Mapping

This schema maps to `core/evidence-policy.md` as follows:

| evidence_status | core/evidence-policy.md class |
|---|---|
| `public_research_unverified` | Public research — unverified |
| `corroborated_public_research` | Public research — corroborated |

Public research evidence never maps to `Confirmed` in `core/evidence-policy.md`
regardless of how specific or reliable the source appears.

---

## Related Documents

- [`workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md)
- [`core/evidence-policy.md`](../core/evidence-policy.md)
- [`core/context-priority.md`](../core/context-priority.md)
- [`frameworks/05-interview-intelligence-framework.md`](../frameworks/05-interview-intelligence-framework.md)
- [`frameworks/01-role-intelligence-framework.md`](../frameworks/01-role-intelligence-framework.md)
