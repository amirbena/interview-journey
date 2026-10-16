# Packaging

All packages are built from canonical sources with explicit allowlists, never a recursive repository copy. Each script has a Bash and a PowerShell twin that must stay logically equivalent. Outputs go to `dist/` (gitignored). Rules: [`policies/packaging-rules.md`](../policies/packaging-rules.md).

| Entry point | Output | Contents |
| --- | --- | --- |
| `package-claude-skill` | `interview-journey.skill.zip` | `skills/interview-journey/` (`SKILL.md`, `references/`, `templates/`) |
| `package-claude-plugin` | `interview-journey-claude-plugin.zip` | `.claude-plugin/plugin.json` + the same Skill under `skills/interview-journey/` |
| `package-claude-external-kit` | `interview-journey-claude-kit.zip` | Skill ZIP, compact Instructions, approved Knowledge, install guides |
| `package-chatgpt-gpt` | `interview-journey-chatgpt.zip` | Custom GPT Instructions, Knowledge bundles, deployment docs |
| `package-chatgpt-plugin` | `interview-journey-chatgpt-plugin.zip` | `plugin.json`, `skills/interview-journey/SKILL.md` (assembled from `chatgpt/plugin/SKILL.header.md` + `chatgpt/instructions.md`), generated Knowledge bundles and `capability-policy.md` as `references/` |

The plugin packagers accept an optional `RELEASE_VERSION` (semantic version). Unset, the committed manifest version is kept. Release orchestration belongs to the release workflow, not these scripts.

Marketplace manifests live in `.claude-plugin/` (`marketplace.json`, `plugin.json`) and point at `./skills/interview-journey`. Validate with `claude plugin validate .`.
