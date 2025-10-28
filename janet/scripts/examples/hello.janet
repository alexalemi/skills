#!/usr/bin/env janet
# Basic Janet Hello World Example

# Simple print
(print "Hello, World!")

# Formatted string
(printf "Hello, %s!\n" "Janet")

# String concatenation
(def name "Developer")
(def greeting (string "Hello, " name "!"))
(print greeting)

# Function definition
(defn greet [name]
  "Greet a person by name"
  (string "Hello, " name "!"))

(print (greet "Alice"))
(print (greet "Bob"))

# Using command line arguments
(when (> (length (dyn :args)) 0)
  (def user-name (get (dyn :args) 1))
  (printf "Hello from command line, %s!\n" user-name))
