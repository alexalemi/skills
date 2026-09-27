# Reader-expectation analysis

Based on George D. Gopen and Judith A. Swan, "The Science of Scientific
Writing," *American Scientist* 78 (1990). Their claim: readers get most of
their interpretive cues from *where* things sit in a sentence, not only from
the words. When structure and substance disagree, readers spend their energy
working out the structure and have less left for the content, and different
readers come away with different meanings.

This is a diagnosis, not a line edit. The deliverable shows the author where
the structure sends the reader's attention, where that differs from what the
author presumably meant, and which connections the prose never states. For
sentence-level fixes, grammar, and voice, use line-edit mode; the two
work well one after the other (this one first).

Work **one section or a few paragraphs at a time.** The method is slow on
purpose. Ask which passage if the request doesn't say. In Typst, LaTeX, or
Markdown, read through the markup to the prose, and analyze captions too.

## The expectations

A *unit of discourse* is anything with a beginning and an end: clause,
sentence, paragraph, section.

1. **Subject then verb, quickly.** Readers hold their attention until the verb
   arrives. Anything long between subject and verb reads as an interruption,
   so as less important, even when it isn't.
2. **One unit, one job.** Each sentence, paragraph, and section is expected to
   make a single point.
3. **Stress position.** Readers emphasize whatever arrives at *syntactic
   closure*: the end of the sentence, or the end of an independent clause
   before a colon or semicolon. New, important information belongs there. A
   sentence is too long when it has more candidates for emphasis than
   it has stress positions, not when it passes some word count.
4. **Topic position.** The start of a sentence tells the reader *whose story*
   it is and links back to what came before. It should hold that
   protagonist and/or old information (already said in this passage).
   Passive voice is fine when it puts the right protagonist first ("Pollen is
   dispersed by bees" in a paragraph about pollen).
5. **Old before new.** Context before new material. Gopen & Swan call new
   information in the topic position "the No. 1 problem in professional
   writing": writers rush to get the new thought down, then add the linkage
   afterward. The principle is *not* "old at the front, new at the back."
   It is: put the old information that links backward in the topic position,
   and put the new information you want emphasized in the stress position.
6. **Action in the verb.** Readers look for the action in the verb. When the
   verbs are *is, has, are presumed to be, occurs* and the actions are buried
   in nouns (*inhibition, limitation, measurement*), readers have to guess
   what happened.
7. **Emphasis matches importance.** Overall, what the structure emphasizes
   should be what the substance says matters.

These are expectations, not rules. Good stylists break them on purpose,
which only works because they keep them most of the time. Don't flag a
deliberate break that pays off (a short punchy sentence with the new idea up
front after a long setup, a rhetorical inversion). Flag the patterns that
cost the reader.

## Procedure

For each paragraph:

1. **Extract three columns**, one row per sentence (split at semicolons
   and colons that close an independent clause, since each part has its own
   stress position):
   - **Topic:** the first few words that make up the grammatical subject or
     opening frame (skip bare connectives like "However," but keep them in
     mind for linkage).
   - **Stress:** the material after the point where the reader knows the
     sentence is ending.
   - **Verb:** the main verb, plus the words between it and its subject when
     that gap is more than about seven words (give the count).
2. **Read the topic column down.** Does it tell one story? Is each entry old
   information, meaning it appeared earlier in the passage? Name the
   string of old information that *actually* recurs (the earthquake example's
   "recurrence interval") and point out where it is kept out of the topic
   position.
3. **Read the stress column down.** Is each entry new and worth emphasis? Flag
   stress positions holding old material, filler ("in this case", "as shown
   above", a citation, a hedge), or an unintended candidate the reader will
   emphasize anyway. Flag sentences with two or three candidates and only
   one stress position.
4. **Read the verb column down.** Are the actions in the verbs? Name the
   buried action verbs you suspect (*inhibition* → *inhibits*).
5. **Check each link.** For each pair of consecutive sentences, does
   the second sentence's topic connect to something in the first, preferably
   its stress? When nothing connects, a logical step is missing. Write the
   connective the reader has to guess, bracketed with a question mark
   (*[However?]*, *[Because?]*, *[For example?]*), as Gopen & Swan do.
6. **Check the promise.** If a stress position sets something up ("has two
   effects", "both"), does the next sentence deliver it? Does the paragraph
   end on its point?
7. **State the questions.** Structural repair usually shows gaps in the
   substance. List the questions only the author can answer: which of two
   readings is meant, which transition is true, whether an interrupting
   phrase is essential (promote it) or an aside (cut it).

Where your guess about emphasis could be wrong, say so. Their
standard response applies: if a careful reader can't tell, the structure
didn't tell them.

## Output format

Plain text in document order. For each paragraph, a compact table of the
three columns, then findings, then questions. No praise, no summary of what
works, no severity scores.

```
¶2 "Large earthquakes along a given fault segment..."

   topic                         stress                               verb
1  Large earthquakes             time to accumulate strain energy     do not occur
2  The rates [new]               approximately uniform                are
3  Therefore... one [new]        constant time intervals              may expect
4  subsequent mainshocks [new]   periodic mainshocks... modified      have / must be modified
5  great plate boundary... [new] vary by a factor of 2                vary
6  the southern segment... [new] variations of several decades       is
7  The smaller the std dev [new] prediction of a future mainshock     could be

- Story: the recurring old information is "recurrence interval", but it never
  gets the topic position; six of seven topics are new. Reader can't tell whose story this is.
- S4: the new idea (different amounts of slip) is inside an if-clause; the stress
  holds the consequence. Consider "the recurrence time may vary; ... if
  subsequent mainshocks have different amounts of slip."
- S4→S5→S6: links unstated. [However?] [Indeed?] [For example?]
- S7 leaves the story of regular recurrence for one about prediction.

Questions
- Is the reason for non-random intervals in S1 or S2?
- Does the San Andreas figure illustrate the factor-of-2 variation or cut against it?
- Is the article going on to discuss periodic or irregular earthquakes? The last sentence points both ways.
```

Mark `[new]` on a topic entry that hasn't appeared earlier in the passage.
Give a suggested restructuring only when it's short and the intent is clear;
otherwise the question is the finding. Suggestions change *order and
structure*, not vocabulary or voice. When a revision needs a connective or a
fact you don't have, bracket it with `?`, don't make it up.

After the paragraphs, at most three **section notes**: whether each paragraph
has one job, whether the section's topic string (the first sentences of its
paragraphs) tells one story, and whether the section ends on its point.

## Red ink (on request)

Follow `red-ink.md`. Write note-only marks (plus `new` where a restructuring
is suggested), anchored on the sentence each finding concerns, with notes
prefixed by the expectation, e.g. `"S-V gap 23 words"`, `"stress: old info"`,
`"topic: new info"`, `"verb: action buried in 'inhibition'"`,
`"gap: [however?]"`. Still print the plain analysis, since the column tables
don't fit in a margin.

## What not to do

- Don't rewrite whole paragraphs. The point is for the author to see the
  structure; their revision will reflect their intent better than your guess.
- Don't flag long sentences for length alone. A 60-word sentence with a
  semicolon at each piece of new information is fine.
- Don't apply "active voice good, passive bad." Judge voice by whether it puts
  the right protagonist in the topic position.
- Don't simplify jargon or dilute the science. The aim is clarity, not plain
  English.
- Don't turn "old first, new last" into a rule you apply to every clause.
- Don't touch code, math, citation keys, or markup.
