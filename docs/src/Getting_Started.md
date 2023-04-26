# Getting Started

Install [Julia](http://julialang.org) and [MADS](http://github.com/madsjulia/Mads.jl) (`import Pkg; Pkg.add("Mads")`).

You can also follow the installation instruction on [GitHub](https://github.com/madsjulia/Mads.jl)).

If you are not familiar with Julia, checkout:
- [Get Started with Julia](https://julialang.org/learning/)
- [Julia By Example](http://samuelcolvin.github.io/JuliaByExample/)
- [learn X in Y minutes](https://learnxinyminutes.com/docs/julia/)
- [Julia Express](http://bogumilkaminski.pl/files/julia_express.pdf)

You can also explore Julia examples provided in Mads: `examples/learn_julia` directory of the `Mads.jl` repository ([github](https://github.com/madsjulia/Mads.jl/tree/master/examples/learn_julia)).

To start using MADS, initiate the Julia REPL and execute `import Mads` to load MADS modules.

All the MADS analyses are based on a MADS problem dictionary that defines the problem.

The MADS problem dictionary is typically loaded from a YAML MADS input file.

The loading of a MADS file can be executed as follows:

```julia
madsdata = Mads.loadmadsfile("<input_file_name>.mads")
```

For example, you can execute:

```julia
madsdata = Mads.loadmadsfile(joinpath(Mads.dir, "examples", "getting_started", "internal-linear.mads"))
```

The file `internal-linear.mads` is located in `examples/getting_started` directory of the `Mads.jl` repository.

Typically, the MADS problem dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations
- `Model` : defines a model to predict the model observations using the model parameters

The file `internal-linear.mads` looks like this:

```yaml
Parameters:
- a : { init:  1, dist: "Uniform(-10, 10)" }
- b : { init: -1, dist: "Uniform(-10, 10)" }
Observations:
- o1: { target: -3 }
- o2: { target:  1 }
- o3: { target:  5 }
- o4: { target:  9 }
Model: internal-linear.jl
```

In this case, there are two parameters, `a` and `b`, defining a linear model, `f(t) = a * t + b`, described in `internal-linear.jl`.

The Julia file `internal-linear.jl` is specified under `Model` in the MADS problem dictionary above.

`internal-linear.jl` looks like this:

```julia
import OrderedCollections

function madsmodelrun(parameters::AbstractDict) # model run
	f(t) = parameters["a"] * t - parameters["b"] # a * t - b
	times = 1:4
	predictions = OrderedCollections.OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), map(f, times)))
	return predictions
end
```

The analyzed models can be not only Julia functions. They can be complex external numerical simulators. In this case, MADS provides various approaches for [Model Coupling](https://madsjulia.github.io/Mads.jl/dev/Model_Coupling.html).

Execute:

- List parameters and associated information:

```julia
Mads.showallparameters(madsdata)
```

- List observations  and associated information:

```julia
Mads.showobservations(madsdata)
```

- Execute forward model simulation based on the initial parameter values:

```julia
forward_results = Mads.forward(madsdata)
```

- Perform eFAST sensitivity analysis of the model parameters against the model observations:

```julia
efast_results = Mads.efast(madsdata)
```
- Perform calibration (inverse analysis) of the model parameters to reproduce the model observations using Levenberg-Marquardt optimization:

```julia
optparam, iaresults = Mads.calibrate(madsdata)
```

- Perform forward model simulation based on the parameter values `optparam` estimated by the inverse analyses above.

```julia
calibrated_results = Mads.forward(madsdata, optparam)
```

More complicated analyses may require additional information to be provided in the MADS problem dictionary.

Examples are given in the `examples` subdirectories of the `Mads.jl` repository [github](https://github.com/madsjulia/Mads.jl/tree/master/examples).
