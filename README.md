MADS (Model Analysis & Decision Support)
=======================================

![logo](logo/mads_black_swan_logo_big_text_new_3inch.png)

[![travis-ci](https://travis-ci.org/madsjulia/Mads.jl.svg?branch=master)](https://travis-ci.org/madsjulia/Mads.jl)
[![appveyor](https://ci.appveyor.com/api/projects/status/github/madsjulia/Example.jl?branch=master&svg=true)](https://ci.appveyor.com/project/montyvesselinov/mads-jl/branch/master)
[![coveralls.io](https://coveralls.io/repos/madsjulia/Mads.jl/badge.svg?branch=master)](https://coveralls.io/r/madsjulia/Mads.jl?branch=master)
[![codecov.io](http://codecov.io/github/madsjulia/Mads.jl/coverage.svg?branch=master)](http://codecov.io/github/madsjulia/Mads.jl?branch=master)

[MADS](http://madsjulia.github.io/Mads.jl) is an integrated open-source high-performance computational (HPC) framework in [Julia](http://julialang.org).
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

Documentation
=============

Detailed documentation including description of all MADS modules and functions is available at [GitHub](http://madsjulia.github.io/Mads.jl), [ReadtheDocs](https://mads.readthedocs.io) and [LANL](https://madsjulia.lanl.gov) sites.

See also [mads.gitlab.io](http://mads.gitlab.io) and [madsjulia.github.io](http://madsjulia.github.io/Mads.jl)

Installation
-------------

After starting Julia, execute:

```julia
import Pkg; Pkg.add("Mads")
```

to access the latest released version.
To utilize the latest updates (commits) use:

```julia
import Pkg; Pkg.add(Pkg.PackageSpec(name="Mads", rev="master"))
```

Docker
-------

```bash
docker run --interactive --tty montyvesselinov/madsjulia
```

Testing
-------------

```julia
import Mads; Mads.test()
```

Examples
-------------

To explore getting-started instructions, execute:

```julia
import Mads; Mads.help()
```

There are various examples located in the `examples` directory of the `Mads` repository.

For example, execute

```julia
include(Mads.madsdir * "/../examples/contamination/contamination.jl")
```

to perform various example analyses related to groundwater contaminant transport, or execute

```julia
include(Mads.madsdir * "/../examples/bigdt/bigdt.jl")
```

to perform Bayesian Information Gap Decision Theory (BIG-DT) analysis.

Installation of MADS behind a firewall
------------------------------

Julia uses git for package management.
Add in the `.gitconfig` file in your home directory to support git behind a firewall:

```
[url "https://"]
        insteadOf = git://
```

or execute:

```bash
git config --global url."https://".insteadOf git://
```

Set proxies executing the following lines in the bash command-line environment:

```bash
export ftp_proxy=http://proxyout.<your_site>:8080
export rsync_proxy=http://proxyout.<your_site>:8080
export http_proxy=http://proxyout.<your_site>:8080
export https_proxy=http://proxyout.<your_site>:8080
export no_proxy=.<your_site>
```

For example, at LANL, you will need to execute the following lines in the bash command-line environment:

```bash
export ftp_proxy=http://proxyout.lanl.gov:8080
export rsync_proxy=http://proxyout.lanl.gov:8080
export http_proxy=http://proxyout.lanl.gov:8080
export https_proxy=http://proxyout.lanl.gov:8080
export no_proxy=.lanl.gov
```

Proxies can be also set up directly in the Julia REPL as well:

```julia
ENV["ftp_proxy"] =  "http://proxyout.lanl.gov:8080"
ENV["rsync_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["http_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["https_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["no_proxy"] = ".lanl.gov"
```

Related Julia Packages
----------------------

* [TensorDecompositions:
Unsupervised Machine Learning based on Matrix/Tensor Factorization](https://github.com/TensorDecompositions)
* [RegAE: Regularization with a variational autoencoder for inverse analysis](https://github.com/madsjulia/RegAE.jl)
* [Geostatistical Inversion with randomized + sketching optimization](https://github.com/madsjulia/GeostatInversion.jl)

Publications, Presentations, Projects
--------------------------

* [mads.gitlab.io](http://mads.gitlab.io)
* [madsjulia.github.io](http://madsjulia.github.io)
* [TensorDecompositions](https://tensordecompositions.github.io)
* [TensorDecompositions](https://tensors.lanl.gov)
* [monty.gitlab.io](http://monty.gitlab.io)
* [ees.lanl.gov/monty](https://www.lanl.gov/orgs/ees/staff/monty)

