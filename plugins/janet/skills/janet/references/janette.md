# Janette

A persistant REPL at `scripts/janette`.

You can use janette to have a persistant repl between bash calls.

 * `janette "(def x 1)"` - will execute the code and marshall the state in a `.janette.image` file
 * `janette "(print x)"` - will then print 1 since that is the state.
 * `janette file` - will execute a whole file.
 * `janette` - launches a repl that saves state between each execution.


The `JANETTE_IMAGE` environment variable controls the name of the image file, by default it is `.janette.jimage`.

