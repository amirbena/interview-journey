# Interview Journey

Evidence-driven technical interview preparation, installable in Claude, Codex, ChatGPT, Cursor, and other skills-compatible agents.

## 1. Overview

Interview Journey is an evidence-driven interview preparation Skill: it turns your target role, real resume, and current interview stage into focused preparation, from role and fit analysis to mock interviews, answer coaching, debriefs, and offer negotiation. It works only from information you provide. One canonical Skill ([`skills/interview-journey/`](skills/interview-journey/)) is distributed for Claude, Codex, ChatGPT, Cursor, and other skills-compatible agents, and the methodology lives once in [`frameworks/`](frameworks/) and [`core/`](core/). See [`docs/features.md`](docs/features.md) for what it can do.

## 2. Installation

Skills-compatible agents (Cursor, Codex, Claude Code, and others):

```bash
npx skills add amirbena/interview-journey
```

```bash
npx skills add amirbena/interview-journey -a cursor -y
```

Claude Code plugin (register the marketplace, then install):

```bash
claude plugin marketplace add amirbena/interview-journey
```

```bash
claude plugin install interview-journey@interview-journey
```

Codex (reads the same marketplace):

```bash
codex plugin marketplace add amirbena/interview-journey
```

The Claude.ai Skill ZIP, the Claude Project kit, and the ChatGPT Plugin (the primary ChatGPT option) are built locally. The ChatGPT Plugin install is **unverified** in Codex CLI and ChatGPT Desktop:

```bash
./scripts/package-claude-skill.sh
./scripts/package-claude-external-kit.sh
./scripts/package-chatgpt-plugin.sh
```

Unverified until the layout is on `main`: every GitHub-based command above (`npx skills add`, the Cursor variant, `claude plugin marketplace add` / `claude plugin install`, and `codex plugin marketplace add`) and the ChatGPT Plugin install. Verification status of each is in [`docs/installation.md`](docs/installation.md). The legacy Custom GPT is deprecated; see [`docs/chatgpt-migration.md`](docs/chatgpt-migration.md).

## 3. Usage

Start a conversation with the information you have, for example:

- "Here is the job description and my resume. Analyze the role and my fit."
- "I have a system design interview next week. Build my preparation plan."
- "Run a mock behavioral interview and coach my answers."
- "I got an offer. Help me prepare to negotiate."

Optional [Natural Answer Mode](docs/natural-answer-mode.md) gives spoken-style answers for practice.

## 4. How It Works

Fifteen frameworks (01–14 specialized modules, 15 the master orchestrator) define the methodology; the Skill routes each request to only the modules it needs and keeps evidence states explicit. State is a logical record carried through your files and conversation; there is no backend, database, Action, MCP server, or background automation. See [`docs/architecture.md`](docs/architecture.md) and [`core/orchestration-policy.md`](core/orchestration-policy.md).

## 5. Documentation

- [`docs/features.md`](docs/features.md) — what Interview Journey can do
- [`docs/installation.md`](docs/installation.md) — every install path and its verification status
- [`docs/chatgpt-migration.md`](docs/chatgpt-migration.md) — Custom GPT → ChatGPT Plugin migration
- [`docs/architecture.md`](docs/architecture.md) — architecture, frameworks, repository structure
- [`docs/packaging.md`](docs/packaging.md) — package entry points
- [`docs/development.md`](docs/development.md) — contributing and validation
- [`docs/natural-answer-mode.md`](docs/natural-answer-mode.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md), [`ROADMAP.md`](ROADMAP.md), [`CHANGELOG.md`](CHANGELOG.md)
- [`AGENTS.md`](AGENTS.md), [`CLAUDE.md`](CLAUDE.md), [`policies/`](policies/)
