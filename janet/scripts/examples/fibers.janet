#!/usr/bin/env janet
# Fiber Examples - Lightweight Concurrency

# Basic fiber creation and execution
(print "=== Basic Fiber ===")
(def simple-fiber
  (fiber/new (fn []
               (print "Hello from fiber!")
               (yield "yielded value")
               (print "Fiber resumed")
               42)))

(printf "First resume: %q\n" (resume simple-fiber))
(printf "Second resume: %q\n" (resume simple-fiber))

# Generator pattern with fibers
(print "\n=== Fibonacci Generator ===")
(defn fib-generator []
  (fiber/new
    (fn []
      (var [a b] [0 1])
      (forever
        (yield a)
        (set [a b] [b (+ a b)])))))

(def fib (fib-generator))
(print "First 10 Fibonacci numbers:")
(for i 0 10
  (printf "%d " (resume fib)))
(print)

# Counter generator
(print "\n=== Counter Generator ===")
(defn counter [start step]
  (fiber/new
    (fn []
      (var n start)
      (forever
        (yield n)
        (+= n step)))))

(def count-by-5 (counter 0 5))
(print "Count by 5:")
(for i 0 5
  (printf "%d " (resume count-by-5)))
(print)

# Range generator
(print "\n=== Range Generator ===")
(defn range-gen [start end]
  (fiber/new
    (fn []
      (var i start)
      (while (< i end)
        (yield i)
        (++ i)))))

(def rng (range-gen 1 6))
(print "Range 1 to 5:")
(while (fiber/can-resume? rng)
  (printf "%d " (resume rng)))
(print)

# Producer-consumer pattern
(print "\n=== Producer-Consumer ===")
(defn producer [items]
  (fiber/new
    (fn []
      (each item items
        (printf "Producing: %q\n" item)
        (yield item))
      nil)))

(defn consume [prod]
  (var value (resume prod))
  (while (not= value nil)
    (printf "Consuming: %q\n" value)
    (set value (resume prod))))

(def prod (producer ["apple" "banana" "cherry"]))
(consume prod)

# Stateful iterator
(print "\n=== Stateful Iterator ===")
(defn stateful-iter [items]
  (var index 0)
  (fiber/new
    (fn []
      (forever
        (if (< index (length items))
          (do
            (def item (get items index))
            (++ index)
            (yield [index item]))
          (break nil))))))

(def iter (stateful-iter ["a" "b" "c" "d"]))
(print "Indexed iteration:")
(while (fiber/can-resume? iter)
  (def result (resume iter))
  (when result
    (printf "  [%d]: %q\n" (get result 0) (get result 1))))

# Task scheduler (simplified)
(print "\n=== Simple Task Scheduler ===")
(defn task [name steps]
  (fiber/new
    (fn []
      (each step steps
        (printf "[%s] %s\n" name step)
        (yield))
      (printf "[%s] Complete!\n" name))))

(def tasks [
  (task "Task A" ["Initialize" "Process" "Finalize"])
  (task "Task B" ["Load" "Transform" "Save"])
])

# Round-robin scheduling
(print "Running tasks in round-robin:")
(var active-tasks tasks)
(while (> (length active-tasks) 0)
  (set active-tasks
    (filter fiber/can-resume?
      (map (fn [t] (resume t) t) active-tasks))))

# Error handling with fibers
(print "\n=== Error Handling ===")
(def error-fiber
  (fiber/new
    (fn []
      (yield "First yield")
      (error "Something went wrong!")
      (yield "This won't be reached"))))

(printf "First resume: %q\n" (resume error-fiber))
(def [status err] (protect (fn [] (resume error-fiber))))
(if status
  (print "Fiber completed normally")
  (printf "Fiber error caught: %s\n" err))
