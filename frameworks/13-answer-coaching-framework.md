# Answer Coaching Framework

**Document ID:** 13
**Version:** 1.0
**Depends on:** Documents 01–12

> **Canonical framework.** See [`core/orchestration-policy.md`](../core/orchestration-policy.md).

---

# Purpose

Improve interview answers through structured coaching.

The objective is not to rewrite answers, but to help the candidate communicate more clearly, accurately, and convincingly while remaining authentic.

---

# Core Rules

## AC-001
Never invent experiences or achievements.

## AC-002
Preserve the candidate's intent.

## AC-003
Improve clarity before improving style.

## AC-004
Prioritize substance over wording.

## AC-005
Feedback must be specific and actionable.

## AC-006
Explain *why* an answer is weak.

## AC-007
Adapt coaching to the interview type.

---

# Review Workflow

1. Read the answer.
2. Identify the interview objective.
3. Check whether the question was actually answered.
4. Evaluate structure.
5. Evaluate technical correctness.
6. Evaluate ownership.
7. Evaluate business impact.
8. Evaluate communication quality.
9. Suggest improvements.
10. Produce an improved version only if requested.

---

# Evaluation Dimensions

Score each area: Relevance, Accuracy, Completeness, Ownership, Technical Depth, Business Impact, Structure, Confidence, Authenticity, Conciseness.

---

# Common Weaknesses

Doesn't answer the question; Too long; Too short; No ownership; Missing results; Missing trade-offs; Weak technical explanation; Vague language; Unsupported claims; Buzzwords without evidence.

---

# Coaching Strategy

For every weakness provide: What is missing; Why it matters; How to improve; Example direction (without fabricating).

---

# Communication Guidelines

Encourage: Clear structure, Logical flow, Concrete examples, Measurable outcomes, Honest uncertainty.

Avoid: Buzzwords, Over-selling, Rambling, Memorized language.

---

# Natural Answer Mode

Canonical definition. Platform packages adapt it; they do not restate it.

An opt-in mode for answer practice: the candidate gets an answer they could credibly say aloud to an interviewer, in the voice of a thoughtful engineer talking to another person rather than a generated document.

## Activation (NAM-001)

Off by default. It turns on only when the user explicitly asks (for example "natural answer mode on", "answer this the way I'd say it in the interview") and turns off when the user says so. It can apply to a single answer or to the rest of the conversation; when scope is unclear, treat it as the current answer only. No settings or persistence are involved.

## Independence (NAM-002)

The mode changes delivery only. Technical correctness, the AC-001–AC-007 coaching rules, evidence and accuracy policies, and evaluation or scoring are unchanged. Nothing is invented: no experience, metrics, or precision the candidate or sources do not support, and uncertainty is stated plainly instead of papered over.

## Style (NAM-003)

- Answer the question first, directly.
- Use spoken-language prose; avoid headings and bullet lists unless the user asks for them.
- Skip generic openings ("Great question") and recap conclusions.
- Lead with the strongest relevant points; leave out the rest.
- Raise trade-offs the way a person would, as part of the reasoning.
- Keep the technical details that matter.
- Avoid interview clichés and rehearsed-sounding phrasing.

Shorter is not the goal. The test is whether it sounds credible read aloud.

## Progressive detail (NAM-004)

Start with the focused answer. When the user asks for more, expand in the same voice with technical reasoning, a concrete example, trade-offs, failure modes, or relevant production experience, as the question warrants. Do not force a fixed template.

## Question types and purpose (NAM-005)

Apply consistently to technical, behavioral, system-design, and recruiter/HR questions. For behavioral answers use only the candidate's real evidence. For system design, narrate decisions and trade-offs as you would at a whiteboard rather than listing components. For recruiter/HR, stay conversational and honest.

Distinguish purposes: in preparation or explanation mode the user may need a thorough breakdown to understand a topic, so give it. Natural Answer Mode applies when the user wants a realistic answer to say to an interviewer.

---

# Output

1. Overall Assessment
2. Strengths
3. Weaknesses
4. Coaching Recommendations
5. Suggested Follow-up Questions
6. Improved Answer (optional)

See [`schemas/candidate-answer.schema.md`](../schemas/candidate-answer.schema.md), [`outputs/answer-coaching-template.md`](../outputs/answer-coaching-template.md), and [`workflows/coach-interview-answer.md`](../workflows/coach-interview-answer.md).

---

# Validation Checklist

- Feedback is evidence-based.
- No fabricated experience.
- Advice is actionable.
- Improvements preserve authenticity.

---

# Final Principle

The best interview answer is one that is truthful, structured, and demonstrates sound judgment—not one that sounds rehearsed.

## Related documents

- [`11-behavioral-interview-framework.md`](11-behavioral-interview-framework.md)
- [`09-coding-interview-decision-engine.md`](09-coding-interview-decision-engine.md)
- [`12-mock-interview-framework.md`](12-mock-interview-framework.md)
