MADS (Model Analysis & Decision Support)
----------------------------------------

MADS is an integrated open-source high-performance computational (HPC) framework in [Julia](http://julialang.org).
MADS can execute a wide range of data- and model-based analyses:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Model Averaging
* Model Reduction and Surrogate Modeling
* Machine Learning (e.g. Blind Source Separation, Source Identification, Feature Extraction, Matrix / Tensor Factorization, etc.)
* Decision Analysis and Support

MADS has been tested to perform HPC simulations on a wide-range multi-processor clusters and parallel environments (Moab, Slurm, etc.).
MADS utilizes adaptive rules and techniques which allows the analyses to be performed with minimum user input.
The code provides a series of alternative algorithms to execute each type of data- and model-based analyses.

For additional information:

* web:
    - [mads.lanl.gov](http://mads.lanl.gov)
    - [madsc.lanl.gov](http://madsc.lanl.gov) (C version of MADS)
* documentation:
    - [github](`http://madsjulia.github.io/Mads.jl`) (recommended)
    - [readthedocs](`http://mads.readthedocs.org`)
    - [madsjulia.lanl.gov](http://madsjulia.lanl.gov) (it might not be up-to-date)
* repos:
    - [github](http://github.com/madsjulia/Mads.jl) (recommended)
    - [gitlab](http://gitlab.com/mads/Mads.jl) (it might not be up-to-date)
* git:
    - `git clone git@github.com:madsjulia/Mads.jl` (recommended)
    - `git clone git@gitlab.com:mads/Mads.jl` (it might not be up-to-date)
* email: [mads@lanl.gov](mailto:mads@lanl.gov)

Builds & Tests
--------------

**Mads Build & Test Status @ JuliaLang.org**

[![julialang](http://pkg.julialang.org/badges/Mads_0.5.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.5)
[![julialang](http://pkg.julialang.org/badges/Mads_0.6.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.6)
[![julialang](http://pkg.julialang.org/badges/Mads_0.7.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.7)

**Mads Build & Test Status @ Travis Continuous Integration (CI) service (OS X & linux)**

[![Travis Status](https://travis-ci.org/madsjulia/Mads.jl.svg?branch=master)](https://travis-ci.org/madsjulia/Mads.jl)

**Coverage of the Build-in Mads Tests**

[![Coverage Status](https://coveralls.io/repos/madsjulia/Mads.jl/badge.svg?branch=master)](https://coveralls.io/r/madsjulia/Mads.jl?branch=master)

LA-CC-15-080

Publications, Presentations, Projects
-------------------------------------

* [mads.gitlab.io](http://mads.gitlab.io)
* [mads.lanl.gov](http://mads.lanl.gov)
* [monty.gitlab.io](http://monty.gitlab.io)
* [ees.lanl.gov/monty](http://ees.lanl.gov/monty)