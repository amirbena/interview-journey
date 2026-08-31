# Sharing and Publishing

Guidance for deciding the visibility of the Interview Journey Custom GPT.

## Visibility options

- **Only me** — recommended default while testing, or if this is purely a personal preparation tool.
- **Anyone with a link** — appropriate once the smoke tests in [`testing-guide.md`](testing-guide.md) pass and you're comfortable sharing the (methodology-only) Instructions and Knowledge with people you send the link to.
- **Public / GPT Store** — only appropriate once you've confirmed no personal data exists anywhere in the Instructions, Knowledge, or Conversation Starters, and you're comfortable with unrelated users interacting with it.

## Before sharing at any level beyond "Only me"

- Re-read every Knowledge file for accidental personal data.
- Re-read `instructions.md` and `conversation-starters.md` for the same.
- Confirm no Actions, Apps, or API credentials were configured.
- Confirm the profile image (if any) doesn't imply affiliation with a real employer or platform.

## After publishing

- This is a static configuration — publishing does not add capabilities like persistence, browsing, or automation beyond what was configured in the Builder.
- When you rebuild the Knowledge bundles later (via the build scripts), follow [`publishing-knowledge.md`](publishing-knowledge.md) to re-upload the three files and re-publish. That document also records why no supported API deployment exists and how to trace a live GPT back to a repository commit.
