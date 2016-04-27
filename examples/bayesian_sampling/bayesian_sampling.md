## Bayesian Sampling

All the figures below are generated using `examples/bayesian_sampling/bayesian_sampling.jl`.

### Model setup

![](w01-problemsetup.svg)

* Contaminant source (orange rectangle)

* 3 monitoring wells

### Prior spaghetti plots

Spaghetti plots of 100 model runs representing the prior model prediction uncertainties at the 3 monitoring wells.

#### Joint spaghetti plots

All model parameters are changed simultaneously within their prior uncertainty ranges.

![](w01-prior-100-spaghetti.png)

#### Individual spaghetti plots

A single model parameter is changed at a time.

**Source $x$ location**

![](w01-prior-source1_x-100-spaghetti.png)

**Source $y$ location**

![](w01-prior-source1_y-100-spaghetti.png)

**Source size along $x$ axis**

![](w01-prior-source1_dx-100-spaghetti.png)

**Source size along $y$ axis**

![](w01-prior-source1_dx-100-spaghetti.png)

**Source release time $t_0$**

![](w01-prior-source1_t0-100-spaghetti.png)

**Source termination time $t_1$**

![](w01-prior-source1_t1-100-spaghetti.png)

### Model calibration match

![](w01-match.svg)

### Bayesian sampling results

![](w01-bayes.png)

### Posterior spaghetti plots

Spaghetti plots of 1000 model predictions representing the posterior model uncertainties at the 3 monitoring wells.


#### Joint spaghetti plots

All model parameters are changed simultaneously within their prior uncertainty ranges.

![](w01-posterior-1000-spaghetti.png)

#### Individual spaghetti plots

A single model parameter is changed at a time.

Note that only the posterior uncertainties in the source release time ($t_0$)  and the source termination time ($t_1$) are producing large impact in the model predictions.

**Source $x$ location (all the 1000 model predictions are overlapping)**

![](w01-posterior-source1_x-1000-spaghetti.png)

**Source $y$ location (all the 1000 model predictions are overlapping**

![](w01-posterior-source1_y-1000-spaghetti.png)

**Source size along $x$ axis (all the 1000 model predictions are overlapping**

![](w01-posterior-source1_dx-1000-spaghetti.png)

**Source size along $y$ axis (all the 1000 model predictions are overlapping**

![](w01-posterior-source1_dx-1000-spaghetti.png)

**Source release time $t_0$**

![](w01-posterior-source1_t0-1000-spaghetti.png)

**Source termination time $t_1$**

![](w01-posterior-source1_t1-1000-spaghetti.png)