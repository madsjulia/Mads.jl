# MADS (Model Analysis & Decision Support)

**MADS** is an integrated open-source high-performance computational (HPC) framework in [Julia](http://julialang.org) for data analytics and model diagnostics.

**MADS** can execute a wide range of data- and model-based analyses:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Model Averaging
* Model Reduction and Surrogate Modeling
* Machine Learning (e.g., Blind Source Separation, Source Identification, Feature Extraction, Matrix / Tensor Factorization, etc.)
* Decision Analysis and Support

**MADS** has been tested to perform HPC simulations on multi-processor clusters, parallel and cloud computing environments (including Moab, Slurm, etc.).

**MADS** utilizes adaptive rules and techniques that allow the analyses to be performed with minimum user input.

**MADS** provides a series of alternative algorithms to execute various types of data- and model-based analyses implemented in the code.

## Publications, Presentations, Projects

* [mads.gitlab.io](http://mads.gitlab.io)
* [madsjulia.github.io](http://madsjulia.github.io)
* [mads.lanl.gov](http://mads.lanl.gov)
* [monty.gitlab.io](http://monty.gitlab.io)
* [ees.lanl.gov/monty](http://ees.lanl.gov/monty)

## Related Julia Packages

* [SmartTensors:
Unsupervised and Physics-Informed Machine Learning based on Matrix/Tensor Factorization](https://github.com/SmartTensors)
* [RegAE: Regularization with a variational autoencoder for inverse analysis](https://github.com/madsjulia/RegAE.jl)
* [Geostatistical Inversion with randomized + sketching optimization](https://github.com/madsjulia/GeostatInversion.jl)

## Additional information:

* web:
    - [mads.lanl.gov](http://mads.lanl.gov) (Julia version of MADS)
    - [madsc.lanl.gov](http://madsc.lanl.gov) (C version of MADS)
* documentation:
    - [github](`http://madsjulia.github.io/Mads.jl`) (recommended)
    - [readthedocs](`http://mads.readthedocs.org`)
    - [madsjulia.lanl.gov](http://madsjulia.lanl.gov) (might not be up-to-date)
* repos:
    - [github](http://github.com/madsjulia/Mads.jl) (recommended)
    - [gitlab](http://gitlab.com/mads/Mads.jl) (might not be up-to-date)
* git:
    - `git clone git@github.com:madsjulia/Mads.jl` (recommended)
    - `git clone git@gitlab.com:mads/Mads.jl` (might not be up-to-date)
* docker:
    - `docker run --interactive --tty montyvesselinov/madsjulia`
* email: [mads@lanl.gov](mailto:mads@lanl.gov)

---
LA-CC-15-080
