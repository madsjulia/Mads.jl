"Make MADS quiet"
function quieton()
	global quiet = true;
end

"Make MADS not quiet"
function quietoff()
	global quiet = false;
end

"MADS graph output on"
function graphon()
	global graphoutput = true;
end

"MADS graph output off"
function graphoff()
	global graphoutput = false;
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
Check for a `keyword` in a `class` within the Mads dictionary `madsdata`

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
function haskeyword(madsdata::Associative, keyword::String)
	return haskey(madsdata, "Problem") ? haskeyword(madsdata, "Problem", keyword) : false
end
function haskeyword(madsdata::Associative, class::String, keyword::String)
	if typeof(madsdata[class]) <: Associative
		return haskey(madsdata[class], keyword) ? true : false
	elseif typeof(madsdata[class]) <: String
		return madsdata[class] == keyword
	elseif typeof(madsdata[class]) <: Vector{ASCIIString}
		for i in madsdata[class]
			if i == keyword
				return true
			end
		end
		return false
	else
		return false
	end
end

"Add a `keyword` in a `class` within the Mads dictionary `madsdata`"
function addkeyword!(madsdata::Associative, keyword::String)
	haskey(madsdata, "Problem") ? addkeyword!(madsdata, "Problem", keyword) : madsdata["Problem"] = keyword
	return
end
function addkeyword!(madsdata::Associative, class::String, keyword::String)
	if haskeyword(madsdata, class, keyword)
		madswarn("Keyword already `$keyword` exists")
		return
	end
	if typeof(madsdata[class]) <: Associative
		push!(madsdata[class], keyword=>true)
	elseif typeof(madsdata[class]) <: String
		madsdata[class] = [keyword, madsdata[class]]
	elseif typeof(madsdata[class]) <: Vector{ASCIIString}
		push!(madsdata[class], keyword)
	end
end