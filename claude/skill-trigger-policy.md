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

## In-Scope Ownership

Interview Journey owns the request when the user's primary objective is:

- Preparing for a specific interview (any stage).
- Understanding what a recruiter or interviewer may ask.
- Researching a company for a current active interview.
- Researching an interviewer or hiring manager for a current active interview.
- Predicting likely interview questions.
- Building or running a mock interview.
- Coaching or reviewing a submitted answer.
- Preparing technical subjects (coding, system design, behavioral).
- Debriefing a completed interview.
- Planning the next interview stage.
- Researching current company or hiring-process information needed for the
  preparation above.

### Context does not change ownership

The presence of the following terms in a request does not remove it from
Interview Journey scope:

- recruiter, interviewer, hiring manager
- company, LinkedIn, recent, current, latest
- public information, research, online search

These may describe inputs, research targets, or evidence required within an
interview-preparation request. Interview Journey handles them directly — it
does not need another product or Skill to do so.

## Outside Scope

Interview Journey does not apply when the primary objective is:

- Finding open jobs or deciding which companies to apply to.
- Finding recruiters or hiring managers for unsolicited outreach.
- Building a recruiter list or outreach priority queue.
- Managing an application pipeline.
- General job search planning unrelated to a specific active interview.
- Tracking hiring activity across multiple companies.
- LinkedIn monitoring or recurring hiring-signal research.

These objectives are outside Interview Journey scope. Interview Journey does
not delegate them to another Skill and does not require another Skill to
handle them.

## Independent Operation

Interview Journey does not depend on other Skills.

It performs all interview preparation, including any current public research
required for that preparation, using its own frameworks and the research tools
available in the active environment. No other Skill needs to be installed for
Interview Journey to work correctly.

## Mutual understandability

These three categories are meant to be recognizable without ambiguity by matching a request against its examples above, not by any hidden signal. When a request plausibly spans two categories (for example, "why is this Critical, and can you also re-check whether my resume proves it?" mixes Partial Reference Use with Skill Methodology Required), treat it as belonging to the stronger category — do the new analysis the second half asks for, using only the framework it needs, rather than defaulting to the weaker category and under-delivering.
