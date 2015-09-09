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
function getmadsrootname(madsdata)
	join(split(madsdata["Filename"], ".")[1:end-1], ".")
end

@doc "Get MADS problem dir" ->
function getmadsdir()
	source_path = Base.source_path()
	if typeof(source_path) == Nothing
		problemdir = ""
	else
		problemdir = string((dirname(source_path))) * "/"
		Mads.madsinfo("Problem directory: $(problemdir)")
	end
	return problemdir
end

@doc "Get file name extension" ->
function getextension(filename)
	split(filename, ".")[end]
end

@doc "Set image file format" ->
function setimagefileformat(filename, format)
	extension = uppercase(getextension(filename))
	if format == ""
		format = extension
	end
	if ismatch(r"^PNG|PDF|PS|SVG", format)
		if format != extension
			filename = filename*"."*lowercase(format)
		end
	elseif format == "EPS"
		if !ismatch(r"^EPS|PS", extension)
			filename = filename*".eps"
		end
		format = "PS"
	else
		if "SVG" != extension
			filename = filename*".svg"
		end
		format = "SVG"
	end
	return filename, format
end

@doc "Get MADS problem directory" ->
function getmadsproblemdir(madsdata)
	join(split(abspath(madsdata["Filename"]), '/')[1:end - 1], '/')
end

@doc "Make MADS command function" ->
function makemadscommandfunction(madsdata) # make MADS command function
	madsproblemdir = getmadsproblemdir(madsdata)
	if haskey(madsdata, "Julia")
		println("Execution using Julia model-evaluation script parsing model outputs ...")
		juliamodel = evalfile(madsdata["Julia"])
	end
	if haskey(madsdata, "Dynamic model")
		println("Dynamic model evaluation ...")
		madscommandfunction = madsdata["Dynamic model"]
	elseif haskey(madsdata, "MADS model")
		println("MADS model evaluation ...")
		yetanothermakemadscommandfunction = evalfile(joinpath(madsproblemdir, madsdata["MADS model"]))
		return yetanothermakemadscommandfunction(madsdata)
	elseif haskey(madsdata, "Model")
		println("Internal model evaluation ...")
		madscommandfunction = evalfile(joinpath(madsproblemdir, madsdata["Model"]))
	elseif haskey(madsdata, "Command") || haskey(madsdata, "Julia")
		madsinfo("External model evaluation ...")
		function madscommandfunction(parameters::Dict) # MADS command function
			currentdir = pwd()
			cd(madsproblemdir)
			newdirname = "../$(split(pwd(),"/")[end])_$(strftime("%Y%m%d%H%M",time()))_$(randstring(6))_$(myid())"
			madsinfo("""Temp directory: $(newdirname)""")
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
				println("Execution of Julia model-evaluation script parsing model outputs ...")
				cd(newdirname)
				results = juliamodel(madsdata) # this should be madsdata; not parameters
				cd(madsproblemdir)
			else
				println("Execution of external command ...")
				madsinfo("""Execute: $(madsdata["Command"])""")
				run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
				results = DataStructures.OrderedDict()
				if haskey(madsdata, "Instructions") # Templates/Instructions
					cd(newdirname)
					results = readobservations(madsdata)
					cd(madsproblemdir)
					madsinfo("""Observations: $(results)""")
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
					obsid=[convert(String,k) for k in obskeys]
					@assert length(obskeys) == length(predictions)
					results = DataStructures.OrderedDict{String, Float64}(zip(obsid, predictions))
				end
			end
			run(`rm -fR $newdirname`)
			cd(currentdir) # restore to the original directory
			global modelruns += 1
			return results
		end
	elseif haskey(madsdata, "Sources") # we may still use "Wells" instead of "Observations"
		println("MADS interal Anasol model evaluation for contaminant transport ...")
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

@doc "Turn on all Wells" ->
function allwellson!(madsdata)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = true
	end
	wells2observations!(madsdata)
end

@doc "Turn on a specific well" ->
function wellon!(madsdata, wellname::String)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = true
			error = false
		end
	end
	if error
		Mads.err("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

@doc "Turn off all Wells" ->
function allwellsoff!(madsdata)
	for wellkey in collect(keys(madsdata["Wells"]))
		madsdata["Wells"][wellkey]["on"] = false
	end
	wells2observations!(madsdata)
end

@doc "Turn off a specific well" ->
function welloff!(madsdata, wellname::String)
	error = true
	for wellkey in collect(keys(madsdata["Wells"]))
		if wellname == wellkey
			madsdata["Wells"][wellkey]["on"] = false
			error = false
		end
	end
	if error
		Mads.err("""Well name $wellname does not match existing well names!""")
	else
		wells2observations!(madsdata)
	end
end

@doc "Plot MADS problem" ->
function plotmadsproblem(madsdata; format="", filename="")
	if haskey(madsdata, "Sources")
		rectangles = Array(Float64, 0, 4)
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			if sourcetype == "box"
				rectangle = Array(Float64, 4)
				rectangle[1] = madsdata["Sources"][i][sourcetype]["x"]["init"] - madsdata["Sources"][i][sourcetype]["dx"]["init"] / 2
				rectangle[2] = madsdata["Sources"][i][sourcetype]["y"]["init"] - madsdata["Sources"][i][sourcetype]["dy"]["init"] / 2
				rectangle[3] = madsdata["Sources"][i][sourcetype]["dx"]["init"]
				rectangle[4] = madsdata["Sources"][i][sourcetype]["dy"]["init"]
				rectangles = vcat(rectangles, rectangle')
			end
		end
	end
	dfw = DataFrame(x = Float64[], y = Float64[], label = String[], category = String[])
	for wellkey in collect(keys(madsdata["Wells"]))
		if !( haskey(madsdata["Wells"][wellkey], "on") && !madsdata["Wells"][wellkey]["on"] )
			match = false
			x = madsdata["Wells"][wellkey]["x"]
			y = madsdata["Wells"][wellkey]["y"]
			for i = 1:size(dfw)[1]
				if dfw[1][i] == x && dfw[2][i] == y
					match = true
					break
				end
			end
			if !match
				push!(dfw, (x, y, wellkey, "Wells"))
			end
		end
	end
	xo = rectangles[:,1] + rectangles[:,3]
	yo = rectangles[:,2] + rectangles[:,4]
	xmin = min(dfw[1]..., rectangles[:,1]...)
	ymin = min(dfw[2]..., rectangles[:,2]...)
	xmax = max(dfw[1]..., xo...)
	ymax = max(dfw[2]..., yo...)
	dx = xmax - xmin
	dy = ymax - ymin
	xmin = xmin - dx / 6
	xmax = xmax + dx / 6
	ymin = ymin - dy / 6
	ymax = ymax + dy / 6
	p = Gadfly.plot(dfw, x="x", y="y", label="label", color="category", Geom.point, Geom.label,
					 Guide.XLabel("x [m]"), Guide.YLabel("y [m]"), Guide.yticks(orientation=:vertical),
					 Guide.annotation(Compose.compose(Compose.context(), Compose.rectangle(rectangles[:,1],rectangles[:,2],rectangles[:,3],rectangles[:,4]), Compose.fill(parse(Colors.Colorant, "orange")), Compose.stroke(parse(Colors.Colorant, "orange")))),
					 Scale.x_continuous(minvalue=xmin, maxvalue=xmax, labels=x -> @sprintf("%.0f", x)),
					 Scale.y_continuous(minvalue=ymin, maxvalue=ymax, labels=y -> @sprintf("%.0f", y)))
	if filename == ""
		rootname = getmadsrootname(madsdata)
		filename = "$rootname-problemsetup"
	end
	filename, format = setimagefileformat(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, 4inch), p)
	p
end

@doc "Convert Wells to Observations class" ->
function wells2observations!(madsdata)
	observations = DataStructures.OrderedDict()
	for wellkey in collect(keys(madsdata["Wells"]))
		if !( haskey(madsdata["Wells"][wellkey], "on") && !madsdata["Wells"][wellkey]["on"] )
			for i in 1:length(madsdata["Wells"][wellkey]["obs"])
				t = madsdata["Wells"][wellkey]["obs"][i][i]["t"]
				obskey = wellkey * "_" * string(t)
				data = DataStructures.OrderedDict()
				data["well"] = wellkey
				data["time"] = t
				if haskey(madsdata["Wells"][wellkey]["obs"][i][i], "c") && !haskey(madsdata["Wells"][wellkey]["obs"][i][i], "target")
					data["target"] = madsdata["Wells"][wellkey]["obs"][i][i]["c"]
				end
				for datakey in keys(madsdata["Wells"][wellkey]["obs"][i][i])
					if datakey != "c" && datakey != "t"
						data[datakey] = madsdata["Wells"][wellkey]["obs"][i][i][datakey]
					end
				end
				observations[obskey] = data
			end
		end
	end
	madsdata["Observations"] = observations
end

@doc "Make MADS command gradient function" ->
function makemadscommandgradient(madsdata) # make MADS command gradient function
	f = makemadscommandfunction(madsdata)
	return makemadscommandgradient(madsdata, f)
end

@doc "Make MADS command gradient function" ->
function makemadscommandgradient(madsdata, f)
	fg = makemadscommandfunctionandgradient(madsdata, f)
	function madscommandgradient(parameters::Dict; dx=Array(Float64,0))
		forwardrun, gradient = fg(parameters; dx=dx)
		return gradient
	end
	return madscommandgradient
end

@doc "Make MADS command function & gradient function" ->
function makemadscommandfunctionandgradient(madsdata)
	f = makemadscommandfunction(madsdata)
	return makemadscommandfunctionandgradient(madsdata, f)
end

@doc "Make MADS command function and gradient function" ->
function makemadscommandfunctionandgradient(madsdata, f::Function) # make MADS command gradient function
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
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph) # TODO we shoud not computer xph["noparametersvaried"] if already available
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

function makelogprior(madsdata)
	distributions = getparamdistributions(madsdata)
	function logprior(params::Associative)
		loglhood = 0.
		for paramname in getoptparamkeys(madsdata)
			loglhood += Distributions.loglikelihood(distributions[paramname], [params[paramname]])[1] # for some reason, loglikelihood accepts and returns arrays, not floats
		end
		return loglhood
	end
end

function makemadsconditionalloglikelihood(madsdata; weightfactor=1.)
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
function makemadsloglikelihood(madsdata; weightfactor=1.)
	if haskey(madsdata, "LogLikelihood")
		madsinfo("Internal log likelihood")
		madsloglikelihood = evalfile(madsdata["LogLikelihood"]) # madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	else
		madsinfo("External log likelihood")
		logprior = makelogprior(madsdata)
		conditionalloglikelihood = makemadsconditionalloglikelihood(madsdata; weightfactor=weightfactor)
		function madsloglikelihood{T1<:Associative, T2<:Associative, T3<:Associative}(params::T1, predictions::T2, observations::T3)
			return logprior(params) + conditionalloglikelihood(predictions, observations)
		end
	end
	return madsloglikelihood
end

@doc "Get keys for parameters" ->
function getparamkeys(madsdata)
	return collect(keys(madsdata["Parameters"]))
	#return [convert(String,k) for k in keys(madsdata["Parameters"])]
end

@doc "Get keys for source parameters" ->
function getsourcekeys(madsdata)
	return collect(keys(madsdata["Sources"][1]["box"]))
	#return [convert(String,k) for k in keys(madsdata["Parameters"])]
end

@doc "Get keys for observations" ->
function getobskeys(madsdata)
	return collect(keys(madsdata["Observations"]))
	#return [convert(String,k) for k in keys(madsdata["Observations"])]
end

@doc "Get keys for wells" ->
function getwellkeys(madsdata)
	return collect(keys(madsdata["Wells"]))
	#return [convert(String,k) for k in keys(madsdata["Wells"])]
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
		for i = 1:int((length(splitline)-1)/2)
			write(outfile, splitline[2 * i - 1]) # write the text before the parameter separator
			madsinfo( "Replacing "*strip(splitline[2 * i])*" -> "*string(parameters[strip(splitline[2 * i])]) )
			write(outfile, string(parameters[strip(splitline[2 * i])])) # splitline[2 * i] in this case is parameter ID
		end
		write(outfile, splitline[end]) # write the rest of the line after the last separator
	end
	close(outfile)
end

@doc "Write initial parameters" ->
function writeparameters(madsdata)
	paramsinit = getparamsinit(madsdata)
	paramkeys = getparamkeys(madsdata)
	writeparameters(madsdata, Dict(paramkeys, paramsinit))
end

@doc "Write parameters" ->
function writeparameters(madsdata, parameters)
	expressions = evaluatemadsexpressions(parameters, madsdata)
	paramsandexps = merge(parameters, expressions)
	for template in madsdata["Templates"]
		writeparametersviatemplate(paramsandexps, template["tpl"], template["write"])
	end
end

@doc "Call C MADS ins_obs() function from the MADS library" ->
function cmadsins_obs(obsid::Array{Any,1}, instructionfilename::ASCIIString, inputfilename::ASCIIString)
	n = length(obsid)
	obsval = zeros(n) # initialize to 0
	obscheck = -1 * ones(n) # initialize to -1
	debug = 0 # setting debug level 0 or 1 works
	# int ins_obs( int nobs, char **obs_id, double *obs, double *check, char *fn_in_t, char *fn_in_d, int debug );
	result = ccall( (:ins_obs, "libmads"), Int32,
								 (Int32, Ptr{Ptr{Uint8}}, Ptr{Float64}, Ptr{Float64}, Ptr{Uint8}, Ptr{Uint8}, Int32),
								 n, obsid, obsval, obscheck, instructionfilename, inputfilename, debug)
	observations = Dict{String, Float64}(obsid, obsval)
	return observations
end

@doc "Read observations" ->
function readobservations(madsdata)
	obsids=getobskeys(madsdata)
	observations = OrderedDict(obsids, zeros(length(obsids)))
	for instruction in madsdata["Instructions"]
		obs = cmadsins_obs(obsids, instruction["ins"], instruction["read"])
		#this loop assumes that cmadsins_obs gives a zero value if the obs is not found, and that each obs will appear only once
		for obsid in obsids
			observations[obsid] += obs[obsid]
		end
	end
	return observations
end

@doc "Get parameter distributions" ->
function getparamdistributions(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	distributions = OrderedDict()
	for i in 1:length(paramkeys)
		if haskey(madsdata["Parameters"][paramkeys[i]], "dist")
			distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
		else
			distributions[paramkeys[i]] = Uniform(madsdata["Parameters"][paramkeys[i]]["min"], madsdata["Parameters"][paramkeys[i]]["max"])
		end
	end
	return distributions
end
