# Common Janet Patterns and Idioms

This reference provides common patterns, idioms, and best practices for Janet programming.

## Functional Programming Patterns

### Map, Filter, Reduce

```janet
# Map - transform each element
(map |(* $ 2) [1 2 3 4])
# => @[2 4 6 8]

# Filter - keep elements matching predicate
(filter even? [1 2 3 4 5 6])
# => @[2 4 6]

# Reduce - accumulate a result
(reduce + 0 [1 2 3 4])
# => 10

# Reduce with custom function
(reduce (fn [acc x] (+ acc (* x x))) 0 [1 2 3])
# => 14 (1² + 2² + 3²)
```

### Function Composition

```janet
# Compose functions using threading macros
(-> 5
    (+ 3)
    (* 2)
    (- 1))
# => 15 (((5 + 3) * 2) - 1)

# Thread-last for collection operations
(->> [1 2 3 4 5]
     (filter even?)
     (map |(* $ $ $))
     (reduce +))
# => 20 (2³ + 4³ = 8 + 12)

# Thread-first assigns result as first argument
# Thread-last assigns result as last argument
```

### Partial Application

```janet
(defn add [x y] (+ x y))

# Create partially applied function
(def add5 (partial add 5))
(add5 10)
# => 15

# Using short function syntax
(def multiply-by [n] |(* n $))
(def double (multiply-by 2))
(double 7)
# => 14
```

## Data Structure Patterns

### Destructuring

```janet
# Array/tuple destructuring
(def [a b c] [1 2 3])
# a=1, b=2, c=3

# Rest elements
(def [first & rest] [1 2 3 4])
# first=1, rest=(2 3 4)

# Table/struct destructuring
(def {:name name :age age} {:name "Alice" :age 30})
# name="Alice", age=30
```

### Working with Tables and Structs

```janet
# Creating and merging
(def t1 @{:a 1 :b 2})
(def t2 @{:c 3 :d 4})
(merge t1 t2)
# => @{:a 1 :b 2 :c 3 :d 4}

# Update nested structures
(update {:person {:name "Alice" :age 25}}
        [:person :age]
        inc)
# => {:person {:name "Alice" :age 26}}

# Get with default value
(get {:a 1} :b "default")
# => "default"

# Put returns the table
(def t @{})
(put t :key "value")
# => @{:key "value"}
```

### Collection Transformations

```janet
# Zip two sequences together
(defn zip [a b]
  (map tuple a b))

(zip [:a :b :c] [1 2 3])
# => @[[:a 1] [:b 2] [:c 3]]

# Group by predicate
(defn group-by [f coll]
  (reduce (fn [acc x]
            (def k (f x))
            (put acc k (array/concat (get acc k @[]) @[x])))
          @{}
          coll))

(group-by even? [1 2 3 4 5 6])
# => @{false @[1 3 5] true @[2 4 6]}

# Partition into chunks
(partition 2 [:a :b :c :d :e :f])
# => @[(:a :b) (:c :d) (:e :f)]
```

## Control Flow Patterns

### Pattern Matching with Cond

```janet
(defn classify [x]
  (cond
    (< x 0) "negative"
    (= x 0) "zero"
    (< x 10) "small positive"
    (< x 100) "medium positive"
    "large positive"))
```

### Error Handling

```janet
# Try-catch pattern
(try
  (/ 10 0)
  ([err] (print "Error: " err)))

# Assert with custom message
(assert (> x 0) "x must be positive")

# Error function to throw errors
(when (< balance amount)
  (error "Insufficient funds"))

# Safe operations with default
(defn safe-div [a b]
  (if (= b 0)
    nil
    (/ a b)))
```

### Optional Values and Nil Handling

```janet
# Use `or` for default values
(def name (or (get data :name) "Unknown"))

# Early return pattern
(defn process [data]
  (when (nil? data)
    (break nil))
  # ... continue processing
  (transform data))

# if-let pattern for nil checks
(defn greet [user-map]
  (if-let [name (get user-map :name)]
    (string "Hello, " name)
    "Hello, stranger"))
```

## Looping Patterns

### Iteration

```janet
# Basic loop over collection
(loop [x :in [1 2 3 4]]
  (print x))

# Loop with index
(loop [[i x] :pairs [10 20 30]]
  (printf "Index %d: %d" i x))

# Loop over table/struct
(loop [[k v] :pairs {:a 1 :b 2}]
  (printf "%q => %d" k v))

# Nested loops
(loop [x :in [1 2 3]
       y :in [:a :b]]
  (print [x y]))
# Prints: [1 :a] [1 :b] [2 :a] [2 :b] [3 :a] [3 :b]
```

### Loop with Accumulation

```janet
# Collect results from loop
(seq [x :in [1 2 3 4]
      :when (even? x)]
  (* x x))
# => @[4 16]

# Generate with yield
(defn range [n]
  (seq [i :range [0 n]] i))

(range 5)
# => @[0 1 2 3 4]
```

### While Loops

```janet
# While loop pattern
(var i 0)
(while (< i 5)
  (print i)
  (++ i))

# Breaking out of loops
(loop [x :in data]
  (when (= x target)
    (break x)))
```

## String and Buffer Patterns

### String Building

```janet
# String concatenation
(string "Hello" " " "World")
# => "Hello World"

# String interpolation
(string/format "Name: %s, Age: %d" name age)

# Buffer for mutable strings
(def buf @"")
(buffer/push-string buf "Hello")
(buffer/push-string buf " World")
# buf is now @"Hello World"

# Join collection
(string/join ["a" "b" "c"] ", ")
# => "a, b, c"
```

### String Manipulation

```janet
# Split string
(string/split "," "a,b,c")
# => @["a" "b" "c"]

# Trim whitespace
(string/trim "  hello  ")
# => "hello"

# Check prefix/suffix
(string/has-prefix? "hello world" "hello")
# => true

# Replace
(string/replace "dog" "cat" "I love my dog")
# => "I love my cat"
```

## Macro Patterns

### Control Flow Macros

```janet
# when - if without else
(defmacro when [condition & body]
  ~(if ,condition (do ,@body)))

# unless - inverted if
(defmacro unless [condition & body]
  ~(if (not ,condition) (do ,@body)))

# while-let - loop with binding
(defmacro while-let [binding & body]
  (def [sym expr] binding)
  ~(do
     (var ,sym ,expr)
     (while ,sym
       ,@body
       (set ,sym ,expr))))
```

### Code Generation Macros

```janet
# Generate multiple similar definitions
(defmacro def-math-ops [name op]
  ~(defn ,name [a b] (,op a b)))

(def-math-ops add-nums +)
(def-math-ops mult-nums *)

# Generate getter/setter pairs
(defmacro defprop [name]
  (def getter-name (symbol "get-" name))
  (def setter-name (symbol "set-" name))
  ~(do
     (defn ,getter-name [obj] (get obj ,(keyword name)))
     (defn ,setter-name [obj val] (put obj ,(keyword name) val))))

(defprop age)
# Creates get-age and set-age functions
```

## PEG Patterns

### Common PEG Idioms

```janet
# Match and capture word
(peg/match '(capture :w+) "hello")
# => @["hello"]

# Match with multiple captures
(peg/match '(* (capture :w+) :s+ (capture :w+)) "hello world")
# => @["hello" "world"]

# Match and transform
(peg/match '(/ (* (capture :d+) "." (capture :d+))
               ,(fn [major minor] {:major (scan-number major)
                                   :minor (scan-number minor)}))
           "1.2")
# => @[{:major 1 :minor 2}]

# Recursive PEG for nested structures
(def paren-grammar
  ~{:open "("
    :close ")"
    :value (* :open (any :main) :close)
    :main (+ :value (/ '(some (if-not (set "()") 1)) ,|(string/trim $)))})

# Common patterns
(def patterns
  {:digit '(range "09")
   :letter '(+ (range "az") (range "AZ"))
   :whitespace '(set " \t\n\r")
   :word '(some (+ :letter (range "09") (set "-_")))
   :number '(* (? "-") (some :digit) (? (* "." (some :digit))))})
```

## Concurrency with Fibers

### Basic Fiber Usage

```janet
# Create and resume fiber
(def f (fiber/new (fn []
                     (print "Hello from fiber")
                     42)))

(resume f)
# Prints: "Hello from fiber"
# => 42

# Yielding from fiber
(def counter
  (fiber/new
    (fn []
      (var i 0)
      (forever
        (yield i)
        (++ i)))))

(resume counter) # => 0
(resume counter) # => 1
(resume counter) # => 2
```

### Generator Pattern

```janet
(defn generator [f]
  (fiber/new (fn [] (forever (yield (f))))))

# Infinite sequence generator
(defn fib-gen []
  (fiber/new
    (fn []
      (var [a b] [0 1])
      (forever
        (yield a)
        (set [a b] [b (+ a b)])))))

(def fib (fib-gen))
(resume fib) # => 0
(resume fib) # => 1
(resume fib) # => 1
(resume fib) # => 2
(resume fib) # => 3
```

## Module and Project Organization

### Creating Modules

```janet
# my-module.janet
(defn public-function [x]
  (* x 2))

(defn- private-function [x]
  (+ x 1))

# Export specific symbols
(def module-exports
  {:public-function public-function})

# Return exports
module-exports
```

### Using Modules

```janet
# Import module
(import my-module)
(my-module/public-function 5)

# Import with prefix
(import my-module :as m)
(m/public-function 5)

# Import specific symbols
(import my-module :prefix "")
(public-function 5)

# Require (searches module tree)
(use module-name)
```

## Common Utility Functions

```janet
# Identity function
(defn identity [x] x)

# Constantly returns same value
(defn constantly [x] (fn [& _] x))

# Complement - negate predicate
(defn complement [f]
  (fn [& args] (not (f ;args))))

(def odd? (complement even?))

# Juxt - apply multiple functions
(defn juxt [& fns]
  (fn [& args]
    (map |($ ;args) fns)))

(def stats (juxt length sum))
(stats [1 2 3 4])
# => @[4 10]

# Memoization
(defn memoize [f]
  (def cache @{})
  (fn [& args]
    (if-let [result (get cache args)]
      result
      (let [result (f ;args)]
        (put cache args result)
        result))))
```
