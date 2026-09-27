# Red ink

Shared by every mode. When the author asks to see the marks on the page (red
ink, markup, margin notes, redline, "let me make the edits myself"), produce
the mode's usual notes and additionally render them onto a copy of the document:

1. Write the edits as JSON to the scratchpad, one object per mark:

   ```json
   [
     {"old": "we need to have something to compare it against",
      "new": "we need to have something to compare them against",
      "note": "measurements is plural"},
     {"old": "The central idea of statistics is that _a number is meaningless without context_.",
      "note": "consider moving to the end of the paragraph as its conclusion"},
     {"old": "Its making an _argument_, by means of _comparison_.",
      "new": "It's making an _argument_ by means of _comparison_."}
   ]
   ```

   `old` and `new` may be whole sentences; the renderer diffs them word by
   word and marks only the words that change, so a one-word fix inside a
   long sentence shows as one struck word and one inserted word. Give
   enough of the sentence to anchor uniquely, no more.

   Rules for `old`: copy it verbatim from the source **including markup**
   (`_italics_`, `#source(...)`, etc.), long enough to be unique, and never
   crossing a blank line or a `#marginfigure(...)`/`#figure(...)` block. Line
   wrapping doesn't matter; matching ignores whitespace differences. `new`
   is the replacement (omit it for a note-only mark); `note` is the margin
   comment (omit it for a self-evident fix). Humor suggestions go in as
   note-only marks prefixed `optional:`, or as a `new` with a note saying
   `optional`.

2. Run the renderer, which sits in this skill's directory:

   ```
   python3 <this skill's directory>/redline.py DRAFT.typ EDITS.json
   ```

   It writes `DRAFT.redline.typ` beside the source and compiles
   `DRAFT.redline.pdf` (typst `--root` defaults to the source's directory;
   pass `--root` if the project uses another). It compiles with
   `--input booklet=1` by default, which the author's Tufte template reads to
   produce half-letter booklet pages; `--letter` drops it and `--input
   KEY=VAL` passes anything else. Deletions appear struck
   through in red, insertions in red, notes as numbered red margin notes
   using the template's `marginnote` when it has one, footnotes otherwise.
   Non-Typst sources get an HTML redline instead. The original is never
   modified.

3. Read the script's report. Any mark listed as NOT FOUND or AMBIGUOUS was
   skipped: fix its `old` and rerun. When rerunning after the author has
   applied some edits, NOT FOUND usually means that edit is already in; say
   so rather than rewriting it. Then tell the author the PDF path and
   still print the plain notes list, since some prefer reading it there.

4. The `*.redline.*` files are disposable build products; suggest adding
   that pattern to `.gitignore` if it isn't there.

Mode-specific marks: CRIBS scores are described in `cribs.md`; reader-expectation notes in `reader-expectations.md`. All mark types can share one edits file.
