import ReusableFunctions
import OrderedCollections
import Distributions
import DocumentFunction
import Sockets
using Distributed

"""
Make MADS function to execute the model defined in the input MADS problem dictionary

$(DocumentFunction.documentfunction(makemadscommandfunction;
argtext=Dict("madsdata_in"=>"MADS problem dictionary"),
keytext=Dict("calczeroweightobs"=>"Calculate zero weight observations [default=`false`]",
             "calcpredictions"=>"Calculate predictions [default=`true`]")))

Example:

```julia
Mads.makemadscommandfunction(madsdata)
```

MADS can be coupled with any internal or external model. The model coupling is defined in the MADS problem dictionary. The expectations is that for a given set of model inputs, the model will produce a model output that will be provided to MADS. The fields in the MADS problem dictionary that can be used to define the model coupling are:

- `Model` : execute a Julia function defined in an input Julia file. The function that should accept a `parameter` dictionary with all the model parameters as an input argument and should return an `observation` dictionary with all the model predicted observations. MADS will execute the first function defined in the file.

- `MADS model` : create a Julia function based on an input Julia file. The input file should contain a function that accepts as an argument the MADS problem dictionary. MADS will execute the first function defined in the file. This function should a create a Julia function that will accept a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.

- `Julia model` : execute an internal Julia function that accepts a `parameter` dictionary with all the model parameters as an input argument and will return an `observation` dictionary with all the model predicted observations.

- `Command` : execute an external UNIX command or script that will execute an external model.

- `Julia command` : execute a Julia script that will execute an external model. The Julia script is defined in an input Julia file. The input file should contain a function that accepts a `parameter` dictionary with all the model parameters as an input argument; MADS will execute the first function defined in the file. The Julia script should be capable to (1) execute the model (making a system call of an external model), (2) parse the model outputs, (3) return an `observation` dictionary with model predictions.

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

Returns:

- Mads function to execute a forward model simulation
"""
function makemadscommandfunction(madsdata_in::AbstractDict; obskeys::Array{String}=getobskeys(madsdata_in), calczeroweightobs::Bool=false, calcpredictions::Bool=true) # make MADS command function
	#remove the obs (as long as it isn't anasol) from madsdata so they don't get sent when doing pmaps -- they aren't used here are they can require a lot of communication
	madsdata = Dict()
	if !haskey(madsdata_in, "Sources")
		for k in keys(madsdata_in)
			if k != "Observations" || k != "Wells"
				madsdata[k] = madsdata_in[k]
			end
		end
	else
		madsdata = madsdata_in
	end
	simpleproblem = Mads.checkmodeloutputdirs(madsdata)
	madsproblemdir = Mads.getmadsproblemdir(madsdata)
	if haskey(madsdata, "Julia model")
		Mads.madsinfo("""Model setup: Julia model -> Internal model evaluation of Julia function '$(madsdata["Julia model"])'""")
		madscommandfunction = madsdata["Julia model"]
	elseif haskey(madsdata, "MADS model")
		filename = joinpath(madsproblemdir, madsdata["MADS model"])
		Mads.madsinfo("Model setup: MADS model -> Internal MADS model evaluation a Julia script in file '$(filename)'")
		madsdatacommandfunction = importeverywhere(filename)
		local madscommandfunction
		try
			madscommandfunction = Base.invokelatest(madsdatacommandfunction, madsdata_in)
		catch errmsg
			printerrormsg(errmsg)
			Mads.madserror("MADS model function defined in '$(filename)' cannot be executed")
		end
		madscommandfunction = Base.invokelatest(madsdatacommandfunction, madsdata_in)
	elseif haskey(madsdata, "Model")
		filename = joinpath(madsproblemdir, madsdata["Model"])
		Mads.madsinfo("Model setup: Model -> Internal model evaluation a Julia script in file '$(filename)'")
		madscommandfunction = importeverywhere(filename)
	elseif haskey(madsdata, "Command") || haskey(madsdata, "Julia command")
		if haskey(madsdata, "Command")
			m = match(r"julia.*-p([\s[0-9]*|[0-9]*])", madsdata["Command"])
			npt = m != nothing ? Meta.parse(Int, m.captures[1]) : 1
			if nprocs_per_task_default > 1 && npt != nprocs_per_task_default
				if m != nothing
					madsdata["Command"] = replace(madsdata["Command"], r"(julia)(.*-p)[\s[0-9]*|[0-9]*]" => Base.SubstitutionString("$(Base.julia_cmd().exec[1]) --startup-file=no \\g<2> $nprocs_per_task_default"))
					Mads.madsinfo("Mads Command has been updated to account for the number of processors per task ($nprocs_per_task_default)\nNew Mads Command: $(madsdata["Command"])")
				else
					m = match(r"julia", madsdata["Command"])
					if m != nothing
						madsdata["Command"] = replace(madsdata["Command"], r"(julia)" => Base.SubstitutionString("$(Base.julia_cmd().exec[1]) --startup-file=no -p $nprocs_per_task_default "))
						Mads.madsinfo("Mads Command has been updated to account for the number of processors per task ($nprocs_per_task_default)\nNew Mads Command: $(madsdata["Command"])")
					end
				end
			else
				madsdata["Command"] = replace(madsdata["Command"], r"(julia)" => Base.SubstitutionString("$(Base.julia_cmd().exec[1]) --startup-file=no"))
				Mads.madsinfo("Mads Command has been updated to account for the location of julia: $(madsdata["Command"])")
			end
			Mads.madsinfo("""Model setup: Command -> External model evaluation of command '$(madsdata["Command"])'""")
		end
		if haskey(madsdata, "Julia command")
			filename = joinpath(madsproblemdir, madsdata["Julia command"])
			Mads.madsinfo("Model setup: Julia command -> Model evaluation using a Julia script in file '$(filename)'")
			madsdatacommandfunction = importeverywhere(filename)
		end
		currentdir = pwd()
		"MADS command function"
		function madscommandfunction(parameters::AbstractDict) # MADS command function
			if simpleproblem && currentdir != abspath(madsproblemdir)
				cd(madsproblemdir)
				cwd = pwd()
			else
				cwd = currentdir
			end
			local results
			attempt = 0
			trying = true
			tempdirname = ""
			while trying
				tempstring = "$(getpid())_$(Libc.strftime("%Y%m%d%H%M",time()))_$(Mads.modelruns)_$(randstring(6))"
				tempdirname = joinpath("..", "$(splitdir(cwd)[2])_$(tempstring)")
				Mads.createtempdir(tempdirname)
				Mads.linktempdir(cwd, tempdirname)
				cd(tempdirname)
				Mads.setmodelinputs(madsdata, parameters)
				execattempt = 0
				while (trying = !checknodedir(tempstring))
					execattempt += 1; sleep(1 * execattempt)
					if execattempt > 3
						attempt +=1; sleep(1 * attempt)
						if attempt > 3
							cd(currentdir)
							if Distributed.nprocs() > 1 && myid() != 1
								madswarn("Mads cannot create directory $(tempdirname) on $(gethostname() * "(" * string(Sockets.getipaddr()) * ")")!")
								madswarn("Process $(myid()) will be removed!"); remotecall(rmprocs, 1, myid())
								return nothing
							else
								madscritical("Mads cannot create directory $(tempdirname) on $(gethostname() * "(" * string(Sockets.getipaddr()) * ")")!")
							end
						end
						break
					end
				end
			end
			if haskey(madsdata, "Julia command")
				Mads.madsinfo("Executing Julia model-evaluation script parsing the model outputs (`Julia command`) in directory $(tempdirname) ...")
				attempt = 0
				trying = true
				latest = false
				while trying
					try
						attempt += 1
						if latest
							out = Base.invokelatest(madsdatacommandfunction, madsdata)
						else
							out = madsdatacommandfunction(madsdata)
						end
						results = convert(OrderedCollections.OrderedDict{Any,Float64}, out)
						trying = false
					catch errmsg
						if !latest
							latest = true; attempt = 0
						else
							if attempt > 3
								@show Base.stacktrace()
								cd(currentdir)
								printerrormsg(errmsg)
								if Distributed.nprocs() > 1 && myid() != 1
									madswarn("$(errmsg)\nJulia command '$(madsdata["Julia command"])' cannot be executed or failed in directory $(tempdirname) on $(gethostname() * "(" * string(Sockets.getipaddr()) * ")")!")
									madswarn("Process $(myid()) will be removed!")
									remotecall(rmprocs, 1, myid())
									return nothing
								else
									madscritical("$(errmsg)\nJulia command '$(madsdata["Julia command"])' cannot be executed or failed in directory $(tempdirname) on $(gethostname() * "(" * string(Sockets.getipaddr()) * ")")!")
								end
							end
							sleep(attempt * 0.5)
						end
					end
				end
			else
				Mads.madsinfo("Executing `Command` '$(madsdata["Command"])' in directory $(tempdirname) ...")
				attempt = 0
				trying = true
				while trying
					try
						runcmd(madsdata["Command"])
						# runcmd(`ls -altr`; quiet=false, pipe=true)
						trying = false
					catch errmsg
						runcmd(madsdata["Command"]; quiet=false, pipe=true)
						if attempt > 3
							@show Base.stacktrace()
							cd(currentdir)
							printerrormsg(errmsg)
							if Distributed.nprocs() > 1 && myid() != 1
								madswarn("Command '$(madsdata["Command"])' cannot be executed or failed in directory $(tempdirname)!")
								madswarn("Process $(myid()) will be removed!"); remotecall(rmprocs, 1, myid())
								return nothing
							else
								madscritical("Command '$(madsdata["Command"])' cannot be executed or failed in directory $(tempdirname)!")
							end
						end
						sleep(attempt * 0.5)
					end
				end
				results = readmodeloutput(madsdata; obskeys=obskeys)
			end
			cd(cwd)
			attempt = 0
			trying = true
			while trying
				try
					attempt += 1
					Mads.rmdir(tempdirname)
					madsinfo("Deleted temporary directory: $(tempdirname)", 1)
					trying = false
				catch errmsg
					if attempt > 3
						printerrormsg(errmsg)
						@show Base.stacktrace()
						madswarn("$(errmsg)\nTemporary directory $tempdirname cannot be deleted!")
						trying = false
					end
					sleep(attempt * 0.5)
				end
			end
			global modelruns += 1
			if simpleproblem && currentdir != madsproblemdir
				cd(currentdir)
			end
			return results
		end
	elseif haskey(madsdata, "Sources") && !haskey(madsdata, "Julia model")# we may still use "Wells" instead of "Observations"
		Mads.madsinfo("MADS internal Anasol model evaluation for contaminant transport ...\n")
		return makecomputeconcentrations(madsdata; calczeroweightobs=calczeroweightobs, calcpredictions=calcpredictions)
	else
		Mads.madswarn("Cannot create a function to call model without an entry in the MADS problem dictionary!")
		Mads.madscritical("Use `Model`, `MADS model`, `Julia model`, `Command` or `Julia command`.")
	end
	"MADS command function with expressions"
	function madscommandfunctionwithexpressions(paramsnoexpressions::AbstractDict)
		parameterswithexpressions = evaluatemadsexpressions(madsdata, paramsnoexpressions)
		local out
		try
			out = madscommandfunction(parameterswithexpressions)
		catch errmsg
			try
				out = Base.invokelatest(madscommandfunction, parameterswithexpressions)
			catch errmsg
				printerrormsg(errmsg)
				Mads.madswarn("Failed Dir: $(pwd())")
				Mads.madserror("madscommandfunction in madscommandfunctionwithexpressions cannot be executed!")
			end
		end
		return out
	end
	return makemadsreusablefunction(getparamkeys(madsdata), obskeys, getrestart(madsdata), madscommandfunctionwithexpressions, getrestartdir(madsdata))
end

function makemadsreusablefunction(madsdata::AbstractDict, madscommandfunction::Function, suffix::String=""; usedict::Bool=true)
	return makemadsreusablefunction(getparamkeys(madsdata), getobskeys(madsdata), getrestart(madsdata), madscommandfunction, getrestartdir(madsdata, suffix); usedict=usedict)
end
function makemadsreusablefunction(paramkeys::Vector, obskeys::Vector, madsdatarestart::Union{String,Bool}, madscommandfunction::Function, restartdir::String; usedict::Bool=true)
	if madsdatarestart == "memory" # this is not very cool
		madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction)
		return madscommandfunctionwithreuse
	elseif madsdatarestart == true
		if usedict
			madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction, restartdir, paramkeys, obskeys)
		else
			madscommandfunctionwithreuse = ReusableFunctions.maker3function(madscommandfunction, restartdir)
		end
		return madscommandfunctionwithreuse
	else
		return madscommandfunction
	end
end

@doc """
Make Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)

$(DocumentFunction.documentfunction(makemadsreusablefunction;
argtext=Dict("madsdata"=>"MADS problem dictionary",
             "madscommandfunction"=>"Mads function to execute a forward model simulation",
             "suffix"=>"Suffix to be added to the name of restart directory",
             "paramkeys"=>"Dictionary of parameter keys",
             "obskeys"=>"Dictionary of observation keys",
             "madsdatarestart"=>"Restart type (memory/disk) or on/off status",
             "restartdir"=>"Restart directory where the reusable model results are stored"),
keytext=Dict("usedict"=>"Use dictionary [default=`true`]")))

Returns:

- Reusable Mads function to execute a forward model simulation (automatically restarts if restart data exists)
""" makemadsreusablefunction

"""
Get the directory where Mads restarts will be stored

$(DocumentFunction.documentfunction(getrestartdir;
argtext=Dict("madsdata"=>"MADS problem dictionary",
             "suffix"=>"Suffix to be added to the name of restart directory")))

Returns:

- restart directory where reusable model results will be stored
"""
function getrestartdir(madsdata::AbstractDict, suffix::String="")
	restartdir = ""
	if haskey(madsdata, "RestartDir")
		restartdir = madsdata["RestartDir"]
		if !isdir(restartdir)
			try
				mkdir(restartdir)
			catch errmsg
				printerrormsg(errmsg)
				madscritical("$(errmsg)\nDirectory specified under 'RestartDir' ($restartdir) cannot be created!")
			end
		end
	elseif haskey(madsdata, "Restart") && typeof(madsdata["Restart"]) == String
		if madsdata["Restart"] == "memory" # this is not very cool
			return ""
		end
		restartdir = madsdata["Restart"]
		if !isdir(restartdir)
			try
				mkdir(restartdir)
			catch errmsg
				printerrormsg(errmsg)
				madscritical("$(errmsg)\nDirectory specified under 'Restart' ($restartdir) cannot be created!")
			end
		end
	end
	if restartdir == "" && (Mads.restart || haskey(madsdata, "Restart"))
		root = splitdir(getmadsrootname(madsdata, version=true))[end]
		restartdir = root * "_restart"
		if !isdir(restartdir)
			try
				mkdir(restartdir)
			catch errmsg
				printerrormsg(errmsg)
				madscritical("$(errmsg)\nDirectory ($restartdir) cannot be created!")
			end
		end
	end
	return joinpath(restartdir, suffix)
end

"""
Import Julia function everywhere from a file.
The first function in the Julia input file is the one that will be targeted by Mads for execution.

$(DocumentFunction.documentfunction(importeverywhere;
argtext=Dict("filename"=>"file name")))

Returns:

- Julia function to execute the model
"""
function importeverywhere(filename::String)
	code = read(filename, String)
	functionname = strip(split(split(code, "function")[2],"(")[1])
	extracode = quiet ? "" : "else Mads.madswarn(\"$functionname already defined\")"
	fullcode = "using Distributed; @everywhere begin if !isdefined(Mads, :$functionname) $code $extracode end end"
	q = Meta.parse(fullcode)
	Core.eval(Main, q)
	functionsymbol = Symbol(functionname)
	q = Expr(:., :Main, Meta.quot(functionsymbol))
	commandfunction = Core.eval(Mads, q)
	return commandfunction
end

"""
Make a function to compute the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`

$(DocumentFunction.documentfunction(makelogprior;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Return:

- the prior log-likelihood of the model parameters listed in the MADS problem dictionary `madsdata`
"""
function makelogprior(madsdata::AbstractDict)
	distributions = getparamdistributions(madsdata::AbstractDict)
	function logprior(params::AbstractDict)
		loglhood = 0.
		for paramname in getoptparamkeys(madsdata)
			loglhood += Distributions.loglikelihood(distributions[paramname], [params[paramname]])[1]
		end
		return loglhood
	end
end

"""
Make a function to compute the conditional log-likelihood of the model parameters conditioned on the model predictions/observations.
Model parameters and observations are defined in the MADS problem dictionary `madsdata`.

$(DocumentFunction.documentfunction(makemadsconditionalloglikelihood;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("weightfactor"=>"Weight factor [default=`1`]")))

Return:

- the conditional log-likelihood
"""
function makemadsconditionalloglikelihood(madsdata::AbstractDict; weightfactor::Number=1.)
	"MADS conditional log-likelihood functions"
	function conditionalloglikelihood(predictions::AbstractDict, observations::AbstractDict)
		loglhood = 0.
		#TODO replace this sum of squared residuals approach with the distribution from the "dist" observation keyword if it is there
		for obsname in keys(observations)
			pred = predictions[obsname]
			if haskey(observations[obsname], "target")
				obs = observations[obsname]["target"]
				diff = obs - pred
				if haskey(observations[obsname], "weight")
					weight = observations[obsname]["weight"]
					loglhood -= weight * diff * diff # divide by variance (weight = 1/var)
				else
					loglhood -= diff * diff # weight = 1
				end
			end
		end
		return weightfactor * loglhood
	end
  return conditionalloglikelihood
end

"""
Make a function to compute the log-likelihood for a given set of model parameters, associated model predictions and existing observations.
By default, the Log-likelihood function computed internally.
The Log-likelihood can be constructed from an external Julia function defined the MADS problem dictionary under `LogLikelihood` or `ConditionalLogLikelihood`.

In the case of a `LogLikelihood` external Julia function, the first function in the file provided should be a function that takes as arguments:
- dictionary of model parameters
- dictionary of model predictions
- dictionary of respective observations

In the case of a `ConditionalLogLikelihood` external Julia function, the first function in the file provided should be a function that takes as arguments:
- dictionary of model predictions
- dictionary of respective observations

$(DocumentFunction.documentfunction(makemadsloglikelihood;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("weightfactor"=>"Weight factor [default=`1`]")))

Returns:

- the log-likelihood for a given set of model parameters
"""
function makemadsloglikelihood(madsdata::AbstractDict; weightfactor::Number=1.)
	madsproblemdir = Mads.getmadsproblemdir(madsdata)
	if haskey(madsdata, "LogLikelihood")
		filename = joinpath(madsproblemdir, madsdata["LogLikelihood"])
		Mads.madsinfo("Log-likelihood function provided externally from a file: '$(filename)'")
		madsloglikelihood = importeverywhere(filename)
		return madsloglikelihood
	elseif haskey(madsdata, "ConditionalLogLikelihood")
		filename = joinpath(madsproblemdir, madsdata["ConditionalLogLikelihood"])
		Mads.madsinfo("Conditional Log-likelihood function provided externally from a file: '$(filename)'")
		conditionalloglikelihood = importeverywhere(filename)
		internalweightfactor = weightfactor
	else
		Mads.madsinfo("Log-likelihood function computed internally ...")
		conditionalloglikelihood = makemadsconditionalloglikelihood(madsdata; weightfactor=weightfactor)
		internalweightfactor = 1
	end
	logprior = makelogprior(madsdata)
	"MADS log-likelihood function"
	function madsloglikelihood(params::AbstractDict, predictions::AbstractDict, observations::AbstractDict)
		return logprior(params) + internalweightfactor * conditionalloglikelihood(predictions, observations)
	end
	return madsloglikelihood
end

function getrestarts()
	if nworkers() > 1
		r = ReusableFunctions.restarts
		for w in workers()
			r += remotecall_fetch(()->ReusableFunctions.restarts, w)
		end
		return r
	else
		return ReusableFunctions.restarts
	end
end

function getcomputes()
	if nworkers() > 1
		r = ReusableFunctions.computes
		for w in workers()
			r += remotecall_fetch(()->ReusableFunctions.computes, w)
		end
		return r
	else
		return ReusableFunctions.computes
	end
end