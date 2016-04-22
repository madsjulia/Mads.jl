## Contaminant transport in an aquifer

### Model setup

![](w01-problemsetup.svg)

There are 20 monitoring wells.
Each well has 2 measurement ports: shallow (3 m below the water table labelled `a`) and deep (33 m below the water table labelled `b`).
Contaminant concentrations are observed for 50 years at each well.

### Unknown model parameters

* Start Time of contaminant releast `$t_0$`
* Ent Time of contaminant releast `$t_1$`
* Advctive pore velocity `$v$`

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

### Gloabal sensitivity analysis

![](ode-SA-results.svg)

Prior parameter uncertainties:

```
k = LogUniform(0.01, 0.1)
omega = Uniform(0.1, 0.3)
```

### Bayesian sensitivity analysis

#### Observations

Synthetic observations are applied to contrain the ODE parameters

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