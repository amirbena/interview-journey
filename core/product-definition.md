# Product Definition

## Purpose

Interview Journey is an evidence-driven interview preparation system. It prepares candidates for technical hiring processes using every piece of available interview information — the target role, the candidate's real resume evidence, the current interview stage, company and team context, previous recruiter conversations, previous interview questions, previous feedback, technical assessments, interviewer information, candidate observations, and lessons from earlier stages.

## Primary user journey

A candidate describes a target role (or shares a Job Description), their background, and whatever interview context they have. The system analyzes the role, analyzes the resume, identifies the current interview stage, compares the two into a fit/gap analysis, builds a preparation strategy, predicts likely questions, forms interview hypotheses, and then executes the specific preparation the candidate asked for — coding practice, system design practice, behavioral story building, a mock interview, answer coaching, a post-interview debrief, or offer and negotiation preparation. Every framework and canonical capability is orchestrated by the master workflow in [`frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md).

## Main outputs

- **Role Intelligence** — a structured interpretation of why the role exists and what it evaluates.
- **Resume Intelligence** — a structured account of what the candidate can actually demonstrate.
- **Interview Process Map** — the known or inferred stages of this specific hiring process.
- **Role Fit & Gap Analysis** — strengths, partial matches, and prioritized gaps.
- **Preparation Strategy** — the shortest, highest-impact plan for the next interview.
- **Question Predictions** and **Interview Hypotheses** — evidence-based expectations for the next interview.
- **Coding / System Design / Behavioral preparation sessions.**
- **Mock Interview Scorecards.**
- **Answer Coaching reviews.**
- **Post-Interview Debriefs** that feed back into Interview Intelligence.
- **Offer and Negotiation Preparation** — an evidence-grounded compensation position and natural responses for an offer conversation.
- **Interview Journey State** — the running record of a candidate's preparation journey.

## Structured but modular

The workflow follows a defined sequence (see [`workflow.md`](workflow.md)), but each stage is a self-contained, modular step. A user can request a single stage in isolation (e.g., "just analyze this role") without running the full journey.

## Success criterion

> Help the candidate perform better in the next interview with the least unnecessary work.

This is the single test every response must pass — see [`frameworks/15-interview-journey-intelligence-framework.md`](../frameworks/15-interview-journey-intelligence-framework.md#final-operating-principle).

## Related documents

- [`../README.md`](../README.md)
- [`scope-and-non-goals.md`](scope-and-non-goals.md)
- [`terminology.md`](terminology.md)
- [`../ROADMAP.md`](../ROADMAP.md)
