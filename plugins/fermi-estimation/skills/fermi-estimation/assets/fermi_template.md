# Fermi Estimation: [PROBLEM TITLE]

[Brief 1-2 sentence description of what we're estimating and why it matters.]

## Problem Breakdown

[Explain the approach: what are the key factors we need to estimate?
How will we combine them to get the final answer? Write the formula.]

Key assumptions:

1. [First major assumption]
2. [Second major assumption]
3. [Third major assumption]

## Step 1: [First Component]

[Explain the reasoning. What range are we considering, and why?
Remember `a to b` is a 68% (±1σ) lognormal range.]

```neofermi
component1 = LOW to HIGH units
```

## Step 2: [Second Component]

[Explain this estimate.]

```neofermi
component2 = K of N
```

## Step 3: [Third Component]

[Explain this estimate.]

```neofermi
component3 = MEAN +/- SIGMA units
```

## Calculation

[Explain how the components combine.]

```neofermi
result = component1 * component2 * component3
```

## Final Result

[Convert to meaningful units and sanity-check.]

```neofermi
result as TARGET_UNITS
```

## Conclusion

We estimate **${result as TARGET_UNITS}**.

[Interpret the median and the uncertainty range. Which assumption dominates
the uncertainty? How does it compare to any known reference value?]
