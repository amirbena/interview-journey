# Workflow: Resume Interview Journey

Continues an Interview Journey from the latest valid [Interview Journey State](../schemas/interview-journey-state.schema.md) available in the active platform context, per [`core/workflow.md#resume-interview-journey`](../core/workflow.md#resume-interview-journey) and [`core/state-management.md`](../core/state-management.md).

## Purpose

Avoid restarting a journey from scratch when the user (or the active conversation/Project/Knowledge context) already has prior state to resume from.

## Required Inputs

An Interview Journey State — pasted, uploaded, or otherwise present in the active conversation context.

## Preconditions

- The state must be actually present in the active context — never assumed because a prior journey "seems likely."
- If no state is present, do not resume; proceed as a fresh [Full Interview Journey](full-interview-journey.md) or [Focused Task](focused-task-routing.md) instead.

## Procedure

1. Load the supplied Interview Journey State.
2. Identify `recommended_next_stage` / `upcoming_stage` and any `refresh_required` flags.
3. Identify the user's current request and reconcile it against the state (a new request may target a different stage than the state's last recorded one — the current request wins per [`core/context-priority.md`](../core/context-priority.md)).
4. Reuse every framework status still `Confirmed` and non-stale; do not re-run those frameworks.
5. Run only the frameworks needed to move the journey forward from its current point.
6. Update the Interview Journey State with any new evidence or completed stage.

## Outputs

An updated [Interview Journey State](../schemas/interview-journey-state.schema.md) plus whatever specific output the resumed work produces.

## State Updates

`last_updated_at` refreshes; only the statuses of frameworks actually re-run change.

## Quality Gates

Same per-output gates as the original stage — see [`core/quality-gates.md`](../core/quality-gates.md).

## Uncertainty Handling

If the supplied state is partial or ambiguous, proceed with what is valid and mark the rest `Unknown` rather than blocking.

## Explicit Non-Actions

- Never fabricate an Interview Journey State that was not actually supplied.
- Never claim cross-conversation memory the platform did not provide — see [Context Boundary](../core/state-management.md#context-boundary).
- Never re-run a `Confirmed` framework absent a reason to refresh it.

## Related documents

- [`../core/state-management.md`](../core/state-management.md)
- [`../core/context-priority.md`](../core/context-priority.md)
- [`full-interview-journey.md`](full-interview-journey.md)
- [`focused-task-routing.md`](focused-task-routing.md)
- [`../schemas/interview-journey-state.schema.md`](../schemas/interview-journey-state.schema.md)
