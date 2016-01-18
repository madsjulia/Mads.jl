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

MADS data dictionary is typically loaded from a YAML MADS input file. For example,

`madsdata = Mads.loadmadsfiles("input_file_name.mads")`

Typically, MADS data dictionary includes several classes:

- `Parameters` : lists of model parameters
- `Observations` : lists of model observations
- `Model` : model applied to compute model observations (predictions) for a given send of model parameters

`Mads.showallparameters(madsdata)` will show all the parameters.

`Mads.showobservations(madsdata)` will list all the observations.

"""
function help()
	@doc Mads.help
end
