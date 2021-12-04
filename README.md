# MADS (Model Analysis & Decision Support)

![logo](logo/mads_black_swan_logo_big_text_new_3inch.png)

[action-img]: https://github.com/madsjulia/Mads.jl/workflows/CI/badge.svg
[action-url]: https://github.com/madsjulia/Mads.jl/actions
[![coveralls.io](https://coveralls.io/repos/madsjulia/Mads.jl/badge.svg?branch=master)](https://coveralls.io/r/madsjulia/Mads.jl?branch=master)
[![codecov.io](http://codecov.io/github/madsjulia/Mads.jl/coverage.svg?branch=master)](http://codecov.io/github/madsjulia/Mads.jl?branch=master)

[MADS](http://madsjulia.github.io/Mads.jl) is an integrated high-performance computational framework for data/model/decision analyses.

[MADS](http://madsjulia.github.io/Mads.jl) can be applied to perform:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Model Averaging
* Model Reduction and Surrogate Modeling
* Machine Learning (e.g., Blind Source Separation, Source Identification, Feature Extraction, Matrix / Tensor Factorization, etc.)
* Decision Analysis and Support

[MADS](http://madsjulia.github.io/Mads.jl) has been tested and verified extensively.

[MADS](http://madsjulia.github.io/Mads.jl) can efficiently utilize available computational resources.

[MADS](http://madsjulia.github.io/Mads.jl) utilizes adaptive rules and techniques which allow the analyses to be performed efficiently with minimum user input.

[MADS](http://madsjulia.github.io/Mads.jl) provides a series of alternative algorithms to execute various types of data- and model-based analyses.

## Documentation

Detailed documentation including description of all MADS modules and functions is available at [GitHub](http://madsjulia.github.io/Mads.jl), [ReadtheDocs](https://mads.readthedocs.io) and [LANL](https://madsjulia.lanl.gov) sites.

See also [mads.gitlab.io](http://mads.gitlab.io) and [madsjulia.github.io](http://madsjulia.github.io/Mads.jl)

Detailed model diagnostics problem is demonstrated [here](https://github.com/madsjulia/Mads.jl/tree/master/notebooks/model_diagnostics)

## Installation

After starting Julia, execute in the REPL:

```julia
import Pkg; Pkg.add("Mads")
```

to access the latest released version.

To utilize the latest updates (commits) use:

```julia
import Pkg; Pkg.add(Pkg.PackageSpec(name="Mads", rev="master"))
```

## Docker

```bash
docker run --interactive --tty montyvesselinov/madsjulia
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

## Examples

To explore getting-started instructions, execute:

```julia
import Mads; Mads.help()
```

Various examples located in the `examples` directory of the `Mads` repository.

To run some of these example, execute

```julia
include(Mads.dir * "/../examples/contamination/contamination.jl")
```

to perform various example analyses related to groundwater contaminant transport, or execute

```julia
include(Mads.dir * "/../examples/bigdt/bigdt.jl")
```

to perform Bayesian Information Gap Decision Theory (BIG-DT) analysis.

## Installation behind a firewall

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

Proxies can be setup directly in the Julia REPL as well:

```julia
ENV["ftp_proxy"] =  "http://proxyout.lanl.gov:8080"
ENV["rsync_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["http_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["https_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["no_proxy"] = ".lanl.gov"
```

Julia uses git for package management.
In some cases, you may need to add in the `.gitconfig` file in your home directory the following lines to support git behind a firewall:

```
[url "git@github.com:"]
    insteadOf = https://github.com/
[url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/
[url "https://"]
    insteadOf = git://
[url "http://"]
    insteadOf = git://
```

or execute:

```bash
git config --global url."https://".insteadOf git://
git config --global url."http://".insteadOf git://
git config --global url."git@gitlab.com:".insteadOf https://gitlab.com/
git config --global url."git@github.com:".insteadOf https://github.com/
```

## Related Julia Packages

* [SmartTensors:
Unsupervised and Physics-Informed Machine Learning based on Matrix/Tensor Factorization](https://github.com/SmartTensors)
* [RegAE: Regularization with a variational autoencoder for inverse analysis](https://github.com/madsjulia/RegAE.jl)
* [Geostatistical Inversion with randomized + sketching optimization](https://github.com/madsjulia/GeostatInversion.jl)

## Publications, Presentations, Projects

* [mads.gitlab.io](http://mads.gitlab.io)
* [madsjulia.github.io](http://madsjulia.github.io)
* [SmartTensors](https://smarttensors.com)
* [SmartTensors](https://smarttensors.github.io)
* [SmartTensors](https://smarttensors.lanl.gov)
* [monty.gitlab.io](http://monty.gitlab.io)
* [ees.lanl.gov/monty](https://www.lanl.gov/orgs/ees/staff/monty)