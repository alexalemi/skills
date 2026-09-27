# NeoFermi Reference

NeoFermi is a Monte Carlo calculator DSL for Fermi estimation: every uncertain
value is 20,000 samples, units are tracked through all arithmetic, and results
display as a median with a 16th–84th percentile range.

- Source: https://github.com/alexalemi/neofermi (npm: `neofermi`)
- Live notebook: https://neofermi.alexalemi.com/
- Worked examples: https://neofermi.alexalemi.com/examples/

## Installation

The CLI is `neoferminb`. Check first with `which neoferminb`; if missing
(needs node >= 18):

```bash
npm install -g neofermi                              # or: bun add -g neofermi
npx -y -p neofermi neoferminb annotate notebook.md   # one-off, no install
```

## CLI

```bash
neoferminb annotate notebook.md            # evaluate, write results into the file
neoferminb annotate notebook.md -o out.md  # ... or into a different file
neoferminb notebook.md --output out.html   # render to static HTML with dotplots
neoferminb notebook.md                     # live-reload server in the browser
neoferminb --repl                          # interactive REPL
neoferminb init                            # scaffold a starter notebook
```

`annotate` is idempotent and seeded: re-running replaces old results rather
than duplicating them, and unchanged input produces byte-identical output.
Errors are printed to stderr as `Warning: code block ending at line N: ...`;
failing blocks get no result.

## Notebook Format

A notebook is plain markdown. Fenced blocks tagged `neofermi` (or untagged)
are evaluated top to bottom with shared variables; other languages are ignored.

- **Each block displays only its last expression.** Put one estimate per block
  so every intermediate value is shown. An assignment as the last line displays
  the assigned value.
- **Inline results:** `${expr}` in prose is replaced with the evaluated result,
  e.g. `We need **${tuners}** tuners` or `${distance as km}`.
- After `annotate`, results appear as:

  ````markdown
  ```neofermi
  x = 1 to 100 m
  ```

  <!-- nf:results -->
  > `10 [1, 100] m {length}`
  <!-- /nf:results -->
  ````

  Read as: median 10 m, 68% interval [1, 100] m, dimension `length`.

## Distributions

| Syntax | Meaning |
|---|---|
| `1 to 10 m` | Lognormal, **68% CI** (±1σ) from 1 to 10 m. Default for positive quantities. |
| `1 .. 10 m` | Uniform between 1 and 10 m |
| `100 +/- 5 kg` | Normal, mean 100, σ = 5 (also `±`) |
| `3 of 10` | Beta: 3 successes in 10 trials (proportions) |
| `3 against 7` | Beta: 3 successes, 7 failures |
| `100 kg * 10%` | Multiply by a ±10% twiddle factor |
| `{365: 303, 366: 97}` | Weighted discrete set (value: weight) |
| `'3.14 m` | Sig-fig number: uncertainty implied by the stated digits |
| `2.5 to 3 million` | Scale words apply to both bounds (`thousand`…`quintillion`) |

Constructor functions: `uniform`, `normal`, `lognormal`, `poisson`, `gamma`,
`exponential`, `binomial`. `lognormal(a, b)` takes exactly two arguments;
there is **no way to change the confidence level** — ranges are always 68%.

A bare number (`24`, `3 m`) is exact.

## Units

- Built-in units are bare identifiers: `m`, `km`, `kg`, `s`, `day`, `year`,
  `mile`, `mph`, `J`, `kWh`, `W`, `atm`, `degC`, `USD`, `dollars_1960`, ...
- Compound units: `kg/m^3`, `m/s**2`, `5 /day` or `5 per day` (reciprocal).
- **Custom units** use a backtick: ``3 to 5 `tuning / day``, ``1 `piano``.
  Unknown bare identifiers are errors (`Unknown unit: widgets. Use `widgets`).
  Custom units cancel like any other, so they're a free dimensional check.
- Define an alias: ``1 `widget = 5 kg``.
- Conversion: `x as km` or `x -> km`; `x as SI` for SI base units.
- Dates: `#2027-01-01# - #2026-01-01#` is a duration.

## Variables and Functions

```neofermi
x = 10 to 100
f(a, b) = a + b * 2
let y = 5 in y * 2
if x > 50 then x else 50
```

Statistics on a distribution: `median(x)`, `mean(x)`, `std(x)`,
`percentile(x, 0.9)`, `p5` `p10` `p25` `p75` `p90` `p95` `p99`.
Math: `sqrt`, `exp`, `ln`, `log10`, `log2`, `pow`, `min`, `max`, `abs`,
`round`, `floor`, `ceil`, `clamp`, trig functions.

## Built-in Constants

Constants with measured uncertainty are distributions (CODATA 2022).

- Math: `pi`, `e`, `tau`, `percent`, `ppm`, `ppb`
- Physics: `c`, `h`, `hbar`, `G`, `g`, `k`/`kB`, `N_A`, `R`, `sigma`,
  `epsilon0`, `mu0`, `m_e`, `m_p`, `alpha`
- Astronomy: `AU`, `ly`, `pc`, `M_sun`, `R_sun`, `L_sun`, `M_earth`,
  `R_earth`, `M_moon`, planet `M_*`/`R_*`, `solar_constant`
- Earth: `earth_surface_area`, `earth_land_area`, `earth_ocean_area`,
  `earth_circumference`, `rho_air`, `rho_water`, `atm`
- Materials & energy: `rho_steel`, `rho_concrete`, `rho_gold`, ...,
  `energy_density_gasoline`, `energy_density_lithium_battery`, `energy_density_tnt`, ...
- Human: `human_basal_power`, `human_caloric_intake`, `human_lifespan`,
  `human_blood_volume`
- Society/economy: `world_population`, `us_population`, `us_gdp`,
  `world_gdp`, `us_median_income`, `internet_users`, ...
- Time: `seconds_per_year`, `days_per_year`, `weeks_per_year`, ...

Prefer these over re-estimating well-known values.

## Gotchas

- **68%, not 90%.** `a to b` puts only about two-thirds of the mass between
  a and b; the bounds are ±1σ, where the density is steepest. Give your gut
  range of where the value lies, not a range you're sure of. (If you only have
  a 90% range, shrink it to about 0.6× its width in log space.)
- **Errors cascade.** A failing block leaves its variables undefined, so later
  blocks that use them fail too. Fix the first warning and re-run.
- **Reserved words:** `to`, `as`, `of`, `against`, `let`, `in`, `if`,
  `then`, `else` cannot be variable names.
- Apostrophe `'` means sig-figs (`'3.14`); backtick `` ` `` means custom unit.
