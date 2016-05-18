## Analysis of an Ordinary Differential Equation (ODE)

All the figures below are generated using `examples/ode/ode.jl`.

### ODE

$$x''(t) = -\omega^2 * x(t) - k * x'(t)$$

#### Unknown ODE parameters

* k
* $\omega$

#### Example ODE solution

![](ode/ode-solution.svg)

For model parameters:

* k = 0.1
* $\omega$ = 0.2

### Local sensitivity analysis

![](ode/ode-eigenmatrix.png)

![](ode/ode-eigenvalues.png)

### Global sensitivity analysis (using eFAST)

![](ode/ode-efast-385.svg)

Probabilistic distributions of the prior parameter uncertainties are:

* k = LogUniform(0.01, 0.1)
* $\omega$ = Uniform(0.1, 0.3)

### Bayesian sensitivity analysis

#### Observations

Synthetic observations are applied to constrain the ODE parameters

![](ode/ode-match.png)

Observation errors are equal for all the sample locations with standard deviation equal to 1 (`observation weight` =  1 / `observation standard deviation` = 1 / 1 = 1)

#### Prior parameter uncertainties

##### *k* only

![](ode/ode-prior-k-100-spaghetti.png)

##### *$\omega$* only

![](ode/ode-prior-omega-100-spaghetti.png)

##### *Both* parameters

![](ode/ode-prior-100-spaghetti.png)

The observation data are plotted as a solid black line.

#### Histograms/scatter plots of Bayesian MCMC results

![](ode/ode-bayes.png)

#### Posterior parameter uncertainties

Note that now the parameter uncertainties are constrained by the observation data.

##### *k* only

![](ode/ode-posterior-k-1000-spaghetti.png)

##### *$\omega$* only

![](ode/ode-posterior-omega-1000-spaghetti.png)

##### *Both* parameters

![](ode/ode-posterior-1000-spaghetti.png)

The observation data are plotted as a solid black line.