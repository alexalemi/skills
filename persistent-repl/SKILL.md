---
name: persistent-repl
description: Use persistent REPL for interactive calculations and debugging.
---

# Persistent REPL

## Overview

This skill is a simple wrapper around the python REPL that provides persistent storage with dill.

Before using, you need to have dill installed with `pip install dill`.

After that you can use the `repl.py` script to run python files or individual code in a way that will be persistent.

For example:

```
./scripts/repl.py 'x=1'
./scripts/repl.py 'print(x)'
```
will return 1 after the second call.

You can also feed in entire python scripts you've written, e.g.

```
./scripts/repl.py test.py
./scripts/repl.py 'print(foo)'
```

## Resources

### Scripts
- `repl.py` - Feed python code as a string to the persistent REPL
