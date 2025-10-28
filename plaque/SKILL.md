---
name: plaque
description: Transform Python files into interactive notebooks with live updates. This skill should be used when you need to create rendered, interactive notebooks from Python code, or when you need to document and present computational work with rich formatting, live updates, and intelligent dependency tracking.
---

# Plaque

## Overview

Plaque transforms standard Python files into interactive notebooks with live updates and intelligent dependency tracking. It's a local-first notebook system that uses plain Python files as source material, making it ideal for creating well-formatted reports and presentations of computational work.

## When to Use This Skill

Use this skill when you need to:
- Create rendered, interactive notebooks from Python code
- Present computational work with rich formatting
- Build live-updating notebooks with automatic re-execution
- Document analysis or estimations with markdown and code
- Create HTML reports from Python files

**Example queries that trigger this skill:**
- "Create a rendered notebook showing this analysis"
- "Make an interactive notebook for this calculation"
- "Present this work as a formatted report"
- "Use plaque to render this Python file"

## Core Workflow

### Step 1: Install Plaque

```bash
pip install plaque
# or: uv pip install plaque
```

### Step 2: Structure Your Python File

Plaque supports multiple cell definition styles. The **recommended approach** for most notebooks is using multiline comments:

```python
"""
# My Notebook Title

Brief description of what this notebook does.
"""

import numpy as np

"""
## Section 1: Data Loading

Explain what this section does.
"""

data = np.array([1, 2, 3, 4, 5])

"""
## Section 2: Analysis

Show the results.
"""

result = data.mean()
result  # Display the result
```

**Alternative style** using traditional notebook markers:

```python
# %% [markdown]
# # My Notebook Title
# Brief description.

# %%
import numpy as np

# %%
data = np.array([1, 2, 3, 4, 5])
```

**Dynamic content** with f-strings:

```python
f"""
## Result

The computed value is {result}
"""
```

### Step 3: Render Your Notebook

Plaque provides three main commands:

**Static rendering:**
```bash
plaque render notebook.py
# Creates notebook.html
```

**Watch mode** (re-renders on file changes):
```bash
plaque watch notebook.py
```

**Interactive server** (recommended for development):
```bash
plaque serve notebook.py --open
# Starts server and opens in browser
```

## Core Principle

"Your files should only run as they would if you ran them from scratch from top to bottom, but we don't actually have to rerun every cell every time."

Plaque intelligently tracks dependencies between cells. Only modified cells and their dependent cells re-execute, enabling reactive features while preserving caching benefits for expensive computations.

## Rich Output Support

Plaque handles various output types:
- **Markdown**: Formatted text, headers, lists, links
- **LaTeX**: Mathematical equations (inline and display)
- **Plots**: Matplotlib, plotly, and other visualization libraries
- **DataFrames**: Pandas tables render nicely
- **HTML**: Rich interactive content
- **Custom visualizations**: Any rich display object

## Best Practices

### Document Structure
1. **Start with a title and overview** - Use a markdown cell to introduce the notebook
2. **Break work into sections** - Use markdown headers to organize
3. **Show your reasoning** - Explain assumptions and decisions
4. **One concept per cell** - Makes dependencies clear and caching effective

### Code Organization
1. **Keep cells focused** - Each cell should do one thing
2. **Display intermediate results** - Show your work
3. **Use meaningful variable names** - Makes reasoning transparent
4. **Import at the top** - Standard Python file conventions apply

### Interactive Development
1. **Use `plaque serve --open`** - Get instant feedback as you edit
2. **Let the cache work** - Structure cells so expensive operations don't need to re-run
3. **Check the browser** - See how your markdown and outputs render

## Example Workflow

```python
"""
# Data Analysis: Sales Report

Analyzing monthly sales data to identify trends.
"""

import pandas as pd
import matplotlib.pyplot as plt

"""
## Data Loading

Load the sales data from CSV.
"""

df = pd.read_csv('sales.csv')
df.head()  # Show first few rows

"""
## Summary Statistics

Calculate key metrics.
"""

total_sales = df['amount'].sum()
avg_sale = df['amount'].mean()

f"""
## Results

- **Total Sales**: ${total_sales:,.2f}
- **Average Sale**: ${avg_sale:,.2f}
"""

"""
## Visualization

Plot sales over time.
"""

plt.figure(figsize=(10, 6))
df.groupby('month')['amount'].sum().plot(kind='bar')
plt.title('Monthly Sales')
plt.ylabel('Sales ($)')
plt.show()
```

Then render with:
```bash
plaque serve analysis.py --open
```

## Resources

### References
- `plaque.md` - Detailed documentation for all features and options

## Tips for Effective Notebooks

1. **Narrate your work** - The markdown cells tell the story
2. **Show, don't just compute** - Display intermediate results
3. **Structure logically** - Guide the reader through your thinking
4. **Test incrementally** - Use `plaque serve` to see changes live
5. **Keep it clean** - Plain Python files are easy to version control
