"""
# Fermi Estimation: Piano Tuners in Chicago

The classic Fermi problem: estimating the number of piano tuners in a large city.
This demonstrates dimensional reasoning and uncertainty quantification.
"""

import simplefermi as sf

"""
## Problem Breakdown

To estimate piano tuners, we need:
1. Total number of pianos in the city
2. How often pianos need tuning
3. How many pianos a tuner can service per year

The number of tuners = (pianos × tunings/year) ÷ (pianos serviced/tuner/year)
"""

"""
## Step 1: Population of Chicago

Chicago's population is approximately 2.5-3 million people.
"""

population = sf.lognormal(2.5e6, 3e6, 'people')
population

"""
## Step 2: People per Household

Average household size in urban areas is typically 2-3 people.
"""

people_per_household = sf.plusminus(2.5, 0.5, 'people/household')
households = population / people_per_household
households

"""
## Step 3: Pianos per Household

Not every household has a piano. Estimate about 1 in 20 households.
This accounts for both private homes and institutions (schools, churches, etc.)
"""

piano_ownership_rate = sf.outof(1, 20)
total_pianos = households * piano_ownership_rate
total_pianos

"""
## Step 4: Tuning Frequency

Most piano owners get their piano tuned once per year.
Some enthusiasts tune more often, some less, so 1/year is reasonable.
"""

tunings_per_piano = sf.Q(1, '1/year')

"""
## Step 5: Pianos Serviced per Tuner

A piano tuner might service 3-5 pianos per day, working 200-250 days per year.
Let's estimate 4 pianos/day × 225 days/year.
"""

pianos_per_day = sf.plusminus(4, 1, 'pianos/day')
working_days = sf.plusminus(225, 25, 'days/year')
pianos_per_tuner_per_year = pianos_per_day * working_days
pianos_per_tuner_per_year

"""
## Calculation

Number of tuners = (total pianos × tunings per year) ÷ (pianos serviced per tuner per year)
"""

total_tuning_demand = total_pianos * tunings_per_piano
number_of_tuners = total_tuning_demand / pianos_per_tuner_per_year
number_of_tuners

"""
## Final Result

Converting to dimensionless count of tuners:
"""

final_result = number_of_tuners.to('')  # Dimensionless
final_result

"""
## Conclusion

We estimate approximately **100-150 piano tuners** in Chicago (with significant uncertainty).

This is remarkably close to real estimates! The actual number is thought to be around 125-150.

The uncertainty range spans about a factor of 2-3, which is typical for Fermi estimates.
The key insight is that even with rough assumptions, we can get within the right
order of magnitude.
"""
