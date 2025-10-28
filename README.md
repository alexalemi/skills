# Skills

A collection of Claude skills I've made or found useful.

## Available Skills

### fermi-estimation
Probabilistic estimation and dimensional reasoning for uncertain quantities using the `simplefermi` package. Break down complex estimation problems (e.g., "How many piano tuners in Chicago?") into components with quantified uncertainty, automatic unit tracking, and dimensional analysis.

### plaque
Transform Python files into interactive notebooks with live updates. Create beautifully rendered HTML reports from plain Python files with rich formatting, markdown documentation, and intelligent dependency tracking. Ideal for presenting computational work.

### janet
Help with writing, learning, running, and debugging Janet code. Janet is a functional and imperative Lisp-like language with powerful features including macros, pattern matching with PEGs, and fibers for concurrency.

### persistent-repl
A Python REPL wrapper with persistent storage using dill. Useful for interactive calculations and debugging sessions that need to maintain state across restarts.

## Usage

To package all skills as zip files:
```bash
make          # or 'make all' or 'make package'
```

To package a specific skill:
```bash
make fermi-estimation.zip
```

To list all available skills:
```bash
make list
```

To clean up generated zip files:
```bash
make clean
```
