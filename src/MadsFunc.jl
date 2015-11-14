if isdefined(:HDF5) # HDF5 installation is problematic on some machines
	import R3Function
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
function makemadscommandgradient(madsdata::Associative, f::Function)
	fg = makemadscommandfunctionandgradient(madsdata, f)
	function madscommandgradient(parameters::Dict; dx=Array(Float64,0), center::Associative=Dict()) #TODO we need the center; this is not working
		forwardrun, gradient = fg(parameters; dx=dx, center=center)
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
	obskeys = getobskeys(madsdata)
	weights = Mads.getobsweight(madsdata)
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	if ssdr
		mins = Mads.getobsmin(madsdata)
		maxs = Mads.getobsmax(madsdata)
	end
	function madscommandfunctionandgradient(parameters::Dict; dx=Array(Float64,0), center::Associative=Dict()) #TODO we need the center; this is not working
		if sizeof(dx) == 0
			dx = lineardx
		end
		xph = Dict()
		if length(center) == 0
			xph["noparametersvaried"] = parameters
		end
		i = 1
		for optparamkey in optparamkeys
			xph[optparamkey] = copy(parameters)
			xph[optparamkey][optparamkey] += dx[i] # TODO make sure that the order matches
			i += 1
		end
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph)
		fevalsdict = Dict()
		for feval in fevals
			fevalsdict[feval[1]] = feval[2]
		end
		if length(center) > 0
			fevalsdict["noparametersvaried"] = center
		end
		gradient = Dict()
		k = 1
		for obskey in obskeys
			gradient[obskey] = Dict()
			i = 1
			c = fevalsdict["noparametersvaried"][obskey]
			if ssdr
					c += ( mins[k] < c ) ? mins[k] - c : 0
					c += ( c > maxs[k] ) ? c - maxs[k] : 0
			end
			for optparamkey in optparamkeys
				o = fevalsdict[optparamkey][obskey]
				if ssdr
					o += ( mins[k] < o ) ? mins[k] - o : 0
					o += ( o > maxs[k] ) ? o - maxs[k] : 0
				end
				gradient[obskey][optparamkey] = weights[k] * (o - c) / dx[i]
				# println("$optparamkey $resultkey : (", fevalsdict[optparamkey][resultkey], " - ", fevalsdict["noparametersvaried"][resultkey], ") / ", dx[i], "=", gradient[resultkey][optparamkey])
				i += 1
			end
			k += 1
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
