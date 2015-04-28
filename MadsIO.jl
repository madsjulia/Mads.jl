using Distributions
using MadsYAML
using MadsASCII

function makemadscommandfunction(madsdata) # make MADS command function
	if haskey(madsdata, "Dynamic model")
		println("Dynamic model evaluation")
		madscommandfunction = madsdata["Dynamic model"]
	elseif haskey(madsdata, "Model")
		println("Internal model evaluation ...")
		madscommandfunction = evalfile(madsdata["Model"])
	elseif haskey(madsdata, "Command")
		madsinfo("External command execution ...")
		function madscommandfunction(parameters::Dict) # MADS command function
			newdirname = "../$(split(pwd(),"/")[end])_$(strftime("%Y%m%d%H%M",time()))_$(randstring(6))_$(myid())"
			madsinfo("""Temp directory: $(newdirname)""")
			run(`mkdir $newdirname`)
			currentdir = pwd()
			run(`bash -c "ln -s $(currentdir)/* $newdirname"`) # link all the files in the current directory
			if haskey(madsdata, "Instructions") # Templates/Instructions
				for filename in vcat(madsdata["Instructions"][]["read"])
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
			end
			if haskey(madsdata, "Templates") # Templates/Instructions
				for filename in vcat(madsdata["Templates"][]["write"])
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				cd(newdirname)
				for template in madsdata["Templates"]
					writeparamtersviatemplate(parameters, template["tpl"], template["write"]) # write the parameters
				end
				cd(currentdir)
			elseif haskey(madsdata, "YAMLParameters") # YAML
				for filename in vcat(madsdata["YAMLPredictions"], madsdata["YAMLParameters"])
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				MadsYAML.dumpyamlfile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters) # create parameter files
			elseif haskey(madsdata, "ASCIIParameters") # ASCII
				for filename in vcat(madsdata["ASCIIPredictions"], madsdata["ASCIIParameters"])
					run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
				end
				MadsASCII.dumpasciifile("$(newdirname)/$(madsdata["ASCIIParameters"])", values(parameters)) # create parameter files
			end
			madsinfo("""Execute: $(madsdata["Command"])""")
			run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
			results = OrderedDict()
			if haskey(madsdata, "Instructions") # Templates/Instructions
				cd(newdirname)
				results = readobservations(madsdata)
				cd(currentdir)
				madsinfo("""Observations: $(results)""")
			elseif haskey(madsdata, "YAMLPredictions") # YAML
				for filename in madsdata["YAMLPredictions"]
					results = merge(results, MadsYAML.loadyamlfile("$(newdirname)/$filename"))
				end
			elseif haskey(madsdata, "ASCIIPredictions") # ASCII
				predictions = MadsASCII.loadasciifile("$(newdirname)/$(madsdata["ASCIIPredictions"])")
				obskeys = getobskeys(madsdata)
				obsid=[convert(String,k) for k in obskeys] # TODO make sure that yaml parsing preserves the order in the input file
				@assert length(obskeys) == length(predictions)
				results = OrderedDict{String, Float64}(zip(obsid, predictions))
			end
			run(`rm -fR $newdirname`)
			return results
		end
	else
		error("Cannot create a madscommand function without a Model or a Command entry in the mads input file")
	end
	return madscommandfunction
end

function makemadscommandgradient(madsdata) # make MADS command gradient function
	f = makemadscommandfunction(madsdata)
	return makemadscommandgradient(madsdata, f)
end

function makemadscommandgradient(madsdata, f::Function) # make MADS command gradient function
	function madscommandgradient(parameters::Dict) # MADS command gradient function
		xph = Dict()
		h = 1e-6
		xph["noparametersvaried"] = parameters
		i = 2
		for paramkey in keys(parameters)
			xph[paramkey] = copy(parameters)
			xph[paramkey][paramkey] += h
			i += 1
		end
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph)
		fevalsdict = Dict()
		for feval in fevals
			fevalsdict[feval[1]] = feval[2]
		end
		gradient = Dict()
		resultkeys = keys(fevals[1][2])
		for resultkey in resultkeys
			gradient[resultkey] = Dict()
			for paramkey in keys(parameters)
				gradient[resultkey][paramkey] = (fevalsdict[paramkey][resultkey] - fevalsdict["noparametersvaried"][resultkey]) / h
			end
		end
		return gradient
	end
	return madscommandgradient
end

function makemadscommandfunctionandgradient(madsdata)
	f = makemadscommandfunction(madsdata)
	function madscommandfunctionandgradient(parameters::Dict) # MADS command gradient function
		xph = Dict()
		h = 1e-6
		xph["noparametersvaried"] = parameters
		i = 2
		for paramkey in keys(parameters)
			xph[paramkey] = copy(parameters)
			xph[paramkey][paramkey] += h
			i += 1
		end
		fevals = pmap(keyval->[keyval[1], f(keyval[2])], xph)
		fevalsdict = Dict()
		for feval in fevals
			fevalsdict[feval[1]] = feval[2]
		end
		gradient = Dict()
		resultkeys = keys(fevals[1][2])
		for resultkey in resultkeys
			gradient[resultkey] = Dict()
			for paramkey in keys(parameters)
				gradient[resultkey][paramkey] = (fevalsdict[paramkey][resultkey] - fevalsdict["noparametersvaried"][resultkey]) / h
			end
		end
		return fevalsdict["noparametersvaried"], gradient
	end
	return madscommandfunctionandgradient
end

function makemadsloglikelihood(madsdata)
	if haskey(madsdata, "LogLikelihood")
		println("Internal log likelihood")
		madsloglikelihood = evalfile(madsdata["LogLikelihood"]) # madsloglikelihood should be a function that takes a dict of MADS parameters, a dict of model predictions, and a dict of MADS observations
	else
		println("External log likelihood")
		function madsloglikelihood{T1<:Associative, T2<:Associative, T3<:Associative}(params::T1, predictions::T2, observations::T3)
			#TODO replace this sum of squared residuals approach with the distribution from the "dist" observation keyword if it is there
			wssr = 0.
			for obsname in keys(predictions)
				pred = predictions[obsname]
				obs = observations[obsname]["target"]
				weight = observations[obsname]["weight"]
				diff = obs - pred
				wssr += weight * diff * diff
			end
			return -wssr
		end
	end
	return madsloglikelihood
end

function getparamkeys(madsdata)
	return collect(keys(madsdata["Parameters"]))
	#return [convert(String,k) for k in keys(madsdata["Parameters"])]
end

function getobskeys(madsdata)
	return collect(keys(madsdata["Observations"]))
	#return [convert(String,k) for k in keys(madsdata["Observations"])]
end

function writeparamtersviatemplate(parameters, templatefilename, outputfilename)
	tplfile = open(templatefilename) # open template file
	line = readline(tplfile) # read the first line that says "template $separator\n"
	separator = line[end-1] # template separator
	lines = readlines(tplfile)
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

function writeparameters(madsdata)
	paramsinit = getparamsinit(madsdata)
	paramkeys = getparamkeys(madsdata)
	for template in madsdata["Templates"]
		writeparamtersviatemplate(Dict(paramkeys, paramsinit), template["tpl"], template["write"])
	end
end

function cmadsins_obs(obsid::Array{Any,1}, instructionfilename::ASCIIString, inputfilename::ASCIIString)
	n = length(obsid)
	obsval = zeros(n) # initialize to 0
	obscheck = -1 * ones(n) # initialize to -1
	debug = 1 # setting debug level 0 or 1 works
	# int ins_obs( int nobs, char **obs_id, double *obs, double *check, char *fn_in_t, char *fn_in_d, int debug );
	result = ccall( (:ins_obs, "libmads"), Int32,
					(Int32, Ptr{Ptr{Uint8}}, Ptr{Float64}, Ptr{Float64}, Ptr{Uint8}, Ptr{Uint8}, Int32),
					n, obsid, obsval, obscheck, instructionfilename, inputfilename, debug)
	observations = Dict{String, Float64}(obsid, obsval)
	return observations
end

function readobservations(madsdata)
	obsid=getobskeys(madsdata)
	observations = Dict()
	for instruction in madsdata["Instructions"]
		obs = cmadsins_obs(obsid, instruction["ins"], instruction["read"])
		observations = merge(observations, obs)
	end
	return observations
end

function getdistributions(madsdata)
	paramkeys = getparamkeys(madsdata)
	distributions = Dict()
	for i in 1:length(paramkeys)
		if haskey(madsdata["Parameters"][paramkeys[i]], "dist")
			distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
		else
			distributions[paramkeys[i]] = Uniform(madsdata["Parameters"][paramkeys[i]]["min"], madsdata["Parameters"][paramkeys[i]]["max"])
		end
	end
	return distributions
end
