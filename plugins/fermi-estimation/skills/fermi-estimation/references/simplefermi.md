# SimpleFermi Reference

## Overview

SimpleFermi is a Python package that combines unit awareness with uncertainty quantification for Fermi estimation. It implements the "GUM Supplement on the Monte Carlo Method" for practical probabilistic computation.

## Installation

```python
# Install from PyPI
# pip install simplefermi
# or: uv pip install simplefermi

import simplefermi as sf
```

## Core Concepts

### Quantities

The fundamental data type combining numerical values with units and uncertainty:

```python
# Basic quantity with units
velocity = sf.Q(1, 'm/s')  # 1 meter per second

# Arithmetic preserves units automatically
distance = velocity * sf.Q(10, 's')  # Result: 10 m
```

### Distribution Functions

These represent uncertain values with different probability distributions:

#### `plusminus(mean, std)`
Explicit mean and standard deviation (normal distribution):
```python
height = sf.plusminus(1.7, 0.1, 'm')  # 1.7 ± 0.1 meters
```

#### `lognormal(low, high)`
For positive physical quantities (commonly used for things that can't be negative):
```python
population = sf.lognormal(1e6, 10e6, 'people')  # Between 1M and 10M people
```

#### `outof(part, whole)`
Beta distribution for percentages and proportions:
```python
success_rate = sf.outof(7, 10)  # 7 out of 10 (70% with uncertainty)
```

#### `sigfig(string)`
Uniform distribution based on significant figures:
```python
measurement = sf.sigfig('42', 'kg')  # Represents 42 kg with implicit uncertainty
```

#### `percent(percentage)`
Multiplicative error introduction:
```python
approximate_value = sf.Q(100, 'kg') * sf.percent(10)  # 100 kg ± 10%
```

#### `data(values)`
Bootstrap sampling from empirical measurements:
```python
measurements = sf.data([98.1, 99.2, 100.3, 101.1], 'kg')
```

## Physical Constants

SimpleFermi includes CODATA18 constants with measured uncertainties:

```python
# Access physical constants
speed_of_light = sf.c  # Speed of light
planck = sf.h  # Planck constant
avogadro = sf.N_A  # Avogadro's number
```

## Unit Conversion

Use the `.to()` method for dimensional analysis:

```python
speed = sf.Q(100, 'km/hr')
speed_mps = speed.to('m/s')  # Convert to meters per second
```

## Visualization

In Jupyter environments, quantities display as quantile dotplots showing the uncertainty distribution.

## Fermi Estimation Pattern

Typical workflow for Fermi problems:

1. Break down the problem into estimatable components
2. Use appropriate distribution functions for each uncertain quantity
3. Combine quantities with arithmetic operations
4. Units and uncertainties propagate automatically
5. Convert final result to desired units

## Example: Estimating CO₂ Emissions

```python
import simplefermi as sf

# Global energy usage
energy = sf.lognormal(500, 700, 'EJ/year')  # Exajoules per year

# Fraction from fossil fuels
fossil_fraction = sf.outof(85, 100)  # ~85%

# Carbon content per energy
carbon_per_energy = sf.plusminus(20, 2, 'kg/GJ')  # kg carbon per gigajoule

# CO₂ molecular weight ratio (CO₂/C)
co2_mass_ratio = 44/12  # Molecular weights

# Calculate total CO₂
co2_emissions = energy * fossil_fraction * carbon_per_energy * co2_mass_ratio
co2_emissions_gt = co2_emissions.to('Gt/year')  # Convert to gigatons per year
```

This demonstrates how SimpleFermi handles complex multi-step estimates with automatic uncertainty propagation and unit tracking.
