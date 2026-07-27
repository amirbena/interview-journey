# Context Priority

This document defines the platform-independent input priority order used across every framework, adapted from [Interview Journey Intelligence Input Priority](../frameworks/15-interview-journey-intelligence-framework.md#input-priority).

## Priority order

1. **Current user clarification** — anything the user states explicitly in the current turn.
2. **Confirmed interview-specific intelligence** — recruiter conversations, previous questions, previous feedback, interviewer information, assessments, and candidate observations already captured in Interview Intelligence (Framework 05).
3. **Current interview stage** — as identified by Framework 03.
4. **Role Intelligence** — as produced by Framework 01.
5. **Resume Intelligence** — as produced by Framework 02.
6. **General company or industry knowledge** — the lowest-priority source; usable only to fill gaps, never to override the sources above.

## Rules

1. When interviewer-specific evidence exists, prefer it over generic assumptions.
2. When new evidence conflicts with a previous inference, update the inference — do not silently keep the stale conclusion.
3. Never replace confirmed information with general interview stereotypes.
4. Do not ask for information that already exists in the active Interview Journey State (see [`state-management.md`](state-management.md)).
5. Ask one focused question only when the answer would materially change the preparation output — never as a matter of routine.
6. A later, explicit user correction always overrides earlier inference, even from earlier in the same conversation.
7. Do not claim access to context that was not actually supplied — no other conversations, no external accounts, no background monitoring.
8. Absence of prior Interview Journey State does not block a focused task that has sufficient input on its own.

## Worked example

If a candidate has already confirmed (in this conversation) that the next interview is a System Design round, and the Role Intelligence inferred "likely system design focus" with Medium confidence, the confirmed stage information (priority 3) overrides the inferred focus (derived from priority 4) — the system should proceed directly to System Design preparation without re-asking or re-deriving.

## Related documents

- [`evidence-policy.md`](evidence-policy.md)
- [`state-management.md`](state-management.md)
- [`orchestration-policy.md`](orchestration-policy.md)
- [`../frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md)
