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


"""
MADS Getting started
--------------------

MADS data dictionary is typically loaded from a YAML MADS input file. The loading of a MADS file can be done as follows:

`madsdata = Mads.loadmadsfiles("<input_file_name>.mads")`

For example, you can do:

`madsdata = Mads.loadmadsfile("Mads.jl/examples/contamination/w01.mads")`

where `examples/contamination/w01.mads` is located in the Mads.jl repository.

Typically, MADS data dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations
- `Model` : model applied to compute model observations (predictions) for a given send of model parameters

`Mads.showallparameters(madsdata)` will show all the parameters.

`Mads.showobservations(madsdata)` will list all the observations.

MADS can perform various types of analyses:

- `saresults = Mads.efast(madsdata)` will perform eFAST sensitivity analysis.
"""
function help()
	@doc Mads.help
end
