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

MADS data dictionary is typically loaded from YAML MADS input file. For example,

`madsdata = Mads.loadmadsfiles("input_file_name.mads")`

"""
function help()
	@doc Mads.help
end
