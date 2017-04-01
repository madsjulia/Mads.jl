"""
MADS restart on

$(documentfunction(restarton))
"""
function restarton()
	global restart = true;
end

"""
MADS restart off

$(documentfunction(restartoff))
"""
function restartoff()
	global restart = false;
end

"""
Get MADS restart status

$(documentfunction(getrestart))
"""
function getrestart(madsdata::Associative)
	haskey(madsdata, "Restart") ? madsdata["Restart"] : restart # note madsdata["Restart"] can be a string
end

"""
Make MADS quiet

$(documentfunction(quieton))
"""
function quieton()
	ReusableFunctions.quieton()
	global quiet = true;
end

"""
Make MADS not quiet

$(documentfunction(quietoff))
"""
function quietoff()
	ReusableFunctions.quietoff()
	global quiet = false;
end

"""
MADS graph output on

$(documentfunction(graphon))
"""
function graphon()
	global graphoutput = true;
end

"""
MADS graph output off

$(documentfunction(graphoff))
"""
function graphoff()
	global graphoutput = false;
end

"""
Turn on the generation of MADS tests (dangerous)

$(documentfunction(create_tests_on))
"""
function create_tests_on()
	global create_tests = true;
end

"""
Turn off the generation of MADS tests (default)

$(documentfunction(create_tests_off))
"""
function create_tests_off()
	global create_tests = false;
end

"""
Turn on execution of long MADS tests (dangerous)

$(documentfunction(long_tests_on))
"""
function long_tests_on()
	global long_tests = true;
end

"""
Turn off execution of long MADS tests (default)

$(documentfunction(long_tests_off))
"""
function long_tests_off()
	global long_tests = false;
end

"""
Set MADS debug level

$(documentfunction(setdebuglevel))
"""
function setdebuglevel(level::Int)
	global debuglevel = level
end

"""
Set MADS verbosity level

$(documentfunction(setverbositylevel))
"""
function setverbositylevel(level::Int)
	global verbositylevel = level
end

"""
Reset the model runs count to be equal to zero

$(documentfunction(resetmodelruns))
"""
function resetmodelruns()
	global modelruns = 0
end

function haskeyword(madsdata::Associative, keyword::String)
	return haskey(madsdata, "Problem") ? haskeyword(madsdata, "Problem", keyword) : false
end
function haskeyword(madsdata::Associative, class::String, keyword::String)
	if typeof(madsdata[class]) <: Associative
		return haskey(madsdata[class], keyword) ? true : false
	elseif typeof(madsdata[class]) <: String
		return madsdata[class] == keyword
	elseif typeof(madsdata[class]) <: Vector{String}
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

@doc """
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

$(documentfunction(haskeyword))
""" haskeyword

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
	elseif typeof(madsdata[class]) <: Vector{String}
		push!(madsdata[class], keyword)
	end
end

@doc """
Add a `keyword` in a `class` within the Mads dictionary `madsdata`

$(documentfunction(addkeyword!))
""" addkeyword!

function deletekeyword!(madsdata::Associative, keyword::String)
	if haskeyword(madsdata, keyword)
		deletekeyword!(madsdata, "Problem", keyword)
	end
	return
end
function deletekeyword!(madsdata::Associative, class::String, keyword::String)
	if haskeyword(madsdata, class, keyword)
		if typeof(madsdata[class]) <: Associative && haskey(madsdata[class], keyword)
			delete!(madsdata[class], keyword)
		elseif typeof(madsdata[class]) <: String
			madsdata[class] = ""
		elseif typeof(madsdata[class]) <: Vector{String}
			v = madsdata[class]
			madsdata[class] = v[v .!= keyword]
		end
	end
end

@doc """
Delete a `keyword` in a `class` within the Mads dictionary `madsdata`

$(documentfunction(deletekeyword!))
""" deletekeyword!

"""
Get sin-space dx

$(documentfunction(getsindx))
"""
function getsindx(madsdata::Associative)
	sindx = 0.1
	if Mads.haskeyword(madsdata, "sindx")
		sindx = madsdata["Problem"]["sindx"]
		if typeof(sindx) == String
			sindx = float(sindx)
		end
	end
	return sindx
end

"""
Transpose non-numeric vector

$(documentfunction(transposevector))
"""
function transposevector(a::Vector)
	reshape(a, 1, length(a))
end

"""
Transpose non-numeric matrix

$(documentfunction(transposematrix))
"""
function transposematrix(a::Matrix)
	permutedims(a, (2, 1))
end

"Print error message"
function printerrormsg(e::Any)
	if in(:msg, fieldnames(e))
		print(e.msg)
	else
		print(e)
	end
end

"""
Mesh grid

$(documentfunction(meshgrid))
"""
function meshgrid(min::Vector, max::Vector)
    m = length(min)
    n = length(max)
    max = reshape(max, 1, n)
    min = reshape(min, m, 1)
    (repmat(max, m, 1), repmat(min, 1, n))
end