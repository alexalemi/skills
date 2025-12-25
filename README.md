# Alemi Skills

A Claude Code plugin marketplace with skills for probabilistic estimation, programming languages, notebooks, and urban planning.

## Installation

### Install as a Marketplace (all plugins)

```bash
claude mcp add-marketplace /path/to/skills
```

This installs all plugins at once. You can then enable/disable individual plugins.

### Install a Single Plugin

Each plugin is standalone and can be installed individually:

```bash
claude --plugin-dir /path/to/skills/plugins/fermi-estimation
```

Or copy the plugin directory to your project's `.claude-plugin/` folder.

## Available Plugins

| Plugin | Category | Description |
|--------|----------|-------------|
| **fermi-estimation** | productivity | Probabilistic estimation and dimensional reasoning using the `simplefermi` package |
| **janet** | development | Help with writing, learning, running, and debugging Janet code |
| **persistent-repl** | development | Python REPL wrapper with persistent storage using dill |
| **plaque** | productivity | Transform Python files into interactive notebooks with live updates |
| **pab** | productivity | Planning Advisory Board agenda analysis for Kissimmee |

## Plugin Details

### fermi-estimation

Break down complex estimation problems (e.g., "How many piano tuners in Chicago?") into components with quantified uncertainty, automatic unit tracking, and dimensional analysis.

**Triggers:** Estimation queries, order-of-magnitude problems, uncertainty quantification

### janet

Janet is a functional and imperative Lisp-like language with powerful features including macros, PEGs for parsing, and fibers for concurrency. This plugin provides language support, examples, and reference documentation.

**Triggers:** Janet code questions, Lisp programming, PEG parsing

### persistent-repl

A simple Python REPL wrapper that maintains state across invocations using dill serialization. Useful for interactive debugging sessions.

**Triggers:** Interactive Python sessions needing persistence

### plaque

Create beautifully rendered HTML reports from plain Python files with rich markdown formatting, LaTeX support, and intelligent dependency tracking.

**Triggers:** Creating notebooks, rendering Python as documentation

### pab

Workflows for analyzing Planning Advisory Board agenda items against Kissimmee's Comprehensive Plan, Land Development Code, Florida Statutes, and Strong Towns principles.

**Triggers:** PAB agenda analysis, zoning questions, development proposal review

## Structure

```
skills/
├── .claude-plugin/
│   └── marketplace.json      # Marketplace registry
├── plugins/
│   ├── fermi-estimation/
│   │   ├── .claude-plugin/
│   │   │   └── plugin.json   # Standalone plugin metadata
│   │   └── skills/
│   │       └── fermi-estimation/
│   │           ├── SKILL.md
│   │           ├── scripts/
│   │           └── references/
│   ├── janet/
│   ├── persistent-repl/
│   ├── plaque/
│   └── pab/
└── README.md
```

## License

MIT License - see [LICENSE](LICENSE)
