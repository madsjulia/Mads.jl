module Mads

using Optim
#import YAML
using PyCall
@pyimport yaml

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector)
	sineparams = asin((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return sineparams
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector)
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5)
	return params
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedg(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		straightgrad = g(params)
		f(x) = cos(x) / 2
		transformgrad = (upperbounds - lowerbounds) .* f(sineparams)
		return straightgrad .* transformgrad
	end
	return sinetransformedg
end

function loadyamlfile(filename::String)
	f = open(filename)
	#madsdict = YAML.load(f)
	yamldata = yaml.load(f)#for now we use the python library because the julia library crashes
	close(f)
	return yamldata
end

function dumpyamlfile(filename::String, yamldata)
	f = open(filename, "w")
	write(f, yaml.dump(yamldata))
	close(f)
end

function loadmadsfile(filename::String)
	madsdict = loadyamlfile(filename)
	parameters = Dict()
	for paramdict in madsdict["Parameters"]
		for key in keys(paramdict)
			parameters[key] = paramdict[key]
		end
	end
	madsdict["Parameters"] = parameters
	observations = Dict()
	for obsdict in madsdict["Observations"]
		for key in keys(obsdict)
			observations[key] = obsdict[key]
		end
	end
	madsdict["Observations"] = observations
	return madsdict
end

function readyamlpredictions(filename::String)
	return loadyamlfile(filename)
end

function makemadscommandfunction(madsdata)
	function madscommandfunction(parameters::Dict)
		newdirname = "../temp_$(replace(replace(strftime(time()), ":", ""), " ", "_"))_$(myid())_$(rand(Int64))"
		run(`mkdir $newdirname`)
		currentdir = pwd()
		run(`bash -c "ln -s $(currentdir)/* $newdirname"`)
		for filename in vcat(madsdata["YAMLPredictions"], madsdata["YAMLParameters"])
			run(`rm -f $(newdirname)/$filename`)
		end
		dumpyamlfile("$(newdirname)/$(madsdata["YAMLParameters"])", parameters)
		run(`bash -c "cd $newdirname; $(madsdata["Command"])"`)
		results = Dict()
		for filename in madsdata["YAMLPredictions"]
			results = merge(results, loadyamlfile("$(newdirname)/$filename"))
		end
		return results
	end
	return madscommandfunction
end

function makemadscommandgradient(madsdata)
	f = makemadscommandfunction(madsdata)
	function madscommandgradient(parameters::Dict)
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

function calibrate(madsdata)
	f = makemadscommandfunction(madsdata)
	g = makemadscommandgradient(madsdata)
	obskeys = [k for k in keys(madsdata["Observations"])]
	paramkeys = [k for k in keys(madsdata["Parameters"])]
	initparams = Array(Float64, length(paramkeys))
	lowerbounds = Array(Float64, length(paramkeys))
	upperbounds = Array(Float64, length(paramkeys))
	for i in 1:length(paramkeys)
		initparams[i] = madsdata["Parameters"][paramkeys[i]]["init"]
		lowerbounds[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		upperbounds[i] = madsdata["Parameters"][paramkeys[i]]["max"]
	end
	function f_lm(arrayparameters::Vector)
		parameters = Dict(paramkeys, arrayparameters)
		resultdict = f(parameters)
		squaredresiduals = Array(Float64, length(madsdata["Observations"]))
		i = 1
		for obskey in obskeys
			diff = resultdict[obskey] - madsdata["Observations"][obskey]["target"]
			squaredresiduals[i] = diff * sqrt(madsdata["Observations"][obskey]["weight"])
			i += 1
		end
		return squaredresiduals
	end
	function g_lm(arrayparameters::Vector)
		parameters = Dict(paramkeys, arrayparameters)
		gradientdict = g(parameters)
		jacobian = Array(Float64, (length(obskeys), length(paramkeys)))
		for i in 1:length(obskeys)
			for j in 1:length(paramkeys)
				jacobian[i, j] = gradientdict[obskeys[i]][paramkeys[j]]
			end
		end
		return jacobian
	end
	results = Optim.levenberg_marquardt(f_lm, g_lm, initparams, show_trace=true)
	return results
end

end
