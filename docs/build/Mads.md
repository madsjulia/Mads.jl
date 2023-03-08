
<a id='Mads.jl'></a>

<a id='Mads.jl-1'></a>

# Mads.jl


MADS (Model Analysis & Decision Support)


Mads.jl is MADS main module.


Mads.jl module functions:

<a id='Mads.MFlm-Union{Tuple{T}, Tuple{AbstractMatrix{T}, Integer}} where T<:Number' href='#Mads.MFlm-Union{Tuple{T}, Tuple{AbstractMatrix{T}, Integer}} where T<:Number'>#</a>
**`Mads.MFlm`** &mdash; *Method*.



Matrix Factorization using Levenberg Marquardt

Methods:

  * `Mads.MFlm(X::AbstractMatrix{T}, nk::Integer; method, log_W, log_H, retries, initW, initH, tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, quiet) where T<:Number` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:136
  * `Mads.MFlm(X::AbstractMatrix{T}, range::AbstractRange{Int64}; kw...) where T<:Number` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:103

Arguments:

  * `X::AbstractMatrix{T}` : matrix to factorize
  * `nk::Integer` : number of features to extract
  * `range::AbstractRange{Int64}`

Keywords:

  * `initH` : initial H (feature) matrix
  * `initW` : initial W (weight) matrix
  * `lambda`
  * `lambda_mu`
  * `log_H` : log-transform H (feature) matrix[default=`false`]
  * `log_W` : log-transform W (weight) matrix [default=`false`]
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `method`
  * `minOF`
  * `np_lambda`
  * `quiet`
  * `retries` : number of solution retries [default=`1`]
  * `show_trace`
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX`

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBlindSourceSeparation.jl#L114-L122' class='documenter-source'>source</a><br>

<a id='Mads.NMFipopt' href='#Mads.NMFipopt'>#</a>
**`Mads.NMFipopt`** &mdash; *Function*.



Non-negative Matrix Factorization using JuMP/Ipopt

Methods:

  * `Mads.NMFipopt(X::AbstractMatrix, nk::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:60
  * `Mads.NMFipopt(X::AbstractMatrix, nk::Integer, retries::Integer; random, maxiter, maxguess, initW, initH, verbosity, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:60

Arguments:

  * `X::AbstractMatrix` : matrix to factorize
  * `nk::Integer` : number of features to extract
  * `retries::Integer` : number of solution retries [default=`1`]

Keywords:

  * `initH` : initial H (feature) matrix
  * `initW` : initial W (weight) matrix
  * `maxguess` : guess about the maximum for the H (feature) matrix [default=`1`]
  * `maxiter` : maximum number of iterations [default=`100000`]
  * `quiet` : quiet [default=`false`]
  * `random` : random initial guesses [default=`false`]
  * `verbosity` : verbosity output level [default=`0`]

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBlindSourceSeparation.jl#L40-L48' class='documenter-source'>source</a><br>

<a id='Mads.NMFm' href='#Mads.NMFm'>#</a>
**`Mads.NMFm`** &mdash; *Function*.



Non-negative Matrix Factorization using NMF

Methods:

  * `Mads.NMFm(X::Array, nk::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:21
  * `Mads.NMFm(X::Array, nk::Integer, retries::Integer; tol, maxiter)` : C:\Users\monty.julia\dev\Mads\src\MadsBlindSourceSeparation.jl:21

Arguments:

  * `X::Array` : matrix to factorize
  * `nk::Integer` : number of features to extract
  * `retries::Integer` : number of solution retries [default=`1`]

Keywords:

  * `maxiter` : maximum number of iterations [default=`10000`]
  * `tol` : solution tolerance [default=`1.0e-9`]

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBlindSourceSeparation.jl#L7-L15' class='documenter-source'>source</a><br>

<a id='Mads.addkeyword!' href='#Mads.addkeyword!'>#</a>
**`Mads.addkeyword!`** &mdash; *Function*.



Add a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods:

  * `Mads.addkeyword!(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:314
  * `Mads.addkeyword!(madsdata::AbstractDict, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:310

Arguments:

  * `class::AbstractString` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::AbstractString` : dictionary key
  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L328-L332' class='documenter-source'>source</a><br>

<a id='Mads.addsource!' href='#Mads.addsource!'>#</a>
**`Mads.addsource!`** &mdash; *Function*.



Add an additional contamination source

Methods:

  * `Mads.addsource!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:18
  * `Mads.addsource!(madsdata::AbstractDict, sourceid::Int64; dict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:18

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `sourceid::Int64` : source id [default=`0`]

Keywords:

  * `dict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.addsourceparameters!-Tuple{AbstractDict}' href='#Mads.addsourceparameters!-Tuple{AbstractDict}'>#</a>
**`Mads.addsourceparameters!`** &mdash; *Method*.



Add contaminant source parameters

Methods:

  * `Mads.addsourceparameters!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:75

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L69-L73' class='documenter-source'>source</a><br>

<a id='Mads.allwellsoff!-Tuple{AbstractDict}' href='#Mads.allwellsoff!-Tuple{AbstractDict}'>#</a>
**`Mads.allwellsoff!`** &mdash; *Method*.



Turn off all the wells in the MADS problem dictionary

Methods:

  * `Mads.allwellsoff!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:618

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L612-L616' class='documenter-source'>source</a><br>

<a id='Mads.allwellson!-Tuple{AbstractDict}' href='#Mads.allwellson!-Tuple{AbstractDict}'>#</a>
**`Mads.allwellson!`** &mdash; *Method*.



Turn on all the wells in the MADS problem dictionary

Methods:

  * `Mads.allwellson!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:560

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L554-L558' class='documenter-source'>source</a><br>

<a id='Mads.amanzi' href='#Mads.amanzi'>#</a>
**`Mads.amanzi`** &mdash; *Function*.



Execute Amanzi external groundwater flow and transport simulator

Methods:

  * `Mads.amanzi(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsSimulators.jl:14
  * `Mads.amanzi(filename::AbstractString, nproc::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsSimulators.jl:14
  * `Mads.amanzi(filename::AbstractString, nproc::Int64, quiet::Bool)` : C:\Users\monty.julia\dev\Mads\src\MadsSimulators.jl:14
  * `Mads.amanzi(filename::AbstractString, nproc::Int64, quiet::Bool, observation_filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsSimulators.jl:14
  * `Mads.amanzi(filename::AbstractString, nproc::Int64, quiet::Bool, observation_filename::AbstractString, setup::AbstractString; amanzi_exe)` : C:\Users\monty.julia\dev\Mads\src\MadsSimulators.jl:14

Arguments:

  * `filename::AbstractString` : amanzi input file name
  * `nproc::Int64` : number of processor to be used by Amanzi [default=`Mads.nprocs_per_task_default`]
  * `observation_filename::AbstractString` : Amanzi observation file name [default=`"observations.out"`]
  * `quiet::Bool` : suppress output [default=`Mads.quiet`]
  * `setup::AbstractString` : bash script to setup Amanzi environmental variables [default=`"source-amanzi-setup"`]

Keywords:

  * `amanzi_exe` : full path to the Amanzi executable


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSimulators.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.amanzi_output_parser' href='#Mads.amanzi_output_parser'>#</a>
**`Mads.amanzi_output_parser`** &mdash; *Function*.



Parse Amanzi output provided in an external file (`filename`)

Methods:

  * `Mads.amanzi_output_parser()` : C:\Users\monty.julia\dev\Mads\src\MadsParsers.jl:21
  * `Mads.amanzi_output_parser(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParsers.jl:21

Arguments:

  * `filename::AbstractString` : external file name [default=`"observations.out"`]

Returns:

  * dictionary with model observations following MADS requirements

Example:

```julia
Mads.amanzi_output_parser()
Mads.amanzi_output_parser("observations.out")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParsers.jl#L4-L19' class='documenter-source'>source</a><br>

<a id='Mads.asinetransform' href='#Mads.asinetransform'>#</a>
**`Mads.asinetransform`** &mdash; *Function*.



Arcsine transformation of model parameters

Methods:

  * `Mads.asinetransform(madsdata::AbstractDict, params::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:3
  * `Mads.asinetransform(params::AbstractVector, lowerbounds::AbstractVector, upperbounds::AbstractVector, indexlogtransformed::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:13

Arguments:

  * `indexlogtransformed::AbstractVector` : index vector of log-transformed parameters
  * `lowerbounds::AbstractVector` : lower bounds
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `params::AbstractVector` : model parameters
  * `upperbounds::AbstractVector` : upper bounds

Returns:

  * Arcsine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSineTransformations.jl#L20-L28' class='documenter-source'>source</a><br>

<a id='Mads.bigdt-Tuple{AbstractDict, Int64}' href='#Mads.bigdt-Tuple{AbstractDict, Int64}'>#</a>
**`Mads.bigdt`** &mdash; *Method*.



Perform Bayesian Information Gap Decision Theory (BIG-DT) analysis

Methods:

  * `Mads.bigdt(madsdata::AbstractDict, nummodelruns::Int64; numhorizons, maxHorizon, numlikelihoods)` : C:\Users\monty.julia\dev\Mads\src\MadsBayesInfoGap.jl:122

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `nummodelruns::Int64` : number of model runs

Keywords:

  * `maxHorizon` : maximum info-gap horizons of uncertainty [default=`3`]
  * `numhorizons` : number of info-gap horizons of uncertainty [default=`100`]
  * `numlikelihoods` : number of Bayesian likelihoods [default=`25`]

Returns:

  * dictionary with BIG-DT results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBayesInfoGap.jl#L108-L116' class='documenter-source'>source</a><br>

<a id='Mads.boundparameters!' href='#Mads.boundparameters!'>#</a>
**`Mads.boundparameters!`** &mdash; *Function*.



Bound model parameters based on their ranges

Methods:

  * `Mads.boundparameters!(madsdata::AbstractDict, pardict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:818
  * `Mads.boundparameters!(madsdata::AbstractDict, parvec::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:806

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `pardict::AbstractDict` : Parameter dictionary
  * `parvec::AbstractVector` : Parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L835-L839' class='documenter-source'>source</a><br>

<a id='Mads.calibrate-Tuple{AbstractDict}' href='#Mads.calibrate-Tuple{AbstractDict}'>#</a>
**`Mads.calibrate`** &mdash; *Method*.



Calibrate Mads model using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Methods:

  * `Mads.calibrate(madsdata::AbstractDict; tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, save_results, localsa, parallel_optimization)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:196

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa` : perform local sensitivity analysis [default=`false`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `minOF` : objective function update tolerance [default=`1e-3`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `parallel_optimization`
  * `save_results` : save intermediate results [default=`true`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * model parameter dictionary with the optimal values at the minimum
  * optimization algorithm results (e.g. results.minimizer)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCalibrate.jl#L168-L179' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom' href='#Mads.calibraterandom'>#</a>
**`Mads.calibraterandom`** &mdash; *Function*.



Calibrate with random initial guesses

Methods:

  * `Mads.calibraterandom(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:44
  * `Mads.calibraterandom(madsdata::AbstractDict, numberofsamples::Integer; tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, seed, rng, quiet, all, save_results, first_init)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:44

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random initial samples [default=`1`]

Keywords:

  * `all` : all model results are returned [default=`false`]
  * `first_init`
  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `minOF`
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `quiet` : [default=`true`]
  * `rng`
  * `save_results` : save intermediate results [default=`true`]
  * `seed` : random seed [default=`0`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * model parameter dictionary with the optimal values at the minimum
  * optimization algorithm results (e.g. bestresult[2].minimizer)

Example:

```julia
Mads.calibraterandom(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCalibrate.jl#L8-L24' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom_parallel' href='#Mads.calibraterandom_parallel'>#</a>
**`Mads.calibraterandom_parallel`** &mdash; *Function*.



Calibrate with random initial guesses in parallel

Methods:

  * `Mads.calibraterandom_parallel(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:120
  * `Mads.calibraterandom_parallel(madsdata::AbstractDict, numberofsamples::Integer; tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, seed, rng, quiet, save_results, first_init, localsa, all_results)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:120

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random initial samples [default=`1`]

Keywords:

  * `all_results`
  * `first_init`
  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa` : perform local sensitivity analysis [default=`false`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `minOF`
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `quiet` : suppress output [default=`true`]
  * `rng`
  * `save_results` : save intermediate results [default=`true`]
  * `seed` : random seed [default=`0`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * vector with all objective function values
  * boolean vector (converged/not converged)
  * array with estimate model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCalibrate.jl#L90-L100' class='documenter-source'>source</a><br>

<a id='Mads.captureoff-Tuple{}' href='#Mads.captureoff-Tuple{}'>#</a>
**`Mads.captureoff`** &mdash; *Method*.



Make MADS not capture

Methods:

  * `Mads.captureoff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:148


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L143-L147' class='documenter-source'>source</a><br>

<a id='Mads.captureon-Tuple{}' href='#Mads.captureon-Tuple{}'>#</a>
**`Mads.captureon`** &mdash; *Method*.



Make MADS capture

Methods:

  * `Mads.captureon()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:139


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L134-L138' class='documenter-source'>source</a><br>

<a id='Mads.check_notebook-Tuple{AbstractString}' href='#Mads.check_notebook-Tuple{AbstractString}'>#</a>
**`Mads.check_notebook`** &mdash; *Method*.



Check is Jupyter notebook exists

Methods:

  * `Mads.check_notebook(rootname::AbstractString; dir, ndir)` : C:\Users\monty.julia\dev\Mads\src\MadsNotebooks.jl:97

Arguments:

  * `rootname::AbstractString` : notebook root name

Keywords:

  * `dir` : notebook directory
  * `ndir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsNotebooks.jl#L90-L94' class='documenter-source'>source</a><br>

<a id='Mads.checkmodeloutputdirs-Tuple{AbstractDict}' href='#Mads.checkmodeloutputdirs-Tuple{AbstractDict}'>#</a>
**`Mads.checkmodeloutputdirs`** &mdash; *Method*.



Check the directories where model outputs should be saved for MADS

Methods:

  * `Mads.checkmodeloutputdirs(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:673

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L663-L671' class='documenter-source'>source</a><br>

<a id='Mads.checknodedir' href='#Mads.checknodedir'>#</a>
**`Mads.checknodedir`** &mdash; *Function*.



Check if a directory is readable

Methods:

  * `Mads.checknodedir(dir::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:12
  * `Mads.checknodedir(dir::AbstractString, waittime::Float64)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:12
  * `Mads.checknodedir(node::AbstractString, dir::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:3
  * `Mads.checknodedir(node::AbstractString, dir::AbstractString, waittime::Float64)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:3

Arguments:

  * `dir::AbstractString` : directory
  * `node::AbstractString` : computational node name (e.g. `madsmax`, `wf03`, or `127.0.0.1`)
  * `waittime::Float64` : wait time in seconds [default=`10`]

Returns:

  * `true` if the directory is readable, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsExecute.jl#L28-L36' class='documenter-source'>source</a><br>

<a id='Mads.checkobservationranges-Tuple{AbstractDict}' href='#Mads.checkobservationranges-Tuple{AbstractDict}'>#</a>
**`Mads.checkobservationranges`** &mdash; *Method*.



Check parameter ranges for model parameters

Methods:

  * `Mads.checkobservationranges(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:811

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L805-L809' class='documenter-source'>source</a><br>

<a id='Mads.checkout' href='#Mads.checkout'>#</a>
**`Mads.checkout`** &mdash; *Function*.



Checkout (pull) the latest version of Mads modules

Methods:

  * `Mads.checkout()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:78
  * `Mads.checkout(modulename::AbstractString; git, master, force, pull, required, all)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:78

Arguments:

  * `modulename::AbstractString` : module name

Keywords:

  * `all` : whether to checkout all the modules [default=`false`]
  * `force` : whether to overwrite local changes when checkout [default=`false`]
  * `git` : whether to use "git checkout" [default=`true`]
  * `master` : whether on master branch [default=`false`]
  * `pull` : whether to run "git pull" [default=`true`]
  * `required` : whether only checkout Mads.required modules [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.checkparameterranges-Tuple{AbstractDict}' href='#Mads.checkparameterranges-Tuple{AbstractDict}'>#</a>
**`Mads.checkparameterranges`** &mdash; *Method*.



Check parameter ranges for model parameters

Methods:

  * `Mads.checkparameterranges(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:742

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L736-L740' class='documenter-source'>source</a><br>

<a id='Mads.cleancoverage-Tuple{}' href='#Mads.cleancoverage-Tuple{}'>#</a>
**`Mads.cleancoverage`** &mdash; *Method*.



Remove Mads coverage files

Methods:

  * `Mads.cleancoverage()` : C:\Users\monty.julia\dev\Mads\src\MadsTest.jl:22


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTest.jl#L17-L21' class='documenter-source'>source</a><br>

<a id='Mads.cmadsins_obs-Tuple{AbstractVector, AbstractString, AbstractString}' href='#Mads.cmadsins_obs-Tuple{AbstractVector, AbstractString, AbstractString}'>#</a>
**`Mads.cmadsins_obs`** &mdash; *Method*.



Call C MADS ins_obs() function from MADS dynamic library

Methods:

  * `Mads.cmadsins_obs(obsid::AbstractVector, instructionfilename::AbstractString, inputfilename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsCMads.jl:39

Arguments:

  * `inputfilename::AbstractString` : input file name
  * `instructionfilename::AbstractString` : instruction file name
  * `obsid::AbstractVector` : observation id

Return:

  * observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCMads.jl#L27-L35' class='documenter-source'>source</a><br>

<a id='Mads.commit' href='#Mads.commit'>#</a>
**`Mads.commit`** &mdash; *Function*.



Commit the latest version of Mads modules in the repository

Methods:

  * `Mads.commit(commitmsg::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:226
  * `Mads.commit(commitmsg::AbstractString, modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:226

Arguments:

  * `commitmsg::AbstractString` : commit message
  * `modulename::AbstractString` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L219-L223' class='documenter-source'>source</a><br>

<a id='Mads.computemass' href='#Mads.computemass'>#</a>
**`Mads.computemass`** &mdash; *Function*.



Compute injected/reduced contaminant mass (for a given set of mads input files when "path" is provided)

Methods:

  * `Mads.computemass(madsdata::AbstractDict; time)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:464
  * `Mads.computemass(madsfiles::Union{Regex, String}; time, path)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:491

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `madsfiles::Union{Regex, String}` : matching pattern for Mads input files (string or regular expression accepted)

Keywords:

  * `path` : search directory for the mads input files [default=`"."`]
  * `time` : computational time [default=`0`]

Returns:

  * array with all the lambda values
  * array with associated total injected mass
  * array with associated total reduced mass

Example:

```julia
Mads.computemass(madsfiles; time=0, path=".")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L512-L528' class='documenter-source'>source</a><br>

<a id='Mads.computeparametersensitities-Tuple{AbstractDict, AbstractDict}' href='#Mads.computeparametersensitities-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.computeparametersensitities`** &mdash; *Method*.



Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

Methods:

  * `Mads.computeparametersensitities(madsdata::AbstractDict, saresults::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:848

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `saresults::AbstractDict` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L841-L845' class='documenter-source'>source</a><br>

<a id='Mads.contamination-Tuple{Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, AbstractVector, Function}' href='#Mads.contamination-Tuple{Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, Number, AbstractVector, Function}'>#</a>
**`Mads.contamination`** &mdash; *Method*.



Compute concentration for a point in space and time (x,y,z,t)

Methods:

  * `Mads.contamination(wellx::Number, welly::Number, wellz::Number, n::Number, lambda::Number, theta::Number, vx::Number, vy::Number, vz::Number, ax::Number, ay::Number, az::Number, H::Number, x::Number, y::Number, z::Number, dx::Number, dy::Number, dz::Number, f::Number, t0::Number, t1::Number, t::AbstractVector, anasolfunction::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:434

Arguments:

  * `H::Number` : Hurst coefficient for Fractional Brownian dispersion
  * `anasolfunction::Function`
  * `ax::Number` : dispersivity in X direction (longitudinal)
  * `ay::Number` : dispersivity in Y direction (transverse horizontal)
  * `az::Number` : dispersivity in Y direction (transverse vertical)
  * `dx::Number` : source size (extent) in X direction
  * `dy::Number` : source size (extent) in Y direction
  * `dz::Number` : source size (extent) in Z direction
  * `f::Number` : source mass flux
  * `lambda::Number` : first-order reaction rate
  * `n::Number` : porosity
  * `t0::Number` : source starting time
  * `t1::Number` : source termination time
  * `t::AbstractVector` : vector of times to compute concentration at the observation point
  * `theta::Number` : groundwater flow direction
  * `vx::Number` : advective transport velocity in X direction
  * `vy::Number` : advective transport velocity in Y direction
  * `vz::Number` : advective transport velocity in Z direction
  * `wellx::Number` : observation point (well) X coordinate
  * `welly::Number` : observation point (well) Y coordinate
  * `wellz::Number` : observation point (well) Z coordinate
  * `x::Number` : X coordinate of contaminant source location
  * `y::Number` : Y coordinate of contaminant source location
  * `z::Number` : Z coordinate of contaminant source location

Returns:

  * a vector of predicted concentration at (wellx, welly, wellz, t)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L401-L409' class='documenter-source'>source</a><br>

<a id='Mads.copyaquifer2sourceparameters!-Tuple{AbstractDict}' href='#Mads.copyaquifer2sourceparameters!-Tuple{AbstractDict}'>#</a>
**`Mads.copyaquifer2sourceparameters!`** &mdash; *Method*.



Copy aquifer parameters to become contaminant source parameters

Methods:

  * `Mads.copyaquifer2sourceparameters!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:114

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L108-L112' class='documenter-source'>source</a><br>

<a id='Mads.copyright-Tuple{}' href='#Mads.copyright-Tuple{}'>#</a>
**`Mads.copyright`** &mdash; *Method*.



Produce MADS copyright information

Methods:

  * `Mads.copyright()` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:44


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelp.jl#L39-L43' class='documenter-source'>source</a><br>

<a id='Mads.create_documentation-Tuple{}' href='#Mads.create_documentation-Tuple{}'>#</a>
**`Mads.create_documentation`** &mdash; *Method*.



Create web documentation files for Mads functions

Methods:

  * `Mads.create_documentation()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:386


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L381-L385' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_off-Tuple{}' href='#Mads.create_tests_off-Tuple{}'>#</a>
**`Mads.create_tests_off`** &mdash; *Method*.



Turn off the generation of MADS tests (default)

Methods:

  * `Mads.create_tests_off()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:193


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L188-L192' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_on-Tuple{}' href='#Mads.create_tests_on-Tuple{}'>#</a>
**`Mads.create_tests_on`** &mdash; *Method*.



Turn on the generation of MADS tests (dangerous)

Methods:

  * `Mads.create_tests_on()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:184


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L179-L183' class='documenter-source'>source</a><br>

<a id='Mads.createobservations' href='#Mads.createobservations'>#</a>
**`Mads.createobservations`** &mdash; *Function*.



Create Mads dictionary of observations and instruction file

Methods:

  * `Mads.createobservations(nrow::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:26
  * `Mads.createobservations(nrow::Int64, ncol::Int64; obstring, pretext, prestring, poststring, filename)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:26
  * `Mads.createobservations(obs::AbstractMatrix; key, weight, time)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:81
  * `Mads.createobservations(obs::AbstractVector; key, weight, time, min, max, minorig, maxorig, dist, distribution)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:44

Arguments:

  * `ncol::Int64` : number of columns [default 1]
  * `nrow::Int64` : number of rows
  * `obs::AbstractMatrix`
  * `obs::AbstractVector`

Keywords:

  * `dist`
  * `distribution`
  * `filename` : file name
  * `key`
  * `max`
  * `maxorig`
  * `min`
  * `minorig`
  * `obstring` : observation string
  * `poststring` : post instruction file string
  * `prestring` : pre instruction file string
  * `pretext` : preamble instructions
  * `time`
  * `weight`

)

Returns:

  * observation dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCreate.jl#L98-L106' class='documenter-source'>source</a><br>

<a id='Mads.createobservations!' href='#Mads.createobservations!'>#</a>
**`Mads.createobservations!`** &mdash; *Function*.



Create observations in the MADS problem dictionary based on `time` and `observation` vectors

Methods:

  * `Mads.createobservations!(madsdata::AbstractDict, observation::AbstractDict; logtransform, weight_type, weight)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:499
  * `Mads.createobservations!(madsdata::AbstractDict, time::AbstractVector, observation::AbstractVector; logtransform, weight_type, weight)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:455
  * `Mads.createobservations!(md::AbstractDict, obs::AbstractVecOrMat; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:116

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `md::AbstractDict`
  * `obs::AbstractVecOrMat`
  * `observation::AbstractDict` : dictionary of observations
  * `observation::AbstractVector` : dictionary of observations
  * `time::AbstractVector` : vector of observation times

Keywords:

  * `logtransform` : log transform observations [default=`false`]
  * `weight` : weight value [default=`1`]
  * `weight_type` : weight type [default=`constant`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L519-L523' class='documenter-source'>source</a><br>

<a id='Mads.createproblem' href='#Mads.createproblem'>#</a>
**`Mads.createproblem`** &mdash; *Function*.



Create a new Mads problem where the observation targets are computed based on the model predictions

Methods:

  * `Mads.createproblem(in::Integer, out::Integer, f::Union{AbstractString, Function}; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:224
  * `Mads.createproblem(infilename::AbstractString, outfilename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:238
  * `Mads.createproblem(madsdata::AbstractDict, outfilename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:263
  * `Mads.createproblem(madsdata::AbstractDict, predictions::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:274
  * `Mads.createproblem(madsdata::AbstractDict, predictions::AbstractDict, outfilename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:269
  * `Mads.createproblem(param::AbstractVector, obs::AbstractVecOrMat, f::Union{AbstractString, Function, Symbol}; problemname, paramkey, paramname, paramplotname, paramtype, parammin, parammax, paramminorig, parammaxorig, paramdist, distribution, expressions, paramlog, obskey, obsweight, obstime, obsmin, obsmax, obsminorig, obsmaxorig, obsdist)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:228
  * `Mads.createproblem(paramfile::AbstractString, obsfile::AbstractString, f::Union{AbstractString, Function}; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:212

Arguments:

  * `f::Union{AbstractString, Function, Symbol}`
  * `f::Union{AbstractString, Function}`
  * `in::Integer`
  * `infilename::AbstractString` : input Mads file
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obs::AbstractVecOrMat`
  * `obsfile::AbstractString`
  * `out::Integer`
  * `outfilename::AbstractString` : output Mads file
  * `param::AbstractVector`
  * `paramfile::AbstractString`
  * `predictions::AbstractDict` : dictionary of model predictions

Keywords:

  * `distribution`
  * `expressions`
  * `obsdist`
  * `obskey`
  * `obsmax`
  * `obsmaxorig`
  * `obsmin`
  * `obsminorig`
  * `obstime`
  * `obsweight`
  * `paramdist`
  * `paramkey`
  * `paramlog`
  * `parammax`
  * `parammaxorig`
  * `parammin`
  * `paramminorig`
  * `paramname`
  * `paramplotname`
  * `paramtype`
  * `problemname`

Returns:

  * new MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCreate.jl#L291-L299' class='documenter-source'>source</a><br>

<a id='Mads.createtempdir-Tuple{AbstractString}' href='#Mads.createtempdir-Tuple{AbstractString}'>#</a>
**`Mads.createtempdir`** &mdash; *Method*.



Create temporary directory

Methods:

  * `Mads.createtempdir(tempdirname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1335

Arguments:

  * `tempdirname::AbstractString` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1329-L1333' class='documenter-source'>source</a><br>

<a id='Mads.deleteNaN!-Tuple{DataFrames.DataFrame}' href='#Mads.deleteNaN!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.deleteNaN!`** &mdash; *Method*.



Delete rows with NaN in a dataframe `df`

Methods:

  * `Mads.deleteNaN!(df::DataFrames.DataFrame)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:1074

Arguments:

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L1068-L1072' class='documenter-source'>source</a><br>

<a id='Mads.deletekeyword!' href='#Mads.deletekeyword!'>#</a>
**`Mads.deletekeyword!`** &mdash; *Function*.



Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods:

  * `Mads.deletekeyword!(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:343
  * `Mads.deletekeyword!(madsdata::AbstractDict, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:337

Arguments:

  * `class::AbstractString` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::AbstractString` : dictionary key
  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L356-L360' class='documenter-source'>source</a><br>

<a id='Mads.deleteoffwells!-Tuple{AbstractDict}' href='#Mads.deleteoffwells!-Tuple{AbstractDict}'>#</a>
**`Mads.deleteoffwells!`** &mdash; *Method*.



Delete all wells marked as being off in the MADS problem dictionary

Methods:

  * `Mads.welloff!(madsdata::AbstractDict, wellname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:632

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `wellname::AbstractString` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L647-L651' class='documenter-source'>source</a><br>

<a id='Mads.deletetimes!-Tuple{AbstractDict, Any}' href='#Mads.deletetimes!-Tuple{AbstractDict, Any}'>#</a>
**`Mads.deletetimes!`** &mdash; *Method*.



Delete all times in the MADS problem dictionary in a given list.

Methods:

  * `Mads.welloff!(madsdata::AbstractDict, wellname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:632

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `wellname::AbstractString` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L662-L666' class='documenter-source'>source</a><br>

<a id='Mads.dependents' href='#Mads.dependents'>#</a>
**`Mads.dependents`** &mdash; *Function*.



Lists module dependents on a module (Mads by default)

Methods:

  * `Mads.dependents()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:42
  * `Mads.dependents(modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:42
  * `Mads.dependents(modulename::AbstractString, filter::Bool)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:42

Arguments:

  * `filter::Bool` : whether to filter modules [default=`false`]
  * `modulename::AbstractString` : module name [default=`"Mads"`]

Returns:

  * modules that are dependents of the input module


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L31-L39' class='documenter-source'>source</a><br>

<a id='Mads.diff' href='#Mads.diff'>#</a>
**`Mads.diff`** &mdash; *Function*.



Diff the latest version of Mads modules in the repository

Methods:

  * `Mads.diff()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:169
  * `Mads.diff(modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:169

Arguments:

  * `modulename::AbstractString` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L163-L167' class='documenter-source'>source</a><br>

<a id='Mads.display' href='#Mads.display'>#</a>
**`Mads.display`** &mdash; *Function*.



Display image file

Methods:

  * `Mads.display(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsDisplay.jl:7
  * `Mads.display(filename::AbstractString, open::Bool)` : C:\Users\monty.julia\dev\Mads\src\MadsDisplay.jl:7
  * `Mads.display(o; gwo, gho, gw, gh)` : C:\Users\monty.julia\dev\Mads\src\MadsDisplay.jl:134
  * `Mads.display(p::Compose.Context; gwo, gho, gw, gh)` : C:\Users\monty.julia\dev\Mads\src\MadsDisplay.jl:101
  * `Mads.display(p::Gadfly.Plot; gwo, gho, gw, gh)` : C:\Users\monty.julia\dev\Mads\src\MadsDisplay.jl:68

Arguments:

  * `filename::AbstractString` : image file name
  * `o`
  * `open::Bool`
  * `p::Compose.Context` : plotting object
  * `p::Gadfly.Plot` : plotting object

Keywords:

  * `gh`
  * `gho`
  * `gw`
  * `gwo`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsDisplay.jl#L141-L145' class='documenter-source'>source</a><br>

<a id='Mads.dumpasciifile-Tuple{AbstractString, Any}' href='#Mads.dumpasciifile-Tuple{AbstractString, Any}'>#</a>
**`Mads.dumpasciifile`** &mdash; *Method*.



Dump ASCII file

Methods:

  * `Mads.dumpasciifile(filename::AbstractString, data)` : C:\Users\monty.julia\dev\Mads\src\MadsASCII.jl:30

Arguments:

  * `data` : data to dump
  * `filename::AbstractString` : ASCII file name

Dumps:

  * ASCII file with the name in "filename"


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsASCII.jl#L19-L27' class='documenter-source'>source</a><br>

<a id='Mads.dumpjsonfile-Tuple{AbstractString, Any}' href='#Mads.dumpjsonfile-Tuple{AbstractString, Any}'>#</a>
**`Mads.dumpjsonfile`** &mdash; *Method*.



Dump a JSON file

Methods:

  * `Mads.dumpjsonfile(filename::AbstractString, data)` : C:\Users\monty.julia\dev\Mads\src\MadsJSON.jl:38

Arguments:

  * `data` : data to dump
  * `filename::AbstractString` : JSON file name

Dumps:

  * JSON file with the name in "filename"


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsJSON.jl#L27-L35' class='documenter-source'>source</a><br>

<a id='Mads.dumpwelldata-Tuple{AbstractDict, AbstractString}' href='#Mads.dumpwelldata-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.dumpwelldata`** &mdash; *Method*.



Dump well data from MADS problem dictionary into a ASCII file

Methods:

  * `Mads.dumpwelldata(madsdata::AbstractDict, filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1201

Arguments:

  * `filename::AbstractString` : output file name
  * `madsdata::AbstractDict` : MADS problem dictionary

Dumps:

  * `filename` : a ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1190-L1198' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlfile-Tuple{AbstractString, Any}' href='#Mads.dumpyamlfile-Tuple{AbstractString, Any}'>#</a>
**`Mads.dumpyamlfile`** &mdash; *Method*.



Dump YAML file

Methods:

  * `Mads.dumpyamlfile(filename::AbstractString, data)` : C:\Users\monty.julia\dev\Mads\src\MadsYAML.jl:32

Arguments:

  * `data` : YAML data
  * `filename::AbstractString` : output file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsYAML.jl#L24-L28' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlmadsfile-Tuple{AbstractDict, AbstractString}' href='#Mads.dumpyamlmadsfile-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.dumpyamlmadsfile`** &mdash; *Method*.



Dump YAML Mads file

Methods:

  * `Mads.dumpyamlmadsfile(madsdata::AbstractDict, filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsYAML.jl:44

Arguments:

  * `filename::AbstractString` : output file name
  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsYAML.jl#L36-L40' class='documenter-source'>source</a><br>

<a id='Mads.efast-Tuple{AbstractDict}' href='#Mads.efast-Tuple{AbstractDict}'>#</a>
**`Mads.efast`** &mdash; *Method*.



Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

Methods:

  * `Mads.efast(md::AbstractDict; N, M, gamma, seed, checkpointfrequency, restartdir, restart, rng)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:1117

Arguments:

  * `md::AbstractDict` : MADS problem dictionary

Keywords:

  * `M` : maximum number of harmonics [default=`6`]
  * `N` : number of samples [default=`100`]
  * `checkpointfrequency` : check point frequency [default=`N`]
  * `gamma` : multiplication factor (Saltelli 1999 recommends gamma = 2 or 4) [default=`4`]
  * `restart` : save restart information [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for the efast simulation restarts [default=`"efastcheckpoints"`]
  * `rng`
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L1104-L1108' class='documenter-source'>source</a><br>

<a id='Mads.emceesampling' href='#Mads.emceesampling'>#</a>
**`Mads.emceesampling`** &mdash; *Function*.



Bayesian sampling with Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

Methods:

  * `Mads.emceesampling(madsdata::AbstractDict, p0::Array; numwalkers, nsteps, burnin, thinning, seed, weightfactor, rng, distributed_function)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:32
  * `Mads.emceesampling(madsdata::AbstractDict; numwalkers, sigma, seed, rng, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:9

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `p0::Array` : initial parameters (matrix of size (number of parameters, number of walkers) or (length(Mads.getoptparamkeys(madsdata)), numwalkers))

Keywords:

  * `burnin` : number of initial realizations before the MCMC are recorded [default=`10`]
  * `distributed_function`
  * `nsteps` : number of final realizations in the chain [default=`100`]
  * `numwalkers` : number of walkers (if in parallel this can be the number of available processors; in general, the higher the number of walkers, the better the results and computational time [default=`10`]
  * `rng`
  * `seed` : random seed [default=`0`]
  * `sigma` : a standard deviation parameter used to initialize the walkers [default=`0.01`]
  * `thinning` : removal of any `thinning` realization [default=`1`]
  * `weightfactor` : weight factor [default=`1.0`]

Returns:

  * MCMC chain
  * log likelihoods of the final samples in the chain

Examples:

```julia
Mads.emceesampling(madsdata; numwalkers=10, nsteps=100, burnin=100, thinning=1, seed=2016, sigma=0.01)
Mads.emceesampling(madsdata, p0; numwalkers=10, nsteps=100, burnin=10, thinning=1, seed=2016)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMonteCarlo.jl#L54-L70' class='documenter-source'>source</a><br>

<a id='Mads.estimationerror' href='#Mads.estimationerror'>#</a>
**`Mads.estimationerror`** &mdash; *Function*.



Estimate kriging error

Methods:

  * `Mads.estimationerror(w::AbstractVector, covmat::AbstractMatrix, covvec::AbstractVector, cov0::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:205
  * `Mads.estimationerror(w::AbstractVector, x0::AbstractVector, X::AbstractMatrix, covfn::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:198

Arguments:

  * `X::AbstractMatrix` : observation matrix
  * `cov0::Number` : zero-separation covariance
  * `covfn::Function`
  * `covmat::AbstractMatrix` : covariance matrix
  * `covvec::AbstractVector` : covariance vector
  * `w::AbstractVector` : kriging weights
  * `x0::AbstractVector` : estimated locations

Returns:

  * estimation kriging error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L209-L217' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpression-Tuple{AbstractString, AbstractDict}' href='#Mads.evaluatemadsexpression-Tuple{AbstractString, AbstractDict}'>#</a>
**`Mads.evaluatemadsexpression`** &mdash; *Method*.



Evaluate an expression string based on a parameter dictionary

Methods:

  * `Mads.evaluatemadsexpression(expressionstring::AbstractString, parameters::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:154

Arguments:

  * `expressionstring::AbstractString` : expression string
  * `parameters::AbstractDict` : parameter dictionary applied to evaluate the expression string

Returns:

  * dictionary containing the expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L143-L151' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpressions' href='#Mads.evaluatemadsexpressions'>#</a>
**`Mads.evaluatemadsexpressions`** &mdash; *Function*.



Evaluate all the expressions in the Mads problem dictiorany based on a parameter dictionary

Methods:

  * `Mads.evaluatemadsexpressions(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:173
  * `Mads.evaluatemadsexpressions(madsdata::AbstractDict, parameters::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:173

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameters::AbstractDict` : parameter dictionary applied to evaluate the expression strings

Returns:

  * dictionary containing the parameter and expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L162-L170' class='documenter-source'>source</a><br>

<a id='Mads.expcov-Tuple{Number, Number, Number}' href='#Mads.expcov-Tuple{Number, Number, Number}'>#</a>
**`Mads.expcov`** &mdash; *Method*.



Exponential spatial covariance function

Methods:

  * `Mads.expcov(h::Number, maxcov::Number, scale::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:31

Arguments:

  * `h::Number` : separation distance
  * `maxcov::Number` : maximum covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L19-L27' class='documenter-source'>source</a><br>

<a id='Mads.exponentialvariogram-NTuple{4, Number}' href='#Mads.exponentialvariogram-NTuple{4, Number}'>#</a>
**`Mads.exponentialvariogram`** &mdash; *Method*.



Exponential variogram

Methods:

  * `Mads.exponentialvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:83

Arguments:

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Exponential variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L70-L78' class='documenter-source'>source</a><br>

<a id='Mads.filterkeys' href='#Mads.filterkeys'>#</a>
**`Mads.filterkeys`** &mdash; *Function*.



Filter dictionary keys based on a string or regular expression

Methods:

  * `Mads.filterkeys(dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:865
  * `Mads.filterkeys(dict::AbstractDict, key::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:865
  * `Mads.filterkeys(dict::AbstractDict, key::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:864

Arguments:

  * `dict::AbstractDict` : dictionary
  * `key::AbstractString` : the regular expression or string used to filter dictionary keys
  * `key::Regex` : the regular expression or string used to filter dictionary keys


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L867-L871' class='documenter-source'>source</a><br>

<a id='Mads.forward' href='#Mads.forward'>#</a>
**`Mads.forward`** &mdash; *Function*.



Perform a forward run using the initial or provided values for the model parameters

Methods:

  * `Mads.forward(madsdata::AbstractDict, paramarray::AbstractArray; all, checkpointfrequency, checkpointfilename)` : C:\Users\monty.julia\dev\Mads\src\MadsForward.jl:46
  * `Mads.forward(madsdata::AbstractDict, paramdict::AbstractDict; all, checkpointfrequency, checkpointfilename)` : C:\Users\monty.julia\dev\Mads\src\MadsForward.jl:11
  * `Mads.forward(madsdata::AbstractDict; all)` : C:\Users\monty.julia\dev\Mads\src\MadsForward.jl:7

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramarray::AbstractArray` : array of model parameter values
  * `paramdict::AbstractDict` : dictionary of model parameter values

Keywords:

  * `all` : all model results are returned [default=`false`]
  * `checkpointfilename` : check point file name [default="checkpoint_forward"]
  * `checkpointfrequency` : check point frequency for storing restart information [default=`0`]

Returns:

  * dictionary of model predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsForward.jl#L118-L126' class='documenter-source'>source</a><br>

<a id='Mads.forwardgrid' href='#Mads.forwardgrid'>#</a>
**`Mads.forwardgrid`** &mdash; *Function*.



Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

Methods:

  * `Mads.forwardgrid(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsForward.jl:134
  * `Mads.forwardgrid(madsdatain::AbstractDict, paramvalues::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsForward.jl:139

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `madsdatain::AbstractDict` : MADS problem dictionary
  * `paramvalues::AbstractDict` : dictionary of model parameter values

Returns:

  * 3D array with model predictions along a 3D grid


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsForward.jl#L227-L235' class='documenter-source'>source</a><br>

<a id='Mads.free' href='#Mads.free'>#</a>
**`Mads.free`** &mdash; *Function*.



Free Mads modules

Methods:

  * `Mads.free()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:202
  * `Mads.free(modulename::AbstractString; required, all)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:202

Arguments:

  * `modulename::AbstractString` : module name

Keywords:

  * `all` : free all the modules [default=`false`]
  * `required` : only free Mads.required modules [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L194-L198' class='documenter-source'>source</a><br>

<a id='Mads.functions' href='#Mads.functions'>#</a>
**`Mads.functions`** &mdash; *Function*.



List available functions in the MADS modules:

Methods:

  * `Mads.functions()` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:57
  * `Mads.functions(m::Union{Module, Symbol})` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:96
  * `Mads.functions(m::Union{Module, Symbol}, re::Regex; shortoutput, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:66
  * `Mads.functions(m::Union{Module, Symbol}, string::AbstractString; shortoutput, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:96
  * `Mads.functions(re::Regex; shortoutput, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:48
  * `Mads.functions(string::AbstractString; shortoutput, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:57

Arguments:

  * `m::Union{Module, Symbol}` : MADS module
  * `re::Regex`
  * `string::AbstractString` : string to display functions with matching names

Keywords:

  * `quiet`
  * `shortoutput`

Examples:

```julia
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelp.jl#L131-L144' class='documenter-source'>source</a><br>

<a id='Mads.gaussiancov-Tuple{Number, Number, Number}' href='#Mads.gaussiancov-Tuple{Number, Number, Number}'>#</a>
**`Mads.gaussiancov`** &mdash; *Method*.



Gaussian spatial covariance function

Methods:

  * `Mads.gaussiancov(h::Number, maxcov::Number, scale::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:17

Arguments:

  * `h::Number` : separation distance
  * `maxcov::Number` : maximum covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.gaussianvariogram-NTuple{4, Number}' href='#Mads.gaussianvariogram-NTuple{4, Number}'>#</a>
**`Mads.gaussianvariogram`** &mdash; *Method*.



Gaussian variogram

Methods:

  * `Mads.gaussianvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:104

Arguments:

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Gaussian variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L91-L99' class='documenter-source'>source</a><br>

<a id='Mads.getcovmat-Tuple{AbstractMatrix, Function}' href='#Mads.getcovmat-Tuple{AbstractMatrix, Function}'>#</a>
**`Mads.getcovmat`** &mdash; *Method*.



Get spatial covariance matrix

Methods:

  * `Mads.getcovmat(X::AbstractMatrix, covfunction::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:160

Arguments:

  * `X::AbstractMatrix` : matrix with coordinates of the data points (x or y)
  * `covfunction::Function`

Returns:

  * spatial covariance matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L149-L157' class='documenter-source'>source</a><br>

<a id='Mads.getcovvec!-Tuple{AbstractVector, AbstractVector, AbstractMatrix, Function}' href='#Mads.getcovvec!-Tuple{AbstractVector, AbstractVector, AbstractMatrix, Function}'>#</a>
**`Mads.getcovvec!`** &mdash; *Method*.



Get spatial covariance vector

Methods:

  * `Mads.getcovvec!(covvec::AbstractVector, x0::AbstractVector, X::AbstractMatrix, covfn::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:186

Arguments:

  * `X::AbstractMatrix` : matrix with coordinates of the data points
  * `covfn::Function` : spatial covariance function
  * `covvec::AbstractVector` : spatial covariance vector
  * `x0::AbstractVector` : vector with coordinates of the estimation points (x or y)

Returns:

  * spatial covariance vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L173-L181' class='documenter-source'>source</a><br>

<a id='Mads.getdefaultplotformat-Tuple{}' href='#Mads.getdefaultplotformat-Tuple{}'>#</a>
**`Mads.getdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)

Methods:

  * `Mads.getdefaultplotformat()` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:32


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L27-L31' class='documenter-source'>source</a><br>

<a id='Mads.getdictvalues' href='#Mads.getdictvalues'>#</a>
**`Mads.getdictvalues`** &mdash; *Function*.



Get dictionary values for keys based on a string or regular expression

Methods:

  * `Mads.getdictvalues(dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:887
  * `Mads.getdictvalues(dict::AbstractDict, key::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:887
  * `Mads.getdictvalues(dict::AbstractDict, key::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:886

Arguments:

  * `dict::AbstractDict` : dictionary
  * `key::AbstractString` : the key to find value for
  * `key::Regex` : the key to find value for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L889-L893' class='documenter-source'>source</a><br>

<a id='Mads.getdir-Tuple{AbstractString}' href='#Mads.getdir-Tuple{AbstractString}'>#</a>
**`Mads.getdir`** &mdash; *Method*.



Get directory

Methods:

  * `Mads.getdir(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:477

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * directory in file name

Example:

```julia
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L460-L475' class='documenter-source'>source</a><br>

<a id='Mads.getdistribution-Tuple{AbstractString, AbstractString, AbstractString}' href='#Mads.getdistribution-Tuple{AbstractString, AbstractString, AbstractString}'>#</a>
**`Mads.getdistribution`** &mdash; *Method*.



Parse parameter distribution from a string

Methods:

  * `Mads.getdistribution(dist::AbstractString, i::AbstractString, inputtype::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:207

Arguments:

  * `dist::AbstractString` : parameter distribution
  * `i::AbstractString`
  * `inputtype::AbstractString` : input type (parameter or observation)

Returns:

  * distribution


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L195-L203' class='documenter-source'>source</a><br>

<a id='Mads.getextension-Tuple{AbstractString}' href='#Mads.getextension-Tuple{AbstractString}'>#</a>
**`Mads.getextension`** &mdash; *Method*.



Get file name extension

Methods:

  * `Mads.getextension(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:653

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * file name extension

Example:

```julia
ext = Mads.getextension("a.mads") # ext = "mads"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L637-L651' class='documenter-source'>source</a><br>

<a id='Mads.getfilenames-Tuple{AbstractString}' href='#Mads.getfilenames-Tuple{AbstractString}'>#</a>
**`Mads.getfilenames`** &mdash; *Method*.



Get file names by expanding wildcards

Methods:

  * `Mads.getfilenames(cmdstring::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:10

Arguments:

  * `cmdstring::AbstractString`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L5-L9' class='documenter-source'>source</a><br>

<a id='Mads.getimportantsamples-Tuple{Array, AbstractVector}' href='#Mads.getimportantsamples-Tuple{Array, AbstractVector}'>#</a>
**`Mads.getimportantsamples`** &mdash; *Method*.



Get important samples

Methods:

  * `Mads.getimportantsamples(samples::Array, llhoods::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:357

Arguments:

  * `llhoods::AbstractVector` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * array of important samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L346-L354' class='documenter-source'>source</a><br>

<a id='Mads.getlogparamkeys-Tuple{AbstractDict, AbstractVector}' href='#Mads.getlogparamkeys-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L535-L537' class='documenter-source'>source</a><br>

<a id='Mads.getmadsinputfile-Tuple{}' href='#Mads.getmadsinputfile-Tuple{}'>#</a>
**`Mads.getmadsinputfile`** &mdash; *Method*.



Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

Methods:

  * `Mads.getmadsinputfile()` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:429

Returns:

  * input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L420-L428' class='documenter-source'>source</a><br>

<a id='Mads.getmadsproblemdir-Tuple{AbstractDict}' href='#Mads.getmadsproblemdir-Tuple{AbstractDict}'>#</a>
**`Mads.getmadsproblemdir`** &mdash; *Method*.



Get the directory where the Mads data file is located

Methods:

  * `Mads.getmadsproblemdir(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:500

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Example:

```julia
madsdata = Mads.loadmadsfile("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L485-L498' class='documenter-source'>source</a><br>

<a id='Mads.getmadsrootname-Tuple{AbstractDict}' href='#Mads.getmadsrootname-Tuple{AbstractDict}'>#</a>
**`Mads.getmadsrootname`** &mdash; *Method*.



Get the MADS problem root name

Methods:

  * `Mads.getmadsrootname(madsdata::AbstractDict; first, version)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:451

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname [default=`false`]

Example:

```julia
madsrootname = Mads.getmadsrootname(madsdata)
```

Returns:

  * root of file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L433-L447' class='documenter-source'>source</a><br>

<a id='Mads.getnextmadsfilename-Tuple{AbstractString}' href='#Mads.getnextmadsfilename-Tuple{AbstractString}'>#</a>
**`Mads.getnextmadsfilename`** &mdash; *Method*.



Get next mads file name

Methods:

  * `Mads.getnextmadsfilename(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:616

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * next mads file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L606-L614' class='documenter-source'>source</a><br>

<a id='Mads.getnonlogparamkeys-Tuple{AbstractDict, AbstractVector}' href='#Mads.getnonlogparamkeys-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getnonlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L546-L548' class='documenter-source'>source</a><br>

<a id='Mads.getnonoptparamkeys-Tuple{AbstractDict, AbstractVector}' href='#Mads.getnonoptparamkeys-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getnonoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L546-L548' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{AbstractDict, Any}' href='#Mads.getobsdist-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{AbstractDict}' href='#Mads.getobsdist-Tuple{AbstractDict}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobskeys-Tuple{AbstractDict}' href='#Mads.getobskeys-Tuple{AbstractDict}'>#</a>
**`Mads.getobskeys`** &mdash; *Method*.



Get keys for all observations in the MADS problem dictionary

Methods:

  * `Mads.getobskeys(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:43

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * keys for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L33-L41' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{AbstractDict, Any}' href='#Mads.getobslog-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{AbstractDict}' href='#Mads.getobslog-Tuple{AbstractDict}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{AbstractDict, Any}' href='#Mads.getobsmax-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{AbstractDict}' href='#Mads.getobsmax-Tuple{AbstractDict}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{AbstractDict, Any}' href='#Mads.getobsmin-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{AbstractDict}' href='#Mads.getobsmin-Tuple{AbstractDict}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{AbstractDict, Any}' href='#Mads.getobstarget-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{AbstractDict}' href='#Mads.getobstarget-Tuple{AbstractDict}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{AbstractDict, Any}' href='#Mads.getobstime-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{AbstractDict}' href='#Mads.getobstime-Tuple{AbstractDict}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{AbstractDict, Any}' href='#Mads.getobsweight-Tuple{AbstractDict, Any}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L93-L95' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{AbstractDict}' href='#Mads.getobsweight-Tuple{AbstractDict}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L123-L125' class='documenter-source'>source</a><br>

<a id='Mads.getoptparamkeys-Tuple{AbstractDict, AbstractVector}' href='#Mads.getoptparamkeys-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L535-L537' class='documenter-source'>source</a><br>

<a id='Mads.getoptparams' href='#Mads.getoptparams'>#</a>
**`Mads.getoptparams`** &mdash; *Function*.



Get optimizable parameters

Methods:

  * `Mads.getoptparams(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:365
  * `Mads.getoptparams(madsdata::AbstractDict, parameterarray::Array)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:365
  * `Mads.getoptparams(madsdata::AbstractDict, parameterarray::Array, optparameterkey::Array)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:365

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `optparameterkey::Array` : optimizable parameter keys
  * `parameterarray::Array` : parameter array

Returns:

  * parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L394-L402' class='documenter-source'>source</a><br>

<a id='Mads.getparamdict-Tuple{AbstractDict}' href='#Mads.getparamdict-Tuple{AbstractDict}'>#</a>
**`Mads.getparamdict`** &mdash; *Method*.



Get dictionary with all parameters and their respective initial values

Methods:

  * `Mads.getparamdict(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:62

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * dictionary with all parameters and their respective initial values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L52-L60' class='documenter-source'>source</a><br>

<a id='Mads.getparamdistributions-Tuple{AbstractDict}' href='#Mads.getparamdistributions-Tuple{AbstractDict}'>#</a>
**`Mads.getparamdistributions`** &mdash; *Method*.



Get probabilistic distributions of all parameters in the MADS problem dictionary

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Methods:

  * `Mads.getparamdistributions(madsdata::AbstractDict; init_dist)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:697

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field [default=`false`]

Returns:

  * probabilistic distributions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L682-L694' class='documenter-source'>source</a><br>

<a id='Mads.getparamkeys-Tuple{AbstractDict}' href='#Mads.getparamkeys-Tuple{AbstractDict}'>#</a>
**`Mads.getparamkeys`** &mdash; *Method*.



Get keys of all parameters in the MADS problem dictionary

Methods:

  * `Mads.getparamkeys(madsdata::AbstractDict; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:43

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `filter` : parameter filter

Returns:

  * array with the keys of all parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.getparamrandom' href='#Mads.getparamrandom'>#</a>
**`Mads.getparamrandom`** &mdash; *Function*.



Get independent sampling of model parameters defined in the MADS problem dictionary

Methods:

  * `Mads.getparamrandom(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:393
  * `Mads.getparamrandom(madsdata::AbstractDict, numsamples::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:393
  * `Mads.getparamrandom(madsdata::AbstractDict, numsamples::Integer, parameterkey::AbstractString; init_dist)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:393
  * `Mads.getparamrandom(madsdata::AbstractDict, parameterkey::AbstractString; numsamples, paramdist, init_dist)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:410

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `numsamples::Integer` : number of samples,  [default=`1`]
  * `parameterkey::AbstractString` : model parameter key

Keywords:

  * `init_dist` : if `true` use the distribution set for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); if `false` (default) use the regular distribution set in the MADS problem dictionary (defined using `dist` parameter field)
  * `numsamples` : number of samples
  * `paramdist` : dictionary of parameter distributions

Returns:

  * generated sample


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L431-L439' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamsinit-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with init values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{AbstractDict}' href='#Mads.getparamsinit-Tuple{AbstractDict}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with init values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max' href='#Mads.getparamsinit_max'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Function*.



Get an array with `init_max` values for parameters defined by `paramkeys`

Methods:

  * `Mads.getparamsinit_max(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:276
  * `Mads.getparamsinit_max(madsdata::AbstractDict, paramkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:276

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramkeys::AbstractVector` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L265-L273' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min' href='#Mads.getparamsinit_min'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Function*.



Get an array with `init_min` values for parameters

Methods:

  * `Mads.getparamsinit_min(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:230
  * `Mads.getparamsinit_min(madsdata::AbstractDict, paramkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:230

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramkeys::AbstractVector` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L219-L227' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamslog-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with log values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{AbstractDict}' href='#Mads.getparamslog-Tuple{AbstractDict}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with log values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamslongname-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with longname values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{AbstractDict}' href='#Mads.getparamslongname-Tuple{AbstractDict}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with longname values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax' href='#Mads.getparamsmax'>#</a>
**`Mads.getparamsmax`** &mdash; *Function*.



Get an array with `max` values for parameters defined by `paramkeys`

Methods:

  * `Mads.getparamsmax(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:196
  * `Mads.getparamsmax(madsdata::AbstractDict, paramkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:196

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramkeys::AbstractVector` : parameter keys

Returns:

  * returns the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L185-L193' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin' href='#Mads.getparamsmin'>#</a>
**`Mads.getparamsmin`** &mdash; *Function*.



Get an array with `min` values for parameters defined by `paramkeys`

Methods:

  * `Mads.getparamsmin(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:162
  * `Mads.getparamsmin(madsdata::AbstractDict, paramkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:162

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramkeys::AbstractVector` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L151-L159' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamsplotname-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with plotname values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{AbstractDict}' href='#Mads.getparamsplotname-Tuple{AbstractDict}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with plotname values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamsstep-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with step values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{AbstractDict}' href='#Mads.getparamsstep-Tuple{AbstractDict}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with step values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{AbstractDict, AbstractVector}' href='#Mads.getparamstype-Tuple{AbstractDict, AbstractVector}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with type values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L108-L110' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{AbstractDict}' href='#Mads.getparamstype-Tuple{AbstractDict}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with type values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L129-L131' class='documenter-source'>source</a><br>

<a id='Mads.getproblemdir-Tuple{}' href='#Mads.getproblemdir-Tuple{}'>#</a>
**`Mads.getproblemdir`** &mdash; *Method*.



Get the directory where currently Mads is running

Methods:

  * `Mads.getproblemdir()` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:523

Example:

```julia
problemdir = Mads.getproblemdir()
```

Returns:

  * Mads problem directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L508-L522' class='documenter-source'>source</a><br>

<a id='Mads.getprocs-Tuple{}' href='#Mads.getprocs-Tuple{}'>#</a>
**`Mads.getprocs`** &mdash; *Method*.



Get the number of processors

Methods:

  * `Mads.getprocs()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:28


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L23-L27' class='documenter-source'>source</a><br>

<a id='Mads.getrestart-Tuple{AbstractDict}' href='#Mads.getrestart-Tuple{AbstractDict}'>#</a>
**`Mads.getrestart`** &mdash; *Method*.



Get MADS restart status

Methods:

  * `Mads.getrestart(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:94

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L88-L92' class='documenter-source'>source</a><br>

<a id='Mads.getrestartdir' href='#Mads.getrestartdir'>#</a>
**`Mads.getrestartdir`** &mdash; *Function*.



Get the directory where Mads restarts will be stored

Methods:

  * `Mads.getrestartdir(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:387
  * `Mads.getrestartdir(madsdata::AbstractDict, suffix::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:387

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `suffix::AbstractString` : Suffix to be added to the name of restart directory

Returns:

  * restart directory where reusable model results will be stored


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L376-L384' class='documenter-source'>source</a><br>

<a id='Mads.getrootname-Tuple{AbstractString}' href='#Mads.getrootname-Tuple{AbstractString}'>#</a>
**`Mads.getrootname`** &mdash; *Method*.



Get file name root

Methods:

  * `Mads.getrootname(filename::AbstractString; first, version)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:553

Arguments:

  * `filename::AbstractString` : file name

Keywords:

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname [default=`false`]

Returns:

  * root of file name

Example:

```julia
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L534-L549' class='documenter-source'>source</a><br>

<a id='Mads.getseed-Tuple{}' href='#Mads.getseed-Tuple{}'>#</a>
**`Mads.getseed`** &mdash; *Method*.



Get and return current random seed.

Methods:

  * `Mads.getseed()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:496


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L491-L495' class='documenter-source'>source</a><br>

<a id='Mads.getsindx-Tuple{AbstractDict}' href='#Mads.getsindx-Tuple{AbstractDict}'>#</a>
**`Mads.getsindx`** &mdash; *Method*.



Get sin-space dx

Methods:

  * `Mads.getsindx(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:375

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * sin-space dx value


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L365-L373' class='documenter-source'>source</a><br>

<a id='Mads.getsourcekeys-Tuple{AbstractDict}' href='#Mads.getsourcekeys-Tuple{AbstractDict}'>#</a>
**`Mads.getsourcekeys`** &mdash; *Method*.



Get keys of all source parameters in the MADS problem dictionary

Methods:

  * `Mads.getsourcekeys(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:80

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * array with keys of all source parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L70-L78' class='documenter-source'>source</a><br>

<a id='Mads.gettarget-Tuple{AbstractDict}' href='#Mads.gettarget-Tuple{AbstractDict}'>#</a>
**`Mads.gettarget`** &mdash; *Method*.



Get observation target

Methods:

  * `Mads.gettarget(o::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:221

Arguments:

  * `o::AbstractDict` : observation data

Returns:

  * observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L211-L219' class='documenter-source'>source</a><br>

<a id='Mads.gettargetkeys-Tuple{AbstractDict}' href='#Mads.gettargetkeys-Tuple{AbstractDict}'>#</a>
**`Mads.gettargetkeys`** &mdash; *Method*.



Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary

Methods:

  * `Mads.gettargetkeys(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:57

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * keys for all targets in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L47-L55' class='documenter-source'>source</a><br>

<a id='Mads.gettime-Tuple{AbstractDict}' href='#Mads.gettime-Tuple{AbstractDict}'>#</a>
**`Mads.gettime`** &mdash; *Method*.



Get observation time

Methods:

  * `Mads.gettime(o::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:144

Arguments:

  * `o::AbstractDict` : observation data

Returns:

  * observation time ("NaN" it time is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L134-L142' class='documenter-source'>source</a><br>

<a id='Mads.getweight-Tuple{AbstractDict}' href='#Mads.getweight-Tuple{AbstractDict}'>#</a>
**`Mads.getweight`** &mdash; *Method*.



Get observation weight

Methods:

  * `Mads.getweight(o::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:182

Arguments:

  * `o::AbstractDict` : observation data

Returns:

  * observation weight ("NaN" when weight is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L172-L180' class='documenter-source'>source</a><br>

<a id='Mads.getwelldata-Tuple{AbstractDict}' href='#Mads.getwelldata-Tuple{AbstractDict}'>#</a>
**`Mads.getwelldata`** &mdash; *Method*.



Get spatial and temporal data in the `Wells` class

Methods:

  * `Mads.getwelldata(madsdata::AbstractDict; time)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:727

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Keywords:

  * `time` : get observation times [default=`false`]

Returns:

  * array with spatial and temporal data in the `Wells` class


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L716-L724' class='documenter-source'>source</a><br>

<a id='Mads.getwellkeys-Tuple{AbstractDict}' href='#Mads.getwellkeys-Tuple{AbstractDict}'>#</a>
**`Mads.getwellkeys`** &mdash; *Method*.



Get keys for all wells in the MADS problem dictionary

Methods:

  * `Mads.getwellkeys(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:74

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * keys for all wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L64-L72' class='documenter-source'>source</a><br>

<a id='Mads.getwelltargets-Tuple{AbstractDict}' href='#Mads.getwelltargets-Tuple{AbstractDict}'>#</a>
**`Mads.getwelltargets`** &mdash; *Method*.



Methods:

  * `Mads.getwelltargets(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:761

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Returns:

  * array with targets in the `Wells` class


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L753-L758' class='documenter-source'>source</a><br>

<a id='Mads.graphoff-Tuple{}' href='#Mads.graphoff-Tuple{}'>#</a>
**`Mads.graphoff`** &mdash; *Method*.



MADS graph output off

Methods:

  * `Mads.graphoff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:166


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L161-L165' class='documenter-source'>source</a><br>

<a id='Mads.graphon-Tuple{}' href='#Mads.graphon-Tuple{}'>#</a>
**`Mads.graphon`** &mdash; *Method*.



MADS graph output on

Methods:

  * `Mads.graphon()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:157


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L152-L156' class='documenter-source'>source</a><br>

<a id='Mads.haskeyword' href='#Mads.haskeyword'>#</a>
**`Mads.haskeyword`** &mdash; *Function*.



Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods:

  * `Mads.haskeyword(madsdata::AbstractDict, class::AbstractString, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:275
  * `Mads.haskeyword(madsdata::AbstractDict, keyword::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:272

Arguments:

  * `class::AbstractString` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::AbstractString` : dictionary key
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns: `true` or `false`

Examples:

```julia
- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L292-L305' class='documenter-source'>source</a><br>

<a id='Mads.help-Tuple{}' href='#Mads.help-Tuple{}'>#</a>
**`Mads.help`** &mdash; *Method*.



Produce MADS help information

Methods:

  * `Mads.help()` : C:\Users\monty.julia\dev\Mads\src\MadsHelp.jl:35


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelp.jl#L30-L34' class='documenter-source'>source</a><br>

<a id='Mads.importeverywhere-Tuple{AbstractString}' href='#Mads.importeverywhere-Tuple{AbstractString}'>#</a>
**`Mads.importeverywhere`** &mdash; *Method*.



Import Julia function everywhere from a file. The first function in the Julia input file is the one that will be targeted by Mads for execution.

Methods:

  * `Mads.importeverywhere(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:439

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * Julia function to execute the model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L428-L437' class='documenter-source'>source</a><br>

<a id='Mads.indexkeys' href='#Mads.indexkeys'>#</a>
**`Mads.indexkeys`** &mdash; *Function*.



Find indexes for dictionary keys based on a string or regular expression

Methods:

  * `Mads.indexkeys(dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:876
  * `Mads.indexkeys(dict::AbstractDict, key::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:876
  * `Mads.indexkeys(dict::AbstractDict, key::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:875

Arguments:

  * `dict::AbstractDict` : dictionary
  * `key::AbstractString` : the key to find index for
  * `key::Regex` : the key to find index for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L878-L882' class='documenter-source'>source</a><br>

<a id='Mads.infogap_jump' href='#Mads.infogap_jump'>#</a>
**`Mads.infogap_jump`** &mdash; *Function*.



Information Gap Decision Analysis using JuMP

Methods:

  * `Mads.infogap_jump()` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:23
  * `Mads.infogap_jump(madsdata::AbstractDict; horizons, retries, random, maxiter, verbosity, seed)` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:23

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Keywords:

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsInfoGap.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.infogap_jump_polynomial' href='#Mads.infogap_jump_polynomial'>#</a>
**`Mads.infogap_jump_polynomial`** &mdash; *Function*.



Information Gap Decision Analysis using JuMP

Methods:

  * `Mads.infogap_jump_polynomial()` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:128
  * `Mads.infogap_jump_polynomial(madsdata::AbstractDict; horizons, retries, random, maxiter, verbosity, quiet, plot, model, seed)` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:128

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Keywords:

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `model` : model id [default=`1`]
  * `plot` : activate plotting [default=`false`]
  * `quiet` : quiet [default=`false`]
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]

Returns:

  * hmin, hmax


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsInfoGap.jl#L109-L117' class='documenter-source'>source</a><br>

<a id='Mads.infogap_moi_lin' href='#Mads.infogap_moi_lin'>#</a>
**`Mads.infogap_moi_lin`** &mdash; *Function*.



Information Gap Decision Analysis using MathOptInterface

Methods:

  * `Mads.infogap_moi_lin()` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:442
  * `Mads.infogap_moi_lin(madsdata::AbstractDict; horizons, retries, random, maxiter, verbosity, seed, pinit)` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:442

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Keywords:

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `pinit` : vector with initial parameters
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsInfoGap.jl#L429-L433' class='documenter-source'>source</a><br>

<a id='Mads.infogap_moi_polynomial' href='#Mads.infogap_moi_polynomial'>#</a>
**`Mads.infogap_moi_polynomial`** &mdash; *Function*.



Information Gap Decision Analysis using MathOptInterface

Methods:

  * `Mads.infogap_moi_polynomial()` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:301
  * `Mads.infogap_moi_polynomial(madsdata::AbstractDict; horizons, retries, random, maxiter, verbosity, seed, rng, pinit)` : C:\Users\monty.julia\dev\Mads\src\MadsInfoGap.jl:301

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Keywords:

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `pinit` : vector with initial parameters
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `rng`
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsInfoGap.jl#L288-L292' class='documenter-source'>source</a><br>

<a id='Mads.ins_obs-Tuple{AbstractString, AbstractString}' href='#Mads.ins_obs-Tuple{AbstractString, AbstractString}'>#</a>
**`Mads.ins_obs`** &mdash; *Method*.



Apply Mads instruction file `instructionfilename` to read model output file `modeloutputfilename`

Methods:

  * `Mads.ins_obs(instructionfilename::AbstractString, modeloutputfilename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1094

Arguments:

  * `instructionfilename::AbstractString` : instruction file name
  * `modeloutputfilename::AbstractString` : model output file name

Returns:

  * `obsdict` : observation dictionary with the model outputs


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1083-L1091' class='documenter-source'>source</a><br>

<a id='Mads.instline2regexs-Tuple{AbstractString}' href='#Mads.instline2regexs-Tuple{AbstractString}'>#</a>
**`Mads.instline2regexs`** &mdash; *Method*.



Convert an instruction line in the Mads instruction file into regular expressions

Methods:

  * `Mads.instline2regexs(instline::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:994

Arguments:

  * `instline::AbstractString` : instruction line

Returns:

  * `regexs` : regular expressions
  * `obsnames` : observation names
  * `getparamhere` : parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L982-L992' class='documenter-source'>source</a><br>

<a id='Mads.invobsweights!' href='#Mads.invobsweights!'>#</a>
**`Mads.invobsweights!`** &mdash; *Function*.



Set inversely proportional observation weights in the MADS problem dictionary

Methods:

  * `Mads.invobsweights!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:327
  * `Mads.invobsweights!(madsdata::AbstractDict, multiplier::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:327
  * `Mads.invobsweights!(madsdata::AbstractDict, multiplier::Number, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:327

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `multiplier::Number` : weight multiplier
  * `obskeys::AbstractVector`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L320-L324' class='documenter-source'>source</a><br>

<a id='Mads.invwellweights!' href='#Mads.invwellweights!'>#</a>
**`Mads.invwellweights!`** &mdash; *Function*.



Set inversely proportional well weights in the MADS problem dictionary

Methods:

  * `Mads.invwellweights!(madsdata::AbstractDict, multiplier::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:379
  * `Mads.invwellweights!(madsdata::AbstractDict, multiplier::Number, wellkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:379

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `multiplier::Number` : weight multiplier
  * `wellkeys::AbstractVector`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L372-L376' class='documenter-source'>source</a><br>

<a id='Mads.islog-Tuple{AbstractDict, AbstractString}' href='#Mads.islog-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.islog`** &mdash; *Method*.



Is parameter with key `parameterkey` log-transformed?

Methods:

  * `Mads.islog(madsdata::AbstractDict, parameterkey::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:438

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameterkey::AbstractString` : parameter key

Returns:

  * `true` if log-transformed, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L427-L435' class='documenter-source'>source</a><br>

<a id='Mads.isobs-Tuple{AbstractDict, AbstractDict}' href='#Mads.isobs-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.isobs`** &mdash; *Method*.



Is a dictionary containing all the observations

Methods:

  * `Mads.isobs(madsdata::AbstractDict, dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:17

Arguments:

  * `dict::AbstractDict` : dictionary
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * `true` if the dictionary contain all the observations, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L6-L14' class='documenter-source'>source</a><br>

<a id='Mads.isopt-Tuple{AbstractDict, AbstractString}' href='#Mads.isopt-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.isopt`** &mdash; *Method*.



Is parameter with key `parameterkey` optimizable?

Methods:

  * `Mads.isopt(madsdata::AbstractDict, parameterkey::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:418

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameterkey::AbstractString` : parameter key

Returns:

  * `true` if optimizable, `false` if not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L407-L415' class='documenter-source'>source</a><br>

<a id='Mads.isparam-Tuple{AbstractDict, AbstractDict}' href='#Mads.isparam-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.isparam`** &mdash; *Method*.



Check if a dictionary containing all the Mads model parameters

Methods:

  * `Mads.isparam(madsdata::AbstractDict, dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:16

Arguments:

  * `dict::AbstractDict` : dictionary
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * `true` if the dictionary containing all the parameters, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable-Tuple{AbstractString}' href='#Mads.ispkgavailable-Tuple{AbstractString}'>#</a>
**`Mads.ispkgavailable`** &mdash; *Method*.



Checks if package is available

Methods:

  * `Mads.ispkgavailable(modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:591

Arguments:

  * `modulename::AbstractString` : module name

Returns:

  * `true` or `false`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L581-L589' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable_old-Tuple{AbstractString}' href='#Mads.ispkgavailable_old-Tuple{AbstractString}'>#</a>
**`Mads.ispkgavailable_old`** &mdash; *Method*.



Checks if package is available

Methods:

  * `Mads.ispkgavailable_old(modulename::AbstractString; quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:569

Arguments:

  * `modulename::AbstractString` : module name

Keywords:

  * `quiet`

Returns:

  * `true` or `false`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L559-L567' class='documenter-source'>source</a><br>

<a id='Mads.krige-Tuple{AbstractMatrix, AbstractMatrix, AbstractVector, Function}' href='#Mads.krige-Tuple{AbstractMatrix, AbstractMatrix, AbstractVector, Function}'>#</a>
**`Mads.krige`** &mdash; *Method*.



Kriging

Methods:

  * `Mads.krige(x0mat::AbstractMatrix, X::AbstractMatrix, Z::AbstractVector, covfn::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:125

Arguments:

  * `X::AbstractMatrix` : coordinates of the observation (conditioning) data
  * `Z::AbstractVector` : values for the observation (conditioning) data
  * `covfn::Function` : spatial covariance function
  * `x0mat::AbstractMatrix` : point coordinates at which to obtain kriging estimates

Returns:

  * kriging estimates at `x0mat`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L112-L120' class='documenter-source'>source</a><br>

<a id='Mads.levenberg_marquardt' href='#Mads.levenberg_marquardt'>#</a>
**`Mads.levenberg_marquardt`** &mdash; *Function*.



Levenberg-Marquardt optimization

Methods:

  * `Mads.levenberg_marquardt(f::Function, g::Function, x0)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:357
  * `Mads.levenberg_marquardt(f::Function, g::Function, x0, o::Function; root, tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_scale, lambda_mu, lambda_nu, np_lambda, show_trace, callbackinitial, callbackiteration, callbackjacobian, callbackfinal, parallel_execution, center_provided)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:357

Arguments:

  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `o::Function` : objective function [default=`x->(x'*x)[1]`]
  * `x0` : initial parameter guess

Keywords:

  * `callbackfinal` : final call back function [default=`(best_x::AbstractVector, of::Number, lambda::Number)->nothing`]
  * `callbackinitial`
  * `callbackiteration` : call back function for each iteration [default=`(best_x::AbstractVector, of::Number, lambda::Number)->nothing`]
  * `callbackjacobian` : call back function for each Jacobian [default=`(x::AbstractVector, J::AbstractMatrix)->nothing`]
  * `center_provided`
  * `lambda` : initial Levenberg-Marquardt lambda [default=`eps(Float32)`]
  * `lambda_mu` : lambda multiplication factor μ [default=`10`]
  * `lambda_nu` : lambda multiplication factor ν [default=`2`]
  * `lambda_scale` : lambda scaling factor [default=`1e-3,`]
  * `maxEval` : maximum number of model evaluations [default=`1001`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `minOF` : objective function update tolerance [default=`1e-3`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `parallel_execution`
  * `root` : Mads problem root name
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX` : parameter space tolerance [default=`1e-4`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L330-L334' class='documenter-source'>source</a><br>

<a id='Mads.linktempdir-Tuple{AbstractString, AbstractString}' href='#Mads.linktempdir-Tuple{AbstractString, AbstractString}'>#</a>
**`Mads.linktempdir`** &mdash; *Method*.



Link files in a temporary directory

Methods:

  * `Mads.linktempdir(madsproblemdir::AbstractString, tempdirname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1361

Arguments:

  * `madsproblemdir::AbstractString` : Mads problem directory
  * `tempdirname::AbstractString` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1354-L1358' class='documenter-source'>source</a><br>

<a id='Mads.loadasciifile-Tuple{AbstractString}' href='#Mads.loadasciifile-Tuple{AbstractString}'>#</a>
**`Mads.loadasciifile`** &mdash; *Method*.



Load ASCII file

Methods:

  * `Mads.loadasciifile(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsASCII.jl:15

Arguments:

  * `filename::AbstractString` : ASCII file name

Returns:

  * data from the file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsASCII.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.loadbigyamlfile-Tuple{AbstractString}' href='#Mads.loadbigyamlfile-Tuple{AbstractString}'>#</a>
**`Mads.loadbigyamlfile`** &mdash; *Method*.



Load BIG YAML input file

Methods:

  * `Mads.loadmadsfile(filename::AbstractString; bigfile, format, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:48

Arguments:

  * `filename::AbstractString` : input file name (e.g. `input_file_name.mads`)

Keywords:

  * `bigfile`
  * `format`
  * `quiet`

Returns:

  * MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L96-L104' class='documenter-source'>source</a><br>

<a id='Mads.loadjsonfile-Tuple{AbstractString}' href='#Mads.loadjsonfile-Tuple{AbstractString}'>#</a>
**`Mads.loadjsonfile`** &mdash; *Method*.



Load a JSON file

Methods:

  * `Mads.loadjsonfile(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsJSON.jl:16

Arguments:

  * `filename::AbstractString` : JSON file name

Returns:

  * data from the JSON file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsJSON.jl#L6-L14' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsfile-Tuple{AbstractString}' href='#Mads.loadmadsfile-Tuple{AbstractString}'>#</a>
**`Mads.loadmadsfile`** &mdash; *Method*.



Load MADS input file defining a MADS problem dictionary

Methods:

  * `Mads.loadmadsfile(filename::AbstractString; bigfile, format, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:48

Arguments:

  * `filename::AbstractString` : input file name (e.g. `input_file_name.mads`)

Keywords:

  * `bigfile`
  * `format` : acceptable formats are `yaml` and `json` [default=`yaml`]
  * `quiet`

Returns:

  * MADS problem dictionary

Example:

```julia
md = Mads.loadmadsfile("input_file_name.mads")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L30-L44' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsproblem-Tuple{AbstractString}' href='#Mads.loadmadsproblem-Tuple{AbstractString}'>#</a>
**`Mads.loadmadsproblem`** &mdash; *Method*.



Load a predefined Mads problem

Methods:

  * `Mads.loadmadsproblem(name::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsCreate.jl:15

Arguments:

  * `name::AbstractString` : predefined MADS problem name

Returns:

  * MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCreate.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.loadsaltellirestart!-Tuple{Array, AbstractString, AbstractString}' href='#Mads.loadsaltellirestart!-Tuple{Array, AbstractString, AbstractString}'>#</a>
**`Mads.loadsaltellirestart!`** &mdash; *Method*.



Load Saltelli sensitivity analysis results for fast simulation restarts

Methods:

  * `Mads.loadsaltellirestart!(evalmat::Array, matname::AbstractString, restartdir::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:604

Arguments:

  * `evalmat::Array` : loaded array
  * `matname::AbstractString` : matrix (array) name (defines the name of the loaded file)
  * `restartdir::AbstractString` : directory where files will be stored containing model results for fast simulation restarts

Returns:

  * `true` when successfully loaded, `false` when it is not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L592-L600' class='documenter-source'>source</a><br>

<a id='Mads.loadyamlfile-Tuple{AbstractString}' href='#Mads.loadyamlfile-Tuple{AbstractString}'>#</a>
**`Mads.loadyamlfile`** &mdash; *Method*.



Load YAML file

Methods:

  * `Mads.loadyamlfile(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsYAML.jl:16

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * data in the yaml input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsYAML.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.localsa-Tuple{AbstractDict}' href='#Mads.localsa-Tuple{AbstractDict}'>#</a>
**`Mads.localsa`** &mdash; *Method*.



Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

Methods:

  * `Mads.localsa(madsdata::AbstractDict; sinspace, keyword, filename, format, datafiles, imagefiles, par, obs, J)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:124

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `J` : Jacobian matrix
  * `datafiles` : flag to write data files [default=`true`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `imagefiles` : flag to create image files [default=`Mads.graphoutput`]
  * `keyword` : keyword to be added in the filename root
  * `obs` : observations for the parameter set
  * `par` : parameter set
  * `sinspace` : apply sin transformation [default=`true`]

Dumps:

  * `filename` : output plot file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L105-L113' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_off-Tuple{}' href='#Mads.long_tests_off-Tuple{}'>#</a>
**`Mads.long_tests_off`** &mdash; *Method*.



Turn off execution of long MADS tests (default)

Methods:

  * `Mads.long_tests_off()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:211


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L206-L210' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_on-Tuple{}' href='#Mads.long_tests_on-Tuple{}'>#</a>
**`Mads.long_tests_on`** &mdash; *Method*.



Turn on execution of long MADS tests

Methods:

  * `Mads.long_tests_on()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:202


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L197-L201' class='documenter-source'>source</a><br>

<a id='Mads.madsMathOptInterface' href='#Mads.madsMathOptInterface'>#</a>
**`Mads.madsMathOptInterface`** &mdash; *Function*.



Define `MadsModel` type applied for Mads execution using `MathOptInterface`

Methods:

  * `Mads.madsMathOptInterface()` : C:\Users\monty.julia\dev\Mads\src\MadsMathOptInterface.jl:16
  * `Mads.madsMathOptInterface(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMathOptInterface.jl:16

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary [default=`Dict()`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMathOptInterface.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.madscores' href='#Mads.madscores'>#</a>
**`Mads.madscores`** &mdash; *Function*.



Check the number of processors on a series of servers

Methods:

  * `Mads.madscores()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:307
  * `Mads.madscores(nodenames::Vector{String})` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:307

Arguments:

  * `nodenames::Vector{String}` : array with names of machines/nodes [default=`madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L301-L305' class='documenter-source'>source</a><br>

<a id='Mads.madscritical-Tuple{AbstractString}' href='#Mads.madscritical-Tuple{AbstractString}'>#</a>
**`Mads.madscritical`** &mdash; *Method*.



MADS critical error messages

Methods:

  * `Mads.madscritical(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:72

Arguments:

  * `message::AbstractString` : critical error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.madsdebug' href='#Mads.madsdebug'>#</a>
**`Mads.madsdebug`** &mdash; *Function*.



MADS debug messages (controlled by `quiet` and `debuglevel`)

Methods:

  * `Mads.madsdebug(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:25
  * `Mads.madsdebug(message::AbstractString, level::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:25

Arguments:

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : debug message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L18-L22' class='documenter-source'>source</a><br>

<a id='Mads.madsdir-Tuple{}' href='#Mads.madsdir-Tuple{}'>#</a>
**`Mads.madsdir`** &mdash; *Method*.



Change the current directory to the Mads source dictionary

Methods:

  * `Mads.madsdir()` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:19


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L14-L18' class='documenter-source'>source</a><br>

<a id='Mads.madserror-Tuple{AbstractString}' href='#Mads.madserror-Tuple{AbstractString}'>#</a>
**`Mads.madserror`** &mdash; *Method*.



MADS error messages

Methods:

  * `Mads.madserror(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:62

Arguments:

  * `message::AbstractString` : error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L56-L60' class='documenter-source'>source</a><br>

<a id='Mads.madsinfo' href='#Mads.madsinfo'>#</a>
**`Mads.madsinfo`** &mdash; *Function*.



MADS information/status messages (controlled by quiet`and`verbositylevel`)

Methods:

  * `Mads.madsinfo(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:40
  * `Mads.madsinfo(message::AbstractString, level::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:40

Arguments:

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : information/status message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L33-L37' class='documenter-source'>source</a><br>

<a id='Mads.madsload' href='#Mads.madsload'>#</a>
**`Mads.madsload`** &mdash; *Function*.



Check the load of a series of servers

Methods:

  * `Mads.madsload()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:327
  * `Mads.madsload(nodenames::Vector{String})` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:327

Arguments:

  * `nodenames::Vector{String}` : array with names of machines/nodes [default=`madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L321-L325' class='documenter-source'>source</a><br>

<a id='Mads.madsoutput' href='#Mads.madsoutput'>#</a>
**`Mads.madsoutput`** &mdash; *Function*.



MADS output (controlled by `quiet` and `verbositylevel`)

Methods:

  * `Mads.madsoutput(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:10
  * `Mads.madsoutput(message::AbstractString, level::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:10

Arguments:

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : output message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.madsup' href='#Mads.madsup'>#</a>
**`Mads.madsup`** &mdash; *Function*.



Check the uptime of a series of servers

Methods:

  * `Mads.madsup()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:317
  * `Mads.madsup(nodenames::Vector{String})` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:317

Arguments:

  * `nodenames::Vector{String}` : array with names of machines/nodes [default=`madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L311-L315' class='documenter-source'>source</a><br>

<a id='Mads.madswarn-Tuple{AbstractString}' href='#Mads.madswarn-Tuple{AbstractString}'>#</a>
**`Mads.madswarn`** &mdash; *Method*.



MADS warning messages

Methods:

  * `Mads.madswarn(message::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsLog.jl:52

Arguments:

  * `message::AbstractString` : warning message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLog.jl#L46-L50' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{AbstractDict, Any}' href='#Mads.makearrayconditionalloglikelihood-Tuple{AbstractDict, Any}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make a conditional log likelihood function that accepts an array containing the optimal parameter values

Methods:

  * `Mads.makearrayconditionalloglikelihood(madsdata::AbstractDict, conditionalloglikelihood)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:104

Arguments:

  * `conditionalloglikelihood` : conditional log likelihood
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * a conditional log likelihood function that accepts an array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L93-L101' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{AbstractDict}' href='#Mads.makearrayconditionalloglikelihood-Tuple{AbstractDict}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make array of conditional log-likelihoods

Methods:

  * `Mads.makearrayconditionalloglikelihood(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsBayesInfoGap.jl:159
  * `Mads.makearrayconditionalloglikelihood(madsdata::AbstractDict, conditionalloglikelihood)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:104

Arguments:

  * `conditionalloglikelihood`
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * array of conditional log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBayesInfoGap.jl#L149-L157' class='documenter-source'>source</a><br>

<a id='Mads.makearrayfunction' href='#Mads.makearrayfunction'>#</a>
**`Mads.makearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameter values

Methods:

  * `Mads.makearrayfunction(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:31
  * `Mads.makearrayfunction(madsdata::AbstractDict, f::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:31

Arguments:

  * `f::Function` : function [default=`makemadscommandfunction(madsdata)`]
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * function accepting an array containing the optimal parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L36-L44' class='documenter-source'>source</a><br>

<a id='Mads.makearrayloglikelihood-Tuple{AbstractDict, Any}' href='#Mads.makearrayloglikelihood-Tuple{AbstractDict, Any}'>#</a>
**`Mads.makearrayloglikelihood`** &mdash; *Method*.



Make a log likelihood function that accepts an array containing the optimal parameter values

Methods:

  * `Mads.makearrayloglikelihood(madsdata::AbstractDict, loglikelihood)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:127

Arguments:

  * `loglikelihood` : log likelihood
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * a log likelihood function that accepts an array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L116-L124' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt!-Tuple{AbstractDict, AbstractDict}' href='#Mads.makebigdt!-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.makebigdt!`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Methods:

  * `Mads.makebigdt!(madsdata::AbstractDict, choice::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsBayesInfoGap.jl:34

Arguments:

  * `choice::AbstractDict` : dictionary of BIG-DT choices (scenarios)
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBayesInfoGap.jl#L23-L31' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt-Tuple{AbstractDict, AbstractDict}' href='#Mads.makebigdt-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.makebigdt`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Methods:

  * `Mads.makebigdt(madsdata::AbstractDict, choice::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsBayesInfoGap.jl:19

Arguments:

  * `choice::AbstractDict` : dictionary of BIG-DT choices (scenarios)
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBayesInfoGap.jl#L8-L16' class='documenter-source'>source</a><br>

<a id='Mads.makecomputeconcentrations-Tuple{AbstractDict}' href='#Mads.makecomputeconcentrations-Tuple{AbstractDict}'>#</a>
**`Mads.makecomputeconcentrations`** &mdash; *Method*.



Create a function to compute concentrations for all the observation points using Anasol

Methods:

  * `Mads.makecomputeconcentrations(madsdata::AbstractDict; calczeroweightobs, calcpredictions)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:178

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `calcpredictions` : calculate zero weight predictions [default=`true`]
  * `calczeroweightobs` : calculate zero weight observations[default=`false`]

Returns:

  * function to compute concentrations; the new function returns a dictionary of observations and model predicted concentrations

Examples:

```julia
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L157-L174' class='documenter-source'>source</a><br>

<a id='Mads.makedixonprice-Tuple{Integer}' href='#Mads.makedixonprice-Tuple{Integer}'>#</a>
**`Mads.makedixonprice`** &mdash; *Method*.



Make dixon price

Methods:

  * `Mads.makedixonprice(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:259

Arguments:

  * `n::Integer` : number of observations

Returns:

  * dixon price


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L249-L257' class='documenter-source'>source</a><br>

<a id='Mads.makedixonprice_gradient-Tuple{Integer}' href='#Mads.makedixonprice_gradient-Tuple{Integer}'>#</a>
**`Mads.makedixonprice_gradient`** &mdash; *Method*.



Methods:

  * `Mads.makedixonprice(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:259

Arguments:

  * `n::Integer` : number of observations

Returns:

  * dixon price gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L271-L276' class='documenter-source'>source</a><br>

<a id='Mads.makedoublearrayfunction' href='#Mads.makedoublearrayfunction'>#</a>
**`Mads.makedoublearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameter values, and returns an array of observations

Methods:

  * `Mads.makedoublearrayfunction(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:77
  * `Mads.makedoublearrayfunction(madsdata::AbstractDict, f::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsMisc.jl:77

Arguments:

  * `f::Function` : function [default=`makemadscommandfunction(madsdata)`]
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * function accepting an array containing the optimal parameter values, and returning an array of observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L81-L89' class='documenter-source'>source</a><br>

<a id='Mads.makelmfunctions' href='#Mads.makelmfunctions'>#</a>
**`Mads.makelmfunctions`** &mdash; *Function*.



Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization

Methods:

  * `Mads.makelmfunctions(f::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:107
  * `Mads.makelmfunctions(madsdata::AbstractDict; parallel_gradients)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:128

Arguments:

  * `f::Function` : Function
  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `parallel_gradients`

Returns:

  * forward model, gradient, objective functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L240-L248' class='documenter-source'>source</a><br>

<a id='Mads.makelocalsafunction-Tuple{AbstractDict}' href='#Mads.makelocalsafunction-Tuple{AbstractDict}'>#</a>
**`Mads.makelocalsafunction`** &mdash; *Method*.



Make gradient function needed for local sensitivity analysis

Methods:

  * `Mads.makelocalsafunction(madsdata::AbstractDict; multiplycenterbyweights)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:25

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `multiplycenterbyweights` : multiply center by observation weights [default=`true`]

Returns:

  * gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L14-L22' class='documenter-source'>source</a><br>

<a id='Mads.makelogprior-Tuple{AbstractDict}' href='#Mads.makelogprior-Tuple{AbstractDict}'>#</a>
**`Mads.makelogprior`** &mdash; *Method*.



Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`

Methods:

  * `Mads.makelogprior(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:467

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Return:

  * the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L457-L465' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunction-Tuple{AbstractDict}' href='#Mads.makemadscommandfunction-Tuple{AbstractDict}'>#</a>
**`Mads.makemadscommandfunction`** &mdash; *Method*.



Make MADS function to execute the model defined in the input MADS problem dictionary

Methods:

  * `Mads.makemadscommandfunction(madsdata_in::AbstractDict; obskeys, calczeroweightobs, calcpredictions)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:68

Arguments:

  * `madsdata_in::AbstractDict`

Keywords:

  * `calcpredictions` : Calculate predictions [default=`true`]
  * `calczeroweightobs` : Calculate zero weight observations [default=`false`]
  * `obskeys`

Example:

```julia
Mads.makemadscommandfunction(madsdata)
```

MADS can be coupled with any internal or external model. The model coupling is defined in the MADS problem dictionary. The expectations is that for a given set of model inputs, the model will produce a model output that will be provided to MADS. The fields in the MADS problem dictionary that can be used to define the model coupling are:

  * `Model` : execute a Julia function defined in an external input Julia file. The function that should accept a `parameter` dictionary with all the model parameters as an input argument and should return an `observation` dictionary with all the model predicted observations. MADS will execute the first function defined in the file.
  * `MADS model` : create a Julia function based on an external input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary. MADS will execute the first function defined in the file. This function should create a Julia function that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.
  * `Julia model` : execute an internal Julia function that accepts a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.
  * `Julia function` : execute an internal Julia function that accepts a `parameter` vector with all the model parameters as an input argument and will return an `observation` vector with all the model predicted observations.
  * `Command` : execute an external UNIX command or script that will execute an external model.
  * `Julia command` : execute a Julia script that will execute an external model. The Julia script is defined in an external Julia file. The input file should contain a function that accepts a `parameter` dictionary with all the model parameters as an input argument; MADS will execute the first function defined in the file. The Julia script should be capable to (1) execute the model (making a system call of an external model), (2) parse the model outputs, (3) return an `observation` dictionary with model predictions.

Both `Command` and `Julia command` can use different approaches to pass model parameters to the external model.

Only `Command` uses different approaches to get back the model outputs.

The script defined under `Julia command` parses the model outputs using Julia.

The available options for writing model inputs and reading model outputs are as follows.

Options for writing model inputs:

  * `Templates` : template files for writing model input files as defined at http://madsjulia.github.io
  * `ASCIIParameters` : model parameters written in a ASCII file
  * `JLDParameters` : model parameters written in a JLD file
  * `YAMLParameters` : model parameters written in a YAML file
  * `JSONParameters` : model parameters written in a JSON file

Options for reading model outputs:

  * `Instructions` : instruction files for reading model output files as defined at http://madsjulia.github.io
  * `ASCIIPredictions` : model predictions read from a ASCII file
  * `JLDPredictions` : model predictions read from a JLD file
  * `YAMLPredictions` : model predictions read from a YAML file
  * `JSONPredictions` : model predictions read from a JSON file

Returns:

  * Mads function to execute a forward model simulation


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L12-L64' class='documenter-source'>source</a><br>

<a id='Mads.makemadsconditionalloglikelihood-Tuple{AbstractDict}' href='#Mads.makemadsconditionalloglikelihood-Tuple{AbstractDict}'>#</a>
**`Mads.makemadsconditionalloglikelihood`** &mdash; *Method*.



Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations. Model parameters and observations are defined in the MADS problem dictionary `madsdata`.

Methods:

  * `Mads.makemadsconditionalloglikelihood(madsdata::AbstractDict; weightfactor)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:490

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `weightfactor` : Weight factor [default=`1`]

Return:

  * the conditional log-likelihood


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L478-L487' class='documenter-source'>source</a><br>

<a id='Mads.makemadsloglikelihood-Tuple{AbstractDict}' href='#Mads.makemadsloglikelihood-Tuple{AbstractDict}'>#</a>
**`Mads.makemadsloglikelihood`** &mdash; *Method*.



Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations. By default, the Log-likelihood function computed internally. The Log-likelihood can be constructed from an external Julia function defined the MADS problem dictionary under `LogLikelihood` or `ConditionalLogLikelihood`.

In the case of a `LogLikelihood` external Julia function, the first function in the file provided should be a function that takes as arguments:

  * dictionary of model parameters
  * dictionary of model predictions
  * dictionary of respective observations

In the case of a `ConditionalLogLikelihood` external Julia function, the first function in the file provided should be a function that takes as arguments:

  * dictionary of model predictions
  * dictionary of respective observations

Methods:

  * `Mads.makemadsloglikelihood(madsdata::AbstractDict; weightfactor)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:535

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `weightfactor` : Weight factor [default=`1`]

Returns:

  * the log-likelihood for a given set of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L513-L532' class='documenter-source'>source</a><br>

<a id='Mads.makemadsreusablefunction' href='#Mads.makemadsreusablefunction'>#</a>
**`Mads.makemadsreusablefunction`** &mdash; *Function*.



Make Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)

Methods:

  * `Mads.makemadsreusablefunction(madsdata::AbstractDict, madscommandfunction::Function)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:339
  * `Mads.makemadsreusablefunction(madsdata::AbstractDict, madscommandfunction::Function, suffix::AbstractString; usedict)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:339
  * `Mads.makemadsreusablefunction(paramkeys::AbstractVector, obskeys::AbstractVector, madsdatarestart::Union{Bool, String}, madscommandfunction::Function, restartdir::AbstractString; usedict)` : C:\Users\monty.julia\dev\Mads\src\MadsFunc.jl:342

Arguments:

  * `madscommandfunction::Function` : Mads function to execute a forward model simulation
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `madsdatarestart::Union{Bool, String}` : Restart type (memory/disk) or on/off status
  * `obskeys::AbstractVector` : Dictionary of observation keys
  * `paramkeys::AbstractVector` : Dictionary of parameter keys
  * `restartdir::AbstractString` : Restart directory where the reusable model results are stored
  * `suffix::AbstractString` : Suffix to be added to the name of restart directory

Keywords:

  * `usedict` : Use dictionary [default=`true`]

Returns:

  * Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsFunc.jl#L358-L366' class='documenter-source'>source</a><br>

<a id='Mads.makemoifunctions-Tuple{AbstractDict}' href='#Mads.makemoifunctions-Tuple{AbstractDict}'>#</a>
**`Mads.makemoifunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for MathOptInterface optimization

Methods:

  * `Mads.makemoifunctions(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMathOptInterface.jl:90

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * forward model, gradient, objective functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMathOptInterface.jl#L80-L88' class='documenter-source'>source</a><br>

<a id='Mads.makepowell-Tuple{Integer}' href='#Mads.makepowell-Tuple{Integer}'>#</a>
**`Mads.makepowell`** &mdash; *Method*.



Make Powell test function for LM optimization

Methods:

  * `Mads.makepowell(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:162

Arguments:

  * `n::Integer` : number of observations

Returns:

  * Powell test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L152-L160' class='documenter-source'>source</a><br>

<a id='Mads.makepowell_gradient-Tuple{Integer}' href='#Mads.makepowell_gradient-Tuple{Integer}'>#</a>
**`Mads.makepowell_gradient`** &mdash; *Method*.



ake parameter gradients of the Powell test function for LM optimization

Methods:

  * `Mads.makepowell_gradient(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:186

Arguments:

  * `n::Integer` : number of observations

Returns:

  * arameter gradients of the Powell test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L176-L184' class='documenter-source'>source</a><br>

<a id='Mads.makerosenbrock-Tuple{Integer}' href='#Mads.makerosenbrock-Tuple{Integer}'>#</a>
**`Mads.makerosenbrock`** &mdash; *Method*.



Make Rosenbrock test function for LM optimization

Methods:

  * `Mads.makerosenbrock(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:117

Arguments:

  * `n::Integer` : number of observations

Returns:

  * Rosenbrock test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L107-L115' class='documenter-source'>source</a><br>

<a id='Mads.makerosenbrock_gradient-Tuple{Integer}' href='#Mads.makerosenbrock_gradient-Tuple{Integer}'>#</a>
**`Mads.makerosenbrock_gradient`** &mdash; *Method*.



Make parameter gradients of the Rosenbrock test function for LM optimization

Methods:

  * `Mads.makerosenbrock_gradient(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:139

Arguments:

  * `n::Integer` : number of observations

Returns:

  * parameter gradients of the Rosenbrock test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L129-L137' class='documenter-source'>source</a><br>

<a id='Mads.makerotatedhyperellipsoid-Tuple{Integer}' href='#Mads.makerotatedhyperellipsoid-Tuple{Integer}'>#</a>
**`Mads.makerotatedhyperellipsoid`** &mdash; *Method*.



Methods:

  * `Mads.makerotatedhyperellipsoid(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:338

Arguments:

  * `n::Integer` : number of observations

Returns:

  * rotated hyperellipsoid


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L330-L335' class='documenter-source'>source</a><br>

<a id='Mads.makerotatedhyperellipsoid_gradient-Tuple{Integer}' href='#Mads.makerotatedhyperellipsoid_gradient-Tuple{Integer}'>#</a>
**`Mads.makerotatedhyperellipsoid_gradient`** &mdash; *Method*.



Methods:

  * `Mads.makerotatedhyperellipsoid_gradient(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:362

Arguments:

  * `n::Integer` : number of observations

Returns:

  * rotated hyperellipsoid gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L354-L359' class='documenter-source'>source</a><br>

<a id='Mads.makesphere-Tuple{Integer}' href='#Mads.makesphere-Tuple{Integer}'>#</a>
**`Mads.makesphere`** &mdash; *Method*.



Make sphere

Methods:

  * `Mads.makesphere(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:217

Arguments:

  * `n::Integer` : number of observations

Returns:

  * sphere


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L207-L215' class='documenter-source'>source</a><br>

<a id='Mads.makesphere_gradient-Tuple{Integer}' href='#Mads.makesphere_gradient-Tuple{Integer}'>#</a>
**`Mads.makesphere_gradient`** &mdash; *Method*.



Make sphere gradient

Methods:

  * `Mads.makesphere_gradient(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:238

Arguments:

  * `n::Integer` : number of observations

Returns:

  * sphere gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L228-L236' class='documenter-source'>source</a><br>

<a id='Mads.makesumsquares-Tuple{Integer}' href='#Mads.makesumsquares-Tuple{Integer}'>#</a>
**`Mads.makesumsquares`** &mdash; *Method*.



Methods:

  * `Mads.makesumsquares(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:300

Arguments:

  * `n::Integer` : number of observations

Returns:

  * sumsquares


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L292-L297' class='documenter-source'>source</a><br>

<a id='Mads.makesumsquares_gradient-Tuple{Integer}' href='#Mads.makesumsquares_gradient-Tuple{Integer}'>#</a>
**`Mads.makesumsquares_gradient`** &mdash; *Method*.



Methods:

  * `Mads.makesumsquares_gradient(n::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:319

Arguments:

  * `n::Integer` : number of observations

Returns:

  * sumsquares gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L311-L316' class='documenter-source'>source</a><br>

<a id='Mads.makesvrmodel' href='#Mads.makesvrmodel'>#</a>
**`Mads.makesvrmodel`** &mdash; *Function*.



Make SVR model functions (executor and cleaner)

Methods:

  * `Mads.makesvrmodel(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:205
  * `Mads.makesvrmodel(madsdata::AbstractDict, numberofsamples::Integer; check, addminmax, loadsvr, savesvr, svm_type, kernel_type, degree, gamma, coef0, C, nu, epsilon, cache_size, tol, shrinking, probability, verbose, seed)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:205

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `numberofsamples::Integer` : number of samples [default=`100`]

Keywords:

  * `C` : cost; penalty parameter of the error term [default=`1000.0`]
  * `addminmax` : add parameter minimum / maximum range values in the training set [default=`true`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `check` : check SVR performance [default=`false`]
  * `coef0` : independent term in kernel function; important only in POLY and SIGMOND kernel types [default=`0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `epsilon` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]
  * `gamma` : coefficient for RBF, POLY and SIGMOND kernel types [default=`1/numberofsamples`]
  * `kernel_type` : kernel type[default=`SVR.RBF`]
  * `loadsvr` : load SVR models [default=`false`]
  * `nu` : upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]
  * `probability` : train to estimate probabilities [default=`false`]
  * `savesvr` : save SVR models [default=`false`]
  * `seed` : random seed [default=`0`]
  * `shrinking` : apply shrinking heuristic [default=`true`]
  * `svm_type` : SVM type [default=`SVR.EPSILON_SVR`]
  * `tol` : tolerance of termination criterion [default=`0.001`]
  * `verbose` : verbose output [default=`false`]

Returns:

  * function performing SVR predictions
  * function loading existing SVR models
  * function saving SVR models
  * function removing SVR models from the memory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L173-L184' class='documenter-source'>source</a><br>

<a id='Mads.maxtofloatmax!-Tuple{DataFrames.DataFrame}' href='#Mads.maxtofloatmax!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.maxtofloatmax!`** &mdash; *Method*.



Scale down values larger than max(Float32) in a dataframe `df` so that Gadfly can plot the data

Methods:

  * `Mads.maxtofloatmax!(df::DataFrames.DataFrame)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:1091

Arguments:

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L1085-L1089' class='documenter-source'>source</a><br>

<a id='Mads.meshgrid' href='#Mads.meshgrid'>#</a>
**`Mads.meshgrid`** &mdash; *Function*.



Create mesh grid

Methods:

  * `Mads.meshgrid(nx::Number, ny::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:454
  * `Mads.meshgrid(x::AbstractVector, y::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:447

Arguments:

  * `nx::Number`
  * `ny::Number`
  * `x::AbstractVector` : vector of grid x coordinates
  * `y::AbstractVector` : vector of grid y coordinates

Returns:

  * 2D grid coordinates based on the coordinates contained in vectors `x` and `y`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L461-L469' class='documenter-source'>source</a><br>

<a id='Mads.minimize-Tuple{Function, AbstractVector}' href='#Mads.minimize-Tuple{Function, AbstractVector}'>#</a>
**`Mads.minimize`** &mdash; *Method*.



Minimize Julia function using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Methods:

  * `Mads.calibrate(madsdata::AbstractDict; tolX, tolG, tolOF, tolOFcount, minOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, save_results, localsa, parallel_optimization)` : C:\Users\monty.julia\dev\Mads\src\MadsCalibrate.jl:196

Arguments:

  * `madsdata::AbstractDict`

Keywords:

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa`
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `minOF` : objective function update tolerance [default=`1e-3`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `parallel_optimization`
  * `save_results`
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolOFcount` : number of Jacobian runs with small objective function change [default=`5`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive`

Returns:

  * vector with the optimal parameter values at the minimum
  * optimization algorithm results (e.g. results.minimizer)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMinimization.jl#L1-L12' class='documenter-source'>source</a><br>

<a id='Mads.mkdir-Tuple{AbstractString}' href='#Mads.mkdir-Tuple{AbstractString}'>#</a>
**`Mads.mkdir`** &mdash; *Method*.



Create a directory (if does not already exist)

Methods:

  * `Mads.mkdir(dirname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1388

Arguments:

  * `dirname::AbstractString` : directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1382-L1386' class='documenter-source'>source</a><br>

<a id='Mads.modelinformationcriteria' href='#Mads.modelinformationcriteria'>#</a>
**`Mads.modelinformationcriteria`** &mdash; *Function*.



Model section information criteria

Methods:

  * `Mads.modelinformationcriteria(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsModelSelection.jl:11
  * `Mads.modelinformationcriteria(madsdata::AbstractDict, par::Array{Float64})` : C:\Users\monty.julia\dev\Mads\src\MadsModelSelection.jl:11

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `par::Array{Float64}` : parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsModelSelection.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.modobsweights!' href='#Mads.modobsweights!'>#</a>
**`Mads.modobsweights!`** &mdash; *Function*.



Modify (multiply) observation weights in the MADS problem dictionary

Methods:

  * `Mads.modobsweights!(madsdata::AbstractDict, value::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:314
  * `Mads.modobsweights!(madsdata::AbstractDict, value::Number, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:314

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector`
  * `value::Number` : value for modifing observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L307-L311' class='documenter-source'>source</a><br>

<a id='Mads.modwellweights!' href='#Mads.modwellweights!'>#</a>
**`Mads.modwellweights!`** &mdash; *Function*.



Modify (multiply) well weights in the MADS problem dictionary

Methods:

  * `Mads.modwellweights!(madsdata::AbstractDict, value::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:361
  * `Mads.modwellweights!(madsdata::AbstractDict, value::Number, wellkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:361

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `value::Number` : value for well weights
  * `wellkeys::AbstractVector`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L354-L358' class='documenter-source'>source</a><br>

<a id='Mads.montecarlo-Tuple{AbstractDict}' href='#Mads.montecarlo-Tuple{AbstractDict}'>#</a>
**`Mads.montecarlo`** &mdash; *Method*.



Monte Carlo analysis

Methods:

  * `Mads.montecarlo(madsdata::AbstractDict; compute, N, filename)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:193

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `N` : number of samples [default=`100`]
  * `compute`
  * `filename` : file name to save Monte-Carlo results

Returns:

  * parameter dictionary containing the data arrays

Dumps:

  * YAML output file with the parameter dictionary containing the data arrays

Example:

```julia
Mads.montecarlo(madsdata; N=100)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMonteCarlo.jl#L171-L189' class='documenter-source'>source</a><br>

<a id='Mads.naive_get_deltax-Tuple{AbstractMatrix{Float64}, AbstractMatrix{Float64}, AbstractVector{Float64}, Number}' href='#Mads.naive_get_deltax-Tuple{AbstractMatrix{Float64}, AbstractMatrix{Float64}, AbstractVector{Float64}, Number}'>#</a>
**`Mads.naive_get_deltax`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: get the LM parameter space step

Methods:

  * `Mads.naive_get_deltax(JpJ::AbstractMatrix{Float64}, Jp::AbstractMatrix{Float64}, f0::AbstractVector{Float64}, lambda::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:264

Arguments:

  * `Jp::AbstractMatrix{Float64}` : Jacobian matrix times model parameters
  * `JpJ::AbstractMatrix{Float64}` : Jacobian matrix times model parameters times transposed Jacobian matrix
  * `f0::AbstractVector{Float64}` : initial model observations
  * `lambda::Number` : Levenberg-Marquardt lambda

Returns:

  * the LM parameter space step


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L251-L259' class='documenter-source'>source</a><br>

<a id='Mads.naive_levenberg_marquardt' href='#Mads.naive_levenberg_marquardt'>#</a>
**`Mads.naive_levenberg_marquardt`** &mdash; *Function*.



Naive Levenberg-Marquardt optimization

Methods:

  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::AbstractVector{Float64})` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:314
  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::AbstractVector{Float64}, o::Function; maxIter, maxEval, lambda, lambda_mu, np_lambda)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:314

Arguments:

  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `o::Function` : objective function [default=x->(x'*x)[1]]
  * `x0::AbstractVector{Float64}` : initial parameter guess

Keywords:

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100`]
  * `lambda_mu` : lambda multiplication factor μ [default=`10`]
  * `maxEval` : maximum number of model evaluations [default=`101`]
  * `maxIter` : maximum number of optimization iterations [default=`10`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L296-L304' class='documenter-source'>source</a><br>

<a id='Mads.naive_lm_iteration-Tuple{Function, Function, Function, AbstractVector{Float64}, AbstractVector{Float64}, AbstractVector{Float64}}' href='#Mads.naive_lm_iteration-Tuple{Function, Function, Function, AbstractVector{Float64}, AbstractVector{Float64}, AbstractVector{Float64}}'>#</a>
**`Mads.naive_lm_iteration`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: perform LM iteration

Methods:

  * `Mads.naive_lm_iteration(f::Function, g::Function, o::Function, x0::AbstractVector{Float64}, f0::AbstractVector{Float64}, lambdas::AbstractVector{Float64})` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:285

Arguments:

  * `f0::AbstractVector{Float64}` : initial model observations
  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `lambdas::AbstractVector{Float64}` : Levenberg-Marquardt lambdas
  * `o::Function` : objective function
  * `x0::AbstractVector{Float64}` : initial parameter guess

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L270-L278' class='documenter-source'>source</a><br>

<a id='Mads.noplot-Tuple{}' href='#Mads.noplot-Tuple{}'>#</a>
**`Mads.noplot`** &mdash; *Method*.



Disable MADS plotting

Methods:

  * `Mads.noplot()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:240


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L235-L239' class='documenter-source'>source</a><br>

<a id='Mads.notebook-Tuple{AbstractString}' href='#Mads.notebook-Tuple{AbstractString}'>#</a>
**`Mads.notebook`** &mdash; *Method*.



Execute Jupyter notebook in IJulia or as a script

Methods:

  * `Mads.notebook(rootname::AbstractString; script, dir, ndir, check)` : C:\Users\monty.julia\dev\Mads\src\MadsNotebooks.jl:21

Arguments:

  * `rootname::AbstractString` : notebook root name

Keywords:

  * `check` : check of notebook exists
  * `dir` : notebook directory
  * `ndir`
  * `script` : execute as a script


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsNotebooks.jl#L14-L18' class='documenter-source'>source</a><br>

<a id='Mads.notebooks-Tuple{}' href='#Mads.notebooks-Tuple{}'>#</a>
**`Mads.notebooks`** &mdash; *Method*.



Execute Jupyter notebook in IJulia or as a script

Methods:

  * `Mads.notebooks(; dir, ndir)` : C:\Users\monty.julia\dev\Mads\src\MadsNotebooks.jl:53

Keywords:

  * `dir` : notebook directory
  * `ndir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsNotebooks.jl#L47-L51' class='documenter-source'>source</a><br>

<a id='Mads.notebookscript-Tuple' href='#Mads.notebookscript-Tuple'>#</a>
**`Mads.notebookscript`** &mdash; *Method*.



Execute Jupyter notebook as a script

Methods:

  * `Mads.notebookscript(a...; script, dir, ndir, k...)` : C:\Users\monty.julia\dev\Mads\src\MadsNotebooks.jl:10

Keywords:

  * `dir` : notebook directory
  * `ndir`
  * `script` : execute as a script


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsNotebooks.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.obslineoccursin-Tuple{AbstractString, Vector{Regex}}' href='#Mads.obslineoccursin-Tuple{AbstractString, Vector{Regex}}'>#</a>
**`Mads.obslineoccursin`** &mdash; *Method*.



Match an instruction line in the Mads instruction file with model input file

Methods:

  * `Mads.obslineoccursin(obsline::AbstractString, regexs::Vector{Regex})` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1043

Arguments:

  * `obsline::AbstractString` : instruction line
  * `regexs::Vector{Regex}` : regular expressions

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1032-L1040' class='documenter-source'>source</a><br>

<a id='Mads.of' href='#Mads.of'>#</a>
**`Mads.of`** &mdash; *Function*.



Compute objective function

Methods:

  * `Mads.of(madsdata::AbstractDict, d::AbstractDict; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:54
  * `Mads.of(madsdata::AbstractDict, resultvec::AbstractVector; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:50
  * `Mads.of(madsdata::AbstractDict; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:65

Arguments:

  * `d::AbstractDict`
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `resultvec::AbstractVector` : result vector

Keywords:

  * `filter`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L70-L74' class='documenter-source'>source</a><br>

<a id='Mads.parallel_optimization_off-Tuple{}' href='#Mads.parallel_optimization_off-Tuple{}'>#</a>
**`Mads.parallel_optimization_off`** &mdash; *Method*.



Turn off parallel optimization of jacobians and lambdas

Methods:

  * `Mads.parallel_optimization_off()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:229


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L224-L228' class='documenter-source'>source</a><br>

<a id='Mads.parallel_optimization_on-Tuple{}' href='#Mads.parallel_optimization_on-Tuple{}'>#</a>
**`Mads.parallel_optimization_on`** &mdash; *Method*.



Turn on parallel optimization of jacobians and lambdas

Methods:

  * `Mads.parallel_optimization_on()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:220


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L215-L219' class='documenter-source'>source</a><br>

<a id='Mads.paramarray2dict-Tuple{AbstractDict, Array}' href='#Mads.paramarray2dict-Tuple{AbstractDict, Array}'>#</a>
**`Mads.paramarray2dict`** &mdash; *Method*.



Convert a parameter array to a parameter dictionary of arrays

Methods:

  * `Mads.paramarray2dict(madsdata::AbstractDict, array::Array)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:263

Arguments:

  * `array::Array` : parameter array
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * a parameter dictionary of arrays


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMonteCarlo.jl#L252-L260' class='documenter-source'>source</a><br>

<a id='Mads.paramdict2array-Tuple{AbstractDict}' href='#Mads.paramdict2array-Tuple{AbstractDict}'>#</a>
**`Mads.paramdict2array`** &mdash; *Method*.



Convert a parameter dictionary of arrays to a parameter array

Methods:

  * `Mads.paramdict2array(dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:282

Arguments:

  * `dict::AbstractDict` : parameter dictionary of arrays

Returns:

  * a parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMonteCarlo.jl#L272-L280' class='documenter-source'>source</a><br>

<a id='Mads.parsemadsdata!-Tuple{AbstractDict}' href='#Mads.parsemadsdata!-Tuple{AbstractDict}'>#</a>
**`Mads.parsemadsdata!`** &mdash; *Method*.



Parse loaded MADS problem dictionary

Methods:

  * `Mads.parsemadsdata!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:195

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L189-L193' class='documenter-source'>source</a><br>

<a id='Mads.parsenodenames' href='#Mads.parsenodenames'>#</a>
**`Mads.parsenodenames`** &mdash; *Function*.



Parse string with node names defined in SLURM

Methods:

  * `Mads.parsenodenames(nodenames::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:209
  * `Mads.parsenodenames(nodenames::AbstractString, ntasks_per_node::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:209

Arguments:

  * `nodenames::AbstractString` : string with node names defined in SLURM
  * `ntasks_per_node::Integer` : number of parallel tasks per node [default=`1`]

Returns:

  * vector with names of compute nodes (hosts)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L198-L206' class='documenter-source'>source</a><br>

<a id='Mads.partialof-Tuple{AbstractDict, AbstractDict, Regex}' href='#Mads.partialof-Tuple{AbstractDict, AbstractDict, Regex}'>#</a>
**`Mads.partialof`** &mdash; *Method*.



Compute the sum of squared residuals for observations that match a regular expression

Methods:

  * `Mads.partialof(madsdata::AbstractDict, resultdict::AbstractDict, regex::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:91

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `regex::Regex` : regular expression
  * `resultdict::AbstractDict` : result dictionary

Returns:

  * the sum of squared residuals for observations that match the regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L79-L87' class='documenter-source'>source</a><br>

<a id='Mads.pkgversion_old-Tuple{AbstractString}' href='#Mads.pkgversion_old-Tuple{AbstractString}'>#</a>
**`Mads.pkgversion_old`** &mdash; *Method*.



Get package version

Methods:

  * `Mads.pkgversion_old(modulestr::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:545

Arguments:

  * `modulestr::AbstractString`

Returns:

  * package version


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L536-L544' class='documenter-source'>source</a><br>

<a id='Mads.plotgrid' href='#Mads.plotgrid'>#</a>
**`Mads.plotgrid`** &mdash; *Function*.



Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

Methods:

  * `Mads.plotgrid(madsdata::AbstractDict, parameters::AbstractDict; addtitle, title, filename, format)` : C:\Users\monty.julia\dev\Mads\src\MadsPlotPy.jl:61
  * `Mads.plotgrid(madsdata::AbstractDict, s::Array{Float64}; addtitle, title, filename, format)` : C:\Users\monty.julia\dev\Mads\src\MadsPlotPy.jl:4
  * `Mads.plotgrid(madsdata::AbstractDict; addtitle, title, filename, format)` : C:\Users\monty.julia\dev\Mads\src\MadsPlotPy.jl:56

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameters::AbstractDict` : dictionary with model parameters
  * `s::Array{Float64}` : model predictions array

Keywords:

  * `addtitle` : add plot title [default=`true`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `title` : plot title

Examples:

```julia
Mads.plotgrid(madsdata, s; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata, parameters; addtitle=true, title="", filename="", format="")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlotPy.jl#L68-L80' class='documenter-source'>source</a><br>

<a id='Mads.plotlocalsa-Tuple{AbstractString}' href='#Mads.plotlocalsa-Tuple{AbstractString}'>#</a>
**`Mads.plotlocalsa`** &mdash; *Method*.



Plot local sensitivity analysis results

Methods:

  * `Mads.plotlocalsa(filenameroot::AbstractString; keyword, filename, format)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:1251

Arguments:

  * `filenameroot::AbstractString` : problem file name root

Keywords:

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : keyword to be added in the filename root

Dumps:

  * `filename` : output plot file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L1238-L1246' class='documenter-source'>source</a><br>

<a id='Mads.plotmadsproblem-Tuple{AbstractDict}' href='#Mads.plotmadsproblem-Tuple{AbstractDict}'>#</a>
**`Mads.plotmadsproblem`** &mdash; *Method*.



Plot contaminant sources and wells defined in MADS problem dictionary

Methods:

  * `Mads.plotmadsproblem(madsdata::AbstractDict; format, filename, keyword, hsize, vsize, quiet, gm)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:116

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `gm`
  * `hsize`
  * `keyword` : to be added in the filename
  * `quiet`
  * `vsize`

Dumps:

  * plot of contaminant sources and wells


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L103-L111' class='documenter-source'>source</a><br>

<a id='Mads.plotmass-Tuple{AbstractVector{Float64}, AbstractVector{Float64}, AbstractVector{Float64}, AbstractString}' href='#Mads.plotmass-Tuple{AbstractVector{Float64}, AbstractVector{Float64}, AbstractVector{Float64}, AbstractString}'>#</a>
**`Mads.plotmass`** &mdash; *Method*.



Plot injected/reduced contaminant mass

Methods:

  * `Mads.plotmass(lambda::AbstractVector{Float64}, mass_injected::AbstractVector{Float64}, mass_reduced::AbstractVector{Float64}, filename::AbstractString; format, hsize, vsize)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasolPlot.jl:17

Arguments:

  * `filename::AbstractString` : output filename for the generated plot
  * `lambda::AbstractVector{Float64}` : array with all the lambda values
  * `mass_injected::AbstractVector{Float64}` : array with associated total injected mass
  * `mass_reduced::AbstractVector{Float64}` : array with associated total reduced mass

Keywords:

  * `format` : output plot format (`png`, `pdf`, etc.)
  * `hsize`
  * `vsize`

Dumps:

  * image file with name `filename` and in specified `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasolPlot.jl#L3-L11' class='documenter-source'>source</a><br>

<a id='Mads.plotmatches' href='#Mads.plotmatches'>#</a>
**`Mads.plotmatches`** &mdash; *Function*.



Plot the matches between model predictions and observations

Methods:

  * `Mads.plotmatches(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:193
  * `Mads.plotmatches(madsdata::AbstractDict, dict_in::AbstractDict; plotdata, filename, format, title, xtitle, ytitle, ymin, ymax, xmin, xmax, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display, notitle, truthtitle, predictiontitle, gmk)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:225
  * `Mads.plotmatches(madsdata::AbstractDict, result::AbstractDict, rx::Union{Regex, AbstractString}; title, notitle, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:201
  * `Mads.plotmatches(madsdata::AbstractDict, rx::Union{Regex, AbstractString}; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:193

Arguments:

  * `dict_in::AbstractDict` : dictionary with model parameters
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `result::AbstractDict` : dictionary with model predictions
  * `rx::Union{Regex, AbstractString}` : regular expression to filter the outputs

Keywords:

  * `colors` : array with plot colors
  * `display` : display plots [default=`false`]
  * `dpi` : graph resolution [default=`Mads.imagedpi`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `gmk`
  * `hsize` : graph horizontal size [default=`8Gadfly.inch`]
  * `linewidth` : line width [default=`2Gadfly.pt`]
  * `noise` : random noise magnitude [default=`0`; no noise]
  * `notitle`
  * `obs_plot_dots` : plot data as dots or line [default=`true`]
  * `plotdata` : plot data (if `false` model predictions are ploted only) [default=`true`]
  * `pointsize` : data dot size [default=`2Gadfly.pt`]
  * `predictiontitle`
  * `separate_files` : plot data for multiple wells separately [default=`false`]
  * `title` : graph title
  * `truthtitle`
  * `vsize` : graph vertical size [default=`4Gadfly.inch`]
  * `xmax`
  * `xmin`
  * `xtitle` : x-axis title [default=`"Time"`]
  * `ymax`
  * `ymin`
  * `ytitle` : y-axis title [default=`"y"`]

Dumps:

  * plot of the matches between model predictions and observations

Examples:

```julia
Mads.plotmatches(madsdata; filename="", format="")
Mads.plotmatches(madsdata, dict_in; filename="", format="")
Mads.plotmatches(madsdata, result; filename="", format="")
Mads.plotmatches(madsdata, result, r"NO3"; filename="", format="")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L380-L397' class='documenter-source'>source</a><br>

<a id='Mads.plotobsSAresults-Tuple{AbstractDict, AbstractDict}' href='#Mads.plotobsSAresults-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.plotobsSAresults`** &mdash; *Method*.



Plot the sensitivity analysis results for the observations

Methods:

  * `Mads.plotobsSAresults(madsdata::AbstractDict, result::AbstractDict; filter, keyword, filename, format, separate_files, xtitle, ytitle, plotlabels, quiet, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:598

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `result::AbstractDict` : sensitivity analysis results

Keywords:

  * `filename` : output file name
  * `filter` : string or regex to plot only observations containing `filter`
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `keyword` : to be added in the auto-generated filename
  * `plotlabels`
  * `quiet`
  * `separate_files` : plot data for multiple wells separately [default=`false`]
  * `xtitle` : x-axis title
  * `ytitle` : y-axis title

Dumps:

  * plot of the sensitivity analysis results for the observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L577-L585' class='documenter-source'>source</a><br>

<a id='Mads.plotrobustnesscurves-Tuple{AbstractDict, Dict}' href='#Mads.plotrobustnesscurves-Tuple{AbstractDict, Dict}'>#</a>
**`Mads.plotrobustnesscurves`** &mdash; *Method*.



Plot BIG-DT robustness curves

Methods:

  * `Mads.plotrobustnesscurves(madsdata::AbstractDict, bigdtresults::Dict; filename, format, maxprob, maxhoriz)` : C:\Users\monty.julia\dev\Mads\src\MadsBayesInfoGapPlot.jl:19

Arguments:

  * `bigdtresults::Dict` : BIG-DT results
  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `filename` : output file name used to dump plots
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `maxhoriz` : maximum horizon [default=`Inf`]
  * `maxprob` : maximum probability [default=`1.0`]

Dumps:

  * image file with name `filename` and in specified `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsBayesInfoGapPlot.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.plotseries' href='#Mads.plotseries'>#</a>
**`Mads.plotseries`** &mdash; *Function*.



Create plots of data series

Methods:

  * `Mads.plotseries(X::AbstractArray)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:1048
  * `Mads.plotseries(X::AbstractArray, filename::AbstractString; nT, nS, format, xtitle, ytitle, title, logx, logy, keytitle, name, names, combined, hsize, vsize, linewidth, linestyle, pointsize, key_position, major_label_font_size, minor_label_font_size, dpi, colors, opacity, xmin, xmax, ymin, ymax, xaxis, plotline, plotdots, firstred, lastred, nextgray, code, returnplot, colorkey, background_color, gm, gl, quiet, truth, gall)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:1048

Arguments:

  * `X::AbstractArray` : matrix with the series data
  * `filename::AbstractString` : output file name

Keywords:

  * `background_color`
  * `code`
  * `colorkey`
  * `colors` : colors to use in plots
  * `combined` : combine plots [default=`true`]
  * `dpi` : graph resolution [default=`Mads.imagedpi`]
  * `firstred`
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `gall`
  * `gl`
  * `gm`
  * `hsize` : horizontal size [default=`8Gadfly.inch`]
  * `key_position`
  * `keytitle`
  * `lastred`
  * `linestyle`
  * `linewidth` : width of the lines in plot  [default=`2Gadfly.pt`]
  * `logx`
  * `logy`
  * `major_label_font_size`
  * `minor_label_font_size`
  * `nS`
  * `nT`
  * `name` : series name [default=`Sources`]
  * `names`
  * `nextgray`
  * `opacity`
  * `plotdots`
  * `plotline`
  * `pointsize`
  * `quiet`
  * `returnplot`
  * `title` : plot title [default=`Sources`]
  * `truth`
  * `vsize` : vertical size [default=`4Gadfly.inch`]
  * `xaxis`
  * `xmax`
  * `xmin`
  * `xtitle` : x-axis title [default=`X`]
  * `ymax`
  * `ymin`
  * `ytitle` : y-axis title [default=`Y`]

Dumps:

  * Plots of data series


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L1026-L1034' class='documenter-source'>source</a><br>

<a id='Mads.plotwellSAresults' href='#Mads.plotwellSAresults'>#</a>
**`Mads.plotwellSAresults`** &mdash; *Function*.



Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

Methods:

  * `Mads.plotwellSAresults(madsdata::AbstractDict, result::AbstractDict, wellname::AbstractString; xtitle, ytitle, filename, format, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:477
  * `Mads.plotwellSAresults(madsdata::AbstractDict, result::AbstractDict; xtitle, ytitle, filename, format, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:466

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `result::AbstractDict` : sensitivity analysis results
  * `wellname::AbstractString` : well name

Keywords:

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `quiet`
  * `xtitle` : x-axis title
  * `ytitle` : y-axis title

Dumps:

  * Plot of the sensitivity analysis results for all the wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L560-L568' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults-Tuple{AbstractDict, AbstractDict}' href='#Mads.printSAresults-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.printSAresults`** &mdash; *Method*.



Print sensitivity analysis results

Methods:

  * `Mads.printSAresults(madsdata::AbstractDict, results::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:927

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `results::AbstractDict` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L920-L924' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults2-Tuple{AbstractDict, AbstractDict}' href='#Mads.printSAresults2-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.printSAresults2`** &mdash; *Method*.



Print sensitivity analysis results (method 2)

Methods:

  * `Mads.printSAresults2(madsdata::AbstractDict, results::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:1009

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `results::AbstractDict` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L1002-L1006' class='documenter-source'>source</a><br>

<a id='Mads.printerrormsg-Tuple{Any}' href='#Mads.printerrormsg-Tuple{Any}'>#</a>
**`Mads.printerrormsg`** &mdash; *Method*.



Print error message

Methods:

  * `Mads.printerrormsg(errmsg)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:438

Arguments:

  * `errmsg` : error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L432-L436' class='documenter-source'>source</a><br>

<a id='Mads.printobservations' href='#Mads.printobservations'>#</a>
**`Mads.printobservations`** &mdash; *Function*.



Print (emit) observations in the MADS problem dictionary

Methods:

  * `Mads.printobservations(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:435
  * `Mads.printobservations(madsdata::AbstractDict, filename::AbstractString; json)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:443
  * `Mads.printobservations(madsdata::AbstractDict, io::IO)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:435
  * `Mads.printobservations(madsdata::AbstractDict, io::IO, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:435

Arguments:

  * `filename::AbstractString` : output file name
  * `io::IO` : output stream
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector`

Keywords:

  * `json`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L448-L452' class='documenter-source'>source</a><br>

<a id='Mads.process_notebook-Tuple{AbstractString}' href='#Mads.process_notebook-Tuple{AbstractString}'>#</a>
**`Mads.process_notebook`** &mdash; *Method*.



Process Jupyter notebook to generate html, markdown, latex, and script versions

Methods:

  * `Mads.process_notebook(rootname::AbstractString; dir, ndir)` : C:\Users\monty.julia\dev\Mads\src\MadsNotebooks.jl:69

Arguments:

  * `rootname::AbstractString` : notebook root name

Keywords:

  * `dir` : notebook directory
  * `ndir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsNotebooks.jl#L62-L66' class='documenter-source'>source</a><br>

<a id='Mads.pull' href='#Mads.pull'>#</a>
**`Mads.pull`** &mdash; *Function*.



Pull (checkout) the latest version of Mads modules

Methods:

  * `Mads.pull()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:62
  * `Mads.pull(modulename::AbstractString; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:62

Arguments:

  * `modulename::AbstractString` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L55-L59' class='documenter-source'>source</a><br>

<a id='Mads.push' href='#Mads.push'>#</a>
**`Mads.push`** &mdash; *Function*.



Push the latest version of Mads modules in the default remote repository

Methods:

  * `Mads.push()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:137
  * `Mads.push(modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:137

Arguments:

  * `modulename::AbstractString` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L131-L135' class='documenter-source'>source</a><br>

<a id='Mads.quietoff-Tuple{}' href='#Mads.quietoff-Tuple{}'>#</a>
**`Mads.quietoff`** &mdash; *Method*.



Make MADS not quiet

Methods:

  * `Mads.quietoff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:112


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L107-L111' class='documenter-source'>source</a><br>

<a id='Mads.quieton-Tuple{}' href='#Mads.quieton-Tuple{}'>#</a>
**`Mads.quieton`** &mdash; *Method*.



Make MADS quiet

Methods:

  * `Mads.quieton()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:103


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L98-L102' class='documenter-source'>source</a><br>

<a id='Mads.readasciipredictions-Tuple{AbstractString}' href='#Mads.readasciipredictions-Tuple{AbstractString}'>#</a>
**`Mads.readasciipredictions`** &mdash; *Method*.



Read MADS predictions from an ASCII file

Methods:

  * `Mads.readasciipredictions(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsASCII.jl:44

Arguments:

  * `filename::AbstractString` : ASCII file name

Returns:

  * MADS predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsASCII.jl#L34-L42' class='documenter-source'>source</a><br>

<a id='Mads.readmodeloutput-Tuple{AbstractDict}' href='#Mads.readmodeloutput-Tuple{AbstractDict}'>#</a>
**`Mads.readmodeloutput`** &mdash; *Method*.



Read model outputs saved for MADS

Methods:

  * `Mads.readmodeloutput(madsdata::AbstractDict; obskeys)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:801

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `obskeys` : observation keys [default=getobskeys(madsdata)]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L794-L798' class='documenter-source'>source</a><br>

<a id='Mads.readobservations' href='#Mads.readobservations'>#</a>
**`Mads.readobservations`** &mdash; *Function*.



Read observations

Methods:

  * `Mads.readobservations(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1163
  * `Mads.readobservations(madsdata::AbstractDict, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1163

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector` : observation keys [default=`getobskeys(madsdata)`]

Returns:

  * dictionary with Mads observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1152-L1160' class='documenter-source'>source</a><br>

<a id='Mads.readobservations_cmads-Tuple{AbstractDict}' href='#Mads.readobservations_cmads-Tuple{AbstractDict}'>#</a>
**`Mads.readobservations_cmads`** &mdash; *Method*.



Read observations using C MADS dynamic library

Methods:

  * `Mads.readobservations_cmads(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsCMads.jl:14

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary

Returns:

  * observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCMads.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.readyamlpredictions-Tuple{AbstractString}' href='#Mads.readyamlpredictions-Tuple{AbstractString}'>#</a>
**`Mads.readyamlpredictions`** &mdash; *Method*.



Read MADS model predictions from a YAML file `filename`

Methods:

  * `Mads.readyamlpredictions(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsYAML.jl:107

Arguments:

  * `filename::AbstractString` : file name

Returns:

  * data in yaml input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsYAML.jl#L96-L104' class='documenter-source'>source</a><br>

<a id='Mads.recursivemkdir-Tuple{AbstractString}' href='#Mads.recursivemkdir-Tuple{AbstractString}'>#</a>
**`Mads.recursivemkdir`** &mdash; *Method*.



Create directories recursively (if does not already exist)

Methods:

  * `Mads.recursivemkdir(s::AbstractString; filename)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1400

Arguments:

  * `s::AbstractString`

Keywords:

  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1394-L1398' class='documenter-source'>source</a><br>

<a id='Mads.recursivermdir-Tuple{AbstractString}' href='#Mads.recursivermdir-Tuple{AbstractString}'>#</a>
**`Mads.recursivermdir`** &mdash; *Method*.



Remove directories recursively

Methods:

  * `Mads.recursivermdir(s::AbstractString; filename)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1445

Arguments:

  * `s::AbstractString`

Keywords:

  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1439-L1443' class='documenter-source'>source</a><br>

<a id='Mads.regexs2obs-Tuple{AbstractString, Vector{Regex}, Vector{String}, Vector{Bool}}' href='#Mads.regexs2obs-Tuple{AbstractString, Vector{Regex}, Vector{String}, Vector{Bool}}'>#</a>
**`Mads.regexs2obs`** &mdash; *Method*.



Get observations for a set of regular expressions

Methods:

  * `Mads.regexs2obs(obsline::AbstractString, regexs::Vector{Regex}, obsnames::Vector{String}, getparamhere::Vector{Bool})` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1064

Arguments:

  * `getparamhere::Vector{Bool}` : parameters
  * `obsline::AbstractString` : observation line
  * `obsnames::Vector{String}` : observation names
  * `regexs::Vector{Regex}` : regular expressions

Returns:

  * `obsdict` : observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1051-L1059' class='documenter-source'>source</a><br>

<a id='Mads.removesource!' href='#Mads.removesource!'>#</a>
**`Mads.removesource!`** &mdash; *Function*.



Remove a contamination source

Methods:

  * `Mads.removesource!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:50
  * `Mads.removesource!(madsdata::AbstractDict, sourceid::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:50

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `sourceid::Int64` : source id [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L43-L47' class='documenter-source'>source</a><br>

<a id='Mads.removesourceparameters!-Tuple{AbstractDict}' href='#Mads.removesourceparameters!-Tuple{AbstractDict}'>#</a>
**`Mads.removesourceparameters!`** &mdash; *Method*.



Remove contaminant source parameters

Methods:

  * `Mads.removesourceparameters!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsAnasol.jl:135

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsAnasol.jl#L129-L133' class='documenter-source'>source</a><br>

<a id='Mads.required' href='#Mads.required'>#</a>
**`Mads.required`** &mdash; *Function*.



Lists modules required by a module (Mads by default)

Methods:

  * `Mads.required()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:16
  * `Mads.required(modulename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:16
  * `Mads.required(modulename::AbstractString, filtermodule::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:16

Arguments:

  * `filtermodule::AbstractString` : filter module name
  * `modulename::AbstractString` : module name [default=`"Mads"`]

Returns:

  * filtered modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.resetmodelruns-Tuple{}' href='#Mads.resetmodelruns-Tuple{}'>#</a>
**`Mads.resetmodelruns`** &mdash; *Method*.



Reset the model runs count to be equal to zero

Methods:

  * `Mads.resetmodelruns()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:268


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L263-L267' class='documenter-source'>source</a><br>

<a id='Mads.residuals' href='#Mads.residuals'>#</a>
**`Mads.residuals`** &mdash; *Function*.



Compute residuals

Methods:

  * `Mads.residuals(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:32
  * `Mads.residuals(madsdata::AbstractDict, resultdict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:29
  * `Mads.residuals(madsdata::AbstractDict, resultvec::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsLevenbergMarquardt.jl:6

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `resultdict::AbstractDict` : result dictionary
  * `resultvec::AbstractVector` : result vector

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsLevenbergMarquardt.jl#L37-L45' class='documenter-source'>source</a><br>

<a id='Mads.restartoff-Tuple{}' href='#Mads.restartoff-Tuple{}'>#</a>
**`Mads.restartoff`** &mdash; *Method*.



MADS restart off

Methods:

  * `Mads.restartoff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:84


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L79-L83' class='documenter-source'>source</a><br>

<a id='Mads.restarton-Tuple{}' href='#Mads.restarton-Tuple{}'>#</a>
**`Mads.restarton`** &mdash; *Method*.



MADS restart on

Methods:

  * `Mads.restarton()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:75


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L70-L74' class='documenter-source'>source</a><br>

<a id='Mads.reweighsamples-Tuple{AbstractDict, Array, AbstractVector}' href='#Mads.reweighsamples-Tuple{AbstractDict, Array, AbstractVector}'>#</a>
**`Mads.reweighsamples`** &mdash; *Method*.



Reweigh samples using importance sampling – returns a vector of log-likelihoods after reweighing

Methods:

  * `Mads.reweighsamples(madsdata::AbstractDict, predictions::Array, oldllhoods::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:331

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `oldllhoods::AbstractVector` : the log likelihoods of the parameters in the old distribution
  * `predictions::Array` : the model predictions for each of the samples

Returns:

  * vector of log-likelihoods after reweighing


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L319-L327' class='documenter-source'>source</a><br>

<a id='Mads.rmdir-Tuple{AbstractString}' href='#Mads.rmdir-Tuple{AbstractString}'>#</a>
**`Mads.rmdir`** &mdash; *Method*.



Remove directory

Methods:

  * `Mads.rmdir(dir::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1260

Arguments:

  * `dir::AbstractString` : directory to be removed

Keywords:

  * `path` : path of the directory [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1253-L1257' class='documenter-source'>source</a><br>

<a id='Mads.rmfile-Tuple{AbstractString}' href='#Mads.rmfile-Tuple{AbstractString}'>#</a>
**`Mads.rmfile`** &mdash; *Method*.



Remove file

Methods:

  * `Mads.rmfile(filename::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1276

Arguments:

  * `filename::AbstractString` : file to be removed

Keywords:

  * `path` : path of the file [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1269-L1273' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles-Tuple{Regex}' href='#Mads.rmfiles-Tuple{Regex}'>#</a>
**`Mads.rmfiles`** &mdash; *Method*.



Remove files

Methods:

  * `Mads.rmfile(filename::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1276

Arguments:

  * `filename::AbstractString`

Keywords:

  * `path` : path of the file [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1285-L1289' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_ext-Tuple{AbstractString}' href='#Mads.rmfiles_ext-Tuple{AbstractString}'>#</a>
**`Mads.rmfiles_ext`** &mdash; *Method*.



Remove files with extension `ext`

Methods:

  * `Mads.rmfiles_ext(ext::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1305

Arguments:

  * `ext::AbstractString` : extension

Keywords:

  * `path` : path of the files to be removed [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1298-L1302' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_root-Tuple{AbstractString}' href='#Mads.rmfiles_root-Tuple{AbstractString}'>#</a>
**`Mads.rmfiles_root`** &mdash; *Method*.



Remove files with root `root`

Methods:

  * `Mads.rmfiles_root(root::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1318

Arguments:

  * `root::AbstractString` : root

Keywords:

  * `path` : path of the files to be removed [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1311-L1315' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock-Tuple{AbstractVector}' href='#Mads.rosenbrock-Tuple{AbstractVector}'>#</a>
**`Mads.rosenbrock`** &mdash; *Method*.



Rosenbrock test function

Methods:

  * `Mads.rosenbrock(x::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:42

Arguments:

  * `x::AbstractVector` : parameter vector

Returns:

  * test result


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_gradient_lm-Tuple{AbstractVector}' href='#Mads.rosenbrock2_gradient_lm-Tuple{AbstractVector}'>#</a>
**`Mads.rosenbrock2_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods:

  * `Mads.rosenbrock2_gradient_lm(x::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:23

Arguments:

  * `x::AbstractVector` : parameter vector

Returns:

  * parameter gradients


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L13-L21' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_lm-Tuple{AbstractVector}' href='#Mads.rosenbrock2_lm-Tuple{AbstractVector}'>#</a>
**`Mads.rosenbrock2_lm`** &mdash; *Method*.



Rosenbrock test function (more difficult to solve)

Methods:

  * `Mads.rosenbrock2_lm(x::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:9

Arguments:

  * `x::AbstractVector` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient!-Tuple{AbstractVector, AbstractVector}' href='#Mads.rosenbrock_gradient!-Tuple{AbstractVector, AbstractVector}'>#</a>
**`Mads.rosenbrock_gradient!`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods:

  * `Mads.rosenbrock_gradient!(x::AbstractVector, grad::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:67

Arguments:

  * `grad::AbstractVector` : gradient vector
  * `x::AbstractVector` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L60-L64' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient_lm-Tuple{AbstractVector}' href='#Mads.rosenbrock_gradient_lm-Tuple{AbstractVector}'>#</a>
**`Mads.rosenbrock_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separately)

Methods:

  * `Mads.rosenbrock_gradient_lm(x::AbstractVector; dx, center)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:84

Arguments:

  * `x::AbstractVector` : parameter vector

Keywords:

  * `center` : array with parameter observations at the center applied to compute numerical derivatives [default=`Vector{Float64}(undef, 0)`]
  * `dx` : apply parameter step to compute numerical derivatives [default=`false`]

Returns:

  * parameter gradients


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L72-L80' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_hessian!-Tuple{AbstractVector, AbstractMatrix}' href='#Mads.rosenbrock_hessian!-Tuple{AbstractVector, AbstractMatrix}'>#</a>
**`Mads.rosenbrock_hessian!`** &mdash; *Method*.



Parameter Hessian of the Rosenbrock test function

Methods:

  * `Mads.rosenbrock_hessian!(x::AbstractVector, hess::AbstractMatrix)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:100

Arguments:

  * `hess::AbstractMatrix` : Hessian matrix
  * `x::AbstractVector` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L93-L97' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_lm-Tuple{AbstractVector}' href='#Mads.rosenbrock_lm-Tuple{AbstractVector}'>#</a>
**`Mads.rosenbrock_lm`** &mdash; *Method*.



Rosenbrock test function for LM optimization (returns the 2 components separately)

Methods:

  * `Mads.rosenbrock_lm(x::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsTestFunctions.jl:56

Arguments:

  * `x::AbstractVector` : parameter vector

Returns:

  * test result


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTestFunctions.jl#L46-L54' class='documenter-source'>source</a><br>

<a id='Mads.runcmd' href='#Mads.runcmd'>#</a>
**`Mads.runcmd`** &mdash; *Function*.



Run external command and pipe stdout and stderr

Methods:

  * `Mads.runcmd(cmd::Cmd; quiet, pipe, waittime)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:41
  * `Mads.runcmd(cmdstring::AbstractString; quiet, pipe, waittime)` : C:\Users\monty.julia\dev\Mads\src\MadsExecute.jl:100

Arguments:

  * `cmd::Cmd` : command (as a julia command; e.g. `ls`)
  * `cmdstring::AbstractString` : command (as a string; e.g. "ls")

Keywords:

  * `pipe` : [default=`false`]
  * `quiet` : [default=`Mads.quiet`]
  * `waittime` : wait time is second [default=`Mads.executionwaittime`]

Returns:

  * command output
  * command error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsExecute.jl#L111-L120' class='documenter-source'>source</a><br>

<a id='Mads.runremote' href='#Mads.runremote'>#</a>
**`Mads.runremote`** &mdash; *Function*.



Run remote command on a series of servers

Methods:

  * `Mads.runremote(cmd::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:285
  * `Mads.runremote(cmd::AbstractString, nodenames::Vector{String})` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:285

Arguments:

  * `cmd::AbstractString` : remote command
  * `nodenames::Vector{String}` : names of machines/nodes [default=`madsservers`]

Returns:

  * output of running remote command


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L274-L282' class='documenter-source'>source</a><br>

<a id='Mads.saltelli-Tuple{AbstractDict}' href='#Mads.saltelli-Tuple{AbstractDict}'>#</a>
**`Mads.saltelli`** &mdash; *Method*.



Saltelli sensitivity analysis

Methods:

  * `Mads.saltelli(madsdata::AbstractDict; N, seed, rng, restartdir, parallel, checkpointfrequency)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:644

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `N` : number of samples [default=`100`]
  * `checkpointfrequency` : check point frequency [default=`N`]
  * `parallel` : set to true if the model runs should be performed in parallel [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `rng`
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L633-L637' class='documenter-source'>source</a><br>

<a id='Mads.saltellibrute-Tuple{AbstractDict}' href='#Mads.saltellibrute-Tuple{AbstractDict}'>#</a>
**`Mads.saltellibrute`** &mdash; *Method*.



Saltelli sensitivity analysis (brute force)

Methods:

  * `Mads.saltellibrute(madsdata::AbstractDict; N, seed, rng, restartdir)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:456

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `N` : number of samples [default=`1000`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `rng`
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L447-L451' class='documenter-source'>source</a><br>

<a id='Mads.saltellibruteparallel-Tuple{AbstractDict, Integer}' href='#Mads.saltellibruteparallel-Tuple{AbstractDict, Integer}'>#</a>
**`Mads.saltellibruteparallel`** &mdash; *Method*.



Parallel version of saltellibrute


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L880-L882' class='documenter-source'>source</a><br>

<a id='Mads.saltelliparallel-Tuple{AbstractDict, Integer}' href='#Mads.saltelliparallel-Tuple{AbstractDict, Integer}'>#</a>
**`Mads.saltelliparallel`** &mdash; *Method*.



Parallel version of saltelli


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L880-L882' class='documenter-source'>source</a><br>

<a id='Mads.sampling-Tuple{AbstractVector, Array, Number}' href='#Mads.sampling-Tuple{AbstractVector, Array, Number}'>#</a>
**`Mads.sampling`** &mdash; *Method*.



Methods:

  * `Mads.sampling(param::AbstractVector, J::Array, numsamples::Number; seed, rng, scale)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:280

Arguments:

  * `J::Array` : Jacobian matrix
  * `numsamples::Number` : Number of samples
  * `param::AbstractVector` : Parameter vector

Keywords:

  * `rng`
  * `scale` : data scaling [default=`1`]
  * `seed` : random esee [default=`0`]

Returns:

  * generated samples (vector or array)
  * vector of log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L267-L278' class='documenter-source'>source</a><br>

<a id='Mads.savemadsfile' href='#Mads.savemadsfile'>#</a>
**`Mads.savemadsfile`** &mdash; *Function*.



Save MADS problem dictionary `madsdata` in MADS input file `filename`

Methods:

  * `Mads.savemadsfile(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:339
  * `Mads.savemadsfile(madsdata::AbstractDict, filename::AbstractString; observations_separate, filenameobs)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:339
  * `Mads.savemadsfile(madsdata::AbstractDict, parameters::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:356
  * `Mads.savemadsfile(madsdata::AbstractDict, parameters::AbstractDict, filename::AbstractString; explicit, observations_separate)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:356

Arguments:

  * `filename::AbstractString` : input file name (e.g. `input_file_name.mads`)
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameters::AbstractDict` : Dictionary with parameters (optional)

Keywords:

  * `explicit` : if `true` ignores MADS YAML file modifications and rereads the original input file [default=`false`]
  * `filenameobs`
  * `observations_separate`

Example:

```julia
Mads.savemadsfile(madsdata)
Mads.savemadsfile(madsdata, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads", explicit=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L390-L403' class='documenter-source'>source</a><br>

<a id='Mads.savemcmcresults-Tuple{Array, AbstractString}' href='#Mads.savemcmcresults-Tuple{Array, AbstractString}'>#</a>
**`Mads.savemcmcresults`** &mdash; *Method*.



Save MCMC chain in a file

Methods:

  * `Mads.savemcmcresults(chain::Array, filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsMonteCarlo.jl:148

Arguments:

  * `chain::Array` : MCMC chain
  * `filename::AbstractString` : file name

Dumps:

  * the file containing MCMC chain


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMonteCarlo.jl#L137-L145' class='documenter-source'>source</a><br>

<a id='Mads.savesaltellirestart-Tuple{Array, AbstractString, AbstractString}' href='#Mads.savesaltellirestart-Tuple{Array, AbstractString, AbstractString}'>#</a>
**`Mads.savesaltellirestart`** &mdash; *Method*.



Save Saltelli sensitivity analysis results for fast simulation restarts

Methods:

  * `Mads.savesaltellirestart(evalmat::Array, matname::AbstractString, restartdir::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:625

Arguments:

  * `evalmat::Array` : saved array
  * `matname::AbstractString` : matrix (array) name (defines the name of the loaded file)
  * `restartdir::AbstractString` : directory where files will be stored containing model results for fast simulation restarts


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L617-L621' class='documenter-source'>source</a><br>

<a id='Mads.scatterplotsamples-Tuple{AbstractDict, AbstractMatrix, AbstractString}' href='#Mads.scatterplotsamples-Tuple{AbstractDict, AbstractMatrix, AbstractString}'>#</a>
**`Mads.scatterplotsamples`** &mdash; *Method*.



Create histogram/scatter plots of model parameter samples

Methods:

  * `Mads.scatterplotsamples(madsdata::AbstractDict, samples::AbstractMatrix, filename::AbstractString; np, format, pointsize, major_label_font_size, minor_label_font_size, highlight_width, dpi)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:434

Arguments:

  * `filename::AbstractString` : output file name
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `samples::AbstractMatrix` : matrix with model parameters

Keywords:

  * `dpi`
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `highlight_width`
  * `major_label_font_size`
  * `minor_label_font_size`
  * `np`
  * `pointsize` : point size [default=`0.9Gadfly.mm`]

Dumps:

  * histogram/scatter plots of model parameter samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L420-L428' class='documenter-source'>source</a><br>

<a id='Mads.searchdir' href='#Mads.searchdir'>#</a>
**`Mads.searchdir`** &mdash; *Function*.



Get files in the current directory or in a directory defined by `path` matching pattern `key` which can be a string or regular expression

Methods:

  * `Mads.searchdir(key::AbstractString; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:842
  * `Mads.searchdir(key::Regex; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:841

Arguments:

  * `key::AbstractString` : matching pattern for Mads input files (string or regular expression accepted)
  * `key::Regex` : matching pattern for Mads input files (string or regular expression accepted)

Keywords:

  * `path` : search directory for the mads input files [default=`.`]

Returns:

  * `filename` : an array with file names matching the pattern in the specified directory

Examples:

```julia
- `Mads.searchdir("a")`
- `Mads.searchdir(r"[A-B]"; path = ".")`
- `Mads.searchdir(r".*.cov"; path = ".")`
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L844-L860' class='documenter-source'>source</a><br>

<a id='Mads.set_nprocs_per_task' href='#Mads.set_nprocs_per_task'>#</a>
**`Mads.set_nprocs_per_task`** &mdash; *Function*.



Set number of processors needed for each parallel task at each node

Methods:

  * `Mads.set_nprocs_per_task()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:66
  * `Mads.set_nprocs_per_task(local_nprocs_per_task::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:66

Arguments:

  * `local_nprocs_per_task::Integer`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L61-L65' class='documenter-source'>source</a><br>

<a id='Mads.setallparamsoff!-Tuple{AbstractDict}' href='#Mads.setallparamsoff!-Tuple{AbstractDict}'>#</a>
**`Mads.setallparamsoff!`** &mdash; *Method*.



Set all parameters OFF

Methods:

  * `Mads.setallparamsoff!(madsdata::AbstractDict; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:467

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `filter` : parameter filter


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L460-L464' class='documenter-source'>source</a><br>

<a id='Mads.setallparamson!-Tuple{AbstractDict}' href='#Mads.setallparamson!-Tuple{AbstractDict}'>#</a>
**`Mads.setallparamson!`** &mdash; *Method*.



Set all parameters ON

Methods:

  * `Mads.setallparamson!(madsdata::AbstractDict; filter)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:453

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary

Keywords:

  * `filter` : parameter filter


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L446-L450' class='documenter-source'>source</a><br>

<a id='Mads.setdebuglevel-Tuple{Int64}' href='#Mads.setdebuglevel-Tuple{Int64}'>#</a>
**`Mads.setdebuglevel`** &mdash; *Method*.



Set MADS debug level

Methods:

  * `Mads.setdebuglevel(level::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:239

Arguments:

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L233-L237' class='documenter-source'>source</a><br>

<a id='Mads.setdefaultplotformat-Tuple{AbstractString}' href='#Mads.setdefaultplotformat-Tuple{AbstractString}'>#</a>
**`Mads.setdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)

Methods:

  * `Mads.setdefaultplotformat(format::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:19

Arguments:

  * `format::AbstractString` : plot format


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L13-L17' class='documenter-source'>source</a><br>

<a id='Mads.setdir' href='#Mads.setdir'>#</a>
**`Mads.setdir`** &mdash; *Function*.



Set the working directory (for parallel environments)

Methods:

  * `Mads.setdir()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:255
  * `Mads.setdir(dir)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:250

Arguments:

  * `dir` : directory

Example:

```julia
@Distributed.everywhere Mads.setdir()
@Distributed.everywhere Mads.setdir("/home/monty")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L260-L271' class='documenter-source'>source</a><br>

<a id='Mads.setdpi-Tuple{Integer}' href='#Mads.setdpi-Tuple{Integer}'>#</a>
**`Mads.setdpi`** &mdash; *Method*.



Set image dpi

Methods:

  * `Mads.setdpi(dpi::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:175

Arguments:

  * `dpi::Integer`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L170-L174' class='documenter-source'>source</a><br>

<a id='Mads.setexecutionwaittime-Tuple{Float64}' href='#Mads.setexecutionwaittime-Tuple{Float64}'>#</a>
**`Mads.setexecutionwaittime`** &mdash; *Method*.



Set maximum execution wait time for forward model runs in seconds

Methods:

  * `Mads.setexecutionwaittime(waitime::Float64)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:259

Arguments:

  * `waitime::Float64` : maximum execution wait time for forward model runs in seconds


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L253-L257' class='documenter-source'>source</a><br>

<a id='Mads.setmadsinputfile-Tuple{AbstractString}' href='#Mads.setmadsinputfile-Tuple{AbstractString}'>#</a>
**`Mads.setmadsinputfile`** &mdash; *Method*.



Set a default MADS input file

Methods:

  * `Mads.setmadsinputfile(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:416

Arguments:

  * `filename::AbstractString` : input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L410-L414' class='documenter-source'>source</a><br>

<a id='Mads.setmadsservers' href='#Mads.setmadsservers'>#</a>
**`Mads.setmadsservers`** &mdash; *Function*.



Generate a list of Mads servers

Methods:

  * `Mads.setmadsservers()` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:340
  * `Mads.setmadsservers(first::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:340
  * `Mads.setmadsservers(first::Int64, last::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:340

Arguments:

  * `first::Int64` : first [default=`0`]
  * `last::Int64` : last [default=`18`]

Returns

  * array string of mads servers


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L331-L338' class='documenter-source'>source</a><br>

<a id='Mads.setmodelinputs' href='#Mads.setmodelinputs'>#</a>
**`Mads.setmodelinputs`** &mdash; *Function*.



Set model input files; delete files where model output should be saved for MADS

Methods:

  * `Mads.setmodelinputs(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:724
  * `Mads.setmodelinputs(madsdata::AbstractDict, parameters::AbstractDict; path)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:724

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameters::AbstractDict` : parameters

Keywords:

  * `path` : path for the files [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L716-L720' class='documenter-source'>source</a><br>

<a id='Mads.setnewmadsfilename' href='#Mads.setnewmadsfilename'>#</a>
**`Mads.setnewmadsfilename`** &mdash; *Function*.



Set new mads file name

Methods:

  * `Mads.setnewmadsfilename(filename::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:579
  * `Mads.setnewmadsfilename(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:576

Arguments:

  * `filename::AbstractString` : file name
  * `madsdata::AbstractDict` : MADS problem dictionary

Returns:

  * new file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L594-L602' class='documenter-source'>source</a><br>

<a id='Mads.setobservationtargets!-Tuple{AbstractDict, AbstractDict}' href='#Mads.setobservationtargets!-Tuple{AbstractDict, AbstractDict}'>#</a>
**`Mads.setobservationtargets!`** &mdash; *Method*.



Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary

Methods:

  * `Mads.setobservationtargets!(madsdata::AbstractDict, predictions::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:539

Arguments:

  * `madsdata::AbstractDict` : Mads problem dictionary
  * `predictions::AbstractDict` : dictionary with model predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L532-L536' class='documenter-source'>source</a><br>

<a id='Mads.setobstime!' href='#Mads.setobstime!'>#</a>
**`Mads.setobstime!`** &mdash; *Function*.



Set observation time based on the observation name in the MADS problem dictionary

Methods:

  * `Mads.setobstime!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:250
  * `Mads.setobstime!(madsdata::AbstractDict, rx::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:260
  * `Mads.setobstime!(madsdata::AbstractDict, rx::Regex, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:260
  * `Mads.setobstime!(madsdata::AbstractDict, separator::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:250
  * `Mads.setobstime!(madsdata::AbstractDict, separator::AbstractString, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:250

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector`
  * `rx::Regex` : regular expression to match
  * `separator::AbstractString` : separator [default=`_`]

Examples:

```julia
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L271-L282' class='documenter-source'>source</a><br>

<a id='Mads.setobsweights!' href='#Mads.setobsweights!'>#</a>
**`Mads.setobsweights!`** &mdash; *Function*.



Set observation weights in the MADS problem dictionary

Methods:

  * `Mads.setobsweights!(madsdata::AbstractDict, v::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:292
  * `Mads.setobsweights!(madsdata::AbstractDict, v::AbstractVector, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:292
  * `Mads.setobsweights!(madsdata::AbstractDict, value::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:287
  * `Mads.setobsweights!(madsdata::AbstractDict, value::Number, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:287

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector`
  * `v::AbstractVector` : vector of observation weights
  * `value::Number` : value for observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L298-L302' class='documenter-source'>source</a><br>

<a id='Mads.setparamoff!-Tuple{AbstractDict, AbstractString}' href='#Mads.setparamoff!-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.setparamoff!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` OFF

Methods:

  * `Mads.setparamoff!(madsdata::AbstractDict, parameterkey::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:492

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameterkey::AbstractString` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L485-L489' class='documenter-source'>source</a><br>

<a id='Mads.setparamon!-Tuple{AbstractDict, AbstractString}' href='#Mads.setparamon!-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.setparamon!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` ON

Methods:

  * `Mads.setparamon!(madsdata::AbstractDict, parameterkey::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:481

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameterkey::AbstractString` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L474-L478' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistnormal!-Tuple{AbstractDict, AbstractVector, AbstractVector}' href='#Mads.setparamsdistnormal!-Tuple{AbstractDict, AbstractVector, AbstractVector}'>#</a>
**`Mads.setparamsdistnormal!`** &mdash; *Method*.



Set normal parameter distributions for all the model parameters in the MADS problem dictionary

Methods:

  * `Mads.setparamsdistnormal!(madsdata::AbstractDict, mean::AbstractVector, stddev::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:504

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `mean::AbstractVector` : array with the mean values
  * `stddev::AbstractVector` : array with the standard deviation values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L496-L500' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistuniform!-Tuple{AbstractDict, AbstractVector, AbstractVector}' href='#Mads.setparamsdistuniform!-Tuple{AbstractDict, AbstractVector, AbstractVector}'>#</a>
**`Mads.setparamsdistuniform!`** &mdash; *Method*.



Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

Methods:

  * `Mads.setparamsdistuniform!(madsdata::AbstractDict, min::AbstractVector, max::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:519

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `max::AbstractVector` : array with the maximum values
  * `min::AbstractVector` : array with the minimum values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L511-L515' class='documenter-source'>source</a><br>

<a id='Mads.setparamsinit!' href='#Mads.setparamsinit!'>#</a>
**`Mads.setparamsinit!`** &mdash; *Function*.



Set initial optimized parameter guesses in the MADS problem dictionary

Methods:

  * `Mads.setparamsinit!(madsdata::AbstractDict, paramdict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:320
  * `Mads.setparamsinit!(madsdata::AbstractDict, paramdict::AbstractDict, idx::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:320

Arguments:

  * `idx::Int64` : index of the dictionary of arrays with initial model parameter values
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramdict::AbstractDict` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L311-L315' class='documenter-source'>source</a><br>

<a id='Mads.setplotfileformat-Tuple{AbstractString, AbstractString}' href='#Mads.setplotfileformat-Tuple{AbstractString, AbstractString}'>#</a>
**`Mads.setplotfileformat`** &mdash; *Method*.



Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

Methods:

  * `Mads.setplotfileformat(filename::AbstractString, format::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:48

Arguments:

  * `filename::AbstractString` : output file name
  * `format::AbstractString` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]

Returns:

  * output file name
  * output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L36-L45' class='documenter-source'>source</a><br>

<a id='Mads.setprocs' href='#Mads.setprocs'>#</a>
**`Mads.setprocs`** &mdash; *Function*.



Set the available processors based on environmental variables (supports SLURM only at the moment)

Methods:

  * `Mads.setprocs(; ntasks_per_node, nprocs_per_task, nodenames, mads_servers, test, quiet, veryquiet, dir, exename)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:48
  * `Mads.setprocs(np::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:45
  * `Mads.setprocs(np::Integer, nt::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsParallel.jl:32

Arguments:

  * `np::Integer` : number of processors [default=`1`]
  * `nt::Integer` : number of threads[default=`1`]

Keywords:

  * `dir` : common directory shared by all the jobs
  * `exename` : location of the julia executable (the same version of julia is needed on all the workers)
  * `mads_servers` : if `true` use MADS servers [default=`false`]
  * `nodenames` : array with names of machines/nodes to be invoked
  * `nprocs_per_task` : number of processors needed for each parallel task at each node [default=`Mads.nprocs_per_task`]
  * `ntasks_per_node` : number of parallel tasks per node [default=`0`]
  * `quiet` : suppress output [default=`Mads.quiet`]
  * `test` : test the servers and connect to each one ones at a time [default=`false`]
  * `veryquiet`

Returns:

  * vector with names of compute nodes (hosts)

Example:

```julia
Mads.setprocs()
Mads.setprocs(4)
Mads.setprocs(4, 8)
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=madsservers)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParallel.jl#L164-L186' class='documenter-source'>source</a><br>

<a id='Mads.setseed' href='#Mads.setseed'>#</a>
**`Mads.setseed`** &mdash; *Function*.



Set / get current random seed. seed < 0 gets seed, anything else sets it.

Methods:

  * `Mads.setseed()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:480
  * `Mads.setseed(seed::Integer)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:480
  * `Mads.setseed(seed::Integer, quiet::Bool; rng)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:480

Arguments:

  * `quiet::Bool` : [default=`true`]
  * `seed::Integer` : random seed

Keywords:

  * `rng`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L473-L477' class='documenter-source'>source</a><br>

<a id='Mads.setsourceinit!' href='#Mads.setsourceinit!'>#</a>
**`Mads.setsourceinit!`** &mdash; *Function*.



Set initial optimized parameter guesses in the MADS problem dictionary for the Source class

Methods:

  * `Mads.setparamsinit!(madsdata::AbstractDict, paramdict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:320
  * `Mads.setparamsinit!(madsdata::AbstractDict, paramdict::AbstractDict, idx::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:320

Arguments:

  * `idx::Int64` : index of the dictionary of arrays with initial model parameter values
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `paramdict::AbstractDict` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L334-L338' class='documenter-source'>source</a><br>

<a id='Mads.settarget!-Tuple{AbstractDict, Number}' href='#Mads.settarget!-Tuple{AbstractDict, Number}'>#</a>
**`Mads.settarget!`** &mdash; *Method*.



Set observation target

Methods:

  * `Mads.settarget!(o::AbstractDict, target::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:240

Arguments:

  * `o::AbstractDict` : observation data
  * `target::Number` : observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L233-L237' class='documenter-source'>source</a><br>

<a id='Mads.settime!-Tuple{AbstractDict, Number}' href='#Mads.settime!-Tuple{AbstractDict, Number}'>#</a>
**`Mads.settime!`** &mdash; *Method*.



Set observation time

Methods:

  * `Mads.settime!(o::AbstractDict, time::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:162

Arguments:

  * `o::AbstractDict` : observation data
  * `time::Number` : observation time


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L155-L159' class='documenter-source'>source</a><br>

<a id='Mads.setverbositylevel-Tuple{Int64}' href='#Mads.setverbositylevel-Tuple{Int64}'>#</a>
**`Mads.setverbositylevel`** &mdash; *Method*.



Set MADS verbosity level

Methods:

  * `Mads.setverbositylevel(level::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:249

Arguments:

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L243-L247' class='documenter-source'>source</a><br>

<a id='Mads.setweight!-Tuple{AbstractDict, Number}' href='#Mads.setweight!-Tuple{AbstractDict, Number}'>#</a>
**`Mads.setweight!`** &mdash; *Method*.



Set observation weight

Methods:

  * `Mads.setweight!(o::AbstractDict, weight::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:201

Arguments:

  * `o::AbstractDict` : observation data
  * `weight::Number` : observation weight


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L194-L198' class='documenter-source'>source</a><br>

<a id='Mads.setwellweights!' href='#Mads.setwellweights!'>#</a>
**`Mads.setwellweights!`** &mdash; *Function*.



Set well weights in the MADS problem dictionary

Methods:

  * `Mads.setwellweights!(madsdata::AbstractDict, value::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:343
  * `Mads.setwellweights!(madsdata::AbstractDict, value::Number, wellkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:343

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `value::Number` : value for well weights
  * `wellkeys::AbstractVector`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L336-L340' class='documenter-source'>source</a><br>

<a id='Mads.showallparameters' href='#Mads.showallparameters'>#</a>
**`Mads.showallparameters`** &mdash; *Function*.



Show all parameters in the MADS problem dictionary

Methods:

  * `Mads.showallparameters(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:580
  * `Mads.showallparameters(madsdata::AbstractDict, parkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:580
  * `Mads.showallparameters(madsdata::AbstractDict, result::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:584

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parkeys::AbstractVector`
  * `result::AbstractDict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L589-L593' class='documenter-source'>source</a><br>

<a id='Mads.showobservations' href='#Mads.showobservations'>#</a>
**`Mads.showobservations`** &mdash; *Function*.



Show observations in the MADS problem dictionary

Methods:

  * `Mads.showobservations(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:399
  * `Mads.showobservations(madsdata::AbstractDict, obskeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:399

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `obskeys::AbstractVector`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L393-L397' class='documenter-source'>source</a><br>

<a id='Mads.showparameters' href='#Mads.showparameters'>#</a>
**`Mads.showparameters`** &mdash; *Function*.



Show parameters in the MADS problem dictionary

Methods:

  * `Mads.showparameters(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:566
  * `Mads.showparameters(madsdata::AbstractDict, parkeys::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:566
  * `Mads.showparameters(madsdata::AbstractDict, parkeys::AbstractVector, all::Bool)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:566
  * `Mads.showparameters(madsdata::AbstractDict, result::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsParameters.jl:561

Arguments:

  * `all::Bool`
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parkeys::AbstractVector`
  * `result::AbstractDict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsParameters.jl#L573-L577' class='documenter-source'>source</a><br>

<a id='Mads.sinetransform' href='#Mads.sinetransform'>#</a>
**`Mads.sinetransform`** &mdash; *Function*.



Sine transformation of model parameters

Methods:

  * `Mads.sinetransform(madsdata::AbstractDict, params::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:35
  * `Mads.sinetransform(sineparams::AbstractVector, lowerbounds::AbstractVector, upperbounds::AbstractVector, indexlogtransformed::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:45

Arguments:

  * `indexlogtransformed::AbstractVector` : index vector of log-transformed parameters
  * `lowerbounds::AbstractVector` : lower bounds
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `params::AbstractVector`
  * `sineparams::AbstractVector` : model parameters
  * `upperbounds::AbstractVector` : upper bounds

Returns:

  * Sine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSineTransformations.jl#L51-L59' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformfunction-Tuple{Function, AbstractVector, AbstractVector, AbstractVector}' href='#Mads.sinetransformfunction-Tuple{Function, AbstractVector, AbstractVector, AbstractVector}'>#</a>
**`Mads.sinetransformfunction`** &mdash; *Method*.



Sine transformation of a function

Methods:

  * `Mads.sinetransformfunction(f::Function, lowerbounds::AbstractVector, upperbounds::AbstractVector, indexlogtransformed::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:79

Arguments:

  * `f::Function` : function
  * `indexlogtransformed::AbstractVector` : index vector of log-transformed parameters
  * `lowerbounds::AbstractVector` : lower bounds
  * `upperbounds::AbstractVector` : upper bounds

Returns:

  * Sine transformation


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSineTransformations.jl#L66-L74' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformgradient-Tuple{Function, AbstractVector, AbstractVector, AbstractVector}' href='#Mads.sinetransformgradient-Tuple{Function, AbstractVector, AbstractVector, AbstractVector}'>#</a>
**`Mads.sinetransformgradient`** &mdash; *Method*.



Sine transformation of a gradient function

Methods:

  * `Mads.sinetransformgradient(g::Function, lowerbounds::AbstractVector, upperbounds::AbstractVector, indexlogtransformed::AbstractVector; sindx)` : C:\Users\monty.julia\dev\Mads\src\MadsSineTransformations.jl:100

Arguments:

  * `g::Function` : gradient function
  * `indexlogtransformed::AbstractVector` : index vector of log-transformed parameters
  * `lowerbounds::AbstractVector` : vector with parameter lower bounds
  * `upperbounds::AbstractVector` : vector with parameter upper bounds

Keywords:

  * `sindx` : sin-space parameter step applied to compute numerical derivatives [default=`0.1`]

Returns:

  * Sine transformation of a gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSineTransformations.jl#L86-L94' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplot' href='#Mads.spaghettiplot'>#</a>
**`Mads.spaghettiplot`** &mdash; *Function*.



Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

Methods:

  * `Mads.spaghettiplot(madsdata::AbstractDict, dictarray::AbstractDict; seed, rng, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:831
  * `Mads.spaghettiplot(madsdata::AbstractDict, matrix::AbstractMatrix; plotdata, filename, keyword, format, title, xtitle, ytitle, yfit, obs_plot_dots, linewidth, pointsize, grayscale, xmin, xmax, ymin, ymax, quiet, colors)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:868
  * `Mads.spaghettiplot(madsdata::AbstractDict, number_of_samples::Integer; kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:827

Arguments:

  * `dictarray::AbstractDict` : dictionary array containing the data arrays to be plotted
  * `madsdata::AbstractDict` : MADS problem dictionary
  * `matrix::AbstractMatrix`
  * `number_of_samples::Integer` : number of samples

Keywords:

  * `colors`
  * `filename` : output file name used to output the produced plots
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `grayscale`
  * `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)
  * `linewidth` : width of the lines in plot [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)
  * `plotdata` : plot data (if `false` model predictions are plotted only) [default=`true`]
  * `pointsize` : size of the markers in plot [default=`4Gadfly.pt`]
  * `quiet`
  * `rng`
  * `seed` : random seed [default=`0`]
  * `title`
  * `xmax`
  * `xmin`
  * `xtitle` : `x` axis title [default=`X`]
  * `yfit` : fit vertical axis range [default=`false`]
  * `ymax`
  * `ymin`
  * `ytitle` : `y` axis title [default=`Y`]

Dumps:

  * Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplot(madsdata, dictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, array; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L992-L1008' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplots' href='#Mads.spaghettiplots'>#</a>
**`Mads.spaghettiplots`** &mdash; *Function*.



Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

Methods:

  * `Mads.spaghettiplots(madsdata::AbstractDict, number_of_samples::Integer; seed, rng, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:676
  * `Mads.spaghettiplots(madsdata::AbstractDict, paramdictarray::OrderedCollections.OrderedDict; format, keyword, xtitle, ytitle, obs_plot_dots, seed, rng, linewidth, pointsize, grayscale, quiet)` : C:\Users\monty.julia\dev\Mads\src\MadsPlot.jl:681

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `number_of_samples::Integer` : number of samples
  * `paramdictarray::OrderedCollections.OrderedDict` : parameter dictionary containing the data arrays to be plotted

Keywords:

  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `grayscale`
  * `keyword` : keyword to be added in the file name used to output the produced plots
  * `linewidth` : width of the lines on the plot [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` (default) or `false`)
  * `pointsize` : size of the markers on the plot [default=`4Gadfly.pt`]
  * `quiet`
  * `rng`
  * `seed` : random seed [default=`0`]
  * `xtitle` : `x` axis title [default=`X`]
  * `ytitle` : `y` axis title [default=`Y`]

Dumps:

  * A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPlot.jl#L799-L814' class='documenter-source'>source</a><br>

<a id='Mads.sphericalcov-Tuple{Number, Number, Number}' href='#Mads.sphericalcov-Tuple{Number, Number, Number}'>#</a>
**`Mads.sphericalcov`** &mdash; *Method*.



Spherical spatial covariance function

Methods:

  * `Mads.sphericalcov(h::Number, maxcov::Number, scale::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:45

Arguments:

  * `h::Number` : separation distance
  * `maxcov::Number` : max covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L33-L41' class='documenter-source'>source</a><br>

<a id='Mads.sphericalvariogram-NTuple{4, Number}' href='#Mads.sphericalvariogram-NTuple{4, Number}'>#</a>
**`Mads.sphericalvariogram`** &mdash; *Method*.



Spherical variogram

Methods:

  * `Mads.sphericalvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : C:\Users\monty.julia\dev\Mads\src\MadsKriging.jl:60

Arguments:

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Spherical variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsKriging.jl#L47-L55' class='documenter-source'>source</a><br>

<a id='Mads.sprintf-Tuple' href='#Mads.sprintf-Tuple'>#</a>
**`Mads.sprintf`** &mdash; *Method*.



Convert `@Printf.sprintf` macro into `sprintf` function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMisc.jl#L192' class='documenter-source'>source</a><br>

<a id='Mads.status' href='#Mads.status'>#</a>
**`Mads.status`** &mdash; *Function*.



Status of Mads modules

Methods:

  * `Mads.status(; git, gitmore)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:251
  * `Mads.status(madsmodule::AbstractString; git, gitmore)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:256

Arguments:

  * `madsmodule::AbstractString` : mads module

Keywords:

  * `git` : use git [default=`true` or `Mads.madsgit`]
  * `gitmore` : use even more git [default=`false`]

Returns:

  * `true` or `false`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L308-L316' class='documenter-source'>source</a><br>

<a id='Mads.stderrcaptureoff-Tuple{}' href='#Mads.stderrcaptureoff-Tuple{}'>#</a>
**`Mads.stderrcaptureoff`** &mdash; *Method*.



Restore stderr

Methods:

  * `Mads.stderrcaptureoff()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:139

Returns:

  * standered error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L130-L138' class='documenter-source'>source</a><br>

<a id='Mads.stderrcaptureon-Tuple{}' href='#Mads.stderrcaptureon-Tuple{}'>#</a>
**`Mads.stderrcaptureon`** &mdash; *Method*.



Redirect stderr to a reader

Methods:

  * `Mads.stderrcaptureon()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:120


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L115-L119' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureoff-Tuple{}' href='#Mads.stdoutcaptureoff-Tuple{}'>#</a>
**`Mads.stdoutcaptureoff`** &mdash; *Method*.



Restore stdout

Methods:

  * `Mads.stdoutcaptureoff()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:105

Returns:

  * standered output


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L96-L104' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureon-Tuple{}' href='#Mads.stdoutcaptureon-Tuple{}'>#</a>
**`Mads.stdoutcaptureon`** &mdash; *Method*.



Redirect stdout to a reader

Methods:

  * `Mads.stdoutcaptureon()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:86


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L81-L85' class='documenter-source'>source</a><br>

<a id='Mads.stdouterrcaptureoff-Tuple{}' href='#Mads.stdouterrcaptureoff-Tuple{}'>#</a>
**`Mads.stdouterrcaptureoff`** &mdash; *Method*.



Restore stdout & stderr

Methods:

  * `Mads.stdouterrcaptureoff()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:170

Returns:

  * standered output amd standered error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L161-L169' class='documenter-source'>source</a><br>

<a id='Mads.stdouterrcaptureon-Tuple{}' href='#Mads.stdouterrcaptureon-Tuple{}'>#</a>
**`Mads.stdouterrcaptureon`** &mdash; *Method*.



Redirect stdout & stderr to readers

Methods:

  * `Mads.stdouterrcaptureon()` : C:\Users\monty.julia\dev\Mads\src\MadsCapture.jl:154


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L149-L153' class='documenter-source'>source</a><br>

<a id='Mads.svrdump-Tuple{Vector{SVR.svmmodel}, AbstractString, Int64}' href='#Mads.svrdump-Tuple{Vector{SVR.svmmodel}, AbstractString, Int64}'>#</a>
**`Mads.svrdump`** &mdash; *Method*.



Dump SVR models in files

Methods:

  * `Mads.svrdump(svrmodel::Vector{SVR.svmmodel}, rootname::AbstractString, numberofsamples::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:137

Arguments:

  * `numberofsamples::Int64` : number of samples
  * `rootname::AbstractString` : root name
  * `svrmodel::Vector{SVR.svmmodel}` : array of SVR models


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L129-L133' class='documenter-source'>source</a><br>

<a id='Mads.svrfree-Tuple{Vector{SVR.svmmodel}}' href='#Mads.svrfree-Tuple{Vector{SVR.svmmodel}}'>#</a>
**`Mads.svrfree`** &mdash; *Method*.



Free SVR

Methods:

  * `Mads.svrfree(svrmodel::Vector{SVR.svmmodel})` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:119

Arguments:

  * `svrmodel::Vector{SVR.svmmodel}` : array of SVR models


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L113-L117' class='documenter-source'>source</a><br>

<a id='Mads.svrload-Tuple{Int64, AbstractString, Int64}' href='#Mads.svrload-Tuple{Int64, AbstractString, Int64}'>#</a>
**`Mads.svrload`** &mdash; *Method*.



Load SVR models from files

Methods:

  * `Mads.svrload(npred::Int64, rootname::AbstractString, numberofsamples::Int64)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:160

Arguments:

  * `npred::Int64` : number of model predictions
  * `numberofsamples::Int64` : number of samples
  * `rootname::AbstractString` : root name

Returns:

  * Array of SVR models for each model prediction


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L148-L156' class='documenter-source'>source</a><br>

<a id='Mads.svrprediction' href='#Mads.svrprediction'>#</a>
**`Mads.svrprediction`** &mdash; *Function*.



Predict SVR

Methods:

  * `Mads.svrprediction(svrmodel::Vector{SVR.svmmodel}, paramarray::Matrix{Float64})` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:93

Arguments:

  * `paramarray::Matrix{Float64}` : parameter array
  * `svrmodel::Vector{SVR.svmmodel}` : array of SVR models

Returns:

  * SVR predicted observations (dependent variables) for a given set of parameters (independent variables)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L101-L109' class='documenter-source'>source</a><br>

<a id='Mads.svrtraining' href='#Mads.svrtraining'>#</a>
**`Mads.svrtraining`** &mdash; *Function*.



Train SVR

Methods:

  * `Mads.svrtraining(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:38
  * `Mads.svrtraining(madsdata::AbstractDict, numberofsamples::Integer; addminmax, kw...)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:38
  * `Mads.svrtraining(madsdata::AbstractDict, paramarray::Matrix{Float64}; check, savesvr, addminmax, svm_type, kernel_type, degree, gamma, coef0, C, nu, cache_size, epsilon, shrinking, probability, verbose, tol)` : C:\Users\monty.julia\dev\Mads\src\MadsSVR.jl:5

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random samples in the training set [default=`100`]
  * `paramarray::Matrix{Float64}`

Keywords:

  * `C` : cost; penalty parameter of the error term [default=`1000.0`]
  * `addminmax` : add parameter minimum / maximum range values in the training set [default=`true`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `check` : check SVR performance [default=`false`]
  * `coef0` : independent term in kernel function; important only in POLY and SIGMOND kernel types [default=`0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `epsilon` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]
  * `gamma` : coefficient for RBF, POLY and SIGMOND kernel types [default=`1/numberofsamples`]
  * `kernel_type` : kernel type[default=`SVR.RBF`]
  * `nu` : upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]
  * `probability` : train to estimate probabilities [default=`false`]
  * `savesvr` : save SVR models [default=`false`]
  * `shrinking` : apply shrinking heuristic [default=`true`]
  * `svm_type` : SVM type [default=`SVR.EPSILON_SVR`]
  * `tol` : tolerance of termination criterion [default=`0.001`]
  * `verbose` : verbose output [default=`false`]

Returns:

  * Array of SVR models


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSVR.jl#L53-L61' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdir-Tuple{AbstractString, AbstractString, AbstractString}' href='#Mads.symlinkdir-Tuple{AbstractString, AbstractString, AbstractString}'>#</a>
**`Mads.symlinkdir`** &mdash; *Method*.



Create a symbolic link of a file `filename` in a directory `dirtarget`

Methods:

  * `Mads.symlinkdir(filename::AbstractString, dirtarget::AbstractString, dirsource::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1246

Arguments:

  * `dirsource::AbstractString`
  * `dirtarget::AbstractString` : target directory
  * `filename::AbstractString` : file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1239-L1243' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdirfiles-Tuple{AbstractString, AbstractString}' href='#Mads.symlinkdirfiles-Tuple{AbstractString, AbstractString}'>#</a>
**`Mads.symlinkdirfiles`** &mdash; *Method*.



Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`

Methods:

  * `Mads.symlinkdirfiles(dirsource::AbstractString, dirtarget::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:1228

Arguments:

  * `dirsource::AbstractString` : source directory
  * `dirtarget::AbstractString` : target directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L1221-L1225' class='documenter-source'>source</a><br>

<a id='Mads.tag' href='#Mads.tag'>#</a>
**`Mads.tag`** &mdash; *Function*.



Tag Mads modules with a default argument `:patch`

Methods:

  * `Mads.tag()` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:321
  * `Mads.tag(madsmodule::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:326
  * `Mads.tag(madsmodule::AbstractString, versionsym::Symbol)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:326
  * `Mads.tag(versionsym::Symbol)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:321

Arguments:

  * `madsmodule::AbstractString` : mads module name
  * `versionsym::Symbol` : version symbol [default=`:patch`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L346-L350' class='documenter-source'>source</a><br>

<a id='Mads.test' href='#Mads.test'>#</a>
**`Mads.test`** &mdash; *Function*.



Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

Methods:

  * `Mads.test()` : C:\Users\monty.julia\dev\Mads\src\MadsTest.jl:38
  * `Mads.test(testname::AbstractString; madstest, plotting)` : C:\Users\monty.julia\dev\Mads\src\MadsTest.jl:38

Arguments:

  * `testname::AbstractString` : name of the test to execute; module or example

Keywords:

  * `madstest` : test Mads [default=`true`]
  * `plotting`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTest.jl#L31-L35' class='documenter-source'>source</a><br>

<a id='Mads.testj' href='#Mads.testj'>#</a>
**`Mads.testj`** &mdash; *Function*.



Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)

Methods:

  * `Mads.testj()` : C:\Users\monty.julia\dev\Mads\src\MadsTest.jl:9
  * `Mads.testj(coverage::Bool)` : C:\Users\monty.julia\dev\Mads\src\MadsTest.jl:9

Arguments:

  * `coverage::Bool` : [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTest.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.transposematrix-Tuple{AbstractMatrix}' href='#Mads.transposematrix-Tuple{AbstractMatrix}'>#</a>
**`Mads.transposematrix`** &mdash; *Method*.



Transpose non-numeric matrix

Methods:

  * `Mads.transposematrix(a::AbstractMatrix)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:428

Arguments:

  * `a::AbstractMatrix` : matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L422-L426' class='documenter-source'>source</a><br>

<a id='Mads.transposevector-Tuple{AbstractVector}' href='#Mads.transposevector-Tuple{AbstractVector}'>#</a>
**`Mads.transposevector`** &mdash; *Method*.



Transpose non-numeric vector

Methods:

  * `Mads.transposevector(a::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:418

Arguments:

  * `a::AbstractVector` : vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L412-L416' class='documenter-source'>source</a><br>

<a id='Mads.untag-Tuple{AbstractString, AbstractString}' href='#Mads.untag-Tuple{AbstractString, AbstractString}'>#</a>
**`Mads.untag`** &mdash; *Method*.



Untag specific version

Methods:

  * `Mads.untag(madsmodule::AbstractString, version::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsPublish.jl:361

Arguments:

  * `madsmodule::AbstractString` : mads module name
  * `version::AbstractString` : version


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsPublish.jl#L354-L358' class='documenter-source'>source</a><br>

<a id='Mads.vectoroff-Tuple{}' href='#Mads.vectoroff-Tuple{}'>#</a>
**`Mads.vectoroff`** &mdash; *Method*.



MADS vector calls off

Methods:

  * `Mads.vectoroff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:57


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L52-L56' class='documenter-source'>source</a><br>

<a id='Mads.vectoron-Tuple{}' href='#Mads.vectoron-Tuple{}'>#</a>
**`Mads.vectoron`** &mdash; *Method*.



MADS vector calls on

Methods:

  * `Mads.vectoron()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:48


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L43-L47' class='documenter-source'>source</a><br>

<a id='Mads.veryquietoff-Tuple{}' href='#Mads.veryquietoff-Tuple{}'>#</a>
**`Mads.veryquietoff`** &mdash; *Method*.



Make MADS not very quiet

Methods:

  * `Mads.veryquietoff()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:130


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L125-L129' class='documenter-source'>source</a><br>

<a id='Mads.veryquieton-Tuple{}' href='#Mads.veryquieton-Tuple{}'>#</a>
**`Mads.veryquieton`** &mdash; *Method*.



Make MADS very quiet

Methods:

  * `Mads.veryquieton()` : C:\Users\monty.julia\dev\Mads\src\MadsHelpers.jl:121


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsHelpers.jl#L116-L120' class='documenter-source'>source</a><br>

<a id='Mads.void2nan!-Tuple{AbstractDict}' href='#Mads.void2nan!-Tuple{AbstractDict}'>#</a>
**`Mads.void2nan!`** &mdash; *Method*.



Convert Nothing's into NaN's in a dictionary

Methods:

  * `Mads.void2nan!(dict::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:1049

Arguments:

  * `dict::AbstractDict` : dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L1043-L1047' class='documenter-source'>source</a><br>

<a id='Mads.weightedstats-Tuple{Array, AbstractVector}' href='#Mads.weightedstats-Tuple{Array, AbstractVector}'>#</a>
**`Mads.weightedstats`** &mdash; *Method*.



Get weighted mean and variance samples

Methods:

  * `Mads.weightedstats(samples::Array, llhoods::AbstractVector)` : C:\Users\monty.julia\dev\Mads\src\MadsSensitivityAnalysis.jl:388

Arguments:

  * `llhoods::AbstractVector` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * vector of sample means
  * vector of sample variances


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsSensitivityAnalysis.jl#L376-L385' class='documenter-source'>source</a><br>

<a id='Mads.welloff!-Tuple{AbstractDict, AbstractString}' href='#Mads.welloff!-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.welloff!`** &mdash; *Method*.



Turn off a specific well in the MADS problem dictionary

Methods:

  * `Mads.welloff!(madsdata::AbstractDict, wellname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:632

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `wellname::AbstractString` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L625-L629' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{AbstractDict, AbstractString}' href='#Mads.wellon!-Tuple{AbstractDict, AbstractString}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

Methods:

  * `Mads.wellon!(madsdata::AbstractDict, wellname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:574

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `wellname::AbstractString` : name of the well to be turned on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L567-L571' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{AbstractDict, Regex}' href='#Mads.wellon!-Tuple{AbstractDict, Regex}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

Methods:

  * `Mads.wellon!(madsdata::AbstractDict, rx::Regex)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:596
  * `Mads.wellon!(madsdata::AbstractDict, wellname::AbstractString)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:574

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `rx::Regex`
  * `wellname::AbstractString` : name of the well to be turned on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L589-L593' class='documenter-source'>source</a><br>

<a id='Mads.wells2observations!-Tuple{AbstractDict}' href='#Mads.wells2observations!-Tuple{AbstractDict}'>#</a>
**`Mads.wells2observations!`** &mdash; *Method*.



Convert `Wells` class to `Observations` class in the MADS problem dictionary

Methods:

  * `Mads.wells2observations!(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsObservations.jl:687

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsObservations.jl#L681-L685' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters' href='#Mads.writeparameters'>#</a>
**`Mads.writeparameters`** &mdash; *Function*.



Write model `parameters`

Methods:

  * `Mads.writeparameters(madsdata::AbstractDict)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:962
  * `Mads.writeparameters(madsdata::AbstractDict, parameters::AbstractDict; respect_space)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:962

Arguments:

  * `madsdata::AbstractDict` : MADS problem dictionary
  * `parameters::AbstractDict` : parameters

Keywords:

  * `respect_space` : respect provided space in the template file to fit model parameters [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L954-L958' class='documenter-source'>source</a><br>

<a id='Mads.writeparametersviatemplate-Tuple{Any, Any, Any}' href='#Mads.writeparametersviatemplate-Tuple{Any, Any, Any}'>#</a>
**`Mads.writeparametersviatemplate`** &mdash; *Method*.



Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)

Methods:

  * `Mads.writeparametersviatemplate(parameters, templatefilename, outputfilename; respect_space)` : C:\Users\monty.julia\dev\Mads\src\MadsIO.jl:906

Arguments:

  * `outputfilename` : output file name
  * `parameters` : parameters
  * `templatefilename` : tmplate file name

Keywords:

  * `respect_space` : respect provided space in the template file to fit model parameters [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsIO.jl#L897-L901' class='documenter-source'>source</a><br>

<a id='Mads.@stderrcapture-Tuple{Any}' href='#Mads.@stderrcapture-Tuple{Any}'>#</a>
**`Mads.@stderrcapture`** &mdash; *Macro*.



Capture stderr of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L27-L29' class='documenter-source'>source</a><br>

<a id='Mads.@stdoutcapture-Tuple{Any}' href='#Mads.@stdoutcapture-Tuple{Any}'>#</a>
**`Mads.@stdoutcapture`** &mdash; *Macro*.



Capture stdout of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L3-L5' class='documenter-source'>source</a><br>

<a id='Mads.@stdouterrcapture-Tuple{Any}' href='#Mads.@stdouterrcapture-Tuple{Any}'>#</a>
**`Mads.@stdouterrcapture`** &mdash; *Macro*.



Capture stderr & stderr of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsCapture.jl#L51-L53' class='documenter-source'>source</a><br>

<a id='Mads.@tryimport' href='#Mads.@tryimport'>#</a>
**`Mads.@tryimport`** &mdash; *Macro*.



Try to import a module in Mads


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTryImport.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.@tryimportmain-Tuple{Symbol}' href='#Mads.@tryimportmain-Tuple{Symbol}'>#</a>
**`Mads.@tryimportmain`** &mdash; *Macro*.



Try to import a module in Main


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsTryImport.jl#L27' class='documenter-source'>source</a><br>

<a id='Mads.MadsModel' href='#Mads.MadsModel'>#</a>
**`Mads.MadsModel`** &mdash; *Type*.



MadsModel type applied for MathOptInterface analyses


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/blob/d0875629ccfbe0d2c9c379a35e9b88db214fca44/src/MadsMathOptInterface.jl#L4-L6' class='documenter-source'>source</a><br>

