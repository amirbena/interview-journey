# Interview Journey

Evidence-driven technical interview preparation. Give it the target role, your real resume, and where you are in the hiring process; it builds role and resume analysis, fit and gap analysis, a focused preparation strategy, likely questions, mock interviews, answer coaching, post-interview debriefs, and offer-negotiation preparation. It works only from information you provide.

## 1. Overview

One canonical Skill ([`skills/interview-journey/`](skills/interview-journey/)) is distributed for Claude, Codex, ChatGPT, Cursor, and other skills-compatible agents. The methodology lives once in [`frameworks/`](frameworks/) and [`core/`](core/).

## 2. Installation

Skills-compatible agents (Cursor, Codex, Claude Code, and others):

```bash
npx skills add amirbena/interview-journey
npx skills add amirbena/interview-journey -a cursor -y
```

Claude Code marketplace:

```text
/plugin marketplace add amirbena/interview-journey
/plugin install interview-journey@interview-journey
```

Codex (reads the same marketplace):

```bash
codex plugin marketplace add amirbena/interview-journey
```

Claude.ai Skill ZIP, Claude Project kit, ChatGPT Custom GPT, and ChatGPT Plugin packages are built locally:

```bash
./scripts/package-claude-skill.sh
./scripts/package-claude-external-kit.sh
./scripts/package-chatgpt-gpt.sh
./scripts/package-chatgpt-plugin.sh
```

Each command is labeled verified or unverified in [`docs/installation.md`](docs/installation.md); anything not yet verified from GitHub is marked there.

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

- [`docs/installation.md`](docs/installation.md) — every install path and its verification status
- [`docs/architecture.md`](docs/architecture.md) — architecture, frameworks, repository structure
- [`docs/packaging.md`](docs/packaging.md) — package entry points
- [`docs/development.md`](docs/development.md) — contributing and validation
- [`docs/natural-answer-mode.md`](docs/natural-answer-mode.md)
- [`core/scope-and-non-goals.md`](core/scope-and-non-goals.md), [`ROADMAP.md`](ROADMAP.md), [`CHANGELOG.md`](CHANGELOG.md)
- [`AGENTS.md`](AGENTS.md), [`CLAUDE.md`](CLAUDE.md), [`policies/`](policies/)
