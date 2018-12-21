MADS (Model Analysis & Decision Support)
=======================================

![logo](logo/mads_black_swan_logo_big_text_new_3inch.png)

[![julialang](http://pkg.julialang.org/badges/Mads_0.5.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.5)
[![julialang](http://pkg.julialang.org/badges/Mads_0.6.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.6)
[![julialang](http://pkg.julialang.org/badges/Mads_0.7.svg)](http://pkg.julialang.org/?pkg=Mads&ver=0.7)

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
* Machine Learning and Blind Source Separation
* Decision Analysis and Support

MADS has been tested to perform HPC simulations on a wide-range multi-processor clusters and parallel environments (Moab, Slurm, etc.).
MADS utilizes adaptive rules and techniques which allows the analyses to be performed with a minimum user input.
The code provides a series of alternative algorithms to execute each type of data- and model-based analyses.

Example
------
```julia
import Mads

include(Mads.madsdir * "/../examples/contamination/contamination.jl")
include(Mads.madsdir * "/../examples/bigdt/bigdt.jl")
```

Documentation
=============

All the available MADS modules and functions are described at [madsjulia.github.io](http://madsjulia.github.io/Mads.jl)

Installation
============

After starting Julia, execute:

```julia
import Pkg; Pkg.add("Mads")
```

Installation of MADS behind a firewall
------------------------------

Julia uses git for package management.
Add in the `.gitconfig` file in your home directory to support git behind a firewall:

```
[url "https://"]
        insteadOf = git://
```

or execute:

```
git config --global url."https://".insteadOf git://
```

Set proxies executing the following lines in the bash command-line environment:

```
export ftp_proxy=http://proxyout.<your_site>:8080
export rsync_proxy=http://proxyout.<your_site>:8080
export http_proxy=http://proxyout.<your_site>:8080
export https_proxy=http://proxyout.<your_site>:8080
export no_proxy=.<your_site>
```

For example, at LANL, you will need to execute the following lines in the bash command-line environment:

```
export ftp_proxy=http://proxyout.lanl.gov:8080
export rsync_proxy=http://proxyout.lanl.gov:8080
export http_proxy=http://proxyout.lanl.gov:8080
export https_proxy=http://proxyout.lanl.gov:8080
export no_proxy=.lanl.gov
```

MADS examples
=============

In Julia REPL, do the following commands:

```julia
import Mads
```

To explore getting-started instructions, execute:

```julia
Mads.help()
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

Publications, Presentations, Projects
=====================================

* [mads.gitlab.io](mads.gitlab.io)
* [monty.gitlab.io](monty.gitlab.io)

