#!/usr/bin/env janet
# PEG (Parsing Expression Grammar) Examples

# Basic pattern matching
(def text "hello world")
(def result (peg/match '(* "hello" :s+ (capture :w+)) text))
(printf "Captured word: %q\n" result)

# Parse numbers
(def number-peg '(* (? "-") (some :d) (? (* "." (some :d)))))
(printf "Match '123': %q\n" (peg/match number-peg "123"))
(printf "Match '-45.67': %q\n" (peg/match number-peg "-45.67"))

# Parse email addresses
(def email-peg
  '(* (capture (some (+ :w (set ".-_"))))
      "@"
      (capture (some (+ :w (set ".-"))))))

(def email "user.name@example.com")
(def parsed-email (peg/match email-peg email))
(printf "Email parts: %q\n" parsed-email)

# Parse simple CSV
(def csv-line "Alice,30,Engineer")
(def csv-peg
  '(* (capture (some (if-not "," 1)))
      (any (* "," (capture (some (if-not "," 1)))))))

(def csv-parsed (peg/match csv-peg csv-line))
(printf "CSV fields: %q\n" csv-parsed)

# Parse and transform
(def version-text "v1.2.3")
(def version-peg
  '(* "v"
      (/ (* (capture :d+) "." (capture :d+) "." (capture :d+))
         ,(fn [major minor patch]
            {:major (scan-number major)
             :minor (scan-number minor)
             :patch (scan-number patch)}))))

(def version (first (peg/match version-peg version-text)))
(printf "Version: %q\n" version)

# Match URLs
(def url-peg
  '{:protocol (+ "http" "https" "ftp")
    :domain (some (+ :w (set ".-")))
    :path (any (+ :w (set "/-_.~")))
    :main (* (capture :protocol) "://"
             (capture :domain)
             (? (* "/" (capture :path))))})

(def url "https://janet-lang.org/docs/index.html")
(def url-parts (peg/match url-peg url))
(printf "URL parts: %q\n" url-parts)

# Replace with PEG
(def text-with-dates "The meeting is on 2024-01-15 and 2024-02-20")
(def date-peg '(* :d :d :d :d "-" :d :d "-" :d :d))
(def replaced (peg/replace-all date-peg "[DATE]" text-with-dates))
(printf "Replaced dates: %s\n" replaced)

# Parse nested structures (simple expression)
(def expr-peg
  ~{:number (* (? "-") (some :d))
    :main (+ :number (* "(" :main :s+ (set "+-*/") :s+ :main ")"))})

(def expr "(123 + 456)")
(when (peg/match expr-peg expr)
  (printf "Expression '%s' is valid!\n" expr))

# Extract all words from text
(def paragraph "Janet is a functional and imperative programming language.")
(def word-peg '(some (+ (capture :w+) (if-not -1 1))))
(def words (peg/match word-peg paragraph))
(printf "Words: %q\n" words)
