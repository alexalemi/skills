---
name: janet
description: This skill should be used when users need help writing, learning, running, or debugging Janet code. Janet is a functional and imperative Lisp-like language with powerful features including macros, PEGs, and fibers for concurrency.
---

# Janet Language Skill

## About Janet

Janet is a functional and imperative programming language with Lisp-like syntax. Key characteristics:

- Minimalist design: entire language (core library, interpreter, compiler, assembler, PEG) is less than 1MB
- Prefix notation with parentheses: `(+ 1 2)` rather than `1 + 2`
- Over 300 built-in functions and macros in the core library
- Powerful metaprogramming with macros for compile-time code generation
- Built-in PEG (Parsing Expression Grammar) system for parsing
- Fibers for lightweight concurrency
- Embeddable in C applications

## When to Use This Skill

Use this skill when users:
- Request help writing Janet code
- Ask about Janet syntax, concepts, or best practices
- Want to run or test Janet programs
- Need debugging assistance with Janet code
- Ask to learn specific Janet features (macros, PEGs, fibers, etc.)
- Request explanations of Janet code

## Installation

If Janet is not installed, use the installation script to set it up:

```bash
bash scripts/install.sh
```

The script:
- Downloads Janet 1.39.1 for Linux x64
- Installs to `~/.local/bin`
- Checks for existing installations
- Provides PATH configuration instructions if needed

Verify installation with: `janet -v`

## Example Scripts

The skill includes example scripts demonstrating Janet features in `scripts/examples/`:

- **hello.janet** - Basic syntax, functions, and command-line arguments
- **functional.janet** - Functional programming patterns (map, filter, reduce, composition)
- **peg-parsing.janet** - Parsing with PEGs (emails, URLs, CSV, nested structures)
- **fibers.janet** - Concurrency with fibers (generators, producers, schedulers)

These examples serve as learning materials and templates. Users can run them with `janet scripts/examples/<name>.janet` or reference them when asking for help with similar tasks.

## Working with Janet

### Running Janet Code

Janet code can be executed in several ways:

1. **REPL (Interactive)**: Run `janet` to start an interactive session
2. **Script execution**: Run `janet script.janet` to execute a file
3. **One-liner**: Run `janet -e '(print "hello")'` for quick commands

### Key Language Concepts

**Data Structures:**
- Arrays: `@[1 2 3]` (mutable)
- Tuples: `[1 2 3]` (immutable)
- Tables: `@{:key "value"}` (mutable)
- Structs: `{:key "value"}` (immutable)
- Strings: `"text"` (immutable byte sequences)
- Buffers: `@"text"` (mutable byte sequences)

**Functions:**
```janet
(defn function-name [arg1 arg2]
  (+ arg1 arg2))

# Anonymous functions
(fn [x] (* x x))

# Short function syntax
|(* $ $)  # equivalent to (fn [x] (* x x))
```

**Control Flow:**
- Conditionals: `(if condition then-value else-value)`
- Multi-branch: `(cond condition1 result1 condition2 result2 default)`
- Looping: `(loop [x :in collection] (print x))`
- Iteration: `(each item collection (print item))`

**Macros:**
Janet macros run at compile-time and transform code:
```janet
(defmacro when [condition & body]
  ~(if ,condition (do ,@body)))
```

**PEGs (Parsing Expression Grammars):**
Built-in pattern matching for parsing text, more powerful than regex:
```janet
(peg/match '(* "hello" :s+ (capture :w+)) "hello world")
# => @["world"]
```

### Code Writing Guidelines

When writing Janet code:

1. **Use descriptive names**: Follow kebab-case for multi-word identifiers
2. **Prefer immutability**: Use tuples `[]` and structs `{}` unless mutation is needed
3. **Leverage the standard library**: Janet has extensive built-ins - check with `(doc function-name)` in REPL
4. **Use short function syntax sparingly**: `|$ syntax` is concise but less readable for complex functions
5. **Document functions**: Use docstrings in `defn`
6. **Handle errors**: Use `try` for error handling or `assert` for preconditions

### Testing and Debugging

**Run code with error output:**
```bash
janet script.janet
```

**Use the REPL for exploration:**
- `(doc symbol)` - Show documentation for any binding
- `(all-bindings)` - List all available bindings
- `(pp value)` - Pretty-print any value

**Common debugging approaches:**
- Use `(print)` or `(printf)` for debug output
- Use `(pp value)` to inspect data structures
- Use `(type value)` to check types
- Leverage the REPL to test snippets interactively

## Reference Files

This skill includes reference documentation that should be loaded when users need detailed information:

- **references/common-patterns.md** - Common Janet patterns, idioms, and best practices including:
  - Functional programming patterns (map, filter, reduce, composition)
  - Data structure manipulation
  - Control flow and error handling
  - Looping and iteration
  - String and buffer operations
  - Macro patterns
  - PEG patterns
  - Concurrency with fibers
  - Module organization

- **references/stdlib-overview.md** - Comprehensive standard library reference covering:
  - Core functions and type operations
  - Math module
  - String operations and formatting
  - Array and table operations
  - Sequence functions
  - File I/O and path operations
  - Process control and environment
  - PEG module details
  - Fiber operations
  - Networking
  - Debug utilities

Load these references when users need specific examples or detailed API information beyond the quick reference provided above.

## Learning Resources

**Official Documentation:**
- [Janet Documentation](https://janet-lang.org/docs/index.html) - Core concepts and syntax
- [Core API](https://janet-lang.org/api/index.html) - Built-in functions and modules
- [JPM Guide](https://janet-lang.org/docs/jpm.html) - Package manager

**Comprehensive Guide:**
- [Janet for Mortals](https://janet.guide/all/) - In-depth guide covering macros, PEGs, and advanced features

## Teaching Approach

When helping users learn Janet:

1. **Start with syntax**: Explain prefix notation and basic data structures
2. **Show working examples**: Provide complete, runnable code snippets
3. **Explain the "why"**: Janet's design choices (immutability, Lisp syntax) have reasons
4. **Reference the REPL**: Encourage interactive exploration with `(doc)` and experimentation
5. **Progressive complexity**: Start with functions and data structures before macros and PEGs
6. **Compare when helpful**: If user knows JavaScript/Python, draw parallels to familiar concepts
