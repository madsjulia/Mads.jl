
<a id='Mads.jl-1'></a>

# Mads.jl


Documentation for Mads.jl

<a id='Mads.MFlm-Tuple{Array{T,2},Integer}' href='#Mads.MFlm-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.MFlm`** &mdash; *Method*.



Matrix Factorization via Levenberg Marquardt

**Mads.MFlm**

Methods

  * `Mads.MFlm(X::Array{T<:Any,2}, nk::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:82

Arguments

  * `X`
  * `nk`

Keywords

  * `initH`
  * `initW`
  * `log_H`
  * `log_W`
  * `mads`
  * `maxiter`
  * `retries`
  * `tol`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-new/MadsBSS.jl#L76-L80' class='documenter-source'>source</a><br>

<a id='Mads.NMFipopt-Tuple{Array{T,2},Integer}' href='#Mads.NMFipopt-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.NMFipopt`** &mdash; *Method*.



Non-negative Matrix Factorization using JuMP/Ipopt

**Mads.NMFipopt**

Methods

  * `Mads.NMFipopt(X::Array{T<:Any,2}, nk::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:36

Arguments

  * `X`
  * `nk`

Keywords

  * `initH`
  * `initW`
  * `maxguess`
  * `maxiter`
  * `random`
  * `retries`
  * `tol`
  * `verbosity`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-new/MadsBSS.jl#L30-L34' class='documenter-source'>source</a><br>

<a id='Mads.NMFm-Tuple{Array,Integer}' href='#Mads.NMFm-Tuple{Array,Integer}'>#</a>
**`Mads.NMFm`** &mdash; *Method*.



Non-negative Matrix Factorization using NMF

**Mads.NMFm**

Methods

  * `Mads.NMFm(X::Array, nk::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-new/MadsBSS.jl:12

Arguments

  * `X`
  * `nk`

Keywords

  * `maxiter`
  * `retries`
  * `tol`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-new/MadsBSS.jl#L6-L10' class='documenter-source'>source</a><br>

<a id='Mads.addkeyword!-Tuple{Associative,String}' href='#Mads.addkeyword!-Tuple{Associative,String}'>#</a>
**`Mads.addkeyword!`** &mdash; *Method*.



Add a `keyword` in a `class` within the Mads dictionary `madsdata`

**Mads.addkeyword!**

Methods

  * `Mads.addkeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:176

Arguments

  * `keyword`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L170-L174' class='documenter-source'>source</a><br>

<a id='Mads.addsource!' href='#Mads.addsource!'>#</a>
**`Mads.addsource!`** &mdash; *Function*.



Add an additional contamination source

**Mads.addsource!**

Methods

  * `Mads.addsource!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:11
  * `Mads.addsource!(madsdata::Associative, sourceid::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:11

Arguments

  * `madsdata`
  * `ns`
  * `sourceid`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L5-L9' class='documenter-source'>source</a><br>

<a id='Mads.addsourceparameters!-Tuple{Associative}' href='#Mads.addsourceparameters!-Tuple{Associative}'>#</a>
**`Mads.addsourceparameters!`** &mdash; *Method*.



Add contaminant source parameters

**Mads.addsourceparameters!**

Methods

  * `Mads.addsourceparameters!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:34

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `sourceparam`
  * `sourceparams`
  * `sourcetype`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L28-L32' class='documenter-source'>source</a><br>

<a id='Mads.allwellsoff!-Tuple{Associative}' href='#Mads.allwellsoff!-Tuple{Associative}'>#</a>
**`Mads.allwellsoff!`** &mdash; *Method*.



Turn off all the wells in the MADS problem dictionary

**Mads.allwellsoff!**

Methods

  * `Mads.allwellsoff!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:468

Arguments

  * `#temp#`
  * `madsdata`
  * `wellkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L462-L466' class='documenter-source'>source</a><br>

<a id='Mads.allwellson!-Tuple{Associative}' href='#Mads.allwellson!-Tuple{Associative}'>#</a>
**`Mads.allwellson!`** &mdash; *Method*.



Turn on all the wells in the MADS problem dictionary

**Mads.allwellson!**

Methods

  * `Mads.allwellson!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:436

Arguments

  * `#temp#`
  * `madsdata`
  * `wellkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L430-L434' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-external/MadsSimulators.jl#L1-L13' class='documenter-source'>source</a><br>

<a id='Mads.amanzi_output_parser' href='#Mads.amanzi_output_parser'>#</a>
**`Mads.amanzi_output_parser`** &mdash; *Function*.



Parse Amanzi output provided in an external file (`filename`)

```
Mads.amanzi_output_parser()
Mads.amanzi_output_parser("observations.out")
```

Arguments:

  * `filename` : external file name (optional)

Returns:

  * `dict` : a dictionary with model observations following MADS requirements


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-external/MadsParsers.jl#L3-L18' class='documenter-source'>source</a><br>

<a id='Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.asinetransform`** &mdash; *Method*.



Arcsine transformation of model parameters

**Mads.asinetransform**

Methods

  * `Mads.asinetransform(params::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:7

Arguments

  * `indexlogtransformed`
  * `lowerbounds`
  * `params`
  * `sineparams`
  * `upperbounds`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSineTransformations.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.bayessampling-Tuple{Associative}' href='#Mads.bayessampling-Tuple{Associative}'>#</a>
**`Mads.bayessampling`** &mdash; *Method*.



Bayesian Sampling

```
Mads.bayessampling(madsdata; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.bayessampling(madsdata, numsequences; nsteps=1000, burnin=100, thinning=1, seed=2016)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `numsequences` : number of sequences executed in parallel
  * `nsteps` : number of final realizations in the chain
  * `burnin` :  number of initial realizations before the MCMC are recorded
  * `thinning` : removal of any `thinning` realization
  * `seed` : initial random number seed

Returns:

  * `mcmcchain` :

**Mads.bayessampling**

Methods

  * `Mads.bayessampling(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:91

Arguments

  * `madsdata`

Keywords

  * `burnin`
  * `nsteps`
  * `seed`
  * `thinning`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L67-L89' class='documenter-source'>source</a><br>

<a id='Mads.calibrate-Tuple{Associative}' href='#Mads.calibrate-Tuple{Associative}'>#</a>
**`Mads.calibrate`** &mdash; *Method*.



Calibrate

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `tolX` : parameter space tolerance
  * `tolG` : parameter space update tolerance
  * `maxEval` : maximum number of model evaluations
  * `maxIter` : maximum number of optimization iterations
  * `maxJacobians` : maximum number of Jacobian solves
  * `lambda` : initial Levenberg-Marquardt lambda
  * `lambda_mu` : lambda multiplication factor [10]
  * `np_lambda` : number of parallel lambda solves
  * `show_trace` : shows solution trace [default=false]
  * `save_results` : save intermediate results [default=true]
  * `usenaive` : use naive Levenberg-Marquardt solver

Returns:

  * `minimumdict` : model parameter dictionary with the optimal values at the minimum
  * `results` : optimization algorithm results (e.g. results.minimizer)

**Mads.calibrate**

Methods

  * `Mads.calibrate(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:142

Arguments

  * `madsdata`

Keywords

  * `lambda`
  * `lambda_mu`
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `np_lambda`
  * `save_results`
  * `show_trace`
  * `tolG`
  * `tolOF`
  * `tolX`
  * `usenaive`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsCalibrate.jl#L113-L140' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom' href='#Mads.calibraterandom'>#</a>
**`Mads.calibraterandom`** &mdash; *Function*.



Calibrate with random initial guesses

```
Mads.calibraterandom(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `numberofsamples` : number of random initial samples
  * `tolX` : parameter space tolerance
  * `tolG` : parameter space update tolerance
  * `maxEval` : maximum number of model evaluations
  * `maxIter` : maximum number of optimization iterations
  * `maxJacobians` : maximum number of Jacobian solves
  * `lambda` : initial Levenberg-Marquardt lambda
  * `lambda_mu` : lambda multiplication factor [10]
  * `np_lambda` : number of parallel lambda solves
  * `show_trace` : shows solution trace [default=false]
  * `save_results` : save intermediate results [default=true]
  * `usenaive` : use naive Levenberg-Marquardt solver
  * `seed` : initial random seed

Returns:

  * `bestresult` : optimal results tuple: [1] model parameter dictionary with the optimal values at the minimum; [2] optimization algorithm results (e.g. bestresult[2].minimizer)

**Mads.calibraterandom**

Methods

  * `Mads.calibraterandom(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:36
  * `Mads.calibraterandom(madsdata::Associative, numberofsamples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:36

Arguments

  * `madsdata`
  * `numberofsamples`

Keywords

  * `all`
  * `lambda`
  * `lambda_mu`
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `np_lambda`
  * `quiet`
  * `save_results`
  * `seed`
  * `show_trace`
  * `tolG`
  * `tolOF`
  * `tolX`
  * `usenaive`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsCalibrate.jl#L3-L34' class='documenter-source'>source</a><br>

<a id='Mads.calibraterandom_parallel' href='#Mads.calibraterandom_parallel'>#</a>
**`Mads.calibraterandom_parallel`** &mdash; *Function*.



Calibrate with random initial guesses in parallel

**Mads.calibraterandom_parallel**

Methods

  * `Mads.calibraterandom_parallel(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:83
  * `Mads.calibraterandom_parallel(madsdata::Associative, numberofsamples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsCalibrate.jl:83

Arguments

  * `madsdata`
  * `numberofsamples`

Keywords

  * `lambda`
  * `lambda_mu`
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `np_lambda`
  * `quiet`
  * `save_results`
  * `seed`
  * `show_trace`
  * `tolG`
  * `tolOF`
  * `tolX`
  * `usenaive`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsCalibrate.jl#L77-L81' class='documenter-source'>source</a><br>

<a id='Mads.checkmodeloutputdirs-Tuple{Associative}' href='#Mads.checkmodeloutputdirs-Tuple{Associative}'>#</a>
**`Mads.checkmodeloutputdirs`** &mdash; *Method*.



Check the directories where model outputs should be saved for MADS

**Mads.checkmodeloutputdirs**

Methods

  * `Mads.checkmodeloutputdirs(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:424

Arguments

  * `#temp#`
  * `d`
  * `directories`
  * `filename`
  * `instruction`
  * `madsdata`
  * `nd`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L418-L422' class='documenter-source'>source</a><br>

<a id='Mads.checkout' href='#Mads.checkout'>#</a>
**`Mads.checkout`** &mdash; *Function*.



Checkout the latest version of the Mads / Julia modules

**Mads.checkout**

Methods

  * `Mads.checkout(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63
  * `Mads.checkout()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:63

Arguments

  * `modulename`

Keywords

  * `all`
  * `force`
  * `git`
  * `master`
  * `pull`
  * `required`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L57-L61' class='documenter-source'>source</a><br>

<a id='Mads.checkparameterranges-Tuple{Associative}' href='#Mads.checkparameterranges-Tuple{Associative}'>#</a>
**`Mads.checkparameterranges`** &mdash; *Method*.



Check parameter ranges for model parameters

**Mads.checkparameterranges**

Methods

  * `Mads.checkparameterranges(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:641

Arguments

  * `#temp#`
  * `d`
  * `flag_error`
  * `i`
  * `init`
  * `init_max`
  * `init_min`
  * `madsdata`
  * `max`
  * `min`
  * `optparamkeys`
  * `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L635-L639' class='documenter-source'>source</a><br>

<a id='Mads.cleancoverage-Tuple{}' href='#Mads.cleancoverage-Tuple{}'>#</a>
**`Mads.cleancoverage`** &mdash; *Method*.



Remove Mads coverage files

**Mads.cleancoverage**

Methods

  * `Mads.cleancoverage()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:20

Arguments

  * `#temp#`
  * `i`
  * `orig_dir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsTest.jl#L14-L18' class='documenter-source'>source</a><br>

<a id='Mads.cmadsins_obs-Tuple{Array{T,1},String,String}' href='#Mads.cmadsins_obs-Tuple{Array{T,1},String,String}'>#</a>
**`Mads.cmadsins_obs`** &mdash; *Method*.



Call C MADS ins_obs() function from the MADS dynamic library

**Mads.cmadsins_obs**

Methods

  * `Mads.cmadsins_obs(obsid::Array{T<:Any,1}, instructionfilename::String, inputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:27

Arguments

  * `debug`
  * `inputfilename`
  * `instructionfilename`
  * `n`
  * `obscheck`
  * `observations`
  * `obsid`
  * `obsval`
  * `result`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-old/MadsCMads.jl#L21-L25' class='documenter-source'>source</a><br>

<a id='Mads.commit' href='#Mads.commit'>#</a>
**`Mads.commit`** &mdash; *Function*.



Commit the latest version of the Mads / Julia modules in the repo

**Mads.commit**

Methods

  * `Mads.commit(commitmsg::String, modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:154
  * `Mads.commit(commitmsg::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:154

Arguments

  * `#temp#`
  * `commitmsg`
  * `cwd`
  * `i`
  * `modulename`
  * `modulenames`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L148-L152' class='documenter-source'>source</a><br>

<a id='Mads.computemass-Tuple{Associative}' href='#Mads.computemass-Tuple{Associative}'>#</a>
**`Mads.computemass`** &mdash; *Method*.



Compute injected/reduced contaminant mass

**Mads.computemass**

Methods

  * `Mads.computemass(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:246

Arguments

  * `madsdata`

Keywords

  * `time`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `time` : computational time

Returns:

  * `mass_injected` : total injected mass
  * `mass_reduced` : total reduced mass


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L230-L244' class='documenter-source'>source</a><br>

<a id='Mads.computemass-Tuple{Union{Regex,String}}' href='#Mads.computemass-Tuple{Union{Regex,String}}'>#</a>
**`Mads.computemass`** &mdash; *Method*.



Compute injected/reduced contaminant mass for a given set of mads input files

**Mads.computemass**

Methods

  * `Mads.computemass(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:246
  * `Mads.computemass(madsfiles::Union{Regex,String})` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:311

Arguments

  * `madsdata`
  * `madsfiles`

Keywords

  * `path`
  * `time`

Example

```
Mads.computemass(madsfiles; time=0, path=".")
```

Arguments:

  * `madsfiles` : matching pattern for Mads input files (string or regular expression accepted)
  * `time` : computational time
  * `path` : search directory for the mads input files

Returns:

  * `lambda` : array with all the lambda values
  * `mass_injected` : array with associated total injected mass
  * `mass_reduced` : array with associated total reduced mass


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L287-L309' class='documenter-source'>source</a><br>

<a id='Mads.computeparametersensitities-Tuple{Associative,Associative}' href='#Mads.computeparametersensitities-Tuple{Associative,Associative}'>#</a>
**`Mads.computeparametersensitities`** &mdash; *Method*.



Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

Arguments:

  * `madsdata` : MADS problem dictionary
  * `saresults` : sensitivity analysis results

**Mads.computeparametersensitities**

Methods

  * `Mads.computeparametersensitities(madsdata::Associative, saresults::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:701

Arguments

  * `#temp#`
  * `i`
  * `j`
  * `m`
  * `madsdata`
  * `mes`
  * `obskeys`
  * `paramkeys`
  * `pm`
  * `pmes`
  * `pt`
  * `ptes`
  * `pv`
  * `pvar`
  * `saresults`
  * `t`
  * `tes`
  * `v`
  * `var`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L690-L699' class='documenter-source'>source</a><br>

<a id='Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}' href='#Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}'>#</a>
**`Mads.contamination`** &mdash; *Method*.



Compute concentration for a point in space and time (x,y,z,t)

**Mads.contamination**

Methods

  * `Mads.contamination(wellx::Number, welly::Number, wellz::Number, n::Number, lambda::Number, theta::Number, vx::Number, vy::Number, vz::Number, ax::Number, ay::Number, az::Number, H::Number, x::Number, y::Number, z::Number, dx::Number, dy::Number, dz::Number, f::Number, t0::Number, t1::Number, t::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:205

Arguments

  * `H`
  * `ax`
  * `ay`
  * `az`
  * `dx`
  * `dy`
  * `dz`
  * `f`
  * `lambda`
  * `n`
  * `t`
  * `t0`
  * `t1`
  * `theta`
  * `vx`
  * `vy`
  * `vz`
  * `wellx`
  * `welly`
  * `wellz`
  * `x`
  * `y`
  * `z`

Keywords

  * `anasolfunction`

Arguments:

  * `wellx` - observation point (well) X coordinate
  * `welly` - observation point (well) Y coordinate
  * `wellz` - observation point (well) Z coordinate
  * `n` - porosity
  * `lambda` - first-order reaction rate
  * `theta` - groundwater flow direction
  * `vx` - advective transport velocity in X direction
  * `vy` - advective transport velocity in Y direction
  * `vz` - advective transport velocity in Z direction
  * `ax` - dispersivity in X direction (longitudinal)
  * `ay` - dispersivity in Y direction (transverse horizontal)
  * `az` - dispersivity in Y direction (transverse vertical)
  * `H` - Hurst coefficient for Fractional Brownian dispersion
  * `x` - X coordinate of contaminant source location
  * `y` - Y coordinate of contaminant source location
  * `z` - Z coordinate of contaminant source location
  * `dx` - source size (extent) in X direction
  * `dy` - source size (extent) in Y direction
  * `dz` - source size (extent) in Z direction
  * `f` - source mass flux
  * `t0` - source starting time
  * `t1` - source termination time
  * `t` - time to compute concentration at the observation point
  * `anasolfunction` : Anasol function to call (check out the Anasol module) [long_bbb_ddd_iir_c]

Returns:

  * predicted concentration at (wellx, welly, wellz, t)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L168-L203' class='documenter-source'>source</a><br>

<a id='Mads.copyright-Tuple{}' href='#Mads.copyright-Tuple{}'>#</a>
**`Mads.copyright`** &mdash; *Method*.



Produce MADS copyright information

**Mads.copyright**

Methods

  * `Mads.copyright()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:18


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelp.jl#L12-L16' class='documenter-source'>source</a><br>

<a id='Mads.create_documentation-Tuple{}' href='#Mads.create_documentation-Tuple{}'>#</a>
**`Mads.create_documentation`** &mdash; *Method*.



Create web documentation files for Mads functions

**Mads.create_documentation**

Methods

  * `Mads.create_documentation()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:257

Arguments

  * `d`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L251-L255' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_off-Tuple{}' href='#Mads.create_tests_off-Tuple{}'>#</a>
**`Mads.create_tests_off`** &mdash; *Method*.



Turn off the generation of MADS tests (default)

**Mads.create_tests_off**

Methods

  * `Mads.create_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:81


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L75-L79' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_on-Tuple{}' href='#Mads.create_tests_on-Tuple{}'>#</a>
**`Mads.create_tests_on`** &mdash; *Method*.



Turn on the generation of MADS tests (dangerous)

**Mads.create_tests_on**

Methods

  * `Mads.create_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:72


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.createmadsproblem-Tuple{String,String}' href='#Mads.createmadsproblem-Tuple{String,String}'>#</a>
**`Mads.createmadsproblem`** &mdash; *Method*.



Create a new Mads problem where the observation targets are computed based on the model predictions

  * `Mads.createmadsproblem(infilename::String, outfilename::String)`
  * `Mads.createmadsproblem(madsdata::Associative, outfilename::String)`
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative)`
  * `Mads.createmadsproblem(madsdata::Associative, predictions::Associative, outfilename::String)`

Arguments:

  * `infilename` : input Mads file
  * `outfilename` : output Mads file
  * `madsdata` : MADS problem dictionary
  * `predictions` : dictionary of model predictions

**Mads.createmadsproblem**

Methods

  * `Mads.createmadsproblem(infilename::String, outfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsCreate.jl:22

Arguments

  * `#temp#`
  * `f`
  * `fullobs`
  * `fullwell`
  * `infilename`
  * `madsdata`
  * `obs`
  * `obskey`
  * `outfilename`
  * `outyaml`
  * `result`
  * `wellname`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsCreate.jl#L4-L20' class='documenter-source'>source</a><br>

<a id='Mads.createobservations!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.createobservations!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.createobservations!`** &mdash; *Method*.



Create observations in the MADS problem dictionary based on `time` and `observation` vectors

**Mads.createobservations!**

Methods

  * `Mads.createobservations!(madsdata::Associative, time::Array{T<:Any,1}, observation::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:368

Arguments

  * `madsdata`
  * `observation`
  * `time`

Keywords

  * `logtransform`
  * `weight`
  * `weight_type`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L362-L366' class='documenter-source'>source</a><br>

<a id='Mads.createtempdir-Tuple{String}' href='#Mads.createtempdir-Tuple{String}'>#</a>
**`Mads.createtempdir`** &mdash; *Method*.



Create temporary directory

**Mads.createtempdir**

Methods

  * `Mads.createtempdir(tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:906

Arguments

  * `attempt`
  * `errmsg`
  * `tempdirname`
  * `trying`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L900-L904' class='documenter-source'>source</a><br>

<a id='Mads.deleteNaN!-Tuple{DataFrames.DataFrame}' href='#Mads.deleteNaN!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.deleteNaN!`** &mdash; *Method*.



Delete rows with NaN in a Dataframe `df`

**Mads.deleteNaN!**

Methods

  * `Mads.deleteNaN!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:919

Arguments

  * `#temp#`
  * `df`
  * `i`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L913-L917' class='documenter-source'>source</a><br>

<a id='Mads.deletekeyword!-Tuple{Associative,String}' href='#Mads.deletekeyword!-Tuple{Associative,String}'>#</a>
**`Mads.deletekeyword!`** &mdash; *Method*.



Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

**Mads.deletekeyword!**

Methods

  * `Mads.deletekeyword!(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:199

Arguments

  * `keyword`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L193-L197' class='documenter-source'>source</a><br>

<a id='Mads.dependents' href='#Mads.dependents'>#</a>
**`Mads.dependents`** &mdash; *Function*.



Lists modules dependents on a module (Mads by default)

**Mads.dependents**

Methods

  * `Mads.dependents(modulename::String, filter::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45
  * `Mads.dependents(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45
  * `Mads.dependents()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:45

Arguments

  * `#temp#`
  * `depmodules`
  * `filter`
  * `i`
  * `modulename`
  * `modules`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L39-L43' class='documenter-source'>source</a><br>

<a id='Mads.display-Tuple{String}' href='#Mads.display-Tuple{String}'>#</a>
**`Mads.display`** &mdash; *Method*.



Display image file

**Mads.display**

Methods

  * `Mads.display(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsDisplay.jl:9

Arguments

  * `ext`
  * `filename`
  * `filename2`
  * `img`
  * `root`
  * `trytoopen`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsDisplay.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.dobigdt-Tuple{Associative,Int64}' href='#Mads.dobigdt-Tuple{Associative,Int64}'>#</a>
**`Mads.dobigdt`** &mdash; *Method*.



Perform Bayesian Information Gap Decision Theory (BIG-DT) analysis

Arguments:

  * `madsdata` : MADS problem dictionary
  * `nummodelruns` : number of model runs
  * `numhorizons` : number of info-gap horizons of uncertainty
  * `maxHorizon` : maximum info-gap horizons of uncertainty
  * `numlikelihoods` : number of Bayesian likelihoods

Returns:

  * `bigdtresults` : dictionary with BIG-DT results

**Mads.dobigdt**

Methods

  * `Mads.dobigdt(madsdata::Associative, nummodelruns::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:131

Arguments

  * `madsdata`
  * `nummodelruns`

Keywords

  * `maxHorizon`
  * `numhorizons`
  * `numlikelihoods`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsBayesInfoGap.jl#L113-L129' class='documenter-source'>source</a><br>

<a id='Mads.documentfunction-Tuple{Function}' href='#Mads.documentfunction-Tuple{Function}'>#</a>
**`Mads.documentfunction`** &mdash; *Method*.



Create function document


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsDocumentation.jl#L1-L3' class='documenter-source'>source</a><br>

<a id='Mads.dumpasciifile-Tuple{String,Any}' href='#Mads.dumpasciifile-Tuple{String,Any}'>#</a>
**`Mads.dumpasciifile`** &mdash; *Method*.



Dump ASCII file

**Mads.dumpasciifile**

Methods

  * `Mads.dumpasciifile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:17

Arguments

  * `data`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsASCII.jl#L11-L15' class='documenter-source'>source</a><br>

<a id='Mads.dumpjsonfile-Tuple{String,Any}' href='#Mads.dumpjsonfile-Tuple{String,Any}'>#</a>
**`Mads.dumpjsonfile`** &mdash; *Method*.



Dump a JSON file

**Mads.dumpjsonfile**

Methods

  * `Mads.dumpjsonfile(filename::String, data)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:26

Arguments

  * `data`
  * `f`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsJSON.jl#L20-L24' class='documenter-source'>source</a><br>

<a id='Mads.dumpwelldata-Tuple{Associative,String}' href='#Mads.dumpwelldata-Tuple{Associative,String}'>#</a>
**`Mads.dumpwelldata`** &mdash; *Method*.



Dump well data from MADS problem dictionary into a ASCII file

**Mads.dumpwelldata**

Methods

  * `Mads.dumpwelldata(madsdata::Associative, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:798

Arguments

  * `#temp#`
  * `c`
  * `filename`
  * `i`
  * `madsdata`
  * `n`
  * `o`
  * `outfile`
  * `t`
  * `x`
  * `y`
  * `z0`
  * `z1`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L792-L796' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlfile-Tuple{String,Any}' href='#Mads.dumpyamlfile-Tuple{String,Any}'>#</a>
**`Mads.dumpyamlfile`** &mdash; *Method*.



Dump YAML file

Arguments:

  * `filename` : file name
  * `yamldata` : YAML data

**Mads.dumpyamlfile**

Methods

  * `Mads.dumpyamlfile(filename::String, yamldata)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:40

Arguments

  * `filename`
  * `yamldata`

Keywords

  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsYAML.jl#L29-L38' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlmadsfile-Tuple{Any,String}' href='#Mads.dumpyamlmadsfile-Tuple{Any,String}'>#</a>
**`Mads.dumpyamlmadsfile`** &mdash; *Method*.



Dump YAML Mads file

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : file name

**Mads.dumpyamlmadsfile**

Methods

  * `Mads.dumpyamlmadsfile(madsdata, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:61

Arguments

  * `filename`
  * `madsdata`

Keywords

  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsYAML.jl#L50-L59' class='documenter-source'>source</a><br>

<a id='Mads.efast-Tuple{Associative}' href='#Mads.efast-Tuple{Associative}'>#</a>
**`Mads.efast`** &mdash; *Method*.



Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `M` : maximum number of harmonics
  * `gamma` : multiplication factor (Saltelli 1999 recommends gamma = 2 or 4)
  * `seed` : initial random seed

**Mads.efast**

Methods

  * `Mads.efast(md::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:999

Arguments

  * `M`
  * `N`
  * `checkpointfrequency`
  * `gamma`
  * `issvr`
  * `md`
  * `plotresults`
  * `restart`
  * `restartdir`
  * `seed`
  * `truncateRanges`

Keywords

  * `M`
  * `N`
  * `checkpointfrequency`
  * `gamma`
  * `issvr`
  * `plotresults`
  * `restart`
  * `restartdir`
  * `seed`
  * `truncateRanges`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L947-L959' class='documenter-source'>source</a><br>

<a id='Mads.emceesampling-Tuple{Associative}' href='#Mads.emceesampling-Tuple{Associative}'>#</a>
**`Mads.emceesampling`** &mdash; *Method*.



Bayesian sampling with Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

```
Mads.emceesampling(madsdata; numwalkers=10, nsteps=100, burnin=100, thinning=1, seed=2016, sigma=0.01)
Mads.emceesampling(madsdata, p0; numwalkers=10, nsteps=100, burnin=10, thinning=1, seed=2016)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `p0` : initial parameters (matrix of size (length(optparams), numwalkers))
  * `numwalkers` : number of walkers (if in parallel this can be the number of available processors)
  * `nsteps` : number of final realizations in the chain
  * `burnin` :  number of initial realizations before the MCMC are recorded
  * `thinning` : removal of any `thinning` realization
  * `seed` : initial random number seed
  * `sigma` : a standard deviation parameter used to initialize the walkers

Returns:

  * `mcmcchain` : MCMC chain
  * `llhoodvals` : log likelihoods of the final samples in the chain

**Mads.emceesampling**

Methods

  * `Mads.emceesampling(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:35

Arguments

  * `madsdata`

Keywords

  * `burnin`
  * `nsteps`
  * `numwalkers`
  * `seed`
  * `sigma`
  * `thinning`
  * `weightfactor`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L8-L33' class='documenter-source'>source</a><br>

<a id='Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}' href='#Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.estimationerror`** &mdash; *Method*.



Estimate kriging error

**Mads.estimationerror**

Methods

  * `Mads.estimationerror(w::Array{T<:Any,1}, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:118

Arguments

  * `X`
  * `cov`
  * `cov0`
  * `covmat`
  * `covvec`
  * `w`
  * `x0`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L112-L116' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpression-Tuple{String,Associative}' href='#Mads.evaluatemadsexpression-Tuple{String,Associative}'>#</a>
**`Mads.evaluatemadsexpression`** &mdash; *Method*.



Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

**Mads.evaluatemadsexpression**

Methods

  * `Mads.evaluatemadsexpression(expressionstring::String, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:114

Arguments

  * `expression`
  * `expressionstring`
  * `parameters`
  * `retval`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L108-L112' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpressions-Tuple{Associative,Associative}' href='#Mads.evaluatemadsexpressions-Tuple{Associative,Associative}'>#</a>
**`Mads.evaluatemadsexpressions`** &mdash; *Method*.



Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

**Mads.evaluatemadsexpressions**

Methods

  * `Mads.evaluatemadsexpressions(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:127

Arguments

  * `#temp#`
  * `expressions`
  * `exprname`
  * `madsdata`
  * `parameters`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L121-L125' class='documenter-source'>source</a><br>

<a id='Mads.expcov-Tuple{Number,Number,Number}' href='#Mads.expcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.expcov`** &mdash; *Method*.



Exponential spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L4' class='documenter-source'>source</a><br>

<a id='Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.exponentialvariogram`** &mdash; *Method*.



Exponential variogram

**Mads.exponentialvariogram**

Methods

  * `Mads.exponentialvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:31

Arguments

  * `h`
  * `nugget`
  * `range`
  * `sill`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L25-L29' class='documenter-source'>source</a><br>

<a id='Mads.filterkeys-Tuple{Associative,Regex}' href='#Mads.filterkeys-Tuple{Associative,Regex}'>#</a>
**`Mads.filterkeys`** &mdash; *Method*.



Filter dictionary keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L581' class='documenter-source'>source</a><br>

<a id='Mads.forward-Tuple{Associative}' href='#Mads.forward-Tuple{Associative}'>#</a>
**`Mads.forward`** &mdash; *Method*.



Perform a forward run using the initial or provided values for the model parameters

  * `forward(madsdata)`
  * `forward(madsdata, paramdict)`
  * `forward(madsdata, paramarray)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramdict` : dictionary of model parameter values
  * `paramarray` : array of model parameter values

Returns:

  * `obsvalues` : dictionary of model predictions

**Mads.forward**

Methods

  * `Mads.forward(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:25

Arguments

  * `madsdata`

Keywords

  * `all`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsForward.jl#L5-L23' class='documenter-source'>source</a><br>

<a id='Mads.forwardgrid-Tuple{Associative}' href='#Mads.forwardgrid-Tuple{Associative}'>#</a>
**`Mads.forwardgrid`** &mdash; *Method*.



Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

  * `forwardgrid(madsdata)`
  * `forwardgrid(madsdata, paramvalues))`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramvalues` : dictionary of model parameter values

Returns:

  * `array3d` : 3D array with model predictions along a 3D grid

**Mads.forwardgrid**

Methods

  * `Mads.forwardgrid(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsForward.jl:134

Arguments

  * `madsdata`
  * `paramvalues`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsForward.jl#L116-L132' class='documenter-source'>source</a><br>

<a id='Mads.free' href='#Mads.free'>#</a>
**`Mads.free`** &mdash; *Function*.



Free Mads / Julia modules

**Mads.free**

Methods

  * `Mads.free(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:132
  * `Mads.free()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:132

Arguments

  * `modulename`

Keywords

  * `all`
  * `required`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L126-L130' class='documenter-source'>source</a><br>

<a id='Mads.functions' href='#Mads.functions'>#</a>
**`Mads.functions`** &mdash; *Function*.



List available functions in the MADS modules:

Examples:

```
Mads.functions()
Mads.functions(BIGUQ)
Mads.functions("get")
Mads.functions(Mads, "get")
```

Arguments:

  * `module` : MADS module
  * `string` : matching string

**Mads.functions**

Methods

  * `Mads.functions(string::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:41
  * `Mads.functions()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:41

Arguments

  * `#temp#`
  * `i`
  * `string`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelp.jl#L21-L39' class='documenter-source'>source</a><br>

<a id='Mads.gaussiancov-Tuple{Number,Number,Number}' href='#Mads.gaussiancov-Tuple{Number,Number,Number}'>#</a>
**`Mads.gaussiancov`** &mdash; *Method*.



Gaussian spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.gaussianvariogram`** &mdash; *Method*.



Gaussian variogram

**Mads.gaussianvariogram**

Methods

  * `Mads.gaussianvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:44

Arguments

  * `h`
  * `nugget`
  * `range`
  * `sill`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L38-L42' class='documenter-source'>source</a><br>

<a id='Mads.getcovmat-Tuple{Array{T,2},Function}' href='#Mads.getcovmat-Tuple{Array{T,2},Function}'>#</a>
**`Mads.getcovmat`** &mdash; *Method*.



Get spatial covariance matrix

**Mads.getcovmat**

Methods

  * `Mads.getcovmat(X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:83

Arguments

  * `#temp#`
  * `X`
  * `cov`
  * `cov0`
  * `covmat`
  * `i`
  * `j`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L77-L81' class='documenter-source'>source</a><br>

<a id='Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}' href='#Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.getcovvec!`** &mdash; *Method*.



Get spatial covariance vector

**Mads.getcovvec!**

Methods

  * `Mads.getcovvec!(covvec::Array, x0::Array{T<:Any,1}, X::Array{T<:Any,2}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:101

Arguments

  * `#temp#`
  * `X`
  * `cov`
  * `covvec`
  * `d`
  * `i`
  * `j`
  * `x0`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L95-L99' class='documenter-source'>source</a><br>

<a id='Mads.getdictvalues-Tuple{Associative,Regex}' href='#Mads.getdictvalues-Tuple{Associative,Regex}'>#</a>
**`Mads.getdictvalues`** &mdash; *Method*.



Get dictionary values for keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L589' class='documenter-source'>source</a><br>

<a id='Mads.getdir-Tuple{String}' href='#Mads.getdir-Tuple{String}'>#</a>
**`Mads.getdir`** &mdash; *Method*.



Get directory

Example:

```
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```

**Mads.getdir**

Methods

  * `Mads.getdir(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:266

Arguments

  * `d`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L253-L264' class='documenter-source'>source</a><br>

<a id='Mads.getdistribution-Tuple{String,String,String}' href='#Mads.getdistribution-Tuple{String,String,String}'>#</a>
**`Mads.getdistribution`** &mdash; *Method*.



Parse distribution from a string

**Mads.getdistribution**

Methods

  * `Mads.getdistribution(dist::String, i::String, inputtype::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:147

Arguments

  * `dist`
  * `distribution`
  * `i`
  * `inputtype`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L141-L145' class='documenter-source'>source</a><br>

<a id='Mads.getextension-Tuple{String}' href='#Mads.getextension-Tuple{String}'>#</a>
**`Mads.getextension`** &mdash; *Method*.



Get file name extension

Example:

```
ext = Mads.getextension("a.mads") # ext = "mads"
```

**Mads.getextension**

Methods

  * `Mads.getextension(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:409

Arguments

  * `d`
  * `filename`
  * `s`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L397-L407' class='documenter-source'>source</a><br>

<a id='Mads.getfunctionarguments-Tuple{Function}' href='#Mads.getfunctionarguments-Tuple{Function}'>#</a>
**`Mads.getfunctionarguments`** &mdash; *Method*.



Get function arguments


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsDocumentation.jl#L50-L52' class='documenter-source'>source</a><br>

<a id='Mads.getfunctionkeywords-Tuple{Function}' href='#Mads.getfunctionkeywords-Tuple{Function}'>#</a>
**`Mads.getfunctionkeywords`** &mdash; *Method*.



Get function keywords


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsDocumentation.jl#L74-L76' class='documenter-source'>source</a><br>

<a id='Mads.getimportantsamples-Tuple{Array,Array{T,1}}' href='#Mads.getimportantsamples-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.getimportantsamples`** &mdash; *Method*.



Get important samples

Arguments:

  * `samples` : array of samples
  * `llhoods` : vector of log-likelihoods

Returns:

  * `imp_samples` : array of important samples

**Mads.getimportantsamples**

Methods

  * `Mads.getimportantsamples(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:239

Arguments

  * `#temp#`
  * `cumprob`
  * `i`
  * `imp_samples`
  * `llhoods`
  * `samples`
  * `sortedlhoods`
  * `sortedprobs`
  * `thresholdllhood`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L224-L237' class='documenter-source'>source</a><br>

<a id='Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L476' class='documenter-source'>source</a><br>

<a id='Mads.getmadsdir-Tuple{}' href='#Mads.getmadsdir-Tuple{}'>#</a>
**`Mads.getmadsdir`** &mdash; *Method*.



Get the directory where currently Mads is running

`problemdir = Mads.getmadsdir()`

**Mads.getmadsdir**

Methods

  * `Mads.getmadsdir()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:301

Arguments

  * `problemdir`
  * `source_path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L293-L299' class='documenter-source'>source</a><br>

<a id='Mads.getmadsinputfile-Tuple{}' href='#Mads.getmadsinputfile-Tuple{}'>#</a>
**`Mads.getmadsinputfile`** &mdash; *Method*.



Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

`Mads.getmadsinputfile()`

Arguments: `none`

Returns:

  * `filename` : input file name (e.g. `input_file_name.mads`)

**Mads.getmadsinputfile**

Methods

  * `Mads.getmadsinputfile()` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:239


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L225-L237' class='documenter-source'>source</a><br>

<a id='Mads.getmadsproblemdir-Tuple{Associative}' href='#Mads.getmadsproblemdir-Tuple{Associative}'>#</a>
**`Mads.getmadsproblemdir`** &mdash; *Method*.



Get the directory where the Mads data file is located

`Mads.getmadsproblemdir(madsdata)`

Example:

```
madsdata = Mads.loadmadsproblem("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`

**Mads.getmadsproblemdir**

Methods

  * `Mads.getmadsproblemdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:290

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L273-L288' class='documenter-source'>source</a><br>

<a id='Mads.getmadsrootname-Tuple{Associative}' href='#Mads.getmadsrootname-Tuple{Associative}'>#</a>
**`Mads.getmadsrootname`** &mdash; *Method*.



Get the MADS problem root name

`madsrootname = Mads.getmadsrootname(madsdata)`

**Mads.getmadsrootname**

Methods

  * `Mads.getmadsrootname(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:250

Arguments

  * `madsdata`

Keywords

  * `first`
  * `version`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L242-L248' class='documenter-source'>source</a><br>

<a id='Mads.getnextmadsfilename-Tuple{String}' href='#Mads.getnextmadsfilename-Tuple{String}'>#</a>
**`Mads.getnextmadsfilename`** &mdash; *Method*.



Get next mads file name

**Mads.getnextmadsfilename**

Methods

  * `Mads.getnextmadsfilename(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:377

Arguments

  * `filename`
  * `filename_old`
  * `t`
  * `t0`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L371-L375' class='documenter-source'>source</a><br>

<a id='Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L476' class='documenter-source'>source</a><br>

<a id='Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L476' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative,Any}' href='#Mads.getobsdist-Tuple{Associative,Any}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative}' href='#Mads.getobsdist-Tuple{Associative}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobskeys-Tuple{Associative}' href='#Mads.getobskeys-Tuple{Associative}'>#</a>
**`Mads.getobskeys`** &mdash; *Method*.



Get keys for all observations in the MADS problem dictionary

**Mads.getobskeys**

Methods

  * `Mads.getobskeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:31

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L25-L29' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative,Any}' href='#Mads.getobslog-Tuple{Associative,Any}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative}' href='#Mads.getobslog-Tuple{Associative}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative,Any}' href='#Mads.getobsmax-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative}' href='#Mads.getobsmax-Tuple{Associative}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative,Any}' href='#Mads.getobsmin-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative}' href='#Mads.getobsmin-Tuple{Associative}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative,Any}' href='#Mads.getobstarget-Tuple{Associative,Any}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative}' href='#Mads.getobstarget-Tuple{Associative}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative,Any}' href='#Mads.getobstime-Tuple{Associative,Any}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative}' href='#Mads.getobstime-Tuple{Associative}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative,Any}' href='#Mads.getobsweight-Tuple{Associative,Any}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative}' href='#Mads.getobsweight-Tuple{Associative}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L62' class='documenter-source'>source</a><br>

<a id='Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L476' class='documenter-source'>source</a><br>

<a id='Mads.getoptparams-Tuple{Associative}' href='#Mads.getoptparams-Tuple{Associative}'>#</a>
**`Mads.getoptparams`** &mdash; *Method*.



Get optimizable parameters

**Mads.getoptparams**

Methods

  * `Mads.getoptparams(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:334

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L328-L332' class='documenter-source'>source</a><br>

<a id='Mads.getparamdict-Tuple{Associative}' href='#Mads.getparamdict-Tuple{Associative}'>#</a>
**`Mads.getparamdict`** &mdash; *Method*.



Get dictionary with all parameters and their respective initial values

`Mads.getparamdict(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `paramdict` : dictionary with all parameters and their respective initial values

**Mads.getparamdict**

Methods

  * `Mads.getparamdict(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:62

Arguments

  * `#54`
  * `madsdata`
  * `paramdict`
  * `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L46-L60' class='documenter-source'>source</a><br>

<a id='Mads.getparamdistributions-Tuple{Associative}' href='#Mads.getparamdistributions-Tuple{Associative}'>#</a>
**`Mads.getparamdistributions`** &mdash; *Method*.



Get probabilistic distributions of all parameters in the MADS problem dictionary

`Mads.getparamdistributions(madsdata; init_dist=false)`

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Arguments:

  * `madsdata` : MADS problem dictionary
  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)

**Mads.getparamdistributions**

Methods

  * `Mads.getparamdistributions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:597

Arguments

  * `madsdata`

Keywords

  * `init_dist`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L580-L595' class='documenter-source'>source</a><br>

<a id='Mads.getparamkeys-Tuple{Associative}' href='#Mads.getparamkeys-Tuple{Associative}'>#</a>
**`Mads.getparamkeys`** &mdash; *Method*.



Get keys of all parameters in the MADS dictionary

`Mads.getparamkeys(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `paramkeys` : array with the keys of all parameters in the MADS dictionary

**Mads.getparamkeys**

Methods

  * `Mads.getparamkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:41

Arguments

  * `madsdata`

Keywords

  * `filter`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L25-L39' class='documenter-source'>source</a><br>

<a id='Mads.getparamrandom' href='#Mads.getparamrandom'>#</a>
**`Mads.getparamrandom`** &mdash; *Function*.



Get independent sampling of model parameters defined in the MADS problem dictionary

Arguments:

  * `madsdata` : MADS problem dictionary
  * `numsamples` : number of samples
  * `parameterkey` : model parameter key
  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)

**Mads.getparamrandom**

Methods

  * `Mads.getparamrandom(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:292
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:292
  * `Mads.getparamrandom(madsdata::Associative, numsamples::Integer, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:292

Arguments

  * `madsdata`
  * `numsamples`
  * `parameterkey`

Keywords

  * `init_dist`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L279-L290' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative}' href='#Mads.getparamsinit-Tuple{Associative}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit_max-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Method*.



Get an array with `init_max` values for parameters defined by `paramkeys`

**Mads.getparamsinit_max**

Methods

  * `Mads.getparamsinit_max(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:266

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L260-L264' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max-Tuple{Associative}' href='#Mads.getparamsinit_max-Tuple{Associative}'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Method*.



Get an array with `init_max` values for all the MADS model parameters

**Mads.getparamsinit_max**

Methods

  * `Mads.getparamsinit_max(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:305
  * `Mads.getparamsinit_max(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:266

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L299-L303' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit_min-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Method*.



Get an array with `init_min` values for parameters defined by `paramkeys`

**Mads.getparamsinit_min**

Methods

  * `Mads.getparamsinit_min(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:217

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L211-L215' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min-Tuple{Associative}' href='#Mads.getparamsinit_min-Tuple{Associative}'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Method*.



Get an array with `init_min` values for all the MADS model parameters

**Mads.getparamsinit_min**

Methods

  * `Mads.getparamsinit_min(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:256
  * `Mads.getparamsinit_min(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:217

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L250-L254' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslog-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative}' href='#Mads.getparamslog-Tuple{Associative}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslongname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative}' href='#Mads.getparamslongname-Tuple{Associative}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsmax-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsmax`** &mdash; *Method*.



Get an array with `max` values for parameters defined by `paramkeys`

**Mads.getparamsmax**

Methods

  * `Mads.getparamsmax(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:180

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L174-L178' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax-Tuple{Associative}' href='#Mads.getparamsmax-Tuple{Associative}'>#</a>
**`Mads.getparamsmax`** &mdash; *Method*.



Get an array with `min` values for all the MADS model parameters

**Mads.getparamsmax**

Methods

  * `Mads.getparamsmax(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:207
  * `Mads.getparamsmax(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:180

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L201-L205' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsmin-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsmin`** &mdash; *Method*.



Get an array with `min` values for parameters defined by `paramkeys`

**Mads.getparamsmin**

Methods

  * `Mads.getparamsmin(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:143

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L137-L141' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin-Tuple{Associative}' href='#Mads.getparamsmin-Tuple{Associative}'>#</a>
**`Mads.getparamsmin`** &mdash; *Method*.



Get an array with `min` values for all the MADS model parameters

**Mads.getparamsmin**

Methods

  * `Mads.getparamsmin(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:170
  * `Mads.getparamsmin(madsdata::Associative, paramkeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:143

Arguments

  * `#temp#`
  * `distribution`
  * `i`
  * `madsdata`
  * `p`
  * `paramkeys`
  * `paramvalue`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L164-L168' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsplotname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative}' href='#Mads.getparamsplotname-Tuple{Associative}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsstep-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative}' href='#Mads.getparamsstep-Tuple{Associative}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative,Array{T,1}}' href='#Mads.getparamstype-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative}' href='#Mads.getparamstype-Tuple{Associative}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L105' class='documenter-source'>source</a><br>

<a id='Mads.getprocs-Tuple{}' href='#Mads.getprocs-Tuple{}'>#</a>
**`Mads.getprocs`** &mdash; *Method*.



Get the number of processors

**Mads.getprocs**

Methods

  * `Mads.getprocs()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:16


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.getrestart-Tuple{Associative}' href='#Mads.getrestart-Tuple{Associative}'>#</a>
**`Mads.getrestart`** &mdash; *Method*.



Get MADS restart status

**Mads.getrestart**

Methods

  * `Mads.getrestart(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:25

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L19-L23' class='documenter-source'>source</a><br>

<a id='Mads.getrestartdir' href='#Mads.getrestartdir'>#</a>
**`Mads.getrestartdir`** &mdash; *Function*.



Get the directory where Mads restarts will be stored.

**Mads.getrestartdir**

Methods

  * `Mads.getrestartdir(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:233
  * `Mads.getrestartdir(madsdata::Associative, suffix::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:233

Arguments

  * `errmsg`
  * `madsdata`
  * `restartdir`
  * `root`
  * `suffix`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L227-L231' class='documenter-source'>source</a><br>

<a id='Mads.getrootname-Tuple{String}' href='#Mads.getrootname-Tuple{String}'>#</a>
**`Mads.getrootname`** &mdash; *Method*.



Get file name root

Example:

```
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```

**Mads.getrootname**

Methods

  * `Mads.getrootname(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:324

Arguments

  * `filename`

Keywords

  * `first`
  * `version`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L311-L322' class='documenter-source'>source</a><br>

<a id='Mads.getsindx-Tuple{Associative}' href='#Mads.getsindx-Tuple{Associative}'>#</a>
**`Mads.getsindx`** &mdash; *Method*.



Get sin-space dx

**Mads.getsindx**

Methods

  * `Mads.getsindx(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:223

Arguments

  * `madsdata`
  * `sindx`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L217-L221' class='documenter-source'>source</a><br>

<a id='Mads.getsourcekeys-Tuple{Associative}' href='#Mads.getsourcekeys-Tuple{Associative}'>#</a>
**`Mads.getsourcekeys`** &mdash; *Method*.



Get keys of all source parameters in the MADS dictionary

`Mads.getsourcekeys(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `sourcekeys` : array with keys of all source parameters in the MADS dictionary

**Mads.getsourcekeys**

Methods

  * `Mads.getsourcekeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:85

Arguments

  * `#temp#`
  * `b`
  * `i`
  * `k`
  * `madsdata`
  * `s`
  * `sk`
  * `sourcekeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L69-L83' class='documenter-source'>source</a><br>

<a id='Mads.gettarget-Tuple{Associative}' href='#Mads.gettarget-Tuple{Associative}'>#</a>
**`Mads.gettarget`** &mdash; *Method*.



Get observation target

**Mads.gettarget**

Methods

  * `Mads.gettarget(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:177

Arguments

  * `o`
  * `target`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L171-L175' class='documenter-source'>source</a><br>

<a id='Mads.gettargetkeys-Tuple{Associative}' href='#Mads.gettargetkeys-Tuple{Associative}'>#</a>
**`Mads.gettargetkeys`** &mdash; *Method*.



Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary

**Mads.gettargetkeys**

Methods

  * `Mads.gettargetkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:40

Arguments

  * `k`
  * `madsdata`
  * `t`
  * `w`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L34-L38' class='documenter-source'>source</a><br>

<a id='Mads.gettime-Tuple{Associative}' href='#Mads.gettime-Tuple{Associative}'>#</a>
**`Mads.gettime`** &mdash; *Method*.



Get observation time

**Mads.gettime**

Methods

  * `Mads.gettime(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:113

Arguments

  * `o`
  * `time`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L107-L111' class='documenter-source'>source</a><br>

<a id='Mads.getweight-Tuple{Associative}' href='#Mads.getweight-Tuple{Associative}'>#</a>
**`Mads.getweight`** &mdash; *Method*.



Get observation weight

**Mads.getweight**

Methods

  * `Mads.getweight(o::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:145

Arguments

  * `o`
  * `weight`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L139-L143' class='documenter-source'>source</a><br>

<a id='Mads.getwellkeys-Tuple{Associative}' href='#Mads.getwellkeys-Tuple{Associative}'>#</a>
**`Mads.getwellkeys`** &mdash; *Method*.



Get keys for all wells in the MADS problem dictionary

**Mads.getwellkeys**

Methods

  * `Mads.getwellkeys(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:52

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L46-L50' class='documenter-source'>source</a><br>

<a id='Mads.getwellsdata-Tuple{Associative}' href='#Mads.getwellsdata-Tuple{Associative}'>#</a>
**`Mads.getwellsdata`** &mdash; *Method*.



Get `Wells` class spatial and temporal data

**Mads.getwellsdata**

Methods

  * `Mads.getwellsdata(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:532

Arguments

  * `madsdata`

Keywords

  * `time`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L526-L530' class='documenter-source'>source</a><br>

<a id='Mads.graphoff-Tuple{}' href='#Mads.graphoff-Tuple{}'>#</a>
**`Mads.graphoff`** &mdash; *Method*.



MADS graph output off

**Mads.graphoff**

Methods

  * `Mads.graphoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:63


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L57-L61' class='documenter-source'>source</a><br>

<a id='Mads.graphon-Tuple{}' href='#Mads.graphon-Tuple{}'>#</a>
**`Mads.graphon`** &mdash; *Method*.



MADS graph output on

**Mads.graphon**

Methods

  * `Mads.graphon()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:54


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L48-L52' class='documenter-source'>source</a><br>

<a id='Mads.haskeyword-Tuple{Associative,String}' href='#Mads.haskeyword-Tuple{Associative,String}'>#</a>
**`Mads.haskeyword`** &mdash; *Method*.



Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

  * `Mads.haskeyword(madsdata, keyword)`
  * `Mads.haskeyword(madsdata, class, keyword)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `class` : dictionary class; if not provided searches for `keyword` in `Problem` class
  * `keyword` : dictionary key

Returns: `true` or `false`

Examples:

  * `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
  * `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"

**Mads.haskeyword**

Methods

  * `Mads.haskeyword(madsdata::Associative, keyword::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:151

Arguments

  * `keyword`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L129-L149' class='documenter-source'>source</a><br>

<a id='Mads.help-Tuple{}' href='#Mads.help-Tuple{}'>#</a>
**`Mads.help`** &mdash; *Method*.



Produce MADS help information

**Mads.help**

Methods

  * `Mads.help()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelp.jl:9


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelp.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.importeverywhere-Tuple{String}' href='#Mads.importeverywhere-Tuple{String}'>#</a>
**`Mads.importeverywhere`** &mdash; *Method*.



Import function everywhere from a file. The first function in the file is the one that will be called by Mads to perform the model simulations.

**Mads.importeverywhere**

Methods

  * `Mads.importeverywhere(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:281

Arguments

  * `code`
  * `commandfunction`
  * `filename`
  * `fullcode`
  * `functionname`
  * `functionsymbol`
  * `q`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L274-L279' class='documenter-source'>source</a><br>

<a id='Mads.indexkeys-Tuple{Associative,Regex}' href='#Mads.indexkeys-Tuple{Associative,Regex}'>#</a>
**`Mads.indexkeys`** &mdash; *Method*.



Find indexes for dictionary keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L585' class='documenter-source'>source</a><br>

<a id='Mads.ins_obs-Tuple{String,String}' href='#Mads.ins_obs-Tuple{String,String}'>#</a>
**`Mads.ins_obs`** &mdash; *Method*.



Apply Mads instruction file `instructionfilename` to read model input file `inputfilename`

**Mads.ins_obs**

Methods

  * `Mads.ins_obs(instructionfilename::String, inputfilename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:735

Arguments

  * `#temp#`
  * `getparamhere`
  * `gotmatch`
  * `inputfilename`
  * `instfile`
  * `instline`
  * `instructionfilename`
  * `obsdict`
  * `obsfile`
  * `obsline`
  * `obslineitr`
  * `obsnames`
  * `regexs`
  * `state`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L729-L733' class='documenter-source'>source</a><br>

<a id='Mads.instline2regexs-Tuple{String}' href='#Mads.instline2regexs-Tuple{String}'>#</a>
**`Mads.instline2regexs`** &mdash; *Method*.



Convert an instruction line in the Mads instruction file into regular expressions

**Mads.instline2regexs**

Methods

  * `Mads.instline2regexs(instline::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:658

Arguments

  * `#temp#`
  * `floatregex`
  * `getparamhere`
  * `instline`
  * `m`
  * `obsnames`
  * `offset`
  * `regex`
  * `regexs`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L652-L656' class='documenter-source'>source</a><br>

<a id='Mads.invobsweights!-Tuple{Associative,Number}' href='#Mads.invobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invobsweights!`** &mdash; *Method*.



Inversely proportional observation weights in the MADS problem dictionary

**Mads.invobsweights!**

Methods

  * `Mads.invobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:280

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `obskeys`
  * `t`
  * `value`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L274-L278' class='documenter-source'>source</a><br>

<a id='Mads.invwellweights!-Tuple{Associative,Number}' href='#Mads.invwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invwellweights!`** &mdash; *Method*.



Inversely proportional observation weights in the MADS problem dictionary

**Mads.invwellweights!**

Methods

  * `Mads.invwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:325

Arguments

  * `#temp#`
  * `i`
  * `k`
  * `madsdata`
  * `t`
  * `value`
  * `wellkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L319-L323' class='documenter-source'>source</a><br>

<a id='Mads.islog-Tuple{Associative,String}' href='#Mads.islog-Tuple{Associative,String}'>#</a>
**`Mads.islog`** &mdash; *Method*.



Is parameter with key `parameterkey` log-transformed?

**Mads.islog**

Methods

  * `Mads.islog(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:381

Arguments

  * `#temp#`
  * `madsdata`
  * `parameterkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L375-L379' class='documenter-source'>source</a><br>

<a id='Mads.isobs-Tuple{Associative,Associative}' href='#Mads.isobs-Tuple{Associative,Associative}'>#</a>
**`Mads.isobs`** &mdash; *Method*.



Is a dictionary containing all the observations

**Mads.isobs**

Methods

  * `Mads.isobs(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:10

Arguments

  * `#temp#`
  * `dict`
  * `flag`
  * `i`
  * `madsdata`
  * `obs`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.isopt-Tuple{Associative,String}' href='#Mads.isopt-Tuple{Associative,String}'>#</a>
**`Mads.isopt`** &mdash; *Method*.



Is parameter with key `parameterkey` optimizable?

**Mads.isopt**

Methods

  * `Mads.isopt(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:367

Arguments

  * `#temp#`
  * `madsdata`
  * `parameterkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L361-L365' class='documenter-source'>source</a><br>

<a id='Mads.isparam-Tuple{Associative,Associative}' href='#Mads.isparam-Tuple{Associative,Associative}'>#</a>
**`Mads.isparam`** &mdash; *Method*.



Is the dictionary containing all the parameters

**Mads.isparam**

Methods

  * `Mads.isparam(madsdata::Associative, dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:10

Arguments

  * `#temp#`
  * `dict`
  * `flag`
  * `i`
  * `madsdata`
  * `par`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable-Tuple{String}' href='#Mads.ispkgavailable-Tuple{String}'>#</a>
**`Mads.ispkgavailable`** &mdash; *Method*.



Checks of package is available

**Mads.ispkgavailable**

Methods

  * `Mads.ispkgavailable(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:9

Arguments

  * `flag`
  * `modulename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}' href='#Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}'>#</a>
**`Mads.krige`** &mdash; *Method*.



Kriging

**Mads.krige**

Methods

  * `Mads.krige(x0mat::Array, X::Array{T<:Any,2}, Z::Array{T<:Any,1}, cov::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:57

Arguments

  * `#temp#`
  * `X`
  * `Z`
  * `bigmat`
  * `bigmatpinv`
  * `bigvec`
  * `cov`
  * `covmat`
  * `covvec`
  * `i`
  * `j`
  * `result`
  * `ws`
  * `x`
  * `x0mat`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L51-L55' class='documenter-source'>source</a><br>

<a id='Mads.levenberg_marquardt' href='#Mads.levenberg_marquardt'>#</a>
**`Mads.levenberg_marquardt`** &mdash; *Function*.



Levenberg-Marquardt optimization

Arguments:

  * `f` : forward model function
  * `g` : gradient function for the forward model
  * `x0` : initial parameter guess
  * `root` : Mads problem root name
  * `tolX` : parameter space tolerance
  * `tolG` : parameter space update tolerance
  * `tolOF` : objective function update tolerance
  * `maxEval` : maximum number of model evaluations
  * `maxIter` : maximum number of optimization iterations
  * `maxJacobians` : maximum number of Jacobian solves
  * `lambda` : initial Levenberg-Marquardt lambda [eps(Float32)]
  * `lambda_scale` : lambda scaling factor
  * `lambda_mu` : lambda multiplication factor μ [10]
  * `lambda_nu` : lambda multiplication factor ν [10]
  * `np_lambda` : number of parallel lambda solves
  * `show_trace` : shows solution trace [default=false]
  * `alwaysDoJacobian`: computer Jacobian each iteration [false]
  * `callback` : call back function for debugging

**Mads.levenberg_marquardt**

Methods

  * `Mads.levenberg_marquardt(f::Function, g::Function, x0)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:363
  * `Mads.levenberg_marquardt(f::Function, g::Function, x0, o::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:363

Arguments

  * `#130`
  * `#131`
  * `alwaysDoJacobian`
  * `callback`
  * `f`
  * `g`
  * `lambda`
  * `lambda_mu`
  * `lambda_nu`
  * `lambda_scale`
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `np_lambda`
  * `o`
  * `root`
  * `show_trace`
  * `tolG`
  * `tolOF`
  * `tolX`
  * `x0`

Keywords

  * `alwaysDoJacobian`
  * `callback`
  * `lambda`
  * `lambda_mu`
  * `lambda_nu`
  * `lambda_scale`
  * `maxEval`
  * `maxIter`
  * `maxJacobians`
  * `np_lambda`
  * `root`
  * `show_trace`
  * `tolG`
  * `tolOF`
  * `tolX`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L315-L340' class='documenter-source'>source</a><br>

<a id='Mads.linktempdir-Tuple{String,String}' href='#Mads.linktempdir-Tuple{String,String}'>#</a>
**`Mads.linktempdir`** &mdash; *Method*.



Link files in a temporary directory

**Mads.linktempdir**

Methods

  * `Mads.linktempdir(madsproblemdir::String, tempdirname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:932

Arguments

  * `attempt`
  * `errmsg`
  * `madsproblemdir`
  * `tempdirname`
  * `trying`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L926-L930' class='documenter-source'>source</a><br>

<a id='Mads.loadasciifile-Tuple{String}' href='#Mads.loadasciifile-Tuple{String}'>#</a>
**`Mads.loadasciifile`** &mdash; *Method*.



Load ASCII file

**Mads.loadasciifile**

Methods

  * `Mads.loadasciifile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:7

Arguments

  * `data`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsASCII.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.loadjsonfile-Tuple{String}' href='#Mads.loadjsonfile-Tuple{String}'>#</a>
**`Mads.loadjsonfile`** &mdash; *Method*.



Load a JSON file

**Mads.loadjsonfile**

Methods

  * `Mads.loadjsonfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:10

Arguments

  * `a`
  * `data`
  * `f`
  * `filename`
  * `s`
  * `sz`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsJSON.jl#L4-L8' class='documenter-source'>source</a><br>

<a id='Mads.loadmadsfile-Tuple{String}' href='#Mads.loadmadsfile-Tuple{String}'>#</a>
**`Mads.loadmadsfile`** &mdash; *Method*.



Load MADS input file defining a MADS problem dictionary

  * `Mads.loadmadsfile(filename)`
  * `Mads.loadmadsfile(filename; julia=false)`
  * `Mads.loadmadsfile(filename; julia=true)`

Arguments:

  * `filename` : input file name (e.g. `input_file_name.mads`)
  * `julia` : if `true`, force using `julia` parsing functions; if `false` (default), use `python` parsing functions [boolean]

Returns:

  * `madsdata` : Mads problem dictionary

Example: `md = loadmadsfile("input_file_name.mads")`

**Mads.loadmadsfile**

Methods

  * `Mads.loadmadsfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:24

Arguments

  * `filename`

Keywords

  * `format`
  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L3-L22' class='documenter-source'>source</a><br>

<a id='Mads.loadyamlfile-Tuple{String}' href='#Mads.loadyamlfile-Tuple{String}'>#</a>
**`Mads.loadyamlfile`** &mdash; *Method*.



Load YAML file

Arguments:

  * `filename` : file name
  * `julia=false` : use Python YAML library (if available)
  * `julia=true` : use Julia YAML library (if available)

**Mads.loadyamlfile**

Methods

  * `Mads.loadyamlfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:17

Arguments

  * `filename`

Keywords

  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsYAML.jl#L5-L15' class='documenter-source'>source</a><br>

<a id='Mads.localsa-Tuple{Associative}' href='#Mads.localsa-Tuple{Associative}'>#</a>
**`Mads.localsa`** &mdash; *Method*.



Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `par` : parameter set
  * `obs` : observations for the parameter set

**Mads.localsa**

Methods

  * `Mads.localsa(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:43

Arguments

  * `madsdata`

Keywords

  * `J`
  * `datafiles`
  * `filename`
  * `format`
  * `imagefiles`
  * `obs`
  * `par`
  * `sinspace`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L29-L41' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_off-Tuple{}' href='#Mads.long_tests_off-Tuple{}'>#</a>
**`Mads.long_tests_off`** &mdash; *Method*.



Turn off execution of long MADS tests (default)

**Mads.long_tests_off**

Methods

  * `Mads.long_tests_off()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:99


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L93-L97' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_on-Tuple{}' href='#Mads.long_tests_on-Tuple{}'>#</a>
**`Mads.long_tests_on`** &mdash; *Method*.



Turn on execution of long MADS tests (dangerous)

**Mads.long_tests_on**

Methods

  * `Mads.long_tests_on()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:90


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L84-L88' class='documenter-source'>source</a><br>

<a id='Mads.madscores' href='#Mads.madscores'>#</a>
**`Mads.madscores`** &mdash; *Function*.



Check the number of processors on a series of servers

**Mads.madscores**

Methods

  * `Mads.madscores(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:295
  * `Mads.madscores()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:295

Arguments

  * `nodenames`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L289-L293' class='documenter-source'>source</a><br>

<a id='Mads.madscritical-Tuple{String}' href='#Mads.madscritical-Tuple{String}'>#</a>
**`Mads.madscritical`** &mdash; *Method*.



MADS critical error messages

**Mads.madscritical**

Methods

  * `Mads.madscritical(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:65

Arguments

  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L59-L63' class='documenter-source'>source</a><br>

<a id='Mads.madsdebug' href='#Mads.madsdebug'>#</a>
**`Mads.madsdebug`** &mdash; *Function*.



MADS debug messages (controlled by `quiet` and `debuglevel`)

**Mads.madsdebug**

Methods

  * `Mads.madsdebug(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:19
  * `Mads.madsdebug(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:19

Arguments

  * `#temp#`
  * `level`
  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L13-L17' class='documenter-source'>source</a><br>

<a id='Mads.madserror-Tuple{String}' href='#Mads.madserror-Tuple{String}'>#</a>
**`Mads.madserror`** &mdash; *Method*.



MADS error messages

**Mads.madserror**

Methods

  * `Mads.madserror(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:54

Arguments

  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L48-L52' class='documenter-source'>source</a><br>

<a id='Mads.madsinfo' href='#Mads.madsinfo'>#</a>
**`Mads.madsinfo`** &mdash; *Function*.



MADS information/status messages (controlled by quiet`and`verbositylevel`)

**Mads.madsinfo**

Methods

  * `Mads.madsinfo(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:31
  * `Mads.madsinfo(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:31

Arguments

  * `#temp#`
  * `level`
  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L25-L29' class='documenter-source'>source</a><br>

<a id='Mads.madsload' href='#Mads.madsload'>#</a>
**`Mads.madsload`** &mdash; *Function*.



Check the load of a series of servers

**Mads.madsload**

Methods

  * `Mads.madsload(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:313
  * `Mads.madsload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:313

Arguments

  * `nodenames`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L307-L311' class='documenter-source'>source</a><br>

<a id='Mads.madsmathprogbase' href='#Mads.madsmathprogbase'>#</a>
**`Mads.madsmathprogbase`** &mdash; *Function*.



Mads execution using MathProgBase

**Mads.madsmathprogbase**

Methods

  * `Mads.madsmathprogbase()` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:13
  * `Mads.madsmathprogbase(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:13

Arguments

  * `#temp#`
  * `f`
  * `f_mpb`
  * `g_mpb`
  * `grad_o_mpb`
  * `index`
  * `initparams`
  * `lineardx`
  * `madsdata`
  * `maxs`
  * `mins`
  * `nO`
  * `nP`
  * `o_function`
  * `o_mpb`
  * `obskeys`
  * `optparamkeys`
  * `restartdir`
  * `sar`
  * `ssdr`
  * `targets`
  * `weights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMathProgBase.jl#L7-L11' class='documenter-source'>source</a><br>

<a id='Mads.madsoutput' href='#Mads.madsoutput'>#</a>
**`Mads.madsoutput`** &mdash; *Function*.



MADS output (controlled by quiet`and`verbositylevel`)

**Mads.madsoutput**

Methods

  * `Mads.madsoutput(message::String, level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:7
  * `Mads.madsoutput(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:7

Arguments

  * `#temp#`
  * `level`
  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.madsup' href='#Mads.madsup'>#</a>
**`Mads.madsup`** &mdash; *Function*.



Check the uptime of a series of servers

**Mads.madsup**

Methods

  * `Mads.madsup(nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:304
  * `Mads.madsup()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:304

Arguments

  * `nodenames`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L298-L302' class='documenter-source'>source</a><br>

<a id='Mads.madswarn-Tuple{String}' href='#Mads.madswarn-Tuple{String}'>#</a>
**`Mads.madswarn`** &mdash; *Method*.



MADS warning messages

**Mads.madswarn**

Methods

  * `Mads.madswarn(message::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsLog.jl:43

Arguments

  * `message`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLog.jl#L37-L41' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make a conditional log likelihood function that accepts an array containing the opt parameters' values

**Mads.makearrayconditionalloglikelihood**

Methods

  * `Mads.makearrayconditionalloglikelihood(madsdata::Associative, conditionalloglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:67

Arguments

  * `arrayconditionalloglikelihood`
  * `conditionalloglikelihood`
  * `f`
  * `initparams`
  * `madsdata`
  * `optparamkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L61-L65' class='documenter-source'>source</a><br>

<a id='Mads.makearrayfunction' href='#Mads.makearrayfunction'>#</a>
**`Mads.makearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameters' values

`Mads.makearrayfunction(madsdata, f)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : ...

Returns:

  * `arrayfunction` : function accepting an array containing the optimal parameters' values

**Mads.makearrayfunction**

Methods

  * `Mads.makearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:21
  * `Mads.makearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:21

Arguments

  * `arrayfunction`
  * `f`
  * `initparams`
  * `madsdata`
  * `optparamkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L4-L19' class='documenter-source'>source</a><br>

<a id='Mads.makearrayloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayloglikelihood`** &mdash; *Method*.



Make a log likelihood function that accepts an array containing the opt parameters' values

**Mads.makearrayloglikelihood**

Methods

  * `Mads.makearrayloglikelihood(madsdata::Associative, loglikelihood)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:84

Arguments

  * `arrayloglikelihood`
  * `f`
  * `initparams`
  * `loglikelihood`
  * `madsdata`
  * `optparamkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L78-L82' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt!-Tuple{Associative,Associative}' href='#Mads.makebigdt!-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt!`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Arguments:

  * `madsdata` : MADS problem dictionary
  * `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

  * `bigdtproblem` : BIG-DT problem type

**Mads.makebigdt!**

Methods

  * `Mads.makebigdt!(madsdata::Associative, choice::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:40

Arguments

  * `#temp#`
  * `c`
  * `choice`
  * `f`
  * `gethorizonoffailure`
  * `likelihoodparamsmax`
  * `likelihoodparamsmin`
  * `logprior`
  * `madsdata`
  * `makeloglikelihood`
  * `nominalparams`
  * `paramname`
  * `performancegoalsatisfied`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsBayesInfoGap.jl#L25-L38' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt-Tuple{Associative,Associative}' href='#Mads.makebigdt-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Arguments:

  * `madsdata` : MADS problem dictionary
  * `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

  * `bigdtproblem` : BIG-DT problem type

**Mads.makebigdt**

Methods

  * `Mads.makebigdt(madsdata::Associative, choice::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGap.jl:22

Arguments

  * `choice`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsBayesInfoGap.jl#L7-L20' class='documenter-source'>source</a><br>

<a id='Mads.makecomputeconcentrations-Tuple{Associative}' href='#Mads.makecomputeconcentrations-Tuple{Associative}'>#</a>
**`Mads.makecomputeconcentrations`** &mdash; *Method*.



Create a function to compute concentrations for all the observation points using Anasol

**Mads.makecomputeconcentrations**

Methods

  * `Mads.makecomputeconcentrations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasol.jl:80

Arguments

  * `madsdata`

Keywords

  * `calcpredictions`
  * `calczeroweightobs`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `computeconcentrations` : function to compute concentrations; `computeconcentrations` returns a dictionary of observations and model predicted concentrations

Examples:

`computeconcentrations()`

or

```
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasol.jl#L53-L78' class='documenter-source'>source</a><br>

<a id='Mads.makedoublearrayfunction' href='#Mads.makedoublearrayfunction'>#</a>
**`Mads.makedoublearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameters' values, and returns an array of observations

`Mads.makedoublearrayfunction(madsdata, f)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : ...

Returns:

  * `doublearrayfunction` : function accepting an array containing the optimal parameters' values, and returning an array of observations

**Mads.makedoublearrayfunction**

Methods

  * `Mads.makedoublearrayfunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:46
  * `Mads.makedoublearrayfunction(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:46

Arguments

  * `arrayfunction`
  * `doublearrayfunction`
  * `f`
  * `madsdata`
  * `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L29-L44' class='documenter-source'>source</a><br>

<a id='Mads.makelmfunctions-Tuple{Associative}' href='#Mads.makelmfunctions-Tuple{Associative}'>#</a>
**`Mads.makelmfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization

**Mads.makelmfunctions**

Methods

  * `Mads.makelmfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:85

Arguments

  * `107`
  * `f`
  * `f_lm`
  * `g_lm`
  * `index`
  * `initparams`
  * `inner_g_lm`
  * `lineardx`
  * `madsdata`
  * `maxs`
  * `mins`
  * `nO`
  * `nP`
  * `o_lm`
  * `obskeys`
  * `optparamkeys`
  * `restartdir`
  * `reusable_inner_g_lm`
  * `sar`
  * `ssdr`
  * `targets`
  * `weights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L79-L83' class='documenter-source'>source</a><br>

<a id='Mads.makelocalsafunction-Tuple{Associative}' href='#Mads.makelocalsafunction-Tuple{Associative}'>#</a>
**`Mads.makelocalsafunction`** &mdash; *Method*.



Make gradient function needed for local sensitivity analysis

**Mads.makelocalsafunction**

Methods

  * `Mads.makelocalsafunction(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:182

Arguments

  * `madsdata`

Keywords

  * `multiplycenterbyweights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L176-L180' class='documenter-source'>source</a><br>

<a id='Mads.makelogprior-Tuple{Associative}' href='#Mads.makelogprior-Tuple{Associative}'>#</a>
**`Mads.makelogprior`** &mdash; *Method*.



Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`

**Mads.makelogprior**

Methods

  * `Mads.makelogprior(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:388

Arguments

  * `distributions`
  * `logprior`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L382-L386' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunction-Tuple{Associative}' href='#Mads.makemadscommandfunction-Tuple{Associative}'>#</a>
**`Mads.makemadscommandfunction`** &mdash; *Method*.



Make MADS function to execute the model defined in the MADS problem dictionary `madsdata`

Usage:

```
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

**Mads.makemadscommandfunction**

Methods

  * `Mads.makemadscommandfunction(madsdatawithobs::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:53

Arguments

  * `madsdatawithobs`

Keywords

  * `calcpredictions`
  * `calczeroweightobs`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L7-L50' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunctionandgradient-Tuple{Associative}' href='#Mads.makemadscommandfunctionandgradient-Tuple{Associative}'>#</a>
**`Mads.makemadscommandfunctionandgradient`** &mdash; *Method*.



Make MADS forward & gradient functions for the model defined in the MADS problem dictionary `madsdata`

**Mads.makemadscommandfunctionandgradient**

Methods

  * `Mads.makemadscommandfunctionandgradient(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:320

Arguments

  * `f`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L314-L318' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandgradient-Tuple{Associative}' href='#Mads.makemadscommandgradient-Tuple{Associative}'>#</a>
**`Mads.makemadscommandgradient`** &mdash; *Method*.



Make MADS gradient function to compute the parameter-space gradient for the model defined in the MADS problem dictionary `madsdata`

**Mads.makemadscommandgradient**

Methods

  * `Mads.makemadscommandgradient(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:302

Arguments

  * `f`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L296-L300' class='documenter-source'>source</a><br>

<a id='Mads.makemadsconditionalloglikelihood-Tuple{Associative}' href='#Mads.makemadsconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsconditionalloglikelihood`** &mdash; *Method*.



Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations. Model parameters and observations are defined in the MADS problem dictionary `madsdata`.

**Mads.makemadsconditionalloglikelihood**

Methods

  * `Mads.makemadsconditionalloglikelihood(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:405

Arguments

  * `madsdata`

Keywords

  * `weightfactor`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L398-L403' class='documenter-source'>source</a><br>

<a id='Mads.makemadsloglikelihood-Tuple{Associative}' href='#Mads.makemadsloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsloglikelihood`** &mdash; *Method*.



Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations. The function can be provided as an external function in the MADS problem dictionary under `LogLikelihood` or computed internally.

**Mads.makemadsloglikelihood**

Methods

  * `Mads.makemadsloglikelihood(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:433

Arguments

  * `madsdata`

Keywords

  * `weightfactor`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L426-L431' class='documenter-source'>source</a><br>

<a id='Mads.makemadsreusablefunction' href='#Mads.makemadsreusablefunction'>#</a>
**`Mads.makemadsreusablefunction`** &mdash; *Function*.



Make Mads reusable function

**Mads.makemadsreusablefunction**

Methods

  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:209
  * `Mads.makemadsreusablefunction(madsdata::Associative, madscommandfunction::Function, suffix::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsFunc.jl:209

Arguments

  * `madscommandfunction`
  * `madsdata`
  * `suffix`

Keywords

  * `usedict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsFunc.jl#L203-L207' class='documenter-source'>source</a><br>

<a id='Mads.makempbfunctions-Tuple{Associative}' href='#Mads.makempbfunctions-Tuple{Associative}'>#</a>
**`Mads.makempbfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for MathProgBase optimization

**Mads.makempbfunctions**

Methods

  * `Mads.makempbfunctions(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMathProgBase.jl:82

Arguments

  * `241`
  * `242`
  * `f_mpb`
  * `g_mpb`
  * `grad_o_mpb`
  * `inner_g_mpb`
  * `madsdata`
  * `o_mpb`
  * `reusable_inner_g_mpb`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMathProgBase.jl#L76-L80' class='documenter-source'>source</a><br>

<a id='Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}' href='#Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.maxtorealmax!`** &mdash; *Method*.



Scale down values larger than max(Float32) in a Dataframe `df` so that Gadfly can plot the data

**Mads.maxtorealmax!**

Methods

  * `Mads.maxtorealmax!(df::DataFrames.DataFrame)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:935

Arguments

  * `#temp#`
  * `df`
  * `i`
  * `j`
  * `limit`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L929-L933' class='documenter-source'>source</a><br>

<a id='Mads.modelinformationcriteria' href='#Mads.modelinformationcriteria'>#</a>
**`Mads.modelinformationcriteria`** &mdash; *Function*.



Model section information criteria

**Mads.modelinformationcriteria**

Methods

  * `Mads.modelinformationcriteria(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:7
  * `Mads.modelinformationcriteria(madsdata::Associative, par::Array{Float64,N<:Any})` : /Users/monty/.julia/v0.5/Mads/src/MadsModelSelection.jl:7

Arguments

  * `#temp#`
  * `aic`
  * `aicc`
  * `aopt`
  * `bic`
  * `copt`
  * `det_w`
  * `dof`
  * `dopt`
  * `eopt`
  * `f`
  * `gf`
  * `kic`
  * `l`
  * `ln_det_v`
  * `ln_det_w`
  * `madsdata`
  * `no`
  * `np`
  * `of`
  * `par`
  * `sml`
  * `w`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsModelSelection.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.modobsweights!-Tuple{Associative,Number}' href='#Mads.modobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modobsweights!`** &mdash; *Method*.



Modify (multiply) observation weights in the MADS problem dictionary

**Mads.modobsweights!**

Methods

  * `Mads.modobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:268

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `obskeys`
  * `value`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L262-L266' class='documenter-source'>source</a><br>

<a id='Mads.modwellweights!-Tuple{Associative,Number}' href='#Mads.modwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modwellweights!`** &mdash; *Method*.



Modify (multiply) well weights in the MADS problem dictionary

**Mads.modwellweights!**

Methods

  * `Mads.modwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:310

Arguments

  * `#temp#`
  * `i`
  * `k`
  * `madsdata`
  * `value`
  * `wellkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L304-L308' class='documenter-source'>source</a><br>

<a id='Mads.montecarlo-Tuple{Associative}' href='#Mads.montecarlo-Tuple{Associative}'>#</a>
**`Mads.montecarlo`** &mdash; *Method*.



Monte Carlo analysis

`Mads.montecarlo(madsdata; N=100)`

Arguments:

  * `madsdata` : MADS problem dictionary sampling uniformly between mins/maxs
  * `N` : number of samples (default = 100)

Returns:

  * `outputdicts` : parameter dictionary containing the data arrays

Dumps:

  * YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)

**Mads.montecarlo**

Methods

  * `Mads.montecarlo(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:174

Arguments

  * `madsdata`

Keywords

  * `N`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L153-L172' class='documenter-source'>source</a><br>

<a id='Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}' href='#Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}'>#</a>
**`Mads.naive_get_deltax`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: get the LM parameter space step

**Mads.naive_get_deltax**

Methods

  * `Mads.naive_get_deltax(JpJ::Array{Float64,2}, Jp::Array{Float64,2}, f0::Array{Float64,1}, lambda::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:258

Arguments

  * `#temp#`
  * `Jp`
  * `JpJ`
  * `deltax`
  * `f0`
  * `lambda`
  * `s`
  * `u`
  * `v`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L252-L256' class='documenter-source'>source</a><br>

<a id='Mads.naive_levenberg_marquardt' href='#Mads.naive_levenberg_marquardt'>#</a>
**`Mads.naive_levenberg_marquardt`** &mdash; *Function*.



Naive Levenberg-Marquardt optimization

Arguments:

  * `f` : forward model function
  * `g` : gradient function for the forward model
  * `x0` : initial parameter guess
  * `o` : objective function
  * `tolX` : parameter space tolerance
  * `tolG` : parameter space update tolerance
  * `tolOF` : objective function update tolerance
  * `maxEval` : maximum number of model evaluations
  * `maxIter` : maximum number of optimization iterations
  * `lambda` : initial Levenberg-Marquardt lambda [100]
  * `lambda_mu` : lambda multiplication factor μ [10]
  * `np_lambda` : number of parallel lambda solves

**Mads.naive_levenberg_marquardt**

Methods

  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:300
  * `Mads.naive_levenberg_marquardt(f::Function, g::Function, x0::Array{Float64,1}, o::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:300

Arguments

  * `#125`
  * `f`
  * `g`
  * `o`
  * `x0`

Keywords

  * `lambda`
  * `lambda_mu`
  * `maxEval`
  * `maxIter`
  * `np_lambda`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L279-L298' class='documenter-source'>source</a><br>

<a id='Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}' href='#Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}'>#</a>
**`Mads.naive_lm_iteration`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: perform LM iteration

**Mads.naive_lm_iteration**

Methods

  * `Mads.naive_lm_iteration(f::Function, g::Function, o::Function, x0::Array{Float64,1}, f0::Array{Float64,1}, lambdas::Array{Float64,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:269

Arguments

  * `#120`
  * `#121`
  * `J`
  * `Jp`
  * `JpJ`
  * `bestindex`
  * `deltaxs`
  * `f`
  * `f0`
  * `fs`
  * `g`
  * `lambdas`
  * `o`
  * `sses`
  * `x0`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L263-L267' class='documenter-source'>source</a><br>

<a id='Mads.noplot-Tuple{}' href='#Mads.noplot-Tuple{}'>#</a>
**`Mads.noplot`** &mdash; *Method*.



Disable MADS plotting

**Mads.noplot**

Methods

  * `Mads.noplot()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:240

Arguments

  * `#263`
  * `#265`
  * `#267`
  * `#temp#`
  * `i`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L234-L238' class='documenter-source'>source</a><br>

<a id='Mads.obslineismatch-Tuple{String,Array{Regex,1}}' href='#Mads.obslineismatch-Tuple{String,Array{Regex,1}}'>#</a>
**`Mads.obslineismatch`** &mdash; *Method*.



Match an instruction line in the Mads instruction file with model input file

**Mads.obslineismatch**

Methods

  * `Mads.obslineismatch(obsline::String, regexs::Array{Regex,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:701

Arguments

  * `#34`
  * `bigregex`
  * `obsline`
  * `regexs`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L695-L699' class='documenter-source'>source</a><br>

<a id='Mads.of-Tuple{Associative,Array{T,1}}' href='#Mads.of-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.of`** &mdash; *Method*.



Compute objective function

**Mads.of**

Methods

  * `Mads.of(madsdata::Associative, results::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:47

Arguments

  * `madsdata`
  * `r`
  * `results`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L41-L45' class='documenter-source'>source</a><br>

<a id='Mads.paramarray2dict-Tuple{Associative,Array}' href='#Mads.paramarray2dict-Tuple{Associative,Array}'>#</a>
**`Mads.paramarray2dict`** &mdash; *Method*.



Convert a parameter array to a parameter dictionary of arrays

**Mads.paramarray2dict**

Methods

  * `Mads.paramarray2dict(madsdata::Associative, array::Array)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:226

Arguments

  * `#temp#`
  * `array`
  * `dict`
  * `i`
  * `madsdata`
  * `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L220-L224' class='documenter-source'>source</a><br>

<a id='Mads.paramdict2array-Tuple{Associative}' href='#Mads.paramdict2array-Tuple{Associative}'>#</a>
**`Mads.paramdict2array`** &mdash; *Method*.



Convert a parameter dictionary of arrays to a parameter array

**Mads.paramdict2array**

Methods

  * `Mads.paramdict2array(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:240

Arguments

  * `#208`
  * `dict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L234-L238' class='documenter-source'>source</a><br>

<a id='Mads.parsemadsdata!-Tuple{Associative}' href='#Mads.parsemadsdata!-Tuple{Associative}'>#</a>
**`Mads.parsemadsdata!`** &mdash; *Method*.



Parse loaded Mads problem dictionary

Arguments:

  * `madsdata` : Mads problem dictionary

**Mads.parsemadsdata!**

Methods

  * `Mads.parsemadsdata!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:56

Arguments

  * `#temp#`
  * `dict`
  * `flag`
  * `i`
  * `instructions`
  * `k`
  * `key`
  * `madsdata`
  * `observations`
  * `parameters`
  * `templates`
  * `v`
  * `wells`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L46-L54' class='documenter-source'>source</a><br>

<a id='Mads.parsenodenames' href='#Mads.parsenodenames'>#</a>
**`Mads.parsenodenames`** &mdash; *Function*.



Parse string with node names defined in SLURM

**Mads.parsenodenames**

Methods

  * `Mads.parsenodenames(nodenames::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:209
  * `Mads.parsenodenames(nodenames::String, ntasks_per_node::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:209

Arguments

  * `#temp#`
  * `cm`
  * `d`
  * `e`
  * `f`
  * `h`
  * `i`
  * `j`
  * `l`
  * `n`
  * `name`
  * `nn`
  * `nodenames`
  * `ntasks_per_node`
  * `ss`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L203-L207' class='documenter-source'>source</a><br>

<a id='Mads.partialof-Tuple{Associative,Associative,Regex}' href='#Mads.partialof-Tuple{Associative,Associative,Regex}'>#</a>
**`Mads.partialof`** &mdash; *Method*.



Compute the sum of squared residuals for observations that match a regular expression

**Mads.partialof**

Methods

  * `Mads.partialof(madsdata::Associative, resultdict::Associative, regex::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:64

Arguments

  * `#temp#`
  * `madsdata`
  * `obskey`
  * `obskeys`
  * `regex`
  * `residuals`
  * `resultdict`
  * `results`
  * `targets`
  * `weights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L58-L62' class='documenter-source'>source</a><br>

<a id='Mads.plotgrid-Tuple{Associative,Array{Float64,N}}' href='#Mads.plotgrid-Tuple{Associative,Array{Float64,N}}'>#</a>
**`Mads.plotgrid`** &mdash; *Method*.



Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

```
plotgrid(madsdata, s; addtitle=true, title="", filename="", format="")
plotgrid(madsdata; addtitle=true, title="", filename="", format="")
plotgrid(madsdata, parameters; addtitle=true, title="", filename="", format="")
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `parameters` : dictionary with model parameters
  * `s` : model predictions array
  * `addtitle` : add plot title [true]
  * `title` : plot title
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.plotgrid**

Methods

  * `Mads.plotgrid(madsdata::Associative, s::Array{Float64,N<:Any})` : /Users/monty/.julia/v0.5/Mads/src/MadsPlotPy.jl:26

Arguments

  * `madsdata`
  * `s`

Keywords

  * `addtitle`
  * `filename`
  * `format`
  * `title`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlotPy.jl#L4-L24' class='documenter-source'>source</a><br>

<a id='Mads.plotmadsproblem-Tuple{Associative}' href='#Mads.plotmadsproblem-Tuple{Associative}'>#</a>
**`Mads.plotmadsproblem`** &mdash; *Method*.



Plot contaminant sources and wells defined in MADS problem dictionary

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : to be added in the filename

**Mads.plotmadsproblem**

Methods

  * `Mads.plotmadsproblem(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:77

Arguments

  * `madsdata`

Keywords

  * `filename`
  * `format`
  * `imagefile`
  * `keyword`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L64-L75' class='documenter-source'>source</a><br>

<a id='Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}' href='#Mads.plotmass-Tuple{Array{Float64,1},Array{Float64,1},Array{Float64,1},String}'>#</a>
**`Mads.plotmass`** &mdash; *Method*.



Plot injected/reduced contaminant mass

  * `Mads.plotmass(lambda, mass_injected, mass_reduced, filename="file_name")`

Arguments:

  * `lambda` : array with all the lambda values
  * `mass_injected` : array with associated total injected mass
  * `mass_reduced` : array with associated total reduced mass
  * `filename` : output filename for the generated plot
  * `format` : output plot format (`png`, `pdf`, etc.)

Dumps: image file with name `filename` and in specified `format`

**Mads.plotmass**

Methods

  * `Mads.plotmass(lambda::Array{Float64,1}, mass_injected::Array{Float64,1}, mass_reduced::Array{Float64,1}, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsAnasolPlot.jl:21

Arguments

  * `filename`
  * `lambda`
  * `mass_injected`
  * `mass_reduced`

Keywords

  * `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsAnasolPlot.jl#L3-L19' class='documenter-source'>source</a><br>

<a id='Mads.plotmatches' href='#Mads.plotmatches'>#</a>
**`Mads.plotmatches`** &mdash; *Function*.



Plot the matches between model predictions and observations

```
plotmatches(madsdata; filename="", format="")
plotmatches(madsdata, param; filename="", format="")
plotmatches(madsdata, result; filename="", format="")
plotmatches(madsdata, result, r"NO3"; filename="", format="")
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `param` : dictionary with model parameters
  * `result` : dictionary with model predictions
  * `rx` : regular expression to filter the outputs
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.plotmatches**

Methods

  * `Mads.plotmatches(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:169
  * `Mads.plotmatches(madsdata::Associative, rx::Regex)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:169

Arguments

  * `madsdata`
  * `rx`

Keywords

  * `filename`
  * `format`
  * `hsize`
  * `separate_files`
  * `title`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L147-L167' class='documenter-source'>source</a><br>

<a id='Mads.plotobsSAresults-Tuple{Associative,Associative}' href='#Mads.plotobsSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.plotobsSAresults`** &mdash; *Method*.



Plot the sensitivity analysis results for the observations

Arguments:

  * `madsdata` : MADS problem dictionary
  * `result` : sensitivity analysis results
  * `filter` : string or regex to plot only observations containing `filter`
  * `keyword` : to be added in the auto-generated filename
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.plotobsSAresults**

Methods

  * `Mads.plotobsSAresults(madsdata::Associative, result::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:501

Arguments

  * `madsdata`
  * `result`

Keywords

  * `debug`
  * `filename`
  * `filter`
  * `format`
  * `keyword`
  * `separate_files`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L486-L499' class='documenter-source'>source</a><br>

<a id='Mads.plotrobustnesscurves-Tuple{Associative,Dict}' href='#Mads.plotrobustnesscurves-Tuple{Associative,Dict}'>#</a>
**`Mads.plotrobustnesscurves`** &mdash; *Method*.



Plot BIG-DT robustness curves

Arguments:

  * `madsdata` : MADS problem dictionary
  * `bigdtresults` : BIG-DT results
  * `filename` : output file name used to dump plots
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.plotrobustnesscurves**

Methods

  * `Mads.plotrobustnesscurves(madsdata::Associative, bigdtresults::Dict)` : /Users/monty/.julia/v0.5/Mads/src/MadsBayesInfoGapPlot.jl:16

Arguments

  * `bigdtresults`
  * `madsdata`

Keywords

  * `filename`
  * `format`
  * `maxhoriz`
  * `maxprob`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsBayesInfoGapPlot.jl#L3-L14' class='documenter-source'>source</a><br>

<a id='Mads.plotseries' href='#Mads.plotseries'>#</a>
**`Mads.plotseries`** &mdash; *Function*.



Create plots of data series

Arguments:

  * `X` : matrix with the series data
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `xtitle` : x-axis title
  * `ytitle` : y-axis title
  * `title` : plot title
  * `name` : series name
  * `combined` : `true` by default

**Mads.plotseries**

Methods

  * `Mads.plotseries(X::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:987
  * `Mads.plotseries(X::Array{T<:Any,2}, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:987

Arguments

  * `X`
  * `filename`

Keywords

  * `combined`
  * `format`
  * `name`
  * `title`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L970-L985' class='documenter-source'>source</a><br>

<a id='Mads.plotwellSAresults-Tuple{Associative,Any}' href='#Mads.plotwellSAresults-Tuple{Associative,Any}'>#</a>
**`Mads.plotwellSAresults`** &mdash; *Method*.



Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

Arguments:

  * `madsdata` : MADS problem dictionary
  * `result` : sensitivity analysis results
  * `wellname` : well name
  * `xtitle` : x-axis title
  * `ytitle` : y-axis title
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.plotwellSAresults**

Methods

  * `Mads.plotwellSAresults(madsdata::Associative, result)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:390

Arguments

  * `madsdata`
  * `result`

Keywords

  * `filename`
  * `format`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L374-L388' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults-Tuple{Associative,Associative}' href='#Mads.printSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults`** &mdash; *Method*.



Print sensitivity analysis results

**Mads.printSAresults**

Methods

  * `Mads.printSAresults(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:776

Arguments

  * `##x#906`
  * `##x#907`
  * `#temp#`
  * `N`
  * `args`
  * `do_out`
  * `exp`
  * `len`
  * `madsdata`
  * `mes`
  * `neg`
  * `obskey`
  * `obskeys`
  * `out`
  * `paramkey`
  * `paramkeys`
  * `pt`
  * `results`
  * `sum`
  * `tes`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L770-L774' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults2-Tuple{Associative,Associative}' href='#Mads.printSAresults2-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults2`** &mdash; *Method*.



Print sensitivity analysis results (method 2)

**Mads.printSAresults2**

Methods

  * `Mads.printSAresults2(madsdata::Associative, results::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:856

Arguments

  * `#temp#`
  * `N`
  * `madsdata`
  * `mes`
  * `obskey`
  * `obskeys`
  * `paramkey`
  * `paramkeys`
  * `results`
  * `tes`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L850-L854' class='documenter-source'>source</a><br>

<a id='Mads.push' href='#Mads.push'>#</a>
**`Mads.push`** &mdash; *Function*.



Push the latest version of the Mads / Julia modules in the repo

**Mads.push**

Methods

  * `Mads.push(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:112
  * `Mads.push()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:112

Arguments

  * `#temp#`
  * `cwd`
  * `i`
  * `modulename`
  * `modulenames`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L106-L110' class='documenter-source'>source</a><br>

<a id='Mads.quietoff-Tuple{}' href='#Mads.quietoff-Tuple{}'>#</a>
**`Mads.quietoff`** &mdash; *Method*.



Make MADS not quiet

**Mads.quietoff**

Methods

  * `Mads.quietoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:44


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L38-L42' class='documenter-source'>source</a><br>

<a id='Mads.quieton-Tuple{}' href='#Mads.quieton-Tuple{}'>#</a>
**`Mads.quieton`** &mdash; *Method*.



Make MADS quiet

**Mads.quieton**

Methods

  * `Mads.quieton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:34


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L28-L32' class='documenter-source'>source</a><br>

<a id='Mads.readasciipredictions-Tuple{String}' href='#Mads.readasciipredictions-Tuple{String}'>#</a>
**`Mads.readasciipredictions`** &mdash; *Method*.



Read MADS predictions from an ASCII file

**Mads.readasciipredictions**

Methods

  * `Mads.readasciipredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsASCII.jl:26

Arguments

  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsASCII.jl#L20-L24' class='documenter-source'>source</a><br>

<a id='Mads.readjsonpredictions-Tuple{String}' href='#Mads.readjsonpredictions-Tuple{String}'>#</a>
**`Mads.readjsonpredictions`** &mdash; *Method*.



Read MADS model predictions from a JSON file

**Mads.readjsonpredictions**

Methods

  * `Mads.readjsonpredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsJSON.jl:37

Arguments

  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsJSON.jl#L31-L35' class='documenter-source'>source</a><br>

<a id='Mads.readmodeloutput-Tuple{Associative}' href='#Mads.readmodeloutput-Tuple{Associative}'>#</a>
**`Mads.readmodeloutput`** &mdash; *Method*.



Read model outputs saved for MADS

**Mads.readmodeloutput**

Methods

  * `Mads.readmodeloutput(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:534

Arguments

  * `madsdata`

Keywords

  * `obskeys`
  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L528-L532' class='documenter-source'>source</a><br>

<a id='Mads.readobservations' href='#Mads.readobservations'>#</a>
**`Mads.readobservations`** &mdash; *Function*.



Read observations

**Mads.readobservations**

Methods

  * `Mads.readobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:765
  * `Mads.readobservations(madsdata::Associative, obskeys::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:765

Arguments

  * `#temp#`
  * `c`
  * `instruction`
  * `k`
  * `madsdata`
  * `missing`
  * `obs`
  * `obscount`
  * `observations`
  * `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L759-L763' class='documenter-source'>source</a><br>

<a id='Mads.readobservations_cmads-Tuple{Associative}' href='#Mads.readobservations_cmads-Tuple{Associative}'>#</a>
**`Mads.readobservations_cmads`** &mdash; *Method*.



Read observations using C Mads library

**Mads.readobservations_cmads**

Methods

  * `Mads.readobservations_cmads(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/../src-old/MadsCMads.jl:9

Arguments

  * `#temp#`
  * `instruction`
  * `madsdata`
  * `obs`
  * `observations`
  * `obsid`
  * `obsids`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-old/MadsCMads.jl#L3-L7' class='documenter-source'>source</a><br>

<a id='Mads.readyamlpredictions-Tuple{String}' href='#Mads.readyamlpredictions-Tuple{String}'>#</a>
**`Mads.readyamlpredictions`** &mdash; *Method*.



Read MADS model predictions from a YAML file `filename`

**Mads.readyamlpredictions**

Methods

  * `Mads.readyamlpredictions(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsYAML.jl:118

Arguments

  * `filename`

Keywords

  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsYAML.jl#L112-L116' class='documenter-source'>source</a><br>

<a id='Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}' href='#Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}'>#</a>
**`Mads.regexs2obs`** &mdash; *Method*.



Get observations for a set of regular expressions

**Mads.regexs2obs**

Methods

  * `Mads.regexs2obs(obsline::String, regexs::Array{Regex,1}, obsnames::Array{String,1}, getparamhere::Array{Bool,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:711

Arguments

  * `#temp#`
  * `getparamhere`
  * `i`
  * `m`
  * `obsdict`
  * `obsline`
  * `obsnameindex`
  * `obsnames`
  * `offset`
  * `regexs`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L705-L709' class='documenter-source'>source</a><br>

<a id='Mads.reload-Tuple{}' href='#Mads.reload-Tuple{}'>#</a>
**`Mads.reload`** &mdash; *Method*.



Reload Mads modules

**Mads.reload**

Methods

  * `Mads.reload()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:34

Arguments

  * `#temp#`
  * `i`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsTest.jl#L28-L32' class='documenter-source'>source</a><br>

<a id='Mads.required' href='#Mads.required'>#</a>
**`Mads.required`** &mdash; *Function*.



Lists modules required by a module (Mads by default)

**Mads.required**

Methods

  * `Mads.required(modulename::String, filtermodule::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25
  * `Mads.required(modulename::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25
  * `Mads.required()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:25

Arguments

  * `filename`
  * `filtermodule`
  * `i`
  * `modulename`
  * `modules`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L19-L23' class='documenter-source'>source</a><br>

<a id='Mads.resetmodelruns-Tuple{}' href='#Mads.resetmodelruns-Tuple{}'>#</a>
**`Mads.resetmodelruns`** &mdash; *Method*.



Reset the model runs count to be equal to zero

**Mads.resetmodelruns**

Methods

  * `Mads.resetmodelruns()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:126


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L120-L124' class='documenter-source'>source</a><br>

<a id='Mads.residuals-Tuple{Associative,Array{T,1}}' href='#Mads.residuals-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.residuals`** &mdash; *Method*.



Compute residuals

**Mads.residuals**

Methods

  * `Mads.residuals(madsdata::Associative, results::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsLevenbergMarquardt.jl:11

Arguments

  * `index`
  * `isn`
  * `madsdata`
  * `maxs`
  * `mins`
  * `obskeys`
  * `residuals`
  * `results`
  * `rmax`
  * `rmin`
  * `ssdr`
  * `targets`
  * `weights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsLevenbergMarquardt.jl#L5-L9' class='documenter-source'>source</a><br>

<a id='Mads.restartoff-Tuple{}' href='#Mads.restartoff-Tuple{}'>#</a>
**`Mads.restartoff`** &mdash; *Method*.



MADS restart off

**Mads.restartoff**

Methods

  * `Mads.restartoff()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:16


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.restarton-Tuple{}' href='#Mads.restarton-Tuple{}'>#</a>
**`Mads.restarton`** &mdash; *Method*.



MADS restart on

**Mads.restarton**

Methods

  * `Mads.restarton()` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:7


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}' href='#Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}'>#</a>
**`Mads.reweighsamples`** &mdash; *Method*.



Reweigh samples using importance sampling – returns a vector of log-likelihoods after reweighing

Arguments:

  * `madsdata` : MADS problem dictionary
  * `predictions` : the model predictions for each of the samples
  * `oldllhoods` : the log likelihoods of the parameters in the old distribution

Returns:

  * `newllhoods` : vector of log-likelihoods after reweighing

**Mads.reweighsamples**

Methods

  * `Mads.reweighsamples(madsdata::Associative, predictions::Array, oldllhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:210

Arguments

  * `#temp#`
  * `j`
  * `madsdata`
  * `newllhoods`
  * `obskeys`
  * `okey`
  * `oldllhoods`
  * `predictions`
  * `targets`
  * `weights`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L194-L208' class='documenter-source'>source</a><br>

<a id='Mads.rmdir-Tuple{String}' href='#Mads.rmdir-Tuple{String}'>#</a>
**`Mads.rmdir`** &mdash; *Method*.



Remove directory

**Mads.rmdir**

Methods

  * `Mads.rmdir(dir::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:851

Arguments

  * `dir`

Keywords

  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L845-L849' class='documenter-source'>source</a><br>

<a id='Mads.rmfile-Tuple{String}' href='#Mads.rmfile-Tuple{String}'>#</a>
**`Mads.rmfile`** &mdash; *Method*.



Remove file

**Mads.rmfile**

Methods

  * `Mads.rmfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:865

Arguments

  * `filename`

Keywords

  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L859-L863' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_ext-Tuple{String}' href='#Mads.rmfiles_ext-Tuple{String}'>#</a>
**`Mads.rmfiles_ext`** &mdash; *Method*.



Remove files with extension `ext`

**Mads.rmfiles_ext**

Methods

  * `Mads.rmfiles_ext(ext::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:879

Arguments

  * `ext`

Keywords

  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L873-L877' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_root-Tuple{String}' href='#Mads.rmfiles_root-Tuple{String}'>#</a>
**`Mads.rmfiles_root`** &mdash; *Method*.



Remove files with root `root`

**Mads.rmfiles_root**

Methods

  * `Mads.rmfiles_root(root::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:890

Arguments

  * `root`

Keywords

  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L884-L888' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock-Tuple{Array{T,1}}' href='#Mads.rosenbrock-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock`** &mdash; *Method*.



Rosenbrock test function

**Mads.rosenbrock**

Methods

  * `Mads.rosenbrock(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:30

Arguments

  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L24-L28' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

**Mads.rosenbrock2_gradient_lm**

Methods

  * `Mads.rosenbrock2_gradient_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:16

Arguments

  * `j`
  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_lm`** &mdash; *Method*.



Rosenbrock test function (more difficult to solve)

**Mads.rosenbrock2_lm**

Methods

  * `Mads.rosenbrock2_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:7

Arguments

  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}' href='#Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient!`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function

**Mads.rosenbrock_gradient!**

Methods

  * `Mads.rosenbrock_gradient!(x::Array{T<:Any,1}, storage::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:48

Arguments

  * `storage`
  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L42-L46' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separetely)

**Mads.rosenbrock_gradient_lm**

Methods

  * `Mads.rosenbrock_gradient_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:58

Arguments

  * `x`

Keywords

  * `center`
  * `dx`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L52-L56' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}' href='#Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}'>#</a>
**`Mads.rosenbrock_hessian!`** &mdash; *Method*.



Parameter Hessian of the Rosenbrock test function

**Mads.rosenbrock_hessian!**

Methods

  * `Mads.rosenbrock_hessian!(x::Array{T<:Any,1}, storage::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:72

Arguments

  * `storage`
  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L66-L70' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_lm`** &mdash; *Method*.



Rosenbrock test function for LM optimization (returns the 2 components separetely)

**Mads.rosenbrock_lm**

Methods

  * `Mads.rosenbrock_lm(x::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsTestFunctions.jl:39

Arguments

  * `x`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsTestFunctions.jl#L33-L37' class='documenter-source'>source</a><br>

<a id='Mads.runcmd' href='#Mads.runcmd'>#</a>
**`Mads.runcmd`** &mdash; *Function*.



Run external command and pipe stdout and stderr

**Mads.runcmd**

Methods

  * `Mads.runcmd(cmd::Cmd, quiet::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:322
  * `Mads.runcmd(cmd::Cmd)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:322

Arguments

  * `#temp#`
  * `cmd`
  * `cmderr`
  * `cmdin`
  * `cmdout`
  * `cmdproc`
  * `erroutput`
  * `i`
  * `l`
  * `output`
  * `quiet`
  * `s`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L316-L320' class='documenter-source'>source</a><br>

<a id='Mads.runremote' href='#Mads.runremote'>#</a>
**`Mads.runremote`** &mdash; *Function*.



Run remote command on a series of servers

**Mads.runremote**

Methods

  * `Mads.runremote(cmd::String, nodenames::Array{String,1})` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:275
  * `Mads.runremote(cmd::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:275

Arguments

  * `#temp#`
  * `cmd`
  * `i`
  * `nodenames`
  * `o`
  * `output`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L269-L273' class='documenter-source'>source</a><br>

<a id='Mads.saltelli-Tuple{Associative}' href='#Mads.saltelli-Tuple{Associative}'>#</a>
**`Mads.saltelli`** &mdash; *Method*.



Saltelli sensitivity analysis

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `seed` : initial random seed
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `parallel` : set to true if the model runs should be performed in parallel

**Mads.saltelli**

Methods

  * `Mads.saltelli(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:509

Arguments

  * `N`
  * `checkpointfrequency`
  * `madsdata`
  * `parallel`
  * `restartdir`
  * `seed`

Keywords

  * `N`
  * `checkpointfrequency`
  * `parallel`
  * `restartdir`
  * `seed`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L495-L507' class='documenter-source'>source</a><br>

<a id='Mads.saltellibrute-Tuple{Associative}' href='#Mads.saltellibrute-Tuple{Associative}'>#</a>
**`Mads.saltellibrute`** &mdash; *Method*.



Saltelli sensitivity analysis (brute force)

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `seed` : initial random seed

**Mads.saltellibrute**

Methods

  * `Mads.saltellibrute(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:337

Arguments

  * `madsdata`

Keywords

  * `N`
  * `restartdir`
  * `seed`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L325-L335' class='documenter-source'>source</a><br>

<a id='Mads.saltellibruteparallel-Tuple{Associative,Integer}' href='#Mads.saltellibruteparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltellibruteparallel`** &mdash; *Method*.



Parallel version of saltellibrute


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L729' class='documenter-source'>source</a><br>

<a id='Mads.saltelliparallel-Tuple{Associative,Integer}' href='#Mads.saltelliparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltelliparallel`** &mdash; *Method*.



Parallel version of saltelli


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L729' class='documenter-source'>source</a><br>

<a id='Mads.savecalibrationresults-Tuple{Associative,Any}' href='#Mads.savecalibrationresults-Tuple{Associative,Any}'>#</a>
**`Mads.savecalibrationresults`** &mdash; *Method*.



Save calibration results

**Mads.savecalibrationresults**

Methods

  * `Mads.savecalibrationresults(madsdata::Associative, results)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:208

Arguments

  * `madsdata`
  * `results`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L199-L203' class='documenter-source'>source</a><br>

<a id='Mads.savemadsfile' href='#Mads.savemadsfile'>#</a>
**`Mads.savemadsfile`** &mdash; *Function*.



Save MADS problem dictionary `madsdata` in MADS input file `filename`

  * `Mads.savemadsfile(madsdata)`
  * `Mads.savemadsfile(madsdata, "test.mads")`
  * `Mads.savemadsfile(madsdata, parameters, "test.mads")`
  * `Mads.savemadsfile(madsdata, parameters, "test.mads", explicit=true)`

Arguments:

  * `madsdata` : Mads problem dictionary
  * `parameters` : Dictinary with parameters (optional)
  * `filename` : input file name (e.g. `input_file_name.mads`)
  * `julia` : if `true` use Julia JSON module to save
  * `explicit` : if `true` ignores MADS YAML file modifications and rereads the original input file

**Mads.savemadsfile**

Methods

  * `Mads.savemadsfile(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:169
  * `Mads.savemadsfile(madsdata::Associative, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:169

Arguments

  * `filename`
  * `madsdata`

Keywords

  * `explicit`
  * `julia`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L150-L167' class='documenter-source'>source</a><br>

<a id='Mads.savemcmcresults-Tuple{Array,String}' href='#Mads.savemcmcresults-Tuple{Array,String}'>#</a>
**`Mads.savemcmcresults`** &mdash; *Method*.



Save MCMC chain in a file

**Mads.savemcmcresults**

Methods

  * `Mads.savemcmcresults(chain::Array, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsMonteCarlo.jl:131

Arguments

  * `chain`
  * `f`
  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMonteCarlo.jl#L125-L129' class='documenter-source'>source</a><br>

<a id='Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}' href='#Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}'>#</a>
**`Mads.scatterplotsamples`** &mdash; *Method*.



Create histogram/scatter plots of model parameter samples

Arguments:

  * `madsdata` : MADS problem dictionary
  * `samples` : matrix with model parameters
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.scatterplotsamples**

Methods

  * `Mads.scatterplotsamples(madsdata::Associative, samples::Array{T<:Any,2}, filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:339

Arguments

  * `filename`
  * `madsdata`
  * `samples`

Keywords

  * `dot_size`
  * `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L326-L337' class='documenter-source'>source</a><br>

<a id='Mads.searchdir-Tuple{Regex}' href='#Mads.searchdir-Tuple{Regex}'>#</a>
**`Mads.searchdir`** &mdash; *Method*.



Get files in the current directory or in a directory defined by `path` matching pattern `key` which can be a string or regular expression

  * `Mads.searchdir("a")`
  * `Mads.searchdir(r"[A-B]"; path = ".")`
  * `Mads.searchdir(r".*.cov"; path = ".")`

Arguments:

  * `key` : matching pattern for Mads input files (string or regular expression accepted)
  * `path` : search directory for the mads input files

Returns:

  * `filename` : an array with file names matching the pattern in the specified directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L562-L577' class='documenter-source'>source</a><br>

<a id='Mads.set_nprocs_per_task' href='#Mads.set_nprocs_per_task'>#</a>
**`Mads.set_nprocs_per_task`** &mdash; *Function*.



Set number of processors needed for each parallel task at each node

**Mads.set_nprocs_per_task**

Methods

  * `Mads.set_nprocs_per_task()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:59
  * `Mads.set_nprocs_per_task(local_nprocs_per_task::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:59

Arguments

  * `local_nprocs_per_task`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L53-L57' class='documenter-source'>source</a><br>

<a id='Mads.setallparamsoff!-Tuple{Associative}' href='#Mads.setallparamsoff!-Tuple{Associative}'>#</a>
**`Mads.setallparamsoff!`** &mdash; *Method*.



Set all parameters OFF

**Mads.setallparamsoff!**

Methods

  * `Mads.setallparamsoff!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:406

Arguments

  * `madsdata`

Keywords

  * `filter`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L400-L404' class='documenter-source'>source</a><br>

<a id='Mads.setallparamson!-Tuple{Associative}' href='#Mads.setallparamson!-Tuple{Associative}'>#</a>
**`Mads.setallparamson!`** &mdash; *Method*.



Set all parameters ON

**Mads.setallparamson!**

Methods

  * `Mads.setallparamson!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:394

Arguments

  * `madsdata`

Keywords

  * `filter`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L388-L392' class='documenter-source'>source</a><br>

<a id='Mads.setdebuglevel-Tuple{Int64}' href='#Mads.setdebuglevel-Tuple{Int64}'>#</a>
**`Mads.setdebuglevel`** &mdash; *Method*.



Set MADS debug level

**Mads.setdebuglevel**

Methods

  * `Mads.setdebuglevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:108

Arguments

  * `level`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L102-L106' class='documenter-source'>source</a><br>

<a id='Mads.setdefaultplotformat-Tuple{String}' href='#Mads.setdefaultplotformat-Tuple{String}'>#</a>
**`Mads.setdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)

**Mads.setdefaultplotformat**

Methods

  * `Mads.setdefaultplotformat(format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:15

Arguments

  * `format`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L9-L13' class='documenter-source'>source</a><br>

<a id='Mads.setdir-Tuple{Any}' href='#Mads.setdir-Tuple{Any}'>#</a>
**`Mads.setdir`** &mdash; *Method*.



Set the working directory (for parallel environments)

```
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```

**Mads.setdir**

Methods

  * `Mads.setdir(dir)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:260

Arguments

  * `dir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L249-L258' class='documenter-source'>source</a><br>

<a id='Mads.setdynamicmodel-Tuple{Associative,Function}' href='#Mads.setdynamicmodel-Tuple{Associative,Function}'>#</a>
**`Mads.setdynamicmodel`** &mdash; *Method*.



Set Dynamic Model for MADS model calls using internal Julia functions

**Mads.setdynamicmodel**

Methods

  * `Mads.setdynamicmodel(madsdata::Associative, f::Function)` : /Users/monty/.julia/v0.5/Mads/src/MadsMisc.jl:105

Arguments

  * `f`
  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L99-L103' class='documenter-source'>source</a><br>

<a id='Mads.setmadsinputfile-Tuple{String}' href='#Mads.setmadsinputfile-Tuple{String}'>#</a>
**`Mads.setmadsinputfile`** &mdash; *Method*.



Set a default MADS input file

`Mads.setmadsinputfile(filename)`

Arguments:

  * `filename` : input file name (e.g. `input_file_name.mads`)

**Mads.setmadsinputfile**

Methods

  * `Mads.setmadsinputfile(filename::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:222

Arguments

  * `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L210-L220' class='documenter-source'>source</a><br>

<a id='Mads.setmodelinputs-Tuple{Associative,Associative}' href='#Mads.setmodelinputs-Tuple{Associative,Associative}'>#</a>
**`Mads.setmodelinputs`** &mdash; *Method*.



Set model input files; delete files where model output should be saved for MADS

**Mads.setmodelinputs**

Methods

  * `Mads.setmodelinputs(madsdata::Associative, parameters::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:468

Arguments

  * `madsdata`
  * `parameters`

Keywords

  * `path`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L462-L466' class='documenter-source'>source</a><br>

<a id='Mads.setnewmadsfilename-Tuple{Associative}' href='#Mads.setnewmadsfilename-Tuple{Associative}'>#</a>
**`Mads.setnewmadsfilename`** &mdash; *Method*.



Set new mads file name

**Mads.setnewmadsfilename**

Methods

  * `Mads.setnewmadsfilename(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:352

Arguments

  * `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L346-L350' class='documenter-source'>source</a><br>

<a id='Mads.setobservationtargets!-Tuple{Associative,Associative}' href='#Mads.setobservationtargets!-Tuple{Associative,Associative}'>#</a>
**`Mads.setobservationtargets!`** &mdash; *Method*.



Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary

**Mads.setobservationtargets!**

Methods

  * `Mads.setobservationtargets!(madsdata::Associative, predictions::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:416

Arguments

  * `#temp#`
  * `i`
  * `k`
  * `madsdata`
  * `observationsdict`
  * `predictions`
  * `well`
  * `wellsdict`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L410-L414' class='documenter-source'>source</a><br>

<a id='Mads.setobstime!' href='#Mads.setobstime!'>#</a>
**`Mads.setobstime!`** &mdash; *Function*.



Set observation time based on the observation name in the MADS problem dictionary

Usage:

```
Mads.setobstime!(madsdata, separator)
Mads.setobstime!(madsdata, regex)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `separator` : string to separator
  * `regex` : regular expression to match

Examples:

```
Mads.setobstime!(madsdata, "_t")
Mads.setobstime!(madsdata, r"[A-x]*_t([0-9,.]+)")
```

**Mads.setobstime!**

Methods

  * `Mads.setobstime!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:228
  * `Mads.setobstime!(madsdata::Associative, separator::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:228

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `obskeys`
  * `s`
  * `separator`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L203-L226' class='documenter-source'>source</a><br>

<a id='Mads.setobsweights!-Tuple{Associative,Number}' href='#Mads.setobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setobsweights!`** &mdash; *Method*.



Set observation weights in the MADS problem dictionary

**Mads.setobsweights!**

Methods

  * `Mads.setobsweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:256

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `obskeys`
  * `value`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L250-L254' class='documenter-source'>source</a><br>

<a id='Mads.setparamoff!-Tuple{Associative,String}' href='#Mads.setparamoff!-Tuple{Associative,String}'>#</a>
**`Mads.setparamoff!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` OFF

**Mads.setparamoff!**

Methods

  * `Mads.setparamoff!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:427

Arguments

  * `madsdata`
  * `parameterkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L421-L425' class='documenter-source'>source</a><br>

<a id='Mads.setparamon!-Tuple{Associative,String}' href='#Mads.setparamon!-Tuple{Associative,String}'>#</a>
**`Mads.setparamon!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` ON

**Mads.setparamon!**

Methods

  * `Mads.setparamon!(madsdata::Associative, parameterkey::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:418

Arguments

  * `madsdata`
  * `parameterkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L412-L416' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistnormal!`** &mdash; *Method*.



Set normal parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistnormal!(madsdata, mean, stddev)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `mean` : array with the mean values
  * `stddev` : array with the standard deviation values

**Mads.setparamsdistnormal!**

Methods

  * `Mads.setparamsdistnormal!(madsdata::Associative, mean::Array{T<:Any,1}, stddev::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:444

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `mean`
  * `paramkeys`
  * `stddev`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L430-L442' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistuniform!`** &mdash; *Method*.



Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistuniform!(madsdata, min, max)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `min` : array with the minimum values
  * `max` : array with the maximum values

**Mads.setparamsdistuniform!**

Methods

  * `Mads.setparamsdistuniform!(madsdata::Associative, min::Array{T<:Any,1}, max::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:464

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `max`
  * `min`
  * `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L450-L462' class='documenter-source'>source</a><br>

<a id='Mads.setparamsinit!-Tuple{Associative,Associative}' href='#Mads.setparamsinit!-Tuple{Associative,Associative}'>#</a>
**`Mads.setparamsinit!`** &mdash; *Method*.



Set initial parameter guesses in the MADS dictionary

`Mads.setparamsinit!(madsdata, paramdict)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramdict` : dictionary with initial model parameter values

**Mads.setparamsinit!**

Methods

  * `Mads.setparamsinit!(madsdata::Associative, paramdict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:322

Arguments

  * `#temp#`
  * `i`
  * `madsdata`
  * `paramdict`
  * `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L309-L320' class='documenter-source'>source</a><br>

<a id='Mads.setplotfileformat-Tuple{String,String}' href='#Mads.setplotfileformat-Tuple{String,String}'>#</a>
**`Mads.setplotfileformat`** &mdash; *Method*.



Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

`Mads.setplotfileformat(filename::String, format::String)`

Arguments:

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

Returns:

  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)

**Mads.setplotfileformat**

Methods

  * `Mads.setplotfileformat(filename::String, format::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:40

Arguments

  * `extension`
  * `filename`
  * `format`
  * `root`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L22-L38' class='documenter-source'>source</a><br>

<a id='Mads.setprocs-Tuple{Integer,Integer}' href='#Mads.setprocs-Tuple{Integer,Integer}'>#</a>
**`Mads.setprocs`** &mdash; *Method*.



Set the number of processors to `np` and the number of threads to `nt`

Usage:

```
Mads.setprocs(4)
Mads.setprocs(4, 8)
```

Arguments:

  * `np` : number of processors
  * `nt` : number of threads

**Mads.setprocs**

Methods

  * `Mads.setprocs(np::Integer, nt::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:36

Arguments

  * `#temp#`
  * `n`
  * `np`
  * `nt`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L19-L34' class='documenter-source'>source</a><br>

<a id='Mads.setprocs-Tuple{}' href='#Mads.setprocs-Tuple{}'>#</a>
**`Mads.setprocs`** &mdash; *Method*.



Set the available processors based on environmental variables. Supports SLURM only at the moment.

Usage:

```
Mads.setprocs()
Mads.setprocs(ntasks_per_node=4)
Mads.setprocs(ntasks_per_node=32, mads_servers=true)
Mads.setprocs(ntasks_per_node=64, nodenames=["madsmax", "madszem"])
Mads.setprocs(ntasks_per_node=64, nodenames="wc[096-157,160,175]")
Mads.setprocs(ntasks_per_node=64, mads_servers=true, exename="/home/monty/bin/julia", dir="/home/monty")
```

Optional arguments:

  * `ntasks_per_node` : number of parallel tasks per
  * `nprocs_per_task` : number of processors needed for each parallel task at each node
  * `nodenames` : array with names of machines/nodes to be invoked
  * `dir` : common directory shared by all the jobs
  * `exename` : location of the julia executable (the same version of julia is needed on all the workers)
  * `mads_servers` : if `true` use MADS servers (LANL only)
  * `quiet` : suppress output [default `true`]
  * `test` : test the servers and connect to each one ones at a time [default `false`]

**Mads.setprocs**

Methods

  * `Mads.setprocs()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:95
  * `Mads.setprocs(np::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:50
  * `Mads.setprocs(np::Integer, nt::Integer)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsParallel.jl:36

Arguments

  * `#temp#`
  * `n`
  * `np`
  * `nt`

Keywords

  * `dir`
  * `exename`
  * `mads_servers`
  * `nodenames`
  * `nprocs_per_task`
  * `ntasks_per_node`
  * `quiet`
  * `test`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsParallel.jl#L67-L93' class='documenter-source'>source</a><br>

<a id='Mads.setseed-Tuple{Integer}' href='#Mads.setseed-Tuple{Integer}'>#</a>
**`Mads.setseed`** &mdash; *Method*.



Set current seed

**Mads.setseed**

Methods

  * `Mads.setseed(seed::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:20

Arguments

  * `s`
  * `seed`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L14-L18' class='documenter-source'>source</a><br>

<a id='Mads.settarget!-Tuple{Associative,Number}' href='#Mads.settarget!-Tuple{Associative,Number}'>#</a>
**`Mads.settarget!`** &mdash; *Method*.



Set observation target

**Mads.settarget!**

Methods

  * `Mads.settarget!(o::Associative, target::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:194

Arguments

  * `o`
  * `target`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L188-L192' class='documenter-source'>source</a><br>

<a id='Mads.settime!-Tuple{Associative,Number}' href='#Mads.settime!-Tuple{Associative,Number}'>#</a>
**`Mads.settime!`** &mdash; *Method*.



Set observation time

**Mads.settime!**

Methods

  * `Mads.settime!(o::Associative, time::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:130

Arguments

  * `o`
  * `time`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L124-L128' class='documenter-source'>source</a><br>

<a id='Mads.setverbositylevel-Tuple{Int64}' href='#Mads.setverbositylevel-Tuple{Int64}'>#</a>
**`Mads.setverbositylevel`** &mdash; *Method*.



Set MADS verbosity level

**Mads.setverbositylevel**

Methods

  * `Mads.setverbositylevel(level::Int64)` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:117

Arguments

  * `level`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L111-L115' class='documenter-source'>source</a><br>

<a id='Mads.setweight!-Tuple{Associative,Number}' href='#Mads.setweight!-Tuple{Associative,Number}'>#</a>
**`Mads.setweight!`** &mdash; *Method*.



Set observation weight

**Mads.setweight!**

Methods

  * `Mads.setweight!(o::Associative, weight::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:162

Arguments

  * `o`
  * `weight`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L156-L160' class='documenter-source'>source</a><br>

<a id='Mads.setwellweights!-Tuple{Associative,Number}' href='#Mads.setwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setwellweights!`** &mdash; *Method*.



Set well weights in the MADS problem dictionary

**Mads.setwellweights!**

Methods

  * `Mads.setwellweights!(madsdata::Associative, value::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:295

Arguments

  * `#temp#`
  * `i`
  * `k`
  * `madsdata`
  * `value`
  * `wellkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L289-L293' class='documenter-source'>source</a><br>

<a id='Mads.showallparameters-Tuple{Associative}' href='#Mads.showallparameters-Tuple{Associative}'>#</a>
**`Mads.showallparameters`** &mdash; *Method*.



Show all parameters in the MADS problem dictionary

**Mads.showallparameters**

Methods

  * `Mads.showallparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:542

Arguments

  * `##i#866`
  * `##i#868`
  * `##i#870`
  * `##i#872`
  * `##x#865`
  * `##x#867`
  * `##x#869`
  * `##x#871`
  * `##x#873`
  * `##x#874`
  * `##x#875`
  * `#temp#`
  * `args`
  * `do_f`
  * `do_out`
  * `endidx`
  * `exp`
  * `fprec`
  * `len`
  * `madsdata`
  * `neg`
  * `out`
  * `p`
  * `padding`
  * `padn`
  * `pardict`
  * `parkey`
  * `parkeys`
  * `pt`
  * `s`
  * `tmpout`
  * `tmpstr`
  * `width`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L536-L540' class='documenter-source'>source</a><br>

<a id='Mads.showobservations-Tuple{Associative}' href='#Mads.showobservations-Tuple{Associative}'>#</a>
**`Mads.showobservations`** &mdash; *Method*.



Show observations in the MADS problem dictionary

**Mads.showobservations**

Methods

  * `Mads.showobservations(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:343

Arguments

  * `##i#877`
  * `##i#879`
  * `##i#881`
  * `##i#883`
  * `##i#885`
  * `##i#887`
  * `##i#889`
  * `##i#891`
  * `##x#876`
  * `##x#878`
  * `##x#880`
  * `##x#882`
  * `##x#884`
  * `##x#886`
  * `##x#888`
  * `##x#890`
  * `#temp#`
  * `args`
  * `do_f`
  * `do_out`
  * `endidx`
  * `exp`
  * `fprec`
  * `len`
  * `madsdata`
  * `neg`
  * `obsdict`
  * `obskey`
  * `obskeys`
  * `out`
  * `p`
  * `padding`
  * `padn`
  * `pt`
  * `s`
  * `t`
  * `tmpout`
  * `tmpstr`
  * `w`
  * `width`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L337-L341' class='documenter-source'>source</a><br>

<a id='Mads.showparameters-Tuple{Associative}' href='#Mads.showparameters-Tuple{Associative}'>#</a>
**`Mads.showparameters`** &mdash; *Method*.



Show optimizable parameters in the MADS problem dictionary

**Mads.showparameters**

Methods

  * `Mads.showparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsParameters.jl:507

Arguments

  * `##i#855`
  * `##i#857`
  * `##i#859`
  * `##i#861`
  * `##x#854`
  * `##x#856`
  * `##x#858`
  * `##x#860`
  * `##x#862`
  * `##x#863`
  * `##x#864`
  * `#temp#`
  * `args`
  * `do_f`
  * `do_out`
  * `endidx`
  * `exp`
  * `fprec`
  * `len`
  * `madsdata`
  * `neg`
  * `out`
  * `p`
  * `padding`
  * `padn`
  * `pardict`
  * `parkey`
  * `parkeys`
  * `pt`
  * `s`
  * `tmpout`
  * `tmpstr`
  * `width`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsParameters.jl#L501-L505' class='documenter-source'>source</a><br>

<a id='Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransform`** &mdash; *Method*.



Sine transformation of model parameters

**Mads.sinetransform**

Methods

  * `Mads.sinetransform(sineparams::Array{T<:Any,1}, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:19

Arguments

  * `indexlogtransformed`
  * `lowerbounds`
  * `params`
  * `sineparams`
  * `upperbounds`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSineTransformations.jl#L13-L17' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformfunction`** &mdash; *Method*.



Sine transformation of a function

**Mads.sinetransformfunction**

Methods

  * `Mads.sinetransformfunction(f::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:30

Arguments

  * `f`
  * `indexlogtransformed`
  * `lowerbounds`
  * `sinetransformedf`
  * `upperbounds`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSineTransformations.jl#L24-L28' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformgradient`** &mdash; *Method*.



Sine transformation of a gradient function

**Mads.sinetransformgradient**

Methods

  * `Mads.sinetransformgradient(g::Function, lowerbounds::Array{T<:Any,1}, upperbounds::Array{T<:Any,1}, indexlogtransformed::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSineTransformations.jl:42

Arguments

  * `g`
  * `indexlogtransformed`
  * `lowerbounds`
  * `upperbounds`

Keywords

  * `sindx`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSineTransformations.jl#L36-L40' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplot-Tuple{Associative,Integer}' href='#Mads.spaghettiplot-Tuple{Associative,Integer}'>#</a>
**`Mads.spaghettiplot`** &mdash; *Method*.



Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

```
Mads.spaghettiplot(madsdata, paramdictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, obsmdictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramdictarray` : parameter dictionary array containing the data arrays to be plotted
  * `obsdictarray` : observation dictionary array containing the data arrays to be plotted
  * `number_of_samples` : number of samples
  * `filename` : output file name used to output the produced plots
  * `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `xtitle` : `x` axis title
  * `ytitle` : `y` axis title
  * `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)
  * `seed` : initial random seed

Returns: `none`

Dumps:

  * Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

**Mads.spaghettiplot**

Methods

  * `Mads.spaghettiplot(madsdata::Associative, number_of_samples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:828

Arguments

  * `madsdata`
  * `number_of_samples`

Keywords

  * `filename`
  * `format`
  * `keyword`
  * `obs_plot_dots`
  * `seed`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L796-L826' class='documenter-source'>source</a><br>

<a id='Mads.spaghettiplots-Tuple{Associative,Integer}' href='#Mads.spaghettiplots-Tuple{Associative,Integer}'>#</a>
**`Mads.spaghettiplots`** &mdash; *Method*.



Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

```
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramdictarray` : parameter dictionary containing the data arrays to be plotted
  * `number_of_samples` : number of samples
  * `keyword` : keyword to be added in the file name used to output the produced plots
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `xtitle` : `x` axis title
  * `ytitle` : `y` axis title
  * `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)
  * `seed` : initial random seed

Dumps:

  * A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

**Mads.spaghettiplots**

Methods

  * `Mads.spaghettiplots(madsdata::Associative, number_of_samples::Integer)` : /Users/monty/.julia/v0.5/Mads/src/MadsPlot.jl:685

Arguments

  * `madsdata`
  * `number_of_samples`

Keywords

  * `format`
  * `keyword`
  * `obs_plot_dots`
  * `seed`
  * `xtitle`
  * `ytitle`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsPlot.jl#L658-L683' class='documenter-source'>source</a><br>

<a id='Mads.sphericalcov-Tuple{Number,Number,Number}' href='#Mads.sphericalcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.sphericalcov`** &mdash; *Method*.



Spherical spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L7' class='documenter-source'>source</a><br>

<a id='Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.sphericalvariogram`** &mdash; *Method*.



Spherical variogram

**Mads.sphericalvariogram**

Methods

  * `Mads.sphericalvariogram(h::Number, sill::Number, range::Number, nugget::Number)` : /Users/monty/.julia/v0.5/Mads/src/MadsKriging.jl:16

Arguments

  * `h`
  * `nugget`
  * `range`
  * `sill`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsKriging.jl#L10-L14' class='documenter-source'>source</a><br>

<a id='Mads.sprintf-Tuple' href='#Mads.sprintf-Tuple'>#</a>
**`Mads.sprintf`** &mdash; *Method*.



Convert `@sprintf` macro into `sprintf` function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsMisc.jl#L138' class='documenter-source'>source</a><br>

<a id='Mads.status-Tuple{}' href='#Mads.status-Tuple{}'>#</a>
**`Mads.status`** &mdash; *Method*.



Status of the Mads modules

**Mads.status**

Methods

  * `Mads.status()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:178

Keywords

  * `git`
  * `gitmore`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L172-L176' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureoff-Tuple{}' href='#Mads.stdoutcaptureoff-Tuple{}'>#</a>
**`Mads.stdoutcaptureoff`** &mdash; *Method*.



Restore STDOUT


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSTDOUT.jl#L12-L14' class='documenter-source'>source</a><br>

<a id='Mads.stdoutcaptureon-Tuple{}' href='#Mads.stdoutcaptureon-Tuple{}'>#</a>
**`Mads.stdoutcaptureon`** &mdash; *Method*.



Redirect STDOUT to a reader


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSTDOUT.jl#L1-L3' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdir-Tuple{String,String}' href='#Mads.symlinkdir-Tuple{String,String}'>#</a>
**`Mads.symlinkdir`** &mdash; *Method*.



Create a symbolic link of a file `filename` in a directory `dirtarget`

**Mads.symlinkdir**

Methods

  * `Mads.symlinkdir(filename::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:839

Arguments

  * `#temp#`
  * `dirtarget`
  * `filename`
  * `filenametarget`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L833-L837' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdirfiles-Tuple{String,String}' href='#Mads.symlinkdirfiles-Tuple{String,String}'>#</a>
**`Mads.symlinkdirfiles`** &mdash; *Method*.



Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`

**Mads.symlinkdirfiles**

Methods

  * `Mads.symlinkdirfiles(dirsource::String, dirtarget::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:823

Arguments

  * `#temp#`
  * `dirsource`
  * `dirtarget`
  * `f`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L817-L821' class='documenter-source'>source</a><br>

<a id='Mads.tag' href='#Mads.tag'>#</a>
**`Mads.tag`** &mdash; *Function*.



Tag the Mads modules with a default argument `:patch`

**Mads.tag**

Methods

  * `Mads.tag(sym::Symbol)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:231
  * `Mads.tag()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsPublish.jl:231

Arguments

  * `#temp#`
  * `i`
  * `sym`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsPublish.jl#L225-L229' class='documenter-source'>source</a><br>

<a id='Mads.test' href='#Mads.test'>#</a>
**`Mads.test`** &mdash; *Function*.



Perform Mads tests (the tests will be in parallel if processors are defined; tests use the current Mads version in the workspace; `reload("Mads.jl")` if needed)

**Mads.test**

Methods

  * `Mads.test(testname::String)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:48
  * `Mads.test()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:48

Arguments

  * `testname` : name of the test to execute (module or example)

Keywords

  * `madstest` : test Mads [default=`true`])
  * `moduletest` : test modules [default=`false`])


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsTest.jl#L40-L44' class='documenter-source'>source</a><br>

<a id='Mads.testj' href='#Mads.testj'>#</a>
**`Mads.testj`** &mdash; *Function*.



Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)

**Mads.testj**

Methods

  * `Mads.testj(coverage::Bool)` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:7
  * `Mads.testj()` : /Users/monty/.julia/v0.5/Mads/src/../src-interactive/MadsTest.jl:7

Arguments

  * `#temp#`
  * `coverage`
  * `i`
  * `orig_dir`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/../src-interactive/MadsTest.jl#L1-L5' class='documenter-source'>source</a><br>

<a id='Mads.transposematrix-Tuple{Array{T,2}}' href='#Mads.transposematrix-Tuple{Array{T,2}}'>#</a>
**`Mads.transposematrix`** &mdash; *Method*.



Transpose non-numeric matrix

**Mads.transposematrix**

Methods

  * `Mads.transposematrix(a::Array{T<:Any,2})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:248

Arguments

  * `a`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L242-L246' class='documenter-source'>source</a><br>

<a id='Mads.transposevector-Tuple{Array{T,1}}' href='#Mads.transposevector-Tuple{Array{T,1}}'>#</a>
**`Mads.transposevector`** &mdash; *Method*.



Transpose non-numeric vector

**Mads.transposevector**

Methods

  * `Mads.transposevector(a::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsHelpers.jl:239

Arguments

  * `a`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsHelpers.jl#L233-L237' class='documenter-source'>source</a><br>

<a id='Mads.void2nan!-Tuple{Associative}' href='#Mads.void2nan!-Tuple{Associative}'>#</a>
**`Mads.void2nan!`** &mdash; *Method*.



Convert Void's into NaN's in a dictionary

**Mads.void2nan!**

Methods

  * `Mads.void2nan!(dict::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:895

Arguments

  * `#temp#`
  * `dict`
  * `i`
  * `j`
  * `k`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L889-L893' class='documenter-source'>source</a><br>

<a id='Mads.weightedstats-Tuple{Array,Array{T,1}}' href='#Mads.weightedstats-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.weightedstats`** &mdash; *Method*.



Get weighted mean and variance samples

Arguments:

  * `samples` : array of samples
  * `llhoods` : vector of log-likelihoods

Returns:

  * `mean` : vector of sample means
  * `var` : vector of sample variances

**Mads.weightedstats**

Methods

  * `Mads.weightedstats(samples::Array, llhoods::Array{T<:Any,1})` : /Users/monty/.julia/v0.5/Mads/src/MadsSenstivityAnalysis.jl:273

Arguments

  * `llhoods`
  * `samples`
  * `wv`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsSenstivityAnalysis.jl#L257-L271' class='documenter-source'>source</a><br>

<a id='Mads.welloff!-Tuple{Associative,String}' href='#Mads.welloff!-Tuple{Associative,String}'>#</a>
**`Mads.welloff!`** &mdash; *Method*.



Turn off a specific well in the MADS problem dictionary

**Mads.welloff!**

Methods

  * `Mads.welloff!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:480

Arguments

  * `#temp#`
  * `error`
  * `madsdata`
  * `wellkey`
  * `wellname`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L474-L478' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{Associative,String}' href='#Mads.wellon!-Tuple{Associative,String}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary

**Mads.wellon!**

Methods

  * `Mads.wellon!(madsdata::Associative, wellname::String)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:448

Arguments

  * `#temp#`
  * `error`
  * `madsdata`
  * `wellkey`
  * `wellname`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L442-L446' class='documenter-source'>source</a><br>

<a id='Mads.wells2observations!-Tuple{Associative}' href='#Mads.wells2observations!-Tuple{Associative}'>#</a>
**`Mads.wells2observations!`** &mdash; *Method*.



Convert `Wells` class to `Observations` class in the MADS problem dictionary

**Mads.wells2observations!**

Methods

  * `Mads.wells2observations!(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsObservations.jl:500

Arguments

  * `#temp#`
  * `data`
  * `datakey`
  * `i`
  * `madsdata`
  * `observations`
  * `obskey`
  * `t`
  * `target`
  * `wellkey`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsObservations.jl#L494-L498' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters-Tuple{Associative}' href='#Mads.writeparameters-Tuple{Associative}'>#</a>
**`Mads.writeparameters`** &mdash; *Method*.



Write initial parameters (inital if parameter set not provided

**Mads.writeparameters**

Methods

  * `Mads.writeparameters(madsdata::Associative)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:639

Arguments

  * `madsdata`
  * `paramkeys`
  * `paramsinit`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L633-L637' class='documenter-source'>source</a><br>

<a id='Mads.writeparametersviatemplate-Tuple{Any,Any,Any}' href='#Mads.writeparametersviatemplate-Tuple{Any,Any,Any}'>#</a>
**`Mads.writeparametersviatemplate`** &mdash; *Method*.



Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)

**Mads.writeparametersviatemplate**

Methods

  * `Mads.writeparametersviatemplate(parameters, templatefilename, outputfilename)` : /Users/monty/.julia/v0.5/Mads/src/MadsIO.jl:599

Arguments

  * `outputfilename`
  * `parameters`
  * `templatefilename`

Keywords

  * `respect_space`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/949b1f508ee98255b815f0c6feb24622468081ce/src/MadsIO.jl#L593-L597' class='documenter-source'>source</a><br>

