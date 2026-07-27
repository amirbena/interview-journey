# Installation Checklist

- [ ] Unzip `interview-journey-claude-kit.zip`.
- [ ] Create a new, private Claude Project.
- [ ] Install `skill/interview-journey.skill.zip` as the Project's Skill.
- [ ] Confirm the Skill is named `interview-journey`.
- [ ] Paste the full contents of `project-instructions.md` into the Project's Instructions field, unedited.
- [ ] Upload every file under `knowledge/` as Project Knowledge.
- [ ] Do **not** upload any real resume, JD, or interview notes as shared Knowledge — those stay in your own conversation or private workspace files (see [`privacy-guide.md`](privacy-guide.md)).
- [ ] Start a new conversation using a prompt from [`conversation-starters.md`](conversation-starters.md).
- [ ] Run the smoke tests in [`verification-guide.md`](verification-guide.md) to confirm the Skill is actually invoked for in-scope requests.
- [ ] Confirm the assistant does not claim cross-chat memory it doesn't have and does not invent candidate experience it wasn't given.
