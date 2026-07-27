# Context Priority

This document defines the platform-independent input priority order used across every framework, adapted from [Interview Journey Intelligence Input Priority](../frameworks/15-interview-journey-intelligence-framework.md#input-priority).

## Priority order

1. **Current user clarification** — anything the user states explicitly in the current turn.
2. **Confirmed interview-specific intelligence** — recruiter conversations, previous questions, previous feedback, interviewer information, assessments, and candidate observations already captured in Interview Intelligence (Framework 05).
3. **Current interview stage** — as identified by Framework 03.
4. **Verified Role Intelligence** — as produced by Framework 01 from user-supplied sources.
5. **Resume Intelligence** — as produced by Framework 02.
6. **Corroborated current public research** — public research evidence classified as `corroborated_public_research` per [`evidence-policy.md`](evidence-policy.md) and [`schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md). Current, specific, and supported by user-supplied corroboration.
7. **Unverified current public research** — public research evidence classified as `public_research_unverified`. Requires freshness and source metadata. Used only to fill gaps that affect preparation quality. Never overrides priorities 1–5.
8. **General company or industry knowledge** — the lowest-priority source; usable only to fill gaps, never to override the sources above.

## Rules

1. When interviewer-specific evidence exists, prefer it over generic assumptions.
2. When new evidence conflicts with a previous inference, update the inference — do not silently keep the stale conclusion.
3. Never replace confirmed information with general interview stereotypes.
4. Do not ask for information that already exists in the active Interview Journey State (see [`state-management.md`](state-management.md)).
5. Ask one focused question only when the answer would materially change the preparation output — never as a matter of routine.
6. A later, explicit user correction always overrides earlier inference, even from earlier in the same conversation.
7. Do not claim access to context that was not actually supplied — no other conversations, no external accounts, no background monitoring.
8. Absence of prior Interview Journey State does not block a focused task that has sufficient input on its own.

### Public research priority rules

9. Freshness does not automatically override specificity. A current generic company article does not outrank a slightly older role-specific recruiter statement.
10. Current user-provided evidence remains higher priority than public research (priorities 1–5 always outrank priorities 6–7) unless the user-provided evidence is explicitly outdated or incorrect.
11. Contradictions between public research and user-supplied evidence must be preserved rather than silently resolved.
12. Public research evidence classified as `public_research_unverified` (priority 7) may not outrank any evidence in priorities 1–5.
13. `corroborated_public_research` (priority 6) may inform preparation but must not be presented as Confirmed evidence.

## Worked example

If a candidate has already confirmed (in this conversation) that the next interview is a System Design round, and the Role Intelligence inferred "likely system design focus" with Medium confidence, the confirmed stage information (priority 3) overrides the inferred focus (derived from priority 4) — the system should proceed directly to System Design preparation without re-asking or re-deriving.

## Related documents

- [`evidence-policy.md`](evidence-policy.md)
- [`state-management.md`](state-management.md)
- [`orchestration-policy.md`](orchestration-policy.md)
- [`../frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md)
- [`../schemas/public-research-evidence.schema.md`](../schemas/public-research-evidence.schema.md)
- [`../workflows/research-current-interview-intelligence.md`](../workflows/research-current-interview-intelligence.md)
