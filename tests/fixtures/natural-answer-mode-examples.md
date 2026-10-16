# Natural Answer Mode — representative examples

Synthetic manual-review fixtures. Each pairs a normal answer with the same answer under Natural Answer Mode (NAM-001–NAM-005 in `frameworks/13-answer-coaching-framework.md`). Check: reads naturally aloud, same technical substance, no new claims, can be switched off, more depth available on request.

## Technical — "How does a database index speed up reads?"

**Normal:** "## Overview / An index is... / - B-tree / - Trade-offs / ## Conclusion..."

**Natural:** "It lets the database skip scanning the whole table. A B-tree index keeps the keys sorted, so a lookup walks a few levels instead of reading every row. The cost is on writes, since every insert or update has to maintain the index, and it takes storage, so I only index columns that queries actually filter or join on."

## Behavioral — "Tell me about a disagreement with a teammate." (candidate supplied a real story)

**Natural:** Uses only the supplied facts: what the disagreement was, what the candidate did, how it resolved. No invented metrics or outcomes; if the result is unknown, says so.

## System design — "Design a URL shortener."

**Natural:** "I'd start with the read path since it dominates: a key lookup behind a cache. For ids I'd generate them from a counter and encode them, which avoids collisions but needs a coordinated range allocator; hashing is simpler but needs collision handling. I'd confirm expected traffic before sizing storage."

## Recruiter/HR — "Why are you looking to leave?"

**Natural:** Short, honest, conversational; no invented reasons, no negativity beyond what the candidate stated.

## Mode control

- Default: normal output. "Natural answer mode on" → applies; "off" → reverts.
- "Go deeper" → same voice, adds reasoning, example, failure modes.
- "Explain how indexes work so I understand it" → preparation mode, thorough explanation.
