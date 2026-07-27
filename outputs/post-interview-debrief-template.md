# Post-Interview Debrief Template

Markdown presentation template for the Post-Interview Debrief output, built from an [Interview Debrief record](../schemas/interview-debrief.schema.md) per [Framework 14 Required Output](../frameworks/14-post-interview-debrief-framework.md#required-output). All values below are synthetic.

## Disclaimer

> Rejection or advancement reasons are never assumed without evidence. Facts, candidate interpretation, and system inference are kept separate.

## Required Sections

1. Interview Summary
2. Strengths
3. Weaknesses
4. Root Causes
5. Recurring Patterns
6. Updated Interview Intelligence
7. Updated Preparation Plan
8. Next Interview Priorities

## Synthetic Example

### Interview Summary
System Design round at Northbridge Payments, 2026-07-20, with Alex R. (Staff Engineer).

### Weaknesses
Underspecified failure handling for cross-region writes.

### Root Causes
Knowledge gap — candidate had not previously studied cross-region consistency trade-offs.

### Next Interview Priorities
1. Practice a cross-region failure-handling design 2. Review the outbox and saga patterns again with a failure-injection lens.

## Related documents

- [`../schemas/interview-debrief.schema.md`](../schemas/interview-debrief.schema.md)
- [`../frameworks/14-post-interview-debrief-framework.md`](../frameworks/14-post-interview-debrief-framework.md)
- [`interview-journey-state-template.md`](interview-journey-state-template.md)
