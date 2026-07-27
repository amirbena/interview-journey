# Scope and Non-Goals

## MVP scope

The MVP covers the following capabilities, one per framework in [`frameworks/`](../frameworks/):

- Role Intelligence
- Resume Intelligence
- Interview Stage detection
- Role Fit and Gap Analysis
- Interview Intelligence (continuous enrichment)
- Preparation Strategy
- Question Prediction
- Interview Hypothesis generation
- Coding interview preparation and simulation
- System Design preparation and simulation
- Behavioral interview preparation
- Mock interviews (Full, Coaching, Lightning Round, Deep Dive, Executive, Panel)
- Answer coaching
- Post-interview debrief
- Continuous Interview Journey State tracking

## Non-goals

The following are explicitly out of scope for the MVP and must not be introduced without a future task explicitly requesting them:

- An application backend or frontend.
- Databases.
- External APIs.
- ChatGPT Actions.
- Claude MCP servers.
- Browser automation.
- LinkedIn or recruiter-platform automation.
- Hidden or automatic persistence of candidate data.
- Background monitoring of interview processes, recruiters, or companies.
- Fabricating missing interview methodology when a source framework is unavailable — see [`evidence-policy.md`](evidence-policy.md).
- Company ranking, recruiter discovery, outreach queues, or activity monitoring — those are Career Targeting Intelligence concerns, not Interview Journey concerns, and must not be copied in.

## Related documents

- [`product-definition.md`](product-definition.md)
- [`../README.md`](../README.md)
- [`../CLAUDE.md`](../CLAUDE.md)
