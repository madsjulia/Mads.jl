# Mads

## Internal

---

<a id="method__allwellsoff.1" class="lexicon_definition"></a>
#### allwellsoff!(madsdata::Associative{K, V}) [¶](#method__allwellsoff.1)
Turn off all the wells in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:140](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__allwellson.1" class="lexicon_definition"></a>
#### allwellson!(madsdata::Associative{K, V}) [¶](#method__allwellson.1)
Turn on all the wells in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:116](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__asinetransform.1" class="lexicon_definition"></a>
#### asinetransform(params::Array{T, 1},  lowerbounds::Array{T, 1},  upperbounds::Array{T, 1},  indexlogtransformed::Array{T, 1}) [¶](#method__asinetransform.1)
Arcsine transformation of model parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSine.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsSine.jl)

---

<a id="method__bayessampling.1" class="lexicon_definition"></a>
#### bayessampling(madsdata,  numsequences) [¶](#method__bayessampling.1)
Brute force parallel Bayesian sampling

`Mads.bayessampling(madsdata, numsequences; nsteps=100, burnin=1000, thinning=1)`

Arguments:

- `madsdata` : Mads data dictionary
- `numsequences` :
- `nsteps` : 
- `burnin` : 
- `thinning` : 

Returns:

- `mcmcchain` : 


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:53](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__bayessampling.2" class="lexicon_definition"></a>
#### bayessampling(madsdata::Associative{K, V}) [¶](#method__bayessampling.2)
Bayes Sampling

`Mads.bayessampling(madsdata; nsteps=100, burnin=1000, thinning=1)`

Arguments:

- `madsdata` : Mads data dictionary
- `nsteps` :  
- `burnin` :  
- `thinning` :   

Returns:

- `mcmcchain` : 


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:20](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__calibrate.1" class="lexicon_definition"></a>
#### calibrate(madsdata::Associative{K, V}) [¶](#method__calibrate.1)
Calibrate

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Arguments:

- `madsdata` : Mads data dictionary
- `tolX` : parameter space tolerance
- `tolG` : parameter space update tolerance
- `maxEval` : maximum number of model evaluations
- `maxIter` : maximum number of optimization iterations
- `maxJacobians` : maximum number of Jacobian solves
- `lambda` : initial Levenberg-Marquardt lambda 
- `lambda_mu` : lambda multiplication factor [10]
- `np_lambda` : number of parallel lambda solves
- `show_trace` : shows solution trace [default=false]
- `usenaive` : use naive Levenberg-Marquardt solver

Returns:

- `minimumdict` : model parameter dictionary with the optimal values at the minimum
- `results` : optimization algorithm results (e.g. results.minimum)



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl:87](file:///Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl)

---

<a id="method__calibratenlopt.1" class="lexicon_definition"></a>
#### calibratenlopt(madsdata::Associative{K, V}) [¶](#method__calibratenlopt.1)
Do a calibration using NLopt 

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl:129](file:///Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl)

---

<a id="method__calibraterandom.1" class="lexicon_definition"></a>
#### calibraterandom(madsdata::Associative{K, V},  numberofsamples) [¶](#method__calibraterandom.1)
Calibrate with random initial guesses

`Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Arguments:

- `madsdata` : Mads data dictionary
- `numberofsamples` : number of random initial samples
- `tolX` : parameter space tolerance
- `tolG` : parameter space update tolerance
- `maxEval` : maximum number of model evaluations
- `maxIter` : maximum number of optimization iterations
- `maxJacobians` : maximum number of Jacobian solves
- `lambda` : initial Levenberg-Marquardt lambda 
- `lambda_mu` : lambda multiplication factor [10]
- `np_lambda` : number of parallel lambda solves
- `show_trace` : shows solution trace [default=false]
- `usenaive` : use naive Levenberg-Marquardt solver

Returns:

- `bestresult` : optimal results tuple: [1] model parameter dictionary with the optimal values at the minimum; [2] optimization algorithm results (e.g. bestresult[2].minimum)



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl:26](file:///Users/monty/Julia/Mads.jl/src/MadsCalibrate.jl)

---

<a id="method__cmadsins_obs.1" class="lexicon_definition"></a>
#### cmadsins_obs(obsid::Array{T, 1},  instructionfilename::AbstractString,  inputfilename::AbstractString) [¶](#method__cmadsins_obs.1)
Call C MADS ins_obs() function from the MADS library

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:314](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__computemass.1" class="lexicon_definition"></a>
#### computemass(madsdata::Associative{K, V}) [¶](#method__computemass.1)
Compute injected/reduced contaminant mass

`Mads.computemass(madsdata; time = 0)`

Arguments:

- `madsdata` : Mads data dictionary
- `time` : computational time

Returns:

- `mass_injected` : total injected mass
- `mass_reduced` : total reduced mass


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsAnasol.jl:189](file:///Users/monty/Julia/Mads.jl/src/MadsAnasol.jl)

---

<a id="method__computemass.2" class="lexicon_definition"></a>
#### computemass(madsfiles) [¶](#method__computemass.2)
Compute injected/reduced contaminant mass for a given set of mads input files

`Mads.computemass(madsfiles; time = 0, path = ".")`

Arguments:

- `madsfiles` : matching pattern for Mads input files (string or regular expression accepted)
- `time` : computational time
- `path` : search directory for the mads input files 

Returns:

- `lambda` : array with all the lambda values
- `mass_injected` : array with associated total injected mass
- `mass_reduced` : array with associated total reduced mass


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsAnasol.jl:249](file:///Users/monty/Julia/Mads.jl/src/MadsAnasol.jl)

---

<a id="method__computeparametersensitities.1" class="lexicon_definition"></a>
#### computeparametersensitities(madsdata::Associative{K, V},  saresults::Associative{K, V}) [¶](#method__computeparametersensitities.1)
Compute sensitities for each model parameter; averaging the sensitivity indices over the entire range

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:392](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__contamination.1" class="lexicon_definition"></a>
#### contamination(wellx,  welly,  wellz,  n,  lambda,  theta,  vx,  vy,  vz,  ax,  ay,  az,  H,  x,  y,  z,  dx,  dy,  dz,  f,  t0,  t1,  t) [¶](#method__contamination.1)
Compute concentration for a point in space and time (x,y,z,t)

`Mads.contamination(wellx, welly, wellz, n, lambda, theta, vx, vy, vz, ax, ay, az, H, x, y, z, dx, dy, dz, f, t0, t1, t; anasolfunction="long_bbb_ddd_iir_c")`

Arguments:

- `wellx`
- `welly`
- `wellz`
- `n`
- `lambda`
- `theta`
- `vx`
- `vy`
- `vz`
- `ax`
- `ay`
- `az`
- `H`
- `x`
- `y`
- `z`
- `dx`
- `dy`
- `dz`
- `f`
- `t0`
- `t1`
- `t`
- `anasolfunction` : "long_bbb_ddd_iir_c"


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsAnasol.jl:148](file:///Users/monty/Julia/Mads.jl/src/MadsAnasol.jl)

---

<a id="method__createmadsproblem.1" class="lexicon_definition"></a>
#### createmadsproblem(infilename::AbstractString,  outfilename::AbstractString) [¶](#method__createmadsproblem.1)
Create a new Mads problem where the observation targets are computed based on the model predictions

- `Mads.createmadsproblem(infilename, outfilename)`
- `Mads.createmadsproblem(madsdata, outfilename)`
- `Mads.createmadsproblem(madsdata, predictions, outfilename)

Arguments:

- `infilename` : input Mads file
- `outfilename` : output Mads file
- `madsdata` : Mads data dictionary
- `predictions` : dictionary of model predictions

Returns: `none`



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsCreate.jl:20](file:///Users/monty/Julia/Mads.jl/src/MadsCreate.jl)

---

<a id="method__createobservations.1" class="lexicon_definition"></a>
#### createobservations!(madsdata::Associative{K, V},  time,  observation) [¶](#method__createobservations.1)
Create observations in the MADS data dictionary based on `time` and `observation` arrays 


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:78](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__deletenan.1" class="lexicon_definition"></a>
#### deleteNaN!(df::DataFrames.DataFrame) [¶](#method__deletenan.1)
Delete rows with NaN in a Dataframe `df`

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:608](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__dumpasciifile.1" class="lexicon_definition"></a>
#### dumpasciifile(filename::AbstractString,  data) [¶](#method__dumpasciifile.1)
Dump ASCII file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsASCII.jl:8](file:///Users/monty/Julia/Mads.jl/src/MadsASCII.jl)

---

<a id="method__dumpjsonfile.1" class="lexicon_definition"></a>
#### dumpjsonfile(filename::AbstractString,  data) [¶](#method__dumpjsonfile.1)
Dump JSON file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsJSON.jl:12](file:///Users/monty/Julia/Mads.jl/src/MadsJSON.jl)

---

<a id="method__dumpwellconcentrations.1" class="lexicon_definition"></a>
#### dumpwellconcentrations(filename::AbstractString,  madsdata) [¶](#method__dumpwellconcentrations.1)
Dump well concentrations

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:205](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__dumpyamlfile.1" class="lexicon_definition"></a>
#### dumpyamlfile(filename::AbstractString,  yamldata) [¶](#method__dumpyamlfile.1)
Dump YAML file in JSON format

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:34](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__dumpyamlmadsfile.1" class="lexicon_definition"></a>
#### dumpyamlmadsfile(madsdata,  filename::AbstractString) [¶](#method__dumpyamlmadsfile.1)
Dump YAML MADS file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:147](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__efast.1" class="lexicon_definition"></a>
#### efast(md::Associative{K, V}) [¶](#method__efast.1)
Saltelli's eFAST Algoirthm based on Saltelli extended Fourier Amplituded Sensitivty Testing (eFAST) method

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:635](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__evaluatemadsexpression.1" class="lexicon_definition"></a>
#### evaluatemadsexpression(expressionstring,  parameters) [¶](#method__evaluatemadsexpression.1)
Evaluate the expression in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:62](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__evaluatemadsexpressions.1" class="lexicon_definition"></a>
#### evaluatemadsexpressions(madsdata::Associative{K, V},  parameters) [¶](#method__evaluatemadsexpressions.1)
Evaluate the expressions in terms of the parameters, return a Dict() containing the expression names as keys, and the values of the expression as values

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:71](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__forward.1" class="lexicon_definition"></a>
#### forward(madsdata::Associative{K, V}) [¶](#method__forward.1)
Perform a forward run using the initial or provided values for the model parameters

- `forward(madsdata)`
- `forward(madsdata, paramvalues)`

Arguments:

- `madsdata` : Mads data dictionary
- `paramvalues` : dictionary of model parameter values

Returns:

- `obsvalues` : dictionary of model predictions



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsForward.jl:18](file:///Users/monty/Julia/Mads.jl/src/MadsForward.jl)

---

<a id="method__forwardgrid.1" class="lexicon_definition"></a>
#### forwardgrid(madsdata::Associative{K, V}) [¶](#method__forwardgrid.1)
Perform a forward run over a 3D grid defined in `madsdata` using the initial or provided values for the model parameters

- `forwardgrid(madsdata)`  
- `forwardgrid(madsdata, paramvalues))`

Arguments:

- `madsdata` : Mads data dictionary
- `paramvalues` : dictionary of model parameter values

Returns:

- `array3d` : 3D array with model predictions along a 3D grid



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsForward.jl:45](file:///Users/monty/Julia/Mads.jl/src/MadsForward.jl)

---

<a id="method__getextension.1" class="lexicon_definition"></a>
#### getextension(filename) [¶](#method__getextension.1)
Get file name extension

Example:

```
ext = Mads.getextension("a.mads") # ext = "mads" 
```


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:135](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getmadsdir.1" class="lexicon_definition"></a>
#### getmadsdir() [¶](#method__getmadsdir.1)
Get the directory where currently Mads is running

`problemdir = Mads.getmadsdir()`


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:90](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getmadsinputfile.1" class="lexicon_definition"></a>
#### getmadsinputfile() [¶](#method__getmadsinputfile.1)
Get the default MADS input file set as a MADS global variable using `setmadsinputfile(filename)`

`Mads.getmadsinputfile()`

Arguments: `none`

Returns:

- `filename` : input file name (e.g. `input_file_name.mads`)


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:54](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getmadsproblemdir.1" class="lexicon_definition"></a>
#### getmadsproblemdir(madsdata::Associative{K, V}) [¶](#method__getmadsproblemdir.1)
Get the directory where the Mads data file is located

`Mads.getmadsproblemdir(madsdata)`

Example:

```
madsdata = Mads.loadmadsproblemdir("../../a.mads")
madsproblemdir = Mads.getmadsproblemdir(madsdata)
```

where `madsproblemdir` = `"../../"`


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:81](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getmadsrootname.1" class="lexicon_definition"></a>
#### getmadsrootname(madsdata::Associative{K, V}) [¶](#method__getmadsrootname.1)
Get the MADS problem root name

`madsrootname = Mads.getmadsrootname(madsdata)`


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:63](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getobskeys.1" class="lexicon_definition"></a>
#### getobskeys(madsdata::Associative{K, V}) [¶](#method__getobskeys.1)
Get keys for all the observations in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__getparamdict.1" class="lexicon_definition"></a>
#### getparamdict(madsdata::Associative{K, V}) [¶](#method__getparamdict.1)
Get dictionary with all parameters and their respective initial values

`Mads.getparamdict(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `paramdict` : dictionary with all parameters and their respective initial values


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:33](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__getparamdistributions.1" class="lexicon_definition"></a>
#### getparamdistributions(madsdata::Associative{K, V}) [¶](#method__getparamdistributions.1)
Get distributions of all parameters in the Mads data dictionary

`Mads.getparamdistributions(madsdata; init_dist=false)`

Arguments:

- `madsdata` : Mads data dictionary
- `init_dist` : if true, use the initialization distributions (if defined)


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:248](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__getparamkeys.1" class="lexicon_definition"></a>
#### getparamkeys(madsdata::Associative{K, V}) [¶](#method__getparamkeys.1)
Get keys of all parameters in the MADS dictionary

`Mads.getparamkeys(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `paramkeys` : array with the keys of all parameters in the MADS dictionary


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:14](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__getrootname.1" class="lexicon_definition"></a>
#### getrootname(filename::AbstractString) [¶](#method__getrootname.1)
Get file name root

Example:

```
r = Mads.getrootname("a.rnd.dat") # r = "a"
r = Mads.getrootname("a.rnd.dat", first=false) # r = "a.rnd"

```


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:112](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__getsourcekeys.1" class="lexicon_definition"></a>
#### getsourcekeys(madsdata::Associative{K, V}) [¶](#method__getsourcekeys.1)
Get keys of all source parameters in the MADS dictionary

`Mads.getsourcekeys(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `sourcekeys` : array with keys of all source parameters in the MADS dictionary


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:54](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__getwellkeys.1" class="lexicon_definition"></a>
#### getwellkeys(madsdata::Associative{K, V}) [¶](#method__getwellkeys.1)
Get keys for all the wells in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:8](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__haskeyword.1" class="lexicon_definition"></a>
#### haskeyword(madsdata::Associative{K, V},  keyword::AbstractString) [¶](#method__haskeyword.1)
Check for a `keyword` in a class within the Mads dictionary `madsdata`

- `Mads.haskeyword(madsdata, keyword)`
- `Mads.haskeyword(madsdata, class, keyword)`

Arguments:

- `madsdata` : Mads data dictionary
- `class` : dictionary class; if not provided searches for `keyword` in `Problem` class
- `keyword` : dictionary key

Returns: `true` or `false`

Examples:

- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:54](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__help.1" class="lexicon_definition"></a>
#### help() [¶](#method__help.1)
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

Licensing: GPLv3: http://www.gnu.org/licenses/gpl-3.0.html

MADS Getting started
--------------------

All the MADS analyses are based on MADS data dictionary that defines the problem.
MADS data dictionary is typically loaded from a YAML MADS input file.
The loading of a MADS file can be executed as follows:

`madsdata = Mads.loadmadsfile("<input_file_name>.mads")`

For example, you can load `Mads.jl/examples/contamination/w01short.mads` located in the Mads.jl repository:

`madsdata = Mads.loadmadsfile("Mads.jl/examples/contamination/w01short.mads")`

Typically, MADS data dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations

`Mads.showallparameters(madsdata)` will show all the parameters.

`Mads.showobservations(madsdata)` will list all the observations.

In addition, the MADS data dictionary provides information how to compute model predictions related to the listed observations based on model parameters. 

MADS can perform various types of analyses:

- `saresults = Mads.efast(madsdata)` will perform eFAST sensitivity analysis of the model parameters against the model observations as defined in the MADS data dictionary.
- `iaresults = Mads.calibrate(madsdata)` will perform calibration (inverse analysis) of the model parameters to reproduce the model observations as defined in the MADS data dictionary; in this case, the calibration uses Levenberg-Marquardt optimization.

MADS Licensing & Copyright
--------------------------

Execute `@doc Mads` to see the licensing & copyright information.


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelp.jl:61](file:///Users/monty/Julia/Mads.jl/src/MadsHelp.jl)

---

<a id="method__loadasciifile.1" class="lexicon_definition"></a>
#### loadasciifile(filename::AbstractString) [¶](#method__loadasciifile.1)
Load ASCII file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsASCII.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsASCII.jl)

---

<a id="method__loadjsonfile.1" class="lexicon_definition"></a>
#### loadjsonfile(filename::AbstractString) [¶](#method__loadjsonfile.1)
Load JSON file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsJSON.jl:6](file:///Users/monty/Julia/Mads.jl/src/MadsJSON.jl)

---

<a id="method__loadmadsfile.1" class="lexicon_definition"></a>
#### loadmadsfile(filename::AbstractString) [¶](#method__loadmadsfile.1)
Load MADS input file defining a MADS class set

- `Mads.loadmadsfile(filename)`
- `Mads.loadmadsfile(filename; julia=false)`
- `Mads.loadmadsfile(filename; julia=true)`

Arguments:

- `filename` : input file name (e.g. `input_file_name.mads`)
- `julia` : if `true`, force using `julia` parsing fuctions; if `false` (default), use `python` parsing functions [boolean]

Returns:

- `madsdata` : Loaded Mads data class

Example: `md = loadmadsfile("input_file_name.mads")`


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:19](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__loadyamlfile.1" class="lexicon_definition"></a>
#### loadyamlfile(filename::AbstractString) [¶](#method__loadyamlfile.1)
Load YAML file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:24](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__loadyamlmadsfile.1" class="lexicon_definition"></a>
#### loadyamlmadsfile(filename::AbstractString) [¶](#method__loadyamlmadsfile.1)
Load YAML MADS file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:45](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__localsa.1" class="lexicon_definition"></a>
#### localsa(madsdata::Associative{K, V}) [¶](#method__localsa.1)
Local sensitivity analysis

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:50](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__madscrit.1" class="lexicon_definition"></a>
#### madscrit(message::AbstractString) [¶](#method__madscrit.1)
MADS critical error messages

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:31](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__madsdebug.1" class="lexicon_definition"></a>
#### madsdebug(message::AbstractString) [¶](#method__madsdebug.1)
MADS debug messages

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:9](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__madserr.1" class="lexicon_definition"></a>
#### madserr(message::AbstractString) [¶](#method__madserr.1)
MADS error messages

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:26](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__madsinfo.1" class="lexicon_definition"></a>
#### madsinfo(message::AbstractString) [¶](#method__madsinfo.1)
MADS information/status messages

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:16](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__madsoutput.1" class="lexicon_definition"></a>
#### madsoutput(message::AbstractString) [¶](#method__madsoutput.1)
MADS output

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__madswarn.1" class="lexicon_definition"></a>
#### madswarn(message::AbstractString) [¶](#method__madswarn.1)
MADS warning messages

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsLog.jl:21](file:///Users/monty/Julia/Mads.jl/src/MadsLog.jl)

---

<a id="method__makearrayconditionalloglikelihood.1" class="lexicon_definition"></a>
#### makearrayconditionalloglikelihood(madsdata::Associative{K, V},  conditionalloglikelihood) [¶](#method__makearrayconditionalloglikelihood.1)
Make a conditional log likelihood function that accepts an array containing the opt parameters' values

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:27](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__makearrayfunction.1" class="lexicon_definition"></a>
#### makearrayfunction(madsdata::Associative{K, V},  f::Function) [¶](#method__makearrayfunction.1)
Make a version of the function `f` that accepts an array containing the optimal parameters' values

`Mads.makearrayfunction(madsdata, f)`

Arguments:

- `madsdata` : Mads data dictionary
- `f` : ...

Returns:

- `arrayfunction` : function accepting an array containing the optimal parameters' values




*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:17](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__makearrayloglikelihood.1" class="lexicon_definition"></a>
#### makearrayloglikelihood(madsdata::Associative{K, V},  loglikelihood) [¶](#method__makearrayloglikelihood.1)
Make a log likelihood function that accepts an array containing the opt parameters' values

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:40](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__makecomputeconcentrations.1" class="lexicon_definition"></a>
#### makecomputeconcentrations(madsdata::Associative{K, V}) [¶](#method__makecomputeconcentrations.1)
Create a function to compute concentrations for all the observation points using Anasol

`Mads.makecomputeconcentrations(madsdata)`

Arguments:

- `madsdata` : Mads data dictionary

Returns:

- `computeconcentrations` : function to compute concentrations; `computeconcentrations` returns a dictionary of observations and model predicted concentrations

Examples:

`computeconcentrations()`

or

```
computeconcentrations = Mads.makecomputeconcentrations(madsdata)
paramkeys = Mads.getparamkeys(madsdata)
paramdict = OrderedDict(zip(paramkeys, map(key->madsdata["Parameters"][key]["init"], paramkeys)))
forward_preds = computeconcentrations(paramdict)
```


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsAnasol.jl:30](file:///Users/monty/Julia/Mads.jl/src/MadsAnasol.jl)

---

<a id="method__makemadscommandfunction.1" class="lexicon_definition"></a>
#### makemadscommandfunction(madsdata::Associative{K, V}) [¶](#method__makemadscommandfunction.1)
Make MADS command function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:6](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__makemadscommandfunctionandgradient.1" class="lexicon_definition"></a>
#### makemadscommandfunctionandgradient(madsdata::Associative{K, V}) [¶](#method__makemadscommandfunctionandgradient.1)
Make MADS command function & gradient function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:162](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__makemadscommandfunctionandgradient.2" class="lexicon_definition"></a>
#### makemadscommandfunctionandgradient(madsdata::Associative{K, V},  f::Function) [¶](#method__makemadscommandfunctionandgradient.2)
Make MADS command function and gradient function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:168](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__makemadscommandgradient.1" class="lexicon_definition"></a>
#### makemadscommandgradient(madsdata::Associative{K, V}) [¶](#method__makemadscommandgradient.1)
Make MADS command gradient function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:146](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__makemadscommandgradient.2" class="lexicon_definition"></a>
#### makemadscommandgradient(madsdata::Associative{K, V},  f::Function) [¶](#method__makemadscommandgradient.2)
Make MADS command gradient function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:152](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__makemadsloglikelihood.1" class="lexicon_definition"></a>
#### makemadsloglikelihood(madsdata::Associative{K, V}) [¶](#method__makemadsloglikelihood.1)
Make MADS loglikelihood function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsFunc.jl:260](file:///Users/monty/Julia/Mads.jl/src/MadsFunc.jl)

---

<a id="method__maxtorealmaxfloat32.1" class="lexicon_definition"></a>
#### maxtorealmaxFloat32!(df::DataFrames.DataFrame) [¶](#method__maxtorealmaxfloat32.1)
Scale down values larger than max(Float32) in a Dataframe `df` so that Gadfly can plot the data

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:620](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__montecarlo.1" class="lexicon_definition"></a>
#### montecarlo(madsdata::Associative{K, V}) [¶](#method__montecarlo.1)
Monte Carlo analysis

`Mads.montecarlo(madsdata; N=100)`

Arguments:

- `madsdata` : Mads data dictionary
- `N` : number of samples (default = 100)

Returns:

- `outputdicts` : parameter dictionary containing the data arrays

Dumps:

- YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:76](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__nothing2nan.1" class="lexicon_definition"></a>
#### nothing2nan!(dict::Associative{K, V}) [¶](#method__nothing2nan.1)
Convert Void's into NaN's in a dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:588](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__paramarray2dict.1" class="lexicon_definition"></a>
#### paramarray2dict(madsdata::Associative{K, V},  array) [¶](#method__paramarray2dict.1)
Convert parameter array to a parameter dictionary of arrays


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:124](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__parametersample.1" class="lexicon_definition"></a>
#### parametersample(madsdata::Associative{K, V},  numsamples::Integer) [¶](#method__parametersample.1)
Independent sampling of MADS Model parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:10](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__parametersample.2" class="lexicon_definition"></a>
#### parametersample(madsdata::Associative{K, V},  numsamples::Integer,  parameterkey::AbstractString) [¶](#method__parametersample.2)
Independent sampling of MADS Model parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:10](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__paramrand.1" class="lexicon_definition"></a>
#### paramrand(madsdata::Associative{K, V},  parameterkey::AbstractString) [¶](#method__paramrand.1)
Random numbers for a MADS Model parameter defined by `parameterkey`

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:24](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__plotsaresults_monty.1" class="lexicon_definition"></a>
#### plotSAresults_monty(wellname,  madsdata,  result) [¶](#method__plotsaresults_monty.1)
Plot the sensitivity analysis results for each well (Specific plot requested by Monty)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:1445](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__plotgrid.1" class="lexicon_definition"></a>
#### plotgrid(madsdata::Associative{K, V}) [¶](#method__plotgrid.1)
Plot a 3D grid solution 

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:151](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotgrid.2" class="lexicon_definition"></a>
#### plotgrid(madsdata::Associative{K, V},  parameters::Associative{K, V}) [¶](#method__plotgrid.2)
Plot a 3D grid solution 

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:157](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotgrid.3" class="lexicon_definition"></a>
#### plotgrid(madsdata::Associative{K, V},  s::Array{Float64, N}) [¶](#method__plotgrid.3)
Plot a 3D grid solution based on s 

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:105](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotmadsproblem.1" class="lexicon_definition"></a>
#### plotmadsproblem(madsdata::Associative{K, V}) [¶](#method__plotmadsproblem.1)
Plot MADS problem

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:43](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotmass.1" class="lexicon_definition"></a>
#### plotmass(lambda,  mass_injected,  mass_reduced,  filename::AbstractString) [¶](#method__plotmass.1)
Plot injected/reduced contaminant mass

- `Mads.plotmass(lambda, mass_injected, mass_reduced, filename="file_name")`

Arguments:

- `lambda` : array with all the lambda values
- `mass_injected` : array with associated total injected mass
- `mass_reduced` : array with associated total reduced mass
- `filename` : output filename for the generated plot
- `format` : output plot format (`png`, `pdf`, etc.)

Dumps: image file with name `filename` and in specified `format`


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsAnasol.jl:286](file:///Users/monty/Julia/Mads.jl/src/MadsAnasol.jl)

---

<a id="method__plotobssaresults.1" class="lexicon_definition"></a>
#### plotobsSAresults(madsdata,  result) [¶](#method__plotobssaresults.1)
Plot the sensitivity analysis results for the observations

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:386](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotwellsaresults.1" class="lexicon_definition"></a>
#### plotwellSAresults(madsdata,  result) [¶](#method__plotwellsaresults.1)
Plot the sensitivity analysis results for all wells (wells class expected)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:294](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__plotwellsaresults.2" class="lexicon_definition"></a>
#### plotwellSAresults(madsdata,  result,  wellname) [¶](#method__plotwellsaresults.2)
Plot the sensitivity analysis results for each well (wells class expected)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:307](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__printsaresults.1" class="lexicon_definition"></a>
#### printSAresults(madsdata::Associative{K, V},  results::Associative{K, V}) [¶](#method__printsaresults.1)
Print the sensitivity analysis results

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:477](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__quietoff.1" class="lexicon_definition"></a>
#### quietoff() [¶](#method__quietoff.1)
Make MADS not quiet

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:7](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__quieton.1" class="lexicon_definition"></a>
#### quieton() [¶](#method__quieton.1)
Make MADS quiet

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__readasciipredictions.1" class="lexicon_definition"></a>
#### readasciipredictions(filename::AbstractString) [¶](#method__readasciipredictions.1)
Read MADS predictions from an ASCII file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsASCII.jl:13](file:///Users/monty/Julia/Mads.jl/src/MadsASCII.jl)

---

<a id="method__readjsonpredictions.1" class="lexicon_definition"></a>
#### readjsonpredictions(filename::AbstractString) [¶](#method__readjsonpredictions.1)
Read MADS predictions from a JSON file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsJSON.jl:19](file:///Users/monty/Julia/Mads.jl/src/MadsJSON.jl)

---

<a id="method__readobservations.1" class="lexicon_definition"></a>
#### readobservations(madsdata::Associative{K, V}) [¶](#method__readobservations.1)
Read observations

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:280](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__readobservations_cmads.1" class="lexicon_definition"></a>
#### readobservations_cmads(madsdata::Associative{K, V}) [¶](#method__readobservations_cmads.1)
Read observations using C Mads library

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:300](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__readyamlpredictions.1" class="lexicon_definition"></a>
#### readyamlpredictions(filename::AbstractString) [¶](#method__readyamlpredictions.1)
Read predictions from YAML MADS file

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsYAML.jl:200](file:///Users/monty/Julia/Mads.jl/src/MadsYAML.jl)

---

<a id="method__resetmodelruns.1" class="lexicon_definition"></a>
#### resetmodelruns() [¶](#method__resetmodelruns.1)
Reset the model runs count to be equal to zero

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:30](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__rosenbrock.1" class="lexicon_definition"></a>
#### rosenbrock(x::Array{T, 1}) [¶](#method__rosenbrock.1)
Rosenbrock test function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:17](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock2_gradient_lm.1" class="lexicon_definition"></a>
#### rosenbrock2_gradient_lm(x) [¶](#method__rosenbrock2_gradient_lm.1)
Parameter gradients of the Rosenbrock test function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:7](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock2_lm.1" class="lexicon_definition"></a>
#### rosenbrock2_lm(x) [¶](#method__rosenbrock2_lm.1)
Rosenbrock test function (more difficult to solve)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock_gradient.1" class="lexicon_definition"></a>
#### rosenbrock_gradient!(x::Array{T, 1},  storage::Array{T, 1}) [¶](#method__rosenbrock_gradient.1)
Parameter gradients of the Rosenbrock test function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:27](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock_gradient_lm.1" class="lexicon_definition"></a>
#### rosenbrock_gradient_lm(x::Array{T, 1}) [¶](#method__rosenbrock_gradient_lm.1)
Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separetely)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:33](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock_hessian.1" class="lexicon_definition"></a>
#### rosenbrock_hessian!(x::Array{T, 1},  storage::Array{T, 2}) [¶](#method__rosenbrock_hessian.1)
Parameter Hessian of the Rosenbrock test function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:43](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__rosenbrock_lm.1" class="lexicon_definition"></a>
#### rosenbrock_lm(x::Array{T, 1}) [¶](#method__rosenbrock_lm.1)
Rosenbrock test function for LM optimization (returns the 2 components separetely)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl:22](file:///Users/monty/Julia/Mads.jl/src/MadsTestFunctions.jl)

---

<a id="method__saltelli.1" class="lexicon_definition"></a>
#### saltelli(madsdata::Associative{K, V}) [¶](#method__saltelli.1)
Saltelli 

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:264](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__saltellibrute.1" class="lexicon_definition"></a>
#### saltellibrute(madsdata::Associative{K, V}) [¶](#method__saltellibrute.1)
Saltelli (brute force)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:125](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__saltelliprintresults2.1" class="lexicon_definition"></a>
#### saltelliprintresults2(madsdata::Associative{K, V},  results::Associative{K, V}) [¶](#method__saltelliprintresults2.1)
Print the sensitivity analysis results (method 2)

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSA.jl:553](file:///Users/monty/Julia/Mads.jl/src/MadsSA.jl)

---

<a id="method__searchdir.1" class="lexicon_definition"></a>
#### searchdir(key::Regex) [¶](#method__searchdir.1)
Get files in the current directory or in a directory difined by `path` matching pattern `key` which cann be a string or regular expression

- `Mads.searchdir(key)`
- `Mads.searchdir(key; path = ".")`

Arguments:

- `key` : matching pattern for Mads input files (string or regular expression accepted)
- `path` : search directory for the mads input files

Returns:

- `filename` : an array with file names matching the pattern in the specified directory


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:160](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__setallparamsoff.1" class="lexicon_definition"></a>
#### setallparamsoff!(madsdata::Associative{K, V}) [¶](#method__setallparamsoff.1)
Set all parameters OFF

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:124](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setallparamson.1" class="lexicon_definition"></a>
#### setallparamson!(madsdata::Associative{K, V}) [¶](#method__setallparamson.1)
Set all parameters ON

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:116](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setdebuglevel.1" class="lexicon_definition"></a>
#### setdebuglevel(level::Int64) [¶](#method__setdebuglevel.1)
Set MADS debug level

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:20](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__setdynamicmodel.1" class="lexicon_definition"></a>
#### setdynamicmodel(madsdata::Associative{K, V},  f::Function) [¶](#method__setdynamicmodel.1)
Set Dynamic Model for MADS model calls using internal Julia functions

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMisc.jl:57](file:///Users/monty/Julia/Mads.jl/src/MadsMisc.jl)

---

<a id="method__setimagefileformat.1" class="lexicon_definition"></a>
#### setimagefileformat!(filename,  format) [¶](#method__setimagefileformat.1)
Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

`Mads.setimagefileformat!(filename, format)`

Arguments:

- `filename` : output file name used to dump plots
- `format` : output plot format (`png`, `pdf`, etc.)

Returns:

- `filename` : output file name used to dump plots
- `format` : output plot format (`png`, `pdf`, etc.)



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsPlot.jl:17](file:///Users/monty/Julia/Mads.jl/src/MadsPlot.jl)

---

<a id="method__setmadsinputfile.1" class="lexicon_definition"></a>
#### setmadsinputfile(filename::AbstractString) [¶](#method__setmadsinputfile.1)
Set a default MADS input file

`Mads.setmadsinputfile(filename)`

Arguments:

- `filename` : input file name (e.g. `input_file_name.mads`)


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:39](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__setnprocs.1" class="lexicon_definition"></a>
#### setnprocs(np) [¶](#method__setnprocs.1)
Set number of processors

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParallel.jl:15](file:///Users/monty/Julia/Mads.jl/src/MadsParallel.jl)

---

<a id="method__setnprocs.2" class="lexicon_definition"></a>
#### setnprocs(np,  nt) [¶](#method__setnprocs.2)
Set number of processors / threads

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParallel.jl:2](file:///Users/monty/Julia/Mads.jl/src/MadsParallel.jl)

---

<a id="method__setobservationtargets.1" class="lexicon_definition"></a>
#### setobservationtargets!(madsdata::Associative{K, V},  predictions::Associative{K, V}) [¶](#method__setobservationtargets.1)
Set observations (calibration targets) in the MADS data dictionary based on `predictions` dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:100](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__setparamoff.1" class="lexicon_definition"></a>
#### setparamoff!(madsdata::Associative{K, V},  parameterkey) [¶](#method__setparamoff.1)
Set a specific parameter with a key `parameterkey`  OFF

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:137](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setparamon.1" class="lexicon_definition"></a>
#### setparamon!(madsdata::Associative{K, V},  parameterkey) [¶](#method__setparamon.1)
Set a specific parameter with a key `parameterkey` ON

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:132](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setparamsdistnormal.1" class="lexicon_definition"></a>
#### setparamsdistnormal!(madsdata::Associative{K, V},  mean,  stddev) [¶](#method__setparamsdistnormal.1)
Set normal parameter distributions for all the model parameters in the MADS data dictionary

`Mads.setparamsdistnormal!(madsdata, mean, stddev)`

Arguments:

- `madsdata` : Mads data dictionary
- `mean` : array with the mean values
- `stddev` : array with the standard deviation values


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:152](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setparamsdistuniform.1" class="lexicon_definition"></a>
#### setparamsdistuniform!(madsdata::Associative{K, V},  min,  max) [¶](#method__setparamsdistuniform.1)
Set uniform parameter distributions for all the model parameters in the MADS data dictionary

`Mads.setparamsdistuniform!(madsdata, min, max)`

Arguments:

- `madsdata` : Mads data dictionary
- `min` : array with the minimum values
- `max` : array with the maximum values


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:170](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setparamsinit.1" class="lexicon_definition"></a>
#### setparamsinit!(madsdata::Associative{K, V},  paramdict::Associative{K, V}) [¶](#method__setparamsinit.1)
Set initial parameter guesses in the MADS dictionary

`Mads.setparamsinit!(madsdata, paramdict)`

Arguments:

- `madsdata` : Mads data dictionary
- `paramdict` : dictionary with initial model parameter values


*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:108](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__setverbositylevel.1" class="lexicon_definition"></a>
#### setverbositylevel(level::Int64) [¶](#method__setverbositylevel.1)
Set MADS verbosity level

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsHelpers.jl:25](file:///Users/monty/Julia/Mads.jl/src/MadsHelpers.jl)

---

<a id="method__showallparameters.1" class="lexicon_definition"></a>
#### showallparameters(madsdata::Associative{K, V}) [¶](#method__showallparameters.1)
Show all parameters in the Mads data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:221](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__showobservations.1" class="lexicon_definition"></a>
#### showobservations(madsdata::Associative{K, V}) [¶](#method__showobservations.1)
Show observations in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:62](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__showparameters.1" class="lexicon_definition"></a>
#### showparameters(madsdata::Associative{K, V}) [¶](#method__showparameters.1)
Show optimizable parameters in the Mads data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsParameters.jl:209](file:///Users/monty/Julia/Mads.jl/src/MadsParameters.jl)

---

<a id="method__sinetransform.1" class="lexicon_definition"></a>
#### sinetransform(sineparams::Array{T, 1},  lowerbounds::Array{T, 1},  upperbounds::Array{T, 1},  indexlogtransformed::Array{T, 1}) [¶](#method__sinetransform.1)
Sine transformation of model parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSine.jl:10](file:///Users/monty/Julia/Mads.jl/src/MadsSine.jl)

---

<a id="method__sinetransformfunction.1" class="lexicon_definition"></a>
#### sinetransformfunction(f::Function,  lowerbounds::Array{T, 1},  upperbounds::Array{T, 1},  indexlogtransformed::Array{T, 1}) [¶](#method__sinetransformfunction.1)
Sine transformation of a function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSine.jl:17](file:///Users/monty/Julia/Mads.jl/src/MadsSine.jl)

---

<a id="method__sinetransformgradient.1" class="lexicon_definition"></a>
#### sinetransformgradient(g::Function,  lowerbounds::Array{T, 1},  upperbounds::Array{T, 1},  indexlogtransformed::Array{T, 1}) [¶](#method__sinetransformgradient.1)
Sine transformation of a gradient function

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsSine.jl:25](file:///Users/monty/Julia/Mads.jl/src/MadsSine.jl)

---

<a id="method__spaghettiplot.1" class="lexicon_definition"></a>
#### spaghettiplot(madsdata::Associative{K, V},  paramdictarray::DataStructures.OrderedDict{K, V}) [¶](#method__spaghettiplot.1)
Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

`Mads.spaghettiplot(madsdata, paramdictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)`

Arguments:

- `madsdata` : Mads data dictionary
- `paramdictarray` : dictionary containing the parameter data arrays to be plotted
- `filename` : output file name used to output the produced plots
- `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)
- `format` : output plot format (`png`, `pdf`, etc.)
- `xtitle` : `x` axis title
- `ytitle` : `y` axis title
- `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)

Returns: `none`

Dumps:

- Image files (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:270](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__spaghettiplots.1" class="lexicon_definition"></a>
#### spaghettiplots(madsdata::Associative{K, V},  paramdictarray::DataStructures.OrderedDict{K, V}) [¶](#method__spaghettiplots.1)
Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

`Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true )`

Arguments:

- `madsdata` : Mads data dictionary
- `paramdictarray` : parameter dictionary containing the data arrays to be plotted
- `keyword` : keyword to be added in the file name used to output the produced plots
- `format` : output plot format (`png`, `pdf`, etc.)
- `xtitle` : `x` axis title
- `ytitle` : `y` axis title
- `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)

Returns: `none`

Dumps:

- Image files (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)



*source:*
[/Users/monty/Julia/Mads.jl/src/MadsMC.jl:155](file:///Users/monty/Julia/Mads.jl/src/MadsMC.jl)

---

<a id="method__welloff.1" class="lexicon_definition"></a>
#### welloff!(madsdata,  wellname::AbstractString) [¶](#method__welloff.1)
Turn off a specific well in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:148](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__wellon.1" class="lexicon_definition"></a>
#### wellon!(madsdata::Associative{K, V},  wellname::AbstractString) [¶](#method__wellon.1)
Turn on a specific well in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:124](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__wells2observations.1" class="lexicon_definition"></a>
#### wells2observations!(madsdata::Associative{K, V}) [¶](#method__wells2observations.1)
Convert `Wells` class to `Observations` class in the MADS data dictionary

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsObservations.jl:164](file:///Users/monty/Julia/Mads.jl/src/MadsObservations.jl)

---

<a id="method__writeparameters.1" class="lexicon_definition"></a>
#### writeparameters(madsdata::Associative{K, V}) [¶](#method__writeparameters.1)
Write initial parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:191](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__writeparameters.2" class="lexicon_definition"></a>
#### writeparameters(madsdata::Associative{K, V},  parameters) [¶](#method__writeparameters.2)
Write parameters

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:198](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

---

<a id="method__writeparametersviatemplate.1" class="lexicon_definition"></a>
#### writeparametersviatemplate(parameters,  templatefilename,  outputfilename) [¶](#method__writeparametersviatemplate.1)
Write parameters via MADS template

*source:*
[/Users/monty/Julia/Mads.jl/src/MadsIO.jl:164](file:///Users/monty/Julia/Mads.jl/src/MadsIO.jl)

