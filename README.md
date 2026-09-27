# Alemi Skills

A Claude Code plugin marketplace with skills for probabilistic estimation, programming languages, notebooks, writing, and urban planning.

## Installation

### Install as a Marketplace (all plugins)

```
/plugin marketplace add alexalemi/skills
```

This installs all plugins at once. Then install individual plugins:

```
/plugin install fermi-estimation@alemi-skills
/plugin install janet@alemi-skills
```

### Install a Single Plugin

Each plugin is standalone. Clone the repo and point to a specific plugin:

```bash
git clone https://github.com/alexalemi/skills.git
claude --plugin-dir ./skills/plugins/fermi-estimation
```

Or copy a plugin directory into your project's `.claude-plugin/` folder.

## Available Plugins

| Plugin | Category | Description |
|--------|----------|-------------|
| **fermi-estimation** | productivity | Probabilistic estimation and dimensional reasoning using the `neofermi` DSL |
| **janet** | development | Help with writing, learning, running, and debugging Janet code |
| **persistent-repl** | development | Python REPL wrapper with persistent storage using dill |
| **plaque** | productivity | Transform Python files into interactive notebooks with live updates |
| **pab** | productivity | Planning Advisory Board agenda analysis for Kissimmee |
| **writing** | productivity | Line edits, CRIBS passes, red-ink markup, and Gopen & Swan reader-expectation analysis |

## Plugin Details

### fermi-estimation

Break down complex estimation problems (e.g., "How many piano tuners in Chicago?") into components with quantified uncertainty, automatic unit tracking, and dimensional analysis. Estimates are written as markdown notebooks and evaluated with the [neofermi](https://github.com/alexalemi/neofermi) `neoferminb` CLI.

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

### writing

One `writing` skill for editing prose (Typst, Markdown, LaTeX, plain text). Its `SKILL.md` routes each request to one of three modes, and only that mode's instructions are loaded:

- **Line edit** (`line-edit.md`): margin-note rewrites in document order, the way a human editor gives them. `style.md` profiles the author's voice so suggestions stay in it.
- **CRIBS** (`cribs.md`): a first-time reader's reactions (Confusing, Repeated, Interesting, Boring, Surprising, X to shorten) plus a keep/cut/shrink/expand verdict per paragraph.
- **Reader expectations** (`reader-expectations.md`): structural diagnosis based on Gopen & Swan, "The Science of Scientific Writing" (1990): topic, stress, and verb columns per sentence, subject-verb separation, old-to-new linkage, and logical gaps, stated as questions for the author.

Any mode can render its marks as red ink on a compiled copy (`red-ink.md`, `redline.py`).

**Triggers:** "edit", "line edit", "proofread", "cribs", "tighten this", "why is this hard to read", "check the flow", "Gopen and Swan"

## Marketplace Management

```
/plugin marketplace list                  # See installed marketplaces
/plugin marketplace update alemi-skills   # Pull latest changes
/plugin marketplace remove alemi-skills   # Uninstall marketplace
```

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
│   │           ├── assets/
│   │           ├── examples/
│   │           └── references/
│   ├── janet/
│   ├── persistent-repl/
│   ├── plaque/
│   ├── pab/
│   └── writing/
└── README.md
```

## License

MIT License - see [LICENSE](LICENSE)
