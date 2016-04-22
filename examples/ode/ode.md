## Analysis of an Ordinary Differential Equation (DOE)

### ODE

$$x''(t) == -\omega^2 * x(t) - k * x'(t)$$

### Unknown ODE parameters

* k
* $\omega$

### An Example ODE solution

![](ode-solution.svg)

```
k = 0.1
$\omega$ = 0.2
```

### Local sensitivity analysis

![](ode-eigenmatrix.svg)

![](ode-eigenvalues.svg)

### Global sensitivity analysis

![](ode-SA-results.svg)

Prior parameter uncertainties:

```
k = LogUniform(0.01, 0.1)
$\omega$ = Uniform(0.1, 0.3)
```

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