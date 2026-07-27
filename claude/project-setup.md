# Project Setup Guide

How to stand up the Interview Journey Claude Project from the files in this repository.

## Steps

1. Create a Claude Project.
2. Install the packaged Skill — build `dist/interview-journey.skill.zip` (see [`packaging.md`](packaging.md)) and install it as the Project's Skill.
3. Paste the compact Project Instructions from [`project-instructions.compact.md`](project-instructions.compact.md) into the Project's instructions field. (See [`project-instructions.md`](project-instructions.md) for the full, explained version this is condensed from.)
4. Add the recommended shared Knowledge files listed in [`knowledge-manifest.md`](knowledge-manifest.md).
5. Optionally add private candidate workspace files (your own resume, in-progress Interview Journey State, or prior outputs) — see the private workspace section of [`knowledge-manifest.md`](knowledge-manifest.md). These are yours alone; do not add them to a shared or team Project.
6. Start with one of the prompts in [`conversation-starters.md`](conversation-starters.md), or describe your target role and background directly.
7. Verify the Skill is being used for in-scope requests — responses to role, resume, stage, fit/gap, preparation, coding/system-design/behavioral, mock interview, coaching, or debrief requests should follow the methodology (evidence, confidence, canonical output shapes) rather than free-form answers.
8. Keep personal data out of shared Project assets — real role, resume, or interviewer details belong only in your own conversation or your own private workspace files, never in shared Knowledge, the Skill package, or this repository.

## Distribution paths

### Organization Shared Project

For teammates within the creator's own Claude organization: share the Project within the same Claude organization, use restricted access unless editing is required, keep shared Knowledge free of personal candidate records, and ensure the Skill is separately available to users (Project sharing does not automatically install the Skill for everyone who gains access).

### External Self-Install

For anyone outside the creator's Claude organization: distribute the [external self-install kit](external-install/README.md) instead of relying on Project sharing. The user installs the Skill from the kit's embedded Skill ZIP, creates their own private Project, pastes the kit's included Instructions (copied byte-for-byte from [`project-instructions.compact.md`](project-instructions.compact.md) at packaging time), uploads the kit's included Knowledge files, and optionally adds their own private workspace files.

See [`external-install/README.md`](external-install/README.md) for the full flow and [`external-install/installation-checklist.md`](external-install/installation-checklist.md) for the step-by-step checklist.

## Responsibility table

| Layer | Responsibility |
|---|---|
| Core repository (`frameworks/`, `core/`, `schemas/`, `workflows/`, `outputs/`) | Canonical methodology |
| Claude Skill (`claude/skill/`) | Execution and progressive loading |
| Project Instructions | Conversation routing and UX |
| Project Knowledge | Shared methodology and optional private context |
| Claude platform | Available context, persistence, and retention |
| User | Inputs, corrections, privacy choices, and actions |

## What this setup does not guarantee

Installing the Skill and following this guide increases the likelihood that in-scope requests are handled with the Interview Journey methodology, but it does not guarantee automatic Skill activation on every message — the underlying platform decides when an installed Skill is invoked. It also does not provide cross-chat memory: nothing in this setup persists candidate data between conversations beyond what the platform itself retains and beyond whatever the user explicitly saves to their own private workspace files or Knowledge.
