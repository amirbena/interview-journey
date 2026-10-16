# Natural Answer Mode

Natural Answer Mode helps you practice answers you could actually say to an interviewer. Instead of a structured, document-style reply, you get a direct answer in spoken language, the way a thoughtful engineer would talk to another person.

It is available in the ChatGPT Custom GPT, the Claude Skill, and the Claude Project, and behaves the same in all three.

## Why it exists

A thorough, well-formatted explanation is great for learning a topic and poor for answering a question out loud. Headings, bullet lists, generic openings, and recap conclusions make an answer sound generated. This mode drops them so the answer holds up when spoken.

The goal is not shorter answers. It is answers that sound credible read aloud while keeping the technical substance.

## Turning it on and off

The mode is **off by default**. There is nothing to configure.

| You say | Effect |
| --- | --- |
| "Natural answer mode on" | Applies to the rest of the conversation |
| "Answer this one in natural answer mode" | Applies to that single answer |
| "How would I say this in the interview?" | Applies to that single answer |
| "Natural answer mode off" | Back to normal output |

If it is unclear whether you meant one answer or the whole conversation, it applies to the current answer only.

## What changes

When the mode is on, answers:

- start with the direct answer to the question;
- use spoken prose, with no headings or bullet lists unless you ask for them;
- skip generic introductions and closing summaries;
- lead with the strongest relevant points;
- bring up trade-offs as part of the reasoning;
- keep the technical details that matter;
- admit uncertainty instead of inventing precision or metrics.

## What does not change

The mode changes delivery only. Technical correctness, evidence and accuracy rules, answer-coaching rules, and evaluation or scoring work exactly as before. In particular, it never invents experience: behavioral answers use only what you have told it.

## Asking for more depth

The first answer is deliberately focused. Ask a follow-up such as "go deeper", "give me an example", or "what could go wrong?" and it expands in the same voice with reasoning, a concrete example, trade-offs, failure modes, or relevant production experience.

## Preparation versus practice

- **Learning a topic:** ask for an explanation and you get the full breakdown, with or without the mode.
- **Practicing an answer:** turn the mode on and you get something you could say.

## Example

Question: "How does a database index speed up reads?"

> It lets the database skip scanning the whole table. A B-tree index keeps the keys sorted, so a lookup walks a few levels instead of reading every row. The cost is on writes, since every insert or update has to maintain the index, and it takes storage, so I only index columns that queries actually filter or join on.

More examples, covering technical, behavioral, system-design, and recruiter/HR questions, are in [`tests/fixtures/natural-answer-mode-examples.md`](../tests/fixtures/natural-answer-mode-examples.md).

## Where it is defined

The canonical rules (NAM-001 to NAM-005) live in [`frameworks/13-answer-coaching-framework.md`](../frameworks/13-answer-coaching-framework.md). Each platform package points to that definition rather than restating it.
