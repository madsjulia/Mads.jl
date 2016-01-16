"""
Load MADS input file defining a MADS class set

`loadmadsfile(filename; julia=false)`

Arguments:

- `filename` : input file name (e.g. `input_file_name.mads`)
- `julia` : if `true`, force using `julia` parsing fuctions; if `false` (default), use `python` parsing functions [boolean]

Returns:

- `madsdata` : Loaded Mads data class

Example: `md = loadmadsfile("input_file_name.mads")`

"""
function loadmadsfile(filename::AbstractString; julia::Bool=false)
	loadyamlmadsfile(filename; julia=julia)
end

"Save calibration results"
function savecalibrationresults(madsdata::Associative, results)
	#TODO map estimated parameters on a new madsdata structure
	#TODO save madsdata in yaml file using dumpyamlmadsfile
	#TODO save residuals, predictions, observations (yaml?)
end

"Set MADS input file"
function setmadsinputfile(filename)
	global madsinputfile = filename
end

"Get MADS input file"
function getmadsinputfile()
	return madsinputfile
end

"Get MADS root name"
function getmadsrootname(madsdata::Associative; first=true)
	return getrootname(madsdata["Filename"]; first=first)
end

"Get MADS problem dir"
function getmadsdir()
	source_path = Base.source_path()
	if typeof(source_path) == Void
		problemdir = ""
	else
		problemdir = string((dirname(source_path))) * "/"
		Mads.madsinfo("Problem directory: $(problemdir)")
	end
	return problemdir
end

"Get file name root "
function getrootname(filename::AbstractString; first=true)
	d = split(filename, "/")
	s = split(d[end], ".")
	if !first && length(s) > 1
		r = join(s[1:end-1], ".")
	else
		r = s[1]
	end
	if length(d) > 1
		r = join(d[1:end-1], "/") * "/" * r
	end
	return r
end

"Get file name extension"
function getextension(filename)
	d = split(filename, "/")
	s = split(d[end], ".")
	if length(s) > 1
		return s[end]
	else
		return ""
	end
end

"Get MADS problem directory"
function getmadsproblemdir(madsdata::Associative)
	join(split(abspath(madsdata["Filename"]), '/')[1:end - 1], '/')
end

"Get matching files in a directory "
searchdir(key::Regex; path = ".") = filter(x->ismatch(key, x), readdir(path))
searchdir(key::ASCIIString; path = ".") = filter(x->contains(x, key), readdir(path))

"Create and save a new mads problem based on provided observations (calibration targets)"
function createmadsproblem(madsdata::Associative, predictions::Associative, filename::AbstractString)
	newmadsdata = deepcopy(madsdata)
	observationsdict = newmadsdata["Observations"]
	if haskey(newmadsdata, "Wells")
		wellsdict = newmadsdata["Wells"]
	end
	for k in keys(predictions)
		observationsdict[k]["target"] = predictions[k]
		if haskey( observationsdict[k], "well" )
			well = observationsdict[k]["well"]
			i = observationsdict[k]["index"]
			wellsdict[well]["obs"][i]["c"] = predictions[k]
		end
	end
	Mads.dumpyamlmadsfile(newmadsdata, filename)
end

"Write parameters via MADS template"
function writeparametersviatemplate(parameters, templatefilename, outputfilename)
	tplfile = open(templatefilename) # open template file
	line = readline(tplfile) # read the first line that says "template $separator\n"
	if length(line) >= 10 && line[1:9] == "template "
		separator = line[10] # template separator
		lines = readlines(tplfile)
	else
		#it doesn't specify the separator -- assume it is '#'
		separator = '#'
		lines = [line; readlines(tplfile)]
	end
	close(tplfile)
	outfile = open(outputfilename, "w")
	for line in lines
		splitline = split(line, separator) # two separators are needed for each parameter
		@assert rem(length(splitline), 2) == 1 # length(splitlines) should always be an odd number -- if it isn't the assumptions in the code below fail
		for i = 1:div(length(splitline)-1, 2)
			write(outfile, splitline[2 * i - 1]) # write the text before the parameter separator
			Mads.madsinfo( "Replacing "*strip(splitline[2 * i])*" -> "*string(parameters[strip(splitline[2 * i])]) )
			write(outfile, string(parameters[strip(splitline[2 * i])])) # splitline[2 * i] in this case is parameter ID
		end
		write(outfile, splitline[end]) # write the rest of the line after the last separator
	end
	close(outfile)
end

"Write initial parameters"
function writeparameters(madsdata::Associative)
	paramsinit = getparamsinit(madsdata)
	paramkeys = getparamkeys(madsdata)
	writeparameters(madsdata, Dict(paramkeys, paramsinit))
end

"Write parameters"
function writeparameters(madsdata::Associative, parameters)
	expressions = evaluatemadsexpressions(parameters, madsdata)
	paramsandexps = merge(parameters, expressions)
	for template in madsdata["Templates"]
		writeparametersviatemplate(paramsandexps, template["tpl"], template["write"])
	end
end

function instline2regexs(instline::AbstractString)
	floatregex = r"\h*[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?"
	regex = r"@[^@]*@|w|![^!]*!"
	offset = 1
	regexs = Regex[]
	obsnames = AbstractString[]
	getparamhere = Bool[]
	while offset <= length(instline) && ismatch(regex, instline, offset)
		m = match(regex, instline, offset)
		if m == nothing
			error("match not found for instruction line:\n$instline\nnear \"$(instline[offset:end])\"")
		end
		offset = m.offset + length(m.match)
		if m.match[1] == '@'
			push!(regexs, Regex(string("\\h*", m.match[2:end - 1])))
			push!(getparamhere, false)
		elseif m.match[1] == '!'
			push!(regexs, floatregex)
			push!(obsnames, m.match[2:end - 1])
			push!(getparamhere, true)
		elseif m.match == "w"
			push!(regexs, r"\h+")
			push!(getparamhere, false)
		else
			error("Unknown instruction file instruction: $(m.match)")
		end
	end
	return regexs, obsnames, getparamhere
end

function obslineismatch(obsline::AbstractString, regexs::Array{Regex, 1})
	bigregex = Regex(string(map(x->x.pattern, regexs)...))
	return ismatch(bigregex, obsline)
end

function regexs2obs(obsline, regexs, obsnames, getparamhere)
	offset = 1
	obsnameindex = 1
	obsdict = Dict{AbstractString, Float64}()
	for i = 1:length(regexs)
		m = match(regexs[i], obsline, offset)
		if getparamhere[i]
			obsdict[obsnames[obsnameindex]] = parse(Float64, m.match)
			obsnameindex += 1
		end
		offset = m.offset + length(m.match)
	end
	return obsdict
end

function ins_obs(instructionfilename::AbstractString, inputfilename::AbstractString)
	instfile = open(instructionfilename, "r")
	obsfile = open(inputfilename, "r")
	obslineitr = eachline(obsfile)
	state = start(obslineitr)
	obsdict = Dict{AbstractString, Float64}()
	for instline in eachline(instfile)
		regexs, obsnames, getparamhere = instline2regexs(instline)
		gotmatch = false
		while !gotmatch && !done(obslineitr, state)
			obsline, state = next(obslineitr, state)
			if obslineismatch(obsline, regexs)
				merge!(obsdict, regexs2obs(obsline, regexs, obsnames, getparamhere))
				gotmatch = true
			end
		end
		if !gotmatch
			error("Didn't get a match for instruction file ($instructionfilename) line:\n$instline")
		end
	end
	return obsdict
end

"Call C MADS ins_obs() function from the MADS library"
function cmadsins_obs(obsid::Array{Any,1}, instructionfilename::AbstractString, inputfilename::AbstractString)
	#TODO is this needed?!
end

"Call C MADS ins_obs() function from the MADS library"
function cmadsins_obs(obsid::Vector, instructionfilename::AbstractString, inputfilename::AbstractString)
	n = length(obsid)
	obsval = zeros(n) # initialize to 0
	obscheck = -1 * ones(n) # initialize to -1
	debug = 0 # setting debug level 0 or 1 works
	# int ins_obs( int nobs, char **obs_id, double *obs, double *check, char *fn_in_t, char *fn_in_d, int debug );
	result = ccall( (:ins_obs, "libmads"), Int32,
								 (Int32, Ptr{Ptr{UInt8}}, Ptr{Float64}, Ptr{Float64}, Ptr{UInt8}, Ptr{UInt8}, Int32),
								 n, obsid, obsval, obscheck, instructionfilename, inputfilename, debug)
	observations = Dict{AbstractString, Float64}(zip(obsid, obsval))
	return observations
end

"Read observations"
function readobservations(madsdata::Associative)
	obsids = getobskeys(madsdata)
	observations = Dict()
	obscount = Dict(zip(obsids, zeros(Int, length(obsids))))
	for instruction in madsdata["Instructions"]
		obs = ins_obs(instruction["ins"], instruction["read"])
		for k in keys(obs)
			obscount[k] += 1
			observations[k] = obs[k]
		end
	end
	for k in keys(obscount)
		if obscount[k] != 1
			warn("got observation, $k, $(obscount[k]) times")
		end
	end
	return observations
end

"Read observations" 
function readobservations_cmads(madsdata::Associative)
	obsids=getobskeys(madsdata)
	observations = OrderedDict(zip(obsids, zeros(length(obsids))))
	for instruction in madsdata["Instructions"]
		obs = cmadsins_obs(obsids, instruction["ins"], instruction["read"])
		#this loop assumes that cmadsins_obs gives a zero value if the obs is not found, and that each obs will appear only once
		for obsid in obsids
			observations[obsid] += obs[obsid]
		end
	end
	return observations
end
