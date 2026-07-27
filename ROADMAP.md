# Roadmap

This roadmap tracks the high-level phases for building Interview Journey. Phases are sequential at a high level.

1. **Foundation** — repository structure, working rules, and high-level scope. **Completed.**
2. **Core Methodology** — the platform-independent product definition, terminology, scope, evidence/accuracy policy, context priority, quality gates, output contracts, state management, and workflow orchestration in `core/`. **Completed.**
3. **Frameworks** — the fifteen canonical frameworks (01 Role Intelligence through 15 Interview Journey Intelligence, the master orchestrator) in `frameworks/`, sourced from the provided reference specifications without fabrication. **Completed.**
4. **Schemas, Workflows, and Output Contracts** — thirteen structured record schemas, seventeen workflow adapters, and fourteen canonical output templates. **Completed.**
5. **Claude Skill** — installable Skill source (`claude/skill/`): `SKILL.md`, thirteen progressively-loaded references, fourteen output templates. **Completed** — packaged via `scripts/package-claude-skill.sh` / `.ps1` into `dist/interview-journey.skill.zip`.
6. **Claude Project** — full and compact Project Instructions, Skill trigger policy, state routing, knowledge manifest, artifact policy, conversation starters, setup guide. **Completed.** External self-install kit (`claude/external-install/`) packaged via `scripts/package-claude-external-kit.sh` / `.ps1` into `dist/interview-journey-claude-kit.zip`. **Completed.**
7. **ChatGPT GPT** — GPT Instructions, Builder configuration, capability policy, conversation starters, ten generated Knowledge bundles, setup/testing/sharing documentation. **Completed** — packaged via `scripts/package-chatgpt-gpt.sh` / `.ps1` into `dist/interview-journey-chatgpt.zip`.
8. **Packaging** — deterministic Bash and PowerShell scripts for all four build/package operations, with explicit allowlists and cross-platform parity by design. **Completed** for the scripts themselves; Windows PowerShell scripts have been statically reviewed for parity but not executed on a real Windows machine, since PowerShell was unavailable in the build environment — this remains a pending real-environment validation, not a known defect.
9. **Synthetic Example** — a complete, fully fictional worked journey (`examples/synthetic-candidate/`) demonstrating the frameworks, schemas, and output contracts together. **Completed.**
10. **Testing** — repository-native validation script (`tests/validate-repository.sh`) checking required files, framework numbering, Skill package structure, forbidden-file absence, and synthetic-example labeling. **Completed** for structural checks; deeper end-to-end behavioral testing against a live Claude/ChatGPT deployment remains a future task.
11. **MVP Release** — first usable release across all three product surfaces. **Not yet started** — pending real deployment and user testing of the packaged Skill, Project, and Custom GPT.

See [README.md](README.md) for project context and [core/product-definition.md](core/product-definition.md) for the product definition.
