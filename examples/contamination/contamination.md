## Analysis of contaminant transport in an aquifer

### Model setup

![](w01-problemsetup.svg)

There are 20 monitoring wells.
Each well has 2 measurement ports: shallow (3 m below the water table labeled `a`) and deep (33 m below the water table labeled `b`).
Contaminant concentrations are observed for 50 years at each well.
The contaminant transport is solved using the `Anasol` package in Mads.

### Unknown model parameters

* Start Time of contaminant release `$t_0$`
* End Time of contaminant release `$t_1$`
* Advective pore velocity `$v$`

### Example model solution

![](w01-solution.svg)

```
$t_0 = 4$
$t_1 = 15$
$v = 40$
```

### Reduced analysis 

Analysis of the data from only 2 monitoring locations: w13a and w20a.

### Calibration match between observations and model predictions

![](w01-match.svg)

### Local sensitivity analysis

![](ode-eigenmatrix.svg)

![](ode-eigenvalues.svg)

### Global sensitivity analysis

![](ode-SA-results.svg)

Prior parameter uncertainties:

```
$t_0$ = Uniform(0, 10)
$t_1$ = Uniform(5, 40)
$v$ = LogUniform(0.1, 200)
```

![](w01-w13a_w20a-source1_t0-10-spaghetti.svg)
![](w01-w13a_w20a-source2_t1-10-spaghetti.svg)
![](w01-w13a_w20a-vx-10-spaghetti.svg)

### Bayesian sensitivity analysis

#### Observations

Synthetic observations are applied to constrain the ODE parameters

![](ode-observations.svg)

Observation errors are equal for all the sample locations with standard deviation equal to 1 (`observation weight` =  1 / `observation standard deviation` = 1 / 1 = 1)

#### Prior parameter uncertainties

![](ode-prior-k-100-spaghetti.svg)

![](ode-prior-omega-100-spaghetti.svg)

#### Histograms/scatter plots of Bayesian MCMC results

![](ode-bayes.svg)

#### Posterior parameter uncertainties

Note: parameter uncertainties are constrained by observation data

![](ode-posterior-k-100-spaghetti.svg)

![](ode-posterior-omega-100-spaghetti.svg)