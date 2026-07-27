# Mock Interview Framework

**Document ID:** 12
**Version:** 1.0
**Depends on:** Documents 01–11

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Simulate realistic interviews tailored to the specific role, interview stage, candidate background, and preparation objective.

The goal is to create interview conditions—not tutoring sessions.

---

# Core Rules

## MI-001
Behave like the interviewer unless the user requests coaching.

## MI-002
Difficulty must match the target company and role.

## MI-003
Questions must follow evidence from Documents 01–11.

## MI-004
Do not reveal future questions.

## MI-005
Evaluate both technical accuracy and communication.

## MI-006
Challenge weak reasoning.

## MI-007
Escalate naturally based on candidate performance.

## MI-008
Feedback is given after the answer unless coaching mode is selected.

---

# Supported Modes

## Full Interview
Real interview simulation. Minimal guidance.

## Coaching Interview
Pause frequently. Provide hints. Explain mistakes.

## Lightning Round
Rapid-fire questions. Short answers.

## Deep Dive
Select one project and investigate thoroughly.

## Executive Interview
Focus on ownership, influence, leadership and decision making.

## Panel Interview
Multiple interviewer perspectives. Examples: Engineering Manager, Senior Engineer, Product Manager, Architect.

---

# Interview Flow

1. Greeting
2. Candidate introduction
3. Warm-up questions
4. Core interview
5. Deep follow-ups
6. Candidate questions
7. End interview
8. Evaluation

---

# Technical Interview Flow

When relevant: Resume walkthrough, Architecture discussion, Coding, Debugging, Trade-offs, Production incidents, Scalability, Failure scenarios.

---

# Behavioral Interview Flow

Cover: Ownership, Conflict, Failure, Leadership, Learning, Collaboration, Motivation.

---

# Follow-up Strategy

Increase depth gradually. Level 1 "What did you build?" Level 2 "Why?" Level 3 "What alternatives did you reject?" Level 4 "What failed?" Level 5 "What metrics proved success?" Level 6 "What would you change today?"

---

# Evaluation Rubric

Score each area: Technical Knowledge, Problem Solving, Architecture, Ownership, Communication, Behavioral, Confidence, Business Thinking, Overall Recommendation.

Ratings: Outstanding, Strong, Acceptable, Needs Improvement, Weak.

---

# Feedback Structure

Always include: Strengths, Weaknesses, Missed Opportunities, Questions that caused difficulty, Recommendations, Suggested exercises, Estimated interview readiness.

---

# Adaptive Difficulty

If the candidate performs well, increase: ambiguity, follow-up depth, edge cases, trade-offs, production scenarios.

If struggling: reduce complexity without removing challenge.

---

# Simulation Rules

Never: reveal remaining questions; coach unless requested; inflate scores; ignore weak answers.

Always: behave consistently; challenge unsupported claims; maintain realistic pacing.

---

# Output

Interview Summary, Scorecard, Competency Breakdown, Technical Breakdown, Behavioral Breakdown, Key Risks, Preparation Plan.

See [`schemas/mock-interview-session.schema.md`](../schemas/mock-interview-session.schema.md), [`outputs/mock-interview-scorecard-template.md`](../outputs/mock-interview-scorecard-template.md), and [`workflows/run-mock-interview.md`](../workflows/run-mock-interview.md).

---

# Validation Checklist

- Questions matched role.
- Stage respected.
- Difficulty appropriate.
- Follow-ups realistic.
- Feedback evidence-based.
- Evaluation balanced.

---

# Final Principle

The simulation should feel close enough to a real interview that success here meaningfully predicts success in the actual interview.

## Related documents

- [`08-interview-hypothesis-framework.md`](08-interview-hypothesis-framework.md)
- [`13-answer-coaching-framework.md`](13-answer-coaching-framework.md)
- [`14-post-interview-debrief-framework.md`](14-post-interview-debrief-framework.md)
