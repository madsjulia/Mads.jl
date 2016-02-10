MADS (Model Analysis & Decision Support)
----------------------------------------

MADS is an open-source [Julia](http://julialang.org) code designed as an integrated high-performance computational framework performing a wide range of model-based analyses:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Averaging
* Decision Support

MADS utilizes adaptive rules and techniques which allows the analyses to be performed with minimum user input.
The code provides a series of alternative algorithms to perform each type of model analyses.

For additional information:

*  web:
    - [mads.lanl.gov](http://mads.lanl.gov)
    - [madsjulia.lanl.gov](http://madsjulia.lanl.gov) 
    - [madsjulia.github.io](`http://madsjulia.github.io/Mads.jl`)
*  repos:
    - [github](http://github.com/madsjulia/Mads.jl)
    - [gitlab](http://gitlab.com/mads/Mads.jl)
*  git:
    - `git clone git@github.com:madsjulia/Mads.jl`
*   - `git clone git@gitlab.com:mads/Mads.jl`
   email: [mads@lanl.gov](mads@lanl.gov)

MADS Getting Started
--------------------

Install [Julia](http://julialang.org) and [MADS](http://github.com/madsjulia/Mads.jl) (`Pkg.add("Mads")`) using the installation instruction in the `README.md` ([see also](https://github.com/madsjulia/Mads.jl)).
If you are not familiar with Julia, checkout [Julia By Example](http://samuelcolvin.github.io/JuliaByExample/), [learn X in Y minutes](https://learnxinyminutes.com/docs/julia/), [Julia Express](http://bogumilkaminski.pl/files/julia_express.pdf)).
You can also explore the Julia examples in the `examples/learn_julia` directory of the `Mads.jl` repository ([github](https://github.com/madsjulia/Mads.jl/tree/master/examples/learn_julia)).

To start using MADS, initiate the Julia REPL and execute `import Mads` to load MADS modules.

All the MADS analyses are based on a MADS problem dictionary that defines the problem.

The MADS problem dictionary is typically loaded from a YAML MADS input file.
The loading of a MADS file can be executed as follows:

`madsdata = Mads.loadmadsfile("<input_file_name>.mads")`

For example, you can execute:

`madsdata = Mads.loadmadsfile(Mads.madsdir * "/../examples/getting_started/internal-linear.mads")`

The file `internal-linear.mads` is located in `examples/getting_started` directory of the `Mads.jl` repository.

Typically, the MADS problem dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations
- `Model` : defines a model to predict the model observations using the model parameters

The file `internal-linear.mads` looks like this:

```
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

In this case, there are two parameters, `a` and `b`, defining a linear model, `f(t) = a * t + b`, described in `internal-linearmodel.jl`.

The Julia file `internal-linearmodel.jl` is specified under `Model` in the MADS problem dictionary above.

Execute:

`Mads.showallparameters(madsdata)` to show all the parameters.

`Mads.showobservations(madsdata)` to list all the observations.

MADS can perform various types of analyses:

- `Mads.forward(madsdata)` will execute forward model simulation based on the initial parameter values.
- `saresults = Mads.efast(madsdata)` will perform eFAST sensitivity analysis of the model parameters against the model observations as defined in the MADS problem dictionary.
- `optparam, iaresults = Mads.calibrate(madsdata)` will perform calibration (inverse analysis) of the model parameters to reproduce the model observations as defined in the MADS problem dictionary; in this case, the calibration uses Levenberg-Marquardt optimization.
- `Mads.forward(madsdata, optparam) will perform forward model simulation based on the parameter values `optparam` estimated by the inverse analyses above.

More complicated analyses will require additional information to be provided in the MADS problem dictionary.
Examples are given in the `examples` subdirectories of the `Mads.jl` repository ([github](https://github.com/madsjulia/Mads.jl/tree/master/examples)).

MADS Command-line execution
---------------------------

MADS can be executed at the command line using `madsjl.jl`. Link this file in a directory in your search `PATH`.

For example, using `madsjl.jl` you can execute:

```
madsjl.jl diff internal-linear.mads internal-parabola.mads
madsjl.jl internal-parabola.mads forward efast
```

in the `examples/getting_started` subdirectory of the `Mads.jl` repository ([github](https://github.com/madsjulia/Mads.jl/tree/master/examples/getting_started)).

MADS Documentation
------------------

All the available MADS modules and functions are described at [madsjulia.github.io](http://madsjulia.github.io/Mads.jl)

MADS Licensing & Copyright
--------------------------

Execute `@doc Mads` or check the file `COPYING` to see the licensing & copyright information.
