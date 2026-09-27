# CRIBS pass

A different job from the line edit: not fixing sentences but reporting how a
first-time reader *reacts*, so the author can cut what isn't pulling its
weight and expand what is. It follows David Perell's CRIBS formula. Run it
only when asked, or offer it in one line after a line edit of a full draft.

Read the section once, straight through, as a reader who doesn't know what
comes next. At every point where you have one of these reactions, mark it:

- **C, Confusing.** You had to reread, or you could not say what the sentence
  claims. Usually the author trying to sound smart or not yet thinking
  clearly. Say what you *thought* it meant.
- **R, Repeated.** This idea already appeared. Point to where.
- **I, Interesting.** You leaned in; you'd want more. Say what more.
- **B, Boring.** You wanted to skip, or your mind wandered. Say whether the
  idea is boring or only its delivery is, since the fixes differ (cut vs.
  rewrite).
- **S, Surprising.** You learned something you didn't expect. Note whether
  the setup earned it or the surprise was given away early.
- **X, Shorten or cut.** Not boring, but longer than its content: a restated
  point, a list of numbers that could be a table, a refrain on its third
  appearance. (An addition to Perell's five; dynomight's variant folds this
  into S, but S is taken here.)

Then judge weight. For every paragraph, one verdict: **keep**, **cut**,
**shrink** (to a sentence or a margin note), **expand**, or **move** (say
where). A section, or a single sentence, can get the same verdict when it is
the unit that's slack.

Honesty rules, because the pass is worthless without them:

- B and R must appear if they were felt. A pass that is all I and S was not
  read as a reader.
- Mark the reaction, not the cause. "B: I skimmed the three sentences about
  the textbook" is the finding; the author decides why.
- Don't fix prose here. If you notice a line edit, save it for the line-edit
  list.
- Mark granularly where the reaction is granular: a word, a sentence, a
  paragraph, a whole section. Don't average over a paragraph.

Output, in document order:

```
CRIBS: Section 1

- S  "Most published research findings are false."  Good opener; the surprise is stated, not built.
- B  "the classic teaching of statistics which presents the field as..."  Delivery: the sentence lists three ways of saying "rules". One would do.
- C  "In order to make sense of measurements..."  I read "it" as the context, not the measurements.
- I  "It was one of the papers that contributed to the discovery of vitamins."  One more sentence on how would earn the figure.
- R  "You can see the difference in the two groups."  Says what "You don't need math to tell you..." already said.

Weight
- P1 keep. P2 shrink to two sentences. P3 keep. P4 expand (the figure walkthrough). P5 cut the first sentence. P6 keep.
```

In red-ink mode (see `red-ink.md`), every paragraph that produced a reaction gets an entry
(margin notes too, when they are substantial); a paragraph that produced none
gets nothing, and the blank is the signal. Each entry anchors on the
paragraph's last sentence and carries `score` (C, R, I, B, S, X), `verdict`
(keep, cut, shrink, expand, move), and `note` (the why, one clause):

```json
{"old": "Unfortunately, none of us are gods.",
 "score": "I", "verdict": "keep", "note": "the Tuesday afternoon image sticks"}
```

The renderer prints these at the end of the paragraph in purple, distinct
from the red line-edit ink, as a boxed letter, the verdict, and the reason.
Keep the reason short; it sits inline. Line-edit marks and CRIBS marks can
share one edits file.
