
<a id='Mads.jl-1'></a>

# Mads.jl


Documentation for Mads.jl

<a id='Mads.MFlm-Tuple{Array{T,2},Integer}' href='#Mads.MFlm-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.MFlm`** &mdash; *Method*.



Matrix Factorization via Levenberg Marquardt

Methods

  * `Mads.MFlm(X::Array{T<:Any,2}, nk::Integer; mads, log_W, log_H, retries, maxiter, tol, initW, initH)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:82

Arguments

  * `X::Array{T<:Any,2}`
  * `nk::Integer`

Keywords

  * `initH`
  * `initW`
  * `log_H`
  * `log_W`
  * `mads`
  * `maxiter`
  * `retries`
  * `tol`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-new/MadsBSS.jl#L76-L80' class='documenter-source'>source</a><br>

<a id='Mads.NMFipopt-Tuple{Array{T,2},Integer}' href='#Mads.NMFipopt-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.NMFipopt`** &mdash; *Method*.



Non-negative Matrix Factorization using JuMP/Ipopt

Methods

  * `Mads.NMFipopt(X::Array{T<:Any,2}, nk::Integer; retries, tol, random, maxiter, maxguess, initW, initH, verbosity, quiet)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:36

Arguments

  * `X::Array{T<:Any,2}`
  * `nk::Integer`

Keywords

  * `initH`
  * `initW`
  * `maxguess`
  * `maxiter`
  * `quiet`
  * `random`
  * `retries`
  * `tol`
  * `verbosity`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-new/MadsBSS.jl#L30-L34' class='documenter-source'>source</a><br>

<a id='Mads.NMFm-Tuple{Array,Integer}' href='#Mads.NMFm-Tuple{Array,Integer}'>#</a>
**`Mads.NMFm`** &mdash; *Method*.



Non-negative Matrix Factorization using NMF

Methods

  * `Mads.NMFm(X::Array, nk::Integer; retries, maxiter, tol)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:12

Arguments

  * `X::Array`
  * `nk::Integer`

Keywords

  * `maxiter`
  * `retries`
  * `tol`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-new/MadsBSS.jl#L6-L10' class='documenter-source'>source</a><br>

<a id='Mads.addkeyword!' href='#Mads.addkeyword!'>#</a>
**`Mads.addkeyword!`** &mdash; *Function*.



Add a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.addkeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:183
  * `Mads.addkeyword!(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:187

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L200-L204' class='documenter-source'>source</a><br>

<a id='Mads.addsource!' href='#Mads.addsource!'>#</a>
**`Mads.addsource!`** &mdash; *Function*.



Add an additional contamination source

Methods

  * `Mads.addsource!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:14
  * `Mads.addsource!(madsdata::Associative, sourceid::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:14

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `sourceid::Int64` : source id [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L6-L10' class='documenter-source'>source</a><br>

<a id='Mads.addsourceparameters!-Tuple{Associative}' href='#Mads.addsourceparameters!-Tuple{Associative}'>#</a>
**`Mads.addsourceparameters!`** &mdash; *Method*.



Add contaminant source parameters

Methods

  * `Mads.addsourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:64

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L57-L61' class='documenter-source'>source</a><br>

<a id='Mads.allwellsoff!-Tuple{Associative}' href='#Mads.allwellsoff!-Tuple{Associative}'>#</a>
**`Mads.allwellsoff!`** &mdash; *Method*.



Turn off all the wells in the MADS problem dictionary

Methods

  * `Mads.allwellsoff!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:551

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L544-L548' class='documenter-source'>source</a><br>

<a id='Mads.allwellson!-Tuple{Associative}' href='#Mads.allwellson!-Tuple{Associative}'>#</a>
**`Mads.allwellson!`** &mdash; *Method*.



Turn on all the wells in the MADS problem dictionary

Methods

  * `Mads.allwellson!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:516

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L509-L513' class='documenter-source'>source</a><br>

<a id='Mads.amanzi' href='#Mads.amanzi'>#</a>
**`Mads.amanzi`** &mdash; *Function*.



Execute amanzi external groundwater flow and transport simulator 

Arguments:

  * `filename` : amanzi input file name
  * `nproc` : number of processor to be used by amanzi
  * `quiet` : : suppress output [default `true`]
  * `observation_filename` : amanzi observation filename [default "observations.out"]
  * `setup` : bash script to setup amanzi environmental variables
  * `amanzi_exe` : full path to the location of the amanzi executable


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-external/MadsSimulators.jl#L1-L13' class='documenter-source'>source</a><br>

<a id='Mads.amanzi_output_parser' href='#Mads.amanzi_output_parser'>#</a>
**`Mads.amanzi_output_parser`** &mdash; *Function*.



Parse Amanzi output provided in an external file (`filename`)

Usage:

```julia
Mads.amanzi_output_parser()
Mads.amanzi_output_parser("observations.out")
```

Arguments:

  * `filename` : external file name (optional)

Returns:

  * a dictionary with model observations following MADS requirements


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-external/MadsParsers.jl#L3-L20' class='documenter-source'>source</a><br>

<a id='Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.asinetransform`** &mdash; *Method*.



Arcsine transformation of model parameters

Methods

  * `Mads.asinetransform(params::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:7

Arguments

  * `indexlogtransformed::Array{T<:Any,1}`
  * `lowerbounds::Array{T<:Any,1}`
  * `params::Array{T<:Any,1}`
  * `upperbounds::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSineTransformations.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.bayessampling' href='#Mads.bayessampling'>#</a>
**`Mads.bayessampling`** &mdash; *Function*.



Bayesian Sampling

Methods

  * `Mads.bayessampling(madsdata::Associative; nsteps, burnin, thinning, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:69
  * `Mads.bayessampling(madsdata::Associative, numsequences::Integer; nsteps, burnin, thinning, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:94

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numsequences::Integer` : number of sequences executed in parallel

Keywords

  * `burnin` : number of initial realizations before the MCMC are recorded [default=`100`]
  * `nsteps` : number of final realizations in the chain [default=`1000`]
  * `seed` : initial random number seed [default=`0`]
  * `thinning` : removal of any `thinning` realization [default=`1`]

Returns:

  * MCMC chain

Examples:

```julia
Mads.bayessampling(madsdata; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.bayessampling(madsdata, numsequences; nsteps=1000, burnin=100, thinning=1, seed=2016)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L102-L117' class='documenter-source'>source</a><br>

<a id='Mads.calibrate-Tuple{Associative}' href='#Mads.calibrate-Tuple{Associative}'>#</a>
**`Mads.calibrate`** &mdash; *Method*.



Calibrate

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Methods

  * `Mads.calibrate(madsdata::Associative; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, save_results, localsa)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:166

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsCalibrate.jl#L139-L150' class='documenter-source'>source</a><br>

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
  * `seed` : initial random seed [default=`0`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsCalibrate.jl#L4-L20' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom_parallel' href='#Mads.calibraterandom_parallel'>#</a>
**`Mads.calibraterandom_parallel`** &mdash; *Function*.



Calibrate with random initial guesses in parallel

Methods

  * `Mads.calibraterandom_parallel(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:109
  * `Mads.calibraterandom_parallel(madsdata::Associative, numberofsamples::Integer; tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_mu, np_lambda, show_trace, usenaive, seed, quiet, save_results, localsa)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:109

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
  * `seed` : initial random seed [default=`0`]
  * `show_trace` : shows solution trace [default=`false`]
  * `tolG` : parameter space update tolerance [default=`1e-6`]
  * `tolOF` : objective function tolerance [default=`1e-3`]
  * `tolX` : parameter space tolerance [default=`1e-4`]
  * `usenaive` : use naive Levenberg-Marquardt solver [default=`false`]

Returns:

  * vector with all objective function values
  * boolean vector (converged/not converged)
  * array with estimate model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsCalibrate.jl#L80-L90' class='documenter-source'>source</a><br>

<a id='Mads.checkmodeloutputdirs-Tuple{Associative}' href='#Mads.checkmodeloutputdirs-Tuple{Associative}'>#</a>
**`Mads.checkmodeloutputdirs`** &mdash; *Method*.



Check the directories where model outputs should be saved for MADS

Methods

  * `Mads.checkmodeloutputdirs(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:489

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L478-L486' class='documenter-source'>source</a><br>

<a id='Mads.checknodedir' href='#Mads.checknodedir'>#</a>
**`Mads.checknodedir`** &mdash; *Function*.



Check if a directory is readable

Methods

  * `Mads.checknodedir(dir::String, waittime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:302
  * `Mads.checknodedir(dir::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:302
  * `Mads.checknodedir(node::String, dir::String, waittime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:293
  * `Mads.checknodedir(node::String, dir::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:293

Arguments

  * `dir::String`
  * `node::String`
  * `waittime::Float64`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L316-L320' class='documenter-source'>source</a><br>

<a id='Mads.checkout' href='#Mads.checkout'>#</a>
**`Mads.checkout`** &mdash; *Function*.



Checkout the latest version of the Mads / Julia modules

Methods

  * `Mads.checkout(modulename::String; git, master, force, pull, required, all)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63
  * `Mads.checkout()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63

Arguments

  * `modulename::String`

Keywords

  * `all`
  * `force`
  * `git`
  * `master`
  * `pull`
  * `required`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L57-L61' class='documenter-source'>source</a><br>

<a id='Mads.checkparameterranges-Tuple{Associative}' href='#Mads.checkparameterranges-Tuple{Associative}'>#</a>
**`Mads.checkparameterranges`** &mdash; *Method*.



Check parameter ranges for model parameters

Methods

  * `Mads.checkparameterranges(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:661

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L654-L658' class='documenter-source'>source</a><br>

<a id='Mads.cleancoverage-Tuple{}' href='#Mads.cleancoverage-Tuple{}'>#</a>
**`Mads.cleancoverage`** &mdash; *Method*.



Remove Mads coverage files

Methods

  * `Mads.cleancoverage()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:20


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsTest.jl#L14-L18' class='documenter-source'>source</a><br>

<a id='Mads.cmadsins_obs-Tuple{Array{T,1},String,String}' href='#Mads.cmadsins_obs-Tuple{Array{T,1},String,String}'>#</a>
**`Mads.cmadsins_obs`** &mdash; *Method*.



Call C MADS ins_obs() function from the MADS dynamic library

Methods

  * `Mads.cmadsins_obs(obsid::Array{T<:Any,1}, instructionfilename::String, inputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:27

Arguments

  * `inputfilename::String`
  * `instructionfilename::String`
  * `obsid::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-old/MadsCMads.jl#L21-L25' class='documenter-source'>source</a><br>

<a id='Mads.commit' href='#Mads.commit'>#</a>
**`Mads.commit`** &mdash; *Function*.



Commit the latest version of the Mads / Julia modules in the repo

Methods

  * `Mads.commit(commitmsg::String, modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:157
  * `Mads.commit(commitmsg::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:157

Arguments

  * `commitmsg::String`
  * `modulename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L151-L155' class='documenter-source'>source</a><br>

<a id='Mads.computemass' href='#Mads.computemass'>#</a>
**`Mads.computemass`** &mdash; *Function*.



Compute injected/reduced contaminant mass (for a given set of mads input files when "path" is provided)

Methods

  * `Mads.computemass(madsdata::Associative; time)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:282
  * `Mads.computemass(madsfiles::Union{Regex,String}; time, path)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:323

Arguments

  * `madsdata::Associative` : Mads problem dictionary
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L346-L362' class='documenter-source'>source</a><br>

<a id='Mads.computeparametersensitities-Tuple{Associative,Associative}' href='#Mads.computeparametersensitities-Tuple{Associative,Associative}'>#</a>
**`Mads.computeparametersensitities`** &mdash; *Method*.



Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

Methods

  * `Mads.computeparametersensitities(madsdata::Associative, saresults::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:812

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `saresults::Associative` : sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L804-L808' class='documenter-source'>source</a><br>

<a id='Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}' href='#Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}'>#</a>
**`Mads.contamination`** &mdash; *Method*.



Compute concentration for a point in space and time (x,y,z,t)

Methods

  * `Mads.contamination(wellx::Number, welly::Number, wellz::Number, n::Number, lambda::Number, theta::Number, vx::Number, vy::Number, vz::Number, ax::Number, ay::Number, az::Number, H::Number, x::Number, y::Number, z::Number, dx::Number, dy::Number, dz::Number, f::Number, t0::Number, t1::Number, t::Number; anasolfunction)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:256

Arguments

  * `H::Number` : Hurst coefficient for Fractional Brownian dispersion
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
  * `t::Number` : time to compute concentration at the observation point
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

Keywords

  * `anasolfunction` : Anasol function to call (check out the Anasol module) [default=`"long_bbb_ddd_iir_c"`]

Returns:

  * predicted concentration at (wellx, welly, wellz, t)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L222-L230' class='documenter-source'>source</a><br>

<a id='Mads.copyright-Tuple{}' href='#Mads.copyright-Tuple{}'>#</a>
**`Mads.copyright`** &mdash; *Method*.



Produce MADS copyright information

Methods

  * `Mads.copyright()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:18


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelp.jl#L12-L16' class='documenter-source'>source</a><br>

<a id='Mads.create_documentation-Tuple{}' href='#Mads.create_documentation-Tuple{}'>#</a>
**`Mads.create_documentation`** &mdash; *Method*.



Create web documentation files for Mads functions

Methods

  * `Mads.create_documentation()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:261


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L255-L259' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_off-Tuple{}' href='#Mads.create_tests_off-Tuple{}'>#</a>
**`Mads.create_tests_off`** &mdash; *Method*.



Turn off the generation of MADS tests (default)

Methods

  * `Mads.create_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:84


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L78-L82' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_on-Tuple{}' href='#Mads.create_tests_on-Tuple{}'>#</a>
**`Mads.create_tests_on`** &mdash; *Method*.



Turn on the generation of MADS tests (dangerous)

Methods

  * `Mads.create_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:75


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L69-L73' class='documenter-source'>source</a><br>

<a id='Mads.createmadsproblem' href='#Mads.createmadsproblem'>#</a>
**`Mads.createmadsproblem`** &mdash; *Function*.



Create a new Mads problem where the observation targets are computed based on the model predictions

Arguments:

  * `infilename` : input Mads file
  * `outfilename` : output Mads file
  * `madsdata` : MADS problem dictionary
  * `predictions` : dictionary of model predictions

Methods

  * `Mads.createmadsproblem(infilename::String, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:4
  * `Mads.createmadsproblem(madsdata::Associative, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:29
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:38
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:34

Arguments

  * `infilename::String`
  * `madsdata::Associative`
  * `outfilename::String`
  * `predictions::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsCreate.jl#L54-L65' class='documenter-source'>source</a><br>

<a id='Mads.createobservations!' href='#Mads.createobservations!'>#</a>
**`Mads.createobservations!`** &mdash; *Function*.



Create observations in the MADS problem dictionary based on `time` and `observation` vectors

Methods

  * `Mads.createobservations!(madsdata::Associative, time::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:411
  * `Mads.createobservations!(madsdata::Associative, time::Array{T<:Any,1}, observation::Array{T<:Any,1}; logtransform, weight_type, weight)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:411
  * `Mads.createobservations!(madsdata::Associative, observation::Associative; logtransform, weight_type, weight)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:455

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `observation::Array{T<:Any,1}` : dictionary of observations
  * `observation::Associative` : dictionary of observations
  * `time::Array{T<:Any,1}` : vector of observation times

Keywords

  * `logtransform` : log transform observations [default=`false`]
  * `weight` : weight value [default=`1`]
  * `weight_type` : weight type [default=`constant`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L474-L478' class='documenter-source'>source</a><br>

<a id='Mads.createtempdir-Tuple{String}' href='#Mads.createtempdir-Tuple{String}'>#</a>
**`Mads.createtempdir`** &mdash; *Method*.



Create temporary directory

Methods

  * `Mads.createtempdir(tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1061

Arguments

  * `tempdirname::String` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1054-L1058' class='documenter-source'>source</a><br>

<a id='Mads.deleteNaN!-Tuple{DataFrames.DataFrame}' href='#Mads.deleteNaN!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.deleteNaN!`** &mdash; *Method*.



Delete rows with NaN in a Dataframe `df`

Methods

  * `Mads.deleteNaN!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1036

Arguments

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L1029-L1033' class='documenter-source'>source</a><br>

<a id='Mads.deletekeyword!' href='#Mads.deletekeyword!'>#</a>
**`Mads.deletekeyword!`** &mdash; *Function*.



Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.deletekeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:210
  * `Mads.deletekeyword!(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:216

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L228-L232' class='documenter-source'>source</a><br>

<a id='Mads.dependents' href='#Mads.dependents'>#</a>
**`Mads.dependents`** &mdash; *Function*.



Lists modules dependents on a module (Mads by default)

Methods

  * `Mads.dependents(modulename::String, filter::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45
  * `Mads.dependents(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45
  * `Mads.dependents()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45

Arguments

  * `filter::Bool`
  * `modulename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L39-L43' class='documenter-source'>source</a><br>

<a id='Mads.display-Tuple{String}' href='#Mads.display-Tuple{String}'>#</a>
**`Mads.display`** &mdash; *Method*.



Display image file

Methods

  * `Mads.display(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsDisplay.jl:9

Arguments

  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsDisplay.jl#L3-L7' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsBayesInfoGap.jl#L108-L116' class='documenter-source'>source</a><br>

<a id='Mads.dumpasciifile-Tuple{String,Any}' href='#Mads.dumpasciifile-Tuple{String,Any}'>#</a>
**`Mads.dumpasciifile`** &mdash; *Method*.



Dump ASCII file

Methods

  * `Mads.dumpasciifile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:17

Arguments

  * `data`
  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsASCII.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.dumpjsonfile-Tuple{String,Any}' href='#Mads.dumpjsonfile-Tuple{String,Any}'>#</a>
**`Mads.dumpjsonfile`** &mdash; *Method*.



Dump a JSON file

Methods

  * `Mads.dumpjsonfile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:26

Arguments

  * `data`
  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsJSON.jl#L20-L24' class='documenter-source'>source</a><br>

<a id='Mads.dumpwelldata-Tuple{Associative,String}' href='#Mads.dumpwelldata-Tuple{Associative,String}'>#</a>
**`Mads.dumpwelldata`** &mdash; *Method*.



Dump well data from MADS problem dictionary into a ASCII file

Methods

  * `Mads.dumpwelldata(madsdata::Associative, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:940

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : Mads problem dictionary

Dumps:

  * `filename` : a ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L928-L936' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlfile-Tuple{String,Any}' href='#Mads.dumpyamlfile-Tuple{String,Any}'>#</a>
**`Mads.dumpyamlfile`** &mdash; *Method*.



Dump YAML file

Methods

  * `Mads.dumpyamlfile(filename::String, data; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:38

Arguments

  * `data` : YAML data
  * `filename::String` : output file name

Keywords

  * `julia` : if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsYAML.jl#L29-L33' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlmadsfile-Tuple{Associative,String}' href='#Mads.dumpyamlmadsfile-Tuple{Associative,String}'>#</a>
**`Mads.dumpyamlmadsfile`** &mdash; *Method*.



Dump YAML Mads file

Methods

  * `Mads.dumpyamlmadsfile(madsdata::Associative, filename::String; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:57

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `julia` : [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsYAML.jl#L48-L52' class='documenter-source'>source</a><br>

<a id='Mads.efast-Tuple{Associative}' href='#Mads.efast-Tuple{Associative}'>#</a>
**`Mads.efast`** &mdash; *Method*.



Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

Methods

  * `Mads.efast(md::Associative; N, M, gamma, plotresults, seed, issvr, truncateRanges, checkpointfrequency, restartdir, restart)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1124

Arguments

  * `md::Associative` : MADS problem dictionary

Keywords

  * `M` : maximum number of harmonics, [default=`6`]
  * `N` : number of samples, [default=`100`]
  * `checkpointfrequency` : [default=`N`]
  * `gamma` : multiplication factor (Saltelli 1999 recommends gamma = 2 or 4), [default=`4`]
  * `issvr` : [default=`false`]
  * `plotresults` : plot of results, [default=`graphoutput`]
  * `restart` : [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts, [default=`efastcheckpoints`]
  * `seed` : initial random seed, [default=`0`]
  * `truncateRanges` : [default=`0`]

Dumps:

  * plot of results, default from `graphoutput`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L1065-L1073' class='documenter-source'>source</a><br>

<a id='Mads.emceesampling' href='#Mads.emceesampling'>#</a>
**`Mads.emceesampling`** &mdash; *Function*.



Bayesian sampling with Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

Methods

  * `Mads.emceesampling(madsdata::Associative; numwalkers, nsteps, burnin, thinning, sigma, seed, weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:10
  * `Mads.emceesampling(madsdata::Associative, p0::Array; numwalkers, nsteps, burnin, thinning, seed, weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:32

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `p0::Array` : initial parameters (matrix of size (length(optparams), numwalkers))

Keywords

  * `burnin` : number of initial realizations before the MCMC are recorded [default=`10`]
  * `nsteps` : number of final realizations in the chain [default=`100`]
  * `numwalkers` : number of walkers (if in parallel this can be the number of available processors) [default=`10`]
  * `seed` : initial random number seed [default=`0`]
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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L41-L57' class='documenter-source'>source</a><br>

<a id='Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}' href='#Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.estimationerror`** &mdash; *Method*.



Estimate kriging error

Methods

  * `Mads.estimationerror(w::Array{T<:Any,1}, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:130

Arguments

  * `X::Array{T<:Any,2}`
  * `cov::Function`
  * `w::Array{T<:Any,1}`
  * `x0::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L124-L128' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpression-Tuple{String,Associative}' href='#Mads.evaluatemadsexpression-Tuple{String,Associative}'>#</a>
**`Mads.evaluatemadsexpression`** &mdash; *Method*.



Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

Methods

  * `Mads.evaluatemadsexpression(expressionstring::String, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:118

Arguments

  * `expressionstring::String`
  * `parameters::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L112-L116' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpressions-Tuple{Associative,Associative}' href='#Mads.evaluatemadsexpressions-Tuple{Associative,Associative}'>#</a>
**`Mads.evaluatemadsexpressions`** &mdash; *Method*.



Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

Methods

  * `Mads.evaluatemadsexpressions(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:131

Arguments

  * `madsdata::Associative`
  * `parameters::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L125-L129' class='documenter-source'>source</a><br>

<a id='Mads.expcov-Tuple{Number,Number,Number}' href='#Mads.expcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.expcov`** &mdash; *Method*.



Exponential spatial covariance function

Methods

  * `Mads.expcov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:13

Arguments

  * `h::Number`
  * `maxcov::Number`
  * `scale::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L8-L12' class='documenter-source'>source</a><br>

<a id='Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.exponentialvariogram`** &mdash; *Method*.



Exponential variogram

Methods

  * `Mads.exponentialvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:43

Arguments

  * `h::Number`
  * `nugget::Number`
  * `range::Number`
  * `sill::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L37-L41' class='documenter-source'>source</a><br>

<a id='Mads.filterkeys' href='#Mads.filterkeys'>#</a>
**`Mads.filterkeys`** &mdash; *Function*.



Filter dictionary keys based on a string or regular expression

Methods

  * `Mads.filterkeys(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:656
  * `Mads.filterkeys(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:655
  * `Mads.filterkeys(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:656

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the regular expression or string used to filter dictionary keys
  * `key::String` : the regular expression or string used to filter dictionary keys


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L658-L662' class='documenter-source'>source</a><br>

<a id='Mads.forward' href='#Mads.forward'>#</a>
**`Mads.forward`** &mdash; *Function*.



Perform a forward run using the initial or provided values for the model parameters

Methods

  * `Mads.forward(madsdata::Associative; all)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:7
  * `Mads.forward(madsdata::Associative, paramdict::Associative; all, checkpointfrequency, checkpointfilename)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:11
  * `Mads.forward(madsdata::Associative, paramarray::Array; all, checkpointfrequency, checkpointfilename)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:41

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `paramarray::Array` : array of model parameter values
  * `paramdict::Associative` : dictionary of model parameter values

Keywords

  * `all` : [default=`false`]
  * `checkpointfilename` : check point file name [default="checkpoint_forward"]
  * `checkpointfrequency` : check point frequency for storing restart information [default=`0`]

Returns:

  * dictionary of model predictions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsForward.jl#L96-L104' class='documenter-source'>source</a><br>

<a id='Mads.forwardgrid' href='#Mads.forwardgrid'>#</a>
**`Mads.forwardgrid`** &mdash; *Function*.



Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

Methods

  * `Mads.forwardgrid(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:113
  * `Mads.forwardgrid(madsdatain::Associative, paramvalues::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:118

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `madsdatain::Associative` : Mads problem dictionary
  * `paramvalues::Associative` : dictionary of model parameter values

Returns:

  * 3D array with model predictions along a 3D grid


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsForward.jl#L175-L183' class='documenter-source'>source</a><br>

<a id='Mads.free' href='#Mads.free'>#</a>
**`Mads.free`** &mdash; *Function*.



Free Mads / Julia modules

Methods

  * `Mads.free(modulename::String; required, all)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:135
  * `Mads.free()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:135

Arguments

  * `modulename::String`

Keywords

  * `all`
  * `required`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L129-L133' class='documenter-source'>source</a><br>

<a id='Mads.functions' href='#Mads.functions'>#</a>
**`Mads.functions`** &mdash; *Function*.



List available functions in the MADS modules:

Methods

  * `Mads.functions(string::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:22
  * `Mads.functions()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:22
  * `Mads.functions(m::Union{Module,Symbol})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:28
  * `Mads.functions(m::Union{Module,Symbol}, string::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:28

Arguments

  * `m::Union{Module,Symbol}`
  * `string::String`

Examples:

```julia
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```

Arguments:

  * `module` : MADS module
  * `string` : matching string


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelp.jl#L50-L69' class='documenter-source'>source</a><br>

<a id='Mads.gaussiancov-Tuple{Number,Number,Number}' href='#Mads.gaussiancov-Tuple{Number,Number,Number}'>#</a>
**`Mads.gaussiancov`** &mdash; *Method*.



Gaussian spatial covariance function

Methods

  * `Mads.gaussiancov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:6

Arguments

  * `h::Number`
  * `maxcov::Number`
  * `scale::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.gaussianvariogram`** &mdash; *Method*.



Gaussian variogram

Methods

  * `Mads.gaussianvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:56

Arguments

  * `h::Number`
  * `nugget::Number`
  * `range::Number`
  * `sill::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L50-L54' class='documenter-source'>source</a><br>

<a id='Mads.getcovmat-Tuple{Array{T,2},Function}' href='#Mads.getcovmat-Tuple{Array{T,2},Function}'>#</a>
**`Mads.getcovmat`** &mdash; *Method*.



Get spatial covariance matrix

Methods

  * `Mads.getcovmat(X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:95

Arguments

  * `X::Array{T<:Any,2}`
  * `cov::Function`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L89-L93' class='documenter-source'>source</a><br>

<a id='Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}' href='#Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.getcovvec!`** &mdash; *Method*.



Get spatial covariance vector

Methods

  * `Mads.getcovvec!(covvec::Array, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:113

Arguments

  * `X::Array{T<:Any,2}`
  * `cov::Function`
  * `covvec::Array`
  * `x0::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L107-L111' class='documenter-source'>source</a><br>

<a id='Mads.getdictvalues' href='#Mads.getdictvalues'>#</a>
**`Mads.getdictvalues`** &mdash; *Function*.



Get dictionary values for keys based on a string or regular expression

Methods

  * `Mads.getdictvalues(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:678
  * `Mads.getdictvalues(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:677
  * `Mads.getdictvalues(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:678

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the key to find value for
  * `key::String` : the key to find value for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L680-L684' class='documenter-source'>source</a><br>

<a id='Mads.getdir-Tuple{String}' href='#Mads.getdir-Tuple{String}'>#</a>
**`Mads.getdir`** &mdash; *Method*.



Get directory

Methods

  * `Mads.getdir(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:291

Arguments

  * `filename::String` : file name

Returns:

  * directory in file name

Example:

```julia
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L273-L288' class='documenter-source'>source</a><br>

<a id='Mads.getdistribution-Tuple{String,String,String}' href='#Mads.getdistribution-Tuple{String,String,String}'>#</a>
**`Mads.getdistribution`** &mdash; *Method*.



Parse distribution from a string

Methods

  * `Mads.getdistribution(dist::String, i::String, inputtype::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:151

Arguments

  * `dist::String`
  * `i::String`
  * `inputtype::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L145-L149' class='documenter-source'>source</a><br>

<a id='Mads.getextension-Tuple{String}' href='#Mads.getextension-Tuple{String}'>#</a>
**`Mads.getextension`** &mdash; *Method*.



Get file name extension

Methods

  * `Mads.getextension(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:469

Arguments

  * `filename::String` : file name

Returns:

  * file name extension

Example:

```julia
ext = Mads.getextension("a.mads") # ext = "mads"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L452-L466' class='documenter-source'>source</a><br>

<a id='Mads.getimportantsamples-Tuple{Array,Array{T,1}}' href='#Mads.getimportantsamples-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.getimportantsamples`** &mdash; *Method*.



Get important samples

Methods

  * `Mads.getimportantsamples(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:325

Arguments

  * `llhoods::Array{T<:Any,1}` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * array of important samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L313-L321' class='documenter-source'>source</a><br>

<a id='Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L494' class='documenter-source'>source</a><br>

<a id='Mads.getmadsdir-Tuple{}' href='#Mads.getmadsdir-Tuple{}'>#</a>
**`Mads.getmadsdir`** &mdash; *Method*.



Get the directory where currently Mads is running

Methods

  * `Mads.getmadsdir()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:337

Usage:

```julia
problemdir = Mads.getmadsdir()
```

Returns:

  * Mads problem directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L321-L335' class='documenter-source'>source</a><br>

<a id='Mads.getmadsinputfile-Tuple{}' href='#Mads.getmadsinputfile-Tuple{}'>#</a>
**`Mads.getmadsinputfile`** &mdash; *Method*.



Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

Methods

  * `Mads.getmadsinputfile()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:248

Usage:

```julia
Mads.getmadsinputfile()
```

Returns:

  * input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L232-L246' class='documenter-source'>source</a><br>

<a id='Mads.getmadsproblemdir-Tuple{Associative}' href='#Mads.getmadsproblemdir-Tuple{Associative}'>#</a>
**`Mads.getmadsproblemdir`** &mdash; *Method*.



Get the directory where the Mads data file is located

Methods

  * `Mads.getmadsproblemdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:318

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Usage:

  * `Mads.getmadsproblemdir(madsdata)`

Example:

```julia
madsdata = Mads.loadmadsproblem("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L298-L315' class='documenter-source'>source</a><br>

<a id='Mads.getmadsrootname-Tuple{Associative}' href='#Mads.getmadsrootname-Tuple{Associative}'>#</a>
**`Mads.getmadsrootname`** &mdash; *Method*.



Get the MADS problem root name

Methods

  * `Mads.getmadsrootname(madsdata::Associative; first, version)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:270

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname, [default=`false`]

Usage:

```julia
madsrootname = Mads.getmadsrootname(madsdata)
```

Returns:

  * root of file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L251-L265' class='documenter-source'>source</a><br>

<a id='Mads.getnextmadsfilename-Tuple{String}' href='#Mads.getnextmadsfilename-Tuple{String}'>#</a>
**`Mads.getnextmadsfilename`** &mdash; *Method*.



Get next mads file name

Methods

  * `Mads.getnextmadsfilename(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:432

Arguments

  * `filename::String` : file name

Returns:

  * next mads file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L421-L429' class='documenter-source'>source</a><br>

<a id='Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L494' class='documenter-source'>source</a><br>

<a id='Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L494' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative,Any}' href='#Mads.getobsdist-Tuple{Associative,Any}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative}' href='#Mads.getobsdist-Tuple{Associative}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobskeys-Tuple{Associative}' href='#Mads.getobskeys-Tuple{Associative}'>#</a>
**`Mads.getobskeys`** &mdash; *Method*.



Get keys for all observations in the MADS problem dictionary

Methods

  * `Mads.getobskeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:43

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * keys for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative,Any}' href='#Mads.getobslog-Tuple{Associative,Any}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative}' href='#Mads.getobslog-Tuple{Associative}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative,Any}' href='#Mads.getobsmax-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative}' href='#Mads.getobsmax-Tuple{Associative}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative,Any}' href='#Mads.getobsmin-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative}' href='#Mads.getobsmin-Tuple{Associative}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative,Any}' href='#Mads.getobstarget-Tuple{Associative,Any}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative}' href='#Mads.getobstarget-Tuple{Associative}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative,Any}' href='#Mads.getobstime-Tuple{Associative,Any}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative}' href='#Mads.getobstime-Tuple{Associative}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative,Any}' href='#Mads.getobsweight-Tuple{Associative,Any}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative}' href='#Mads.getobsweight-Tuple{Associative}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L84' class='documenter-source'>source</a><br>

<a id='Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L494' class='documenter-source'>source</a><br>

<a id='Mads.getoptparams' href='#Mads.getoptparams'>#</a>
**`Mads.getoptparams`** &mdash; *Function*.



Get optimizable parameters

Methods

  * `Mads.getoptparams(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:325
  * `Mads.getoptparams(madsdata::Associative, parameterarray::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:328
  * `Mads.getoptparams(madsdata::Associative, parameterarray::Array, optparameterkey::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:328

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `optparameterkey::Array` : optimizable parameter keys
  * `parameterarray::Array` :

Returns:

  * parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L356-L364' class='documenter-source'>source</a><br>

<a id='Mads.getparamdict-Tuple{Associative}' href='#Mads.getparamdict-Tuple{Associative}'>#</a>
**`Mads.getparamdict`** &mdash; *Method*.



Get dictionary with all parameters and their respective initial values

Methods

  * `Mads.getparamdict(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:60

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * dictionary with all parameters and their respective initial values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L49-L57' class='documenter-source'>source</a><br>

<a id='Mads.getparamdistributions-Tuple{Associative}' href='#Mads.getparamdistributions-Tuple{Associative}'>#</a>
**`Mads.getparamdistributions`** &mdash; *Method*.



Get probabilistic distributions of all parameters in the MADS problem dictionary

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Methods

  * `Mads.getparamdistributions(madsdata::Associative; init_dist)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:616

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field, [default=`false`]

Returns:

  * probabilistic distributions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L600-L612' class='documenter-source'>source</a><br>

<a id='Mads.getparamkeys-Tuple{Associative}' href='#Mads.getparamkeys-Tuple{Associative}'>#</a>
**`Mads.getparamkeys`** &mdash; *Method*.



Get keys of all parameters in the MADS dictionary

Methods

  * `Mads.getparamkeys(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:44

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `filter` :

Returns:

  * array with the keys of all parameters in the MADS dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L32-L40' class='documenter-source'>source</a><br>

<a id='Mads.getparamrandom' href='#Mads.getparamrandom'>#</a>
**`Mads.getparamrandom`** &mdash; *Function*.



Get independent sampling of model parameters defined in the MADS problem dictionary

Methods

  * `Mads.getparamrandom(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:361
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:361
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer, parameterkey::String; init_dist)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:361
  * `Mads.getparamrandom(madsdata::Associative, parameterkey::String; numsamples, init_dist, paramdist)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:374

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `numsamples::Integer` : number of samples,  [default=`1`]
  * `parameterkey::String` : model parameter key

Keywords

  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); if `false` (default) use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)
  * `numsamples` : number of samples
  * `paramdist` :

Returns:

  * generated sample


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L394-L402' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative}' href='#Mads.getparamsinit-Tuple{Associative}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L298-L306' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L247-L255' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslog-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative}' href='#Mads.getparamslog-Tuple{Associative}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslongname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative}' href='#Mads.getparamslongname-Tuple{Associative}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L196-L204' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L157-L165' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsplotname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative}' href='#Mads.getparamsplotname-Tuple{Associative}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsstep-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative}' href='#Mads.getparamsstep-Tuple{Associative}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative,Array{T,1}}' href='#Mads.getparamstype-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative}' href='#Mads.getparamstype-Tuple{Associative}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L98' class='documenter-source'>source</a><br>

<a id='Mads.getprocs-Tuple{}' href='#Mads.getprocs-Tuple{}'>#</a>
**`Mads.getprocs`** &mdash; *Method*.



Get the number of processors

Methods

  * `Mads.getprocs()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:34


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L28-L32' class='documenter-source'>source</a><br>

<a id='Mads.getrestart-Tuple{Associative}' href='#Mads.getrestart-Tuple{Associative}'>#</a>
**`Mads.getrestart`** &mdash; *Method*.



Get MADS restart status

Methods

  * `Mads.getrestart(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:28

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L21-L25' class='documenter-source'>source</a><br>

<a id='Mads.getrestartdir' href='#Mads.getrestartdir'>#</a>
**`Mads.getrestartdir`** &mdash; *Function*.



Get the directory where Mads restarts will be stored

Methods

  * `Mads.getrestartdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:277
  * `Mads.getrestartdir(madsdata::Associative, suffix::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:277

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `suffix::String` : Suffix to be added to the name of restart directory

Returns:

  * restart directory where reusable model results will be stored


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L265-L273' class='documenter-source'>source</a><br>

<a id='Mads.getrootname-Tuple{String}' href='#Mads.getrootname-Tuple{String}'>#</a>
**`Mads.getrootname`** &mdash; *Method*.



Get file name root

Methods

  * `Mads.getrootname(filename::String; first, version)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:367

Arguments

  * `filename::String` : file name

Keywords

  * `first` : use the first . in filename as the seperator between root name and extention [default=`true`]
  * `version` : delete version information from filename for the returned rootname, [default=`false`]

Returns:

  * root of file name

Example:

```julia
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L347-L362' class='documenter-source'>source</a><br>

<a id='Mads.getsindx-Tuple{Associative}' href='#Mads.getsindx-Tuple{Associative}'>#</a>
**`Mads.getsindx`** &mdash; *Method*.



Get sin-space dx

Methods

  * `Mads.getsindx(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:248

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * sin-space dx


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L237-L245' class='documenter-source'>source</a><br>

<a id='Mads.getsourcekeys-Tuple{Associative}' href='#Mads.getsourcekeys-Tuple{Associative}'>#</a>
**`Mads.getsourcekeys`** &mdash; *Method*.



Get keys of all source parameters in the MADS dictionary

Methods

  * `Mads.getsourcekeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:78

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * array with keys of all source parameters in the MADS dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L67-L75' class='documenter-source'>source</a><br>

<a id='Mads.gettarget-Tuple{Associative}' href='#Mads.gettarget-Tuple{Associative}'>#</a>
**`Mads.gettarget`** &mdash; *Method*.



Get observation target

Methods

  * `Mads.gettarget(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:218

Arguments

  * `o::Associative` : observation data

Returns:

  * observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L207-L215' class='documenter-source'>source</a><br>

<a id='Mads.gettargetkeys-Tuple{Associative}' href='#Mads.gettargetkeys-Tuple{Associative}'>#</a>
**`Mads.gettargetkeys`** &mdash; *Method*.



Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary

Methods

  * `Mads.gettargetkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:57

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * keys for all targets in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L46-L54' class='documenter-source'>source</a><br>

<a id='Mads.gettime-Tuple{Associative}' href='#Mads.gettime-Tuple{Associative}'>#</a>
**`Mads.gettime`** &mdash; *Method*.



Get observation time

Methods

  * `Mads.gettime(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:140

Arguments

  * `o::Associative` : observation data

Returns:

  * observation time ("NaN" it time is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L129-L137' class='documenter-source'>source</a><br>

<a id='Mads.getweight-Tuple{Associative}' href='#Mads.getweight-Tuple{Associative}'>#</a>
**`Mads.getweight`** &mdash; *Method*.



Get observation weight

Methods

  * `Mads.getweight(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:179

Arguments

  * `o::Associative` : observation data

Returns:

  * observation weight ("NaN" when weight is missing)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L168-L176' class='documenter-source'>source</a><br>

<a id='Mads.getwellkeys-Tuple{Associative}' href='#Mads.getwellkeys-Tuple{Associative}'>#</a>
**`Mads.getwellkeys`** &mdash; *Method*.



Get keys for all wells in the MADS problem dictionary

Methods

  * `Mads.getwellkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:74

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * keys for all wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L63-L71' class='documenter-source'>source</a><br>

<a id='Mads.getwellsdata-Tuple{Associative}' href='#Mads.getwellsdata-Tuple{Associative}'>#</a>
**`Mads.getwellsdata`** &mdash; *Method*.



Get spatial and temporal data in the `Wells` class

Methods

  * `Mads.getwellsdata(madsdata::Associative; time)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:624

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `time` : [default=`false`]

Returns:

  * array with spatial and temporal data in the `Wells` class


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L612-L620' class='documenter-source'>source</a><br>

<a id='Mads.graphoff-Tuple{}' href='#Mads.graphoff-Tuple{}'>#</a>
**`Mads.graphoff`** &mdash; *Method*.



MADS graph output off

Methods

  * `Mads.graphoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:66


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L60-L64' class='documenter-source'>source</a><br>

<a id='Mads.graphon-Tuple{}' href='#Mads.graphon-Tuple{}'>#</a>
**`Mads.graphon`** &mdash; *Method*.



MADS graph output on

Methods

  * `Mads.graphon()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:57


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L51-L55' class='documenter-source'>source</a><br>

<a id='Mads.haskeyword' href='#Mads.haskeyword'>#</a>
**`Mads.haskeyword`** &mdash; *Function*.



Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

Methods

  * `Mads.haskeyword(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:145
  * `Mads.haskeyword(madsdata::Associative, class::String, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:148

Arguments

  * `class::String` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword::String` : dictionary key
  * `madsdata::Associative` : Mads problem dictionary

Returns: `true` or `false`

Examples:

```julia
- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L164-L177' class='documenter-source'>source</a><br>

<a id='Mads.help-Tuple{}' href='#Mads.help-Tuple{}'>#</a>
**`Mads.help`** &mdash; *Method*.



Produce MADS help information

Methods

  * `Mads.help()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelp.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.importeverywhere-Tuple{String}' href='#Mads.importeverywhere-Tuple{String}'>#</a>
**`Mads.importeverywhere`** &mdash; *Method*.



Import function everywhere from a file. The first function in the file is the one that will be called by Mads to perform the model simulations.

Methods

  * `Mads.importeverywhere(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:332

Arguments

  * `filename::String` : file name

Returns:

  * `madscommandfunction` to execute the model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L320-L329' class='documenter-source'>source</a><br>

<a id='Mads.indexkeys' href='#Mads.indexkeys'>#</a>
**`Mads.indexkeys`** &mdash; *Function*.



Find indexes for dictionary keys based on a string or regular expression

Methods

  * `Mads.indexkeys(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:667
  * `Mads.indexkeys(dict::Associative, key::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:666
  * `Mads.indexkeys(dict::Associative, key::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:667

Arguments

  * `dict::Associative` : dictionary
  * `key::Regex` : the key to find index for
  * `key::String` : the key to find index for


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L669-L673' class='documenter-source'>source</a><br>

<a id='Mads.ins_obs-Tuple{String,String}' href='#Mads.ins_obs-Tuple{String,String}'>#</a>
**`Mads.ins_obs`** &mdash; *Method*.



Apply Mads instruction file `instructionfilename` to read model input file `inputfilename`

Methods

  * `Mads.ins_obs(instructionfilename::String, inputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:865

Arguments

  * `inputfilename::String` : read model input file
  * `instructionfilename::String` : instruction file name

Returns:

  * `obsdict` : result dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L853-L861' class='documenter-source'>source</a><br>

<a id='Mads.instline2regexs-Tuple{String}' href='#Mads.instline2regexs-Tuple{String}'>#</a>
**`Mads.instline2regexs`** &mdash; *Method*.



Convert an instruction line in the Mads instruction file into regular expressions

Methods

  * `Mads.instline2regexs(instline::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:768

Arguments

  * `instline::String` : instruction line

Returns:

  * `regexs` : regular expressions
  * `obsnames` :
  * `getparamhere` :


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L755-L765' class='documenter-source'>source</a><br>

<a id='Mads.invobsweights!-Tuple{Associative,Number}' href='#Mads.invobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invobsweights!`** &mdash; *Method*.



Set inversely proportional observation weights in the MADS problem dictionary

Methods

  * `Mads.invobsweights!(madsdata::Associative, multiplier::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:321

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `multiplier::Number` : weight multiplier


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L313-L317' class='documenter-source'>source</a><br>

<a id='Mads.invwellweights!-Tuple{Associative,Number}' href='#Mads.invwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invwellweights!`** &mdash; *Method*.



Set inversely proportional well weights in the MADS problem dictionary

Methods

  * `Mads.invwellweights!(madsdata::Associative, multiplier::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:372

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `multiplier::Number` : weight multiplier


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L364-L368' class='documenter-source'>source</a><br>

<a id='Mads.islog-Tuple{Associative,String}' href='#Mads.islog-Tuple{Associative,String}'>#</a>
**`Mads.islog`** &mdash; *Method*.



Is parameter with key `parameterkey` log-transformed?

Methods

  * `Mads.islog(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:401

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key

Returns:

  * `ture` if log-transformed, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L389-L397' class='documenter-source'>source</a><br>

<a id='Mads.isobs-Tuple{Associative,Associative}' href='#Mads.isobs-Tuple{Associative,Associative}'>#</a>
**`Mads.isobs`** &mdash; *Method*.



Is a dictionary containing all the observations

Methods

  * `Mads.isobs(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:17

Arguments

  * `dict::Associative` : dictionary
  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * `true` if the dictionary contain all the observations, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.isopt-Tuple{Associative,String}' href='#Mads.isopt-Tuple{Associative,String}'>#</a>
**`Mads.isopt`** &mdash; *Method*.



Is parameter with key `parameterkey` optimizable?

Methods

  * `Mads.isopt(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:381

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key

Returns:

  * `ture` if optimizable, `false` if not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L369-L377' class='documenter-source'>source</a><br>

<a id='Mads.isparam-Tuple{Associative,Associative}' href='#Mads.isparam-Tuple{Associative,Associative}'>#</a>
**`Mads.isparam`** &mdash; *Method*.



Is the dictionary containing all the parameters

Methods

  * `Mads.isparam(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:17

Arguments

  * `dict::Associative` : dictionary
  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * `true` if the dictionary containing all the parameters, `false` otherwise


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable-Tuple{String}' href='#Mads.ispkgavailable-Tuple{String}'>#</a>
**`Mads.ispkgavailable`** &mdash; *Method*.



Checks of package is available

Methods

  * `Mads.ispkgavailable(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:9

Arguments

  * `modulename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}' href='#Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}'>#</a>
**`Mads.krige`** &mdash; *Method*.



Kriging

Methods

  * `Mads.krige(x0mat::Array, X::Array{T<:Any,2}, Z::Array{T<:Any,1}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:69

Arguments

  * `X::Array{T<:Any,2}`
  * `Z::Array{T<:Any,1}`
  * `cov::Function`
  * `x0mat::Array`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L63-L67' class='documenter-source'>source</a><br>

<a id='Mads.levenberg_marquardt' href='#Mads.levenberg_marquardt'>#</a>
**`Mads.levenberg_marquardt`** &mdash; *Function*.



Levenberg-Marquardt optimization

Methods

  * `Mads.levenberg_marquardt(f::Function, g::Function, x0)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:330
  * `Mads.levenberg_marquardt(f::Function, g::Function, x0, o::Function; root, tolX, tolG, tolOF, maxEval, maxIter, maxJacobians, lambda, lambda_scale, lambda_mu, lambda_nu, np_lambda, show_trace, alwaysDoJacobian, callbackiteration, callbackjacobian)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:330

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L283-L287' class='documenter-source'>source</a><br>

<a id='Mads.linktempdir-Tuple{String,String}' href='#Mads.linktempdir-Tuple{String,String}'>#</a>
**`Mads.linktempdir`** &mdash; *Method*.



Link files in a temporary directory

Methods

  * `Mads.linktempdir(madsproblemdir::String, tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1088

Arguments

  * `madsproblemdir::String` : mads problem directory
  * `tempdirname::String` : temporary directory name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1080-L1084' class='documenter-source'>source</a><br>

<a id='Mads.loadasciifile-Tuple{String}' href='#Mads.loadasciifile-Tuple{String}'>#</a>
**`Mads.loadasciifile`** &mdash; *Method*.



Load ASCII file

Methods

  * `Mads.loadasciifile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:7

Arguments

  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsASCII.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.loadjsonfile-Tuple{String}' href='#Mads.loadjsonfile-Tuple{String}'>#</a>
**`Mads.loadjsonfile`** &mdash; *Method*.



Load a JSON file

Methods

  * `Mads.loadjsonfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:10

Arguments

  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsJSON.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsfile-Tuple{String}' href='#Mads.loadmadsfile-Tuple{String}'>#</a>
**`Mads.loadmadsfile`** &mdash; *Method*.



Load MADS input file defining a MADS problem dictionary

Methods

  * `Mads.loadmadsfile(filename::String; julia, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:30

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)

Keywords

  * `format` : acceptable formats are `yaml` and`json`,  [default=`yaml`]
  * `julia` : if `true`, force using `julia` parsing functions; if `false` (default), use `python` parsing functions

Usage:

```
Mads.loadmadsfile(filename)
Mads.loadmadsfile(filename; julia=false)
Mads.loadmadsfile(filename; julia=true)
```

Returns:

  * Mads problem dictionary

Example:

```julia
md = Mads.loadmadsfile("input_file_name.mads")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L3-L25' class='documenter-source'>source</a><br>

<a id='Mads.loadsaltellirestart!-Tuple{Array,String,String}' href='#Mads.loadsaltellirestart!-Tuple{Array,String,String}'>#</a>
**`Mads.loadsaltellirestart!`** &mdash; *Method*.



Load Saltelli sensitivity analysis results for fast simulation restarts

Methods

  * `Mads.loadsaltellirestart!(evalmat::Array, matname::String, restartdir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:568

Arguments

  * `evalmat::Array` : Loaded array
  * `matname::String` : Matrix (array) name (defines the name of the loaded file)
  * `restartdir::String` : directory where files will be stored containing model results for fast simulation restarts

Returns:

  * `true` when successfully loaded, `false` when it is not


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L555-L563' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsYAML.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.localsa-Tuple{Associative}' href='#Mads.localsa-Tuple{Associative}'>#</a>
**`Mads.localsa`** &mdash; *Method*.



Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

Methods

  * `Mads.localsa(madsdata::Associative; sinspace, keyword, filename, format, datafiles, imagefiles, par, obs, J)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:118

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `J` :
  * `datafiles` : [default=`true`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `imagefiles` : [default=`graphoutput`]
  * `keyword` :
  * `obs` : observations for the parameter set
  * `par` : parameter set
  * `sinspace` : [default=`true`]

Dumps:

  * `filename` : output plot file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L98-L106' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_off-Tuple{}' href='#Mads.long_tests_off-Tuple{}'>#</a>
**`Mads.long_tests_off`** &mdash; *Method*.



Turn off execution of long MADS tests (default)

Methods

  * `Mads.long_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:102


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L96-L100' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_on-Tuple{}' href='#Mads.long_tests_on-Tuple{}'>#</a>
**`Mads.long_tests_on`** &mdash; *Method*.



Turn on execution of long MADS tests

Methods

  * `Mads.long_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:93


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L87-L91' class='documenter-source'>source</a><br>

<a id='Mads.madscores' href='#Mads.madscores'>#</a>
**`Mads.madscores`** &mdash; *Function*.



Check the number of processors on a series of servers

Methods

  * `Mads.madscores(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:328
  * `Mads.madscores()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:328

Arguments

  * `nodenames::Array{String,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L322-L326' class='documenter-source'>source</a><br>

<a id='Mads.madscritical-Tuple{String}' href='#Mads.madscritical-Tuple{String}'>#</a>
**`Mads.madscritical`** &mdash; *Method*.



MADS critical error messages

Methods

  * `Mads.madscritical(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:65

Arguments

  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L59-L63' class='documenter-source'>source</a><br>

<a id='Mads.madsdebug' href='#Mads.madsdebug'>#</a>
**`Mads.madsdebug`** &mdash; *Function*.



MADS debug messages (controlled by `quiet` and `debuglevel`)

Methods

  * `Mads.madsdebug(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:19
  * `Mads.madsdebug(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:19

Arguments

  * `level::Int64`
  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L13-L17' class='documenter-source'>source</a><br>

<a id='Mads.madserror-Tuple{String}' href='#Mads.madserror-Tuple{String}'>#</a>
**`Mads.madserror`** &mdash; *Method*.



MADS error messages

Methods

  * `Mads.madserror(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:54

Arguments

  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L48-L52' class='documenter-source'>source</a><br>

<a id='Mads.madsinfo' href='#Mads.madsinfo'>#</a>
**`Mads.madsinfo`** &mdash; *Function*.



MADS information/status messages (controlled by quiet`and`verbositylevel`)

Methods

  * `Mads.madsinfo(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:31
  * `Mads.madsinfo(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:31

Arguments

  * `level::Int64`
  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L25-L29' class='documenter-source'>source</a><br>

<a id='Mads.madsload' href='#Mads.madsload'>#</a>
**`Mads.madsload`** &mdash; *Function*.



Check the load of a series of servers

Methods

  * `Mads.madsload(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:346
  * `Mads.madsload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:346

Arguments

  * `nodenames::Array{String,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L340-L344' class='documenter-source'>source</a><br>

<a id='Mads.madsmathprogbase' href='#Mads.madsmathprogbase'>#</a>
**`Mads.madsmathprogbase`** &mdash; *Function*.



Mads execution using MathProgBase

Methods

  * `Mads.madsmathprogbase()` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:13
  * `Mads.madsmathprogbase(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:13

Arguments

  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMathProgBase.jl#L7-L11' class='documenter-source'>source</a><br>

<a id='Mads.madsoutput' href='#Mads.madsoutput'>#</a>
**`Mads.madsoutput`** &mdash; *Function*.



MADS output (controlled by quiet`and`verbositylevel`)

Methods

  * `Mads.madsoutput(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:7
  * `Mads.madsoutput(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:7

Arguments

  * `level::Int64`
  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.madsup' href='#Mads.madsup'>#</a>
**`Mads.madsup`** &mdash; *Function*.



Check the uptime of a series of servers

Methods

  * `Mads.madsup(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:337
  * `Mads.madsup()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:337

Arguments

  * `nodenames::Array{String,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L331-L335' class='documenter-source'>source</a><br>

<a id='Mads.madswarn-Tuple{String}' href='#Mads.madswarn-Tuple{String}'>#</a>
**`Mads.madswarn`** &mdash; *Method*.



MADS warning messages

Methods

  * `Mads.madswarn(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:43

Arguments

  * `message::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLog.jl#L37-L41' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make a conditional log likelihood function that accepts an array containing the opt parameters' values

Methods

  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:71

Arguments

  * `conditionalloglikelihood`
  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L65-L69' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make array of conditional log-likelihoods

Methods

  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:160
  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:71

Arguments

  * `conditionalloglikelihood`
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * array of conditional log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsBayesInfoGap.jl#L149-L157' class='documenter-source'>source</a><br>

<a id='Mads.makearrayfunction' href='#Mads.makearrayfunction'>#</a>
**`Mads.makearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameters' values

```julia
Mads.makearrayfunction(madsdata, f)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : function

Returns:

  * function accepting an array containing the optimal parameter values

Methods

  * `Mads.makearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:23
  * `Mads.makearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:23

Arguments

  * `f::Function`
  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L4-L21' class='documenter-source'>source</a><br>

<a id='Mads.makearrayloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayloglikelihood`** &mdash; *Method*.



Make a log likelihood function that accepts an array containing the opt parameters' values

Methods

  * `Mads.makearrayloglikelihood(madsdata::Associative, loglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:88

Arguments

  * `loglikelihood`
  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L82-L86' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsBayesInfoGap.jl#L23-L31' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsBayesInfoGap.jl#L8-L16' class='documenter-source'>source</a><br>

<a id='Mads.makecomputeconcentrations-Tuple{Associative}' href='#Mads.makecomputeconcentrations-Tuple{Associative}'>#</a>
**`Mads.makecomputeconcentrations`** &mdash; *Method*.



Create a function to compute concentrations for all the observation points using Anasol

Methods

  * `Mads.makecomputeconcentrations(madsdata::Associative; calczeroweightobs, calcpredictions)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:134

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `calcpredictions` : [default=`true`]
  * `calczeroweightobs` : [default=`false`]

Returns:

  * function to compute concentrations; the new function returns a dictionary of observations and model predicted concentrations

Examples:

```julia
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L112-L129' class='documenter-source'>source</a><br>

<a id='Mads.makedoublearrayfunction' href='#Mads.makedoublearrayfunction'>#</a>
**`Mads.makedoublearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameter values, and returns an array of observations

```julia
Mads.makedoublearrayfunction(madsdata, f)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : function

Returns:

  * function accepting an array containing the optimal parameters' values, and returning an array of observations

Methods

  * `Mads.makedoublearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:50
  * `Mads.makedoublearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:50

Arguments

  * `f::Function`
  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L31-L48' class='documenter-source'>source</a><br>

<a id='Mads.makelmfunctions-Tuple{Associative}' href='#Mads.makelmfunctions-Tuple{Associative}'>#</a>
**`Mads.makelmfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization

Methods

  * `Mads.makelmfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:111

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * forward model, gradient, objective functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L100-L108' class='documenter-source'>source</a><br>

<a id='Mads.makelocalsafunction-Tuple{Associative}' href='#Mads.makelocalsafunction-Tuple{Associative}'>#</a>
**`Mads.makelocalsafunction`** &mdash; *Method*.



Make gradient function needed for local sensitivity analysis

Methods

  * `Mads.makelocalsafunction(madsdata::Associative; multiplycenterbyweights)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:26

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `multiplycenterbyweights` : [default=`true`]

Returns:

  * gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L14-L22' class='documenter-source'>source</a><br>

<a id='Mads.makelogprior-Tuple{Associative}' href='#Mads.makelogprior-Tuple{Associative}'>#</a>
**`Mads.makelogprior`** &mdash; *Method*.



Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`

Methods

  * `Mads.makelogprior(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:459

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Return:

  * the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L448-L456' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunction-Tuple{Associative}' href='#Mads.makemadscommandfunction-Tuple{Associative}'>#</a>
**`Mads.makemadscommandfunction`** &mdash; *Method*.



Make MADS function to execute the model defined in the inpit MADS problem dictionary

Methods

  * `Mads.makemadscommandfunction(madsdata_in::Associative; calczeroweightobs, calcpredictions)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:62

Arguments

  * `madsdata_in::Associative` : Mads problem dictionary

Keywords

  * `calcpredictions` : Calculate predictions [default=`true`]
  * `calczeroweightobs` : Calculate zero weight observations [default=`false`]

Usage:

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L8-L56' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunctionandgradient' href='#Mads.makemadscommandfunctionandgradient'>#</a>
**`Mads.makemadscommandfunctionandgradient`** &mdash; *Function*.



Make MADS forward & gradient functions for the model defined in the MADS problem dictionary `madsdata`

Methods

  * `Mads.makemadscommandfunctionandgradient(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:373
  * `Mads.makemadscommandfunctionandgradient(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:377

Arguments

  * `f::Function` : Mads forward model function
  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * Mads forward function for the model defined in the MADS problem dictionary `madsdata`
  * Mads gradient function for the model defined in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L435-L444' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandgradient' href='#Mads.makemadscommandgradient'>#</a>
**`Mads.makemadscommandgradient`** &mdash; *Function*.



Make MADS gradient function to compute the parameter-space gradient for the model defined in the MADS problem dictionary `madsdata`

Methods

  * `Mads.makemadscommandgradient(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:348
  * `Mads.makemadscommandgradient(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:352

Arguments

  * `f::Function` : Mads forward model function
  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * the parameter-space gradient for the model defined in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L360-L368' class='documenter-source'>source</a><br>

<a id='Mads.makemadsconditionalloglikelihood-Tuple{Associative}' href='#Mads.makemadsconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsconditionalloglikelihood`** &mdash; *Method*.



Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations. Model parameters and observations are defined in the MADS problem dictionary `madsdata`.

Methods

  * `Mads.makemadsconditionalloglikelihood(madsdata::Associative; weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:482

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `weightfactor` : Weight factor [default=`1`]

Return:

  * the conditional log-likelihood


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L469-L478' class='documenter-source'>source</a><br>

<a id='Mads.makemadsloglikelihood-Tuple{Associative}' href='#Mads.makemadsloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsloglikelihood`** &mdash; *Method*.



Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations. The function can be provided as an external function in the MADS problem dictionary under `LogLikelihood` or computed internally.

Methods

  * `Mads.makemadsloglikelihood(madsdata::Associative; weightfactor)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:516

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `weightfactor` : Weight factor [default=`1`]

Returns:

  * the log-likelihood for a given set of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L503-L512' class='documenter-source'>source</a><br>

<a id='Mads.makemadsreusablefunction' href='#Mads.makemadsreusablefunction'>#</a>
**`Mads.makemadsreusablefunction`** &mdash; *Function*.



Make Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)

Methods

  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:229
  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function, suffix::String; usedict)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:229
  * `Mads.makemadsreusablefunction(paramkeys::Array{T<:Any,1}, obskeys::Array{T<:Any,1}, madsdatarestart::Union{Bool,String}, madscommandfunction::Function, restartdir::String; usedict)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:232

Arguments

  * `madscommandfunction::Function` : Mads function to execute a forward model simulation
  * `madsdata::Associative` : Mads problem dictionary
  * `madsdatarestart::Union{Bool,String}` : Restart type (memory/disk) or on/off status
  * `obskeys::Array{T<:Any,1}` : Dictionary of observation keys
  * `paramkeys::Array{T<:Any,1}` : Dictionary of parameter keys
  * `restartdir::String` : Restart directory where the reusable model results are stored
  * `suffix::String` : Suffix to be added to the name of restart directory

Keywords

  * `usedict` : Use dictionary [default=`true`]

Returns:

  * Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsFunc.jl#L247-L255' class='documenter-source'>source</a><br>

<a id='Mads.makempbfunctions-Tuple{Associative}' href='#Mads.makempbfunctions-Tuple{Associative}'>#</a>
**`Mads.makempbfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for MathProgBase optimization

Methods

  * `Mads.makempbfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:82

Arguments

  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMathProgBase.jl#L76-L80' class='documenter-source'>source</a><br>

<a id='Mads.makesvrmodel' href='#Mads.makesvrmodel'>#</a>
**`Mads.makesvrmodel`** &mdash; *Function*.



Make SVR model functions (executor and cleaner)

Methods

  * `Mads.makesvrmodel(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:200
  * `Mads.makesvrmodel(madsdata::Associative, numberofsamples::Integer; check, addminmax, loaddata, savefile, svm_type, kernel_type, degree, gamma, coef0, C, nu, p, cache_size, eps, shrinking, probability, verbose, seed)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:200

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `numberofsamples::Integer` : number of samples [default=`100`]

Keywords

  * `C` : [default=`1000.0`]
  * `addminmax` : [default=`true`]
  * `cache_size` : [default=`100.0`]
  * `check` : [default=`false`]
  * `coef0` : [default=`0`]
  * `degree` : [default=`3`]
  * `eps` : [default=`0.001`]
  * `gamma` : [default=`1/numberofsamples`]
  * `kernel_type` : [default=`SVR.RBF`]
  * `loaddata` : [default=`false`]
  * `nu` : [default=`0.5`]
  * `p` : [default=`0.001`]
  * `probability` : [default=`false`]
  * `savefile` : [default=`false`]
  * `seed` : [default=`0`]
  * `shrinking` : [default=`true`]
  * `svm_type` : [default=`SVR.EPSILON_SVR`]
  * `verbose` : [default=`false`]

Returns:

  * svrexec, svrread, svrsave, svrclean


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L170-L178' class='documenter-source'>source</a><br>

<a id='Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}' href='#Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.maxtorealmax!`** &mdash; *Method*.



Scale down values larger than max(Float32) in a Dataframe `df` so that Gadfly can plot the data

Methods

  * `Mads.maxtorealmax!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1053

Arguments

  * `df::DataFrames.DataFrame` : dataframe


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L1046-L1050' class='documenter-source'>source</a><br>

<a id='Mads.meshgrid-Tuple{Array{T,1},Array{T,1}}' href='#Mads.meshgrid-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.meshgrid`** &mdash; *Method*.



Create mesh grid

Methods

  * `Mads.meshgrid(x::Array{T<:Any,1}, y::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:304

Arguments

  * `x::Array{T<:Any,1}` : vector of grid x coordinates
  * `y::Array{T<:Any,1}` : vector of grid y coordinates

Returns:

  * 2D grid coordinates based on the coordinates contained in vectors `x` and `y`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L292-L300' class='documenter-source'>source</a><br>

<a id='Mads.mkdir-Tuple{String}' href='#Mads.mkdir-Tuple{String}'>#</a>
**`Mads.mkdir`** &mdash; *Method*.



Create a directory (if does not already exist)

Methods

  * `Mads.mkdir(dirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1116

Arguments

  * `dirname::String` : directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1109-L1113' class='documenter-source'>source</a><br>

<a id='Mads.modelinformationcriteria' href='#Mads.modelinformationcriteria'>#</a>
**`Mads.modelinformationcriteria`** &mdash; *Function*.



Model section information criteria

Methods

  * `Mads.modelinformationcriteria(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:7
  * `Mads.modelinformationcriteria(madsdata::Associative, par::Array{Float64,N<:Any})` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:7

Arguments

  * `madsdata::Associative`
  * `par::Array{Float64,N<:Any}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsModelSelection.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.modobsweights!-Tuple{Associative,Number}' href='#Mads.modobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modobsweights!`** &mdash; *Method*.



Modify (multiply) observation weights in the MADS problem dictionary

Methods

  * `Mads.modobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:307

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `value::Number` : value for modifing observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L299-L303' class='documenter-source'>source</a><br>

<a id='Mads.modwellweights!-Tuple{Associative,Number}' href='#Mads.modwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modwellweights!`** &mdash; *Method*.



Modify (multiply) well weights in the MADS problem dictionary

Methods

  * `Mads.modwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:355

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `value::Number` : value for well weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L347-L351' class='documenter-source'>source</a><br>

<a id='Mads.montecarlo-Tuple{Associative}' href='#Mads.montecarlo-Tuple{Associative}'>#</a>
**`Mads.montecarlo`** &mdash; *Method*.



Monte Carlo analysis

Methods

  * `Mads.montecarlo(madsdata::Associative; N, filename)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:182

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples [default=`100`]
  * `filename` : file name

Returns:

  * parameter dictionary containing the data arrays

Dumps:

  * YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)

Example:

```julia
Mads.montecarlo(madsdata; N=100)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L159-L177' class='documenter-source'>source</a><br>

<a id='Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}' href='#Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}'>#</a>
**`Mads.naive_get_deltax`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: get the LM parameter space step

Methods

  * `Mads.naive_get_deltax(JpJ::Array{Float64,2}, Jp::Array{Float64,2}, f0::Array{Float64,1}, lambda::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:218

Arguments

  * `Jp::Array{Float64,2}` :
  * `JpJ::Array{Float64,2}` :
  * `f0::Array{Float64,1}` :
  * `lambda::Number` :

Returns:

  * the LM parameter space step


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L204-L212' class='documenter-source'>source</a><br>

<a id='Mads.naive_levenberg_marquardt' href='#Mads.naive_levenberg_marquardt'>#</a>
**`Mads.naive_levenberg_marquardt`** &mdash; *Function*.



Naive Levenberg-Marquardt optimization

Methods

  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:268
  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1}, o::Function; maxIter, maxEval, np_lambda, lambda, lambda_mu)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:268

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L249-L257' class='documenter-source'>source</a><br>

<a id='Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}' href='#Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}'>#</a>
**`Mads.naive_lm_iteration`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: perform LM iteration

Methods

  * `Mads.naive_lm_iteration(f::Function, g::Function, o::Function, x0::Array{Float64,1}, f0::Array{Float64,1}, lambdas::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:239

Arguments

  * `f0::Array{Float64,1}` :
  * `f::Function` : forward model function
  * `g::Function` : gradient function for the forward model
  * `lambdas::Array{Float64,1}` :
  * `o::Function` : objective function
  * `x0::Array{Float64,1}` : initial parameter guess

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L223-L231' class='documenter-source'>source</a><br>

<a id='Mads.noplot-Tuple{}' href='#Mads.noplot-Tuple{}'>#</a>
**`Mads.noplot`** &mdash; *Method*.



Disable MADS plotting

Methods

  * `Mads.noplot()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:239


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L233-L237' class='documenter-source'>source</a><br>

<a id='Mads.obslineismatch-Tuple{String,Array{Regex,1}}' href='#Mads.obslineismatch-Tuple{String,Array{Regex,1}}'>#</a>
**`Mads.obslineismatch`** &mdash; *Method*.



Match an instruction line in the Mads instruction file with model input file

Methods

  * `Mads.obslineismatch(obsline::String, regexs::Array{Regex,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:817

Arguments

  * `obsline::String` : instruction line
  * `regexs::Array{Regex,1}` :

Returns:

  * true or false


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L805-L813' class='documenter-source'>source</a><br>

<a id='Mads.of' href='#Mads.of'>#</a>
**`Mads.of`** &mdash; *Function*.



Compute objective function

Methods

  * `Mads.of(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:59
  * `Mads.of(madsdata::Associative, resultvec::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:52
  * `Mads.of(madsdata::Associative, resultdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:56

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `resultdict::Associative` : result dictionary
  * `resultvec::Array{T<:Any,1}` : result vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L63-L67' class='documenter-source'>source</a><br>

<a id='Mads.paramarray2dict-Tuple{Associative,Array}' href='#Mads.paramarray2dict-Tuple{Associative,Array}'>#</a>
**`Mads.paramarray2dict`** &mdash; *Method*.



Convert a parameter array to a parameter dictionary of arrays

Methods

  * `Mads.paramarray2dict(madsdata::Associative, array::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:240

Arguments

  * `array::Array` : parameter array
  * `madsdata::Associative` : MADS problem dictionary

Returns:

  * a parameter dictionary of arrays


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L228-L236' class='documenter-source'>source</a><br>

<a id='Mads.paramdict2array-Tuple{Associative}' href='#Mads.paramdict2array-Tuple{Associative}'>#</a>
**`Mads.paramdict2array`** &mdash; *Method*.



Convert a parameter dictionary of arrays to a parameter array

Methods

  * `Mads.paramdict2array(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:259

Arguments

  * `dict::Associative` : parameter dictionary of arrays

Returns:

  * a parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L248-L256' class='documenter-source'>source</a><br>

<a id='Mads.parsemadsdata!-Tuple{Associative}' href='#Mads.parsemadsdata!-Tuple{Associative}'>#</a>
**`Mads.parsemadsdata!`** &mdash; *Method*.



Parse loaded Mads problem dictionary

Methods

  * `Mads.parsemadsdata!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:59

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L52-L56' class='documenter-source'>source</a><br>

<a id='Mads.parsenodenames' href='#Mads.parsenodenames'>#</a>
**`Mads.parsenodenames`** &mdash; *Function*.



Parse string with node names defined in SLURM

Methods

  * `Mads.parsenodenames(nodenames::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:208
  * `Mads.parsenodenames(nodenames::String, ntasks_per_node::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:208

Arguments

  * `nodenames::String`
  * `ntasks_per_node::Integer`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L202-L206' class='documenter-source'>source</a><br>

<a id='Mads.partialof-Tuple{Associative,Associative,Regex}' href='#Mads.partialof-Tuple{Associative,Associative,Regex}'>#</a>
**`Mads.partialof`** &mdash; *Method*.



Compute the sum of squared residuals for observations that match a regular expression

Methods

  * `Mads.partialof(madsdata::Associative, resultdict::Associative, regex::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:85

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `regex::Regex` : regular expression
  * `resultdict::Associative` : result dictionary

Returns:

  * the sum of squared residuals for observations that match the regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L72-L80' class='documenter-source'>source</a><br>

<a id='Mads.plotgrid' href='#Mads.plotgrid'>#</a>
**`Mads.plotgrid`** &mdash; *Function*.



Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

Methods

  * `Mads.plotgrid(madsdata::Associative; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:55
  * `Mads.plotgrid(madsdata::Associative, s::Array{Float64,N<:Any}; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:5
  * `Mads.plotgrid(madsdata::Associative, parameters::Associative; addtitle, title, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:60

Arguments

  * `madsdata::Associative`
  * `parameters::Associative`
  * `s::Array{Float64,N<:Any}`

Keywords

  * `addtitle`
  * `filename`
  * `format`
  * `title`

Examples:

```julia
Mads.plotgrid(madsdata, s; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata, parameters; addtitle=true, title="", filename="", format="")
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `parameters` : dictionary with model parameters
  * `s` : model predictions array
  * `addtitle` : add plot title [true]
  * `title` : plot title
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlotPy.jl#L64-L86' class='documenter-source'>source</a><br>

<a id='Mads.plotmadsproblem-Tuple{Associative}' href='#Mads.plotmadsproblem-Tuple{Associative}'>#</a>
**`Mads.plotmadsproblem`** &mdash; *Method*.



Plot contaminant sources and wells defined in MADS problem dictionary

Methods

  * `Mads.plotmadsproblem(madsdata::Associative; imagefile, format, filename, keyword)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:75

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `imagefile` : dump image file [default=`false`]
  * `keyword` : to be added in the filename

Dumps:

  * plot of contaminant sources and wells


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L60-L68' class='documenter-source'>source</a><br>

<a id='Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}' href='#Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}'>#</a>
**`Mads.plotmass`** &mdash; *Method*.



Plot injected/reduced contaminant mass

Methods

  * `Mads.plotmass(lambda::Array{Float64,1}, mass_injected::Array{Float64,1}, mass_reduced::Array{Float64,1}, filename::String; format)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasolPlot.jl:21

Arguments

  * `filename::String`
  * `lambda::Array{Float64,1}`
  * `mass_injected::Array{Float64,1}`
  * `mass_reduced::Array{Float64,1}`

Keywords

  * `format`

  * `Mads.plotmass(lambda, mass_injected, mass_reduced, filename="file_name")`

Arguments:

  * `lambda` : array with all the lambda values
  * `mass_injected` : array with associated total injected mass
  * `mass_reduced` : array with associated total reduced mass
  * `filename` : output filename for the generated plot
  * `format` : output plot format (`png`, `pdf`, etc.)

Dumps: image file with name `filename` and in specified `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasolPlot.jl#L3-L19' class='documenter-source'>source</a><br>

<a id='Mads.plotmatches' href='#Mads.plotmatches'>#</a>
**`Mads.plotmatches`** &mdash; *Function*.



Plot the matches between model predictions and observations

Methods

  * `Mads.plotmatches(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:146
  * `Mads.plotmatches(madsdata::Associative, rx::Regex; plotdata, filename, format, title, xtitle, ytitle, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:146
  * `Mads.plotmatches(madsdata::Associative, dict_in::Associative; plotdata, filename, format, title, xtitle, ytitle, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:178
  * `Mads.plotmatches(madsdata::Associative, result::Associative, rx::Regex; plotdata, filename, format, key2time, title, xtitle, ytitle, separate_files, hsize, vsize, linewidth, pointsize, obs_plot_dots, noise, dpi, colors, display)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:154

Arguments

  * `dict_in::Associative` : dictionary with model parameters
  * `madsdata::Associative` : Mads problem dictionary
  * `result::Associative` : dictionary with model predictions
  * `rx::Regex` : regular expression to filter the outputs

Keywords

  * `colors` : array with plot colors
  * `display` : [default=`false`]
  * `dpi` : graph resolution [default=`Mads.dpi`]
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]
  * `hsize` : graph horizontal size[default=`6Gadfly.inch`]
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
  * `ytitle` : y-axis title

Dumps:

  * plot of the matches between model predictions and observations

Examples:

```julia
Mads.plotmatches(madsdata; filename="", format="")
Mads.plotmatches(madsdata, dict_in; filename="", format="")
Mads.plotmatches(madsdata, result; filename="", format="")
Mads.plotmatches(madsdata, result, r"NO3"; filename="", format="")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L324-L341' class='documenter-source'>source</a><br>

<a id='Mads.plotobsSAresults-Tuple{Associative,Associative}' href='#Mads.plotobsSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.plotobsSAresults`** &mdash; *Method*.



Plot the sensitivity analysis results for the observations

Methods

  * `Mads.plotobsSAresults(madsdata::Associative, result::Associative; filter, keyword, filename, format, debug, separate_files, xtitle, ytitle, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:550

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `result::Associative` : sensitivity analysis results

Keywords

  * `debug` : [default=`false`]
  * `filename` : output file name
  * `filter` : string or regex to plot only observations containing `filter`
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : to be added in the auto-generated filename
  * `linewidth` : [default=`2Gadfly.pt`]
  * `pointsize` : [default=`2Gadfly.pt`]
  * `separate_files` : [default=`false`]
  * `xtitle` : [default=`"Time [years]"`]
  * `ytitle` : [default=`"Concentration [ppb]"`]

Dumps:

  * plot of the sensitivity analysis results for the observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L528-L536' class='documenter-source'>source</a><br>

<a id='Mads.plotrobustnesscurves-Tuple{Associative,Dict}' href='#Mads.plotrobustnesscurves-Tuple{Associative,Dict}'>#</a>
**`Mads.plotrobustnesscurves`** &mdash; *Method*.



Plot BIG-DT robustness curves

Methods

  * `Mads.plotrobustnesscurves(madsdata::Associative, bigdtresults::Dict; filename, format, maxprob, maxhoriz)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGapPlot.jl:16

Arguments

  * `bigdtresults::Dict`
  * `madsdata::Associative`

Keywords

  * `filename`
  * `format`
  * `maxhoriz`
  * `maxprob`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `bigdtresults` : BIG-DT results
  * `filename` : output file name used to dump plots
  * `format` : output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsBayesInfoGapPlot.jl#L3-L14' class='documenter-source'>source</a><br>

<a id='Mads.plotseries' href='#Mads.plotseries'>#</a>
**`Mads.plotseries`** &mdash; *Function*.



Create plots of data series

Methods

  * `Mads.plotseries(X::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:1062
  * `Mads.plotseries(X::Array{T<:Any,2}, filename::String; format, xtitle, ytitle, title, name, combined, hsize, vsize, linewidth, dpi, colors)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:1062

Arguments

  * `X::Array{T<:Any,2}` : matrix with the series data
  * `filename::String` : output file name

Keywords

  * `colors` :
  * `combined` : [default=`true`]
  * `dpi` : [default=`Mads.dpi`]
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `hsize` : [default=`6Gadfly.inch`]
  * `linewidth` : [default=`2Gadfly.pt`]
  * `name` : series name, [default=`Sources`]
  * `title` : plot title, [default=`Sources`]
  * `vsize` : [default=`4Gadfly.inch`]
  * `xtitle` : x-axis title, [default=`X`]
  * `ytitle` : y-axis title, [default=`Y`]

Dumps:

  * Plots of data series


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L1039-L1047' class='documenter-source'>source</a><br>

<a id='Mads.plotwellSAresults' href='#Mads.plotwellSAresults'>#</a>
**`Mads.plotwellSAresults`** &mdash; *Function*.



Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

Methods

  * `Mads.plotwellSAresults(madsdata::Associative, result; xtitle, ytitle, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:416
  * `Mads.plotwellSAresults(madsdata::Associative, result, wellname; xtitle, ytitle, filename, format)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:427

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `result` : sensitivity analysis results
  * `wellname` : well name

Keywords

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `xtitle` : x-axis title, [default=`"Time years"`]
  * `ytitle` : y-axis title, [default=`"Concentration ppb"`]

Dumps:

  * Plot of the sensitivity analysis results for all the wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L511-L519' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults-Tuple{Associative,Associative}' href='#Mads.printSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults`** &mdash; *Method*.



Print sensitivity analysis results

Methods

  * `Mads.printSAresults(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:889

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `results::Associative` : sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L881-L885' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults2-Tuple{Associative,Associative}' href='#Mads.printSAresults2-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults2`** &mdash; *Method*.



Print sensitivity analysis results (method 2)

Methods

  * `Mads.printSAresults2(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:971

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `results::Associative` : sensitivity analysis results (method 2)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L963-L967' class='documenter-source'>source</a><br>

<a id='Mads.printerrormsg-Tuple{Any}' href='#Mads.printerrormsg-Tuple{Any}'>#</a>
**`Mads.printerrormsg`** &mdash; *Method*.



Print error message

Methods

  * `Mads.printerrormsg(e)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:285

Arguments

  * `e` : error message


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L278-L282' class='documenter-source'>source</a><br>

<a id='Mads.push' href='#Mads.push'>#</a>
**`Mads.push`** &mdash; *Function*.



Push the latest version of the Mads / Julia modules in the repo

Methods

  * `Mads.push(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:115
  * `Mads.push()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:115

Arguments

  * `modulename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L109-L113' class='documenter-source'>source</a><br>

<a id='Mads.quietoff-Tuple{}' href='#Mads.quietoff-Tuple{}'>#</a>
**`Mads.quietoff`** &mdash; *Method*.



Make MADS not quiet

Methods

  * `Mads.quietoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:47


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L41-L45' class='documenter-source'>source</a><br>

<a id='Mads.quieton-Tuple{}' href='#Mads.quieton-Tuple{}'>#</a>
**`Mads.quieton`** &mdash; *Method*.



Make MADS quiet

Methods

  * `Mads.quieton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:37


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L31-L35' class='documenter-source'>source</a><br>

<a id='Mads.readasciipredictions-Tuple{String}' href='#Mads.readasciipredictions-Tuple{String}'>#</a>
**`Mads.readasciipredictions`** &mdash; *Method*.



Read MADS predictions from an ASCII file

Methods

  * `Mads.readasciipredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:26

Arguments

  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsASCII.jl#L20-L24' class='documenter-source'>source</a><br>

<a id='Mads.readjsonpredictions-Tuple{String}' href='#Mads.readjsonpredictions-Tuple{String}'>#</a>
**`Mads.readjsonpredictions`** &mdash; *Method*.



Read MADS model predictions from a JSON file

Methods

  * `Mads.readjsonpredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:37

Arguments

  * `filename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsJSON.jl#L31-L35' class='documenter-source'>source</a><br>

<a id='Mads.readmodeloutput-Tuple{Associative}' href='#Mads.readmodeloutput-Tuple{Associative}'>#</a>
**`Mads.readmodeloutput`** &mdash; *Method*.



Read model outputs saved for MADS

Methods

  * `Mads.readmodeloutput(madsdata::Associative; obskeys)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:604

Arguments

  * `madsdata::Associative` : Mads problem dictionary

Keywords

  * `obskeys` : [default=getobskeys(madsdata)]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L596-L600' class='documenter-source'>source</a><br>

<a id='Mads.readobservations' href='#Mads.readobservations'>#</a>
**`Mads.readobservations`** &mdash; *Function*.



Read observations

Methods

  * `Mads.readobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:901
  * `Mads.readobservations(madsdata::Associative, obskeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:901

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `obskeys::Array{T<:Any,1}` : observation keys, [default=`getobskeys(madsdata)`]

Returns:

  * Dictionary with Mads observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L889-L897' class='documenter-source'>source</a><br>

<a id='Mads.readobservations_cmads-Tuple{Associative}' href='#Mads.readobservations_cmads-Tuple{Associative}'>#</a>
**`Mads.readobservations_cmads`** &mdash; *Method*.



Read observations using C Mads library

Methods

  * `Mads.readobservations_cmads(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:9

Arguments

  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-old/MadsCMads.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.readyamlpredictions-Tuple{String}' href='#Mads.readyamlpredictions-Tuple{String}'>#</a>
**`Mads.readyamlpredictions`** &mdash; *Method*.



Read MADS model predictions from a YAML file `filename`

Methods

  * `Mads.readyamlpredictions(filename::String; julia)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:120

Arguments

  * `filename::String` : file name

Keywords

  * `julia` : if `true`, use `julia` YAML library (if available); if `false` (default), use `python` YAML library (if available)

Returns:

  * data in yaml input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsYAML.jl#L108-L116' class='documenter-source'>source</a><br>

<a id='Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}' href='#Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}'>#</a>
**`Mads.regexs2obs`** &mdash; *Method*.



Get observations for a set of regular expressions

Methods

  * `Mads.regexs2obs(obsline::String, regexs::Array{Regex,1}, obsnames::Array{String,1}, getparamhere::Array{Bool,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:835

Arguments

  * `getparamhere::Array{Bool,1}` :
  * `obsline::String` :
  * `obsnames::Array{String,1}` :
  * `regexs::Array{Regex,1}` : regular expressions

Returns:

  * `obsdict` : observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L821-L829' class='documenter-source'>source</a><br>

<a id='Mads.reload-Tuple{}' href='#Mads.reload-Tuple{}'>#</a>
**`Mads.reload`** &mdash; *Method*.



Reload Mads modules

Methods

  * `Mads.reload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:34


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsTest.jl#L28-L32' class='documenter-source'>source</a><br>

<a id='Mads.removesource!' href='#Mads.removesource!'>#</a>
**`Mads.removesource!`** &mdash; *Function*.



Remove a contamination source

Methods

  * `Mads.removesource!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:39
  * `Mads.removesource!(madsdata::Associative, sourceid::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:39

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `sourceid::Int64` : source id [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L31-L35' class='documenter-source'>source</a><br>

<a id='Mads.removesourceparameters!-Tuple{Associative}' href='#Mads.removesourceparameters!-Tuple{Associative}'>#</a>
**`Mads.removesourceparameters!`** &mdash; *Method*.



Remove contaminant source parameters

Methods

  * `Mads.removesourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:90

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsAnasol.jl#L83-L87' class='documenter-source'>source</a><br>

<a id='Mads.required' href='#Mads.required'>#</a>
**`Mads.required`** &mdash; *Function*.



Lists modules required by a module (Mads by default)

Methods

  * `Mads.required(modulename::String, filtermodule::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25
  * `Mads.required(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25
  * `Mads.required()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25

Arguments

  * `filtermodule::String`
  * `modulename::String`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L19-L23' class='documenter-source'>source</a><br>

<a id='Mads.resetmodelruns-Tuple{}' href='#Mads.resetmodelruns-Tuple{}'>#</a>
**`Mads.resetmodelruns`** &mdash; *Method*.



Reset the model runs count to be equal to zero

Methods

  * `Mads.resetmodelruns()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:141


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L135-L139' class='documenter-source'>source</a><br>

<a id='Mads.residuals' href='#Mads.residuals'>#</a>
**`Mads.residuals`** &mdash; *Function*.



Compute residuals

Methods

  * `Mads.residuals(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:33
  * `Mads.residuals(madsdata::Associative, resultvec::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:7
  * `Mads.residuals(madsdata::Associative, resultdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:30

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `resultdict::Associative` : result dictionary
  * `resultvec::Array{T<:Any,1}` : result vector

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsLevenbergMarquardt.jl#L37-L45' class='documenter-source'>source</a><br>

<a id='Mads.restartoff-Tuple{}' href='#Mads.restartoff-Tuple{}'>#</a>
**`Mads.restartoff`** &mdash; *Method*.



MADS restart off

Methods

  * `Mads.restartoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:18


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L12-L16' class='documenter-source'>source</a><br>

<a id='Mads.restarton-Tuple{}' href='#Mads.restarton-Tuple{}'>#</a>
**`Mads.restarton`** &mdash; *Method*.



MADS restart on

Methods

  * `Mads.restarton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}' href='#Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}'>#</a>
**`Mads.reweighsamples`** &mdash; *Method*.



Reweigh samples using importance sampling – returns a vector of log-likelihoods after reweighing

Methods

  * `Mads.reweighsamples(madsdata::Associative, predictions::Array, oldllhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:299

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `oldllhoods::Array{T<:Any,1}` : the log likelihoods of the parameters in the old distribution
  * `predictions::Array` : the model predictions for each of the samples

Returns:

  * vector of log-likelihoods after reweighing


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L286-L294' class='documenter-source'>source</a><br>

<a id='Mads.rmdir-Tuple{String}' href='#Mads.rmdir-Tuple{String}'>#</a>
**`Mads.rmdir`** &mdash; *Method*.



Remove directory

Methods

  * `Mads.rmdir(dir::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:999

Arguments

  * `dir::String` : the directory to be removed

Keywords

  * `path` : path of the directory, [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L991-L995' class='documenter-source'>source</a><br>

<a id='Mads.rmfile-Tuple{String}' href='#Mads.rmfile-Tuple{String}'>#</a>
**`Mads.rmfile`** &mdash; *Method*.



Remove file

Methods

  * `Mads.rmfile(filename::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1015

Arguments

  * `filename::String` : the file to be removed

Keywords

  * `path` : path of the file, [default=`current path`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1007-L1011' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_ext-Tuple{String}' href='#Mads.rmfiles_ext-Tuple{String}'>#</a>
**`Mads.rmfiles_ext`** &mdash; *Method*.



Remove files with extension `ext`

Methods

  * `Mads.rmfiles_ext(ext::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1031

Arguments

  * `ext::String` : extension

Keywords

  * `path` : path of the files to be removed, [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1023-L1027' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_root-Tuple{String}' href='#Mads.rmfiles_root-Tuple{String}'>#</a>
**`Mads.rmfiles_root`** &mdash; *Method*.



Remove files with root `root`

Methods

  * `Mads.rmfiles_root(root::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:1044

Arguments

  * `root::String` : root

Keywords

  * `path` : path of the files to be removed, [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L1036-L1040' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock-Tuple{Array{T,1}}' href='#Mads.rosenbrock-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock`** &mdash; *Method*.



Rosenbrock test function

Methods

  * `Mads.rosenbrock(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:30

Arguments

  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L24-L28' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods

  * `Mads.rosenbrock2_gradient_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:16

Arguments

  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_lm`** &mdash; *Method*.



Rosenbrock test function (more difficult to solve)

Methods

  * `Mads.rosenbrock2_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:7

Arguments

  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}' href='#Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient!`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

Methods

  * `Mads.rosenbrock_gradient!(x::Array{T<:Any,1}, storage::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:48

Arguments

  * `storage::Array{T<:Any,1}`
  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L42-L46' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separetely)

Methods

  * `Mads.rosenbrock_gradient_lm(x::Array{T<:Any,1}; dx, center)` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:58

Arguments

  * `x::Array{T<:Any,1}`

Keywords

  * `center`
  * `dx`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L52-L56' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}' href='#Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}'>#</a>
**`Mads.rosenbrock_hessian!`** &mdash; *Method*.



Parameter Hessian of the Rosenbrock test function

Methods

  * `Mads.rosenbrock_hessian!(x::Array{T<:Any,1}, storage::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:72

Arguments

  * `storage::Array{T<:Any,2}`
  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_lm`** &mdash; *Method*.



Rosenbrock test function for LM optimization (returns the 2 components separetely)

Methods

  * `Mads.rosenbrock_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:39

Arguments

  * `x::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsTestFunctions.jl#L33-L37' class='documenter-source'>source</a><br>

<a id='Mads.runcmd' href='#Mads.runcmd'>#</a>
**`Mads.runcmd`** &mdash; *Function*.



Run external command and pipe stdout and stderr

Methods

  * `Mads.runcmd(cmdstring::String; pipe, quiet, waittime)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:405
  * `Mads.runcmd(cmd::Cmd; pipe, quiet, waittime)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:350

Arguments

  * `cmd::Cmd`
  * `cmdstring::String`

Keywords

  * `pipe`
  * `quiet`
  * `waittime`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L415-L419' class='documenter-source'>source</a><br>

<a id='Mads.runremote' href='#Mads.runremote'>#</a>
**`Mads.runremote`** &mdash; *Function*.



Run remote command on a series of servers

Methods

  * `Mads.runremote(cmd::String, nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:277
  * `Mads.runremote(cmd::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:277

Arguments

  * `cmd::String`
  * `nodenames::Array{String,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L271-L275' class='documenter-source'>source</a><br>

<a id='Mads.saltelli-Tuple{Associative}' href='#Mads.saltelli-Tuple{Associative}'>#</a>
**`Mads.saltelli`** &mdash; *Method*.



Saltelli sensitivity analysis

Methods

  * `Mads.saltelli(madsdata::Associative; N, seed, parallel, restartdir, checkpointfrequency)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:608

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples, [default=`100`]
  * `checkpointfrequency` : [default=`N`]
  * `parallel` : set to true if the model runs should be performed in parallel, [default=`false`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `seed` : initial random seed, [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L596-L600' class='documenter-source'>source</a><br>

<a id='Mads.saltellibrute-Tuple{Associative}' href='#Mads.saltellibrute-Tuple{Associative}'>#</a>
**`Mads.saltellibrute`** &mdash; *Method*.



Saltelli sensitivity analysis (brute force)

Methods

  * `Mads.saltellibrute(madsdata::Associative; N, seed, restartdir)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:420

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `N` : number of samples, [default=`1000`]
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `seed` : initial random seed, [default=`0`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L410-L414' class='documenter-source'>source</a><br>

<a id='Mads.saltellibruteparallel-Tuple{Associative,Integer}' href='#Mads.saltellibruteparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltellibruteparallel`** &mdash; *Method*.



Parallel version of saltellibrute


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L840' class='documenter-source'>source</a><br>

<a id='Mads.saltelliparallel-Tuple{Associative,Integer}' href='#Mads.saltelliparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltelliparallel`** &mdash; *Method*.



Parallel version of saltelli


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L840' class='documenter-source'>source</a><br>

<a id='Mads.sampling-Tuple{Array{T,1},Array,Number}' href='#Mads.sampling-Tuple{Array{T,1},Array,Number}'>#</a>
**`Mads.sampling`** &mdash; *Method*.



Methods

  * `Mads.sampling(param::Array{T<:Any,1}, J::Array, numsamples::Number; seed, scale)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:244

Arguments

  * `J::Array` : Jacobian matrix
  * `numsamples::Number` : Number of samples
  * `param::Array{T<:Any,1}` : Parameter vector

Keywords

  * `scale` : [default=`1`]
  * `seed` : [default=`0`]

Returns:

  * generated samples (vector or array)
  * vector of log-likelihoods


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L230-L240' class='documenter-source'>source</a><br>

<a id='Mads.savecalibrationresults-Tuple{Associative,Any}' href='#Mads.savecalibrationresults-Tuple{Associative,Any}'>#</a>
**`Mads.savecalibrationresults`** &mdash; *Method*.



Save calibration results

Methods

  * `Mads.savecalibrationresults(madsdata::Associative, results)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:214

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `results` : the calibration results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L203-L207' class='documenter-source'>source</a><br>

<a id='Mads.savemadsfile' href='#Mads.savemadsfile'>#</a>
**`Mads.savemadsfile`** &mdash; *Function*.



Save MADS problem dictionary `madsdata` in MADS input file `filename`

Methods

  * `Mads.savemadsfile(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:154
  * `Mads.savemadsfile(madsdata::Associative, filename::String; julia, explicit)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:154
  * `Mads.savemadsfile(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:160
  * `Mads.savemadsfile(madsdata::Associative, parameters::Associative, filename::String; julia, explicit)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:160

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)
  * `madsdata::Associative` : Mads problem dictionary
  * `parameters::Associative` : Dictionary with parameters (optional)

Keywords

  * `explicit` : if `true` ignores MADS YAML file modifications and rereads the original input file, [default=`false`]
  * `julia` : if `true` use Julia JSON module to save, [default=`false`]

Usage:

```julia
Mads.savemadsfile(madsdata)
Mads.savemadsfile(madsdata, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads")
Mads.savemadsfile(madsdata, parameters, "test.mads", explicit=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L183-L196' class='documenter-source'>source</a><br>

<a id='Mads.savemcmcresults-Tuple{Array,String}' href='#Mads.savemcmcresults-Tuple{Array,String}'>#</a>
**`Mads.savemcmcresults`** &mdash; *Method*.



Save MCMC chain in a file

Methods

  * `Mads.savemcmcresults(chain::Array, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:137

Arguments

  * `chain::Array` : MCMC chain
  * `filename::String` : file name

Dumps:

  * the file containing MCMC chain


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMonteCarlo.jl#L125-L133' class='documenter-source'>source</a><br>

<a id='Mads.savesaltellirestart-Tuple{Array,String,String}' href='#Mads.savesaltellirestart-Tuple{Array,String,String}'>#</a>
**`Mads.savesaltellirestart`** &mdash; *Method*.



Save Saltelli sensitivity analysis results for fast simulation restarts

Methods

  * `Mads.savesaltellirestart(evalmat::Array, matname::String, restartdir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:589

Arguments

  * `evalmat::Array` : Saved array
  * `matname::String` : Matrix (array) name (defines the name of the loaded file)
  * `restartdir::String` : directory where files will be stored containing model results for fast simulation restarts


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L580-L584' class='documenter-source'>source</a><br>

<a id='Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}' href='#Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}'>#</a>
**`Mads.scatterplotsamples`** &mdash; *Method*.



Create histogram/scatter plots of model parameter samples

Methods

  * `Mads.scatterplotsamples(madsdata::Associative, samples::Array{T<:Any,2}, filename::String; format, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:379

Arguments

  * `filename::String` : output file name
  * `madsdata::Associative` : MADS problem dictionary
  * `samples::Array{T<:Any,2}` : matrix with model parameters

Keywords

  * `format` : output plot format (`png`, `pdf`, etc.)
  * `pointsize` : [default=`0.9Gadfly.mm`]

Dumps:

  * histogram/scatter plots of model parameter samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L364-L372' class='documenter-source'>source</a><br>

<a id='Mads.searchdir' href='#Mads.searchdir'>#</a>
**`Mads.searchdir`** &mdash; *Function*.



Get files in the current directory or in a directory defined by `path` matching pattern `key` which can be a string or regular expression

Methods

  * `Mads.searchdir(key::String; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:633
  * `Mads.searchdir(key::Regex; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:632

Arguments

  * `key::Regex` : matching pattern for Mads input files (string or regular expression accepted)
  * `key::String` : matching pattern for Mads input files (string or regular expression accepted)

Keywords

  * `path` : search directory for the mads input files, [default=`.`]

Returns:

  * `filename` : an array with file names matching the pattern in the specified directory

Examples:

```julia
- `Mads.searchdir("a")`
- `Mads.searchdir(r"[A-B]"; path = ".")`
- `Mads.searchdir(r".*.cov"; path = ".")`
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L635-L651' class='documenter-source'>source</a><br>

<a id='Mads.set_nprocs_per_task' href='#Mads.set_nprocs_per_task'>#</a>
**`Mads.set_nprocs_per_task`** &mdash; *Function*.



Set number of processors needed for each parallel task at each node

Methods

  * `Mads.set_nprocs_per_task()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:25
  * `Mads.set_nprocs_per_task(local_nprocs_per_task::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:25

Arguments

  * `local_nprocs_per_task::Integer`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L19-L23' class='documenter-source'>source</a><br>

<a id='Mads.setallparamsoff!-Tuple{Associative}' href='#Mads.setallparamsoff!-Tuple{Associative}'>#</a>
**`Mads.setallparamsoff!`** &mdash; *Method*.



Set all parameters OFF

Methods

  * `Mads.setallparamsoff!(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:430

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filter` :


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L422-L426' class='documenter-source'>source</a><br>

<a id='Mads.setallparamson!-Tuple{Associative}' href='#Mads.setallparamson!-Tuple{Associative}'>#</a>
**`Mads.setallparamson!`** &mdash; *Method*.



Set all parameters ON

Methods

  * `Mads.setallparamson!(madsdata::Associative; filter)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:416

Arguments

  * `madsdata::Associative` : MADS problem dictionary

Keywords

  * `filter` :


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L408-L412' class='documenter-source'>source</a><br>

<a id='Mads.setdebuglevel-Tuple{Int64}' href='#Mads.setdebuglevel-Tuple{Int64}'>#</a>
**`Mads.setdebuglevel`** &mdash; *Method*.



Set MADS debug level

Methods

  * `Mads.setdebuglevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:112

Arguments

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L105-L109' class='documenter-source'>source</a><br>

<a id='Mads.setdefaultplotformat-Tuple{String}' href='#Mads.setdefaultplotformat-Tuple{String}'>#</a>
**`Mads.setdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)

Methods

  * `Mads.setdefaultplotformat(format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:16

Arguments

  * `format::String` : plot format


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L9-L13' class='documenter-source'>source</a><br>

<a id='Mads.setdir' href='#Mads.setdir'>#</a>
**`Mads.setdir`** &mdash; *Function*.



Set the working directory (for parallel environments)

Usage:

```julia
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```

Methods

  * `Mads.setdir()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:254
  * `Mads.setdir(dir)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:249

Arguments

  * `dir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L258-L269' class='documenter-source'>source</a><br>

<a id='Mads.setdynamicmodel-Tuple{Associative,Function}' href='#Mads.setdynamicmodel-Tuple{Associative,Function}'>#</a>
**`Mads.setdynamicmodel`** &mdash; *Method*.



Set Dynamic Model for MADS model calls using internal Julia functions

Methods

  * `Mads.setdynamicmodel(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:109

Arguments

  * `f::Function`
  * `madsdata::Associative`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L103-L107' class='documenter-source'>source</a><br>

<a id='Mads.setexecutionwaittime-Tuple{Float64}' href='#Mads.setexecutionwaittime-Tuple{Float64}'>#</a>
**`Mads.setexecutionwaittime`** &mdash; *Method*.



Set maximum execution wait time for forward model runs in seconds

Methods

  * `Mads.setexecutionwaittime(waitime::Float64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:132

Arguments

  * `waitime::Float64` : maximum execution wait time for forward model runs in seconds


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L125-L129' class='documenter-source'>source</a><br>

<a id='Mads.setmadsinputfile-Tuple{String}' href='#Mads.setmadsinputfile-Tuple{String}'>#</a>
**`Mads.setmadsinputfile`** &mdash; *Method*.



Set a default MADS input file

Methods

  * `Mads.setmadsinputfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:229

Arguments

  * `filename::String` : input file name (e.g. `input_file_name.mads`)

Usage:

```
Mads.setmadsinputfile(filename)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L216-L226' class='documenter-source'>source</a><br>

<a id='Mads.setmodelinputs-Tuple{Associative,Associative}' href='#Mads.setmodelinputs-Tuple{Associative,Associative}'>#</a>
**`Mads.setmodelinputs`** &mdash; *Method*.



Set model input files; delete files where model output should be saved for MADS

Methods

  * `Mads.setmodelinputs(madsdata::Associative, parameters::Associative; path)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:536

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `parameters::Associative` :

Keywords

  * `path` : path for the files, [default=`.`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L527-L531' class='documenter-source'>source</a><br>

<a id='Mads.setnewmadsfilename' href='#Mads.setnewmadsfilename'>#</a>
**`Mads.setnewmadsfilename`** &mdash; *Function*.



Set new mads file name

Methods

  * `Mads.setnewmadsfilename(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:393
  * `Mads.setnewmadsfilename(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:390

Arguments

  * `filename::String` : file name
  * `madsdata::Associative` : Mads problem dictionary

Returns:

  * new file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L409-L417' class='documenter-source'>source</a><br>

<a id='Mads.setobservationtargets!-Tuple{Associative,Associative}' href='#Mads.setobservationtargets!-Tuple{Associative,Associative}'>#</a>
**`Mads.setobservationtargets!`** &mdash; *Method*.



Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary

Methods

  * `Mads.setobservationtargets!(madsdata::Associative, predictions::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:495

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `predictions::Associative` :


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L487-L491' class='documenter-source'>source</a><br>

<a id='Mads.setobstime!' href='#Mads.setobstime!'>#</a>
**`Mads.setobstime!`** &mdash; *Function*.



Set observation time based on the observation name in the MADS problem dictionary

Methods

  * `Mads.setobstime!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:247
  * `Mads.setobstime!(madsdata::Associative, separator::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:247
  * `Mads.setobstime!(madsdata::Associative, rx::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:258

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `rx::Regex` : regular expression to match
  * `separator::String` : separator [default=`_`]

Examples:

```julia
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L269-L280' class='documenter-source'>source</a><br>

<a id='Mads.setobsweights!-Tuple{Associative,Number}' href='#Mads.setobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setobsweights!`** &mdash; *Method*.



Set observation weights in the MADS problem dictionary

Methods

  * `Mads.setobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:293

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `value::Number` : value for observation weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L285-L289' class='documenter-source'>source</a><br>

<a id='Mads.setparamoff!-Tuple{Associative,String}' href='#Mads.setparamoff!-Tuple{Associative,String}'>#</a>
**`Mads.setparamoff!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` OFF

Methods

  * `Mads.setparamoff!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:455

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L447-L451' class='documenter-source'>source</a><br>

<a id='Mads.setparamon!-Tuple{Associative,String}' href='#Mads.setparamon!-Tuple{Associative,String}'>#</a>
**`Mads.setparamon!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` ON

Methods

  * `Mads.setparamon!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:444

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `parameterkey::String` : parameter key


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L436-L440' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistnormal!`** &mdash; *Method*.



Set normal parameter distributions for all the model parameters in the MADS problem dictionary

Methods

  * `Mads.setparamsdistnormal!(madsdata::Associative, mean::Array{T<:Any,1}, stddev::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:467

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `mean::Array{T<:Any,1}` : array with the mean values
  * `stddev::Array{T<:Any,1}` : array with the standard deviation values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L458-L462' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistuniform!`** &mdash; *Method*.



Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

Methods

  * `Mads.setparamsdistuniform!(madsdata::Associative, min::Array{T<:Any,1}, max::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:482

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `max::Array{T<:Any,1}` : array with the maximum values
  * `min::Array{T<:Any,1}` : array with the minimum values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L473-L477' class='documenter-source'>source</a><br>

<a id='Mads.setparamsinit!-Tuple{Associative,Associative}' href='#Mads.setparamsinit!-Tuple{Associative,Associative}'>#</a>
**`Mads.setparamsinit!`** &mdash; *Method*.



Set initial parameter guesses in the MADS dictionary

Methods

  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:318

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `paramdict::Associative` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L310-L314' class='documenter-source'>source</a><br>

<a id='Mads.setplotfileformat-Tuple{String,String}' href='#Mads.setplotfileformat-Tuple{String,String}'>#</a>
**`Mads.setplotfileformat`** &mdash; *Method*.



Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

Methods

  * `Mads.setplotfileformat(filename::String, format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:36

Arguments

  * `filename::String` : output file name
  * `format::String` : output plot format (`png`, `pdf`, etc.)

Returns:

  * output file name
  * output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L23-L32' class='documenter-source'>source</a><br>

<a id='Mads.setprocs' href='#Mads.setprocs'>#</a>
**`Mads.setprocs`** &mdash; *Function*.



Set the available processors based on environmental variables. Supports SLURM only at the moment.

Usage:

```julia
Mads.setprocs()
Mads.setprocs(4)
Mads.setprocs(4, 8)
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```

Arguments:

  * `np` : number of processors
  * `nt` : number of threads

Optional arguments:

  * `ntasks_per_node` : number of parallel tasks per
  * `nprocs_per_task` : number of processors needed for each parallel task at each node
  * `nodenames` : array with names of machines/nodes to be invoked
  * `dir` : common directory shared by all the jobs
  * `exename` : location of the julia executable (the same version of julia is needed on all the workers)
  * `mads_servers` : if `true` use MADS servers (LANL only)
  * `quiet` : suppress output [default `true`]
  * `test` : test the servers and connect to each one ones at a time [default `false`]

Methods

  * `Mads.setprocs(; ntasks_per_node, nprocs_per_task, mads_servers, test, dir, exename, nodenames, quiet)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:56
  * `Mads.setprocs(np::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:52
  * `Mads.setprocs(np::Integer, nt::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:38

Arguments

  * `np::Integer`
  * `nt::Integer`

Keywords

  * `dir`
  * `exename`
  * `mads_servers`
  * `nodenames`
  * `nprocs_per_task`
  * `ntasks_per_node`
  * `quiet`
  * `test`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsParallel.jl#L166-L200' class='documenter-source'>source</a><br>

<a id='Mads.setseed' href='#Mads.setseed'>#</a>
**`Mads.setseed`** &mdash; *Function*.



Set / get current random seed

Methods

  * `Mads.setseed()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:319
  * `Mads.setseed(seed::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:319
  * `Mads.setseed(seed::Integer, quiet::Bool)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:319

Arguments

  * `quiet::Bool` : [default=`true`]
  * `seed::Integer` : random seed


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L311-L315' class='documenter-source'>source</a><br>

<a id='Mads.settarget!-Tuple{Associative,Number}' href='#Mads.settarget!-Tuple{Associative,Number}'>#</a>
**`Mads.settarget!`** &mdash; *Method*.



Set observation target

Methods

  * `Mads.settarget!(o::Associative, target::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:237

Arguments

  * `o::Associative` : observation data
  * `target::Number` : observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L229-L233' class='documenter-source'>source</a><br>

<a id='Mads.settime!-Tuple{Associative,Number}' href='#Mads.settime!-Tuple{Associative,Number}'>#</a>
**`Mads.settime!`** &mdash; *Method*.



Set observation time

Methods

  * `Mads.settime!(o::Associative, time::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:159

Arguments

  * `o::Associative` : observation data
  * `time::Number` : observation time


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L151-L155' class='documenter-source'>source</a><br>

<a id='Mads.setverbositylevel-Tuple{Int64}' href='#Mads.setverbositylevel-Tuple{Int64}'>#</a>
**`Mads.setverbositylevel`** &mdash; *Method*.



Set MADS verbosity level

Methods

  * `Mads.setverbositylevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:122

Arguments

  * `level::Int64` : debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L115-L119' class='documenter-source'>source</a><br>

<a id='Mads.setweight!-Tuple{Associative,Number}' href='#Mads.setweight!-Tuple{Associative,Number}'>#</a>
**`Mads.setweight!`** &mdash; *Method*.



Set observation weight

Methods

  * `Mads.setweight!(o::Associative, weight::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:198

Arguments

  * `o::Associative` : observation data
  * `weight::Number` : observation weight


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L190-L194' class='documenter-source'>source</a><br>

<a id='Mads.setwellweights!-Tuple{Associative,Number}' href='#Mads.setwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setwellweights!`** &mdash; *Method*.



Set well weights in the MADS problem dictionary

Methods

  * `Mads.setwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:338

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `value::Number` : value for well weights


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L330-L334' class='documenter-source'>source</a><br>

<a id='Mads.showallparameters-Tuple{Associative}' href='#Mads.showallparameters-Tuple{Associative}'>#</a>
**`Mads.showallparameters`** &mdash; *Method*.



Show all parameters in the MADS problem dictionary

Methods

  * `Mads.showallparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:562

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L555-L559' class='documenter-source'>source</a><br>

<a id='Mads.showobservations-Tuple{Associative}' href='#Mads.showobservations-Tuple{Associative}'>#</a>
**`Mads.showobservations`** &mdash; *Method*.



Show observations in the MADS problem dictionary

Methods

  * `Mads.showobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:391

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L384-L388' class='documenter-source'>source</a><br>

<a id='Mads.showparameters-Tuple{Associative}' href='#Mads.showparameters-Tuple{Associative}'>#</a>
**`Mads.showparameters`** &mdash; *Method*.



Show parameters in the MADS problem dictionary

Methods

  * `Mads.showparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:526

Arguments

  * `madsdata::Associative` : MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsParameters.jl#L519-L523' class='documenter-source'>source</a><br>

<a id='Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransform`** &mdash; *Method*.



Sine transformation of model parameters

Methods

  * `Mads.sinetransform(sineparams::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:19

Arguments

  * `indexlogtransformed::Array{T<:Any,1}`
  * `lowerbounds::Array{T<:Any,1}`
  * `sineparams::Array{T<:Any,1}`
  * `upperbounds::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSineTransformations.jl#L13-L17' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformfunction`** &mdash; *Method*.



Sine transformation of a function

Methods

  * `Mads.sinetransformfunction(f::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:30

Arguments

  * `f::Function`
  * `indexlogtransformed::Array{T<:Any,1}`
  * `lowerbounds::Array{T<:Any,1}`
  * `upperbounds::Array{T<:Any,1}`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSineTransformations.jl#L24-L28' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformgradient`** &mdash; *Method*.



Sine transformation of a gradient function

Methods

  * `Mads.sinetransformgradient(g::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1}; sindx)` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:42

Arguments

  * `g::Function`
  * `indexlogtransformed::Array{T<:Any,1}`
  * `lowerbounds::Array{T<:Any,1}`
  * `upperbounds::Array{T<:Any,1}`

Keywords

  * `sindx`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSineTransformations.jl#L36-L40' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplot' href='#Mads.spaghettiplot'>#</a>
**`Mads.spaghettiplot`** &mdash; *Function*.



Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

Methods

  * `Mads.spaghettiplot(madsdata::Associative, number_of_samples::Integer; plotdata, filename, keyword, format, xtitle, ytitle, yfit, obs_plot_dots, seed, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:849
  * `Mads.spaghettiplot(madsdata::Associative, dictarray::Associative; plotdata, filename, keyword, format, xtitle, ytitle, yfit, obs_plot_dots, seed, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:853
  * `Mads.spaghettiplot(madsdata::Associative, array::Array; plotdata, filename, keyword, format, xtitle, ytitle, yfit, obs_plot_dots, seed, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:890

Arguments

  * `array::Array` :
  * `dictarray::Associative` : dictionary array containing the data arrays to be plotted
  * `madsdata::Associative` : MADS problem dictionary
  * `number_of_samples::Integer` : number of samples

Keywords

  * `filename` : output file name used to output the produced plots
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)
  * `linewidth` : [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)
  * `plotdata` : [default=`true`]
  * `pointsize` : [default=`4Gadfly.pt`]
  * `seed` : initial random seed, [default=`0`]
  * `xtitle` : `x` axis title, [default=`X`]
  * `yfit` : [default=`false`]
  * `ytitle` : `y` axis title, [default=`Y`]

Dumps:

  * Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplot(madsdata, dictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, array; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L1005-L1021' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplots' href='#Mads.spaghettiplots'>#</a>
**`Mads.spaghettiplots`** &mdash; *Function*.



Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

Methods

  * `Mads.spaghettiplots(madsdata::Associative, number_of_samples::Integer; format, keyword, xtitle, ytitle, obs_plot_dots, seed, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:708
  * `Mads.spaghettiplots(madsdata::Associative, paramdictarray::DataStructures.OrderedDict; format, keyword, xtitle, ytitle, obs_plot_dots, seed, linewidth, pointsize)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:712

Arguments

  * `madsdata::Associative` : MADS problem dictionary
  * `number_of_samples::Integer` : number of samples
  * `paramdictarray::DataStructures.OrderedDict` : parameter dictionary containing the data arrays to be plotted

Keywords

  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : keyword to be added in the file name used to output the produced plots
  * `linewidth` : [default=`2Gadfly.pt`]
  * `obs_plot_dots` : plot observation as dots (`true` (default) or `false`)
  * `pointsize` : [default=`4Gadfly.pt`]
  * `seed` : initial random seed, [default=`0`]
  * `xtitle` : `x` axis title, [default=`X`]
  * `ytitle` : `y` axis title, [default=`Y`]

Dumps:

  * A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsPlot.jl#L820-L835' class='documenter-source'>source</a><br>

<a id='Mads.sphericalcov-Tuple{Number,Number,Number}' href='#Mads.sphericalcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.sphericalcov`** &mdash; *Method*.



Spherical spatial covariance function

Methods

  * `Mads.sphericalcov(h::Number, maxcov::Number, scale::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:20

Arguments

  * `h::Number`
  * `maxcov::Number`
  * `scale::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L15-L19' class='documenter-source'>source</a><br>

<a id='Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.sphericalvariogram`** &mdash; *Method*.



Spherical variogram

Methods

  * `Mads.sphericalvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:28

Arguments

  * `h::Number`
  * `nugget::Number`
  * `range::Number`
  * `sill::Number`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsKriging.jl#L22-L26' class='documenter-source'>source</a><br>

<a id='Mads.sprintf-Tuple' href='#Mads.sprintf-Tuple'>#</a>
**`Mads.sprintf`** &mdash; *Method*.



Convert `@sprintf` macro into `sprintf` function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsMisc.jl#L142' class='documenter-source'>source</a><br>

<a id='Mads.status-Tuple{}' href='#Mads.status-Tuple{}'>#</a>
**`Mads.status`** &mdash; *Method*.



Status of the Mads modules

Methods

  * `Mads.status(; git, gitmore)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:181

Keywords

  * `git`
  * `gitmore`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L175-L179' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureoff-Tuple{}' href='#Mads.stdoutcaptureoff-Tuple{}'>#</a>
**`Mads.stdoutcaptureoff`** &mdash; *Method*.



Restore STDOUT


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSTDOUT.jl#L12-L14' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureon-Tuple{}' href='#Mads.stdoutcaptureon-Tuple{}'>#</a>
**`Mads.stdoutcaptureon`** &mdash; *Method*.



Redirect STDOUT to a reader


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSTDOUT.jl#L1-L3' class='documenter-source'>source</a><br>

<a id='Mads.svrdump-Tuple{Array{SVR.svmmodel,1},String,Int64}' href='#Mads.svrdump-Tuple{Array{SVR.svmmodel,1},String,Int64}'>#</a>
**`Mads.svrdump`** &mdash; *Method*.



Dump SVR models in files

Methods

  * `Mads.svrdump(svrmodel::Array{SVR.svmmodel,1}, rootname::String, numberofsamples::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:135

Arguments

  * `numberofsamples::Int64` : number of samples
  * `rootname::String` : root name
  * `svrmodel::Array{SVR.svmmodel,1}` : SVR model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L126-L130' class='documenter-source'>source</a><br>

<a id='Mads.svrfree-Tuple{Array{SVR.svmmodel,1}}' href='#Mads.svrfree-Tuple{Array{SVR.svmmodel,1}}'>#</a>
**`Mads.svrfree`** &mdash; *Method*.



Free SVR 

Methods

  * `Mads.svrfree(svrmodel::Array{SVR.svmmodel,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:117

Arguments

  * `svrmodel::Array{SVR.svmmodel,1}` : SVR model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L110-L114' class='documenter-source'>source</a><br>

<a id='Mads.svrload-Tuple{Int64,String,Int64}' href='#Mads.svrload-Tuple{Int64,String,Int64}'>#</a>
**`Mads.svrload`** &mdash; *Method*.



Load SVR models from files

Methods

  * `Mads.svrload(npred::Int64, rootname::String, numberofsamples::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:158

Arguments

  * `npred::Int64` :
  * `numberofsamples::Int64` : number of samples
  * `rootname::String` : root name

Returns:

  * SVR model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L145-L153' class='documenter-source'>source</a><br>

<a id='Mads.svrpredict' href='#Mads.svrpredict'>#</a>
**`Mads.svrpredict`** &mdash; *Function*.



Predict SVR

Methods

  * `Mads.svrpredict(svrmodel::Array{SVR.svmmodel,1}, paramarray::Array{Float64,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:90
  * `Mads.svrpredict(svrmodel::Array{SVR.svmmodel,1}, paramarray::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:82

Arguments

  * `paramarray::Array{Float64,1}` : parameter array
  * `paramarray::Array{Float64,2}` : parameter array
  * `svrmodel::Array{SVR.svmmodel,1}` : SVR model

Returns:

  * 


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L98-L106' class='documenter-source'>source</a><br>

<a id='Mads.svrtrain' href='#Mads.svrtrain'>#</a>
**`Mads.svrtrain`** &mdash; *Function*.



Train SVR

Methods

  * `Mads.svrtrain(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:38
  * `Mads.svrtrain(madsdata::Associative, paramarray::Array{Float64,2}; check, savefile, addminmax, svm_type, kernel_type, degree, gamma, coef0, C, nu, p, cache_size, eps, shrinking, probability, verbose)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:6
  * `Mads.svrtrain(madsdata::Associative, numberofsamples::Integer; addminmax, kw...)` : /Users/monty/.julia/v0.5/Mads/src/MadsSVR.jl:38

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `numberofsamples::Integer` : number of random samples in the training set [default=`100`]
  * `paramarray::Array{Float64,2}`

Keywords

  * `C` : [default=`10000.0`]
  * `addminmax` : [default=`true`]
  * `cache_size` : [default=`100.0`]
  * `check` : [default=`false`]
  * `coef0` : [default=`0`]
  * `degree` : [default=`3`]
  * `eps` : [default=`0.001`]
  * `gamma` : [default=`1/numberofsamples`]
  * `kernel_type` : [default=`SVR.RBF`]
  * `nu` : [default=`0.5`]
  * `p` : [default=`0.1`]
  * `probability` : [default=`false`]
  * `savefile` : [default=`false`]
  * `shrinking` : [default=`true`]
  * `svm_type` : [default=`SVR.EPSILON_SVR`]
  * `verbose` : [default=`false`]

Returns:

  * SVR model


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSVR.jl#L53-L61' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdir-Tuple{String,String}' href='#Mads.symlinkdir-Tuple{String,String}'>#</a>
**`Mads.symlinkdir`** &mdash; *Method*.



Create a symbolic link of a file `filename` in a directory `dirtarget`

Methods

  * `Mads.symlinkdir(filename::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:985

Arguments

  * `dirtarget::String` : target directory
  * `filename::String` : file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L977-L981' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdirfiles-Tuple{String,String}' href='#Mads.symlinkdirfiles-Tuple{String,String}'>#</a>
**`Mads.symlinkdirfiles`** &mdash; *Method*.



Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`

Methods

  * `Mads.symlinkdirfiles(dirsource::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:967

Arguments

  * `dirsource::String` : source directory
  * `dirtarget::String` : target directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L959-L963' class='documenter-source'>source</a><br>

<a id='Mads.tag' href='#Mads.tag'>#</a>
**`Mads.tag`** &mdash; *Function*.



Tag the Mads modules with a default argument `:patch`

Methods

  * `Mads.tag(madsmodule::String, sym::Symbol)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:234
  * `Mads.tag(madsmodule::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:234
  * `Mads.tag(sym::Symbol)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:229
  * `Mads.tag()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:229

Arguments

  * `madsmodule::String`
  * `sym::Symbol`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsPublish.jl#L249-L253' class='documenter-source'>source</a><br>

<a id='Mads.test' href='#Mads.test'>#</a>
**`Mads.test`** &mdash; *Function*.



Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

Methods

  * `Mads.test(testname::String; madstest)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:49
  * `Mads.test()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:49

Arguments

  * `testname::String` : name of the test to execute (module or example)

Keywords

  * `madstest` : test Mads [default=`true`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsTest.jl#L40-L44' class='documenter-source'>source</a><br>

<a id='Mads.testj' href='#Mads.testj'>#</a>
**`Mads.testj`** &mdash; *Function*.



Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)

Methods

  * `Mads.testj(coverage::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:7
  * `Mads.testj()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:7

Arguments

  * `coverage::Bool`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/../src-interactive/MadsTest.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.transposematrix-Tuple{Array{T,2}}' href='#Mads.transposematrix-Tuple{Array{T,2}}'>#</a>
**`Mads.transposematrix`** &mdash; *Method*.



Transpose non-numeric matrix

Methods

  * `Mads.transposematrix(a::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:275

Arguments

  * `a::Array{T<:Any,2}` : matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L268-L272' class='documenter-source'>source</a><br>

<a id='Mads.transposevector-Tuple{Array{T,1}}' href='#Mads.transposevector-Tuple{Array{T,1}}'>#</a>
**`Mads.transposevector`** &mdash; *Method*.



Transpose non-numeric vector

Methods

  * `Mads.transposevector(a::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:265

Arguments

  * `a::Array{T<:Any,1}` : vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsHelpers.jl#L258-L262' class='documenter-source'>source</a><br>

<a id='Mads.void2nan!-Tuple{Associative}' href='#Mads.void2nan!-Tuple{Associative}'>#</a>
**`Mads.void2nan!`** &mdash; *Method*.



Convert Void's into NaN's in a dictionary

Methods

  * `Mads.void2nan!(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:1011

Arguments

  * `dict::Associative` : dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L1004-L1008' class='documenter-source'>source</a><br>

<a id='Mads.weightedstats-Tuple{Array,Array{T,1}}' href='#Mads.weightedstats-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.weightedstats`** &mdash; *Method*.



Get weighted mean and variance samples

Methods

  * `Mads.weightedstats(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:356

Arguments

  * `llhoods::Array{T<:Any,1}` : vector of log-likelihoods
  * `samples::Array` : array of samples

Returns:

  * vector of sample means
  * vector of sample variances


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsSenstivityAnalysis.jl#L343-L352' class='documenter-source'>source</a><br>

<a id='Mads.welloff!-Tuple{Associative,String}' href='#Mads.welloff!-Tuple{Associative,String}'>#</a>
**`Mads.welloff!`** &mdash; *Method*.



Turn off a specific well in the MADS problem dictionary

Methods

  * `Mads.welloff!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:565

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `wellname::String` : name of the well to be turned off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L557-L561' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{Associative,String}' href='#Mads.wellon!-Tuple{Associative,String}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

Methods

  * `Mads.wellon!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:530

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `wellname::String` : name of the well to be turned on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L522-L526' class='documenter-source'>source</a><br>

<a id='Mads.wells2observations!-Tuple{Associative}' href='#Mads.wells2observations!-Tuple{Associative}'>#</a>
**`Mads.wells2observations!`** &mdash; *Method*.



Convert `Wells` class to `Observations` class in the MADS problem dictionary

Methods

  * `Mads.wells2observations!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:586

Arguments

  * `madsdata::Associative` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsObservations.jl#L579-L583' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters' href='#Mads.writeparameters'>#</a>
**`Mads.writeparameters`** &mdash; *Function*.



Write `parameters`

Methods

  * `Mads.writeparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:733
  * `Mads.writeparameters(madsdata::Associative, parameters::Associative; respect_space)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:738

Arguments

  * `madsdata::Associative` : Mads problem dictionary
  * `parameters::Associative` : parameters

Keywords

  * `respect_space` : [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L746-L750' class='documenter-source'>source</a><br>

<a id='Mads.writeparametersviatemplate-Tuple{Any,Any,Any}' href='#Mads.writeparametersviatemplate-Tuple{Any,Any,Any}'>#</a>
**`Mads.writeparametersviatemplate`** &mdash; *Method*.



Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)

Methods

  * `Mads.writeparametersviatemplate(parameters, templatefilename, outputfilename; respect_space)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:698

Arguments

  * `outputfilename` : output file name
  * `parameters` : parameters
  * `templatefilename` : tmplate file name

Keywords

  * `respect_space` : [default=`false`]


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/d44e2f77618ad8c282b1c5d190779b1d7fd95e9e/src/MadsIO.jl#L688-L692' class='documenter-source'>source</a><br>

