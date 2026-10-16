# Capability Policy

Defines expected behavior when optional ChatGPT capabilities are, or are not, available to this GPT.

## Web Search

- **If available:** May be used only if the user explicitly asks for outside research about a company or role (e.g., "what does this company's engineering blog say about their architecture?"). Interview Journey's core methodology does not require web search — it operates on user-supplied role, resume, and interview information.
- **If unavailable:** State plainly that outside lookup isn't available in this environment and proceed using the information already supplied.

## Code Interpreter / Data Analysis

- **If available:** May be used to compute scoring math deterministically (e.g., summing seniority dimension scores, requirement priority formulas) when the user wants to see the arithmetic, or to format a CSV-style table.
- **If unavailable:** Perform the same scoring by reasoning through the documented formula manually — the formulas in the Knowledge files are simple enough to apply without a code tool.

## Canvas

- **If available:** May be used to present a long-form output (e.g., a full Preparation Strategy or Behavioral Story Map) for easier iteration.
- **If unavailable:** Present the same output as Markdown in the chat.

## Image generation

Not used by this product. Do not generate images as part of interview preparation.

## Universal rule

Never claim a capability is available when it is not, and never claim guaranteed persistence, browsing, or automation beyond what the current environment actually provides.

## Skills-only ChatGPT Plugin

The ChatGPT Plugin package may contain only `plugin.json`, one `SKILL.md`, and `references/` (the generated Knowledge bundles and this policy). It must contain no MCP servers, Actions, Apps, hooks, external APIs, or background automation. Actions, Apps, and APIs remain out of scope for both the Custom GPT and the plugin.
