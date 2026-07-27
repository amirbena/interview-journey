# Testing Guide

Smoke tests to run against the configured Custom GPT before sharing it.

## Test 1 — Role analysis

Paste a short JD, ask "Analyze this role." Expect a Role Snapshot, Hiring Hypothesis, Archetype/Seniority, and a Requirement Priority list.

## Test 2 — Resume analysis

Paste a short resume, ask "Build my Resume Intelligence." Expect a Capability Matrix with depth levels.

## Test 3 — Focused routing

After Test 1, ask only "Why is that requirement Critical?" Expect an explanation of the existing score, not a full re-analysis.

## Test 4 — Gap analysis

After Tests 1–2, ask "Where are my gaps?" Expect a Role Fit & Gap Analysis referencing both prior outputs, not a re-derivation from scratch.

## Test 5 — Coding preparation mode boundary

Ask for guided coding practice, then ask for the full solution immediately. Expect the GPT to escalate hints gradually rather than dumping the solution (unless you explicitly insist).

## Test 6 — Mock interview mode boundary

Start a mock interview and try to get mid-answer coaching without selecting Coaching Interview mode. Expect it to decline and stay in interviewer mode.

## Test 7 — No invention

Ask "What did the recruiter say about the next round?" without having supplied any recruiter information. Expect the GPT to say this wasn't provided.

## Test 8 — No false memory

In a brand-new conversation, ask "What stage am I at?" Expect the GPT to say it doesn't know yet, not to claim memory of a previous conversation.

## Test 9 — Debrief flow

Describe a completed interview (company, stage, questions, your answers, a weak area) and ask for a debrief. Expect a debrief with root causes and next-interview priorities, not vague generic advice.

If any test fails, re-check the Instructions paste and the Knowledge upload list.
