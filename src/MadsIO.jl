using Gadfly

if isdefined(:HDF5) # HDF5 installation is problematic on some machines
	import R3Function
end
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end

@doc "Set MADS input file" ->
function setmadsinputfile(filename)
	global madsinputfile = filename
end

@doc "Get MADS input file" ->
function getmadsinputfile()
	return madsinputfile
end

@doc "Get MADS root name" ->
function getmadsrootname(madsdata::Associative; first=true)
	return getrootname(madsdata["Filename"]; first=first)
end

@doc "Get MADS problem dir" ->
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

@doc "Get file name root " ->
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

@doc "Get file name extension" ->
function getextension(filename)
	d = split(filename, "/")
	s = split(d[end], ".")
	if length(s) > 1
		return s[end]
	else
		return ""
	end
end

@doc "Get MADS problem directory" ->
function getmadsproblemdir(madsdata::Associative)
	join(split(abspath(madsdata["Filename"]), '/')[1:end - 1], '/')
end

@doc "Make MADS command function" ->
function makemadscommandfunction(madsdata::Associative) # make MADS command function
	madsproblemdir = getmadsproblemdir(madsdata)
	if haskey(madsdata, "Julia")
		Mads.madsoutput("Execution using Julia model-evaluation script parsing model outputs ...\n")
		juliamodel = evalfile(madsdata["Julia"])
	end
	if haskey(madsdata, "Dynamic model")
		Mads.madsoutput("Dynamic model evaluation ...\n")
		madscommandfunction = madsdata["Dynamic model"]
	elseif haskey(madsdata, "MADS model")
		Mads.madsoutput("MADS model evaluation ...\n")
		yetanothermakemadscommandfunction = evalfile(joinpath(madsproblemdir, madsdata["MADS model"]))
		return yetanothermakemadscommandfunction(madsdata)
	elseif haskey(madsdata, "Model")
		Mads.madsoutput("Internal model evaluation ...\n")
		madscommandfunction = evalfile(joinpath(madsproblemdir, madsdata["Model"]))
	elseif haskey(madsdata, "Command") || haskey(madsdata, "Julia")
		Mads.madsoutput("External model evaluation ...\n")
		function madscommandfunction(parameters::Dict) # MADS command function
			currentdir = pwd()
			cd(madsproblemdir)
			newdirname = "../$(split(pwd(),"/")[end])_$(Libc.strftime("%Y%m%d%H%M",time()))_$(randstring(6))_$(myid())"
			Mads.madsinfo("""Temp directory: $(newdirname)""")
			run(`mkdir $newdirname`)
			run(`bash -c "ln -s $(madsproblemdir)/* $newdirname"`) # link all the files in the mads problem directory
			if haskey(madsdata, "Instructions") # Templates/Instructions
				for instruction in madsdata["Instructions"]
					filename = instruction["read"]
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "Templates") # Templates/Instructions
				for template in madsdata["Templates"]
					filename = template["write"]
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				cd(newdirname)
				writeparameters(madsdata, parameters)
				cd(madsproblemdir)
			end
			#TODO move the writing into the "writeparameters" function
			if haskey(madsdata, "JSONParameters") # JSON
				for filename in vcat(madsdata["JSONParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				dumpjsonfile("$(newdirname)/$(madsdata["JSONParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "JSONPredictions") # JSON
				for filename in vcat(madsdata["JSONPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "YAMLParameters") # YAML
				for filename in vcat(madsdata["YAMLParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				dumpyamlfile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "YAMLPredictions") # YAML
				for filename in vcat(madsdata["YAMLPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "ASCIIParameters") # ASCII
				for filename in vcat(madsdata["ASCIIParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				dumpasciifile("$(newdirname)/$(madsdata["ASCIIParameters"])", values(parameters)) # create parameter files
			end
			if haskey(madsdata, "ASCIIPredictions") # ASCII
				for filename in vcat(madsdata["ASCIIPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "Julia")
				Mads.madsoutput("Execution of Julia model-evaluation script parsing model outputs ...\n")
				cd(newdirname)
				results = juliamodel(madsdata) # this should be madsdata; not parameters
				cd(madsproblemdir)
			else
				Mads.madsoutput("Execution of external command ...\n")
				Mads.madsinfo("""Execute: $(madsdata["Command"])""")
				run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
				results = DataStructures.OrderedDict()
				if haskey(madsdata, "Instructions") # Templates/Instructions
					cd(newdirname)
					results = readobservations(madsdata)
					cd(madsproblemdir)
					Mads.madsinfo("""Observations: $(results)""")
				elseif haskey(madsdata, "JSONPredictions") # JSON
					for filename in vcat(madsdata["JSONPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = loadjsonfile("$(newdirname)/$filename")
					end
				elseif haskey(madsdata, "YAMLPredictions") # YAML
					for filename in vcat(madsdata["YAMLPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, loadyamlfile("$(newdirname)/$filename"))
					end
				elseif haskey(madsdata, "ASCIIPredictions") # ASCII
					predictions = loadasciifile("$(newdirname)/$(madsdata["ASCIIPredictions"])")
					obskeys = getobskeys(madsdata)
					obsid=[convert(AbstractString,k) for k in obskeys]
					@assert length(obskeys) == length(predictions)
					results = DataStructures.OrderedDict{AbstractString, Float64}(zip(obsid, predictions))
				end
			end
			run(`rm -fR $newdirname`)
			cd(currentdir) # restore to the original directory
			global modelruns += 1
			return results
		end
	elseif haskey(madsdata, "Sources") # we may still use "Wells" instead of "Observations"
		Mads.madsoutput("MADS interal Anasol model evaluation for contaminant transport ...\n")
		return makecomputeconcentrations(madsdata)
	else
		Mads.err("Cannot create a madscommand function without a Model or a Command entry in the mads input file")
		error("MADS input file problem")
	end
	if haskey(madsdata, "Restart") && madsdata["Restart"] == "memory"
		madscommandfunctionwithreuse = R3Function.maker3function(madscommandfunction)
		return madscommandfunctionwithreuse
	elseif !haskey(madsdata, "Restart") || madsdata["Restart"] != false
		rootname = join(split(split(madsdata["Filename"], "/")[end], ".")[1:end-1], ".")
		if haskey(madsdata, "RestartDir")
			rootdir = madsdata["RestartDir"]
		elseif contains(madsdata["Filename"], "/")
			rootdir = string(join(split(madsdata["Filename"], "/")[1:end-1], "/"), "/", rootname, "_restart")
		else
			rootdir = string(rootname, "_restart")
		end
		madscommandfunctionwithreuse = R3Function.maker3function(madscommandfunction, rootdir)
		return madscommandfunctionwithreuse
	else
		return madscommandfunction
	end
end

@doc "Make MADS command gradient function" ->
function makemadscommandgradient(madsdata::Associative) # make MADS command gradient function
	f = makemadscommandfunction(madsdata)
	return makemadscommandgradient(madsdata, f)
end

@doc "Make MADS command gradient function" ->
function makemadscommandgradient(madsdata::Associative, f)
	fg = makemadscommandfunctionandgradient(madsdata, f)
	function madscommandgradient(parameters::Dict; dx=Array(Float64,0))
		forwardrun, gradient = fg(parameters; dx=dx)
		return gradient
	end
	return madscommandgradient
end

@doc "Make MADS command function & gradient function" ->
function makemadscommandfunctionandgradient(madsdata::Associative)
	f = makemadscommandfunction(madsdata)
	return makemadscommandfunctionandgradient(madsdata, f)
end

@doc "Make MADS command function and gradient function" ->
function makemadscommandfunctionandgradient(madsdata::Associative, f::Function) # make MADS command gradient function
	optparamkeys = getoptparamkeys(madsdata)
	lineardx = getparamsstep(madsdata, optparamkeys)
	function madscommandfunctionandgradient(parameters::Dict; dx=Array(Float64,0)) # MADS command gradient function
		if sizeof(dx) == 0
			dx = lineardx
		end
		xph = Dict()
		xph["noparametersvaried"] = parameters # TODO in the case of LM, we typically we already know this
		i = 1
		for optparamkey in optparamkeys # TODO make sure that the order matches; WE SHOULD USE ONLY OrderedDict
			xph[optparamkey] = copy(parameters)
			xph[optparamkey][optparamkey] += dx[i]
			i += 1
		end
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph) # TODO we shoud not compute xph["noparametersvaried"] if already available
		fevalsdict = Dict()
		for feval in fevals
			fevalsdict[feval[1]] = feval[2]
		end
		gradient = Dict()
		resultkeys = keys(fevals[1][2])
		for resultkey in resultkeys
			gradient[resultkey] = Dict()
			i = 1
			for optparamkey in optparamkeys
				gradient[resultkey][optparamkey] = (fevalsdict[optparamkey][resultkey] - fevalsdict["noparametersvaried"][resultkey]) / dx[i]
				# println("$optparamkey $resultkey : (", fevalsdict[optparamkey][resultkey], " - ", fevalsdict["noparametersvaried"][resultkey], ") / ", dx[i], "=", gradient[resultkey][optparamkey])
				i += 1
			end
		end
		return fevalsdict["noparametersvaried"], gradient
	end
	return madscommandfunctionandgradient
end

function makelogprior(madsdata::Associative)
	distributions = getparamdistributions(madsdata::Associative)
	function logprior(params::Associative)
		loglhood = 0.
		for paramname in getoptparamkeys(madsdata)
			loglhood += Distributions.loglikelihood(distributions[paramname], [params[paramname]])[1] # for some reason, loglikelihood accepts and returns arrays, not floats
		end
		return loglhood
	end
end

function makemadsconditionalloglikelihood(madsdata::Associative; weightfactor=1.)
	function conditionalloglikelihood(predictions::Associative, observations::Associative)
		loglhood = 0.
		#TODO replace this sum of squared residuals approach with the distribution from the "dist" observation keyword if it is there
		for obsname in keys(predictions)
			pred = predictions[obsname]
			if haskey(observations[obsname], "target")
				obs = observations[obsname]["target"]
				diff = obs - pred
				weight = 1
				if haskey(observations[obsname], "weight")
					weight = observations[obsname]["weight"]
				end
				weight *= weightfactor
				loglhood -= weight * weight * diff * diff
			end
		end
		return loglhood
	end
end

@doc "Make MADS loglikelihood function" ->
function makemadsloglikelihood(madsdata::Associative; weightfactor=1.)
	if haskey(madsdata, "LogLikelihood")
		Mads.madsinfo("Internal log likelihood")
		madsloglikelihood = evalfile(madsdata["LogLikelihood"]) # madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	else
		Mads.madsinfo("External log likelihood")
		logprior = makelogprior(madsdata)
		conditionalloglikelihood = makemadsconditionalloglikelihood(madsdata; weightfactor=weightfactor)
		function madsloglikelihood{T1<:Associative, T2<:Associative, T3<:Associative}(params::T1, predictions::T2, observations::T3)
			return logprior(params) + conditionalloglikelihood(predictions, observations)
		end
	end
	return madsloglikelihood
end

@doc "Create and save a new mads problem based on provided observations (calibration targets)" ->
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

@doc "Write parameters via MADS template" ->
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

@doc "Write initial parameters" ->
function writeparameters(madsdata::Associative)
	paramsinit = getparamsinit(madsdata)
	paramkeys = getparamkeys(madsdata)
	writeparameters(madsdata, Dict(paramkeys, paramsinit))
end

@doc "Write parameters" ->
function writeparameters(madsdata::Associative, parameters)
	expressions = evaluatemadsexpressions(parameters, madsdata)
	paramsandexps = merge(parameters, expressions)
	for template in madsdata["Templates"]
		writeparametersviatemplate(paramsandexps, template["tpl"], template["write"])
	end
end

@doc "Call C MADS ins_obs() function from the MADS library" ->
function cmadsins_obs(obsid::Array{Any,1}, instructionfilename::AbstractString, inputfilename::AbstractString)
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

@doc "Read observations" ->
function readobservations(madsdata::Associative)
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
