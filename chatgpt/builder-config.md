# Builder Configuration

Paste-ready fields for configuring the Interview Journey Custom GPT in the GPT editor. See [`builder-setup.md`](builder-setup.md) for the step-by-step process this configuration fits into.

## Name

```text
Interview Journey
```

## Description

```text
An evidence-driven system for personalized technical interview preparation, simulation, answer coaching, and continuous improvement across the full hiring journey.
```

## Instructions source

```text
chatgpt/instructions.md
```

Paste the entire content of that file into the GPT's Instructions field, unedited.

## Conversation Starters

```text
chatgpt/conversation-starters.md
```

Add each starter listed there as one of the GPT's Conversation Starters.

## Knowledge uploads

Upload all three generated bundles under `chatgpt/knowledge/`:

1. `01-product-orchestration-and-quality.md`
2. `02-role-resume-and-strategy.md`
3. `03-interview-execution.md`

These are generated files — build or rebuild them with `scripts/build-chatgpt-knowledge.sh` (or `.ps1`) rather than editing them by hand. See [`knowledge-manifest.md`](knowledge-manifest.md) for what each bundle contains and where it comes from, and [`publishing-knowledge.md`](publishing-knowledge.md) for the update-and-publish procedure.

## Recommended capabilities

- **Web search** — optional; not required for core functionality since this product does not perform company or people research. See [`capability-policy.md`](capability-policy.md).
- **Code Interpreter / Data Analysis** — optional, useful for deterministic scoring math if the user wants it computed live.
- **Canvas** — optional, enable if available; not required.
- **Image generation** — disabled, unless a future product requirement needs it.

## Not configured

- **Actions** — not configured. This package defines no Action schema.
- **Apps / connectors** — not configured.
- **External APIs** — not configured.

## Profile image

Document only a high-level visual brief for whoever creates the image — this task does not generate it:

- Professional, clean.
- Interview / preparation theme (for example, an abstract compass, checklist, or dialogue motif).
- No company logos.
- No misleading affiliation with any employer, job board, or platform.
