import Lexicon

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

For additional information:

*  web:   `http://mads.lanl.gov` -:- `http://madsjulia.lanl.gov` -:- `http://madsjulia.github.io/Mads.jl`
*  repo:  `http://gitlab.com/mads/Mads.jl` -:- `http://gitlab.com/madsjulia/Mads.jl`
*  git:   `git clone git@gitlab.com:mads/Mads.jl` -:- `git clone git@gitlab.com:madsjulia/Mads.jl`
*  email: `mads@lanl.gov`

MADS Getting started
--------------------

Install Julia and MADS using the installation instruction in the `README.md`.
If you are not familiar with Julia an on-line class is recommended.
You can also explore the examples in the `examples/learn_julia` directory of the `Mads.jl` repository.

To start using Mads, initiate the Julia REPL and execute `import Mads` to load MADS.
All the MADS analyses are based on a MADS data dictionary that defines the problem.
The MADS data dictionary is typically loaded from a YAML MADS input file.
The loading of a MADS file can be executed as follows:

`madsdata = Mads.loadmadsfile("<input_file_name>.mads")`

For example, you can execute:

`madsdata = Mads.loadmadsfile(Mads.madsdir * "/../examples/getting_started/internal-linear.mads")`

The file `internal-linear.mads` is located in `examples/getting_started` directory of the `Mads` repository.

Typically, the MADS data dictionary includes several classes:

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

The Julia file `internal-linearmodel.jl` is specified under `Model` in the MADS data dictionary.

Execute:

`Mads.showallparameters(madsdata)` to show all the parameters.

`Mads.showobservations(madsdata)` to list all the observations.

MADS can perform various types of analyses:

- `Mads.forward(madsdata)` will execute forward model simulation based on the initial parameter values.
- `saresults = Mads.efast(madsdata)` will perform eFAST sensitivity analysis of the model parameters against the model observations as defined in the MADS data dictionary.
- `optparam, iaresults = Mads.calibrate(madsdata)` will perform calibration (inverse analysis) of the model parameters to reproduce the model observations as defined in the MADS data dictionary; in this case, the calibration uses Levenberg-Marquardt optimization.
- `Mads.forward(madsdata, optparam) will perform forward model simulation based on the parameter values `optparam` estimated by the inverse analyses above.

More complicated analyses will require additional information to be provided in the MADS data dictionary.
Examples are given in the `examples` subdirectories of the `Mads.jl` repository.

All the available MADS functions are described at `http://madsjulia.github.io/Mads.jl`

MADS Licensing & Copyright
--------------------------

Execute `@doc Mads` or check the file `COPYING` to see the licensing & copyright information.
"""
function help()
	@doc Mads.help
end

"Create help files for Mads functions"
function create_help_func()
	config = Lexicon.Config()
	Lexicon.save(Mads.madsdir * "/../docs/mads.md", Mads, config; md_permalink = false)
	Lexicon.save(Mads.madsdir * "/../docs/mads.html", Mads)
	Lexicon.save(Mads.madsdir * "/../mkdocs/docs/index.md", Mads)
	# index = Lexicon.save(Mads.madsdir * "/../mkdocs/docs/mads.md", Mads)
	# Lexicon.save(Mads.madsdir * "/../mkdocs/docs/index.md", Lexicon.Index([index]); md_subheader = :category)
	d = pwd()
	cd(Mads.madsdir * "/../mkdocs")
	run(`mkdocs gh-deploy --clean`)
	cd(d)
	return
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
