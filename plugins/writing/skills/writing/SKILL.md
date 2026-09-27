---
name: writing
description: Editorial feedback on prose (Typst, Markdown, LaTeX, plain text) the way a trusted human editor would give it. Use when the user asks to "edit", "proofread", "line edit", "give feedback on my writing", "tighten this", "cribs", "is every paragraph pulling its weight", "what's boring", "why is this hard to read", "check the flow", "topic and stress positions", "old/new information", "Gopen and Swan", "reader expectations", or wants red-ink markup on a compiled copy. Three modes, line edit (specific rewrites in document order), CRIBS (a first-time reader's reactions plus a keep/cut/shrink/expand verdict per paragraph), and reader-expectations (Gopen & Swan structural diagnosis of topic, stress, and verb positions and logical gaps), any of which can be rendered as red ink via redline.py. Gives notes, not a rewritten document.
---

# Writing

Editorial passes on a draft. Each mode has its own instructions in this
directory; read the one you need before starting, and only that one.

| Mode | Read | Use when the author asks | Answers |
|---|---|---|---|
| Line edit | `line-edit.md` | "edit", "proofread", "line edit", "feedback on my writing" | Which sentences should change, and to what? |
| CRIBS | `cribs.md` | "cribs", "what's boring", "is every paragraph pulling its weight", "tighten this" | How does a first-time reader react, and what should be cut or expanded? |
| Reader expectations | `reader-expectations.md` | "why is this hard to read", "check the flow", "Gopen and Swan", "topic/stress" | Where does the structure put the reader's attention, and what connections are missing? |

Shared files:

- `style.md`: the author's voice profile. Read it before any mode that
  suggests wording (line edit, and any rewrite in the other two).
- `red-ink.md` and `redline.py`: render any mode's marks onto a compiled copy
  when the author wants to see them on the page. Marks from several modes can
  share one edits file.

## Choosing a mode

- If the request names a mode or clearly matches one row, use it.
- "Edit this" or "give me feedback" with no more detail means **line edit**;
  offer CRIBS in one line afterwards for a full draft.
- If the author says it's hard to follow, confusing, or doesn't flow, and
  the sentences themselves seem fine, use **reader expectations**.
- For a **full review**, run them from structure down to sentences:
  reader expectations, then CRIBS, then line edit. Fixing structure
  often moves or removes sentences, so line-editing first wastes the edits.
  Keep each mode's output in its own labeled block.

In every mode, work one section at a time unless asked otherwise, and ask
which section if the request doesn't make it clear.
