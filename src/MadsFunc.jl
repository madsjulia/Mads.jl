import RobustPmap
import ReusableFunctions
import DataStructures
import Distributions
import JLD

"""
Make MADS function to execute the model defined in the MADS problem dictionary `madsdata`

Usage:
```
Mads.makemadscommandfunction(madsdata)
```

MADS can be coupled with any internal or external model. The model coupling is defined in the MADS problem dictionary. The expectations is that for a given set of model inputs, the model will produce a model output that will be provided to MADS. The fields in the MADS problem dictionary that can be used to define the model coupling are:

- `Model` : execute a Julia function defined in an input Julia file. The function that should accept a `parameter` dictionary with all the model parameters as an input argument and should return an `observation` dictionary with all the model predicted observations. MADS will execute the first function defined in the file.

- `MADS model` : create a Julia function based on an input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary. MADS will execute the first function defined in the file. This function should a create a Julia function that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.

- `Julia model` : execute an internal Julia function that accepts a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.

- `Command` : execute an external UNIX command or script that will execute an external model.

- `Julia command` : execute a Julia script that will execute an external model. The Julia script is defined in an input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary; MADS will execute the first function defined in the file. The Julia script should be capable to (1) execute the model (making a system call of an external model), (2) parse the model outputs, (3) return an `observation` dictionary with model predictions.

Both `Command` and `Julia command` can use different approaches to pass model parameters to the external model.

Only `Command` uses different approaches to get back the model outputs. The script defined under `Julia command` parses the model outputs using Julia.

The available options for writing model inputs and reading model outputs are as follows.

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
function makemadscommandfunction(madsdatawithobs::Associative; calczeroweightobs::Bool=false, calcpredictions::Bool=true) # make MADS command function
	#remove the obs (as long as it isn't anasol) from madsdata so they don't get sent when doing pmaps -- they aren't used here are they can require a lot of communication
	obskeys = getobskeys(madsdatawithobs)#keep just the keys of the obs
	madsdata = Dict()
	if !haskey(madsdatawithobs, "Sources")
		for k in keys(madsdatawithobs)
			if k != "Observations"
				madsdata[k] = madsdatawithobs[k]
			end
		end
	else
		madsdata = madsdatawithobs
	end
	madsproblemdir = Mads.getmadsproblemdir(madsdata)
	if haskey(madsdata, "Julia model")
		Mads.madsinfo("""Model setup: Julia model -> Internal model evaluation of Julia function '$(madsdata["Julia model"])'""")
		madscommandfunction = madsdata["Julia model"]
	elseif haskey(madsdata, "MADS model")
		filename = joinpath(madsproblemdir, madsdata["MADS model"])
		Mads.madsinfo("Model setup: MADS model -> Internal MADS model evaluation a Julia script in file '$(filename)'")
		madsdatacommandfunction = importeverywhere(joinpath(filename))
		madscommandfunction = madsdatacommandfunction(madsdatawithobs)
	elseif haskey(madsdata, "Model")
		filename = joinpath(madsproblemdir, madsdata["Model"])
		Mads.madsinfo("Model setup: Model -> Internal model evaluation a Julia script in file '$(filename)'")
		madscommandfunction = importeverywhere(filename)
	elseif haskey(madsdata, "Command") || haskey(madsdata, "Julia command")
		if haskey(madsdata, "Command")
			Mads.madsinfo("""Model setup: Command -> External model evaluation of command '$(madsdata["Command"])'""")
		end
		if haskey(madsdata, "Julia command")
			filename = joinpath(madsproblemdir, madsdata["Julia command"])
			Mads.madsinfo("Model setup: Julia command -> Model evaluation using a Julia script in file '$(filename)'")
			madsdatacommandfunction = importeverywhere(filename)
		end
		function madscommandfunction(parameters::Associative) # MADS command function
			currentdir = pwd()
			cd(madsproblemdir)
			tempdirname = "../$(split(pwd(),"/")[end])_$(getpid())_$(Libc.strftime("%Y%m%d%H%M",time()))_$(Mads.modelruns)_$(randstring(6))"
			attempt = 0
			trying = true
			while trying
				try
					attempt += 1
					if !isdir(tempdirname)
						mkdir(tempdirname)
					end
					run(`bash -c "ln -sf $(madsproblemdir)/* $tempdirname"`) # link all the files in the mads problem directory
					cd(tempdirname)
					Mads.madsinfo("Created temporary directory: $(tempdirname)", 1)
					trying = false
				catch
					sleep(attempt * 0.5)
					if attempt > 3
						madscritical("Temporary directory $tempdirname cannot be created!")
						trying = false
					end
				end
			end
			if haskey(madsdata, "Instructions") # Templates/Instructions
				for instruction in madsdata["Instructions"]
					filename = instruction["read"]
					if isfile(filename)
						rm(filename) # delete the parameter file links
					end
				end
			end
			if haskey(madsdata, "Templates") # Templates/Instructions
				for template in madsdata["Templates"]
					filename = template["write"]
					if isfile(filename)
						rm(filename) # delete the parameter file links
					end
				end
				writeparameters(madsdata, parameters)
			end
			#TODO move the writing into the "writeparameters" function
			if haskey(madsdata, "JLDParameters") # JLD
				for filename in vcat(madsdata["JLDParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
				JLD.save("$(madsdata["JLDParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "JLDPredictions") # JLD
				for filename in vcat(madsdata["JLDPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
			end
			if haskey(madsdata, "JSONParameters") # JSON
				for filename in vcat(madsdata["JSONParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
				dumpjsonfile("$(madsdata["JSONParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "JSONPredictions") # JSON
				for filename in vcat(madsdata["JSONPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
			end
			if haskey(madsdata, "YAMLParameters") # YAML
				for filename in vcat(madsdata["YAMLParameters"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
				dumpyamlfile("$(tempdirname)/$(madsdata["YAMLParameters"])", parameters) # create parameter files
			end
			if haskey(madsdata, "YAMLPredictions") # YAML
				for filename in vcat(madsdata["YAMLPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
			end
			if haskey(madsdata, "ASCIIParameters") # ASCII
				f = madsdata["ASCIIParameters"]
				if isfile(f)
					rm(f) # delete the parameter file links
				end
				#TODO this does NOT work; `parameters` are not required to be Ordered Dictionary
				dumpasciifile("$(tempdirname)/$(madsdata["ASCIIParameters"])", values(parameters)) # create an ASCII parameter file
			end
			if haskey(madsdata, "ASCIIPredictions") # ASCII
				for filename in vcat(madsdata["ASCIIPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
					f = filename
					if isfile(f)
						rm(f) # delete the parameter file links
					end
				end
			end
			if haskey(madsdata, "Julia command")
				Mads.madsinfo("Executing Julia model-evaluation script parsing the model outputs (`Julia command`) ...")
				results = madsdatacommandfunction(madsdata)
			else
				Mads.madsinfo("Executing `Command` '$(madsdata["Command"])' in directory $(tempdirname) ...")
				try
					run(`bash -c "$(madsdata["Command"])"`)
				catch
					cd(madsproblemdir)
					Mads.madscritical("Command '$(madsdata["Command"])' cannot be executed or failed!")
				end
				results = DataStructures.OrderedDict()
				if haskey(madsdata, "Instructions") # Templates/Instructions
					results = readobservations(madsdata, obskeys)
				end
				if haskey(madsdata, "JLDPredictions") # JLD
					for filename in vcat(madsdata["JLDPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, JLD.load(filename))
					end
				end
				if haskey(madsdata, "JSONPredictions") # JSON
					for filename in vcat(madsdata["JSONPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, loadjsonfile(filename))
					end
				end
				if haskey(madsdata, "YAMLPredictions") # YAML
					for filename in vcat(madsdata["YAMLPredictions"]) # the vcat is needed in case madsdata["..."] contains only one thing
						results = merge(results, loadyamlfile(filename))
					end
				end
				if haskey(madsdata, "ASCIIPredictions") # ASCII
					predictions = loadasciifile("$(madsdata["ASCIIPredictions"])")
					obsid=[convert(AbstractString,k) for k in obskeys]
					@assert length(obskeys) == length(predictions)
					results = merge(results, DataStructures.OrderedDict{AbstractString, Float64}(zip(obsid, predictions)))
				end
			end
			cd(madsproblemdir)
			attempt = 0
			trying = true
			while trying
				try
					attempt += 1
					rm(tempdirname, recursive=true)
					sleep(0.1)
					if isdir(tempdirname)
						rm(tempdirname, recursive=true)
					end
					trying = false
					Mads.madsinfo("Deleted temporary directory: $(tempdirname)", 1)
				catch
					sleep(attempt * 0.5)
					if attempt > 3
						madswarn("Temporary directory $tempdirname cannot be deleted!")
						trying = false
					end
				end
			end
			global modelruns += 1
			return results
		end
	elseif haskey(madsdata, "Sources") # we may still use "Wells" instead of "Observations"
		Mads.madsinfo("MADS internal Anasol model evaluation for contaminant transport ...\n")
		return makecomputeconcentrations(madsdata; calczeroweightobs=calczeroweightobs, calcpredictions=calcpredictions)
	else
		Mads.madserror("Cannot create a function to call model without an entry in the MADS problem dictionary!")
		Mads.madscritical("Use `Model`, `MADS model`, `Julia model`, `Command` or `Julia command`.")
	end
	function madscommandfunctionwithexpressions(paramsnoexpressions::Associative)
		expressions = evaluatemadsexpressions(madsdata, paramsnoexpressions)
		parameterswithexpressions = merge(paramsnoexpressions, expressions)
		return madscommandfunction(parameterswithexpressions)
	end
	return makemadsreusablefunction(getparamkeys(madsdata), obskeys, haskey(madsdata, "Restart") ? madsdata["Restart"] : nothing, madscommandfunctionwithexpressions, getrestartdir(madsdata))
end

function makemadsreusablefunction(madsdata::Associative, madscommandfunction, suffix=""; usedict::Bool=true)
	return makemadsreusablefunction(getparamkeys(madsdata), getobskeys(madsdata), haskey(madsdata, "Restart") ? madsdata["Restart"] : nothing, madscommandfunction, getrestartdir(madsdata, suffix); usedict=usedict)
end

function makemadsreusablefunction(paramkeys, obskeys, madsdatarestart, madscommandfunction, restartdir; usedict::Bool=true)
	if isdefined(:ReusableFunctions) && madsdatarestart != nothing
		if madsdatarestart == "memory"
			madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction)
			return madscommandfunctionwithreuse
		elseif madsdatarestart != false
			if usedict
				madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction, restartdir, paramkeys, obskeys)
			else
				madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction, restartdir)
			end
			return madscommandfunctionwithreuse
		else
			return madscommandfunction
		end
	else
		return madscommandfunction
	end
end

"""
Get the directory where restarts will be stored.
"""
function getrestartdir(madsdata::Associative, suffix="")
	rootname = join(split(split(madsdata["Filename"], "/")[end], ".")[1:end-1], ".")
	restartdir = ""
	if haskey(madsdata, "RestartDir")
		restartdir = madsdata["RestartDir"]
		if !isdir(restartdir)
			try
				mkdir(restartdir)
			catch
				restartdir = ""
				madscritical("Directory specified under 'RestartDir' ($restartdir) cannot be created")
			end
		end
	end
	if restartdir == ""
		if contains(madsdata["Filename"], "/")
			restartdir = string(join(split(madsdata["Filename"], "/")[1:end-1], "/"), "/", rootname, "_restart")
		else
			restartdir = string(rootname, "_restart")
		end
	end
	return joinpath(restartdir, suffix)
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
		madscritical("loading model defined in $(finename)")
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
	return makemadsreusablefunction(madsdata, madscommandfunctionandgradient, "jacobian")
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
function makemadsconditionalloglikelihood(madsdata::Associative; weightfactor::Real=1.)
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
function makemadsloglikelihood(madsdata::Associative; weightfactor::Real=1.)
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
