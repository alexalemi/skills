#!/usr/bin/env janet
# Functional Programming Examples in Janet

# Map - transform each element
(def numbers [1 2 3 4 5])
(def doubled (map |(* $ 2) numbers))
(printf "Doubled: %q\n" doubled)

# Filter - keep only matching elements
(def evens (filter even? numbers))
(printf "Even numbers: %q\n" evens)

# Reduce - accumulate a result
(def sum (reduce + 0 numbers))
(printf "Sum: %d\n" sum)

# Function composition with threading
(def result
  (->> [1 2 3 4 5 6 7 8 9 10]
       (filter even?)
       (map |(* $ $))
       (reduce +)))
(printf "Sum of squares of evens: %d\n" result)

# Partial application
(defn multiply [a b] (* a b))
(def triple (partial multiply 3))
(printf "Triple 5: %d\n" (triple 5))

# Higher-order functions
(defn apply-twice [f x]
  "Apply function f to x twice"
  (f (f x)))

(defn increment [x] (+ x 1))
(printf "Increment 5 twice: %d\n" (apply-twice increment 5))

# Composition
(defn square [x] (* x x))
(defn add-ten [x] (+ x 10))
(def transform (comp add-ten square))
(printf "Square then add 10 to 5: %d\n" (transform 5))

# Working with sequences
(def data [
  {:name "Alice" :age 30}
  {:name "Bob" :age 25}
  {:name "Charlie" :age 35}
])

# Extract names
(def names (map |(get $ :name) data))
(printf "Names: %q\n" names)

# Filter by age
(def older-than-26 (filter |(> (get $ :age) 26) data))
(printf "Older than 26: %q\n" older-than-26)

# Find oldest person
(defn compare-age [a b]
  (< (get a :age) (get b :age)))

(def oldest (last (sorted data compare-age)))
(printf "Oldest: %s (%d years)\n" (get oldest :name) (get oldest :age))
