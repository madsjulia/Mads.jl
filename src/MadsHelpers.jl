import DocumentFunction

"""
MADS restart on

$(DocumentFunction.documentfunction(restarton))
"""
function restarton()
	global restart = true;
end

"""
MADS restart off

$(DocumentFunction.documentfunction(restartoff))
"""
function restartoff()
	global restart = false;
end

"""
Get MADS restart status

$(DocumentFunction.documentfunction(getrestart;
argtext=Dict("madsdata"=>"MADS problem dictionary")))
"""
function getrestart(madsdata::Associative)
	haskey(madsdata, "Restart") ? madsdata["Restart"] : restart # note madsdata["Restart"] can be a string
end

"""
Make MADS quiet

$(DocumentFunction.documentfunction(quieton))
"""
function quieton()
	ReusableFunctions.quieton()
	global quiet = true;
end

"""
Make MADS not quiet

$(DocumentFunction.documentfunction(quietoff))
"""
function quietoff()
	ReusableFunctions.quietoff()
	global quiet = false;
end

"""
MADS graph output on

$(DocumentFunction.documentfunction(graphon))
"""
function graphon()
	global graphoutput = true;
end

"""
MADS graph output off

$(DocumentFunction.documentfunction(graphoff))
"""
function graphoff()
	global graphoutput = false;
end

"""
Turn on the generation of MADS tests (dangerous)

$(DocumentFunction.documentfunction(create_tests_on))
"""
function create_tests_on()
	global create_tests = true;
end

"""
Turn off the generation of MADS tests (default)

$(DocumentFunction.documentfunction(create_tests_off))
"""
function create_tests_off()
	global create_tests = false;
end

"""
Turn on execution of long MADS tests

$(DocumentFunction.documentfunction(long_tests_on))
"""
function long_tests_on()
	global long_tests = true;
end

"""
Turn off execution of long MADS tests (default)

$(DocumentFunction.documentfunction(long_tests_off))
"""
function long_tests_off()
	global long_tests = false;
end

"""
Set MADS debug level

$(DocumentFunction.documentfunction(setdebuglevel;
argtext=Dict("level"=>"debug level")))
"""
function setdebuglevel(level::Int)
	global debuglevel = level
end

"""
Set MADS verbosity level

$(DocumentFunction.documentfunction(setverbositylevel;
argtext=Dict("level"=>"debug level")))
"""
function setverbositylevel(level::Int)
	global verbositylevel = level
end

"""
Set maximum execution wait time for forward model runs in seconds

$(DocumentFunction.documentfunction(setexecutionwaittime;
argtext=Dict("waitime"=>"maximum execution wait time for forward model runs in seconds")))
"""
function setexecutionwaittime(waitime::Float64)
	global executionwaittime = waitime
end

"""
Reset the model runs count to be equal to zero

$(DocumentFunction.documentfunction(resetmodelruns))
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

$(DocumentFunction.documentfunction(haskeyword;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "keyword"=>"dictionary key",
            "class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))

Returns: `true` or `false`

Examples:

```julia
- `Mads.haskeyword(madsdata, "disp")` ... searches in `Problem` class by default
- `Mads.haskeyword(madsdata, "Wells", "R-28")` ... searches in `Wells` class for a keyword "R-28"
```
""" haskeyword

function addkeyword!(madsdata::Associative, keyword::String)
	haskey(madsdata, "Problem") ? addkeyword!(madsdata, "Problem", keyword) : madsdata["Problem"] = keyword
	return
end
function addkeyword!(madsdata::Associative, class::String, keyword::String)
	if haskeyword(madsdata, class, keyword)
		madswarn("Keyword `$keyword` already exists")
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

$(DocumentFunction.documentfunction(addkeyword!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "keyword"=>"dictionary key",
            "class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))
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

$(DocumentFunction.documentfunction(deletekeyword!;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "keyword"=>"dictionary key",
            "class"=>"dictionary class; if not provided searches for `keyword` in `Problem` class")))
""" deletekeyword!

"""
Get sin-space dx

$(DocumentFunction.documentfunction(getsindx;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- sin-space dx
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

$(DocumentFunction.documentfunction(transposevector;
argtext=Dict("a"=>"vector")))
"""
function transposevector(a::Vector)
	reshape(a, 1, length(a))
end

"""
Transpose non-numeric matrix

$(DocumentFunction.documentfunction(transposematrix;
argtext=Dict("a"=>"matrix")))
"""
function transposematrix(a::Matrix)
	permutedims(a, (2, 1))
end

"""
Print error message

$(DocumentFunction.documentfunction(printerrormsg;
argtext=Dict("e"=>"error message")))
"""
function printerrormsg(e::Any)
	if in(:msg, fieldnames(e))
		println(strip(e.msg))
	else
		println(e)
	end
end

"""
Create mesh grid

$(DocumentFunction.documentfunction(meshgrid;
argtext=Dict("x"=>"vector of grid x coordinates",
            "y"=>"vector of grid y coordinates")))

Returns:

- 2D grid coordinates based on the coordinates contained in vectors `x` and `y`
"""
function meshgrid(x::Vector, y::Vector)
	m = length(x)
	n = length(y)
	xx = reshape(x, 1, n)
	yy = reshape(y, m, 1)
	(repmat(xx, m, 1), repmat(yy, 1, n))
end

"""
Set / get current random seed

$(DocumentFunction.documentfunction(setseed;
argtext=Dict("seed"=>"random seed",
            "quiet"=>"[default=`true`]")))
"""
function setseed(seed::Integer=0, quiet::Bool=true)
	if seed != 0
		srand(seed)
		!quiet && info("New seed: $s")
	else
		s = Int(Base.Random.GLOBAL_RNG.seed[1])
		!quiet && info("Current seed: $s")
	end
end

"""
Get package version

$(DocumentFunction.documentfunction(pkgversion))
"""
function pkgversion(modulestr::String)
	try
		stdoutcaptureon()
		Pkg.status(modulestr)
		o = stdoutcaptureoff()
		a = ascii(String(o))
		m = match(r"\s+-\s+(\S+)\s+([0-9](\.[0-9])+)", a)
		return convert(VersionNumber, m[2])
	catch
		o = stdoutcaptureoff()
		warn("Module $(modulestr) is not available")
		return v"0.0.0"
	end
end
