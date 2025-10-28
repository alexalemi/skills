# Plaque Reference

## Overview

Plaque transforms standard Python files into interactive notebooks with live updates and intelligent dependency tracking. It's a local-first notebook system that uses plain Python files as source material.

## Installation

```bash
pip install plaque
# or: uv pip install plaque
```

## Core Principle

"Your files should only run as they would if you ran them from scratch from top to bottom, but we don't actually have to rerun every cell every time."

Only modified cells and their dependent cells re-execute, enabling reactive features while preserving caching benefits for expensive computations.

## Cell Definition Styles

### Traditional Markers

Use `# %%` for code cells and `# %% [markdown]` for markdown cells:

```python
# %% [markdown]
# # Fermi Estimation: Piano Tuners in Chicago
# This notebook estimates the number of piano tuners in a city.

# %%
import simplefermi as sf

# %%
population = sf.lognormal(2e6, 3e6, 'people')
```

### Multiline Comments (Recommended for Fermi Estimations)

Top-level triple-quoted strings become markdown cells:

```python
"""
# Fermi Estimation: Piano Tuners in Chicago

This notebook estimates the number of piano tuners in a city.
"""

import simplefermi as sf

"""
## Step 1: Estimate Population

Chicago has approximately 2-3 million people.
"""

population = sf.lognormal(2e6, 3e6, 'people')

"""
## Step 2: Pianos per Household

Roughly 1 in 20 households has a piano.
"""

pianos_per_household = sf.outof(1, 20)
```

### Dynamic Markdown with F-strings

Use f-string style comments to incorporate variables:

```python
result = sf.lognormal(100, 200)

f"""
## Result

The estimated value is {result.to('units')}
"""
```

## CLI Commands

### `plaque render`
Generates static HTML from a Python notebook:

```bash
plaque render estimation.py
# Creates estimation.html
```

### `plaque watch`
Enables live re-rendering with caching:

```bash
plaque watch estimation.py
# Re-renders when file changes
```

### `plaque serve`
Starts an interactive server with live updates:

```bash
plaque serve estimation.py
# Opens browser automatically

plaque serve estimation.py --port 8080
# Custom port

plaque serve estimation.py --open
# Auto-open browser
```

## Rich Output Support

Plaque handles various output types:

- **Markdown**: Formatted text, headers, lists
- **LaTeX**: Mathematical equations (inline and display)
- **Plots**: Matplotlib, plotly, etc.
- **DataFrames**: Pandas tables
- **HTML**: Rich interactive content

## Best Practices for Fermi Estimations

1. **Structure with markdown cells**: Break estimation into clear steps
2. **Show your reasoning**: Explain each assumption in markdown
3. **One calculation per cell**: Makes dependencies clear
4. **Display intermediate results**: Show how values combine
5. **Use meaningful variable names**: Makes reasoning transparent
6. **Add visualizations**: SimpleFermi quantities render as dotplots in notebooks

## Example Workflow

```python
"""
# Fermi Estimation: [Problem Title]

Brief description of what we're estimating.
"""

import simplefermi as sf

"""
## Assumptions

List your key assumptions here.
"""

# Each assumption as a separate cell
assumption1 = sf.lognormal(low, high, 'units')

assumption2 = sf.outof(part, whole)

"""
## Calculation

Combine the assumptions.
"""

result = assumption1 * assumption2

"""
## Final Result

The result with interpretation.
"""

final = result.to('desired_units')
final  # Display the result
```

## Tips for Interactive Notebooks

- Keep cells small and focused
- Display intermediate results to show work
- Use markdown to narrate the reasoning
- SimpleFermi quantities will show uncertainty distributions
- The server auto-updates as you edit the Python file
