---
name: fermi-estimation
description: Probabilistic estimation and dimensional reasoning for uncertain quantities. This skill should be used when asked to estimate quantities with significant uncertainty (e.g., "How many piano tuners in Chicago?", "What's the energy consumption of all data centers?", "Estimate the number of trees in Central Park"). Use when numerical estimates require breaking down complex problems, tracking units, and quantifying uncertainty.
---

# Fermi Estimation

## Overview

This skill enables probabilistic estimation using dimensional reasoning and uncertainty quantification. It uses the `simplefermi` package for unit-aware probabilistic calculations, implementing the "GUM Supplement on the Monte Carlo Method" for practical probabilistic computation.

## When to Use This Skill

Use this skill when asked to:
- Estimate quantities that cannot be known with certainty
- Break down complex estimation problems into simpler components
- Quantify uncertainty in numerical estimates
- Perform dimensional analysis with uncertainty propagation
- Create transparent, well-documented estimation reasoning

**Example queries that trigger this skill:**
- "How many piano tuners are there in Chicago?"
- "Estimate the total energy consumption of all data centers worldwide"
- "How many trees are in Central Park?"
- "What's the probability that [some uncertain event]?"
- "Estimate [any quantity requiring order-of-magnitude reasoning]"

## Core Workflow

### Step 1: Install SimpleFermi

```bash
pip install simplefermi
# or: uv pip install simplefermi
```

### Step 2: Create the Estimation

Create a Python file using the multiline comment style for clarity. Use `scripts/fermi_template.py` as a starting point.

**Key principles:**
1. **Break down the problem** - Identify the key components needed for the estimate
2. **State assumptions clearly** - Use markdown cells to explain reasoning
3. **One estimate per cell** - Keep calculations focused and traceable
4. **Show your work** - Display intermediate results
5. **Use appropriate distributions** - Choose distribution functions that match the uncertainty

### Step 3: Choose the Right Distribution Functions

SimpleFermi provides several distribution functions for different types of uncertainty:

- `Q(value, 'units')` - For truly exact values with no uncertainty (rare)
- `sigfig('value', 'units')` - **For precisely-known measurements** - captures implicit uncertainty in the final reported digit(s). Use this for physical constants, regulated standards, or precisely measured values.
- `lognormal(low, high, 'units')` - For positive quantities where you estimate a plausible range (most physical things)
- `plusminus(mean, std, 'units')` - For normally distributed quantities with known mean and standard deviation
- `outof(part, whole)` - For proportions and percentages based on counting (e.g., 1 in 20)
- `percent(p)` - For multiplicative uncertainty (e.g., ±10%)

**Important**: Don't invent uncertainty for precisely-known values. If a value is reported to a certain precision (e.g., "40,075.017 km"), use `sigfig('40075.017', 'units')` to properly represent the measurement uncertainty in the final digits. Only use `Q()` for truly exact values like mathematical constants or defined standards.

Reference `references/simplefermi.md` for detailed documentation.

### Step 4: Structure the Estimation

Follow this structure:

```python
"""
# Fermi Estimation: [Problem Title]

Brief description of what we're estimating.
"""

import simplefermi as sf

"""
## Problem Breakdown

Explain the approach and key assumptions.
"""

"""
## Step 1: [Component Name]

Explain the reasoning for this estimate.
"""

component1 = sf.lognormal(low, high, 'units')
component1  # Display to show uncertainty distribution

"""
## Step 2: [Next Component]

Continue building up the estimate...
"""

# More steps...

"""
## Calculation

Combine the components with clear reasoning.
"""

result = component1 * component2 * component3

"""
## Final Result

Interpret the result with uncertainty range.
"""

final = result.to('desired_units')
final
```

See `scripts/example_piano_tuners.py` for a complete example.

### Step 5: Present the Results

For creating a beautifully rendered report of your estimation, use the **plaque** skill to transform your Python file into an interactive HTML notebook. The plaque skill provides tools for rendering your work with rich formatting and visualizations.

## Best Practices

### Problem Decomposition
- Break complex estimates into 3-7 components
- Each component should be independently estimatable
- Combine with multiplication/division to get final result

### Uncertainty Representation
- Use `sigfig('value', 'units')` for precisely-known measurements to capture implicit precision uncertainty
- Use `lognormal()` for physical quantities where you're estimating a plausible range
- Use `outof()` for proportions based on rough counts (e.g., "about 1 in 20")
- Use `plusminus()` for quantities with known mean and standard deviation
- Don't invent uncertainty for well-known values - use `sigfig()` to represent measurement precision
- Don't be overly precise with estimates - Fermi problems are about orders of magnitude

### Documentation
- Explain every assumption in a markdown cell
- Show intermediate results to make reasoning transparent
- Include a "Problem Breakdown" section explaining the approach
- End with a "Conclusion" interpreting the uncertainty range

### Dimensional Analysis
- Always include units on quantities
- Let SimpleFermi track unit propagation automatically
- Use `.to('units')` to convert to meaningful final units
- Dimensional mismatches will raise errors (which is good!)

### Sanity Checks
- Does the order of magnitude make sense?
- Are the units correct?
- Is the uncertainty range reasonable?
- Compare to known similar quantities if possible

## Example Workflow

For the query "How many piano tuners are there in Chicago?":

1. **Install simplefermi** (if needed)
2. **Create `piano_tuners.py`** based on `scripts/fermi_template.py`
3. **Break down the problem:**
   - Population of Chicago
   - Households per person
   - Pianos per household
   - Tunings per year
   - Pianos serviced per tuner per year
4. **Estimate each component** with appropriate distributions
5. **Combine** with dimensional reasoning
6. **Present** using the plaque skill for a formatted report

See `scripts/example_piano_tuners.py` for the complete implementation.

## Resources

### Scripts
- `fermi_template.py` - Template for creating new Fermi estimations
- `example_piano_tuners.py` - Complete example of a classic Fermi problem

### References
- `simplefermi.md` - Detailed API reference for the simplefermi package

### Related Skills
- **plaque** - For creating beautifully rendered reports of your estimations

## Tips for Effective Estimations

1. **Identify ambiguities in the problem** - Unclear specifications are sources of genuine uncertainty that should be captured. Example: "around the Earth" is ambiguous (equatorial vs polar circumference differs by ~0.17%)
2. **Start simple** - Begin with a rough decomposition, refine if needed
3. **Make assumptions explicit** - Every assumption should be visible
4. **Capture real uncertainty sources** - Use appropriate distributions:
   - Problem ambiguity → `lognormal(low, high, 'units')` for the range of interpretations
   - Measurement precision → `sigfig('value', 'units')` for reported precision
   - Rough estimates → `lognormal()` or `outof()` for order-of-magnitude ranges
5. **Don't invent uncertainty** - If a value is precise and the problem is unambiguous, use `sigfig()` or `Q()`
6. **Think in orders of magnitude** - Getting within 2-3x is success for true Fermi problems
7. **Show the distribution** - Display intermediate results to show uncertainty
8. **Narrate your reasoning** - The markdown cells are as important as the code
