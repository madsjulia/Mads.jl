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
