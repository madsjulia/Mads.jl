"Make MADS quiet"
function quieton()
	global quiet = true;
end

"Make MADS not quiet"
function quietoff()
	global quiet = false;
end

"Turn on the generation of MADS tests (dangerous)"
function create_tests_on()
	global create_tests = true;
end

"Turn off the generation of MADS tests (default)"
function create_tests_off()
	global create_tests = false;
end

"Turn on execution of long MADS tests (dangerous)"
function long_tests_on()
	global long_tests = true;
end

"Turn off execution of long MADS tests (default)"
function long_tests_off()
	global long_tests = false;
end

"Set MADS debug level"
function setdebuglevel(level::Int)
	global debuglevel = level
end

"Set MADS verbosity level"
function setverbositylevel(level::Int)
	global verbositylevel = level
end

"Reset the model runs count to be equal to zero"
function resetmodelruns()
	global modelruns = 0
end

"""
Check for a `keyword` in a class within the Mads dictionary `madsdata`

- `Mads.haskeyword(madsdata, keyword)`
- `Mads.haskeyword(madsdata, class, keyword)`

Arguments:

- `madsdata` : MADS problem dictionary
- `class` : dictionary class; if not provided searches for `keyword` in `Problem` class
- `keyword` : dictionary key

Returns: `true` or `false`

Examples:

- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
"""
function haskeyword(madsdata::Associative, keyword::AbstractString)
	return haskey(madsdata, "Problem") ? haskeyword(madsdata, "Problem", keyword) : false
end

function haskeyword(madsdata::Associative, class::AbstractString, keyword::AbstractString)
	return haskey(madsdata[class], keyword) ? true : false
end