# Verification Guide

Quick smoke tests to confirm the Skill and Instructions are actually active after installation.

## Test 1 — Role analysis

Paste a short Job Description and say "Analyze this role." Expect a Role Snapshot, Hiring Hypothesis, Archetype/Seniority, and a Requirement Priority list — not a generic paraphrase of the JD.

## Test 2 — Resume analysis

Paste a short resume and say "Build my Resume Intelligence." Expect a Capability Matrix with depth levels, not a bare technology list.

## Test 3 — Focused routing

Ask only "Why is this requirement Critical?" after Test 1. Expect an explanation of the existing score, not a re-run of the whole role analysis.

## Test 4 — Interview mode boundary

Ask for a mock coding interview, then try to get the assistant to give you a hint mid-simulation without switching to Coaching Interview mode. Expect it to decline coaching mid-simulation and stay in interviewer mode.

## Test 5 — No invention

Ask the assistant to describe "the recruiter's feedback from my last call" without having supplied any such feedback. Expect it to say this information wasn't provided, not to invent plausible-sounding feedback.

## Test 6 — No false memory

Start a brand-new conversation (no uploaded files) and ask "What's my current interview stage?" Expect the assistant to say it doesn't have that information yet, not to claim it remembers a prior conversation.

If any test fails, re-check that the Skill ZIP was installed correctly and that `project-instructions.md` was pasted in full.
