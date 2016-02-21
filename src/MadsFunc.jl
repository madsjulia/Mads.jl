if isdefined(:HDF5) # HDF5 installation is problematic on some machines
	import ReusableFunctions
end

"""
Make MADS function to execute the model defined in the MADS problem dictionary `madsdata`

The model fields that can be used to define the model are:

- `Model` : execute a julia function defined in an input julia file that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations

- `MADS model` : create a julia function based on an input julia file; the input file should have a function that accepts as an argument the MADS problem dictionary; this function should a create a julia function that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations

- `Internal model` : execute an internal julia function that accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations

- `Command` : execute an external unix command or script that will execute an external model.

- `Julia` : execute a julia script that will execute an external model.

Both `Command` and `Julia` can use different approaches to pass model parameters to the external model and different approaches to get back the model outputs. The available options for writing model inputs and reading model outputs are listed below.

Options for writing model inputs:

- `Templates` : template files for writing model input files as defined at http://mads.lanl.gov
- `ASCIIParameters` : model parameters written in a ASCII file
- `JLDParameters` : model parameters written in a JLD file
- `YAMLParameters` : model parameters written in a YAML file
- `JSONParameters` : model parameters written in a JSON file

Options for reading model outputs:

- `Instructions` : instruction files for reading model output files as defined at http://mads.lanl.gov
- `ASCIIPredictions` : model predictions read from a ASCII file
- `JLDPredictions` : model predictions read from a JLD file
- `YAMLPredictions` : model predictions read from a YAML file
- `JSONPredictions` : model predictions read from a JSON file
"""
function makemadscommandfunction(madsdata::Associative) # make MADS command function
	madsproblemdir = Mads.getmadsproblemdir(madsdata)
	if haskey(madsdata, "Julia")
		filename = joinpath(madsproblemdir, madsdata["Julia"])
		Mads.madsoutput("Execution using Julia model-evaluation script parsing model outputs in file $(filename)n")
		juliafunction = importeverywhere(filename)
	end
	if haskey(madsdata, "Internal model")
		Mads.madsoutput("Internal evaluation of a model function $(madsdata["Internal model"]) ...\n")
		madscommandfunction = madsdata["Internal model"]
	elseif haskey(madsdata, "MADS model")
		filename = joinpath(madsproblemdir, madsdata["MADS model"])
		Mads.madsoutput("MADS model evaluation of file $(filename) ...\n")
		madsdatacommandfunction = importeverywhere(joinpath(filename))
		madscommandfunction = madsdatacommandfunction(madsdata)
	elseif haskey(madsdata, "Model")
		filename = joinpath(madsproblemdir, madsdata["Model"])
		Mads.madsoutput("Internal model evaluation of file $(filename) ...\n")
		madscommandfunction = importeverywhere(filename)
	elseif haskey(madsdata, "Command") || haskey(madsdata, "Julia")
		Mads.madsoutput("External model evaluation ...\n")
		function madscommandfunction(parameters::Associative) # MADS command function
			currentdir = pwd()
			cd(madsproblemdir)
			newdirname = "../$(split(pwd(),"/")[end])_$(Libc.strftime("%Y%m%d%H%M",time()))_$(getpid())_$(randstring(6))_$(Mads.modelruns)"
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
			if haskey(madsdata, "JLDParameters") # JLD
				for filename in vcat(madsdata["JLDParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				JLD.save("$(newdirname)/$(madsdata["JLDParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "JLDPredictions") # JLD
				for filename in vcat(madsdata["JLDPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
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
				run(`rm -f $(newdirname)/$(madsdata["ASCIIParameters"])`) # delete the parameter file links
				#TODO this does NOT work; `parameters` are not required to be Ordered Dictionary
				dumpasciifile("$(newdirname)/$(madsdata["ASCIIParameters"])", values(parameters)) # create an ASCII parameter file
			end
			if haskey(madsdata, "ASCIIPredictions") # ASCII
				for filename in vcat(madsdata["ASCIIPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "Julia")
				Mads.madsoutput("Execution of Julia model-evaluation script parsing model outputs ...\n")
				cd(newdirname)
				results = juliafunction(madsdata)
				cd(madsproblemdir)
			else
				Mads.madsoutput("Execution of external command ...\n")
				Mads.madsinfo("Execute: $(madsdata["Command"])")
				try
					run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
				catch
					Mads.madscrit("Command $(madsdata["Command"]) cannot be executed!")
				end
				results = DataStructures.OrderedDict()
				if haskey(madsdata, "Instructions") # Templates/Instructions
					cd(newdirname)
					results = readobservations(madsdata)
					cd(madsproblemdir)
				end
				if haskey(madsdata, "JLDPredictions") # JLD
					for filename in vcat(madsdata["JLDPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, JLD.load("$(newdirname)/$filename"))
					end
				end
				if haskey(madsdata, "JSONPredictions") # JSON
					for filename in vcat(madsdata["JSONPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, loadjsonfile("$(newdirname)/$filename"))
					end
				end
				if haskey(madsdata, "YAMLPredictions") # YAML
					for filename in vcat(madsdata["YAMLPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, loadyamlfile("$(newdirname)/$filename"))
					end
				end
				if haskey(madsdata, "ASCIIPredictions") # ASCII
					predictions = loadasciifile("$(newdirname)/$(madsdata["ASCIIPredictions"])")
					obskeys = getobskeys(madsdata)
					obsid=[convert(AbstractString,k) for k in obskeys]
					@assert length(obskeys) == length(predictions)
					results = merge(results, DataStructures.OrderedDict{AbstractString, Float64}(zip(obsid, predictions)))
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
		Mads.madscrit("Cannot create a function to call model without a `Model` entry in the MADS problem dictionary!")
	end
	if isdefined(:ReusableFunctions) && haskey(madsdata, "Restart")
		if madsdata["Restart"] == "memory"
			madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction)
			return madscommandfunctionwithreuse
		elseif madsdata["Restart"] != false
			rootname = join(split(split(madsdata["Filename"], "/")[end], ".")[1:end-1], ".")
			if haskey(madsdata, "RestartDir")
				rootdir = madsdata["RestartDir"]
			elseif contains(madsdata["Filename"], "/")
				rootdir = string(join(split(madsdata["Filename"], "/")[1:end-1], "/"), "/", rootname, "_restart")
			else
				rootdir = string(rootname, "_restart")
			end
			madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction, rootdir)
			return madscommandfunctionwithreuse
		else
			return madscommandfunction
		end
	else
		return madscommandfunction
	end
end

"""
Import function everywhere from a file.
The first function in the file is the one that will be called by Mads to perform the model simulations.
"""
function importeverywhere(finename)
	#TODO DANGEROUS a function with the same name but with different method may exist in the memory
	code = readall(finename)
	functionname = strip(split(split(code, "function")[2],"(")[1])
	q = parse(string("@everywhere begin\n", code, "\n$functionname\nend"))
	eval(Main, q)
	functionsymbol = q.args[2].args[end]
	try
		q = Expr(:., :Main, QuoteNode(functionsymbol))
		commandfunction = eval(q)
		return commandfunction
	catch
		madscrit("loading model defined in $(finename)")
	end
end

"Make MADS gradient function to compute the parameter-space gradient for the model defined in the MADS problem dictionary `madsdata`"
function makemadscommandgradient(madsdata::Associative) # make MADS command gradient function
	f = makemadscommandfunction(madsdata)
	return makemadscommandgradient(madsdata, f)
end

function makemadscommandgradient(madsdata::Associative, f::Function)
	fg = makemadscommandfunctionandgradient(madsdata, f)
	function madscommandgradient(parameters::Dict; dx=Array(Float64,0), center::Associative=Dict()) #TODO we need the center; this is not working
		forwardrun, gradient = fg(parameters; dx=dx, center=center)
		return gradient
	end
	return madscommandgradient
end

"Make MADS forward & gradient functions for the model defined in the MADS problem dictionary `madsdata`"
function makemadscommandfunctionandgradient(madsdata::Associative)
	f = makemadscommandfunction(madsdata)
	return makemadscommandfunctionandgradient(madsdata, f)
end

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
	function madscommandfunctionandgradient(parameters::Associative; dx=Array(Float64,0), center::Associative=Dict()) #TODO we need the center; this is not working
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
		fevals = RobustPmap.rpmap(keyval->[keyval[1], f(keyval[2])], xph)
		for i = 1:length(fevals)
			if typeof(fevals[i]) == RemoteException
				throw(fevals[i])
			end
		end
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

"Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`"
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

"""
Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations.
Model parameters and observations are defined in the MADS problem dictionary `madsdata`.
"""
function makemadsconditionalloglikelihood(madsdata::Associative; weightfactor=1.)
	function conditionalloglikelihood(predictions::Associative, observations::Associative)
		loglhood = 0.
		#TODO replace this sum of squared residuals approach with the distribution from the "dist" observation keyword if it is there
		for obsname in keys(predictions)
			pred = predictions[obsname]
			if haskey(observations[obsname], "target")
				obs = observations[obsname]["target"]
				diff = obs - pred
				weight = 1.
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

"""
Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations.
The function can be provided as an external function in the MADS problem dictionary under `LogLikelihood` or computed internally.
"""
function makemadsloglikelihood(madsdata::Associative; weightfactor=1.)
	if haskey(madsdata, "LogLikelihood")
		Mads.madsinfo("Log-likelihood function provided externally ...")
		madsloglikelihood = evalfile(madsdata["LogLikelihood"]) # madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	else
		Mads.madsinfo("Log-likelihood function computed internally ...")
		logprior = makelogprior(madsdata)
		conditionalloglikelihood = makemadsconditionalloglikelihood(madsdata; weightfactor=weightfactor)
		function madsloglikelihood{T1<:Associative, T2<:Associative, T3<:Associative}(params::T1, predictions::T2, observations::T3)
			return logprior(params) + conditionalloglikelihood(predictions, observations)
		end
	end
	return madsloglikelihood
end
