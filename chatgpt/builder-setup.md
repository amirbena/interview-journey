# Builder Setup Guide

Steps to configure the Interview Journey Custom GPT from this repository.

## Steps

1. Build the Knowledge bundles: `./scripts/build-chatgpt-knowledge.sh` (or `.ps1`).
2. Open the ChatGPT GPT editor and create a new GPT.
3. Set Name and Description from [`builder-config.md`](builder-config.md).
4. Paste [`instructions.md`](instructions.md) into the Instructions field, unedited.
5. Add the Conversation Starters from [`conversation-starters.md`](conversation-starters.md).
6. Upload all nine files from `chatgpt/knowledge/` as Knowledge.
7. Configure capabilities per [`capability-policy.md`](capability-policy.md) — leave Actions, Apps, and external APIs unconfigured.
8. Save as a draft and run the smoke tests in [`testing-guide.md`](testing-guide.md).
9. When satisfied, follow [`sharing-and-publishing.md`](sharing-and-publishing.md) to decide visibility.

## Alternative: build the deployable package

Instead of manual upload, build `dist/interview-journey-chatgpt.zip` with `./scripts/package-chatgpt-gpt.sh` (or `.ps1`) and use its contents (`instructions.md`, `knowledge/*.md`, `conversation-starters.md`) as the paste-ready source for the same steps above.
