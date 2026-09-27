# Fermi Estimation: Piano Tuners in Chicago

The classic Fermi problem: estimating the number of piano tuners in a large city.
This demonstrates dimensional reasoning and uncertainty propagation.

## Problem Breakdown

To estimate piano tuners, we need:

1. Total number of pianos in the city
2. How often pianos need tuning
3. How many pianos a tuner can service per year

Number of tuners = (pianos × tunings per piano per year) ÷ (tunings per tuner per year)

We track two custom units, `` `piano `` and `` `tuning ``, so the dimensional
analysis catches mistakes: the final answer should be a pure number.

## Step 1: Population of Chicago

Chicago's population is about 2.7 million. We're fairly confident, so the
range is narrow. Remember `a to b` is a *68%* range — roughly ±1σ.

```neofermi
population = 2.5 to 3 million
```

## Step 2: Households

Average urban household size is around 2.5 people, give or take half a person.

```neofermi
people_per_household = 2.5 +/- 0.5
households = population / people_per_household
```

## Step 3: Pianos

Not every household has a piano. Say about 1 household in 20, which also
loosely accounts for institutions (schools, churches, venues).

```neofermi
ownership = 1 of 20
pianos = households * ownership * 1 `piano
```

## Step 4: Tuning Demand

Most owners who tune at all tune about once a year; enthusiasts more,
neglectful owners less.

```neofermi
tunings_per_piano = 0.5 to 2 `tuning / `piano / year
demand = pianos * tunings_per_piano
demand as `tuning / year
```

## Step 5: Tuner Capacity

A tuner might manage 3–5 tunings per day (including travel), working
200–250 days a year.

```neofermi
per_day = 3 to 5 `tuning / day
work_days = 200 .. 250 day / year
capacity = per_day * work_days
capacity as `tuning / year
```

## Calculation

The custom units cancel, leaving a dimensionless count of tuners.

```neofermi
tuners = demand / capacity
```

## Conclusion

We estimate **${tuners}** piano tuners in Chicago (median, with 16th–84th
percentile range), i.e. about a hundred, give or take a factor of three.

For comparison, directory listings have historically shown on the order of
80–150 piano tuners in the Chicago area — the right order of magnitude.
The largest source of uncertainty is tuning frequency, which spans a factor of 4.
