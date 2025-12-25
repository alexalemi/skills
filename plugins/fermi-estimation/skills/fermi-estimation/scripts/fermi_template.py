"""
# Fermi Estimation: [PROBLEM TITLE]

[Brief 1-2 sentence description of what we're estimating and why it matters]
"""

import simplefermi as sf

"""
## Problem Breakdown

[Explain the approach: what are the key factors we need to estimate?
 How will we combine them to get the final answer?]

Key assumptions:
1. [First major assumption]
2. [Second major assumption]
3. [Third major assumption]
"""

"""
## Step 1: [First Component]

[Explain the reasoning for this estimate. What range are we considering?
 What distribution type makes sense and why?]
"""

component1 = sf.lognormal(low_estimate, high_estimate, 'units')
component1  # Display the distribution

"""
## Step 2: [Second Component]

[Explain this estimate]
"""

component2 = sf.outof(numerator, denominator)  # For proportions/percentages
component2

"""
## Step 3: [Third Component]

[Explain this estimate]
"""

component3 = sf.plusminus(mean, std, 'units')  # For normally distributed quantities
component3

"""
## Calculation

[Explain how we're combining these components. Show the formula/reasoning.]
"""

intermediate_result = component1 * component2 * component3

"""
## Final Result

[Convert to meaningful units and interpret the result.
 What does this tell us? Is it reasonable? Sanity checks?]
"""

final_result = intermediate_result.to('target_units')
final_result

"""
## Sensitivity Analysis

[Optional: Which assumptions matter most? What happens if we vary them?]
"""

"""
## Conclusion

[1-2 sentence summary of the estimate and its implications.
 Discuss the uncertainty range and what it means.]
"""
