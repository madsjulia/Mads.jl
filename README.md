# MADS (Model Analysis & Decision Support)

![logo](logos/mads_black_swan_logo_big_text_new_3inch.png)

[action-img]: https://github.com/madsjulia/Mads.jl/workflows/CI/badge.svg
[action-url]: https://github.com/madsjulia/Mads.jl/actions

[![coveralls.io](https://coveralls.io/repos/madsjulia/Mads.jl/badge.svg?branch=master)](https://coveralls.io/r/madsjulia/Mads.jl?branch=master)
<!-- [![codecov.io](http://codecov.io/github/madsjulia/Mads.jl/coverage.svg?branch=master)](http://codecov.io/github/madsjulia/Mads.jl?branch=master) -->

[MADS](http://madsjulia.github.io/Mads.jl) is an integrated high-performance computational framework for data/model/decision analyses.

[MADS](http://madsjulia.github.io/Mads.jl) can be applied to perform:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Averaging
* Model Reduction and Surrogate Modeling
* Risk Assessment
* Decision Analysis and Support

[MADS](http://madsjulia.github.io/Mads.jl) utilizes adaptive rules and techniques that allow the analyses to be performed efficiently with minimum user input.

[MADS](http://madsjulia.github.io/Mads.jl) provides a series of alternative algorithms to execute various types of data-based and model-based analyses.

[MADS](http://madsjulia.github.io/Mads.jl) can efficiently utilize available computational resources.

[MADS](http://madsjulia.github.io/Mads.jl) has been extensively tested and verified.

## Documentation

[MADS](http://madsjulia.github.io/Mads.jl) documentation, including descriptions of all modules, functions, and variables, is available at:
- [GitHub](http://madsjulia.github.io/Mads.jl) (always up-to-date)
- [ReadtheDocs](https://mads.readthedocs.io)

[MADS](http://madsjulia.github.io/Mads.jl) information is also available at [mads.gitlab.io](http://mads.gitlab.io) and [madsjulia.github.io](http://madsjulia.github.io/Mads.jl)

Detailed demontrative data analysis and model diagnostics problems are available as [Julia scripts](https://github.com/madsjulia/Mads.jl/tree/master/examples) and [Jupyter notebooks](https://github.com/madsjulia/Mads.jl/tree/master/notebooks/model_diagnostics). See also below.

## Installation

In [Julia](https://julialang.org/downloads) REPL, execute:

```julia
import Pkg; Pkg.add("Mads")
```

To utilize the latest code updates, use:

```julia
import Pkg; Pkg.add(Pkg.PackageSpec(name="Mads", rev="master"))
```

## Testing

Execute:

```julia
import Mads; Mads.test()
```

or

```julia
import Pkg; Pkg.test("Mads")
```

## Getting started

To explore getting-started instructions, execute:

```julia
import Mads; Mads.help()
```

## Examples

Various examples are located in the `examples` directory of the `Mads` repository.

A list of all the examples is provided by:

```julia
Mads.examples()
```

A specific can be executed using:

```julia
Mads.examples("contamination")
```

or

```julia
include(joinpath(Mads.dir, "examples", "contamination", "contamination.jl"))
```

This example will demonstrate various  analyses related to groundwater contaminant transport.

To perform Bayesian Information Gap Decision Theory (BIG-DT) analysis, execute:

```julia
Mads.examples("bigdt")
```

or

```julia
include(joinpath(Mads.dir, "examples", "bigdt", "bigdt.jl"))
```

## Notebooks

To explore available notebooks, please execute:

```julia
Mads.notebooks()
```

## Docker

```bash
docker run --interactive --tty montyvesselinov/madsjulia
```

## Related Julia Packages

* [SmartTensors:
Unsupervised and Physics-Informed Machine Learning based on Matrix/Tensor Factorization](https://github.com/SmartTensors)
* [RegAE: Regularization with a variational autoencoder for inverse analysis](https://github.com/madsjulia/RegAE.jl)
* [Geostatistical Inversion with randomized + sketching optimization](https://github.com/madsjulia/GeostatInversion.jl)

## Publications, Presentations, Projects

* [mads @ GitLab](http://mads.gitlab.io)
* [mads @ GitHub](http://madsjulia.github.io)
* [SmartTensors.com](https://smarttensors.com)
* [SmartTensors @ GitHub](https://smarttensors.github.io)
* [monty @ GitLab](http://monty.gitlab.io)
* [monty @ GitHub](http://montyvesselinov.github.io)
