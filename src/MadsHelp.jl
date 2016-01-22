"""
MADS (Model Analysis & Decision Support)
----------------------------------------

MADS is an open-source code designed as an integrated high-performance computational framework performing a wide range of model-based analyses:

* Sensitivity Analysis
* Parameter Estimation
* Model Inversion and Calibration
* Uncertainty Quantification
* Model Selection and Averaging
* Decision Support

MADS utilizes adaptive rules and techniques which allows the analyses to be performed with minimum user input.
The code provides a series of alternative algorithms to perform each type of model analyses.
The code allows for coupled model parameters and regularization terms that are internally computed based on user-defined mathematical expressions.

For additional information:

*  web:   http://mads.lanl.gov -:- http://madsjulia.lanl.gov
*  repo:  http://gitlab.com/mads/Mads.jl -:- http://gitlab.com/madsjulia/Mads.jl
*  git:   git clone git@gitlab.com:mads/Mads.jl -:- git clone git@gitlab.com:madsjulia/Mads.jl
*  email: mads@lanl.gov

MADS Getting started
--------------------

Install Julia and MADS using the installation instruction in the `Readme.md`.
If you are not familiar with Julia a short on-line class is recommended.
You can also explore the examples in the `Mads.jl/examples/learn_julia` directory of the Mads.jl repository.

To start using Mads, initiate the Julia REPL and execute `using Mads` to load MADS.
All the MADS analyses are based on a MADS data dictionary that defines the problem.
The MADS data dictionary is typically loaded from a YAML MADS input file.
The loading of a MADS file can be executed as follows:

`madsdata = Mads.loadmadsfile("<input_file_name>.mads")`

For example, you can execute:

`madsdata = Mads.loadmadsfile("internal-linear.mads")`

To run this command, Julia needs to be executed in the `Mads.jl/examples/getting_started` directory of the Mads.jl repository.

Typically, MADS data dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations
- `Model` : defines a model to predict model observations using model parameters

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

In this case there are two parameters, `a` and `b`, defining a linear model, `f(t) = a * t + b`, described in `internal-linearmodel.jl`.
This Julia file `internal-linearmodel.jl` is specified under `Model` in the MADS data dictionary.

`Mads.showallparameters(madsdata)` will show all the parameters.

`Mads.showobservations(madsdata)` will list all the observations.

MADS can perform various types of analyses:

- `Mads.forward(madsdata)` will execute forward model simulation based on the initial parameter values.
- `saresults = Mads.efast(madsdata)` will perform eFAST sensitivity analysis of the model parameters against the model observations as defined in the MADS data dictionary.
- `optparam, iaresults = Mads.calibrate(madsdata)` will perform calibration (inverse analysis) of the model parameters to reproduce the model observations as defined in the MADS data dictionary; in this case, the calibration uses Levenberg-Marquardt optimization.
- `Mads.forward(madsdata, optparam) will perform forward model simulation based on the parameter values `optparam` estimated by the inverse analyses above.

More complicated analyses will require additional information to be provided in the MADS data dictionary.
Examples are given in the `Mads.jl/examples` subdirectories of the Mads.jl repository

MADS Licensing & Copyright
--------------------------

Execute `@doc Mads` to see the licensing & copyright information.
"""
function help()
	@doc Mads.help
end

#=
#TODO IMPORTANT

MADS function documentation should include the following sections:
"""
Description:

Usage:

Arguments:

Returns:

Dumps:

Examples:

Details:

References:

See Also:
"""
=#
