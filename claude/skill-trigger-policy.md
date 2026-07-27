# Skill Trigger Policy

Defines when a request needs the full Interview Journey Skill methodology, when it needs only a partial reference to existing results, and when it needs no Skill involvement at all. This lets the Project apply the [core routing rule](project-instructions.md#skill-usage-rules) — minimum required frameworks — consistently.

Claude does not need to expose Skill-invocation mechanics to the user (which reference file loaded, which framework ran). The user sees the result of the right amount of work, not the routing decision behind it.

## Skill Methodology Required

The request needs one or more Skill frameworks to run, producing new or updated evidence, analysis, or a new record:

- Role analysis (building or rebuilding Role Intelligence).
- Resume analysis (building or rebuilding Resume Intelligence).
- Interview-stage identification.
- Role Fit and Gap Analysis.
- Merging new interview intelligence.
- Building or rebuilding a Preparation Strategy.
- Question prediction.
- Interview hypothesis generation.
- Coding, system design, or behavioral preparation (including simulation and review).
- Running a mock interview.
- Coaching a submitted answer.
- Running a post-interview debrief.
- Producing a new artifact or canonical output from underlying records.

Route these to the specific framework(s) they need, per [`state-routing.md`](state-routing.md) — not to a full journey by default.

## Partial Skill Reference Use

The request references existing Skill output or methodology without generating new evidence or re-running a framework:

- Explaining an existing Role Intelligence priority score or archetype classification.
- Comparing two already-analyzed requirements or gaps.
- Updating the formatting or presentation of an existing output.
- Summarizing an already-produced output.
- Refreshing a single stale claim (not the whole record or journey).

These may still consult a Skill reference file to apply the methodology correctly, but they do not re-run analysis, simulation, or debrief from scratch.

## Skill Not Required

The request has nothing to do with the interview-preparation methodology:

- General product-help questions ("what can this Project do?").
- Unrelated conversation.
- Simple wording or tone changes to text already in the conversation.
- Questions about the repository's own setup or structure.

Handle these as ordinary conversation. Do not load any Skill reference file, and do not frame the response as if Skill methodology applied.

## Mutual understandability

These three categories are meant to be recognizable without ambiguity by matching a request against its examples above, not by any hidden signal. When a request plausibly spans two categories (for example, "why is this Critical, and can you also re-check whether my resume proves it?" mixes Partial Reference Use with Skill Methodology Required), treat it as belonging to the stronger category — do the new analysis the second half asks for, using only the framework it needs, rather than defaulting to the weaker category and under-delivering.
