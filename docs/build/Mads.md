
<a id='Mads.jl-1'></a>

# Mads.jl


MADS (Model Analysis & Decision Support)


Mads.jl is MADS main module.


Mads.jl module functions:

<a id='Mads.MFlm-Tuple{Array{T,2},Integer}' href='#Mads.MFlm-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.MFlm`** &mdash; *Method*.



Matrix Factorization using Levenberg Marquardt

Methods

  * `Mads.MFlm(X::Array{T<:Any,2}, nk::Integer; mads, log_W, log_H, retries, maxiter, tol, initW, initH)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:122

Arguments

  * `X::Array{T<:Any,2}` : matrix to factorize
  * `nk::Integer` : number of features to extract

Keywords

  * `initH` : initial H (feature) matrix
  * `initW` : initial W (weight) matrix
  * `log_H` : log-transform H (feature) matrix[default=`false`]
  * `log_W` : log-transform W (weight) matrix [default=`false`]
  * `mads` : use MADS Levenberg-Marquardt algorithm [default=`true`]
  * `maxiter` : maximum number of iterations [default=`10000`]
  * `retries` : number of solution retries [default=`1`]
  * `tol` : solution tolerance [default=`1.0e-9`]

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsBSS.jl#L102-L110' class='documenter-source'>source</a><br>

<a id='Mads.NMFipopt' href='#Mads.NMFipopt'>#</a>
**`Mads.NMFipopt`** &mdash; *Function*.



Non-negative Matrix Factorization using JuMP/Ipopt

Methods

  * `Mads.NMFipopt(X::Array{T<:Any,2}, nk::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:61
  * `Mads.NMFipopt(X::Array{T<:Any,2}, nk::Integer, retries::Integer; random, maxiter, maxguess, verbosity, quiet, initW, initH)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:61

Arguments

  * `X::Array{T<:Any,2}` : matrix to factorize
  * `nk::Integer` : number of features to extract
  * `retries::Integer` : number of solution retries [default=`1`]

Keywords

  * `initH` : initial H (feature) matrix
  * `initW` : initial W (weight) matrix
  * `maxguess` : guess about the maximum for the H (feature) matrix [default=`1`]
  * `maxiter` : maximum number of iterations [default=`100000`]
  * `quiet` : quiet [default=`false`]
  * `random` : random initial guesses [default=`false`]
  * `verbosity` : verbosity output level [default=`0`]

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsBSS.jl#L40-L48' class='documenter-source'>source</a><br>

<a id='Mads.NMFm-Tuple{Array,Integer}' href='#Mads.NMFm-Tuple{Array,Integer}'>#</a>
**`Mads.NMFm`** &mdash; *Method*.



Non-negative Matrix Factorization using NMF

Methods

  * `Mads.NMFm(X::Array, nk::Integer; retries, maxiter, tol)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:22

Arguments

  * `X::Array` : matrix to factorize
  * `nk::Integer` : number of features to extract

Keywords

  * `maxiter` : maximum number of iterations [default=`10000`]
  * `retries` : number of solution retries [default=`1`]
  * `tol` : solution tolerance [default=`1.0e-9`]

Returns:

  * NMF results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsBSS.jl#L7-L15' class='documenter-source'>source</a><br>

<a id='Mads.addkeyword!' href='#Mads.addkeyword!'>#</a>
**`Mads.addkeyword!`** &mdash; *Function*.



Add a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.addkeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:209
  * `Mads.addkeyword!(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:213

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L226-L230' class='documenter-source'>source</a><br>

<a id='Mads.addsource!' href='#Mads.addsource!'>#</a>
**`Mads.addsource!`** &mdash; *Function*.



Add an additional contamination source

Methods

  * `Mads.addsource!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:19
  * `Mads.addsource!(madsdata::Associative, sourceid::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:19

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `sourceid::Int64` : source id [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.addsourceparameters!-Tuple{Associative}' href='#Mads.addsourceparameters!-Tuple{Associative}'>#</a>
**`Mads.addsourceparameters!`** &mdash; *Method*.



Add contaminant source parameters

Methods

  * `Mads.addsourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:69

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L62-L66' class='documenter-source'>source</a><br>

<a id='Mads.allwellsoff!-Tuple{Associative}' href='#Mads.allwellsoff!-Tuple{Associative}'>#</a>
**`Mads.allwellsoff!`** &mdash; *Method*.



Turn off all the wells in the MADS problem dictionary

Methods

  * `Mads.allwellsoff!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:597

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L590-L594' class='documenter-source'>source</a><br>

<a id='Mads.allwellson!-Tuple{Associative}' href='#Mads.allwellson!-Tuple{Associative}'>#</a>
**`Mads.allwellson!`** &mdash; *Method*.



Turn on all the wells in the MADS problem dictionary

Methods

  * `Mads.allwellson!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:539

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L532-L536' class='documenter-source'>source</a><br>

<a id='Mads.amanzi' href='#Mads.amanzi'>#</a>
**`Mads.amanzi`** &mdash; *Function*.



Execute Amanzi external groundwater flow and transport simulator

Methods

  * `Mads.amanzi(filename::String, nproc::Int64, quiet::Bool, observation_filename::String, setup::String; amanzi_exe)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsSimulators.jl:15
  * `Mads.amanzi(filename::String, nproc::Int64, quiet::Bool, observation_filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsSimulators.jl:15
  * `Mads.amanzi(filename::String, nproc::Int64, quiet::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsSimulators.jl:15
  * `Mads.amanzi(filename::String, nproc::Int64)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsSimulators.jl:15
  * `Mads.amanzi(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsSimulators.jl:15

Arguments

  * `filename::String` : amanzi input file name
  * `nproc::Int64` : number of processor to be used by Amanzi [default=`Mads.nprocs_per_task_default`]
  * `observation_filename::String` : Amanzi observation file name [default=`"observations.out"`]
  * `quiet::Bool` : suppress output [default=`Mads.quiet`]
  * `setup::String` : bash script to setup Amanzi environmental variables [default=`"source-amanzi-setup"`]

Keywords

  * `amanzi_exe` : full path to the Amanzi executable


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-external/MadsSimulators.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.amanzi_output_parser' href='#Mads.amanzi_output_parser'>#</a>
**`Mads.amanzi_output_parser`** &mdash; *Function*.



Parse Amanzi output provided in an external file (`filename`)

Methods

  * `Mads.amanzi_output_parser(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsParsers.jl:22
  * `Mads.amanzi_output_parser()` : /Users/monty/.julia/v0.5/Mads/src/../src-external/MadsParsers.jl:22

Arguments

  * `filename::String` : external file name [default=`"observations.out"`]

Returns:

  * dictionary with model observations following MADS requirements

Example:

```julia
Mads.amanzi_output_parser()
Mads.amanzi_output_parser("observations.out")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-external/MadsParsers.jl#L4-L19' class='documenter-source'>source</a><br>

<a id='Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.asinetransform`** &mdash; *Method*.



Arcsine transformation of model parameters

Methods

  * `Mads.asinetransform(params::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:17

Arguments

  * `indexlogtransformed::Array{T<:Any,1}` : index vector of log-transformed parameters
  * `lowerbounds::Array{T<:Any,1}` : lower bounds
  * `params::Array{T<:Any,1}` : model parameters
  * `upperbounds::Array{T<:Any,1}` : upper bounds

Returns:

  * Arcsine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSineTransformations.jl#L3-L11' class='documenter-source'>source</a><br>

<a id='Mads.bayessampling' href='#Mads.bayessampling'>#</a>
**`Mads.bayessampling`** &mdash; *Function*.



Bayesian Sampling

Methods

  * `Mads.bayessampling(madsdata::Associative; nsteps, burnin, thinning, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:78
  * `Mads.bayessampling(madsdata::Associative, numsequences::Integer; nsteps, burnin, thinning, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:99

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numsequences::Integer` : number of sequences executed in parallel

Keywords

  * `burnin` : number of initial realizations before the MCMC are recorded [default=`100`]
  * `nsteps` : number of final realizations in the chain [default=`1000`]
  * `seed` : random seed [default=`0`]
  * `thinning` : removal of any `thinning` realization [default=`1`]

Returns:

  * MCMC chain

Examples:

```julia
Mads.bayessampling(madsdata; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.bayessampling(madsdata, numsequences; nsteps=1000, burnin=100, thinning=1, seed=2016)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L107-L122' class='documenter-source'>source</a><br>

<a id='Mads.calibrate-Tuple{Associative}' href='#Mads.calibrate-Tuple{Associative}'>#</a>
**`Mads.calibrate`** &mdash; *Method*.



Calibrate Mads model using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Methods

  * `Mads.calibrate(madsdata::Associative; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, save_results, localsa)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:162

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa` : perform local sensitivity analysis [default=`false`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `save_results` : save intermediate results [default=`true`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function tolerance [default=`1e-3`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * model parameter dictionary with the optimal values at the minimum
  * optimization algorithm results (e.g. results.minimizer)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCalibrate.jl#L135-L146' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom' href='#Mads.calibraterandom'>#</a>
**`Mads.calibraterandom`** &mdash; *Function*.



Calibrate with random initial guesses

Methods

  * `Mads.calibraterandom(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:39
  * `Mads.calibraterandom(madsdata::Associative, numberofsamples::Integer; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, seed, quiet, all, save_results)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:39

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random initial samples [default=`1`]

Keywords

  * `all` : all model results are returned [default=`false`]
  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `quiet` : [default=`true`]
  * `save_results` : save intermediate results [default=`true`]
  * `seed` : random seed [default=`0`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function tolerance [default=`1e-3`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCalibrate.jl#L4-L20' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom_parallel' href='#Mads.calibraterandom_parallel'>#</a>
**`Mads.calibraterandom_parallel`** &mdash; *Function*.



Calibrate with random initial guesses in parallel

Methods

  * `Mads.calibraterandom_parallel(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:106
  * `Mads.calibraterandom_parallel(madsdata::Associative, numberofsamples::Integer; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, seed, quiet, save_results, localsa)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:106

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random initial samples [default=`1`]

Keywords

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa` : perform local sensitivity analysis [default=`false`]
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `quiet` : suppress output [default=`true`]
  * `save_results` : save intermediate results [default=`true`]
  * `seed` : random seed [default=`0`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function tolerance [default=`1e-3`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * vector with all objective function values
  * boolean vector (converged/not converged)
  * array with estimate model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCalibrate.jl#L77-L87' class='documenter-source'>source</a><br>

<a id='Mads.checkmodeloutputdirs-Tuple{Associative}' href='#Mads.checkmodeloutputdirs-Tuple{Associative}'>#</a>
**`Mads.checkmodeloutputdirs`** &mdash; *Method*.



Check the directories where model outputs should be saved for MADS

Methods

  * `Mads.checkmodeloutputdirs(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:588

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L577-L585' class='documenter-source'>source</a><br>

<a id='Mads.checknodedir' href='#Mads.checknodedir'>#</a>
**`Mads.checknodedir`** &mdash; *Function*.



Check if a directory is readable

Methods

  * `Mads.checknodedir(dir::String, waittime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:13
  * `Mads.checknodedir(dir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:13
  * `Mads.checknodedir(node::String, dir::String, waittime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:4
  * `Mads.checknodedir(node::String, dir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:4

Arguments

  * `dir::String` : directory
  * `node::String` : computational node name (e.g. `madsmax.lanl.gov`, `wf03`, or `127.0.0.1`)
  * `waittime::Float64` : wait time in seconds [default=`10`]

Returns:

  * `true` if the directory is readable, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsExecute.jl#L28-L36' class='documenter-source'>source</a><br>

<a id='Mads.checkout' href='#Mads.checkout'>#</a>
**`Mads.checkout`** &mdash; *Function*.



Checkout (pull) the latest version of Mads modules

Methods

  * `Mads.checkout(modulename::String; git, master, force, pull, required, all)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:79
  * `Mads.checkout()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:79

Arguments

  * `modulename::String` : module name

Keywords

  * `all` : whether to checkout all the modules [default=`false`]
  * `force` : whether to overwrite local changes when checkout [default=`false`]
  * `git` : whether to use "git checkout" [default=`true`]
  * `master` : whether on master branch [default=`false`]
  * `pull` : whether to run "git pull" [default=`true`]
  * `required` : whether only checkout Mads.required modules [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.checkparameterranges-Tuple{Associative}' href='#Mads.checkparameterranges-Tuple{Associative}'>#</a>
**`Mads.checkparameterranges`** &mdash; *Method*.



Check parameter ranges for model parameters

Methods

  * `Mads.checkparameterranges(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:701

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L694-L698' class='documenter-source'>source</a><br>

<a id='Mads.cleancoverage-Tuple{}' href='#Mads.cleancoverage-Tuple{}'>#</a>
**`Mads.cleancoverage`** &mdash; *Method*.



Remove Mads coverage files

Methods

  * `Mads.cleancoverage()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:24


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsTest.jl#L18-L22' class='documenter-source'>source</a><br>

<a id='Mads.cmadsins_obs-Tuple{Array{T,1},String,String}' href='#Mads.cmadsins_obs-Tuple{Array{T,1},String,String}'>#</a>
**`Mads.cmadsins_obs`** &mdash; *Method*.



Call C MADS ins_obs() function from MADS dynamic library

Methods

  * `Mads.cmadsins_obs(obsid::Array{T<:Any,1}, instructionfilename::String, inputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:40

Arguments

  * `inputfilename::String` : input file name
  * `instructionfilename::String` : instruction file name
  * `obsid::Array{T<:Any,1}` : observation id

Return:

  * observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-old/MadsCMads.jl#L27-L35' class='documenter-source'>source</a><br>

<a id='Mads.commit' href='#Mads.commit'>#</a>
**`Mads.commit`** &mdash; *Function*.



Commit the latest version of Mads modules in the repository

Methods

  * `Mads.commit(commitmsg::String, modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:209
  * `Mads.commit(commitmsg::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:209

Arguments

  * `commitmsg::String` : commit message
  * `modulename::String` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L201-L205' class='documenter-source'>source</a><br>

<a id='Mads.computemass' href='#Mads.computemass'>#</a>
**`Mads.computemass`** &mdash; *Function*.



Compute injected/reduced contaminant mass (for a given set of mads input files when "path" is provided)

Methods

  * `Mads.computemass(madsdata::Associative; time)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:447
  * `Mads.computemass(madsfiles::Union{Regex,String}; time, path)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:474

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `madsfiles::Union{Regex,String}` : matching pattern for Mads input files (string or regular expression accepted)

Keywords

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L494-L510' class='documenter-source'>source</a><br>

<a id='Mads.computeparametersensitities-Tuple{Associative,Associative}' href='#Mads.computeparametersensitities-Tuple{Associative,Associative}'>#</a>
**`Mads.computeparametersensitities`** &mdash; *Method*.



Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

Methods

  * `Mads.computeparametersensitities(madsdata::Associative, saresults::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:841

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `saresults::Associative` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L833-L837' class='documenter-source'>source</a><br>

<a id='Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Array{T,1},Function}' href='#Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Array{T,1},Function}'>#</a>
**`Mads.contamination`** &mdash; *Method*.



Compute concentration for a point in space and time (x,y,z,t)

Methods

  * `Mads.contamination(wellx::Number, welly::Number, wellz::Number, n::Number, lambda::Number, theta::Number, vx::Number, vy::Number, vz::Number, ax::Number, ay::Number, az::Number, H::Number, x::Number, y::Number, z::Number, dx::Number, dy::Number, dz::Number, f::Number, t0::Number, t1::Number, t::Array{T<:Any,1}, anasolfunction::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:417

Arguments

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
  * `t::Array{T<:Any,1}` : vector of times to compute concentration at the observation point
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L382-L390' class='documenter-source'>source</a><br>

<a id='Mads.copyaquifer2sourceparameters!-Tuple{Associative}' href='#Mads.copyaquifer2sourceparameters!-Tuple{Associative}'>#</a>
**`Mads.copyaquifer2sourceparameters!`** &mdash; *Method*.



Copy aquifer parameters to become contaminant source parameters

Methods

  * `Mads.copyaquifer2sourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:108

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L101-L105' class='documenter-source'>source</a><br>

<a id='Mads.copyright-Tuple{}' href='#Mads.copyright-Tuple{}'>#</a>
**`Mads.copyright`** &mdash; *Method*.



Produce MADS copyright information

Methods

  * `Mads.copyright()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:18


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelp.jl#L12-L16' class='documenter-source'>source</a><br>

<a id='Mads.create_documentation-Tuple{}' href='#Mads.create_documentation-Tuple{}'>#</a>
**`Mads.create_documentation`** &mdash; *Method*.



Create web documentation files for Mads functions

Methods

  * `Mads.create_documentation()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:346


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L340-L344' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_off-Tuple{}' href='#Mads.create_tests_off-Tuple{}'>#</a>
**`Mads.create_tests_off`** &mdash; *Method*.



Turn off the generation of MADS tests (default)

Methods

  * `Mads.create_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:110


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L104-L108' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_on-Tuple{}' href='#Mads.create_tests_on-Tuple{}'>#</a>
**`Mads.create_tests_on`** &mdash; *Method*.



Turn on the generation of MADS tests (dangerous)

Methods

  * `Mads.create_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:101


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L95-L99' class='documenter-source'>source</a><br>

<a id='Mads.createmadsobservations' href='#Mads.createmadsobservations'>#</a>
**`Mads.createmadsobservations`** &mdash; *Function*.



Create Mads dictionary of observations and instruction file

Methods

  * `Mads.createmadsobservations(nrow::Int64, ncol::Int64; obstring, pretext, prestring, poststring, filename)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:108
  * `Mads.createmadsobservations(nrow::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:108

Arguments

  * `ncol::Int64` : number of columns [default 1]
  * `nrow::Int64` : number of rows

Keywords

  * `filename` : file name
  * `obstring` : observation string
  * `poststring` : post instruction file string
  * `prestring` : pre instruction file string
  * `pretext` : preamble instructions

)

Returns:

  * observation dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCreate.jl#L90-L98' class='documenter-source'>source</a><br>

<a id='Mads.createmadsproblem' href='#Mads.createmadsproblem'>#</a>
**`Mads.createmadsproblem`** &mdash; *Function*.



Create a new Mads problem where the observation targets are computed based on the model predictions

Methods

  * `Mads.createmadsproblem(infilename::String, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:26
  * `Mads.createmadsproblem(madsdata::Associative, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:51
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:60
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:56

Arguments

  * `infilename::String` : input Mads file
  * `madsdata::Associative` : MADS problem dictionary
  * `outfilename::String` : output Mads file
  * `predictions::Associative` : dictionary of model predictions

Returns:

  * new MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCreate.jl#L76-L84' class='documenter-source'>source</a><br>

<a id='Mads.createobservations!' href='#Mads.createobservations!'>#</a>
**`Mads.createobservations!`** &mdash; *Function*.



Create observations in the MADS problem dictionary based on `time` and `observation` vectors

Methods

  * `Mads.createobservations!(madsdata::Associative, time::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:434
  * `Mads.createobservations!(madsdata::Associative, time::Array{T<:Any,1}, observation::Array{T<:Any,1}; logtransform, weight_type, weight)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:434
  * `Mads.createobservations!(madsdata::Associative, observation::Associative; logtransform, weight_type, weight)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:478

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `observation::Array{T<:Any,1}` : dictionary of observations
  * `observation::Associative` : dictionary of observations
  * `time::Array{T<:Any,1}` : vector of observation times

Keywords

  * `logtransform` : log transform observations [default=`false`]
  * `weight` : weight value [default=`1`]
  * `weight_type` : weight type [default=`constant`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L497-L501' class='documenter-source'>source</a><br>

<a id='Mads.createtempdir-Tuple{String}' href='#Mads.createtempdir-Tuple{String}'>#</a>
**`Mads.createtempdir`** &mdash; *Method*.



Create temporary directory

Methods

  * `Mads.createtempdir(tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1189

Arguments

  * `tempdirname::String` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1182-L1186' class='documenter-source'>source</a><br>

<a id='Mads.deleteNaN!-Tuple{DataFrames.DataFrame}' href='#Mads.deleteNaN!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.deleteNaN!`** &mdash; *Method*.



Delete rows with NaN in a dataframe `df`

Methods

  * `Mads.deleteNaN!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1065

Arguments

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L1058-L1062' class='documenter-source'>source</a><br>

<a id='Mads.deletekeyword!' href='#Mads.deletekeyword!'>#</a>
**`Mads.deletekeyword!`** &mdash; *Function*.



Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.deletekeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:236
  * `Mads.deletekeyword!(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:242

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L254-L258' class='documenter-source'>source</a><br>

<a id='Mads.deleteoffwells!-Tuple{Associative}' href='#Mads.deleteoffwells!-Tuple{Associative}'>#</a>
**`Mads.deleteoffwells!`** &mdash; *Method*.



Delete all wells marked as being off in the MADS problem dictionary

Methods

  * `Mads.welloff!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:611

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `wellname::String` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L625-L629' class='documenter-source'>source</a><br>

<a id='Mads.deletetimes!-Tuple{Associative,Any}' href='#Mads.deletetimes!-Tuple{Associative,Any}'>#</a>
**`Mads.deletetimes!`** &mdash; *Method*.



Delete all times in the MADS problem dictionary in a given list.

Methods

  * `Mads.welloff!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:611

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `wellname::String` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L640-L644' class='documenter-source'>source</a><br>

<a id='Mads.dependents' href='#Mads.dependents'>#</a>
**`Mads.dependents`** &mdash; *Function*.



Lists module dependents on a module (Mads by default)

Methods

  * `Mads.dependents(modulename::String, filter::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:43
  * `Mads.dependents(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:43
  * `Mads.dependents()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:43

Arguments

  * `filter::Bool` : whether to filter modules [default=`false`]
  * `modulename::String` : module name [default=`"Mads"`]

Returns:

  * modules that are dependents of the input module


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L31-L39' class='documenter-source'>source</a><br>

<a id='Mads.diff' href='#Mads.diff'>#</a>
**`Mads.diff`** &mdash; *Function*.



Diff the latest version of Mads modules in the repository

Methods

  * `Mads.diff(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:158
  * `Mads.diff()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:158

Arguments

  * `modulename::String` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L151-L155' class='documenter-source'>source</a><br>

<a id='Mads.display' href='#Mads.display'>#</a>
**`Mads.display`** &mdash; *Function*.



Display image file

Methods

  * `Mads.display(p::Gadfly.Plot)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsDisplay.jl:61
  * `Mads.display(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsDisplay.jl:7

Arguments

  * `filename::String` : image file name
  * `p::Gadfly.Plot`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsDisplay.jl#L68-L72' class='documenter-source'>source</a><br>

<a id='Mads.dobigdt-Tuple{Associative,Int64}' href='#Mads.dobigdt-Tuple{Associative,Int64}'>#</a>
**`Mads.dobigdt`** &mdash; *Method*.



Perform Bayesian Information Gap Decision Theory (BIG-DT) analysis

Methods

  * `Mads.dobigdt(madsdata::Associative, nummodelruns::Int64; numhorizons, numlikelihoods, maxHorizon)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:123

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `nummodelruns::Int64` : number of model runs

Keywords

  * `maxHorizon` : maximum info-gap horizons of uncertainty [default=`3`]
  * `numhorizons` : number of info-gap horizons of uncertainty [default=`100`]
  * `numlikelihoods` : number of Bayesian likelihoods [default=`25`]

Returns:

  * dictionary with BIG-DT results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsBayesInfoGap.jl#L108-L116' class='documenter-source'>source</a><br>

<a id='Mads.dumpasciifile-Tuple{String,Any}' href='#Mads.dumpasciifile-Tuple{String,Any}'>#</a>
**`Mads.dumpasciifile`** &mdash; *Method*.



Dump ASCII file

Methods

  * `Mads.dumpasciifile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:30

Arguments

  * `data` : data to dump
  * `filename::String` : ASCII file name

Dumps:

  * ASCII file with the name in "filename"


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsASCII.jl#L18-L26' class='documenter-source'>source</a><br>

<a id='Mads.dumpjsonfile-Tuple{String,Any}' href='#Mads.dumpjsonfile-Tuple{String,Any}'>#</a>
**`Mads.dumpjsonfile`** &mdash; *Method*.



Dump a JSON file

Methods

  * `Mads.dumpjsonfile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:38

Arguments

  * `data` : data to dump
  * `filename::String` : JSON file name

Dumps:

  * JSON file with the name in "filename"


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsJSON.jl#L26-L34' class='documenter-source'>source</a><br>

<a id='Mads.dumpwelldata-Tuple{Associative,String}' href='#Mads.dumpwelldata-Tuple{Associative,String}'>#</a>
**`Mads.dumpwelldata`** &mdash; *Method*.



Dump well data from MADS problem dictionary into a ASCII file

Methods

  * `Mads.dumpwelldata(madsdata::Associative, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1055

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : MADS problem dictionary

Dumps:

  * `filename` : a ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1043-L1051' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlfile-Tuple{String,Any}' href='#Mads.dumpyamlfile-Tuple{String,Any}'>#</a>
**`Mads.dumpyamlfile`** &mdash; *Method*.



Dump YAML file

Methods

  * `Mads.dumpyamlfile(filename::String, data; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:44

Arguments

  * `data` : YAML data
  * `filename::String` : output file name

Keywords

  * `julia` : if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsYAML.jl#L35-L39' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlmadsfile-Tuple{Associative,String}' href='#Mads.dumpyamlmadsfile-Tuple{Associative,String}'>#</a>
**`Mads.dumpyamlmadsfile`** &mdash; *Method*.



Dump YAML Mads file

Methods

  * `Mads.dumpyamlmadsfile(madsdata::Associative, filename::String; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:63

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `julia` : use julia YAML [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsYAML.jl#L54-L58' class='documenter-source'>source</a><br>

<a id='Mads.efast-Tuple{Associative}' href='#Mads.efast-Tuple{Associative}'>#</a>
**`Mads.efast`** &mdash; *Method*.



Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

Methods

  * `Mads.efast(md::Associative; N, M, gamma, seed, restart, checkpointfrequency, restartdir)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1108

Arguments

  * `md::Associative` : MADS problem dictionary

Keywords

  * `M` : maximum number of harmonics [default=`6`]
  * `N` : number of samples [default=`100`]
  * `checkpointfrequency` : check point frequency [default=`N`]
  * `gamma` : multiplication factor (Saltelli 1999 recommends gamma = 2 or 4) [default=`4`]
  * `restart` : save restart information [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for the efast simulation restarts [default=`"efastcheckpoints"`]
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L1094-L1098' class='documenter-source'>source</a><br>

<a id='Mads.emceesampling' href='#Mads.emceesampling'>#</a>
**`Mads.emceesampling`** &mdash; *Function*.



Bayesian sampling with Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

Methods

  * `Mads.emceesampling(madsdata::Associative; numwalkers, nsteps, burnin, thinning, sigma, seed, weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:10
  * `Mads.emceesampling(madsdata::Associative, p0::Array; numwalkers, nsteps, burnin, thinning, seed, weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:33

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `p0::Array` : initial parameters (matrix of size (number of parameters, number of walkers) or (length(Mads.getoptparamkeys(madsdata)), numwalkers))

Keywords

  * `burnin` : number of initial realizations before the MCMC are recorded [default=`10`]
  * `nsteps` : number of final realizations in the chain [default=`100`]
  * `numwalkers` : number of walkers (if in parallel this can be the number of available processors; in general, the higher the number of walkers, the better the results and computational time [default=`10`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L50-L66' class='documenter-source'>source</a><br>

<a id='Mads.estimationerror' href='#Mads.estimationerror'>#</a>
**`Mads.estimationerror`** &mdash; *Function*.



Estimate kriging error

Methods

  * `Mads.estimationerror(w::Array{T<:Any,1}, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:194
  * `Mads.estimationerror(w::Array{T<:Any,1}, covmat::Array{T<:Any,2}, covvec::Array{T<:Any,1}, cov0::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:201

Arguments

  * `X::Array{T<:Any,2}` : observation matrix
  * `cov0::Number` : zero-separation covariance
  * `cov::Function` : spatial covariance function
  * `covmat::Array{T<:Any,2}` : covariance matrix
  * `covvec::Array{T<:Any,1}` : covariance vector
  * `w::Array{T<:Any,1}` : kriging weights
  * `x0::Array{T<:Any,1}` : estimated locations

Returns:

  * estimation kriging error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L204-L212' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpression-Tuple{String,Associative}' href='#Mads.evaluatemadsexpression-Tuple{String,Associative}'>#</a>
**`Mads.evaluatemadsexpression`** &mdash; *Method*.



Evaluate an expression string based on a parameter dictionary

Methods

  * `Mads.evaluatemadsexpression(expressionstring::String, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:154

Arguments

  * `expressionstring::String` : expression string
  * `parameters::Associative` : parameter dictionary applied to evaluate the expression string

Returns:

  * dictionary containing the expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L142-L150' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpressions-Tuple{Associative,Associative}' href='#Mads.evaluatemadsexpressions-Tuple{Associative,Associative}'>#</a>
**`Mads.evaluatemadsexpressions`** &mdash; *Method*.



Evaluate all the expressions in the Mads problem dictiorany based on a parameter dictionary

Methods

  * `Mads.evaluatemadsexpressions(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:173

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameters::Associative` : parameter dictionary applied to evaluate the expression strings

Returns:

  * dictionary containing the parameter and expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L161-L169' class='documenter-source'>source</a><br>

<a id='Mads.expcov-Tuple{Number,Number,Number}' href='#Mads.expcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.expcov`** &mdash; *Method*.



Exponential spatial covariance function

Methods

  * `Mads.expcov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:29

Arguments

  * `h::Number` : separation distance
  * `maxcov::Number` : maximum covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L17-L25' class='documenter-source'>source</a><br>

<a id='Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.exponentialvariogram`** &mdash; *Method*.



Exponential variogram

Methods

  * `Mads.exponentialvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:82

Arguments

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Exponential variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L68-L76' class='documenter-source'>source</a><br>

<a id='Mads.filterkeys' href='#Mads.filterkeys'>#</a>
**`Mads.filterkeys`** &mdash; *Function*.



Filter dictionary keys based on a string or regular expression

Methods

  * `Mads.filterkeys(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:766
  * `Mads.filterkeys(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:765
  * `Mads.filterkeys(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:766

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the regular expression or string used to filter dictionary keys
  * `key::String` : the regular expression or string used to filter dictionary keys


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L768-L772' class='documenter-source'>source</a><br>

<a id='Mads.forward' href='#Mads.forward'>#</a>
**`Mads.forward`** &mdash; *Function*.



Perform a forward run using the initial or provided values for the model parameters

Methods

  * `Mads.forward(madsdata::Associative; all)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:7
  * `Mads.forward(madsdata::Associative, paramdict::Associative; all, checkpointfrequency, checkpointfilename)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:11
  * `Mads.forward(madsdata::Associative, paramarray::Array; all, checkpointfrequency, checkpointfilename)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:45

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramarray::Array` : array of model parameter values
  * `paramdict::Associative` : dictionary of model parameter values

Keywords

  * `all` : all model results are returned [default=`false`]
  * `checkpointfilename` : check point file name [default="checkpoint_forward"]
  * `checkpointfrequency` : check point frequency for storing restart information [default=`0`]

Returns:

  * dictionary of model predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsForward.jl#L116-L124' class='documenter-source'>source</a><br>

<a id='Mads.forwardgrid' href='#Mads.forwardgrid'>#</a>
**`Mads.forwardgrid`** &mdash; *Function*.



Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

Methods

  * `Mads.forwardgrid(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:133
  * `Mads.forwardgrid(madsdatain::Associative, paramvalues::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:138

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `madsdatain::Associative` : MADS problem dictionary
  * `paramvalues::Associative` : dictionary of model parameter values

Returns:

  * 3D array with model predictions along a 3D grid


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsForward.jl#L199-L207' class='documenter-source'>source</a><br>

<a id='Mads.free' href='#Mads.free'>#</a>
**`Mads.free`** &mdash; *Function*.



Free Mads modules

Methods

  * `Mads.free(modulename::String; required, all)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:185
  * `Mads.free()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:185

Arguments

  * `modulename::String` : module name

Keywords

  * `all` : free all the modules [default=`false`]
  * `required` : only free Mads.required modules [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L176-L180' class='documenter-source'>source</a><br>

<a id='Mads.functions' href='#Mads.functions'>#</a>
**`Mads.functions`** &mdash; *Function*.



List available functions in the MADS modules:

Methods

  * `Mads.functions(string::String; stdout, quiet)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:31
  * `Mads.functions()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:31
  * `Mads.functions(re::Regex; stdout, quiet)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:22
  * `Mads.functions(m::Union{Module,Symbol})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:70
  * `Mads.functions(m::Union{Module,Symbol}, re::Regex; stdout, quiet)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:40
  * `Mads.functions(m::Union{Module,Symbol}, string::String; stdout, quiet)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:70

Arguments

  * `m::Union{Module,Symbol}` : MADS module
  * `re::Regex`
  * `string::String` : string to display functions with matching names

Keywords

  * `quiet`
  * `stdout`

Examples:

```julia
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelp.jl#L103-L116' class='documenter-source'>source</a><br>

<a id='Mads.gaussiancov-Tuple{Number,Number,Number}' href='#Mads.gaussiancov-Tuple{Number,Number,Number}'>#</a>
**`Mads.gaussiancov`** &mdash; *Method*.



Gaussian spatial covariance function

Methods

  * `Mads.gaussiancov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:15

Arguments

  * `h::Number` : separation distance
  * `maxcov::Number` : maximum covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L3-L11' class='documenter-source'>source</a><br>

<a id='Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.gaussianvariogram`** &mdash; *Method*.



Gaussian variogram

Methods

  * `Mads.gaussianvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:103

Arguments

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Gaussian variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L89-L97' class='documenter-source'>source</a><br>

<a id='Mads.getcovmat-Tuple{Array{T,2},Function}' href='#Mads.getcovmat-Tuple{Array{T,2},Function}'>#</a>
**`Mads.getcovmat`** &mdash; *Method*.



Get spatial covariance matrix

Methods

  * `Mads.getcovmat(X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:156

Arguments

  * `X::Array{T<:Any,2}` : matrix with coordinates of the data points (x or y)
  * `cov::Function` : spatial covariance function

Returns:

  * spatial covariance matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L144-L152' class='documenter-source'>source</a><br>

<a id='Mads.getcovvec!-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}' href='#Mads.getcovvec!-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.getcovvec!`** &mdash; *Method*.



Get spatial covariance vector

Methods

  * `Mads.getcovvec!(covvec::Array{T<:Any,1}, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:182

Arguments

  * `X::Array{T<:Any,2}` : matrix with coordinates of the data points
  * `cov::Function` : spatial covariance function
  * `covvec::Array{T<:Any,1}` : spatial covariance vector
  * `x0::Array{T<:Any,1}` : vector with coordinates of the estimation points (x or y)

Returns:

  * spatial covariance vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L168-L176' class='documenter-source'>source</a><br>

<a id='Mads.getdictvalues' href='#Mads.getdictvalues'>#</a>
**`Mads.getdictvalues`** &mdash; *Function*.



Get dictionary values for keys based on a string or regular expression

Methods

  * `Mads.getdictvalues(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:788
  * `Mads.getdictvalues(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:787
  * `Mads.getdictvalues(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:788

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the key to find value for
  * `key::String` : the key to find value for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L790-L794' class='documenter-source'>source</a><br>

<a id='Mads.getdir-Tuple{String}' href='#Mads.getdir-Tuple{String}'>#</a>
**`Mads.getdir`** &mdash; *Method*.



Get directory

Methods

  * `Mads.getdir(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:396

Arguments

  * `filename::String` : file name

Returns:

  * directory in file name

Example:

```julia
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L378-L393' class='documenter-source'>source</a><br>

<a id='Mads.getdistribution-Tuple{String,String,String}' href='#Mads.getdistribution-Tuple{String,String,String}'>#</a>
**`Mads.getdistribution`** &mdash; *Method*.



Parse parameter distribution from a string

Methods

  * `Mads.getdistribution(dist::String, i::String, inputtype::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:202

Arguments

  * `dist::String` : parameter distribution
  * `i::String`
  * `inputtype::String` : input type (parameter or observation)

Returns:

  * distribution


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L189-L197' class='documenter-source'>source</a><br>

<a id='Mads.getextension-Tuple{String}' href='#Mads.getextension-Tuple{String}'>#</a>
**`Mads.getextension`** &mdash; *Method*.



Get file name extension

Methods

  * `Mads.getextension(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:568

Arguments

  * `filename::String` : file name

Returns:

  * file name extension

Example:

```julia
ext = Mads.getextension("a.mads") # ext = "mads"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L551-L565' class='documenter-source'>source</a><br>

<a id='Mads.getimportantsamples-Tuple{Array,Array{T,1}}' href='#Mads.getimportantsamples-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.getimportantsamples`** &mdash; *Method*.



Get important samples

Methods

  * `Mads.getimportantsamples(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:350

Arguments

  * `llhoods::Array{T<:Any,1}` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * array of important samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L338-L346' class='documenter-source'>source</a><br>

<a id='Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L534' class='documenter-source'>source</a><br>

<a id='Mads.getmadsdir-Tuple{}' href='#Mads.getmadsdir-Tuple{}'>#</a>
**`Mads.getmadsdir`** &mdash; *Method*.



Get the directory where currently Mads is running

Methods

  * `Mads.getmadsdir()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:438

Example:

```julia
problemdir = Mads.getmadsdir()
```

Returns:

  * Mads problem directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L422-L436' class='documenter-source'>source</a><br>

<a id='Mads.getmadsinputfile-Tuple{}' href='#Mads.getmadsinputfile-Tuple{}'>#</a>
**`Mads.getmadsinputfile`** &mdash; *Method*.



Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

Methods

  * `Mads.getmadsinputfile()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:353

Returns:

  * input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L343-L351' class='documenter-source'>source</a><br>

<a id='Mads.getmadsproblemdir-Tuple{Associative}' href='#Mads.getmadsproblemdir-Tuple{Associative}'>#</a>
**`Mads.getmadsproblemdir`** &mdash; *Method*.



Get the directory where the Mads data file is located

Methods

  * `Mads.getmadsproblemdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:419

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Example:

```julia
madsdata = Mads.loadmadsfile("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L403-L416' class='documenter-source'>source</a><br>

<a id='Mads.getmadsrootname-Tuple{Associative}' href='#Mads.getmadsrootname-Tuple{Associative}'>#</a>
**`Mads.getmadsrootname`** &mdash; *Method*.



Get the MADS problem root name

Methods

  * `Mads.getmadsrootname(madsdata::Associative; first, version)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:375

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname [default=`false`]

Example:

```julia
madsrootname = Mads.getmadsrootname(madsdata)
```

Returns:

  * root of file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L356-L370' class='documenter-source'>source</a><br>

<a id='Mads.getnextmadsfilename-Tuple{String}' href='#Mads.getnextmadsfilename-Tuple{String}'>#</a>
**`Mads.getnextmadsfilename`** &mdash; *Method*.



Get next mads file name

Methods

  * `Mads.getnextmadsfilename(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:531

Arguments

  * `filename::String` : file name

Returns:

  * next mads file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L520-L528' class='documenter-source'>source</a><br>

<a id='Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L534' class='documenter-source'>source</a><br>

<a id='Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L534' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative,Any}' href='#Mads.getobsdist-Tuple{Associative,Any}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative}' href='#Mads.getobsdist-Tuple{Associative}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobskeys-Tuple{Associative}' href='#Mads.getobskeys-Tuple{Associative}'>#</a>
**`Mads.getobskeys`** &mdash; *Method*.



Get keys for all observations in the MADS problem dictionary

Methods

  * `Mads.getobskeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:45

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * keys for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L34-L42' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative,Any}' href='#Mads.getobslog-Tuple{Associative,Any}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative}' href='#Mads.getobslog-Tuple{Associative}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative,Any}' href='#Mads.getobsmax-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative}' href='#Mads.getobsmax-Tuple{Associative}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative,Any}' href='#Mads.getobsmin-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative}' href='#Mads.getobsmin-Tuple{Associative}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative,Any}' href='#Mads.getobstarget-Tuple{Associative,Any}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative}' href='#Mads.getobstarget-Tuple{Associative}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative,Any}' href='#Mads.getobstime-Tuple{Associative,Any}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative}' href='#Mads.getobstime-Tuple{Associative}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative,Any}' href='#Mads.getobsweight-Tuple{Associative,Any}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative}' href='#Mads.getobsweight-Tuple{Associative}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L86' class='documenter-source'>source</a><br>

<a id='Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L534' class='documenter-source'>source</a><br>

<a id='Mads.getoptparams' href='#Mads.getoptparams'>#</a>
**`Mads.getoptparams`** &mdash; *Function*.



Get optimizable parameters

Methods

  * `Mads.getoptparams(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:365
  * `Mads.getoptparams(madsdata::Associative, parameterarray::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:368
  * `Mads.getoptparams(madsdata::Associative, parameterarray::Array, optparameterkey::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:368

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `optparameterkey::Array` : optimizable parameter keys
  * `parameterarray::Array` : parameter array

Returns:

  * parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L396-L404' class='documenter-source'>source</a><br>

<a id='Mads.getparamdict-Tuple{Associative}' href='#Mads.getparamdict-Tuple{Associative}'>#</a>
**`Mads.getparamdict`** &mdash; *Method*.



Get dictionary with all parameters and their respective initial values

Methods

  * `Mads.getparamdict(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:60

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * dictionary with all parameters and their respective initial values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L49-L57' class='documenter-source'>source</a><br>

<a id='Mads.getparamdistributions-Tuple{Associative}' href='#Mads.getparamdistributions-Tuple{Associative}'>#</a>
**`Mads.getparamdistributions`** &mdash; *Method*.



Get probabilistic distributions of all parameters in the MADS problem dictionary

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Methods

  * `Mads.getparamdistributions(madsdata::Associative; init_dist)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:656

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field [default=`false`]

Returns:

  * probabilistic distributions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L640-L652' class='documenter-source'>source</a><br>

<a id='Mads.getparamkeys-Tuple{Associative}' href='#Mads.getparamkeys-Tuple{Associative}'>#</a>
**`Mads.getparamkeys`** &mdash; *Method*.



Get keys of all parameters in the MADS problem dictionary

Methods

  * `Mads.getparamkeys(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:44

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filter` : parameter filter

Returns:

  * array with the keys of all parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.getparamrandom' href='#Mads.getparamrandom'>#</a>
**`Mads.getparamrandom`** &mdash; *Function*.



Get independent sampling of model parameters defined in the MADS problem dictionary

Methods

  * `Mads.getparamrandom(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:386
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:386
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer, parameterkey::String; init_dist)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:386
  * `Mads.getparamrandom(madsdata::Associative, parameterkey::String; numsamples, init_dist, paramdist)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:403

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numsamples::Integer` : number of samples,  [default=`1`]
  * `parameterkey::String` : model parameter key

Keywords

  * `init_dist` : if `true` use the distribution set for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); if `false` (default) use the regular distribution set in the MADS problem dictionary (defined using `dist` parameter field)
  * `numsamples` : number of samples
  * `paramdist` : dictionary of parameter distributions

Returns:

  * generated sample


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L423-L431' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative}' href='#Mads.getparamsinit-Tuple{Associative}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max' href='#Mads.getparamsinit_max'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Function*.



Get an array with `init_max` values for parameters defined by `paramkeys`

Methods

  * `Mads.getparamsinit_max(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:294
  * `Mads.getparamsinit_max(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:260

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramkeys::Array{T<:Any,1}` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L298-L306' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min' href='#Mads.getparamsinit_min'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Function*.



Get an array with `init_min` values for parameters

Methods

  * `Mads.getparamsinit_min(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:243
  * `Mads.getparamsinit_min(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:209

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramkeys::Array{T<:Any,1}` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L247-L255' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslog-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative}' href='#Mads.getparamslog-Tuple{Associative}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslongname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative}' href='#Mads.getparamslongname-Tuple{Associative}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax' href='#Mads.getparamsmax'>#</a>
**`Mads.getparamsmax`** &mdash; *Function*.



Get an array with `max` values for parameters defined by `paramkeys`

Methods

  * `Mads.getparamsmax(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:192
  * `Mads.getparamsmax(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:170

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramkeys::Array{T<:Any,1}` : parameter keys

Returns:

  * returns the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L196-L204' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin' href='#Mads.getparamsmin'>#</a>
**`Mads.getparamsmin`** &mdash; *Function*.



Get an array with `min` values for parameters defined by `paramkeys`

Methods

  * `Mads.getparamsmin(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:153
  * `Mads.getparamsmin(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:131

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramkeys::Array{T<:Any,1}` : parameter keys

Returns:

  * the parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L157-L165' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsplotname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative}' href='#Mads.getparamsplotname-Tuple{Associative}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsstep-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative}' href='#Mads.getparamsstep-Tuple{Associative}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative,Array{T,1}}' href='#Mads.getparamstype-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative}' href='#Mads.getparamstype-Tuple{Associative}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getprocs-Tuple{}' href='#Mads.getprocs-Tuple{}'>#</a>
**`Mads.getprocs`** &mdash; *Method*.



Get the number of processors

Methods

  * `Mads.getprocs()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:25


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L19-L23' class='documenter-source'>source</a><br>

<a id='Mads.getrestart-Tuple{Associative}' href='#Mads.getrestart-Tuple{Associative}'>#</a>
**`Mads.getrestart`** &mdash; *Method*.



Get MADS restart status

Methods

  * `Mads.getrestart(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:56

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L49-L53' class='documenter-source'>source</a><br>

<a id='Mads.getrestartdir' href='#Mads.getrestartdir'>#</a>
**`Mads.getrestartdir`** &mdash; *Function*.



Get the directory where Mads restarts will be stored

Methods

  * `Mads.getrestartdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:334
  * `Mads.getrestartdir(madsdata::Associative, suffix::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:334

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `suffix::String` : Suffix to be added to the name of restart directory

Returns:

  * restart directory where reusable model results will be stored


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L322-L330' class='documenter-source'>source</a><br>

<a id='Mads.getrootname-Tuple{String}' href='#Mads.getrootname-Tuple{String}'>#</a>
**`Mads.getrootname`** &mdash; *Method*.



Get file name root

Methods

  * `Mads.getrootname(filename::String; first, version)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:468

Arguments

  * `filename::String` : file name

Keywords

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname [default=`false`]

Returns:

  * root of file name

Example:

```julia
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L448-L463' class='documenter-source'>source</a><br>

<a id='Mads.getseed-Tuple{}' href='#Mads.getseed-Tuple{}'>#</a>
**`Mads.getseed`** &mdash; *Method*.



Get and return current random seed.

Methods

  * `Mads.getseed()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:361


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L355-L359' class='documenter-source'>source</a><br>

<a id='Mads.getsindx-Tuple{Associative}' href='#Mads.getsindx-Tuple{Associative}'>#</a>
**`Mads.getsindx`** &mdash; *Method*.



Get sin-space dx

Methods

  * `Mads.getsindx(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:274

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * sin-space dx


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L263-L271' class='documenter-source'>source</a><br>

<a id='Mads.getsourcekeys-Tuple{Associative}' href='#Mads.getsourcekeys-Tuple{Associative}'>#</a>
**`Mads.getsourcekeys`** &mdash; *Method*.



Get keys of all source parameters in the MADS problem dictionary

Methods

  * `Mads.getsourcekeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:78

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * array with keys of all source parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L67-L75' class='documenter-source'>source</a><br>

<a id='Mads.gettarget-Tuple{Associative}' href='#Mads.gettarget-Tuple{Associative}'>#</a>
**`Mads.gettarget`** &mdash; *Method*.



Get observation target

Methods

  * `Mads.gettarget(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:220

Arguments

  * `o::Associative` : observation data

Returns:

  * observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L209-L217' class='documenter-source'>source</a><br>

<a id='Mads.gettargetkeys-Tuple{Associative}' href='#Mads.gettargetkeys-Tuple{Associative}'>#</a>
**`Mads.gettargetkeys`** &mdash; *Method*.



Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary

Methods

  * `Mads.gettargetkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:59

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * keys for all targets in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L48-L56' class='documenter-source'>source</a><br>

<a id='Mads.gettime-Tuple{Associative}' href='#Mads.gettime-Tuple{Associative}'>#</a>
**`Mads.gettime`** &mdash; *Method*.



Get observation time

Methods

  * `Mads.gettime(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:142

Arguments

  * `o::Associative` : observation data

Returns:

  * observation time ("NaN" it time is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L131-L139' class='documenter-source'>source</a><br>

<a id='Mads.getweight-Tuple{Associative}' href='#Mads.getweight-Tuple{Associative}'>#</a>
**`Mads.getweight`** &mdash; *Method*.



Get observation weight

Methods

  * `Mads.getweight(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:181

Arguments

  * `o::Associative` : observation data

Returns:

  * observation weight ("NaN" when weight is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L170-L178' class='documenter-source'>source</a><br>

<a id='Mads.getwellkeys-Tuple{Associative}' href='#Mads.getwellkeys-Tuple{Associative}'>#</a>
**`Mads.getwellkeys`** &mdash; *Method*.



Get keys for all wells in the MADS problem dictionary

Methods

  * `Mads.getwellkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:76

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * keys for all wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L65-L73' class='documenter-source'>source</a><br>

<a id='Mads.getwellsdata-Tuple{Associative}' href='#Mads.getwellsdata-Tuple{Associative}'>#</a>
**`Mads.getwellsdata`** &mdash; *Method*.



Get spatial and temporal data in the `Wells` class

Methods

  * `Mads.getwellsdata(madsdata::Associative; time)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:704

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `time` : get observation times [default=`false`]

Returns:

  * array with spatial and temporal data in the `Wells` class


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L692-L700' class='documenter-source'>source</a><br>

<a id='Mads.graphoff-Tuple{}' href='#Mads.graphoff-Tuple{}'>#</a>
**`Mads.graphoff`** &mdash; *Method*.



MADS graph output off

Methods

  * `Mads.graphoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:92


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L86-L90' class='documenter-source'>source</a><br>

<a id='Mads.graphon-Tuple{}' href='#Mads.graphon-Tuple{}'>#</a>
**`Mads.graphon`** &mdash; *Method*.



MADS graph output on

Methods

  * `Mads.graphon()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:83


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L77-L81' class='documenter-source'>source</a><br>

<a id='Mads.haskeyword' href='#Mads.haskeyword'>#</a>
**`Mads.haskeyword`** &mdash; *Function*.



Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.haskeyword(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:171
  * `Mads.haskeyword(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:174

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : MADS problem dictionary

Returns: `true` or `false`

Examples:

```julia
- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L190-L203' class='documenter-source'>source</a><br>

<a id='Mads.help-Tuple{}' href='#Mads.help-Tuple{}'>#</a>
**`Mads.help`** &mdash; *Method*.



Produce MADS help information

Methods

  * `Mads.help()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelp.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.importeverywhere-Tuple{String}' href='#Mads.importeverywhere-Tuple{String}'>#</a>
**`Mads.importeverywhere`** &mdash; *Method*.



Import Julia function everywhere from a file. The first function in the Julia input file is the one that will be called by Mads to perform the model simulations.

Methods

  * `Mads.importeverywhere(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:386

Arguments

  * `filename::String` : file name

Returns:

  * Julia function to execute the model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L374-L383' class='documenter-source'>source</a><br>

<a id='Mads.indexkeys' href='#Mads.indexkeys'>#</a>
**`Mads.indexkeys`** &mdash; *Function*.



Find indexes for dictionary keys based on a string or regular expression

Methods

  * `Mads.indexkeys(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:777
  * `Mads.indexkeys(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:776
  * `Mads.indexkeys(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:777

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the key to find index for
  * `key::String` : the key to find index for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L779-L783' class='documenter-source'>source</a><br>

<a id='Mads.infogap_jump' href='#Mads.infogap_jump'>#</a>
**`Mads.infogap_jump`** &mdash; *Function*.



Information Gap Decision Analysis using JuMP

Methods

  * `Mads.infogap_jump()` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:22
  * `Mads.infogap_jump(madsdata::Associative; retries, random, maxiter, verbosity, seed, horizons)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:22

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsInfoGap.jl#L9-L13' class='documenter-source'>source</a><br>

<a id='Mads.infogap_jump_polinomial' href='#Mads.infogap_jump_polinomial'>#</a>
**`Mads.infogap_jump_polinomial`** &mdash; *Function*.



Information Gap Decision Analysis using JuMP

Methods

  * `Mads.infogap_jump_polinomial()` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:126
  * `Mads.infogap_jump_polinomial(madsdata::Associative; retries, random, maxiter, verbosity, quiet, plot, model, seed, horizons)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:126

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsInfoGap.jl#L106-L114' class='documenter-source'>source</a><br>

<a id='Mads.infogap_mpb_lin' href='#Mads.infogap_mpb_lin'>#</a>
**`Mads.infogap_mpb_lin`** &mdash; *Function*.



Information Gap Decision Analysis using MathProgBase

Methods

  * `Mads.infogap_mpb_lin()` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:423
  * `Mads.infogap_mpb_lin(madsdata::Associative; retries, random, maxiter, verbosity, seed, horizons, pinit)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:423

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `pinit` : vector with initial parameters
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsInfoGap.jl#L409-L413' class='documenter-source'>source</a><br>

<a id='Mads.infogap_mpb_polinomial' href='#Mads.infogap_mpb_polinomial'>#</a>
**`Mads.infogap_mpb_polinomial`** &mdash; *Function*.



Information Gap Decision Analysis using MathProgBase

Methods

  * `Mads.infogap_mpb_polinomial()` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:282
  * `Mads.infogap_mpb_polinomial(madsdata::Associative; retries, random, maxiter, verbosity, seed, horizons, pinit)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsInfoGap.jl:282

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `horizons` : info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]
  * `maxiter` : maximum number of iterations [default=`3000`]
  * `pinit` : vector with initial parameters
  * `random` : random initial guesses [default=`false`]
  * `retries` : number of solution retries [default=`1`]
  * `seed` : random seed [default=`0`]
  * `verbosity` : verbosity output level [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsInfoGap.jl#L268-L272' class='documenter-source'>source</a><br>

<a id='Mads.ins_obs-Tuple{String,String}' href='#Mads.ins_obs-Tuple{String,String}'>#</a>
**`Mads.ins_obs`** &mdash; *Method*.



Apply Mads instruction file `instructionfilename` to read model output file `modeloutputfilename`

Methods

  * `Mads.ins_obs(instructionfilename::String, modeloutputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:971

Arguments

  * `instructionfilename::String` : instruction file name
  * `modeloutputfilename::String` : model output file name

Returns:

  * `obsdict` : observation dictionary with the model outputs


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L959-L967' class='documenter-source'>source</a><br>

<a id='Mads.instline2regexs-Tuple{String}' href='#Mads.instline2regexs-Tuple{String}'>#</a>
**`Mads.instline2regexs`** &mdash; *Method*.



Convert an instruction line in the Mads instruction file into regular expressions

Methods

  * `Mads.instline2regexs(instline::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:874

Arguments

  * `instline::String` : instruction line

Returns:

  * `regexs` : regular expressions
  * `obsnames` : observation names
  * `getparamhere` : parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L861-L871' class='documenter-source'>source</a><br>

<a id='Mads.invobsweights!-Tuple{Associative,Number}' href='#Mads.invobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invobsweights!`** &mdash; *Method*.



Set inversely proportional observation weights in the MADS problem dictionary

Methods

  * `Mads.invobsweights!(madsdata::Associative, multiplier::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:323

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `multiplier::Number` : weight multiplier


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L315-L319' class='documenter-source'>source</a><br>

<a id='Mads.invwellweights!-Tuple{Associative,Number}' href='#Mads.invwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invwellweights!`** &mdash; *Method*.



Set inversely proportional well weights in the MADS problem dictionary

Methods

  * `Mads.invwellweights!(madsdata::Associative, multiplier::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:374

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `multiplier::Number` : weight multiplier


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L366-L370' class='documenter-source'>source</a><br>

<a id='Mads.islog-Tuple{Associative,String}' href='#Mads.islog-Tuple{Associative,String}'>#</a>
**`Mads.islog`** &mdash; *Method*.



Is parameter with key `parameterkey` log-transformed?

Methods

  * `Mads.islog(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:441

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key

Returns:

  * `true` if log-transformed, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L429-L437' class='documenter-source'>source</a><br>

<a id='Mads.isobs-Tuple{Associative,Associative}' href='#Mads.isobs-Tuple{Associative,Associative}'>#</a>
**`Mads.isobs`** &mdash; *Method*.



Is a dictionary containing all the observations

Methods

  * `Mads.isobs(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:19

Arguments

  * `dict::Associative` : dictionary
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * `true` if the dictionary contain all the observations, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L7-L15' class='documenter-source'>source</a><br>

<a id='Mads.isopt-Tuple{Associative,String}' href='#Mads.isopt-Tuple{Associative,String}'>#</a>
**`Mads.isopt`** &mdash; *Method*.



Is parameter with key `parameterkey` optimizable?

Methods

  * `Mads.isopt(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:421

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key

Returns:

  * `true` if optimizable, `false` if not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L409-L417' class='documenter-source'>source</a><br>

<a id='Mads.isparam-Tuple{Associative,Associative}' href='#Mads.isparam-Tuple{Associative,Associative}'>#</a>
**`Mads.isparam`** &mdash; *Method*.



Check if a dictionary containing all the Mads model parameters

Methods

  * `Mads.isparam(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:17

Arguments

  * `dict::Associative` : dictionary
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * `true` if the dictionary containing all the parameters, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable-Tuple{String}' href='#Mads.ispkgavailable-Tuple{String}'>#</a>
**`Mads.ispkgavailable`** &mdash; *Method*.



Checks if package is available

Methods

  * `Mads.ispkgavailable(modulename::String; quiet)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:399

Arguments

  * `modulename::String` : module name

Keywords

  * `quiet`

Returns:

  * `true` or `false`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L388-L396' class='documenter-source'>source</a><br>

<a id='Mads.krige-Tuple{Array{T,2},Array{T,2},Array{T,1},Function}' href='#Mads.krige-Tuple{Array{T,2},Array{T,2},Array{T,1},Function}'>#</a>
**`Mads.krige`** &mdash; *Method*.



Kriging

Methods

  * `Mads.krige(x0mat::Array{T<:Any,2}, X::Array{T<:Any,2}, Z::Array{T<:Any,1}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:124

Arguments

  * `X::Array{T<:Any,2}` : coordinates of the observation (conditioning) data
  * `Z::Array{T<:Any,1}` : values for the observation (conditioning) data
  * `cov::Function` : spatial covariance function
  * `x0mat::Array{T<:Any,2}` : point coordinates at which to obtain kriging estimates

Returns:

  * kriging estimates at `x0mat`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L110-L118' class='documenter-source'>source</a><br>

<a id='Mads.levenberg_marquardt' href='#Mads.levenberg_marquardt'>#</a>
**`Mads.levenberg_marquardt`** &mdash; *Function*.



Levenberg-Marquardt optimization

Methods

  * `Mads.levenberg_marquardt(f::Function, g::Function, x0)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:359
  * `Mads.levenberg_marquardt(f::Function, g::Function, x0, o::Function; root, tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_scale, lambda_mu, lambda_nu, np_lambda, show_trace, alwaysDoJacobian, callbackiteration, callbackjacobian)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:359

Arguments

  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `o::Function` : objective function [default=`x->(x'*x)[1]`]
  * `x0` : initial parameter guess

Keywords

  * `alwaysDoJacobian` : computer Jacobian each iteration [default=`false`]
  * `callbackiteration` : call back function for each iteration [default=`(best_x::Vector, of::Number, lambda::Number)->nothing`]
  * `callbackjacobian` : call back function for each Jacobian [default=`(x::Vector, J::Matrix)->nothing`]
  * `lambda` : initial Levenberg-Marquardt lambda [default=`eps(Float32)`]
  * `lambda_mu` : lambda multiplication factor μ [default=`10`]
  * `lambda_nu` : lambda multiplication factor ν [default=`2`]
  * `lambda_scale` : lambda scaling factor [default=`1e-3,`]
  * `maxEval` : maximum number of model evaluations [default=`1001`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `root` : Mads problem root name
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function update tolerance [default=`1e-3`]
  * `tolX` : parameter space tolerance [default=`1e-4`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L312-L316' class='documenter-source'>source</a><br>

<a id='Mads.linktempdir-Tuple{String,String}' href='#Mads.linktempdir-Tuple{String,String}'>#</a>
**`Mads.linktempdir`** &mdash; *Method*.



Link files in a temporary directory

Methods

  * `Mads.linktempdir(madsproblemdir::String, tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1215

Arguments

  * `madsproblemdir::String` : Mads problem directory
  * `tempdirname::String` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1207-L1211' class='documenter-source'>source</a><br>

<a id='Mads.loadasciifile-Tuple{String}' href='#Mads.loadasciifile-Tuple{String}'>#</a>
**`Mads.loadasciifile`** &mdash; *Method*.



Load ASCII file

Methods

  * `Mads.loadasciifile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:14

Arguments

  * `filename::String` : ASCII file name

Returns:

  * data from the file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsASCII.jl#L3-L11' class='documenter-source'>source</a><br>

<a id='Mads.loadbigyamlfile-Tuple{String}' href='#Mads.loadbigyamlfile-Tuple{String}'>#</a>
**`Mads.loadbigyamlfile`** &mdash; *Method*.



Load BIG YAML input file

Methods

  * `Mads.loadmadsfile(filename::String; bigfile, julia, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:32

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)

Keywords

  * `bigfile`
  * `format`
  * `julia`

Returns:

  * MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L59-L67' class='documenter-source'>source</a><br>

<a id='Mads.loadjsonfile-Tuple{String}' href='#Mads.loadjsonfile-Tuple{String}'>#</a>
**`Mads.loadjsonfile`** &mdash; *Method*.



Load a JSON file

Methods

  * `Mads.loadjsonfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:16

Arguments

  * `filename::String` : JSON file name

Returns:

  * data from the JSON file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsJSON.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsfile-Tuple{String}' href='#Mads.loadmadsfile-Tuple{String}'>#</a>
**`Mads.loadmadsfile`** &mdash; *Method*.



Load MADS input file defining a MADS problem dictionary

Methods

  * `Mads.loadmadsfile(filename::String; bigfile, julia, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:32

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)

Keywords

  * `bigfile`
  * `format` : acceptable formats are `yaml` and `json` [default=`yaml`]
  * `julia` : if `true`, force using `julia` parsing functions; if `false` (default), use `python` parsing functions

Returns:

  * MADS problem dictionary

Example:

```julia
md = Mads.loadmadsfile("input_file_name.mads")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L13-L27' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsproblem-Tuple{String}' href='#Mads.loadmadsproblem-Tuple{String}'>#</a>
**`Mads.loadmadsproblem`** &mdash; *Method*.



Load a predefined Mads problem

Methods

  * `Mads.loadmadsproblem(name::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:15

Arguments

  * `name::String` : predefined MADS problem name

Returns:

  * MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCreate.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.loadsaltellirestart!-Tuple{Array,String,String}' href='#Mads.loadsaltellirestart!-Tuple{Array,String,String}'>#</a>
**`Mads.loadsaltellirestart!`** &mdash; *Method*.



Load Saltelli sensitivity analysis results for fast simulation restarts

Methods

  * `Mads.loadsaltellirestart!(evalmat::Array, matname::String, restartdir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:597

Arguments

  * `evalmat::Array` : loaded array
  * `matname::String` : matrix (array) name (defines the name of the loaded file)
  * `restartdir::String` : directory where files will be stored containing model results for fast simulation restarts

Returns:

  * `true` when successfully loaded, `false` when it is not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L584-L592' class='documenter-source'>source</a><br>

<a id='Mads.loadyamlfile-Tuple{String}' href='#Mads.loadyamlfile-Tuple{String}'>#</a>
**`Mads.loadyamlfile`** &mdash; *Method*.



Load YAML file

Methods

  * `Mads.loadyamlfile(filename::String; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:17

Arguments

  * `filename::String` : file name

Keywords

  * `julia` : if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)

Returns:

  * data in the yaml input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsYAML.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.localsa-Tuple{Associative}' href='#Mads.localsa-Tuple{Associative}'>#</a>
**`Mads.localsa`** &mdash; *Method*.



Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

Methods

  * `Mads.localsa(madsdata::Associative; sinspace, keyword, filename, format, datafiles, imagefiles, par, obs, J)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:125

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L105-L113' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_off-Tuple{}' href='#Mads.long_tests_off-Tuple{}'>#</a>
**`Mads.long_tests_off`** &mdash; *Method*.



Turn off execution of long MADS tests (default)

Methods

  * `Mads.long_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:128


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L122-L126' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_on-Tuple{}' href='#Mads.long_tests_on-Tuple{}'>#</a>
**`Mads.long_tests_on`** &mdash; *Method*.



Turn on execution of long MADS tests

Methods

  * `Mads.long_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:119


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L113-L117' class='documenter-source'>source</a><br>

<a id='Mads.madscores' href='#Mads.madscores'>#</a>
**`Mads.madscores`** &mdash; *Function*.



Check the number of processors on a series of servers

Methods

  * `Mads.madscores(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:305
  * `Mads.madscores()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:305

Arguments

  * `nodenames::Array{String,1}` : array with names of machines/nodes [default=`Mads.madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L298-L302' class='documenter-source'>source</a><br>

<a id='Mads.madscritical-Tuple{AbstractString}' href='#Mads.madscritical-Tuple{AbstractString}'>#</a>
**`Mads.madscritical`** &mdash; *Method*.



MADS critical error messages

Methods

  * `Mads.madscritical(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:73

Arguments

  * `message::AbstractString` : critical error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.madsdebug' href='#Mads.madsdebug'>#</a>
**`Mads.madsdebug`** &mdash; *Function*.



MADS debug messages (controlled by `quiet` and `debuglevel`)

Methods

  * `Mads.madsdebug(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:26
  * `Mads.madsdebug(message::AbstractString, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:26

Arguments

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : debug message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L18-L22' class='documenter-source'>source</a><br>

<a id='Mads.madserror-Tuple{AbstractString}' href='#Mads.madserror-Tuple{AbstractString}'>#</a>
**`Mads.madserror`** &mdash; *Method*.



MADS error messages

Methods

  * `Mads.madserror(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:63

Arguments

  * `message::AbstractString` : error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L56-L60' class='documenter-source'>source</a><br>

<a id='Mads.madsinfo' href='#Mads.madsinfo'>#</a>
**`Mads.madsinfo`** &mdash; *Function*.



MADS information/status messages (controlled by quiet`and`verbositylevel`)

Methods

  * `Mads.madsinfo(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:41
  * `Mads.madsinfo(message::AbstractString, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:41

Arguments

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : information/status message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L33-L37' class='documenter-source'>source</a><br>

<a id='Mads.madsload' href='#Mads.madsload'>#</a>
**`Mads.madsload`** &mdash; *Function*.



Check the load of a series of servers

Methods

  * `Mads.madsload(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:325
  * `Mads.madsload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:325

Arguments

  * `nodenames::Array{String,1}` : array with names of machines/nodes [default=`Mads.madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L318-L322' class='documenter-source'>source</a><br>

<a id='Mads.madsmathprogbase' href='#Mads.madsmathprogbase'>#</a>
**`Mads.madsmathprogbase`** &mdash; *Function*.



Define `MadsModel` type applied for Mads execution using `MathProgBase`

Methods

  * `Mads.madsmathprogbase()` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsMathProgBase.jl:18
  * `Mads.madsmathprogbase(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsMathProgBase.jl:18

Arguments

  * `madsdata::Associative` : MADS problem dictionary [default=`Dict()`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsMathProgBase.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.madsoutput' href='#Mads.madsoutput'>#</a>
**`Mads.madsoutput`** &mdash; *Function*.



MADS output (controlled by `quiet` and `verbositylevel`)

Methods

  * `Mads.madsoutput(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:11
  * `Mads.madsoutput(message::AbstractString, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:11

Arguments

  * `level::Int64` : output verbosity level [default=`0`]
  * `message::AbstractString` : output message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.madsup' href='#Mads.madsup'>#</a>
**`Mads.madsup`** &mdash; *Function*.



Check the uptime of a series of servers

Methods

  * `Mads.madsup(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:315
  * `Mads.madsup()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:315

Arguments

  * `nodenames::Array{String,1}` : array with names of machines/nodes [default=`Mads.madsservers`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L308-L312' class='documenter-source'>source</a><br>

<a id='Mads.madswarn-Tuple{AbstractString}' href='#Mads.madswarn-Tuple{AbstractString}'>#</a>
**`Mads.madswarn`** &mdash; *Method*.



MADS warning messages

Methods

  * `Mads.madswarn(message::AbstractString)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:53

Arguments

  * `message::AbstractString` : warning message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLog.jl#L46-L50' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make a conditional log likelihood function that accepts an array containing the optimal parameter values

Methods

  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:104

Arguments

  * `conditionalloglikelihood` : conditional log likelihood
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * a conditional log likelihood function that accepts an array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L92-L100' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make array of conditional log-likelihoods

Methods

  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:160
  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:104

Arguments

  * `conditionalloglikelihood`
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * array of conditional log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsBayesInfoGap.jl#L149-L157' class='documenter-source'>source</a><br>

<a id='Mads.makearrayfunction' href='#Mads.makearrayfunction'>#</a>
**`Mads.makearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameter values

Methods

  * `Mads.makearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:32
  * `Mads.makearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:32

Arguments

  * `f::Function` : function [default=`makemadscommandfunction(madsdata)`]
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * function accepting an array containing the optimal parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L35-L43' class='documenter-source'>source</a><br>

<a id='Mads.makearrayloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayloglikelihood`** &mdash; *Method*.



Make a log likelihood function that accepts an array containing the optimal parameter values

Methods

  * `Mads.makearrayloglikelihood(madsdata::Associative, loglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:127

Arguments

  * `loglikelihood` : log likelihood
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * a log likelihood function that accepts an array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L115-L123' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt!-Tuple{Associative,Associative}' href='#Mads.makebigdt!-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt!`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Methods

  * `Mads.makebigdt!(madsdata::Associative, choice::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:35

Arguments

  * `choice::Associative` : dictionary of BIG-DT choices (scenarios)
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsBayesInfoGap.jl#L23-L31' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt-Tuple{Associative,Associative}' href='#Mads.makebigdt-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Methods

  * `Mads.makebigdt(madsdata::Associative, choice::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:20

Arguments

  * `choice::Associative` : dictionary of BIG-DT choices (scenarios)
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsBayesInfoGap.jl#L8-L16' class='documenter-source'>source</a><br>

<a id='Mads.makecomputeconcentrations-Tuple{Associative}' href='#Mads.makecomputeconcentrations-Tuple{Associative}'>#</a>
**`Mads.makecomputeconcentrations`** &mdash; *Method*.



Create a function to compute concentrations for all the observation points using Anasol

Methods

  * `Mads.makecomputeconcentrations(madsdata::Associative; calczeroweightobs, calcpredictions)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:172

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L150-L167' class='documenter-source'>source</a><br>

<a id='Mads.makedixonprice-Tuple{Integer}' href='#Mads.makedixonprice-Tuple{Integer}'>#</a>
**`Mads.makedixonprice`** &mdash; *Method*.



Make dixon price

Methods

  * `Mads.makedixonprice(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:260

Arguments

  * `n::Integer` : number of observations

Returns:

  * dixon price


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L249-L257' class='documenter-source'>source</a><br>

<a id='Mads.makedixonprice_gradient-Tuple{Integer}' href='#Mads.makedixonprice_gradient-Tuple{Integer}'>#</a>
**`Mads.makedixonprice_gradient`** &mdash; *Method*.



Methods

  * `Mads.makedixonprice(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:260

Arguments

  * `n::Integer` : number of observations

Returns:

  * dixon price gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L271-L276' class='documenter-source'>source</a><br>

<a id='Mads.makedoublearrayfunction' href='#Mads.makedoublearrayfunction'>#</a>
**`Mads.makedoublearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameter values, and returns an array of observations

Methods

  * `Mads.makedoublearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:77
  * `Mads.makedoublearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:77

Arguments

  * `f::Function` : function [default=`makemadscommandfunction(madsdata)`]
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * function accepting an array containing the optimal parameter values, and returning an array of observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L80-L88' class='documenter-source'>source</a><br>

<a id='Mads.makelmfunctions' href='#Mads.makelmfunctions'>#</a>
**`Mads.makelmfunctions`** &mdash; *Function*.



Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization

Methods

  * `Mads.makelmfunctions(f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:101
  * `Mads.makelmfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:122

Arguments

  * `f::Function` : Function
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * forward model, gradient, objective functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L222-L230' class='documenter-source'>source</a><br>

<a id='Mads.makelocalsafunction-Tuple{Associative}' href='#Mads.makelocalsafunction-Tuple{Associative}'>#</a>
**`Mads.makelocalsafunction`** &mdash; *Method*.



Make gradient function needed for local sensitivity analysis

Methods

  * `Mads.makelocalsafunction(madsdata::Associative; multiplycenterbyweights)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:26

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `multiplycenterbyweights` : multiply center by observation weights [default=`true`]

Returns:

  * gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L14-L22' class='documenter-source'>source</a><br>

<a id='Mads.makelogprior-Tuple{Associative}' href='#Mads.makelogprior-Tuple{Associative}'>#</a>
**`Mads.makelogprior`** &mdash; *Method*.



Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`

Methods

  * `Mads.makelogprior(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:409

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Return:

  * the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L398-L406' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunction-Tuple{Associative}' href='#Mads.makemadscommandfunction-Tuple{Associative}'>#</a>
**`Mads.makemadscommandfunction`** &mdash; *Method*.



Make MADS function to execute the model defined in the input MADS problem dictionary

Methods

  * `Mads.makemadscommandfunction(madsdata_in::Associative; calczeroweightobs, calcpredictions, obskeys)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:62

Arguments

  * `madsdata_in::Associative` : MADS problem dictionary

Keywords

  * `calcpredictions` : Calculate predictions [default=`true`]
  * `calczeroweightobs` : Calculate zero weight observations [default=`false`]
  * `obskeys`

Example:

```julia
Mads.makemadscommandfunction(madsdata)
```

MADS can be coupled with any internal or external model. The model coupling is defined in the MADS problem dictionary. The expectations is that for a given set of model inputs, the model will produce a model output that will be provided to MADS. The fields in the MADS problem dictionary that can be used to define the model coupling are:

  * `Model` : execute a Julia function defined in an input Julia file. The function that should accept a `parameter` dictionary with all the model parameters as an input argument and should return an `observation` dictionary with all the model predicted observations. MADS will execute the first function defined in the file.
  * `MADS model` : create a Julia function based on an input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary. MADS will execute the first function defined in the file. This function should a create a Julia function that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.
  * `Julia model` : execute an internal Julia function that accepts a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.
  * `Command` : execute an external UNIX command or script that will execute an external model.
  * `Julia command` : execute a Julia script that will execute an external model. The Julia script is defined in an input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary; MADS will execute the first function defined in the file. The Julia script should be capable to (1) execute the model (making a system call of an external model), (2) parse the model outputs, (3) return an `observation` dictionary with model predictions.

Both `Command` and `Julia command` can use different approaches to pass model parameters to the external model.

Only `Command` uses different approaches to get back the model outputs. The script defined under `Julia command` parses the model outputs using Julia.

The available options for writing model inputs and reading model outputs are as follows.

Options for writing model inputs:

  * `Templates` : template files for writing model input files as defined at http://mads.lanl.gov
  * `ASCIIParameters` : model parameters written in a ASCII file
  * `JLDParameters` : model parameters written in a JLD file
  * `YAMLParameters` : model parameters written in a YAML file
  * `JSONParameters` : model parameters written in a JSON file

Options for reading model outputs:

  * `Instructions` : instruction files for reading model output files as defined at http://mads.lanl.gov
  * `ASCIIPredictions` : model predictions read from a ASCII file
  * `JLDPredictions` : model predictions read from a JLD file
  * `YAMLPredictions` : model predictions read from a YAML file
  * `JSONPredictions` : model predictions read from a JSON file

Returns:

  * Mads function to execute a forward model simulation


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L8-L56' class='documenter-source'>source</a><br>

<a id='Mads.makemadsconditionalloglikelihood-Tuple{Associative}' href='#Mads.makemadsconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsconditionalloglikelihood`** &mdash; *Method*.



Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations. Model parameters and observations are defined in the MADS problem dictionary `madsdata`.

Methods

  * `Mads.makemadsconditionalloglikelihood(madsdata::Associative; weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:432

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `weightfactor` : Weight factor [default=`1`]

Return:

  * the conditional log-likelihood


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L419-L428' class='documenter-source'>source</a><br>

<a id='Mads.makemadsloglikelihood-Tuple{Associative}' href='#Mads.makemadsloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsloglikelihood`** &mdash; *Method*.



Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations. The function can be provided as an external function in the MADS problem dictionary under `LogLikelihood` or computed internally.

Methods

  * `Mads.makemadsloglikelihood(madsdata::Associative; weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:467

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `weightfactor` : Weight factor [default=`1`]

Returns:

  * the log-likelihood for a given set of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L454-L463' class='documenter-source'>source</a><br>

<a id='Mads.makemadsreusablefunction' href='#Mads.makemadsreusablefunction'>#</a>
**`Mads.makemadsreusablefunction`** &mdash; *Function*.



Make Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)

Methods

  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:286
  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function, suffix::String; usedict)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:286
  * `Mads.makemadsreusablefunction(paramkeys::Array{T<:Any,1}, obskeys::Array{T<:Any,1}, madsdatarestart::Union{Bool,String}, madscommandfunction::Function, restartdir::String; usedict)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:289

Arguments

  * `madscommandfunction::Function` : Mads function to execute a forward model simulation
  * `madsdata::Associative` : MADS problem dictionary
  * `madsdatarestart::Union{Bool,String}` : Restart type (memory/disk) or on/off status
  * `obskeys::Array{T<:Any,1}` : Dictionary of observation keys
  * `paramkeys::Array{T<:Any,1}` : Dictionary of parameter keys
  * `restartdir::String` : Restart directory where the reusable model results are stored
  * `suffix::String` : Suffix to be added to the name of restart directory

Keywords

  * `usedict` : Use dictionary [default=`true`]

Returns:

  * Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsFunc.jl#L304-L312' class='documenter-source'>source</a><br>

<a id='Mads.makempbfunctions-Tuple{Associative}' href='#Mads.makempbfunctions-Tuple{Associative}'>#</a>
**`Mads.makempbfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for MathProgBase optimization

Methods

  * `Mads.makempbfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsMathProgBase.jl:92

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * forward model, gradient, objective functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsMathProgBase.jl#L81-L89' class='documenter-source'>source</a><br>

<a id='Mads.makepowell-Tuple{Integer}' href='#Mads.makepowell-Tuple{Integer}'>#</a>
**`Mads.makepowell`** &mdash; *Method*.



Make Powell test function for LM optimization

Methods

  * `Mads.makepowell(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:163

Arguments

  * `n::Integer` : number of observations

Returns:

  * Powell test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L152-L160' class='documenter-source'>source</a><br>

<a id='Mads.makepowell_gradient-Tuple{Integer}' href='#Mads.makepowell_gradient-Tuple{Integer}'>#</a>
**`Mads.makepowell_gradient`** &mdash; *Method*.



ake parameter gradients of the Powell test function for LM optimization

Methods

  * `Mads.makepowell_gradient(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:187

Arguments

  * `n::Integer` : number of observations

Returns:

  * arameter gradients of the Powell test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L176-L184' class='documenter-source'>source</a><br>

<a id='Mads.makerosenbrock-Tuple{Integer}' href='#Mads.makerosenbrock-Tuple{Integer}'>#</a>
**`Mads.makerosenbrock`** &mdash; *Method*.



Make Rosenbrock test function for LM optimization

Methods

  * `Mads.makerosenbrock(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:118

Arguments

  * `n::Integer` : number of observations

Returns:

  * Rosenbrock test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L107-L115' class='documenter-source'>source</a><br>

<a id='Mads.makerosenbrock_gradient-Tuple{Integer}' href='#Mads.makerosenbrock_gradient-Tuple{Integer}'>#</a>
**`Mads.makerosenbrock_gradient`** &mdash; *Method*.



Make parameter gradients of the Rosenbrock test function for LM optimization

Methods

  * `Mads.makerosenbrock_gradient(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:140

Arguments

  * `n::Integer` : number of observations

Returns:

  * parameter gradients of the Rosenbrock test function for LM optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L129-L137' class='documenter-source'>source</a><br>

<a id='Mads.makerotatedhyperellipsoid-Tuple{Integer}' href='#Mads.makerotatedhyperellipsoid-Tuple{Integer}'>#</a>
**`Mads.makerotatedhyperellipsoid`** &mdash; *Method*.



Methods

  * `Mads.makerotatedhyperellipsoid(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:339

Arguments

  * `n::Integer` : number of observations

Returns:

  * rotated hyperellipsoid


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L330-L335' class='documenter-source'>source</a><br>

<a id='Mads.makerotatedhyperellipsoid_gradient-Tuple{Integer}' href='#Mads.makerotatedhyperellipsoid_gradient-Tuple{Integer}'>#</a>
**`Mads.makerotatedhyperellipsoid_gradient`** &mdash; *Method*.



Methods

  * `Mads.makerotatedhyperellipsoid_gradient(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:363

Arguments

  * `n::Integer` : number of observations

Returns:

  * rotated hyperellipsoid gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L354-L359' class='documenter-source'>source</a><br>

<a id='Mads.makesphere-Tuple{Integer}' href='#Mads.makesphere-Tuple{Integer}'>#</a>
**`Mads.makesphere`** &mdash; *Method*.



Make sphere

Methods

  * `Mads.makesphere(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:218

Arguments

  * `n::Integer` : number of observations

Returns:

  * sphere


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L207-L215' class='documenter-source'>source</a><br>

<a id='Mads.makesphere_gradient-Tuple{Integer}' href='#Mads.makesphere_gradient-Tuple{Integer}'>#</a>
**`Mads.makesphere_gradient`** &mdash; *Method*.



Make sphere gradient

Methods

  * `Mads.makesphere_gradient(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:239

Arguments

  * `n::Integer` : number of observations

Returns:

  * sphere gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L228-L236' class='documenter-source'>source</a><br>

<a id='Mads.makesumsquares-Tuple{Integer}' href='#Mads.makesumsquares-Tuple{Integer}'>#</a>
**`Mads.makesumsquares`** &mdash; *Method*.



Methods

  * `Mads.makesumsquares(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:301

Arguments

  * `n::Integer` : number of observations

Returns:

  * sumsquares


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L292-L297' class='documenter-source'>source</a><br>

<a id='Mads.makesumsquares_gradient-Tuple{Integer}' href='#Mads.makesumsquares_gradient-Tuple{Integer}'>#</a>
**`Mads.makesumsquares_gradient`** &mdash; *Method*.



Methods

  * `Mads.makesumsquares_gradient(n::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:320

Arguments

  * `n::Integer` : number of observations

Returns:

  * sumsquares gradient


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L311-L316' class='documenter-source'>source</a><br>

<a id='Mads.makesvrmodel' href='#Mads.makesvrmodel'>#</a>
**`Mads.makesvrmodel`** &mdash; *Function*.



Make SVR model functions (executor and cleaner)

Methods

  * `Mads.makesvrmodel(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:210
  * `Mads.makesvrmodel(madsdata::Associative, numberofsamples::Integer; check, addminmax, loadsvr, savesvr, svm_type, kernel_type, degree, gamma, coef0, C, nu, eps, cache_size, tol, shrinking, probability, verbose, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:210

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numberofsamples::Integer` : number of samples [default=`100`]

Keywords

  * `C` : cost; penalty parameter of the error term [default=`1000.0`]
  * `addminmax` : add parameter minimum / maximum range values in the training set [default=`true`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `check` : check SVR performance [default=`false`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types

[default=`0`]

  * `degree` : degree of the polynomial kernel [default=`3`]
  * `eps` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L176-L187' class='documenter-source'>source</a><br>

<a id='Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}' href='#Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.maxtorealmax!`** &mdash; *Method*.



Scale down values larger than max(Float32) in a dataframe `df` so that Gadfly can plot the data

Methods

  * `Mads.maxtorealmax!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1082

Arguments

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L1075-L1079' class='documenter-source'>source</a><br>

<a id='Mads.md-Tuple{}' href='#Mads.md-Tuple{}'>#</a>
**`Mads.md`** &mdash; *Method*.



Change the current directory to the Mads source dictionary

Methods

  * `Mads.md()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.meshgrid-Tuple{Array{T,1},Array{T,1}}' href='#Mads.meshgrid-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.meshgrid`** &mdash; *Method*.



Create mesh grid

Methods

  * `Mads.meshgrid(x::Array{T<:Any,1}, y::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:331

Arguments

  * `x::Array{T<:Any,1}` : vector of grid x coordinates
  * `y::Array{T<:Any,1}` : vector of grid y coordinates

Returns:

  * 2D grid coordinates based on the coordinates contained in vectors `x` and `y`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L319-L327' class='documenter-source'>source</a><br>

<a id='Mads.minimize-Tuple{Function,Array{T,1}}' href='#Mads.minimize-Tuple{Function,Array{T,1}}'>#</a>
**`Mads.minimize`** &mdash; *Method*.



Minimize Julia function using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Methods

  * `Mads.calibrate(madsdata::Associative; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, save_results, localsa)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:162

Arguments

  * `madsdata::Associative`

Keywords

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100.0`]
  * `lambda_mu` : lambda multiplication factor [default=`10.0`]
  * `localsa`
  * `maxEval` : maximum number of model evaluations [default=`1000`]
  * `maxIter` : maximum number of optimization iterations [default=`100`]
  * `maxJacobians` : maximum number of Jacobian solves [default=`100`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]
  * `save_results`
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function tolerance [default=`1e-3`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive`

Returns:

  * vector with the optimal parameter values at the minimum
  * optimization algorithm results (e.g. results.minimizer)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMinimization.jl#L1-L12' class='documenter-source'>source</a><br>

<a id='Mads.mkdir-Tuple{String}' href='#Mads.mkdir-Tuple{String}'>#</a>
**`Mads.mkdir`** &mdash; *Method*.



Create a directory (if does not already exist)

Methods

  * `Mads.mkdir(dirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1242

Arguments

  * `dirname::String` : directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1235-L1239' class='documenter-source'>source</a><br>

<a id='Mads.modelinformationcriteria' href='#Mads.modelinformationcriteria'>#</a>
**`Mads.modelinformationcriteria`** &mdash; *Function*.



Model section information criteria

Methods

  * `Mads.modelinformationcriteria(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:11
  * `Mads.modelinformationcriteria(madsdata::Associative, par::Array{Float64,N<:Any})` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:11

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `par::Array{Float64,N<:Any}` : parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsModelSelection.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.modobsweights!-Tuple{Associative,Number}' href='#Mads.modobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modobsweights!`** &mdash; *Method*.



Modify (multiply) observation weights in the MADS problem dictionary

Methods

  * `Mads.modobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:309

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `value::Number` : value for modifing observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L301-L305' class='documenter-source'>source</a><br>

<a id='Mads.modwellweights!-Tuple{Associative,Number}' href='#Mads.modwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modwellweights!`** &mdash; *Method*.



Modify (multiply) well weights in the MADS problem dictionary

Methods

  * `Mads.modwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:357

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `value::Number` : value for well weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L349-L353' class='documenter-source'>source</a><br>

<a id='Mads.montecarlo-Tuple{Associative}' href='#Mads.montecarlo-Tuple{Associative}'>#</a>
**`Mads.montecarlo`** &mdash; *Method*.



Monte Carlo analysis

Methods

  * `Mads.montecarlo(madsdata::Associative; N, filename)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:187

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples [default=`100`]
  * `filename` : file name to save Monte-Carlo results

Returns:

  * parameter dictionary containing the data arrays

Dumps:

  * YAML output file with the parameter dictionary containing the data arrays

Example:

```julia
Mads.montecarlo(madsdata; N=100)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L164-L182' class='documenter-source'>source</a><br>

<a id='Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}' href='#Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}'>#</a>
**`Mads.naive_get_deltax`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: get the LM parameter space step

Methods

  * `Mads.naive_get_deltax(JpJ::Array{Float64,2}, Jp::Array{Float64,2}, f0::Array{Float64,1}, lambda::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:247

Arguments

  * `Jp::Array{Float64,2}` : Jacobian matrix times model parameters
  * `JpJ::Array{Float64,2}` : Jacobian matrix times model parameters times transposed Jacobian matrix
  * `f0::Array{Float64,1}` : initial model observations
  * `lambda::Number` : Levenberg-Marquardt lambda

Returns:

  * the LM parameter space step


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L233-L241' class='documenter-source'>source</a><br>

<a id='Mads.naive_levenberg_marquardt' href='#Mads.naive_levenberg_marquardt'>#</a>
**`Mads.naive_levenberg_marquardt`** &mdash; *Function*.



Naive Levenberg-Marquardt optimization

Methods

  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:297
  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1}, o::Function; maxIter, maxEval, np_lambda, lambda, lambda_mu)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:297

Arguments

  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `o::Function` : objective function [default=x->(x'*x)[1]]
  * `x0::Array{Float64,1}` : initial parameter guess

Keywords

  * `lambda` : initial Levenberg-Marquardt lambda [default=`100`]
  * `lambda_mu` : lambda multiplication factor μ [default=`10`]
  * `maxEval` : maximum number of model evaluations [default=`101`]
  * `maxIter` : maximum number of optimization iterations [default=`10`]
  * `np_lambda` : number of parallel lambda solves [default=`10`]

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L278-L286' class='documenter-source'>source</a><br>

<a id='Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}' href='#Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}'>#</a>
**`Mads.naive_lm_iteration`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: perform LM iteration

Methods

  * `Mads.naive_lm_iteration(f::Function, g::Function, o::Function, x0::Array{Float64,1}, f0::Array{Float64,1}, lambdas::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:268

Arguments

  * `f0::Array{Float64,1}` : initial model observations
  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `lambdas::Array{Float64,1}` : Levenberg-Marquardt lambdas
  * `o::Function` : objective function
  * `x0::Array{Float64,1}` : initial parameter guess

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L252-L260' class='documenter-source'>source</a><br>

<a id='Mads.noplot-Tuple{}' href='#Mads.noplot-Tuple{}'>#</a>
**`Mads.noplot`** &mdash; *Method*.



Disable MADS plotting

Methods

  * `Mads.noplot()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:238


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L232-L236' class='documenter-source'>source</a><br>

<a id='Mads.obslineismatch-Tuple{String,Array{Regex,1}}' href='#Mads.obslineismatch-Tuple{String,Array{Regex,1}}'>#</a>
**`Mads.obslineismatch`** &mdash; *Method*.



Match an instruction line in the Mads instruction file with model input file

Methods

  * `Mads.obslineismatch(obsline::String, regexs::Array{Regex,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:923

Arguments

  * `obsline::String` : instruction line
  * `regexs::Array{Regex,1}` : regular expressions

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L911-L919' class='documenter-source'>source</a><br>

<a id='Mads.of' href='#Mads.of'>#</a>
**`Mads.of`** &mdash; *Function*.



Compute objective function

Methods

  * `Mads.of(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:59
  * `Mads.of(madsdata::Associative, resultvec::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:52
  * `Mads.of(madsdata::Associative, resultdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:56

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `resultdict::Associative` : result dictionary
  * `resultvec::Array{T<:Any,1}` : result vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L63-L67' class='documenter-source'>source</a><br>

<a id='Mads.paramarray2dict-Tuple{Associative,Array}' href='#Mads.paramarray2dict-Tuple{Associative,Array}'>#</a>
**`Mads.paramarray2dict`** &mdash; *Method*.



Convert a parameter array to a parameter dictionary of arrays

Methods

  * `Mads.paramarray2dict(madsdata::Associative, array::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:241

Arguments

  * `array::Array` : parameter array
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * a parameter dictionary of arrays


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L229-L237' class='documenter-source'>source</a><br>

<a id='Mads.paramdict2array-Tuple{Associative}' href='#Mads.paramdict2array-Tuple{Associative}'>#</a>
**`Mads.paramdict2array`** &mdash; *Method*.



Convert a parameter dictionary of arrays to a parameter array

Methods

  * `Mads.paramdict2array(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:260

Arguments

  * `dict::Associative` : parameter dictionary of arrays

Returns:

  * a parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L249-L257' class='documenter-source'>source</a><br>

<a id='Mads.parsemadsdata!-Tuple{Associative}' href='#Mads.parsemadsdata!-Tuple{Associative}'>#</a>
**`Mads.parsemadsdata!`** &mdash; *Method*.



Parse loaded MADS problem dictionary

Methods

  * `Mads.parsemadsdata!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:151

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L144-L148' class='documenter-source'>source</a><br>

<a id='Mads.parsenodenames' href='#Mads.parsenodenames'>#</a>
**`Mads.parsenodenames`** &mdash; *Function*.



Parse string with node names defined in SLURM

Methods

  * `Mads.parsenodenames(nodenames::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:207
  * `Mads.parsenodenames(nodenames::String, ntasks_per_node::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:207

Arguments

  * `nodenames::String` : string with node names defined in SLURM
  * `ntasks_per_node::Integer` : number of parallel tasks per node [default=`1`]

Returns:

  * vector with names of compute nodes (hosts)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L195-L203' class='documenter-source'>source</a><br>

<a id='Mads.partialof-Tuple{Associative,Associative,Regex}' href='#Mads.partialof-Tuple{Associative,Associative,Regex}'>#</a>
**`Mads.partialof`** &mdash; *Method*.



Compute the sum of squared residuals for observations that match a regular expression

Methods

  * `Mads.partialof(madsdata::Associative, resultdict::Associative, regex::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:85

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `regex::Regex` : regular expression
  * `resultdict::Associative` : result dictionary

Returns:

  * the sum of squared residuals for observations that match the regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L72-L80' class='documenter-source'>source</a><br>

<a id='Mads.pkgversion-Tuple{String}' href='#Mads.pkgversion-Tuple{String}'>#</a>
**`Mads.pkgversion`** &mdash; *Method*.



Get package version

Methods

  * `Mads.pkgversion(modulestr::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:374

Arguments

  * `modulestr::String`

Returns:

  * package version


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L364-L372' class='documenter-source'>source</a><br>

<a id='Mads.plotgrid' href='#Mads.plotgrid'>#</a>
**`Mads.plotgrid`** &mdash; *Function*.



Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

Methods

  * `Mads.plotgrid(madsdata::Associative; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:57
  * `Mads.plotgrid(madsdata::Associative, s::Array{Float64,N<:Any}; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:6
  * `Mads.plotgrid(madsdata::Associative, parameters::Associative; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:62

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameters::Associative` : dictionary with model parameters
  * `s::Array{Float64,N<:Any}` : model predictions array

Keywords

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlotPy.jl#L68-L80' class='documenter-source'>source</a><br>

<a id='Mads.plotlocalsa-Tuple{String}' href='#Mads.plotlocalsa-Tuple{String}'>#</a>
**`Mads.plotlocalsa`** &mdash; *Method*.



Plot local sensitivity analysis results

Methods

  * `Mads.plotlocalsa(filenameroot::String; keyword, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:1161

Arguments

  * `filenameroot::String` : problem file name root

Keywords

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : keyword to be added in the filename root

Dumps:

  * `filename` : output plot file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L1147-L1155' class='documenter-source'>source</a><br>

<a id='Mads.plotmadsproblem-Tuple{Associative}' href='#Mads.plotmadsproblem-Tuple{Associative}'>#</a>
**`Mads.plotmadsproblem`** &mdash; *Method*.



Plot contaminant sources and wells defined in MADS problem dictionary

Methods

  * `Mads.plotmadsproblem(madsdata::Associative; imagefile, format, filename, keyword)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:75

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `imagefile` : dump image file [default=`false`]
  * `keyword` : to be added in the filename

Dumps:

  * plot of contaminant sources and wells


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L60-L68' class='documenter-source'>source</a><br>

<a id='Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}' href='#Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}'>#</a>
**`Mads.plotmass`** &mdash; *Method*.



Plot injected/reduced contaminant mass

Methods

  * `Mads.plotmass(lambda::Array{Float64,1}, mass_injected::Array{Float64,1}, mass_reduced::Array{Float64,1}, filename::String; format)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasolPlot.jl:19

Arguments

  * `filename::String` : output filename for the generated plot
  * `lambda::Array{Float64,1}` : array with all the lambda values
  * `mass_injected::Array{Float64,1}` : array with associated total injected mass
  * `mass_reduced::Array{Float64,1}` : array with associated total reduced mass

Keywords

  * `format` : output plot format (`png`, `pdf`, etc.)

Dumps:

  * image file with name `filename` and in specified `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasolPlot.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.plotmatches' href='#Mads.plotmatches'>#</a>
**`Mads.plotmatches`** &mdash; *Function*.



Plot the matches between model predictions and observations

Methods

  * `Mads.plotmatches(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:147
  * `Mads.plotmatches(madsdata::Associative, rx::Regex; plotdata, filename, format, title, xtitle, ytitle, ymin, ymax, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:147
  * `Mads.plotmatches(madsdata::Associative, dict_in::Associative; plotdata, filename, format, title, xtitle, ytitle, ymin, ymax, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:179
  * `Mads.plotmatches(madsdata::Associative, result::Associative, rx::Regex; plotdata, filename, format, key2time, title, xtitle, ytitle, ymin, ymax, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:155

Arguments

  * `dict_in::Associative` : dictionary with model parameters
  * `madsdata::Associative` : MADS problem dictionary
  * `result::Associative` : dictionary with model predictions
  * `rx::Regex` : regular expression to filter the outputs

Keywords

  * `colors` : array with plot colors
  * `display` : display plots [default=`false`]
  * `dpi` : graph resolution [default=`Mads.dpi`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `hsize` : graph horizontal size [default=`6Gadfly.inch`]
  * `key2time` : user provided function to convert observation keys to observation times
  * `linewidth` : line width [default=`2Gadfly.pt`]
  * `noise` : random noise magnitude [default=`0`; no noise]
  * `obs_plot_dots` : plot data as dots or line [default=`true`]
  * `plotdata` : plot data (if `false` model predictions are ploted only) [default=`true`]
  * `pointsize` : data dot size [default=`4Gadfly.pt`]
  * `separate_files` : plot data for multiple wells separately [default=`false`]
  * `title` : graph title
  * `vsize` : graph vertical size [default=`4Gadfly.inch`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L325-L342' class='documenter-source'>source</a><br>

<a id='Mads.plotobsSAresults-Tuple{Associative,Associative}' href='#Mads.plotobsSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.plotobsSAresults`** &mdash; *Method*.



Plot the sensitivity analysis results for the observations

Methods

  * `Mads.plotobsSAresults(madsdata::Associative, result::Associative; filter, keyword, filename, format, debug, separate_files, xtitle, ytitle, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:553

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `result::Associative` : sensitivity analysis results

Keywords

  * `debug` : [default=`false`]
  * `filename` : output file name
  * `filter` : string or regex to plot only observations containing `filter`
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `keyword` : to be added in the auto-generated filename
  * `linewidth` : line width [default=`2Gadfly.pt`]
  * `pointsize` : point size [default=`2Gadfly.pt`]
  * `separate_files` : plot data for multiple wells separately [default=`false`]
  * `xtitle` : x-axis title [default=`"Time [years]"`]
  * `ytitle` : y-axis title [default=`"Concentration [ppb]"`]

Dumps:

  * plot of the sensitivity analysis results for the observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L531-L539' class='documenter-source'>source</a><br>

<a id='Mads.plotrobustnesscurves-Tuple{Associative,Dict}' href='#Mads.plotrobustnesscurves-Tuple{Associative,Dict}'>#</a>
**`Mads.plotrobustnesscurves`** &mdash; *Method*.



Plot BIG-DT robustness curves

Methods

  * `Mads.plotrobustnesscurves(madsdata::Associative, bigdtresults::Dict; filename, format, maxprob, maxhoriz)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGapPlot.jl:20

Arguments

  * `bigdtresults::Dict` : BIG-DT results
  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filename` : output file name used to dump plots
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `maxhoriz` : maximum horizon [default=`Inf`]
  * `maxprob` : maximum probability [default=`1.0`]

Dumps:

  * image file with name `filename` and in specified `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsBayesInfoGapPlot.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.plotseries' href='#Mads.plotseries'>#</a>
**`Mads.plotseries`** &mdash; *Function*.



Create plots of data series

Methods

  * `Mads.plotseries(X::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:1097
  * `Mads.plotseries(X::Array{T<:Any,2}, filename::String; format, xtitle, ytitle, title, name, combined, hsize, vsize, linewidth, dpi, colors)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:1097

Arguments

  * `X::Array{T<:Any,2}` : matrix with the series data
  * `filename::String` : output file name

Keywords

  * `colors` : colors to use in plots
  * `combined` : combine plots [default=`true`]
  * `dpi` : graph resolution [default=`Mads.dpi`]
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `hsize` : horizontal size [default=`6Gadfly.inch`]
  * `linewidth` : width of the lines in plot  [default=`2Gadfly.pt`]
  * `name` : series name [default=`Sources`]
  * `title` : plot title [default=`Sources`]
  * `vsize` : vertical size [default=`4Gadfly.inch`]
  * `xtitle` : x-axis title [default=`X`]
  * `ytitle` : y-axis title [default=`Y`]

Dumps:

  * Plots of data series


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L1074-L1082' class='documenter-source'>source</a><br>

<a id='Mads.plotwellSAresults' href='#Mads.plotwellSAresults'>#</a>
**`Mads.plotwellSAresults`** &mdash; *Function*.



Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

Methods

  * `Mads.plotwellSAresults(madsdata::Associative, result::Associative; xtitle, ytitle, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:418
  * `Mads.plotwellSAresults(madsdata::Associative, result::Associative, wellname::String; xtitle, ytitle, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:429

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `result::Associative` : sensitivity analysis results
  * `wellname::String` : well name

Keywords

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `xtitle` : x-axis title [default=`"Time [years]"`]
  * `ytitle` : y-axis title [default=`"Concentration [ppb]"`]

Dumps:

  * Plot of the sensitivity analysis results for all the wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L514-L522' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults-Tuple{Associative,Associative}' href='#Mads.printSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults`** &mdash; *Method*.



Print sensitivity analysis results

Methods

  * `Mads.printSAresults(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:918

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `results::Associative` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L910-L914' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults2-Tuple{Associative,Associative}' href='#Mads.printSAresults2-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults2`** &mdash; *Method*.



Print sensitivity analysis results (method 2)

Methods

  * `Mads.printSAresults2(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1000

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `results::Associative` : dictionary with sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L992-L996' class='documenter-source'>source</a><br>

<a id='Mads.printerrormsg-Tuple{Any}' href='#Mads.printerrormsg-Tuple{Any}'>#</a>
**`Mads.printerrormsg`** &mdash; *Method*.



Print error message

Methods

  * `Mads.printerrormsg(errmsg)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:311

Arguments

  * `errmsg` : error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L304-L308' class='documenter-source'>source</a><br>

<a id='Mads.printobservations' href='#Mads.printobservations'>#</a>
**`Mads.printobservations`** &mdash; *Function*.



Print (emit) observations in the MADS problem dictionary

Methods

  * `Mads.printobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:413
  * `Mads.printobservations(madsdata::Associative, io::IO)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:413
  * `Mads.printobservations(madsdata::Associative, filename::String; json)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:422

Arguments

  * `filename::String` : output file name
  * `io::IO` : output stream
  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `json`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L426-L430' class='documenter-source'>source</a><br>

<a id='Mads.pull' href='#Mads.pull'>#</a>
**`Mads.pull`** &mdash; *Function*.



Pull (checkout) the latest version of Mads modules

Methods

  * `Mads.pull(modulename::String; kw...)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63
  * `Mads.pull()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63

Arguments

  * `modulename::String` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L55-L59' class='documenter-source'>source</a><br>

<a id='Mads.push' href='#Mads.push'>#</a>
**`Mads.push`** &mdash; *Function*.



Push the latest version of Mads modules in the default remote repository

Methods

  * `Mads.push(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:132
  * `Mads.push()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:132

Arguments

  * `modulename::String` : module name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L125-L129' class='documenter-source'>source</a><br>

<a id='Mads.quietoff-Tuple{}' href='#Mads.quietoff-Tuple{}'>#</a>
**`Mads.quietoff`** &mdash; *Method*.



Make MADS not quiet

Methods

  * `Mads.quietoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:74


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L68-L72' class='documenter-source'>source</a><br>

<a id='Mads.quieton-Tuple{}' href='#Mads.quieton-Tuple{}'>#</a>
**`Mads.quieton`** &mdash; *Method*.



Make MADS quiet

Methods

  * `Mads.quieton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:65


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L59-L63' class='documenter-source'>source</a><br>

<a id='Mads.readasciipredictions-Tuple{String}' href='#Mads.readasciipredictions-Tuple{String}'>#</a>
**`Mads.readasciipredictions`** &mdash; *Method*.



Read MADS predictions from an ASCII file

Methods

  * `Mads.readasciipredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:44

Arguments

  * `filename::String` : ASCII file name

Returns:

  * MADS predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsASCII.jl#L33-L41' class='documenter-source'>source</a><br>

<a id='Mads.readmodeloutput-Tuple{Associative}' href='#Mads.readmodeloutput-Tuple{Associative}'>#</a>
**`Mads.readmodeloutput`** &mdash; *Method*.



Read model outputs saved for MADS

Methods

  * `Mads.readmodeloutput(madsdata::Associative; obskeys)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:703

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `obskeys` : observation keys [default=getobskeys(madsdata)]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L695-L699' class='documenter-source'>source</a><br>

<a id='Mads.readobservations' href='#Mads.readobservations'>#</a>
**`Mads.readobservations`** &mdash; *Function*.



Read observations

Methods

  * `Mads.readobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1020
  * `Mads.readobservations(madsdata::Associative, obskeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1020

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `obskeys::Array{T<:Any,1}` : observation keys [default=`getobskeys(madsdata)`]

Returns:

  * dictionary with Mads observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1008-L1016' class='documenter-source'>source</a><br>

<a id='Mads.readobservations_cmads-Tuple{Associative}' href='#Mads.readobservations_cmads-Tuple{Associative}'>#</a>
**`Mads.readobservations_cmads`** &mdash; *Method*.



Read observations using C MADS dynamic library

Methods

  * `Mads.readobservations_cmads(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:15

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-old/MadsCMads.jl#L4-L12' class='documenter-source'>source</a><br>

<a id='Mads.readyamlpredictions-Tuple{String}' href='#Mads.readyamlpredictions-Tuple{String}'>#</a>
**`Mads.readyamlpredictions`** &mdash; *Method*.



Read MADS model predictions from a YAML file `filename`

Methods

  * `Mads.readyamlpredictions(filename::String; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:126

Arguments

  * `filename::String` : file name

Keywords

  * `julia` : if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)

Returns:

  * data in yaml input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsYAML.jl#L114-L122' class='documenter-source'>source</a><br>

<a id='Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}' href='#Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}'>#</a>
**`Mads.regexs2obs`** &mdash; *Method*.



Get observations for a set of regular expressions

Methods

  * `Mads.regexs2obs(obsline::String, regexs::Array{Regex,1}, obsnames::Array{String,1}, getparamhere::Array{Bool,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:941

Arguments

  * `getparamhere::Array{Bool,1}` : parameters
  * `obsline::String` : observation line
  * `obsnames::Array{String,1}` : observation names
  * `regexs::Array{Regex,1}` : regular expressions

Returns:

  * `obsdict` : observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L927-L935' class='documenter-source'>source</a><br>

<a id='Mads.reload-Tuple{}' href='#Mads.reload-Tuple{}'>#</a>
**`Mads.reload`** &mdash; *Method*.



Reload Mads modules

Methods

  * `Mads.reload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:38


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsTest.jl#L32-L36' class='documenter-source'>source</a><br>

<a id='Mads.removesource!' href='#Mads.removesource!'>#</a>
**`Mads.removesource!`** &mdash; *Function*.



Remove a contamination source

Methods

  * `Mads.removesource!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:44
  * `Mads.removesource!(madsdata::Associative, sourceid::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:44

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `sourceid::Int64` : source id [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L36-L40' class='documenter-source'>source</a><br>

<a id='Mads.removesourceparameters!-Tuple{Associative}' href='#Mads.removesourceparameters!-Tuple{Associative}'>#</a>
**`Mads.removesourceparameters!`** &mdash; *Method*.



Remove contaminant source parameters

Methods

  * `Mads.removesourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:129

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsAnasol.jl#L122-L126' class='documenter-source'>source</a><br>

<a id='Mads.required' href='#Mads.required'>#</a>
**`Mads.required`** &mdash; *Function*.



Lists modules required by a module (Mads by default)

Methods

  * `Mads.required(modulename::String, filtermodule::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:17
  * `Mads.required(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:17
  * `Mads.required()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:17

Arguments

  * `filtermodule::String` : filter module name
  * `modulename::String` : module name [default=`"Mads"`]

Returns:

  * filtered modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.resetmodelruns-Tuple{}' href='#Mads.resetmodelruns-Tuple{}'>#</a>
**`Mads.resetmodelruns`** &mdash; *Method*.



Reset the model runs count to be equal to zero

Methods

  * `Mads.resetmodelruns()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:167


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L161-L165' class='documenter-source'>source</a><br>

<a id='Mads.residuals' href='#Mads.residuals'>#</a>
**`Mads.residuals`** &mdash; *Function*.



Compute residuals

Methods

  * `Mads.residuals(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:33
  * `Mads.residuals(madsdata::Associative, resultvec::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:7
  * `Mads.residuals(madsdata::Associative, resultdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:30

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `resultdict::Associative` : result dictionary
  * `resultvec::Array{T<:Any,1}` : result vector

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsLevenbergMarquardt.jl#L37-L45' class='documenter-source'>source</a><br>

<a id='Mads.restartoff-Tuple{}' href='#Mads.restartoff-Tuple{}'>#</a>
**`Mads.restartoff`** &mdash; *Method*.



MADS restart off

Methods

  * `Mads.restartoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:45


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L39-L43' class='documenter-source'>source</a><br>

<a id='Mads.restarton-Tuple{}' href='#Mads.restarton-Tuple{}'>#</a>
**`Mads.restarton`** &mdash; *Method*.



MADS restart on

Methods

  * `Mads.restarton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:36


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L30-L34' class='documenter-source'>source</a><br>

<a id='Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}' href='#Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}'>#</a>
**`Mads.reweighsamples`** &mdash; *Method*.



Reweigh samples using importance sampling – returns a vector of log-likelihoods after reweighing

Methods

  * `Mads.reweighsamples(madsdata::Associative, predictions::Array, oldllhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:324

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `oldllhoods::Array{T<:Any,1}` : the log likelihoods of the parameters in the old distribution
  * `predictions::Array` : the model predictions for each of the samples

Returns:

  * vector of log-likelihoods after reweighing


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L311-L319' class='documenter-source'>source</a><br>

<a id='Mads.rmdir-Tuple{String}' href='#Mads.rmdir-Tuple{String}'>#</a>
**`Mads.rmdir`** &mdash; *Method*.



Remove directory

Methods

  * `Mads.rmdir(dir::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1114

Arguments

  * `dir::String` : directory to be removed

Keywords

  * `path` : path of the directory [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1106-L1110' class='documenter-source'>source</a><br>

<a id='Mads.rmfile-Tuple{String}' href='#Mads.rmfile-Tuple{String}'>#</a>
**`Mads.rmfile`** &mdash; *Method*.



Remove file

Methods

  * `Mads.rmfile(filename::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1130

Arguments

  * `filename::String` : file to be removed

Keywords

  * `path` : path of the file [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1122-L1126' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles-Tuple{Regex}' href='#Mads.rmfiles-Tuple{Regex}'>#</a>
**`Mads.rmfiles`** &mdash; *Method*.



Remove files

Methods

  * `Mads.rmfile(filename::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1130

Arguments

  * `filename::String`

Keywords

  * `path` : path of the file [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1138-L1142' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_ext-Tuple{String}' href='#Mads.rmfiles_ext-Tuple{String}'>#</a>
**`Mads.rmfiles_ext`** &mdash; *Method*.



Remove files with extension `ext`

Methods

  * `Mads.rmfiles_ext(ext::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1159

Arguments

  * `ext::String` : extension

Keywords

  * `path` : path of the files to be removed [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1151-L1155' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_root-Tuple{String}' href='#Mads.rmfiles_root-Tuple{String}'>#</a>
**`Mads.rmfiles_root`** &mdash; *Method*.



Remove files with root `root`

Methods

  * `Mads.rmfiles_root(root::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1172

Arguments

  * `root::String` : root

Keywords

  * `path` : path of the files to be removed [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1164-L1168' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock-Tuple{Array{T,1}}' href='#Mads.rosenbrock-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock`** &mdash; *Method*.



Rosenbrock test function

Methods

  * `Mads.rosenbrock(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:43

Arguments

  * `x::Array{T<:Any,1}` : parameter vector

Returns:

  * test result


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods

  * `Mads.rosenbrock2_gradient_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:24

Arguments

  * `x::Array{T<:Any,1}` : parameter vector

Returns:

  * parameter gradients


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L13-L21' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_lm`** &mdash; *Method*.



Rosenbrock test function (more difficult to solve)

Methods

  * `Mads.rosenbrock2_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:10

Arguments

  * `x::Array{T<:Any,1}` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}' href='#Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient!`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods

  * `Mads.rosenbrock_gradient!(x::Array{T<:Any,1}, grad::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:68

Arguments

  * `grad::Array{T<:Any,1}` : gradient vector
  * `x::Array{T<:Any,1}` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L60-L64' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separately)

Methods

  * `Mads.rosenbrock_gradient_lm(x::Array{T<:Any,1}; dx, center)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:85

Arguments

  * `x::Array{T<:Any,1}` : parameter vector

Keywords

  * `center` : array with parameter observations at the center applied to compute numerical derivatives [default=`Array{Float64}(0)`]
  * `dx` : apply parameter step to compute numerical derivatives [default=`false`]

Returns:

  * parameter gradients


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L72-L80' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}' href='#Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}'>#</a>
**`Mads.rosenbrock_hessian!`** &mdash; *Method*.



Parameter Hessian of the Rosenbrock test function

Methods

  * `Mads.rosenbrock_hessian!(x::Array{T<:Any,1}, hess::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:101

Arguments

  * `hess::Array{T<:Any,2}` : Hessian matrix
  * `x::Array{T<:Any,1}` : parameter vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L93-L97' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_lm`** &mdash; *Method*.



Rosenbrock test function for LM optimization (returns the 2 components separately)

Methods

  * `Mads.rosenbrock_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:57

Arguments

  * `x::Array{T<:Any,1}` : parameter vector

Returns:

  * test result


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsTestFunctions.jl#L46-L54' class='documenter-source'>source</a><br>

<a id='Mads.runcmd' href='#Mads.runcmd'>#</a>
**`Mads.runcmd`** &mdash; *Function*.



Run external command and pipe stdout and stderr

Methods

  * `Mads.runcmd(cmdstring::String; pipe, quiet, waittime)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:97
  * `Mads.runcmd(cmd::Cmd; pipe, quiet, waittime)` : /Users/monty/.julia/v0.5/Mads/src/MadsExecute.jl:42

Arguments

  * `cmd::Cmd` : command (as a julia command; e.g. `ls`)
  * `cmdstring::String` : command (as a string; e.g. "ls")

Keywords

  * `pipe` : [default=`false`]
  * `quiet` : [default=`Mads.quiet`]
  * `waittime` : wait time is second [default=`Mads.executionwaittime`]

Returns:

  * command output
  * command error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsExecute.jl#L107-L116' class='documenter-source'>source</a><br>

<a id='Mads.runremote' href='#Mads.runremote'>#</a>
**`Mads.runremote`** &mdash; *Function*.



Run remote command on a series of servers

Methods

  * `Mads.runremote(cmd::String, nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:283
  * `Mads.runremote(cmd::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:283

Arguments

  * `cmd::String` : remote command
  * `nodenames::Array{String,1}` : names of machines/nodes [default=`Mads.madsservers`]

Returns:

  * output of running remote command


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L271-L279' class='documenter-source'>source</a><br>

<a id='Mads.saltelli-Tuple{Associative}' href='#Mads.saltelli-Tuple{Associative}'>#</a>
**`Mads.saltelli`** &mdash; *Method*.



Saltelli sensitivity analysis

Methods

  * `Mads.saltelli(madsdata::Associative; N, seed, parallel, restartdir, checkpointfrequency)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:637

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples [default=`100`]
  * `checkpointfrequency` : check point frequency [default=`N`]
  * `parallel` : set to true if the model runs should be performed in parallel [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L625-L629' class='documenter-source'>source</a><br>

<a id='Mads.saltellibrute-Tuple{Associative}' href='#Mads.saltellibrute-Tuple{Associative}'>#</a>
**`Mads.saltellibrute`** &mdash; *Method*.



Saltelli sensitivity analysis (brute force)

Methods

  * `Mads.saltellibrute(madsdata::Associative; N, seed, restartdir)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:449

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples [default=`1000`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `seed` : random seed [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L439-L443' class='documenter-source'>source</a><br>

<a id='Mads.saltellibruteparallel-Tuple{Associative,Integer}' href='#Mads.saltellibruteparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltellibruteparallel`** &mdash; *Method*.



Parallel version of saltellibrute


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L869' class='documenter-source'>source</a><br>

<a id='Mads.saltelliparallel-Tuple{Associative,Integer}' href='#Mads.saltelliparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltelliparallel`** &mdash; *Method*.



Parallel version of saltelli


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L869' class='documenter-source'>source</a><br>

<a id='Mads.sampling-Tuple{Array{T,1},Array,Number}' href='#Mads.sampling-Tuple{Array{T,1},Array,Number}'>#</a>
**`Mads.sampling`** &mdash; *Method*.



Methods

  * `Mads.sampling(param::Array{T<:Any,1}, J::Array, numsamples::Number; seed, scale)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:273

Arguments

  * `J::Array` : Jacobian matrix
  * `numsamples::Number` : Number of samples
  * `param::Array{T<:Any,1}` : Parameter vector

Keywords

  * `scale` : data scaling [default=`1`]
  * `seed` : random esee [default=`0`]

Returns:

  * generated samples (vector or array)
  * vector of log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L259-L269' class='documenter-source'>source</a><br>

<a id='Mads.savemadsfile' href='#Mads.savemadsfile'>#</a>
**`Mads.savemadsfile`** &mdash; *Function*.



Save MADS problem dictionary `madsdata` in MADS input file `filename`

Methods

  * `Mads.savemadsfile(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:262
  * `Mads.savemadsfile(madsdata::Associative, filename::String; julia, observations_separate)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:262
  * `Mads.savemadsfile(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:280
  * `Mads.savemadsfile(madsdata::Associative, parameters::Associative, filename::String; julia, explicit, observations_separate)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:280

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)
  * `madsdata::Associative` : MADS problem dictionary
  * `parameters::Associative` : Dictionary with parameters (optional)

Keywords

  * `explicit` : if `true` ignores MADS YAML file modifications and rereads the original input file [default=`false`]
  * `julia` : if `true` use Julia JSON module to save [default=`false`]
  * `observations_separate`

Example:

```julia
Mads.savemadsfile(madsdata)
Mads.savemadsfile(madsdata, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads", explicit=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L313-L326' class='documenter-source'>source</a><br>

<a id='Mads.savemcmcresults-Tuple{Array,String}' href='#Mads.savemcmcresults-Tuple{Array,String}'>#</a>
**`Mads.savemcmcresults`** &mdash; *Method*.



Save MCMC chain in a file

Methods

  * `Mads.savemcmcresults(chain::Array, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:142

Arguments

  * `chain::Array` : MCMC chain
  * `filename::String` : file name

Dumps:

  * the file containing MCMC chain


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMonteCarlo.jl#L130-L138' class='documenter-source'>source</a><br>

<a id='Mads.savesaltellirestart-Tuple{Array,String,String}' href='#Mads.savesaltellirestart-Tuple{Array,String,String}'>#</a>
**`Mads.savesaltellirestart`** &mdash; *Method*.



Save Saltelli sensitivity analysis results for fast simulation restarts

Methods

  * `Mads.savesaltellirestart(evalmat::Array, matname::String, restartdir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:618

Arguments

  * `evalmat::Array` : saved array
  * `matname::String` : matrix (array) name (defines the name of the loaded file)
  * `restartdir::String` : directory where files will be stored containing model results for fast simulation restarts


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L609-L613' class='documenter-source'>source</a><br>

<a id='Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}' href='#Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}'>#</a>
**`Mads.scatterplotsamples`** &mdash; *Method*.



Create histogram/scatter plots of model parameter samples

Methods

  * `Mads.scatterplotsamples(madsdata::Associative, samples::Array{T<:Any,2}, filename::String; format, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:380

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : MADS problem dictionary
  * `samples::Array{T<:Any,2}` : matrix with model parameters

Keywords

  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `pointsize` : point size [default=`0.9Gadfly.mm`]

Dumps:

  * histogram/scatter plots of model parameter samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L365-L373' class='documenter-source'>source</a><br>

<a id='Mads.searchdir' href='#Mads.searchdir'>#</a>
**`Mads.searchdir`** &mdash; *Function*.



Get files in the current directory or in a directory defined by `path` matching pattern `key` which can be a string or regular expression

Methods

  * `Mads.searchdir(key::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:743
  * `Mads.searchdir(key::Regex; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:742

Arguments

  * `key::Regex` : matching pattern for Mads input files (string or regular expression accepted)
  * `key::String` : matching pattern for Mads input files (string or regular expression accepted)

Keywords

  * `path` : search directory for the mads input files [default=`.`]

Returns:

  * `filename` : an array with file names matching the pattern in the specified directory

Examples:

```julia
- `Mads.searchdir("a")`
- `Mads.searchdir(r"[A-B]"; path = ".")`
- `Mads.searchdir(r".*.cov"; path = ".")`
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L745-L761' class='documenter-source'>source</a><br>

<a id='Mads.set_nprocs_per_task' href='#Mads.set_nprocs_per_task'>#</a>
**`Mads.set_nprocs_per_task`** &mdash; *Function*.



Set number of processors needed for each parallel task at each node

Methods

  * `Mads.set_nprocs_per_task()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:27
  * `Mads.set_nprocs_per_task(local_nprocs_per_task::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:27

Arguments

  * `local_nprocs_per_task::Integer`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L21-L25' class='documenter-source'>source</a><br>

<a id='Mads.setallparamsoff!-Tuple{Associative}' href='#Mads.setallparamsoff!-Tuple{Associative}'>#</a>
**`Mads.setallparamsoff!`** &mdash; *Method*.



Set all parameters OFF

Methods

  * `Mads.setallparamsoff!(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:470

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filter` : parameter filter


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L462-L466' class='documenter-source'>source</a><br>

<a id='Mads.setallparamson!-Tuple{Associative}' href='#Mads.setallparamson!-Tuple{Associative}'>#</a>
**`Mads.setallparamson!`** &mdash; *Method*.



Set all parameters ON

Methods

  * `Mads.setallparamson!(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:456

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filter` : parameter filter


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L448-L452' class='documenter-source'>source</a><br>

<a id='Mads.setdebuglevel-Tuple{Int64}' href='#Mads.setdebuglevel-Tuple{Int64}'>#</a>
**`Mads.setdebuglevel`** &mdash; *Method*.



Set MADS debug level

Methods

  * `Mads.setdebuglevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:138

Arguments

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L131-L135' class='documenter-source'>source</a><br>

<a id='Mads.setdefaultplotformat-Tuple{String}' href='#Mads.setdefaultplotformat-Tuple{String}'>#</a>
**`Mads.setdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)

Methods

  * `Mads.setdefaultplotformat(format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:16

Arguments

  * `format::String` : plot format


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L9-L13' class='documenter-source'>source</a><br>

<a id='Mads.setdir' href='#Mads.setdir'>#</a>
**`Mads.setdir`** &mdash; *Function*.



Set the working directory (for parallel environments)

Methods

  * `Mads.setdir()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:253
  * `Mads.setdir(dir)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:248

Arguments

  * `dir` : directory

Example:

```julia
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L257-L268' class='documenter-source'>source</a><br>

<a id='Mads.setexecutionwaittime-Tuple{Float64}' href='#Mads.setexecutionwaittime-Tuple{Float64}'>#</a>
**`Mads.setexecutionwaittime`** &mdash; *Method*.



Set maximum execution wait time for forward model runs in seconds

Methods

  * `Mads.setexecutionwaittime(waitime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:158

Arguments

  * `waitime::Float64` : maximum execution wait time for forward model runs in seconds


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L151-L155' class='documenter-source'>source</a><br>

<a id='Mads.setmadsinputfile-Tuple{String}' href='#Mads.setmadsinputfile-Tuple{String}'>#</a>
**`Mads.setmadsinputfile`** &mdash; *Method*.



Set a default MADS input file

Methods

  * `Mads.setmadsinputfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:340

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L333-L337' class='documenter-source'>source</a><br>

<a id='Mads.setmodelinputs-Tuple{Associative,Associative}' href='#Mads.setmodelinputs-Tuple{Associative,Associative}'>#</a>
**`Mads.setmodelinputs`** &mdash; *Method*.



Set model input files; delete files where model output should be saved for MADS

Methods

  * `Mads.setmodelinputs(madsdata::Associative, parameters::Associative; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:635

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameters::Associative` : parameters

Keywords

  * `path` : path for the files [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L626-L630' class='documenter-source'>source</a><br>

<a id='Mads.setnewmadsfilename' href='#Mads.setnewmadsfilename'>#</a>
**`Mads.setnewmadsfilename`** &mdash; *Function*.



Set new mads file name

Methods

  * `Mads.setnewmadsfilename(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:494
  * `Mads.setnewmadsfilename(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:491

Arguments

  * `filename::String` : file name
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * new file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L508-L516' class='documenter-source'>source</a><br>

<a id='Mads.setobservationtargets!-Tuple{Associative,Associative}' href='#Mads.setobservationtargets!-Tuple{Associative,Associative}'>#</a>
**`Mads.setobservationtargets!`** &mdash; *Method*.



Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary

Methods

  * `Mads.setobservationtargets!(madsdata::Associative, predictions::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:518

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `predictions::Associative` : dictionary with model predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L510-L514' class='documenter-source'>source</a><br>

<a id='Mads.setobstime!' href='#Mads.setobstime!'>#</a>
**`Mads.setobstime!`** &mdash; *Function*.



Set observation time based on the observation name in the MADS problem dictionary

Methods

  * `Mads.setobstime!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:249
  * `Mads.setobstime!(madsdata::Associative, separator::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:249
  * `Mads.setobstime!(madsdata::Associative, rx::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:260

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `rx::Regex` : regular expression to match
  * `separator::String` : separator [default=`_`]

Examples:

```julia
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L271-L282' class='documenter-source'>source</a><br>

<a id='Mads.setobsweights!-Tuple{Associative,Number}' href='#Mads.setobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setobsweights!`** &mdash; *Method*.



Set observation weights in the MADS problem dictionary

Methods

  * `Mads.setobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:295

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `value::Number` : value for observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L287-L291' class='documenter-source'>source</a><br>

<a id='Mads.setparamoff!-Tuple{Associative,String}' href='#Mads.setparamoff!-Tuple{Associative,String}'>#</a>
**`Mads.setparamoff!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` OFF

Methods

  * `Mads.setparamoff!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:495

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L487-L491' class='documenter-source'>source</a><br>

<a id='Mads.setparamon!-Tuple{Associative,String}' href='#Mads.setparamon!-Tuple{Associative,String}'>#</a>
**`Mads.setparamon!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` ON

Methods

  * `Mads.setparamon!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:484

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L476-L480' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistnormal!`** &mdash; *Method*.



Set normal parameter distributions for all the model parameters in the MADS problem dictionary

Methods

  * `Mads.setparamsdistnormal!(madsdata::Associative, mean::Array{T<:Any,1}, stddev::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:507

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `mean::Array{T<:Any,1}` : array with the mean values
  * `stddev::Array{T<:Any,1}` : array with the standard deviation values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L498-L502' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistuniform!`** &mdash; *Method*.



Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

Methods

  * `Mads.setparamsdistuniform!(madsdata::Associative, min::Array{T<:Any,1}, max::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:522

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `max::Array{T<:Any,1}` : array with the maximum values
  * `min::Array{T<:Any,1}` : array with the minimum values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L513-L517' class='documenter-source'>source</a><br>

<a id='Mads.setparamsinit!' href='#Mads.setparamsinit!'>#</a>
**`Mads.setparamsinit!`** &mdash; *Function*.



Set initial optimized parameter guesses in the MADS problem dictionary

Methods

  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:320
  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative, idx::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:320

Arguments

  * `idx::Int64` : index of the dictionary of arrays with initial model parameter values
  * `madsdata::Associative` : MADS problem dictionary
  * `paramdict::Associative` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L310-L314' class='documenter-source'>source</a><br>

<a id='Mads.setplotfileformat-Tuple{String,String}' href='#Mads.setplotfileformat-Tuple{String,String}'>#</a>
**`Mads.setplotfileformat`** &mdash; *Method*.



Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

Methods

  * `Mads.setplotfileformat(filename::String, format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:36

Arguments

  * `filename::String` : output file name
  * `format::String` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]

Returns:

  * output file name
  * output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L23-L32' class='documenter-source'>source</a><br>

<a id='Mads.setprocs' href='#Mads.setprocs'>#</a>
**`Mads.setprocs`** &mdash; *Function*.



Set the available processors based on environmental variables (supports SLURM only at the moment)

Methods

  * `Mads.setprocs(; ntasks_per_node, mads_servers, test, dir, exename, nprocs_per_task, nodenames, quiet)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:45
  * `Mads.setprocs(np::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:42
  * `Mads.setprocs(np::Integer, nt::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:29

Arguments

  * `np::Integer` : number of processors [default=`1`]
  * `nt::Integer` : number of threads[default=`1`]

Keywords

  * `dir` : common directory shared by all the jobs
  * `exename` : location of the julia executable (the same version of julia is needed on all the workers)
  * `mads_servers` : if `true` use MADS servers (LANL only) [default=`false`]
  * `nodenames` : array with names of machines/nodes to be invoked
  * `nprocs_per_task` : number of processors needed for each parallel task at each node [default=`Mads.nprocs_per_task`]
  * `ntasks_per_node` : number of parallel tasks per node [default=`0`]
  * `quiet` : suppress output [default=`Mads.quiet`]
  * `test` : test the servers and connect to each one ones at a time [default=`false`]

Returns:

  * vector with names of compute nodes (hosts)

Example:

```julia
Mads.setprocs()
Mads.setprocs(4)
Mads.setprocs(4, 8)
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=Mads.madsservers)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsParallel.jl#L161-L183' class='documenter-source'>source</a><br>

<a id='Mads.setseed' href='#Mads.setseed'>#</a>
**`Mads.setseed`** &mdash; *Function*.



Set / get current random seed. seed < 0 gets seed, anything else sets it.

Methods

  * `Mads.setseed()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:346
  * `Mads.setseed(seed::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:346
  * `Mads.setseed(seed::Integer, quiet::Bool)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:346

Arguments

  * `quiet::Bool` : [default=`true`]
  * `seed::Integer` : random seed


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L338-L342' class='documenter-source'>source</a><br>

<a id='Mads.setsourceinit!' href='#Mads.setsourceinit!'>#</a>
**`Mads.setsourceinit!`** &mdash; *Function*.



Set initial optimized parameter guesses in the MADS problem dictionary for the Source class

Methods

  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:320
  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative, idx::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:320

Arguments

  * `idx::Int64` : index of the dictionary of arrays with initial model parameter values
  * `madsdata::Associative` : MADS problem dictionary
  * `paramdict::Associative` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L333-L337' class='documenter-source'>source</a><br>

<a id='Mads.settarget!-Tuple{Associative,Number}' href='#Mads.settarget!-Tuple{Associative,Number}'>#</a>
**`Mads.settarget!`** &mdash; *Method*.



Set observation target

Methods

  * `Mads.settarget!(o::Associative, target::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:239

Arguments

  * `o::Associative` : observation data
  * `target::Number` : observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L231-L235' class='documenter-source'>source</a><br>

<a id='Mads.settime!-Tuple{Associative,Number}' href='#Mads.settime!-Tuple{Associative,Number}'>#</a>
**`Mads.settime!`** &mdash; *Method*.



Set observation time

Methods

  * `Mads.settime!(o::Associative, time::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:161

Arguments

  * `o::Associative` : observation data
  * `time::Number` : observation time


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L153-L157' class='documenter-source'>source</a><br>

<a id='Mads.setverbositylevel-Tuple{Int64}' href='#Mads.setverbositylevel-Tuple{Int64}'>#</a>
**`Mads.setverbositylevel`** &mdash; *Method*.



Set MADS verbosity level

Methods

  * `Mads.setverbositylevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:148

Arguments

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L141-L145' class='documenter-source'>source</a><br>

<a id='Mads.setweight!-Tuple{Associative,Number}' href='#Mads.setweight!-Tuple{Associative,Number}'>#</a>
**`Mads.setweight!`** &mdash; *Method*.



Set observation weight

Methods

  * `Mads.setweight!(o::Associative, weight::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:200

Arguments

  * `o::Associative` : observation data
  * `weight::Number` : observation weight


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L192-L196' class='documenter-source'>source</a><br>

<a id='Mads.setwellweights!-Tuple{Associative,Number}' href='#Mads.setwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setwellweights!`** &mdash; *Method*.



Set well weights in the MADS problem dictionary

Methods

  * `Mads.setwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:340

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `value::Number` : value for well weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L332-L336' class='documenter-source'>source</a><br>

<a id='Mads.showallparameters-Tuple{Associative}' href='#Mads.showallparameters-Tuple{Associative}'>#</a>
**`Mads.showallparameters`** &mdash; *Method*.



Show all parameters in the MADS problem dictionary

Methods

  * `Mads.showallparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:602

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L595-L599' class='documenter-source'>source</a><br>

<a id='Mads.showobservations-Tuple{Associative}' href='#Mads.showobservations-Tuple{Associative}'>#</a>
**`Mads.showobservations`** &mdash; *Method*.



Show observations in the MADS problem dictionary

Methods

  * `Mads.showobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:393

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L386-L390' class='documenter-source'>source</a><br>

<a id='Mads.showparameters-Tuple{Associative}' href='#Mads.showparameters-Tuple{Associative}'>#</a>
**`Mads.showparameters`** &mdash; *Method*.



Show parameters in the MADS problem dictionary

Methods

  * `Mads.showparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:566

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsParameters.jl#L559-L563' class='documenter-source'>source</a><br>

<a id='Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransform`** &mdash; *Method*.



Sine transformation of model parameters

Methods

  * `Mads.sinetransform(sineparams::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:37

Arguments

  * `indexlogtransformed::Array{T<:Any,1}` : index vector of log-transformed parameters
  * `lowerbounds::Array{T<:Any,1}` : lower bounds
  * `sineparams::Array{T<:Any,1}` : model parameters
  * `upperbounds::Array{T<:Any,1}` : upper bounds

Returns:

  * Sine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSineTransformations.jl#L23-L31' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformfunction`** &mdash; *Method*.



Sine transformation of a function

Methods

  * `Mads.sinetransformfunction(f::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:56

Arguments

  * `f::Function` : function
  * `indexlogtransformed::Array{T<:Any,1}` : index vector of log-transformed parameters
  * `lowerbounds::Array{T<:Any,1}` : lower bounds
  * `upperbounds::Array{T<:Any,1}` : upper bounds

Returns:

  * Sine transformation


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSineTransformations.jl#L42-L50' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformgradient`** &mdash; *Method*.



Sine transformation of a gradient function

Methods

  * `Mads.sinetransformgradient(g::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1}; sindx)` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:77

Arguments

  * `g::Function` : gradient function
  * `indexlogtransformed::Array{T<:Any,1}` : index vector of log-transformed parameters
  * `lowerbounds::Array{T<:Any,1}` : vector with parameter lower bounds
  * `upperbounds::Array{T<:Any,1}` : vector with parameter upper bounds

Keywords

  * `sindx` : sin-space parameter step applied to compute numerical derivatives [default=`0.1`]

Returns:

  * Sine transformation of a gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSineTransformations.jl#L62-L70' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplot' href='#Mads.spaghettiplot'>#</a>
**`Mads.spaghettiplot`** &mdash; *Function*.



Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

Methods

  * `Mads.spaghettiplot(madsdata::Associative, number_of_samples::Integer; kw...)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:867
  * `Mads.spaghettiplot(madsdata::Associative, dictarray::Associative; seed, kw...)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:871
  * `Mads.spaghettiplot(madsdata::Associative, array::Array; plotdata, filename, keyword, format, xtitle, ytitle, yfit, obs_plot_dots, linewidth, pointsize, grayscale)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:908

Arguments

  * `array::Array` : data arrays to be plotted
  * `dictarray::Associative` : dictionary array containing the data arrays to be plotted
  * `madsdata::Associative` : MADS problem dictionary
  * `number_of_samples::Integer` : number of samples

Keywords

  * `filename` : output file name used to output the produced plots
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `grayscale`
  * `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)
  * `linewidth` : width of the lines in plot [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)
  * `plotdata` : plot data (if `false` model predictions are plotted only) [default=`true`]
  * `pointsize` : size of the markers in plot [default=`4Gadfly.pt`]
  * `seed` : random seed [default=`0`]
  * `xtitle` : `x` axis title [default=`X`]
  * `yfit` : fit vertical axis range [default=`false`]
  * `ytitle` : `y` axis title [default=`Y`]

Dumps:

  * Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplot(madsdata, dictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, array; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L1040-L1056' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplots' href='#Mads.spaghettiplots'>#</a>
**`Mads.spaghettiplots`** &mdash; *Function*.



Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

Methods

  * `Mads.spaghettiplots(madsdata::Associative, number_of_samples::Integer; seed, kw...)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:708
  * `Mads.spaghettiplots(madsdata::Associative, paramdictarray::DataStructures.OrderedDict; format, keyword, xtitle, ytitle, obs_plot_dots, seed, grayscale, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:713

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `number_of_samples::Integer` : number of samples
  * `paramdictarray::DataStructures.OrderedDict` : parameter dictionary containing the data arrays to be plotted

Keywords

  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `grayscale`
  * `keyword` : keyword to be added in the file name used to output the produced plots
  * `linewidth` : width of the lines on the plot [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` (default) or `false`)
  * `pointsize` : size of the markers on the plot [default=`4Gadfly.pt`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsPlot.jl#L838-L853' class='documenter-source'>source</a><br>

<a id='Mads.sphericalcov-Tuple{Number,Number,Number}' href='#Mads.sphericalcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.sphericalcov`** &mdash; *Method*.



Spherical spatial covariance function

Methods

  * `Mads.sphericalcov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:43

Arguments

  * `h::Number` : separation distance
  * `maxcov::Number` : max covariance
  * `scale::Number` : scale

Returns:

  * covariance


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L31-L39' class='documenter-source'>source</a><br>

<a id='Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.sphericalvariogram`** &mdash; *Method*.



Spherical variogram

Methods

  * `Mads.sphericalvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:59

Arguments

  * `h::Number` : separation distance
  * `nugget::Number` : nugget
  * `range::Number` : range
  * `sill::Number` : sill

Returns:

  * Spherical variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsKriging.jl#L45-L53' class='documenter-source'>source</a><br>

<a id='Mads.sprintf-Tuple' href='#Mads.sprintf-Tuple'>#</a>
**`Mads.sprintf`** &mdash; *Method*.



Convert `@sprintf` macro into `sprintf` function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsMisc.jl#L186' class='documenter-source'>source</a><br>

<a id='Mads.status' href='#Mads.status'>#</a>
**`Mads.status`** &mdash; *Function*.



Status of Mads modules

Methods

  * `Mads.status(madsmodule::String; gitmore, git)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:233
  * `Mads.status(; git, gitmore)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:228

Arguments

  * `madsmodule::String` : mads module

Keywords

  * `git` : use git [default=`true` or `Mads.madsgit`]
  * `gitmore` : use even more git [default=`false`]

Returns:

  * `true` or `false`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L273-L281' class='documenter-source'>source</a><br>

<a id='Mads.stderrcaptureoff-Tuple{}' href='#Mads.stderrcaptureoff-Tuple{}'>#</a>
**`Mads.stderrcaptureoff`** &mdash; *Method*.



Restore STDERR

Methods

  * `Mads.stderrcaptureoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:134

Returns:

  * standered error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L124-L132' class='documenter-source'>source</a><br>

<a id='Mads.stderrcaptureon-Tuple{}' href='#Mads.stderrcaptureon-Tuple{}'>#</a>
**`Mads.stderrcaptureon`** &mdash; *Method*.



Redirect STDERR to a reader

Methods

  * `Mads.stderrcaptureon()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:117


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L111-L115' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureoff-Tuple{}' href='#Mads.stdoutcaptureoff-Tuple{}'>#</a>
**`Mads.stdoutcaptureoff`** &mdash; *Method*.



Restore STDOUT

Methods

  * `Mads.stdoutcaptureoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:104

Returns:

  * standered output


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L94-L102' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureon-Tuple{}' href='#Mads.stdoutcaptureon-Tuple{}'>#</a>
**`Mads.stdoutcaptureon`** &mdash; *Method*.



Redirect STDOUT to a reader

Methods

  * `Mads.stdoutcaptureon()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:87


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L81-L85' class='documenter-source'>source</a><br>

<a id='Mads.stdouterrcaptureoff-Tuple{}' href='#Mads.stdouterrcaptureoff-Tuple{}'>#</a>
**`Mads.stdouterrcaptureoff`** &mdash; *Method*.



Restore STDOUT & STDERR

Methods

  * `Mads.stdouterrcaptureoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:161

Returns:

  * standered output amd standered error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L151-L159' class='documenter-source'>source</a><br>

<a id='Mads.stdouterrcaptureon-Tuple{}' href='#Mads.stdouterrcaptureon-Tuple{}'>#</a>
**`Mads.stdouterrcaptureon`** &mdash; *Method*.



Redirect STDOUT & STDERR to readers

Methods

  * `Mads.stdouterrcaptureon()` : /Users/monty/.julia/v0.5/Mads/src/MadsCapture.jl:147


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L141-L145' class='documenter-source'>source</a><br>

<a id='Mads.svrdump-Tuple{Array{SVR.svmmodel,1},String,Int64}' href='#Mads.svrdump-Tuple{Array{SVR.svmmodel,1},String,Int64}'>#</a>
**`Mads.svrdump`** &mdash; *Method*.



Dump SVR models in files

Methods

  * `Mads.svrdump(svrmodel::Array{SVR.svmmodel,1}, rootname::String, numberofsamples::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:141

Arguments

  * `numberofsamples::Int64` : number of samples
  * `rootname::String` : root name
  * `svrmodel::Array{SVR.svmmodel,1}` : array of SVR models


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L132-L136' class='documenter-source'>source</a><br>

<a id='Mads.svrfree-Tuple{Array{SVR.svmmodel,1}}' href='#Mads.svrfree-Tuple{Array{SVR.svmmodel,1}}'>#</a>
**`Mads.svrfree`** &mdash; *Method*.



Free SVR

Methods

  * `Mads.svrfree(svrmodel::Array{SVR.svmmodel,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:123

Arguments

  * `svrmodel::Array{SVR.svmmodel,1}` : array of SVR models


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L116-L120' class='documenter-source'>source</a><br>

<a id='Mads.svrload-Tuple{Int64,String,Int64}' href='#Mads.svrload-Tuple{Int64,String,Int64}'>#</a>
**`Mads.svrload`** &mdash; *Method*.



Load SVR models from files

Methods

  * `Mads.svrload(npred::Int64, rootname::String, numberofsamples::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:164

Arguments

  * `npred::Int64` : number of model predictions
  * `numberofsamples::Int64` : number of samples
  * `rootname::String` : root name

Returns:

  * Array of SVR models for each model prediction


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L151-L159' class='documenter-source'>source</a><br>

<a id='Mads.svrpredict' href='#Mads.svrpredict'>#</a>
**`Mads.svrpredict`** &mdash; *Function*.



Predict SVR

Methods

  * `Mads.svrpredict(svrmodel::Array{SVR.svmmodel,1}, paramarray::Array{Float64,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:96

Arguments

  * `paramarray::Array{Float64,2}` : parameter array
  * `svrmodel::Array{SVR.svmmodel,1}` : array of SVR models

Returns:

  * SVR predicted observations (dependent variables) for a given set of parameters (independent variables)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L104-L112' class='documenter-source'>source</a><br>

<a id='Mads.svrtrain' href='#Mads.svrtrain'>#</a>
**`Mads.svrtrain`** &mdash; *Function*.



Train SVR

Methods

  * `Mads.svrtrain(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:39
  * `Mads.svrtrain(madsdata::Associative, paramarray::Array{Float64,2}; check, savesvr, addminmax, svm_type, kernel_type, degree, gamma, coef0, C, nu, cache_size, eps, shrinking, probability, verbose, tol)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:6
  * `Mads.svrtrain(madsdata::Associative, numberofsamples::Integer; addminmax, kw...)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:39

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numberofsamples::Integer` : number of random samples in the training set [default=`100`]
  * `paramarray::Array{Float64,2}`

Keywords

  * `C` : cost; penalty parameter of the error term [default=`1000.0`]
  * `addminmax` : add parameter minimum / maximum range values in the training set [default=`true`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `check` : check SVR performance [default=`false`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types

[default=`0`]

  * `degree` : degree of the polynomial kernel [default=`3`]
  * `eps` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSVR.jl#L54-L62' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdir-Tuple{String,String}' href='#Mads.symlinkdir-Tuple{String,String}'>#</a>
**`Mads.symlinkdir`** &mdash; *Method*.



Create a symbolic link of a file `filename` in a directory `dirtarget`

Methods

  * `Mads.symlinkdir(filename::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1100

Arguments

  * `dirtarget::String` : target directory
  * `filename::String` : file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1092-L1096' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdirfiles-Tuple{String,String}' href='#Mads.symlinkdirfiles-Tuple{String,String}'>#</a>
**`Mads.symlinkdirfiles`** &mdash; *Method*.



Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`

Methods

  * `Mads.symlinkdirfiles(dirsource::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1082

Arguments

  * `dirsource::String` : source directory
  * `dirtarget::String` : target directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L1074-L1078' class='documenter-source'>source</a><br>

<a id='Mads.tag' href='#Mads.tag'>#</a>
**`Mads.tag`** &mdash; *Function*.



Tag Mads modules with a default argument `:patch`

Methods

  * `Mads.tag(madsmodule::String, versionsym::Symbol)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:292
  * `Mads.tag(madsmodule::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:292
  * `Mads.tag(versionsym::Symbol)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:287
  * `Mads.tag()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:287

Arguments

  * `madsmodule::String` : mads module name
  * `versionsym::Symbol` : version symbol [default=`:patch`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L311-L315' class='documenter-source'>source</a><br>

<a id='Mads.test' href='#Mads.test'>#</a>
**`Mads.test`** &mdash; *Function*.



Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

Methods

  * `Mads.test(testname::String; madstest)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:52
  * `Mads.test()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:52

Arguments

  * `testname::String` : name of the test to execute (module or example)

Keywords

  * `madstest` : test Mads [default=`true`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsTest.jl#L44-L48' class='documenter-source'>source</a><br>

<a id='Mads.testj' href='#Mads.testj'>#</a>
**`Mads.testj`** &mdash; *Function*.



Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)

Methods

  * `Mads.testj(coverage::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:11
  * `Mads.testj()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:11

Arguments

  * `coverage::Bool` : [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsTest.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.transposematrix-Tuple{Array{T,2}}' href='#Mads.transposematrix-Tuple{Array{T,2}}'>#</a>
**`Mads.transposematrix`** &mdash; *Method*.



Transpose non-numeric matrix

Methods

  * `Mads.transposematrix(a::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:301

Arguments

  * `a::Array{T<:Any,2}` : matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L294-L298' class='documenter-source'>source</a><br>

<a id='Mads.transposevector-Tuple{Array{T,1}}' href='#Mads.transposevector-Tuple{Array{T,1}}'>#</a>
**`Mads.transposevector`** &mdash; *Method*.



Transpose non-numeric vector

Methods

  * `Mads.transposevector(a::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:291

Arguments

  * `a::Array{T<:Any,1}` : vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L284-L288' class='documenter-source'>source</a><br>

<a id='Mads.untag-Tuple{String,String}' href='#Mads.untag-Tuple{String,String}'>#</a>
**`Mads.untag`** &mdash; *Method*.



Untag specific version

Methods

  * `Mads.untag(madsmodule::String, version::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:327

Arguments

  * `madsmodule::String` : mads module name
  * `version::String` : version


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-interactive/MadsPublish.jl#L319-L323' class='documenter-source'>source</a><br>

<a id='Mads.vectoroff-Tuple{}' href='#Mads.vectoroff-Tuple{}'>#</a>
**`Mads.vectoroff`** &mdash; *Method*.



MADS vector calls off

Methods

  * `Mads.vectoroff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:18


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L12-L16' class='documenter-source'>source</a><br>

<a id='Mads.vectoron-Tuple{}' href='#Mads.vectoron-Tuple{}'>#</a>
**`Mads.vectoron`** &mdash; *Method*.



MADS vector calls on

Methods

  * `Mads.vectoron()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsHelpers.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.void2nan!-Tuple{Associative}' href='#Mads.void2nan!-Tuple{Associative}'>#</a>
**`Mads.void2nan!`** &mdash; *Method*.



Convert Void's into NaN's in a dictionary

Methods

  * `Mads.void2nan!(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1040

Arguments

  * `dict::Associative` : dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L1033-L1037' class='documenter-source'>source</a><br>

<a id='Mads.weightedstats-Tuple{Array,Array{T,1}}' href='#Mads.weightedstats-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.weightedstats`** &mdash; *Method*.



Get weighted mean and variance samples

Methods

  * `Mads.weightedstats(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:381

Arguments

  * `llhoods::Array{T<:Any,1}` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * vector of sample means
  * vector of sample variances


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsSenstivityAnalysis.jl#L368-L377' class='documenter-source'>source</a><br>

<a id='Mads.welloff!-Tuple{Associative,String}' href='#Mads.welloff!-Tuple{Associative,String}'>#</a>
**`Mads.welloff!`** &mdash; *Method*.



Turn off a specific well in the MADS problem dictionary

Methods

  * `Mads.welloff!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:611

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `wellname::String` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L603-L607' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{Associative,Regex}' href='#Mads.wellon!-Tuple{Associative,Regex}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

Methods

  * `Mads.wellon!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:553
  * `Mads.wellon!(madsdata::Associative, rx::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:575

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `rx::Regex`
  * `wellname::String` : name of the well to be turned on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L567-L571' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{Associative,String}' href='#Mads.wellon!-Tuple{Associative,String}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

Methods

  * `Mads.wellon!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:553

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `wellname::String` : name of the well to be turned on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L545-L549' class='documenter-source'>source</a><br>

<a id='Mads.wells2observations!-Tuple{Associative}' href='#Mads.wells2observations!-Tuple{Associative}'>#</a>
**`Mads.wells2observations!`** &mdash; *Method*.



Convert `Wells` class to `Observations` class in the MADS problem dictionary

Methods

  * `Mads.wells2observations!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:666

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsObservations.jl#L659-L663' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters-Tuple{Associative,Associative}' href='#Mads.writeparameters-Tuple{Associative,Associative}'>#</a>
**`Mads.writeparameters`** &mdash; *Method*.



Write model `parameters`

Methods

  * `Mads.writeparameters(madsdata::Associative, parameters::Associative; respect_space)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:854

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameters::Associative` : parameters

Keywords

  * `respect_space` : respect provided space in the template file to fit model parameters [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L845-L849' class='documenter-source'>source</a><br>

<a id='Mads.writeparametersviatemplate-Tuple{Any,Any,Any}' href='#Mads.writeparametersviatemplate-Tuple{Any,Any,Any}'>#</a>
**`Mads.writeparametersviatemplate`** &mdash; *Method*.



Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)

Methods

  * `Mads.writeparametersviatemplate(parameters, templatefilename, outputfilename; respect_space)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:808

Arguments

  * `outputfilename` : output file name
  * `parameters` : parameters
  * `templatefilename` : tmplate file name

Keywords

  * `respect_space` : respect provided space in the template file to fit model parameters [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsIO.jl#L798-L802' class='documenter-source'>source</a><br>

<a id='Mads.@stderrcapture-Tuple{Any}' href='#Mads.@stderrcapture-Tuple{Any}'>#</a>
**`Mads.@stderrcapture`** &mdash; *Macro*.



Capture STDERR of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L27-L29' class='documenter-source'>source</a><br>

<a id='Mads.@stdoutcapture-Tuple{Any}' href='#Mads.@stdoutcapture-Tuple{Any}'>#</a>
**`Mads.@stdoutcapture`** &mdash; *Macro*.



Capture STDOUT of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L3-L5' class='documenter-source'>source</a><br>

<a id='Mads.@stdouterrcapture-Tuple{Any}' href='#Mads.@stdouterrcapture-Tuple{Any}'>#</a>
**`Mads.@stdouterrcapture`** &mdash; *Macro*.



Capture STDERR & STDERR of a block


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/MadsCapture.jl#L51-L53' class='documenter-source'>source</a><br>

<a id='Mads.@tryimport-Tuple{Symbol}' href='#Mads.@tryimport-Tuple{Symbol}'>#</a>
**`Mads.@tryimport`** &mdash; *Macro*.



Try to import a module


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/Mads.jl#L40' class='documenter-source'>source</a><br>

<a id='Mads.MadsModel' href='#Mads.MadsModel'>#</a>
**`Mads.MadsModel`** &mdash; *Type*.



MadsModel type applied for MathProgBase analyses


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/ac302ce7ecae7216fc6a48f001689f22ca2a7fe5/src/../src-new/MadsMathProgBase.jl#L5-L7' class='documenter-source'>source</a><br>

