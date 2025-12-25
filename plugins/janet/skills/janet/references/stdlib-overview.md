# Janet Standard Library Overview

This reference provides an overview of Janet's extensive standard library, organized by functional area.

## Core Functions

### Type Checking and Conversion

```janet
# Type checking
(type value)           # Returns type as keyword (:number, :string, etc.)
(int? x)               # Check if integer
(number? x)            # Check if number
(string? x)            # Check if string
(buffer? x)            # Check if buffer
(array? x)             # Check if array
(tuple? x)             # Check if tuple
(table? x)             # Check if table
(struct? x)            # Check if struct
(function? x)          # Check if function
(fiber? x)             # Check if fiber
(nil? x)               # Check if nil
(boolean? x)           # Check if boolean
(indexed? x)           # Array or tuple
(dictionary? x)        # Table or struct

# Type conversion
(string x)             # Convert to string
(number x)             # Parse number from string
(int x)                # Convert to integer
(buffer x)             # Convert to buffer
(array x)              # Convert to array
(tuple x)              # Convert to tuple
(table x)              # Convert to table
(struct x)             # Convert to struct
```

## Math Module

### Arithmetic

```janet
(+ a b ...)            # Addition
(- a b ...)            # Subtraction
(* a b ...)            # Multiplication
(/ a b ...)            # Division
(% a b)                # Modulo
(div a b)              # Integer division
(mod a b)              # Mathematical modulus

(++ x)                 # Increment (returns new value)
(-- x)                 # Decrement (returns new value)
(+= x n)               # Add and assign
(-= x n)               # Subtract and assign
(*= x n)               # Multiply and assign
(/= x n)               # Divide and assign
(%= x n)               # Modulo and assign
```

### Mathematical Functions

```janet
(math/abs x)           # Absolute value
(math/ceil x)          # Round up
(math/floor x)         # Round down
(math/round x)         # Round to nearest
(math/sqrt x)          # Square root
(math/pow x y)         # x raised to power y
(math/exp x)           # e^x
(math/log x)           # Natural logarithm
(math/log10 x)         # Base-10 logarithm

(math/sin x)           # Sine
(math/cos x)           # Cosine
(math/tan x)           # Tangent
(math/asin x)          # Arcsine
(math/acos x)          # Arccosine
(math/atan x)          # Arctangent
(math/atan2 y x)       # Two-argument arctangent

(math/random)          # Random float [0, 1)
(math/seedrandom seed) # Seed RNG
(math/rng)             # Create new RNG
(math/rng-int rng max) # Random integer [0, max)
(math/rng-uniform rng) # Random float [0, 1)

# Constants
math/pi                # π
math/e                 # Euler's number
math/inf               # Infinity
math/-inf              # Negative infinity
```

### Comparison and Logic

```janet
(= a b ...)            # Equality
(not= a b)             # Inequality
(< a b ...)            # Less than
(<= a b ...)           # Less than or equal
(> a b ...)            # Greater than
(>= a b ...)           # Greater than or equal

(compare a b)          # Returns -1, 0, or 1
(max a b ...)          # Maximum value
(min a b ...)          # Minimum value

(and a b ...)          # Logical AND
(or a b ...)           # Logical OR
(not x)                # Logical NOT
```

## String Module

### String Operations

```janet
(string a b ...)       # Concatenate
(string/slice str start end?) # Substring
(string/repeat str n)  # Repeat string n times
(string/reverse str)   # Reverse string
(string/join arr sep?) # Join array with separator

(string/split sep str) # Split into array
(string/find needle haystack start?) # Find substring
(string/has-prefix? pre str) # Check prefix
(string/has-suffix? suf str) # Check suffix
(string/replace pat new str) # Replace substring
(string/replace-all pat new str) # Replace all occurrences

(string/trim str)      # Trim whitespace
(string/triml str)     # Trim left
(string/trimr str)     # Trim right

(string/ascii-lower str) # Convert to lowercase
(string/ascii-upper str) # Convert to uppercase

(length str)           # String length
(get str index)        # Get byte at index
```

### String Formatting

```janet
(string/format fmt ...)  # Printf-style formatting
# Format specifiers:
# %s - string
# %d - integer
# %f - float
# %x - hexadecimal
# %o - octal
# %b - binary
# %q - quoted string (escape special chars)
# %p - pointer address

# Examples:
(string/format "Hello %s" "World")
# => "Hello World"

(string/format "Number: %05d" 42)
# => "Number: 00042"

(string/format "Pi: %.2f" math/pi)
# => "Pi: 3.14"
```

### String Scanning

```janet
(string/check-set set str) # Check if all chars in set
(string/find-all pattern str) # Find all matches

(scan-number str)      # Parse number from string
```

## Array Module

### Array Creation and Manipulation

```janet
(array a b ...)        # Create array
(array/new capacity)   # Create with capacity
(array/new-filled count value) # Create filled array

(array/push arr x ...)  # Append to end
(array/pop arr)         # Remove from end
(array/peek arr)        # Get last element

(array/insert arr i x)  # Insert at index
(array/remove arr i)    # Remove at index

(array/clear arr)       # Remove all elements
(array/concat arr1 arr2 ...) # Concatenate arrays
(array/slice arr start end?) # Get subarray

(length arr)            # Array length
(get arr index)         # Get element at index
(put arr index value)   # Set element at index
```

### Array Operations

```janet
(reverse arr)           # Reverse in place
(sort arr compare?)     # Sort in place
(sorted arr compare?)   # Return sorted copy
(sorted-by keyfn arr)   # Sort by key function

(map f arr)             # Map function over array
(filter pred arr)       # Filter by predicate
(reduce f init arr)     # Reduce/fold
(accumulate f init arr) # Accumulate intermediate results

(find pred arr)         # Find first match
(find-index pred arr)   # Find index of first match
(index-of x arr)        # Find index of value

(all pred arr)          # Check if all match
(some pred arr)         # Check if any match
(any pred arr)          # Alias for some
```

## Table Module

### Table Operations

```janet
(table a b ...)         # Create table from pairs
(table/new capacity)    # Create with capacity
(table/to-struct tbl)   # Convert to struct
(table/clone tbl)       # Shallow clone

(get tbl key default?)  # Get value
(put tbl key value)     # Set value
(in key tbl)            # Check if key exists

(length tbl)            # Number of key-value pairs
(empty? tbl)            # Check if empty

(keys tbl)              # Get all keys
(values tbl)            # Get all values
(pairs tbl)             # Get key-value pairs
(kvs tbl)               # Get flattened [k1 v1 k2 v2 ...]

(merge tbl1 tbl2 ...)   # Merge tables
(merge-into target source ...) # Merge into target

(table/clear tbl)       # Remove all entries
```

### Table Utilities

```janet
(freeze x)              # Convert mutable to immutable
(thaw x)                # Convert immutable to mutable

(get-in data path default?) # Get nested value
(put-in data path value)    # Set nested value
(update-in data path f)     # Update nested value

(update tbl key f)      # Update value with function
```

## Sequence Functions

These work on any indexed collection (arrays, tuples):

```janet
(map f & seqs)          # Map over sequences
(map-indexed f seq)     # Map with index
(mapcat f & seqs)       # Map and concatenate

(filter pred seq)       # Keep matching elements
(keep pred seq)         # Map, keeping non-nil results
(remove pred seq)       # Remove matching elements

(reduce f init seq)     # Fold left
(reduce2 f seq)         # Reduce without initial value
(accumulate f init seq) # Return all intermediate values

(distinct seq)          # Remove duplicates
(frequencies seq)       # Count occurrences
(group-by f seq)        # Group by function result

(interleave & seqs)     # Interleave sequences
(interpose sep seq)     # Insert separator between elements
(partition n seq)       # Partition into n-element tuples

(take n seq)            # First n elements
(take-while pred seq)   # Take while predicate true
(drop n seq)            # Skip first n elements
(drop-while pred seq)   # Skip while predicate true

(first seq)             # First element
(last seq)              # Last element
(slice seq start end?)  # Get subsequence

(range & args)          # Generate range
# (range n) => [0 1 ... n-1]
# (range start end) => [start ... end-1]
# (range start end step) => [start start+step ... ]

(repeat n x)            # Repeat value n times
(repeatedly n f)        # Call function n times

(reverse seq)           # Reverse sequence
(sort seq compare?)     # Sort sequence
(sorted seq compare?)   # Return sorted copy
(sorted-by keyfn seq)   # Sort by key function

(apply f args)          # Apply function to array of arguments
(juxt & fns)            # Apply multiple functions to same args

(comp & fns)            # Function composition
(complement f)          # Negate predicate
(constantly x)          # Function that always returns x
(identity x)            # Identity function

(partial f & args)      # Partial application
```

## File I/O Module

### File Operations

```janet
(file/open path mode)   # Open file
# Modes: "r" read, "w" write, "a" append, "r+" read/write, etc.

(file/close f)          # Close file
(file/read f how)       # Read from file
# how: :all, :line, or number of bytes

(file/write f & data)   # Write to file
(file/flush f)          # Flush buffer

(file/seek f whence offset?) # Seek in file
# whence: :set, :cur, :end

(file/lines f)          # Iterate over lines

# Context managers
(with [f (file/open path "r")]
  (file/read f :all))
```

### Path Operations

```janet
(os/stat path)          # Get file info
(os/lstat path)         # Get file info (don't follow symlinks)

(os/dir path)           # List directory contents
(os/mkdir path)         # Create directory
(os/rmdir path)         # Remove directory
(os/rm path)            # Remove file

(os/rename old new)     # Rename/move file
(os/link old new)       # Create hard link
(os/symlink old new)    # Create symbolic link

(os/chmod path mode)    # Change permissions
(os/touch path)         # Update modification time

(os/cwd)                # Get current directory
(os/cd path)            # Change directory
```

## Process and Environment

### Process Control

```janet
(os/exit code?)         # Exit program
(os/getenv var)         # Get environment variable
(os/setenv var value)   # Set environment variable
(os/environ)            # Get all environment variables

(os/which executable)   # Find executable in PATH
(os/execute args & opts) # Execute command
(os/spawn args & opts)  # Spawn process
(os/shell command)      # Execute shell command

(os/proc-wait proc)     # Wait for process
(os/proc-kill proc signal?) # Kill process
(os/proc-close proc)    # Close process handles
```

### System Information

```janet
(os/time)               # Current Unix timestamp
(os/date time? local?)  # Get date struct
(os/mktime date)        # Convert date to timestamp
(os/clock)              # High-precision time

(os/arch)               # CPU architecture
(os/cpu-count)          # Number of CPUs

(os/sleep seconds)      # Sleep for duration
```

## PEG Module

### PEG Matching

```janet
(peg/match grammar text start?) # Match and capture
(peg/compile grammar)   # Compile PEG
(peg/replace grammar replacement text) # Replace matches
(peg/replace-all grammar replacement text) # Replace all
```

### PEG Combinators

```janet
# Literals
"string"                # Match literal string
n                       # Match n characters

# Character classes
:w                      # Word character [a-zA-Z0-9_]
:a                      # Alphabetic [a-zA-Z]
:d                      # Digit [0-9]
:s                      # Whitespace [ \t\n\r]
:h                      # Hex digit [0-9a-fA-F]

# Repetition
(* peg ...)             # Match all in sequence
(+ peg ...)             # Match first alternative
(? peg)                 # Optional (0 or 1)
(some peg)              # One or more
(any peg)               # Zero or more
(between min max peg)   # Min to max repetitions

# Captures
(capture peg)           # Capture match as string
(/ peg transform)       # Capture and transform
(group peg)             # Capture as array
(quote peg)             # Capture as tuple

# Predicates
(if peg)                # Positive lookahead
(if-not peg)            # Negative lookahead
(not peg)               # Do not match

# Advanced
(set str)               # Match any char in string
(range from to)         # Match char range
(look offset peg)       # Match at offset
(to peg)                # Match up to pattern
(thru peg)              # Match through pattern
```

## Fiber Module

### Fiber Operations

```janet
(fiber/new f)           # Create new fiber
(fiber/current)         # Get current fiber
(fiber/status f)        # Get fiber status

(resume f & args)       # Resume fiber
(yield & args)          # Yield from fiber

(fiber/setenv f env)    # Set fiber environment
(fiber/getenv f)        # Get fiber environment

(fiber/can-resume? f)   # Check if resumable
(fiber/root)            # Get root fiber
```

### Error Handling with Fibers

```janet
(try expr catch-clause) # Try-catch
(error msg)             # Throw error
(errorf fmt & args)     # Throw formatted error
(assert cond message?)  # Assert condition

(protect f & args)      # Protect function call
# Returns [status result-or-error]
```

## Net Module

### Networking

```janet
(net/listen host port)  # Create server socket
(net/accept server)     # Accept connection
(net/connect host port) # Connect to server
(net/close socket)      # Close socket

(net/read socket n)     # Read n bytes
(net/chunk socket n)    # Read up to n bytes
(net/write socket data) # Write data
(net/send socket data)  # Send data

(net/flush socket)      # Flush output buffer
(net/shutdown socket how?) # Shutdown socket
```

## Parser and Marshal

### Parsing Janet Source

```janet
(parse source)          # Parse Janet code
(eval form env?)        # Evaluate form
(compile form env?)     # Compile to function

(require module)        # Load module
(import module & args)  # Import module
(use module)            # Use module (prefix optional)
```

### Marshaling

```janet
(marshal value)         # Serialize to bytes
(unmarshal bytes)       # Deserialize from bytes

(make-image dict)       # Create image
(load-image bytes)      # Load image
```

## Debug Module

### Debugging Functions

```janet
(debug/stack fiber?)    # Get stack trace
(debug/lineage fiber?)  # Get fiber lineage
(debug/fbreak f index)  # Set breakpoint

(doc symbol)            # Show documentation
(pp value)              # Pretty-print
(describe value)        # Describe value type and structure

(macex form)            # Expand macro once
(macex1 form)           # Alias for macex
```

## Best Practices

1. **Use built-ins**: Janet's standard library is comprehensive - check if functionality exists before reimplementing
2. **REPL exploration**: Use `(doc function-name)` to discover functions and their usage
3. **Type checking**: Use predicates like `string?`, `number?` for validation
4. **Sequence functions**: Leverage `map`, `filter`, `reduce` for collection operations
5. **Error handling**: Use `try`, `assert`, and `protect` appropriately
6. **PEGs over regex**: Janet's PEG system is more powerful and readable than traditional regex
