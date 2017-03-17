"MADS restart on"
function restarton()
	global restart = true;
end

"MADS restart off"
function restartoff()
	global restart = false;
end

"Get MADS restart status"
function getrestart(madsdata::Associative)
	haskey(madsdata, "Restart") ? madsdata["Restart"] : restart # note madsdata["Restart"] can be a string
end

"Make MADS quiet"
function quieton()
	ReusableFunctions.quieton()
	global quiet = true;
end

"Make MADS not quiet"
function quietoff()
	ReusableFunctions.quietoff()
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

"Redirect STDOUT to a reader"
function stdoutcaptureon()
	global outputoriginal = STDOUT;
	(outR, outW) = redirect_stdout();
	global outputread = outR;
	global outputwrite = outW;
	global outputreader = @async readstring(outputread);
end

"Restore STDOUT"
function stdoutcaptureoff()
	redirect_stdout(outputoriginal);
	close(outputwrite);
	output = wait(outputreader);
	close(outputread);
	return output
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
	elseif typeof(madsdata[class]) <: Vector{String}
		push!(madsdata[class], keyword)
	end
end

"Delete a `keyword` in a `class` within the Mads dictionary `madsdata`"
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

"Get sin-space dx"
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

"Transpose non-numeric vector"
function transposevector(a::Vector)
	reshape(a, 1, length(a))
end

"Transpose non-numeric matrix"
function transposematrix(a::Matrix)
	permutedims(a, (2, 1))
end