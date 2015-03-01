using Distributions
using MadsYAML
using MadsASCII
export loadyamlmadsfile

function makemadscommandfunction(madsdata) # make MADS command function
	if haskey(madsdata, "Model")
    println("Internal model evaluation ...")
		madscommandfunction = evalfile(madsdata["Model"])
	elseif haskey(madsdata, "Command")
    println("External command execution ...")
		function madscommandfunction(parameters::Dict) # MADS command function
			newdirname = "../$(split(pwd(),"/")[end])_$(strftime("%Y%m%d%H%M",time()))_$(@printf("%10d",rand(Uint32)))_$(myid())"
      # println("Temp directory ", newdirname)
			run(`mkdir $newdirname`)
			currentdir = pwd()
			run(`bash -c "ln -s $(currentdir)/* $newdirname"`) # link all the files in the current directory
			if haskey(madsdata, "Templates") # Templates/Instructions
        for filename in vcat(madsdata["Templates"][]["write"], madsdata["Instructions"][]["read"])
				  run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
			  end
        cd(newdirname)
        writeparameters(madsdata)
        cd(currentdir)
      elseif haskey(madsdata, "YAMLParameters") # YAML
        for filename in vcat(madsdata["YAMLPredictions"], madsdata["YAMLParameters"])
				  run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
			  end
        MadsYAML.dumpasciifile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters) # create parameter files
      elseif haskey(madsdata, "ASCIIParameters") # ASCII
			  for filename in vcat(madsdata["ASCIIPredictions"], madsdata["ASCIIParameters"])
				  run(`rm -f $(newdirname)/$filename`) # delete the parameter file links
			  end
			  MadsASCII.dumpasciifile("$(newdirname)/$(madsdata["ASCIIParameters"])", values(parameters)) # create parameter files
      end
      # println("Execute ", madsdata["Command"])
			run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
			results = Dict()
			if haskey(madsdata, "Instructions") # Templates/Instructions
        cd(newdirname)
        readobservations(madsdata)
        cd(currentdir)
      elseif haskey(madsdata, "YAMLPredictions") # YAML
			  for filename in madsdata["YAMLPredictions"]
				  results = merge(results, MadsYAML.loadyamlfile("$(newdirname)/$filename"))
			  end
      elseif haskey(madsdata, "ASCIIPredictions") # ASCII
        predictions = MadsASCII.loadasciifile("$(newdirname)/$(madsdata["ASCIIPredictions"])")
        obskeys = getobskeys(madsdata)
        @assert length(obskeys) == length(predictions)
        times = 1:length(obskeys)
	      results = Dict{String, Float64}(map(i -> string("o", i), times), predictions)
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

function getparamkeys(madsdata)
	return [k for k in keys(madsdata["Parameters"])]
end

function getobskeys(madsdata)
	return [k for k in keys(madsdata["Observations"])]
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
      println( "Replacing ", strip(splitline[2 * i]), "->", parameters[strip(splitline[2 * i])]["init"] )
			write(outfile, string(parameters[strip(splitline[2 * i])]["init"])) # replace the initial value for the parameter; splitline[2 * i] in this case is parameter ID
		end
		write(outfile, splitline[end]) # write the rest of the line after the last separator
	end
	close(outfile)
end

function writeparameters(madsdata)
	for template in madsdata["Templates"]
		writeparamtersviatemplate(madsdata["Parameters"], template["tpl"], template["write"])
	end
end

function readobservationsviainstructions(observations, instructionfilename, inputfilename)
  #TODO
end

function readobservations(madsdata)
	for instruction in madsdata["Instructions"]
		readobservationsviainstructions(madsdata["Observations"], instruction["ins"], instruction["read"])
	end
end

function getdistributions(madsdata)
	paramkeys = getparamkeys(madsdata)
	distributions = Dict()
	for i in 1:length(paramkeys)
		distributions[paramkeys[i]] = eval(parse(madsdata["Parameters"][paramkeys[i]]["dist"]))
	end
	return distributions
end
