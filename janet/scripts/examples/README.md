# Janet Example Scripts

This directory contains example Janet scripts demonstrating various language features.

## Running Examples

Make sure Janet is installed (use `../install.sh` if needed), then run:

```bash
janet hello.janet
janet functional.janet
janet peg-parsing.janet
janet fibers.janet
```

## Examples Overview

### hello.janet
**Basic Janet syntax and Hello World**
- Simple printing and string formatting
- Function definition and usage
- Command-line argument handling

Run: `janet hello.janet` or `janet hello.janet YourName`

### functional.janet
**Functional programming patterns**
- Map, filter, and reduce operations
- Threading macros (`->` and `->>`)
- Partial application
- Function composition
- Higher-order functions
- Working with collections and data structures

Demonstrates Janet's functional programming capabilities and idiomatic patterns.

### peg-parsing.janet
**PEG (Parsing Expression Grammar) examples**
- Basic pattern matching
- Parsing numbers, emails, URLs, and CSV
- Capture groups and transformations
- Pattern replacement
- Nested structure parsing

Shows Janet's powerful built-in parsing system that replaces traditional regex.

### fibers.janet
**Lightweight concurrency with fibers**
- Creating and resuming fibers
- Generator pattern (Fibonacci, counters, ranges)
- Producer-consumer pattern
- Stateful iterators
- Simple task scheduling
- Error handling with fibers

Demonstrates Janet's approach to concurrency using cooperative multitasking.

## Learning Path

Recommended order for learning:
1. **hello.janet** - Start here to understand basic syntax
2. **functional.janet** - Learn functional programming in Janet
3. **peg-parsing.janet** - Explore Janet's parsing capabilities
4. **fibers.janet** - Understand concurrency model

## Modifying Examples

Feel free to modify these scripts to experiment with Janet. Use the Janet REPL (`janet`) to interactively explore any concepts:

```bash
$ janet
Janet 1.39.1  Copyright (C) 2017-2024 Calvin Rose
janet:1:> (doc map)
...
```

Use `(doc function-name)` to see documentation for any function.
