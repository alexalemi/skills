---
name: fermi-estimation
description: Probabilistic estimation and dimensional reasoning for uncertain quantities. This skill should be used when asked to estimate quantities with significant uncertainty (e.g., "How many piano tuners in Chicago?", "What's the energy consumption of all data centers?", "Estimate the number of trees in Central Park"). Use when numerical estimates require breaking down complex problems, tracking units, and quantifying uncertainty.
---

# Fermi Estimation

## Overview

This skill enables probabilistic estimation using dimensional reasoning and uncertainty quantification. It uses **neofermi**, a Monte Carlo calculator DSL with unit tracking: estimates are written as markdown notebooks with `neofermi` code blocks, and the `neoferminb` CLI evaluates them, propagating 20,000 samples through every calculation.

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

### Step 1: Check for neoferminb

```bash
which neoferminb
```

If missing, install it from npm (needs node >= 18):

```bash
npm install -g neofermi   # or: bun add -g neofermi
```

Or run it without installing: `npx -y -p neofermi neoferminb annotate file.md`.

### Step 2: Write the Notebook

Create a markdown file (e.g. `piano_tuners.md`) starting from `assets/fermi_template.md`. Prose explains the reasoning; fenced ```` ```neofermi ```` blocks hold the calculations.

**Key principles:**
1. **Break down the problem** - Identify the key components needed for the estimate
2. **State assumptions clearly** - Explain the reasoning in prose before each block
3. **One estimate per block** - Each block displays only its *last* expression, so separate blocks make every intermediate value visible
4. **Use units everywhere** - Including custom units (`` `piano ``, `` `tuning ``) so dimensional analysis checks the logic
5. **Use appropriate distributions** - Choose syntax that matches the kind of uncertainty

### Step 3: Choose the Right Distributions

| Syntax | Use for |
|---|---|
| `2.5 to 3 million` | **Default.** Positive quantities with a plausible range (lognormal, 68% CI) |
| `2.5 +/- 0.5` | Quantities with a known mean and standard deviation (normal) |
| `1 of 20` | Proportions from rough counts: 1 success in 20 trials (beta) |
| `200 .. 250 day` | Only the bounds are known, nothing favored inside (uniform) |
| `'40075.017 km` | Precisely reported values: sig-fig uncertainty in the last digit |
| `x * 10%` | Multiplicative ±10% fudge on a value |
| `24` | Truly exact values (definitions, counts, math constants) |

Prefer built-in constants (`world_population`, `R_earth`, `c`, `energy_density_gasoline`, ...) over re-estimating known values. See `references/neofermi.md` for the full syntax, units, constants, and gotchas.

**Important**: Don't invent uncertainty for precisely-known values. If a value is reported to a certain precision, use a sig-fig literal (`'40075.017 km`) so the uncertainty reflects the stated digits.

### Step 4: Choose Range Bounds (Calibration)

`a to b` is a **68% interval** (±1σ), not the 90% interval people usually give when asked for a range. The DSL has no way to change this.

So pick the bounds as your **gut range** — where you feel the value lies — not the range you'd be sure it falls in. The ±1σ points are where a Gaussian's density is steepest, i.e. where plausibility is changing fastest; `a to b` should mark where "sounds about right" turns into "hmm, that seems off". For a lognormal the same holds in log space. (This framing is inspired by Sanjoy Mahajan and his book *Street-Fighting Mathematics*.)

- Don't widen bounds to cover everything conceivable; the tails already put about 1/3 of the mass outside `a to b`.
- If a quantity really is "anywhere between X and Y, nothing favored," use `X .. Y` (uniform) instead.

### Step 5: Evaluate and Check

```bash
neoferminb annotate piano_tuners.md
```

This writes each block's result into the file (`> `100 [30, 300]`` = median, 16th–84th percentile range) and fills in any `${expr}` in the prose. It is seeded and idempotent, so re-run freely after edits.

- Read the warnings on stderr. A failing block leaves its variables undefined, so **fix the first warning first**; later ones are often knock-on errors.
- Read the annotated file and sanity-check every intermediate result before writing conclusions.
- Write the conclusion using `${result}` inline so the numbers stay in sync with the calculation.

### Step 6: Present the Results

- The annotated markdown is itself a readable, standalone report — share it directly.
- For a rendered page with dotplots: `neoferminb piano_tuners.md --output piano_tuners.html`
- For live editing in the browser: `neoferminb piano_tuners.md` (live reload)
- In chat, report the median and range, and name the assumption that dominates the uncertainty.

## Notebook Structure

````markdown
# Fermi Estimation: [Problem Title]

Brief description of what we're estimating.

## Problem Breakdown

Approach, formula, key assumptions.

## Step 1: [Component]

Reasoning for this estimate.

```neofermi
population = 2.5 to 3 million
```

## Step 2: [Component]

```neofermi
pianos = population / (2.5 +/- 0.5) * (1 of 20) * 1 `piano
```

...

## Calculation

```neofermi
tuners = demand / capacity
```

## Conclusion

We estimate **${tuners}** piano tuners. [Interpretation, dominant uncertainty, comparison.]
````

See `examples/piano_tuners.md` for a complete, verified example.

## Best Practices

### Problem Decomposition
- Break complex estimates into 3-7 components
- Each component should be independently estimatable
- Combine with multiplication/division to get final result

### Dimensional Analysis
- Always include units; invent custom units with a backtick (`` `piano ``, `` `tuning ``) for counted things
- A count that should be dimensionless should come out with no unit. Leftover units mean a mistake in the logic
- Use `as` to convert for display: `x as km`, `` x as `tuning / year ``
- Dimensional mismatches raise errors (which is good!)

### Documentation
- Explain every assumption in prose next to its block
- Show intermediate results, one block per step
- Include a "Problem Breakdown" section explaining the approach
- End with a "Conclusion" that interprets the uncertainty range

### Sanity Checks
- Does the order of magnitude make sense?
- Are the units correct (and did custom units cancel)?
- Is the uncertainty range reasonable? Which input drives it?
- Compare to known similar quantities if possible

## Resources

### Assets
- `assets/fermi_template.md` - Template notebook for new estimations

### Examples
- `examples/piano_tuners.md` - Complete example of a classic Fermi problem
- More worked examples: https://neofermi.alexalemi.com/examples/

### References
- `references/neofermi.md` - Full DSL reference: distributions, units, constants, functions, CLI, gotchas

## Tips for Effective Estimations

1. **Identify ambiguities in the problem** - Unclear specifications are genuine uncertainty that should be captured. Example: "around the Earth" is ambiguous (equatorial vs polar circumference differs by ~0.17%)
2. **Start simple** - Begin with a rough decomposition, refine if needed
3. **Make assumptions explicit** - Every assumption should be visible in the prose
4. **Capture real uncertainty sources**:
   - Problem ambiguity → `a to b` over the range of interpretations
   - Measurement precision → sig-fig literals like `'42.0 kg`
   - Rough estimates → `a to b` or `k of n`
5. **Don't invent uncertainty** - If a value is precise and the problem is unambiguous, use a sig-fig literal or an exact number
6. **Think in orders of magnitude** - Getting within 2-3x is success for true Fermi problems
7. **Narrate your reasoning** - The prose is as important as the calculations
