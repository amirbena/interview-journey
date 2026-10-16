# Development

- Read [`AGENTS.md`](../AGENTS.md) and [`policies/git-workflow.md`](../policies/git-workflow.md) first.
- Validate before completing a change:

```bash
bash tests/validate-repository.sh
bash tests/validate-offer-negotiation.sh
claude plugin validate .
```

- Generated ChatGPT Knowledge bundles are rebuilt with `./scripts/build-chatgpt-knowledge.sh`; never edit them by hand.
- Packaging details: [packaging](packaging.md). Install commands: [installation](installation.md).
