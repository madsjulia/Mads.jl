
<a id='Mads.jl-1'></a>

# Mads.jl


Documentation for Mads.jl

<a id='Mads.MFlm-Tuple{Array{T,2},Integer}' href='#Mads.MFlm-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.MFlm`** &mdash; *Method*.



Matrix Factorization via Levenberg Marquardt


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-new/MadsBSS.jl#L68' class='documenter-source'>source</a><br>

<a id='Mads.NMFipopt-Tuple{Array{T,2},Integer}' href='#Mads.NMFipopt-Tuple{Array{T,2},Integer}'>#</a>
**`Mads.NMFipopt`** &mdash; *Method*.



Non-negative Matrix Factorization using JuMP/Ipopt


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-new/MadsBSS.jl#L26' class='documenter-source'>source</a><br>

<a id='Mads.NMFm-Tuple{Array,Integer}' href='#Mads.NMFm-Tuple{Array,Integer}'>#</a>
**`Mads.NMFm`** &mdash; *Method*.



Non-negative Matrix Factorization using NMF


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-new/MadsBSS.jl#L6' class='documenter-source'>source</a><br>

<a id='Mads.addkeyword!-Tuple{Associative,String}' href='#Mads.addkeyword!-Tuple{Associative,String}'>#</a>
**`Mads.addkeyword!`** &mdash; *Method*.



Add a `keyword` in a `class` within the Mads dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L110' class='documenter-source'>source</a><br>

<a id='Mads.addsource!' href='#Mads.addsource!'>#</a>
**`Mads.addsource!`** &mdash; *Function*.



Add an additional contamination source


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L5' class='documenter-source'>source</a><br>

<a id='Mads.addsourceparameters!-Tuple{Associative}' href='#Mads.addsourceparameters!-Tuple{Associative}'>#</a>
**`Mads.addsourceparameters!`** &mdash; *Method*.



Add contaminant source parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L24' class='documenter-source'>source</a><br>

<a id='Mads.allwellsoff!-Tuple{Associative}' href='#Mads.allwellsoff!-Tuple{Associative}'>#</a>
**`Mads.allwellsoff!`** &mdash; *Method*.



Turn off all the wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L376' class='documenter-source'>source</a><br>

<a id='Mads.allwellson!-Tuple{Associative}' href='#Mads.allwellson!-Tuple{Associative}'>#</a>
**`Mads.allwellson!`** &mdash; *Method*.



Turn on all the wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L352' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-external/MadsSimulators.jl#L1-L13' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-external/MadsParsers.jl#L3-L18' class='documenter-source'>source</a><br>

<a id='Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.asinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.asinetransform`** &mdash; *Method*.



Arcsine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSineTransformations.jl#L1' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L65-L85' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsCalibrate.jl#L106-L131' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsCalibrate.jl#L3-L32' class='documenter-source'>source</a><br>

<a id='Mads.checkmodeloutputdirs-Tuple{Associative}' href='#Mads.checkmodeloutputdirs-Tuple{Associative}'>#</a>
**`Mads.checkmodeloutputdirs`** &mdash; *Method*.



Check the directories where model outputs should be saved for MADS


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L343' class='documenter-source'>source</a><br>

<a id='Mads.checkout' href='#Mads.checkout'>#</a>
**`Mads.checkout`** &mdash; *Function*.



Checkout the latest version of the Mads / Julia modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L47' class='documenter-source'>source</a><br>

<a id='Mads.checkparameterranges-Tuple{Associative}' href='#Mads.checkparameterranges-Tuple{Associative}'>#</a>
**`Mads.checkparameterranges`** &mdash; *Method*.



Check parameter ranges for model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L549' class='documenter-source'>source</a><br>

<a id='Mads.cleancoverage-Tuple{}' href='#Mads.cleancoverage-Tuple{}'>#</a>
**`Mads.cleancoverage`** &mdash; *Method*.



Remove Mads coverage files


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsTest.jl#L10' class='documenter-source'>source</a><br>

<a id='Mads.cmadsins_obs-Tuple{Array{T,1},String,String}' href='#Mads.cmadsins_obs-Tuple{Array{T,1},String,String}'>#</a>
**`Mads.cmadsins_obs`** &mdash; *Method*.



Call C MADS ins_obs() function from the MADS dynamic library


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-old/MadsCMads.jl#L17' class='documenter-source'>source</a><br>

<a id='Mads.commit' href='#Mads.commit'>#</a>
**`Mads.commit`** &mdash; *Function*.



Commit the latest version of the Mads / Julia modules in the repo


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L122' class='documenter-source'>source</a><br>

<a id='Mads.computemass-Tuple{Associative}' href='#Mads.computemass-Tuple{Associative}'>#</a>
**`Mads.computemass`** &mdash; *Method*.



Compute injected/reduced contaminant mass

`Mads.computemass(madsdata; time = 0)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `time` : computational time

Returns:

  * `mass_injected` : total injected mass
  * `mass_reduced` : total reduced mass


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L222-L236' class='documenter-source'>source</a><br>

<a id='Mads.computemass-Tuple{Union{Regex,String}}' href='#Mads.computemass-Tuple{Union{Regex,String}}'>#</a>
**`Mads.computemass`** &mdash; *Method*.



Compute injected/reduced contaminant mass for a given set of mads input files

`Mads.computemass(madsfiles; time=0, path=".")`

Arguments:

  * `madsfiles` : matching pattern for Mads input files (string or regular expression accepted)
  * `time` : computational time
  * `path` : search directory for the mads input files

Returns:

  * `lambda` : array with all the lambda values
  * `mass_injected` : array with associated total injected mass
  * `mass_reduced` : array with associated total reduced mass


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L279-L295' class='documenter-source'>source</a><br>

<a id='Mads.computeparametersensitities-Tuple{Associative,Associative}' href='#Mads.computeparametersensitities-Tuple{Associative,Associative}'>#</a>
**`Mads.computeparametersensitities`** &mdash; *Method*.



Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

Arguments:

  * `madsdata` : MADS problem dictionary
  * `saresults` : sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L672-L679' class='documenter-source'>source</a><br>

<a id='Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}' href='#Mads.contamination-Tuple{Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number,Number}'>#</a>
**`Mads.contamination`** &mdash; *Method*.



Compute concentration for a point in space and time (x,y,z,t)

`Mads.contamination(wellx, welly, wellz, n, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction="long_bbb_ddd_iir_c")`

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L160-L195' class='documenter-source'>source</a><br>

<a id='Mads.copyright-Tuple{}' href='#Mads.copyright-Tuple{}'>#</a>
**`Mads.copyright`** &mdash; *Method*.



Produce MADS copyright information


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelp.jl#L8' class='documenter-source'>source</a><br>

<a id='Mads.create_documentation-Tuple{}' href='#Mads.create_documentation-Tuple{}'>#</a>
**`Mads.create_documentation`** &mdash; *Method*.



Create web documentation files for Mads functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L213' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_off-Tuple{}' href='#Mads.create_tests_off-Tuple{}'>#</a>
**`Mads.create_tests_off`** &mdash; *Method*.



Turn off the generation of MADS tests (default)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L41' class='documenter-source'>source</a><br>

<a id='Mads.create_tests_on-Tuple{}' href='#Mads.create_tests_on-Tuple{}'>#</a>
**`Mads.create_tests_on`** &mdash; *Method*.



Turn on the generation of MADS tests (dangerous)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L36' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsCreate.jl#L4-L18' class='documenter-source'>source</a><br>

<a id='Mads.createobservations!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.createobservations!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.createobservations!`** &mdash; *Method*.



Create observations in the MADS problem dictionary based on `time` and `observation` vectors


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L292' class='documenter-source'>source</a><br>

<a id='Mads.createtempdir-Tuple{String}' href='#Mads.createtempdir-Tuple{String}'>#</a>
**`Mads.createtempdir`** &mdash; *Method*.



Create temporary directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L771' class='documenter-source'>source</a><br>

<a id='Mads.deleteNaN!-Tuple{DataFrames.DataFrame}' href='#Mads.deleteNaN!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.deleteNaN!`** &mdash; *Method*.



Delete rows with NaN in a Dataframe `df`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L881' class='documenter-source'>source</a><br>

<a id='Mads.dependents' href='#Mads.dependents'>#</a>
**`Mads.dependents`** &mdash; *Function*.



Lists modules dependents on a module (Mads by default)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L33' class='documenter-source'>source</a><br>

<a id='Mads.display-Tuple{String}' href='#Mads.display-Tuple{String}'>#</a>
**`Mads.display`** &mdash; *Method*.



Display image file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsDisplay.jl#L3-L5' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsBayesInfoGap.jl#L109-L123' class='documenter-source'>source</a><br>

<a id='Mads.dumpasciifile-Tuple{String,Any}' href='#Mads.dumpasciifile-Tuple{String,Any}'>#</a>
**`Mads.dumpasciifile`** &mdash; *Method*.



Dump ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsASCII.jl#L7' class='documenter-source'>source</a><br>

<a id='Mads.dumpjsonfile-Tuple{String,Any}' href='#Mads.dumpjsonfile-Tuple{String,Any}'>#</a>
**`Mads.dumpjsonfile`** &mdash; *Method*.



Dump a JSON file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsJSON.jl#L16' class='documenter-source'>source</a><br>

<a id='Mads.dumpwelldata-Tuple{Associative,String}' href='#Mads.dumpwelldata-Tuple{Associative,String}'>#</a>
**`Mads.dumpwelldata`** &mdash; *Method*.



Dump well data from MADS problem dictionary into a ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L691' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlfile-Tuple{String,Any}' href='#Mads.dumpyamlfile-Tuple{String,Any}'>#</a>
**`Mads.dumpyamlfile`** &mdash; *Method*.



Dump YAML file

Arguments:

  * `filename` : file name
  * `yamldata` : YAML data


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsYAML.jl#L27-L34' class='documenter-source'>source</a><br>

<a id='Mads.dumpyamlmadsfile-Tuple{Any,String}' href='#Mads.dumpyamlmadsfile-Tuple{Any,String}'>#</a>
**`Mads.dumpyamlmadsfile`** &mdash; *Method*.



Dump YAML Mads file

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsYAML.jl#L46-L53' class='documenter-source'>source</a><br>

<a id='Mads.efast-Tuple{Associative}' href='#Mads.efast-Tuple{Associative}'>#</a>
**`Mads.efast`** &mdash; *Method*.



Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `M` : maximum number of harmonics
  * `gamma` : multiplication factor (Saltelli 1999 recommends gamma = 2 or 4)
  * `seed` : initial random seed


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L907-L917' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L8-L31' class='documenter-source'>source</a><br>

<a id='Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}' href='#Mads.estimationerror-Tuple{Array{T,1},Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.estimationerror`** &mdash; *Method*.



Estimate kriging error


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L88' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpression-Tuple{String,Associative}' href='#Mads.evaluatemadsexpression-Tuple{String,Associative}'>#</a>
**`Mads.evaluatemadsexpression`** &mdash; *Method*.



Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L92' class='documenter-source'>source</a><br>

<a id='Mads.evaluatemadsexpressions-Tuple{Associative,Associative}' href='#Mads.evaluatemadsexpressions-Tuple{Associative,Associative}'>#</a>
**`Mads.evaluatemadsexpressions`** &mdash; *Method*.



Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L101' class='documenter-source'>source</a><br>

<a id='Mads.expcov-Tuple{Number,Number,Number}' href='#Mads.expcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.expcov`** &mdash; *Method*.



Exponential spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L4' class='documenter-source'>source</a><br>

<a id='Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.exponentialvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.exponentialvariogram`** &mdash; *Method*.



Exponential variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L21' class='documenter-source'>source</a><br>

<a id='Mads.filterkeys-Tuple{Associative,Regex}' href='#Mads.filterkeys-Tuple{Associative,Regex}'>#</a>
**`Mads.filterkeys`** &mdash; *Method*.



Filter dictionary keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L514' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsForward.jl#L5-L21' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsForward.jl#L114-L128' class='documenter-source'>source</a><br>

<a id='Mads.free' href='#Mads.free'>#</a>
**`Mads.free`** &mdash; *Function*.



Free Mads / Julia modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L104' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelp.jl#L13-L29' class='documenter-source'>source</a><br>

<a id='Mads.gaussiancov-Tuple{Number,Number,Number}' href='#Mads.gaussiancov-Tuple{Number,Number,Number}'>#</a>
**`Mads.gaussiancov`** &mdash; *Method*.



Gaussian spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.gaussianvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.gaussianvariogram`** &mdash; *Method*.



Gaussian variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L30' class='documenter-source'>source</a><br>

<a id='Mads.getcovmat-Tuple{Array{T,2},Function}' href='#Mads.getcovmat-Tuple{Array{T,2},Function}'>#</a>
**`Mads.getcovmat`** &mdash; *Method*.



Get spatial covariance matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L61' class='documenter-source'>source</a><br>

<a id='Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}' href='#Mads.getcovvec!-Tuple{Array,Array{T,1},Array{T,2},Function}'>#</a>
**`Mads.getcovvec!`** &mdash; *Method*.



Get spatial covariance vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L75' class='documenter-source'>source</a><br>

<a id='Mads.getdictvalues-Tuple{Associative,Regex}' href='#Mads.getdictvalues-Tuple{Associative,Regex}'>#</a>
**`Mads.getdictvalues`** &mdash; *Method*.



Get dictionary values for keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L522' class='documenter-source'>source</a><br>

<a id='Mads.getdir-Tuple{String}' href='#Mads.getdir-Tuple{String}'>#</a>
**`Mads.getdir`** &mdash; *Method*.



Get directory

Example:

```
d = Mads.getdir("a.mads") # d = "."
d = Mads.getdir("test/a.mads") # d = "test"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L325-L334' class='documenter-source'>source</a><br>

<a id='Mads.getdistribution-Tuple{String,String,String}' href='#Mads.getdistribution-Tuple{String,String,String}'>#</a>
**`Mads.getdistribution`** &mdash; *Method*.



Parse distribution from a string


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L117' class='documenter-source'>source</a><br>

<a id='Mads.getextension-Tuple{String}' href='#Mads.getextension-Tuple{String}'>#</a>
**`Mads.getextension`** &mdash; *Method*.



Get file name extension

Example:

```
ext = Mads.getextension("a.mads") # ext = "mads"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L306-L314' class='documenter-source'>source</a><br>

<a id='Mads.getimportantsamples-Tuple{Array,Array{T,1}}' href='#Mads.getimportantsamples-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.getimportantsamples`** &mdash; *Method*.



Get important samples

Arguments:

  * `samples` : array of samples
  * `llhoods` : vector of log-likelihoods

Returns:

  * `imp_samples` : array of important samples


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L216-L227' class='documenter-source'>source</a><br>

<a id='Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L400' class='documenter-source'>source</a><br>

<a id='Mads.getmadsdir-Tuple{}' href='#Mads.getmadsdir-Tuple{}'>#</a>
**`Mads.getmadsdir`** &mdash; *Method*.



Get the directory where currently Mads is running

`problemdir = Mads.getmadsdir()`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L259-L263' class='documenter-source'>source</a><br>

<a id='Mads.getmadsinputfile-Tuple{}' href='#Mads.getmadsinputfile-Tuple{}'>#</a>
**`Mads.getmadsinputfile`** &mdash; *Method*.



Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

`Mads.getmadsinputfile()`

Arguments: `none`

Returns:

  * `filename` : input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L213-L223' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L237-L250' class='documenter-source'>source</a><br>

<a id='Mads.getmadsrootname-Tuple{Associative}' href='#Mads.getmadsrootname-Tuple{Associative}'>#</a>
**`Mads.getmadsrootname`** &mdash; *Method*.



Get the MADS problem root name

`madsrootname = Mads.getmadsrootname(madsdata)`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L228-L232' class='documenter-source'>source</a><br>

<a id='Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonlogparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonlogparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT log-transformed (`log`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L400' class='documenter-source'>source</a><br>

<a id='Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getnonoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getnonoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are NOT optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L400' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative,Any}' href='#Mads.getobsdist-Tuple{Associative,Any}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsdist-Tuple{Associative}' href='#Mads.getobsdist-Tuple{Associative}'>#</a>
**`Mads.getobsdist`** &mdash; *Method*.



Get an array with `dist` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobskeys-Tuple{Associative}' href='#Mads.getobskeys-Tuple{Associative}'>#</a>
**`Mads.getobskeys`** &mdash; *Method*.



Get keys for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L21' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative,Any}' href='#Mads.getobslog-Tuple{Associative,Any}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobslog-Tuple{Associative}' href='#Mads.getobslog-Tuple{Associative}'>#</a>
**`Mads.getobslog`** &mdash; *Method*.



Get an array with `log` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative,Any}' href='#Mads.getobsmax-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsmax-Tuple{Associative}' href='#Mads.getobsmax-Tuple{Associative}'>#</a>
**`Mads.getobsmax`** &mdash; *Method*.



Get an array with `max` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative,Any}' href='#Mads.getobsmin-Tuple{Associative,Any}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsmin-Tuple{Associative}' href='#Mads.getobsmin-Tuple{Associative}'>#</a>
**`Mads.getobsmin`** &mdash; *Method*.



Get an array with `min` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative,Any}' href='#Mads.getobstarget-Tuple{Associative,Any}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobstarget-Tuple{Associative}' href='#Mads.getobstarget-Tuple{Associative}'>#</a>
**`Mads.getobstarget`** &mdash; *Method*.



Get an array with `target` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative,Any}' href='#Mads.getobstime-Tuple{Associative,Any}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobstime-Tuple{Associative}' href='#Mads.getobstime-Tuple{Associative}'>#</a>
**`Mads.getobstime`** &mdash; *Method*.



Get an array with `time` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative,Any}' href='#Mads.getobsweight-Tuple{Associative,Any}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for observations in the MADS problem dictionary defined by `obskeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getobsweight-Tuple{Associative}' href='#Mads.getobsweight-Tuple{Associative}'>#</a>
**`Mads.getobsweight`** &mdash; *Method*.



Get an array with `weight` values for all observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}' href='#Mads.getoptparamkeys-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getoptparamkeys`** &mdash; *Method*.



Get the keys in the MADS problem dictionary for parameters that are optimized (`opt`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L400' class='documenter-source'>source</a><br>

<a id='Mads.getoptparams-Tuple{Associative}' href='#Mads.getoptparams-Tuple{Associative}'>#</a>
**`Mads.getoptparams`** &mdash; *Method*.



Get optimizable parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L284' class='documenter-source'>source</a><br>

<a id='Mads.getparamdict-Tuple{Associative}' href='#Mads.getparamdict-Tuple{Associative}'>#</a>
**`Mads.getparamdict`** &mdash; *Method*.



Get dictionary with all parameters and their respective initial values

`Mads.getparamdict(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `paramdict` : dictionary with all parameters and their respective initial values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L40-L52' class='documenter-source'>source</a><br>

<a id='Mads.getparamdistributions-Tuple{Associative}' href='#Mads.getparamdistributions-Tuple{Associative}'>#</a>
**`Mads.getparamdistributions`** &mdash; *Method*.



Get probabilistic distributions of all parameters in the MADS problem dictionary

`Mads.getparamdistributions(madsdata; init_dist=false)`

Note:

Probabilistic distribution of parameters can be defined only if `dist` or `min`/`max` model parameter fields are specified in the MADS problem dictionary `madsdata`.

Arguments:

  * `madsdata` : MADS problem dictionary
  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L496-L509' class='documenter-source'>source</a><br>

<a id='Mads.getparamkeys-Tuple{Associative}' href='#Mads.getparamkeys-Tuple{Associative}'>#</a>
**`Mads.getparamkeys`** &mdash; *Method*.



Get keys of all parameters in the MADS dictionary

`Mads.getparamkeys(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `paramkeys` : array with the keys of all parameters in the MADS dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L21-L33' class='documenter-source'>source</a><br>

<a id='Mads.getparamrandom' href='#Mads.getparamrandom'>#</a>
**`Mads.getparamrandom`** &mdash; *Function*.



Get independent sampling of model parameters defined in the MADS problem dictionary

Arguments:

  * `madsdata` : MADS problem dictionary
  * `numsamples` : number of samples
  * `parameterkey` : model parameter key
  * `init_dist` : if `true` use the distribution defined for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); else use the regular distribution defined in the MADS problem dictionary (defined using `dist` parameter field)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L267-L276' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit-Tuple{Associative}' href='#Mads.getparamsinit-Tuple{Associative}'>#</a>
**`Mads.getparamsinit`** &mdash; *Method*.



Get an array with `init` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit_max-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Method*.



Get an array with `init_max` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L226' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_max-Tuple{Associative}' href='#Mads.getparamsinit_max-Tuple{Associative}'>#</a>
**`Mads.getparamsinit_max`** &mdash; *Method*.



Get an array with `init_max` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L261' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsinit_min-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Method*.



Get an array with `init_min` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L185' class='documenter-source'>source</a><br>

<a id='Mads.getparamsinit_min-Tuple{Associative}' href='#Mads.getparamsinit_min-Tuple{Associative}'>#</a>
**`Mads.getparamsinit_min`** &mdash; *Method*.



Get an array with `init_min` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L220' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslog-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamslog-Tuple{Associative}' href='#Mads.getparamslog-Tuple{Associative}'>#</a>
**`Mads.getparamslog`** &mdash; *Method*.



Get an array with `log` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamslongname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamslongname-Tuple{Associative}' href='#Mads.getparamslongname-Tuple{Associative}'>#</a>
**`Mads.getparamslongname`** &mdash; *Method*.



Get an array with `longname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsmax-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsmax`** &mdash; *Method*.



Get an array with `max` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L156' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmax-Tuple{Associative}' href='#Mads.getparamsmax-Tuple{Associative}'>#</a>
**`Mads.getparamsmax`** &mdash; *Method*.



Get an array with `min` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L179' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsmin-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsmin`** &mdash; *Method*.



Get an array with `min` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L127' class='documenter-source'>source</a><br>

<a id='Mads.getparamsmin-Tuple{Associative}' href='#Mads.getparamsmin-Tuple{Associative}'>#</a>
**`Mads.getparamsmin`** &mdash; *Method*.



Get an array with `min` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L150' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsplotname-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsplotname-Tuple{Associative}' href='#Mads.getparamsplotname-Tuple{Associative}'>#</a>
**`Mads.getparamsplotname`** &mdash; *Method*.



Get an array with `plotname` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative,Array{T,1}}' href='#Mads.getparamsstep-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamsstep-Tuple{Associative}' href='#Mads.getparamsstep-Tuple{Associative}'>#</a>
**`Mads.getparamsstep`** &mdash; *Method*.



Get an array with `step` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative,Array{T,1}}' href='#Mads.getparamstype-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for parameters defined by `paramkeys`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getparamstype-Tuple{Associative}' href='#Mads.getparamstype-Tuple{Associative}'>#</a>
**`Mads.getparamstype`** &mdash; *Method*.



Get an array with `type` values for all the MADS model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L95' class='documenter-source'>source</a><br>

<a id='Mads.getprocs-Tuple{}' href='#Mads.getprocs-Tuple{}'>#</a>
**`Mads.getprocs`** &mdash; *Method*.



Get the number of processors


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L10' class='documenter-source'>source</a><br>

<a id='Mads.getrestart-Tuple{Associative}' href='#Mads.getrestart-Tuple{Associative}'>#</a>
**`Mads.getrestart`** &mdash; *Method*.



Get MADS restart status


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L11' class='documenter-source'>source</a><br>

<a id='Mads.getrestartdir' href='#Mads.getrestartdir'>#</a>
**`Mads.getrestartdir`** &mdash; *Function*.



Get the directory where Mads restarts will be stored.


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L221-L223' class='documenter-source'>source</a><br>

<a id='Mads.getrootname-Tuple{String}' href='#Mads.getrootname-Tuple{String}'>#</a>
**`Mads.getrootname`** &mdash; *Method*.



Get file name root

Example:

```
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L278-L287' class='documenter-source'>source</a><br>

<a id='Mads.getsindx-Tuple{Associative}' href='#Mads.getsindx-Tuple{Associative}'>#</a>
**`Mads.getsindx`** &mdash; *Method*.



Get sin-space dx


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L129' class='documenter-source'>source</a><br>

<a id='Mads.getsourcekeys-Tuple{Associative}' href='#Mads.getsourcekeys-Tuple{Associative}'>#</a>
**`Mads.getsourcekeys`** &mdash; *Method*.



Get keys of all source parameters in the MADS dictionary

`Mads.getsourcekeys(madsdata)`

Arguments:

  * `madsdata` : MADS problem dictionary

Returns:

  * `sourcekeys` : array with keys of all source parameters in the MADS dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L61-L73' class='documenter-source'>source</a><br>

<a id='Mads.gettarget-Tuple{Associative}' href='#Mads.gettarget-Tuple{Associative}'>#</a>
**`Mads.gettarget`** &mdash; *Method*.



Get observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L139' class='documenter-source'>source</a><br>

<a id='Mads.gettargetkeys-Tuple{Associative}' href='#Mads.gettargetkeys-Tuple{Associative}'>#</a>
**`Mads.gettargetkeys`** &mdash; *Method*.



Get keys for all targets (observations with weights greater than zero) in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L26' class='documenter-source'>source</a><br>

<a id='Mads.gettime-Tuple{Associative}' href='#Mads.gettime-Tuple{Associative}'>#</a>
**`Mads.gettime`** &mdash; *Method*.



Get observation time


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L91' class='documenter-source'>source</a><br>

<a id='Mads.getweight-Tuple{Associative}' href='#Mads.getweight-Tuple{Associative}'>#</a>
**`Mads.getweight`** &mdash; *Method*.



Get observation weight


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L115' class='documenter-source'>source</a><br>

<a id='Mads.getwellkeys-Tuple{Associative}' href='#Mads.getwellkeys-Tuple{Associative}'>#</a>
**`Mads.getwellkeys`** &mdash; *Method*.



Get keys for all wells in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L34' class='documenter-source'>source</a><br>

<a id='Mads.getwellsdata-Tuple{Associative}' href='#Mads.getwellsdata-Tuple{Associative}'>#</a>
**`Mads.getwellsdata`** &mdash; *Method*.



Get `Wells` class spatial and temporal data


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L428' class='documenter-source'>source</a><br>

<a id='Mads.graphoff-Tuple{}' href='#Mads.graphoff-Tuple{}'>#</a>
**`Mads.graphoff`** &mdash; *Method*.



MADS graph output off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L31' class='documenter-source'>source</a><br>

<a id='Mads.graphon-Tuple{}' href='#Mads.graphon-Tuple{}'>#</a>
**`Mads.graphon`** &mdash; *Method*.



MADS graph output on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L26' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L71-L89' class='documenter-source'>source</a><br>

<a id='Mads.help-Tuple{}' href='#Mads.help-Tuple{}'>#</a>
**`Mads.help`** &mdash; *Method*.



Produce MADS help information


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelp.jl#L3' class='documenter-source'>source</a><br>

<a id='Mads.importeverywhere-Tuple{String}' href='#Mads.importeverywhere-Tuple{String}'>#</a>
**`Mads.importeverywhere`** &mdash; *Method*.



Import function everywhere from a file. The first function in the file is the one that will be called by Mads to perform the model simulations.


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L264-L267' class='documenter-source'>source</a><br>

<a id='Mads.indexkeys-Tuple{Associative,Regex}' href='#Mads.indexkeys-Tuple{Associative,Regex}'>#</a>
**`Mads.indexkeys`** &mdash; *Method*.



Find indexes for dictionary keys based on a string or regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L518' class='documenter-source'>source</a><br>

<a id='Mads.ins_obs-Tuple{String,String}' href='#Mads.ins_obs-Tuple{String,String}'>#</a>
**`Mads.ins_obs`** &mdash; *Method*.



Apply Mads instruction file `instructionfilename` to read model input file `inputfilename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L636' class='documenter-source'>source</a><br>

<a id='Mads.instline2regexs-Tuple{String}' href='#Mads.instline2regexs-Tuple{String}'>#</a>
**`Mads.instline2regexs`** &mdash; *Method*.



Convert an instruction line in the Mads instruction file into regular expressions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L571' class='documenter-source'>source</a><br>

<a id='Mads.invobsweights!-Tuple{Associative,Number}' href='#Mads.invobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invobsweights!`** &mdash; *Method*.



Inversely proportional observation weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L224' class='documenter-source'>source</a><br>

<a id='Mads.invwellweights!-Tuple{Associative,Number}' href='#Mads.invwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.invwellweights!`** &mdash; *Method*.



Inversely proportional observation weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L257' class='documenter-source'>source</a><br>

<a id='Mads.islog-Tuple{Associative,String}' href='#Mads.islog-Tuple{Associative,String}'>#</a>
**`Mads.islog`** &mdash; *Method*.



Is parameter with key `parameterkey` log-transformed?


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L323' class='documenter-source'>source</a><br>

<a id='Mads.isobs-Tuple{Associative,Associative}' href='#Mads.isobs-Tuple{Associative,Associative}'>#</a>
**`Mads.isobs`** &mdash; *Method*.



Is a dictionary containing all the observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L4' class='documenter-source'>source</a><br>

<a id='Mads.isopt-Tuple{Associative,String}' href='#Mads.isopt-Tuple{Associative,String}'>#</a>
**`Mads.isopt`** &mdash; *Method*.



Is parameter with key `parameterkey` optimizable?


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L313' class='documenter-source'>source</a><br>

<a id='Mads.isparam-Tuple{Associative,Associative}' href='#Mads.isparam-Tuple{Associative,Associative}'>#</a>
**`Mads.isparam`** &mdash; *Method*.



Is the dictionary containing all the parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L4' class='documenter-source'>source</a><br>

<a id='Mads.ispkgavailable-Tuple{String}' href='#Mads.ispkgavailable-Tuple{String}'>#</a>
**`Mads.ispkgavailable`** &mdash; *Method*.



Checks of package is available


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L5' class='documenter-source'>source</a><br>

<a id='Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}' href='#Mads.krige-Tuple{Array,Array{T,2},Array{T,1},Function}'>#</a>
**`Mads.krige`** &mdash; *Method*.



Kriging


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L39' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L285-L308' class='documenter-source'>source</a><br>

<a id='Mads.linktempdir-Tuple{String,String}' href='#Mads.linktempdir-Tuple{String,String}'>#</a>
**`Mads.linktempdir`** &mdash; *Method*.



Link files in a temporary directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L793' class='documenter-source'>source</a><br>

<a id='Mads.loadasciifile-Tuple{String}' href='#Mads.loadasciifile-Tuple{String}'>#</a>
**`Mads.loadasciifile`** &mdash; *Method*.



Load ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsASCII.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.loadjsonfile-Tuple{String}' href='#Mads.loadjsonfile-Tuple{String}'>#</a>
**`Mads.loadjsonfile`** &mdash; *Method*.



Load a JSON file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsJSON.jl#L4' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L3-L20' class='documenter-source'>source</a><br>

<a id='Mads.loadyamlfile-Tuple{String}' href='#Mads.loadyamlfile-Tuple{String}'>#</a>
**`Mads.loadyamlfile`** &mdash; *Method*.



Load YAML file

Arguments:

  * `filename` : file name
  * `julia=false` : use Python YAML library (if available)
  * `julia=true` : use Julia YAML library (if available)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsYAML.jl#L5-L13' class='documenter-source'>source</a><br>

<a id='Mads.localsa-Tuple{Associative}' href='#Mads.localsa-Tuple{Associative}'>#</a>
**`Mads.localsa`** &mdash; *Method*.



Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `par` : parameter set
  * `obs` : observations for the parameter set


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L25-L35' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_off-Tuple{}' href='#Mads.long_tests_off-Tuple{}'>#</a>
**`Mads.long_tests_off`** &mdash; *Method*.



Turn off execution of long MADS tests (default)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L51' class='documenter-source'>source</a><br>

<a id='Mads.long_tests_on-Tuple{}' href='#Mads.long_tests_on-Tuple{}'>#</a>
**`Mads.long_tests_on`** &mdash; *Method*.



Turn on execution of long MADS tests (dangerous)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L46' class='documenter-source'>source</a><br>

<a id='Mads.madscores' href='#Mads.madscores'>#</a>
**`Mads.madscores`** &mdash; *Function*.



Check the number of processors on a series of servers


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L269-L271' class='documenter-source'>source</a><br>

<a id='Mads.madscritical-Tuple{String}' href='#Mads.madscritical-Tuple{String}'>#</a>
**`Mads.madscritical`** &mdash; *Method*.



MADS critical error messages


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L39' class='documenter-source'>source</a><br>

<a id='Mads.madsdebug' href='#Mads.madsdebug'>#</a>
**`Mads.madsdebug`** &mdash; *Function*.



MADS debug messages (controlled by `quiet` and `debuglevel`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L9' class='documenter-source'>source</a><br>

<a id='Mads.madserror-Tuple{String}' href='#Mads.madserror-Tuple{String}'>#</a>
**`Mads.madserror`** &mdash; *Method*.



MADS error messages


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L32' class='documenter-source'>source</a><br>

<a id='Mads.madsinfo' href='#Mads.madsinfo'>#</a>
**`Mads.madsinfo`** &mdash; *Function*.



MADS information/status messages (controlled by quiet`and`verbositylevel`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L17' class='documenter-source'>source</a><br>

<a id='Mads.madsload' href='#Mads.madsload'>#</a>
**`Mads.madsload`** &mdash; *Function*.



Check the load of a series of servers


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L283-L285' class='documenter-source'>source</a><br>

<a id='Mads.madsmathprogbase' href='#Mads.madsmathprogbase'>#</a>
**`Mads.madsmathprogbase`** &mdash; *Function*.



Mads execution using MathProgBase


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMathProgBase.jl#L7' class='documenter-source'>source</a><br>

<a id='Mads.madsoutput' href='#Mads.madsoutput'>#</a>
**`Mads.madsoutput`** &mdash; *Function*.



MADS output (controlled by quiet`and`verbositylevel`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.madsup' href='#Mads.madsup'>#</a>
**`Mads.madsup`** &mdash; *Function*.



Check the uptime of a series of servers


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L276-L278' class='documenter-source'>source</a><br>

<a id='Mads.madswarn-Tuple{String}' href='#Mads.madswarn-Tuple{String}'>#</a>
**`Mads.madswarn`** &mdash; *Method*.



MADS warning messages


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLog.jl#L25' class='documenter-source'>source</a><br>

<a id='Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayconditionalloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayconditionalloglikelihood`** &mdash; *Method*.



Make a conditional log likelihood function that accepts an array containing the opt parameters' values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L57' class='documenter-source'>source</a><br>

<a id='Mads.makearrayfunction' href='#Mads.makearrayfunction'>#</a>
**`Mads.makearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameters' values

`Mads.makearrayfunction(madsdata, f)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : ...

Returns:

  * `arrayfunction` : function accepting an array containing the optimal parameters' values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L4-L17' class='documenter-source'>source</a><br>

<a id='Mads.makearrayloglikelihood-Tuple{Associative,Any}' href='#Mads.makearrayloglikelihood-Tuple{Associative,Any}'>#</a>
**`Mads.makearrayloglikelihood`** &mdash; *Method*.



Make a log likelihood function that accepts an array containing the opt parameters' values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L70' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt!-Tuple{Associative,Associative}' href='#Mads.makebigdt!-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt!`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Arguments:

  * `madsdata` : MADS problem dictionary
  * `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

  * `bigdtproblem` : BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsBayesInfoGap.jl#L23-L34' class='documenter-source'>source</a><br>

<a id='Mads.makebigdt-Tuple{Associative,Associative}' href='#Mads.makebigdt-Tuple{Associative,Associative}'>#</a>
**`Mads.makebigdt`** &mdash; *Method*.



Setup Bayesian Information Gap Decision Theory (BIG-DT) problem

Arguments:

  * `madsdata` : MADS problem dictionary
  * `choice` : dictionary of BIG-DT choices (scenarios)

Returns:

  * `bigdtproblem` : BIG-DT problem type


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsBayesInfoGap.jl#L7-L18' class='documenter-source'>source</a><br>

<a id='Mads.makecomputeconcentrations-Tuple{Associative}' href='#Mads.makecomputeconcentrations-Tuple{Associative}'>#</a>
**`Mads.makecomputeconcentrations`** &mdash; *Method*.



Create a function to compute concentrations for all the observation points using Anasol

`Mads.makecomputeconcentrations(madsdata)`

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasol.jl#L45-L70' class='documenter-source'>source</a><br>

<a id='Mads.makedoublearrayfunction' href='#Mads.makedoublearrayfunction'>#</a>
**`Mads.makedoublearrayfunction`** &mdash; *Function*.



Make a version of the function `f` that accepts an array containing the optimal parameters' values, and returns an array of observations

`Mads.makedoublearrayfunction(madsdata, f)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `f` : ...

Returns:

  * `doublearrayfunction` : function accepting an array containing the optimal parameters' values, and returning an array of observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L27-L40' class='documenter-source'>source</a><br>

<a id='Mads.makelmfunctions-Tuple{Associative}' href='#Mads.makelmfunctions-Tuple{Associative}'>#</a>
**`Mads.makelmfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L67' class='documenter-source'>source</a><br>

<a id='Mads.makelocalsafunction-Tuple{Associative}' href='#Mads.makelocalsafunction-Tuple{Associative}'>#</a>
**`Mads.makelocalsafunction`** &mdash; *Method*.



Make gradient function needed for local sensitivity analysis


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L160' class='documenter-source'>source</a><br>

<a id='Mads.makelogprior-Tuple{Associative}' href='#Mads.makelogprior-Tuple{Associative}'>#</a>
**`Mads.makelogprior`** &mdash; *Method*.



Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L366' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L7-L48' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandfunctionandgradient-Tuple{Associative}' href='#Mads.makemadscommandfunctionandgradient-Tuple{Associative}'>#</a>
**`Mads.makemadscommandfunctionandgradient`** &mdash; *Method*.



Make MADS forward & gradient functions for the model defined in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L302' class='documenter-source'>source</a><br>

<a id='Mads.makemadscommandgradient-Tuple{Associative}' href='#Mads.makemadscommandgradient-Tuple{Associative}'>#</a>
**`Mads.makemadscommandgradient`** &mdash; *Method*.



Make MADS gradient function to compute the parameter-space gradient for the model defined in the MADS problem dictionary `madsdata`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L288' class='documenter-source'>source</a><br>

<a id='Mads.makemadsconditionalloglikelihood-Tuple{Associative}' href='#Mads.makemadsconditionalloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsconditionalloglikelihood`** &mdash; *Method*.



Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations. Model parameters and observations are defined in the MADS problem dictionary `madsdata`.


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L378-L381' class='documenter-source'>source</a><br>

<a id='Mads.makemadsloglikelihood-Tuple{Associative}' href='#Mads.makemadsloglikelihood-Tuple{Associative}'>#</a>
**`Mads.makemadsloglikelihood`** &mdash; *Method*.



Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations. The function can be provided as an external function in the MADS problem dictionary under `LogLikelihood` or computed internally.


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L404-L407' class='documenter-source'>source</a><br>

<a id='Mads.makemadsreusablefunction' href='#Mads.makemadsreusablefunction'>#</a>
**`Mads.makemadsreusablefunction`** &mdash; *Function*.



Make Mads reusable function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsFunc.jl#L201' class='documenter-source'>source</a><br>

<a id='Mads.makempbfunctions-Tuple{Associative}' href='#Mads.makempbfunctions-Tuple{Associative}'>#</a>
**`Mads.makempbfunctions`** &mdash; *Method*.



Make forward model, gradient, objective functions needed for MathProgBase optimization


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMathProgBase.jl#L72' class='documenter-source'>source</a><br>

<a id='Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}' href='#Mads.maxtorealmax!-Tuple{DataFrames.DataFrame}'>#</a>
**`Mads.maxtorealmax!`** &mdash; *Method*.



Scale down values larger than max(Float32) in a Dataframe `df` so that Gadfly can plot the data


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L893' class='documenter-source'>source</a><br>

<a id='Mads.modelinformationcriteria' href='#Mads.modelinformationcriteria'>#</a>
**`Mads.modelinformationcriteria`** &mdash; *Function*.



Model section information criteria


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsModelSelection.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.modobsweights!-Tuple{Associative,Number}' href='#Mads.modobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modobsweights!`** &mdash; *Method*.



Modify (multiply) observation weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L216' class='documenter-source'>source</a><br>

<a id='Mads.modwellweights!-Tuple{Associative,Number}' href='#Mads.modwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.modwellweights!`** &mdash; *Method*.



Modify (multiply) well weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L246' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L145-L162' class='documenter-source'>source</a><br>

<a id='Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}' href='#Mads.naive_get_deltax-Tuple{Array{Float64,2},Array{Float64,2},Array{Float64,1},Number}'>#</a>
**`Mads.naive_get_deltax`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: get the LM parameter space step


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L232' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L251-L268' class='documenter-source'>source</a><br>

<a id='Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}' href='#Mads.naive_lm_iteration-Tuple{Function,Function,Function,Array{Float64,1},Array{Float64,1},Array{Float64,1}}'>#</a>
**`Mads.naive_lm_iteration`** &mdash; *Method*.



Naive Levenberg-Marquardt optimization: perform LM iteration


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L239' class='documenter-source'>source</a><br>

<a id='Mads.noplot-Tuple{}' href='#Mads.noplot-Tuple{}'>#</a>
**`Mads.noplot`** &mdash; *Method*.



Disable MADS plotting


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L222' class='documenter-source'>source</a><br>

<a id='Mads.obslineismatch-Tuple{String,Array{Regex,1}}' href='#Mads.obslineismatch-Tuple{String,Array{Regex,1}}'>#</a>
**`Mads.obslineismatch`** &mdash; *Method*.



Match an instruction line in the Mads instruction file with model input file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L610' class='documenter-source'>source</a><br>

<a id='Mads.of-Tuple{Associative,Array{T,1}}' href='#Mads.of-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.of`** &mdash; *Method*.



Compute objective function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L37' class='documenter-source'>source</a><br>

<a id='Mads.paramarray2dict-Tuple{Associative,Array}' href='#Mads.paramarray2dict-Tuple{Associative,Array}'>#</a>
**`Mads.paramarray2dict`** &mdash; *Method*.



Convert a parameter array to a parameter dictionary of arrays


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L210-L212' class='documenter-source'>source</a><br>

<a id='Mads.paramdict2array-Tuple{Associative}' href='#Mads.paramdict2array-Tuple{Associative}'>#</a>
**`Mads.paramdict2array`** &mdash; *Method*.



Convert a parameter dictionary of arrays to a parameter array


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L222-L224' class='documenter-source'>source</a><br>

<a id='Mads.parsemadsdata!-Tuple{Associative}' href='#Mads.parsemadsdata!-Tuple{Associative}'>#</a>
**`Mads.parsemadsdata!`** &mdash; *Method*.



Parse loaded Mads problem dictionary

Arguments:

  * `madsdata` : Mads problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L44-L50' class='documenter-source'>source</a><br>

<a id='Mads.parsenodenames' href='#Mads.parsenodenames'>#</a>
**`Mads.parsenodenames`** &mdash; *Function*.



Parse string with node names defined in SLURM


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L195' class='documenter-source'>source</a><br>

<a id='Mads.partialof-Tuple{Associative,Associative,Regex}' href='#Mads.partialof-Tuple{Associative,Associative,Regex}'>#</a>
**`Mads.partialof`** &mdash; *Method*.



Compute the sum of squared residuals for observations that match a regular expression


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L50' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlotPy.jl#L4-L22' class='documenter-source'>source</a><br>

<a id='Mads.plotmadsproblem-Tuple{Associative}' href='#Mads.plotmadsproblem-Tuple{Associative}'>#</a>
**`Mads.plotmadsproblem`** &mdash; *Method*.



Plot contaminant sources and wells defined in MADS problem dictionary

Arguments:

  * `madsdata` : MADS problem dictionary
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)
  * `keyword` : to be added in the filename


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L60-L69' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsAnasolPlot.jl#L3-L17' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L141-L159' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L474-L485' class='documenter-source'>source</a><br>

<a id='Mads.plotrobustnesscurves-Tuple{Associative,Dict}' href='#Mads.plotrobustnesscurves-Tuple{Associative,Dict}'>#</a>
**`Mads.plotrobustnesscurves`** &mdash; *Method*.



Plot BIG-DT robustness curves

Arguments:

  * `madsdata` : MADS problem dictionary
  * `bigdtresults` : BIG-DT results
  * `filename` : output file name used to dump plots
  * `format` : output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsBayesInfoGapPlot.jl#L3-L12' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L952-L965' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L364-L376' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults-Tuple{Associative,Associative}' href='#Mads.printSAresults-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults`** &mdash; *Method*.



Print sensitivity analysis results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L750' class='documenter-source'>source</a><br>

<a id='Mads.printSAresults2-Tuple{Associative,Associative}' href='#Mads.printSAresults2-Tuple{Associative,Associative}'>#</a>
**`Mads.printSAresults2`** &mdash; *Method*.



Print sensitivity analysis results (method 2)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L826' class='documenter-source'>source</a><br>

<a id='Mads.push' href='#Mads.push'>#</a>
**`Mads.push`** &mdash; *Function*.



Push the latest version of the Mads / Julia modules in the repo


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L88' class='documenter-source'>source</a><br>

<a id='Mads.quietoff-Tuple{}' href='#Mads.quietoff-Tuple{}'>#</a>
**`Mads.quietoff`** &mdash; *Method*.



Make MADS not quiet


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L21' class='documenter-source'>source</a><br>

<a id='Mads.quieton-Tuple{}' href='#Mads.quieton-Tuple{}'>#</a>
**`Mads.quieton`** &mdash; *Method*.



Make MADS quiet


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L16' class='documenter-source'>source</a><br>

<a id='Mads.readasciipredictions-Tuple{String}' href='#Mads.readasciipredictions-Tuple{String}'>#</a>
**`Mads.readasciipredictions`** &mdash; *Method*.



Read MADS predictions from an ASCII file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsASCII.jl#L12' class='documenter-source'>source</a><br>

<a id='Mads.readjsonpredictions-Tuple{String}' href='#Mads.readjsonpredictions-Tuple{String}'>#</a>
**`Mads.readjsonpredictions`** &mdash; *Method*.



Read MADS model predictions from a JSON file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsJSON.jl#L23' class='documenter-source'>source</a><br>

<a id='Mads.readmodeloutput-Tuple{Associative}' href='#Mads.readmodeloutput-Tuple{Associative}'>#</a>
**`Mads.readmodeloutput`** &mdash; *Method*.



Read model outputs saved for MADS


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L445' class='documenter-source'>source</a><br>

<a id='Mads.readobservations' href='#Mads.readobservations'>#</a>
**`Mads.readobservations`** &mdash; *Function*.



Read observations


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L662' class='documenter-source'>source</a><br>

<a id='Mads.readobservations_cmads-Tuple{Associative}' href='#Mads.readobservations_cmads-Tuple{Associative}'>#</a>
**`Mads.readobservations_cmads`** &mdash; *Method*.



Read observations using C Mads library


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-old/MadsCMads.jl#L3' class='documenter-source'>source</a><br>

<a id='Mads.readyamlpredictions-Tuple{String}' href='#Mads.readyamlpredictions-Tuple{String}'>#</a>
**`Mads.readyamlpredictions`** &mdash; *Method*.



Read MADS model predictions from a YAML file `filename`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsYAML.jl#L106' class='documenter-source'>source</a><br>

<a id='Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}' href='#Mads.regexs2obs-Tuple{String,Array{Regex,1},Array{String,1},Array{Bool,1}}'>#</a>
**`Mads.regexs2obs`** &mdash; *Method*.



Get observations for a set of regular expressions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L616' class='documenter-source'>source</a><br>

<a id='Mads.reload-Tuple{}' href='#Mads.reload-Tuple{}'>#</a>
**`Mads.reload`** &mdash; *Method*.



Reload Mads modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsTest.jl#L20' class='documenter-source'>source</a><br>

<a id='Mads.required' href='#Mads.required'>#</a>
**`Mads.required`** &mdash; *Function*.



Lists modules required by a module (Mads by default)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L17' class='documenter-source'>source</a><br>

<a id='Mads.resetmodelruns-Tuple{}' href='#Mads.resetmodelruns-Tuple{}'>#</a>
**`Mads.resetmodelruns`** &mdash; *Method*.



Reset the model runs count to be equal to zero


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L66' class='documenter-source'>source</a><br>

<a id='Mads.residuals-Tuple{Associative,Array{T,1}}' href='#Mads.residuals-Tuple{Associative,Array{T,1}}'>#</a>
**`Mads.residuals`** &mdash; *Method*.



Compute residuals


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsLevenbergMarquardt.jl#L5' class='documenter-source'>source</a><br>

<a id='Mads.restartoff-Tuple{}' href='#Mads.restartoff-Tuple{}'>#</a>
**`Mads.restartoff`** &mdash; *Method*.



MADS restart off


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L6' class='documenter-source'>source</a><br>

<a id='Mads.restarton-Tuple{}' href='#Mads.restarton-Tuple{}'>#</a>
**`Mads.restarton`** &mdash; *Method*.



MADS restart on


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}' href='#Mads.reweighsamples-Tuple{Associative,Array,Array{T,1}}'>#</a>
**`Mads.reweighsamples`** &mdash; *Method*.



Reweigh samples using importance sampling – returns a vector of log-likelihoods after reweighing

Arguments:

  * `madsdata` : MADS problem dictionary
  * `predictions` : the model predictions for each of the samples
  * `oldllhoods` : the log likelihoods of the parameters in the old distribution

Returns:

  * `newllhoods` : vector of log-likelihoods after reweighing


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L188-L200' class='documenter-source'>source</a><br>

<a id='Mads.rmdir-Tuple{String}' href='#Mads.rmdir-Tuple{String}'>#</a>
**`Mads.rmdir`** &mdash; *Method*.



Remove directory


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L732' class='documenter-source'>source</a><br>

<a id='Mads.rmfile-Tuple{String}' href='#Mads.rmfile-Tuple{String}'>#</a>
**`Mads.rmfile`** &mdash; *Method*.



Remove file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L742' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_ext-Tuple{String}' href='#Mads.rmfiles_ext-Tuple{String}'>#</a>
**`Mads.rmfiles_ext`** &mdash; *Method*.



Remove files with extension `ext`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L752' class='documenter-source'>source</a><br>

<a id='Mads.rmfiles_root-Tuple{String}' href='#Mads.rmfiles_root-Tuple{String}'>#</a>
**`Mads.rmfiles_root`** &mdash; *Method*.



Remove files with root `root`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L759' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock-Tuple{Array{T,1}}' href='#Mads.rosenbrock-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock`** &mdash; *Method*.



Rosenbrock test function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L16' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L6' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock2_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock2_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock2_lm`** &mdash; *Method*.



Rosenbrock test function (more difficult to solve)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}' href='#Mads.rosenbrock_gradient!-Tuple{Array{T,1},Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient!`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L26' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_gradient_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_gradient_lm`** &mdash; *Method*.



Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separetely)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L32' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}' href='#Mads.rosenbrock_hessian!-Tuple{Array{T,1},Array{T,2}}'>#</a>
**`Mads.rosenbrock_hessian!`** &mdash; *Method*.



Parameter Hessian of the Rosenbrock test function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L42' class='documenter-source'>source</a><br>

<a id='Mads.rosenbrock_lm-Tuple{Array{T,1}}' href='#Mads.rosenbrock_lm-Tuple{Array{T,1}}'>#</a>
**`Mads.rosenbrock_lm`** &mdash; *Method*.



Rosenbrock test function for LM optimization (returns the 2 components separetely)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsTestFunctions.jl#L21' class='documenter-source'>source</a><br>

<a id='Mads.runcmd' href='#Mads.runcmd'>#</a>
**`Mads.runcmd`** &mdash; *Function*.



Run external command and pipe stdout and stderr


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L290-L292' class='documenter-source'>source</a><br>

<a id='Mads.runremote' href='#Mads.runremote'>#</a>
**`Mads.runremote`** &mdash; *Function*.



Run remote command on a series of servers


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L251-L253' class='documenter-source'>source</a><br>

<a id='Mads.saltelli-Tuple{Associative}' href='#Mads.saltelli-Tuple{Associative}'>#</a>
**`Mads.saltelli`** &mdash; *Method*.



Saltelli sensitivity analysis

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `seed` : initial random seed
  * `restartdir` : directory where files will be stored containing model results for fast simulation restarts
  * `parallel` : set to true if the model runs should be performed in parallel


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L479-L489' class='documenter-source'>source</a><br>

<a id='Mads.saltellibrute-Tuple{Associative}' href='#Mads.saltellibrute-Tuple{Associative}'>#</a>
**`Mads.saltellibrute`** &mdash; *Method*.



Saltelli sensitivity analysis (brute force)

Arguments:

  * `madsdata` : MADS problem dictionary
  * `N` : number of samples
  * `seed` : initial random seed


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L311-L319' class='documenter-source'>source</a><br>

<a id='Mads.saltellibruteparallel-Tuple{Associative,Integer}' href='#Mads.saltellibruteparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltellibruteparallel`** &mdash; *Method*.



Parallel version of saltellibrute


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L709' class='documenter-source'>source</a><br>

<a id='Mads.saltelliparallel-Tuple{Associative,Integer}' href='#Mads.saltelliparallel-Tuple{Associative,Integer}'>#</a>
**`Mads.saltelliparallel`** &mdash; *Method*.



Parallel version of saltelli


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L709' class='documenter-source'>source</a><br>

<a id='Mads.savecalibrationresults-Tuple{Associative,Any}' href='#Mads.savecalibrationresults-Tuple{Associative,Any}'>#</a>
**`Mads.savecalibrationresults`** &mdash; *Method*.



Save calibration results


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L193' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L146-L161' class='documenter-source'>source</a><br>

<a id='Mads.savemcmcresults-Tuple{Array,String}' href='#Mads.savemcmcresults-Tuple{Array,String}'>#</a>
**`Mads.savemcmcresults`** &mdash; *Method*.



Save MCMC chain in a file


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMonteCarlo.jl#L121' class='documenter-source'>source</a><br>

<a id='Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}' href='#Mads.scatterplotsamples-Tuple{Associative,Array{T,2},String}'>#</a>
**`Mads.scatterplotsamples`** &mdash; *Method*.



Create histogram/scatter plots of model parameter samples

Arguments:

  * `madsdata` : MADS problem dictionary
  * `samples` : matrix with model parameters
  * `filename` : output file name
  * `format` : output plot format (`png`, `pdf`, etc.)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L318-L327' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L495-L510' class='documenter-source'>source</a><br>

<a id='Mads.set_nprocs_per_task' href='#Mads.set_nprocs_per_task'>#</a>
**`Mads.set_nprocs_per_task`** &mdash; *Function*.



Set number of processors needed for each parallel task at each node


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L51' class='documenter-source'>source</a><br>

<a id='Mads.setallparamsoff!-Tuple{Associative}' href='#Mads.setallparamsoff!-Tuple{Associative}'>#</a>
**`Mads.setallparamsoff!`** &mdash; *Method*.



Set all parameters OFF


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L340' class='documenter-source'>source</a><br>

<a id='Mads.setallparamson!-Tuple{Associative}' href='#Mads.setallparamson!-Tuple{Associative}'>#</a>
**`Mads.setallparamson!`** &mdash; *Method*.



Set all parameters ON


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L332' class='documenter-source'>source</a><br>

<a id='Mads.setdebuglevel-Tuple{Int64}' href='#Mads.setdebuglevel-Tuple{Int64}'>#</a>
**`Mads.setdebuglevel`** &mdash; *Method*.



Set MADS debug level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L56' class='documenter-source'>source</a><br>

<a id='Mads.setdefaultplotformat-Tuple{String}' href='#Mads.setdefaultplotformat-Tuple{String}'>#</a>
**`Mads.setdefaultplotformat`** &mdash; *Method*.



Set the default plot format (`SVG` is the default format)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L9-L11' class='documenter-source'>source</a><br>

<a id='Mads.setdir-Tuple{Any}' href='#Mads.setdir-Tuple{Any}'>#</a>
**`Mads.setdir`** &mdash; *Method*.



Set the working directory (for parallel environments)

```
@everywhere Mads.setdir()
@everywhere Mads.setdir("/home/monty")
```


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L233-L240' class='documenter-source'>source</a><br>

<a id='Mads.setdynamicmodel-Tuple{Associative,Function}' href='#Mads.setdynamicmodel-Tuple{Associative,Function}'>#</a>
**`Mads.setdynamicmodel`** &mdash; *Method*.



Set Dynamic Model for MADS model calls using internal Julia functions


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L87' class='documenter-source'>source</a><br>

<a id='Mads.setmadsinputfile-Tuple{String}' href='#Mads.setmadsinputfile-Tuple{String}'>#</a>
**`Mads.setmadsinputfile`** &mdash; *Method*.



Set a default MADS input file

`Mads.setmadsinputfile(filename)`

Arguments:

  * `filename` : input file name (e.g. `input_file_name.mads`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L200-L208' class='documenter-source'>source</a><br>

<a id='Mads.setmodelinputs-Tuple{Associative,Associative}' href='#Mads.setmodelinputs-Tuple{Associative,Associative}'>#</a>
**`Mads.setmodelinputs`** &mdash; *Method*.



Set model input files; delete files where model output should be saved for MADS


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L383' class='documenter-source'>source</a><br>

<a id='Mads.setnewmadsfilename-Tuple{Associative}' href='#Mads.setnewmadsfilename-Tuple{Associative}'>#</a>
**`Mads.setnewmadsfilename`** &mdash; *Method*.



Set new mads file name


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L475-L477' class='documenter-source'>source</a><br>

<a id='Mads.setobservationtargets!-Tuple{Associative,Associative}' href='#Mads.setobservationtargets!-Tuple{Associative,Associative}'>#</a>
**`Mads.setobservationtargets!`** &mdash; *Method*.



Set observations (calibration targets) in the MADS problem dictionary based on a `predictions` dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L336' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L163-L184' class='documenter-source'>source</a><br>

<a id='Mads.setobsweights!-Tuple{Associative,Number}' href='#Mads.setobsweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setobsweights!`** &mdash; *Method*.



Set observation weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L208' class='documenter-source'>source</a><br>

<a id='Mads.setparamoff!-Tuple{Associative,String}' href='#Mads.setparamoff!-Tuple{Associative,String}'>#</a>
**`Mads.setparamoff!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` OFF


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L353' class='documenter-source'>source</a><br>

<a id='Mads.setparamon!-Tuple{Associative,String}' href='#Mads.setparamon!-Tuple{Associative,String}'>#</a>
**`Mads.setparamon!`** &mdash; *Method*.



Set a specific parameter with a key `parameterkey` ON


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L348' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistnormal!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistnormal!`** &mdash; *Method*.



Set normal parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistnormal!(madsdata, mean, stddev)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `mean` : array with the mean values
  * `stddev` : array with the standard deviation values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L358-L368' class='documenter-source'>source</a><br>

<a id='Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}' href='#Mads.setparamsdistuniform!-Tuple{Associative,Array{T,1},Array{T,1}}'>#</a>
**`Mads.setparamsdistuniform!`** &mdash; *Method*.



Set uniform parameter distributions for all the model parameters in the MADS problem dictionary

`Mads.setparamsdistuniform!(madsdata, min, max)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `min` : array with the minimum values
  * `max` : array with the maximum values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L376-L386' class='documenter-source'>source</a><br>

<a id='Mads.setparamsinit!-Tuple{Associative,Associative}' href='#Mads.setparamsinit!-Tuple{Associative,Associative}'>#</a>
**`Mads.setparamsinit!`** &mdash; *Method*.



Set initial parameter guesses in the MADS dictionary

`Mads.setparamsinit!(madsdata, paramdict)`

Arguments:

  * `madsdata` : MADS problem dictionary
  * `paramdict` : dictionary with initial model parameter values


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L267-L276' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L20-L34' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L15-L28' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsParallel.jl#L61-L85' class='documenter-source'>source</a><br>

<a id='Mads.setseed-Tuple{Integer}' href='#Mads.setseed-Tuple{Integer}'>#</a>
**`Mads.setseed`** &mdash; *Method*.



Set current seed


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L14' class='documenter-source'>source</a><br>

<a id='Mads.settarget!-Tuple{Associative,Number}' href='#Mads.settarget!-Tuple{Associative,Number}'>#</a>
**`Mads.settarget!`** &mdash; *Method*.



Set observation target


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L152' class='documenter-source'>source</a><br>

<a id='Mads.settime!-Tuple{Associative,Number}' href='#Mads.settime!-Tuple{Associative,Number}'>#</a>
**`Mads.settime!`** &mdash; *Method*.



Set observation time


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L104' class='documenter-source'>source</a><br>

<a id='Mads.setverbositylevel-Tuple{Int64}' href='#Mads.setverbositylevel-Tuple{Int64}'>#</a>
**`Mads.setverbositylevel`** &mdash; *Method*.



Set MADS verbosity level


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L61' class='documenter-source'>source</a><br>

<a id='Mads.setweight!-Tuple{Associative,Number}' href='#Mads.setweight!-Tuple{Associative,Number}'>#</a>
**`Mads.setweight!`** &mdash; *Method*.



Set observation weight


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L128' class='documenter-source'>source</a><br>

<a id='Mads.setwellweights!-Tuple{Associative,Number}' href='#Mads.setwellweights!-Tuple{Associative,Number}'>#</a>
**`Mads.setwellweights!`** &mdash; *Method*.



Set well weights in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L235' class='documenter-source'>source</a><br>

<a id='Mads.showallparameters-Tuple{Associative}' href='#Mads.showallparameters-Tuple{Associative}'>#</a>
**`Mads.showallparameters`** &mdash; *Method*.



Show all parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L456' class='documenter-source'>source</a><br>

<a id='Mads.showobservations-Tuple{Associative}' href='#Mads.showobservations-Tuple{Associative}'>#</a>
**`Mads.showobservations`** &mdash; *Method*.



Show observations in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L271' class='documenter-source'>source</a><br>

<a id='Mads.showparameters-Tuple{Associative}' href='#Mads.showparameters-Tuple{Associative}'>#</a>
**`Mads.showparameters`** &mdash; *Method*.



Show optimizable parameters in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsParameters.jl#L425' class='documenter-source'>source</a><br>

<a id='Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransform-Tuple{Array{T,1},Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransform`** &mdash; *Method*.



Sine transformation of model parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSineTransformations.jl#L9' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformfunction-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformfunction`** &mdash; *Method*.



Sine transformation of a function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSineTransformations.jl#L16' class='documenter-source'>source</a><br>

<a id='Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}' href='#Mads.sinetransformgradient-Tuple{Function,Array{T,1},Array{T,1},Array{T,1}}'>#</a>
**`Mads.sinetransformgradient`** &mdash; *Method*.



Sine transformation of a gradient function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSineTransformations.jl#L24' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L780-L808' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsPlot.jl#L644-L667' class='documenter-source'>source</a><br>

<a id='Mads.sphericalcov-Tuple{Number,Number,Number}' href='#Mads.sphericalcov-Tuple{Number,Number,Number}'>#</a>
**`Mads.sphericalcov`** &mdash; *Method*.



Spherical spatial covariance function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L7' class='documenter-source'>source</a><br>

<a id='Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}' href='#Mads.sphericalvariogram-Tuple{Number,Number,Number,Number}'>#</a>
**`Mads.sphericalvariogram`** &mdash; *Method*.



Spherical variogram


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsKriging.jl#L10' class='documenter-source'>source</a><br>

<a id='Mads.sprintf-Tuple' href='#Mads.sprintf-Tuple'>#</a>
**`Mads.sprintf`** &mdash; *Method*.



Convert `@sprintf` macro into `sprintf` function


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsMisc.jl#L114' class='documenter-source'>source</a><br>

<a id='Mads.status-Tuple{}' href='#Mads.status-Tuple{}'>#</a>
**`Mads.status`** &mdash; *Method*.



Status of the Mads modules


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L142' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdir-Tuple{String,String}' href='#Mads.symlinkdir-Tuple{String,String}'>#</a>
**`Mads.symlinkdir`** &mdash; *Method*.



Create a symbolic link of a file `filename` in a directory `dirtarget`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L724' class='documenter-source'>source</a><br>

<a id='Mads.symlinkdirfiles-Tuple{String,String}' href='#Mads.symlinkdirfiles-Tuple{String,String}'>#</a>
**`Mads.symlinkdirfiles`** &mdash; *Method*.



Create a symbolic link of all the files in a directory `dirsource` in a directory `dirtarget`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L712' class='documenter-source'>source</a><br>

<a id='Mads.tag' href='#Mads.tag'>#</a>
**`Mads.tag`** &mdash; *Function*.



Tag the Mads modules with a default argument `:patch`


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsPublish.jl#L191' class='documenter-source'>source</a><br>

<a id='Mads.test' href='#Mads.test'>#</a>
**`Mads.test`** &mdash; *Function*.



Execute Mads tests (the tests will be in parallel if processors are defined)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsTest.jl#L28' class='documenter-source'>source</a><br>

<a id='Mads.testj' href='#Mads.testj'>#</a>
**`Mads.testj`** &mdash; *Function*.



Execute Mads tests using Julia Pkg.test (the default Pkg.test in Julia is executed in serial)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/../src-interactive/MadsTest.jl#L1' class='documenter-source'>source</a><br>

<a id='Mads.transposematrix-Tuple{Array{T,2}}' href='#Mads.transposematrix-Tuple{Array{T,2}}'>#</a>
**`Mads.transposematrix`** &mdash; *Method*.



Transpose non-numeric matrix


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L146' class='documenter-source'>source</a><br>

<a id='Mads.transposevector-Tuple{Array{T,1}}' href='#Mads.transposevector-Tuple{Array{T,1}}'>#</a>
**`Mads.transposevector`** &mdash; *Method*.



Transpose non-numeric vector


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsHelpers.jl#L141' class='documenter-source'>source</a><br>

<a id='Mads.void2nan!-Tuple{Associative}' href='#Mads.void2nan!-Tuple{Associative}'>#</a>
**`Mads.void2nan!`** &mdash; *Method*.



Convert Void's into NaN's in a dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L861' class='documenter-source'>source</a><br>

<a id='Mads.weightedstats-Tuple{Array,Array{T,1}}' href='#Mads.weightedstats-Tuple{Array,Array{T,1}}'>#</a>
**`Mads.weightedstats`** &mdash; *Method*.



Get weighted mean and variance samples

Arguments:

  * `samples` : array of samples
  * `llhoods` : vector of log-likelihoods

Returns:

  * `mean` : vector of sample means
  * `var` : vector of sample variances


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsSenstivityAnalysis.jl#L247-L259' class='documenter-source'>source</a><br>

<a id='Mads.welloff!-Tuple{Associative,String}' href='#Mads.welloff!-Tuple{Associative,String}'>#</a>
**`Mads.welloff!`** &mdash; *Method*.



Turn off a specific well in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L384' class='documenter-source'>source</a><br>

<a id='Mads.wellon!-Tuple{Associative,String}' href='#Mads.wellon!-Tuple{Associative,String}'>#</a>
**`Mads.wellon!`** &mdash; *Method*.



Turn on a specific well in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L360' class='documenter-source'>source</a><br>

<a id='Mads.wells2observations!-Tuple{Associative}' href='#Mads.wells2observations!-Tuple{Associative}'>#</a>
**`Mads.wells2observations!`** &mdash; *Method*.



Convert `Wells` class to `Observations` class in the MADS problem dictionary


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsObservations.jl#L400' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters-Tuple{Associative,Associative}' href='#Mads.writeparameters-Tuple{Associative,Associative}'>#</a>
**`Mads.writeparameters`** &mdash; *Method*.



Write parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L562' class='documenter-source'>source</a><br>

<a id='Mads.writeparameters-Tuple{Associative}' href='#Mads.writeparameters-Tuple{Associative}'>#</a>
**`Mads.writeparameters`** &mdash; *Method*.



Write initial parameters


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L555' class='documenter-source'>source</a><br>

<a id='Mads.writeparametersviatemplate-Tuple{Any,Any,Any}' href='#Mads.writeparametersviatemplate-Tuple{Any,Any,Any}'>#</a>
**`Mads.writeparametersviatemplate`** &mdash; *Method*.



Write `parameters` via MADS template (`templatefilename`) to an output file (`outputfilename`)


<a target='_blank' href='https://github.com/madsjulia/Mads.jl/tree/e3fafff63c8caaf12f4a8abb09e137f158002124/src/MadsIO.jl#L526' class='documenter-source'>source</a><br>

