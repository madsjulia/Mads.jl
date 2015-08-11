import BlackBoxOptim
import Lora
import Compose
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
@docstrings

function scatterplotsamples(samples::Matrix, paramnames::Vector, filename::String)
	cs = Array(Compose.Context, (size(samples, 2), size(samples, 2)))
	for i in 1:size(samples, 2)
		for j in 1:size(samples, 2)
			if i == j
				cs[i, j] = Gadfly.render(plot(x=samples[:, i], Gadfly.Geom.histogram, Gadfly.Guide.xlabel(paramnames[i])))
			else
				cs[i, j] = Gadfly.render(plot(x=samples[:, i], y=samples[:, j], Gadfly.Guide.xlabel(paramnames[i]), Gadfly.Guide.ylabel(paramnames[j])))
			end
		end
	end
	draw(SVG(filename, (3 * size(samples, 2))inch, (3 * size(samples, 2))inch), Compose.gridstack(cs))
end

@doc "Bayes Sampling " ->
function bayessampling(madsdata; nsteps=int(1e2), burnin=int(1e3), thinning=1)
	#TODO make it sample only over the opt params
	madsloglikelihood = makemadsloglikelihood(madsdata)
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	optparamkeys = getoptparamkeys(madsdata)
	initvals = Array(Float64, length(optparamkeys))
	for i = 1:length(optparamkeys)
		initvals[i] = madsdata["Parameters"][optparamkeys[i]]["init"]
	end
	mcmcmodel = Lora.model(arrayloglikelihood, init=initvals)
	sampler = Lora.RAM(1e-1, 0.3)
	smc = Lora.SerialMC(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
	mcmcchain = Lora.run(mcmcmodel, sampler, smc)
	return mcmcchain
end

@doc "Brute force parallel Bayesian sampling " ->
function bayessampling(madsdata, numsequences; nsteps=int(1e2), burnin=int(1e3))
	mcmcchains = pmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin), 1:numsequences)
	return mcmcchains
end

@doc "Do a forward Monte Carlo analysis " ->
function montecarlo(madsdata; N=int(1e2))
	paramkeys = getparamkeys(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	logoptparamkeys = getlogparamkeys(madsdata, optparamkeys)
	nonlogoptparamkeys = getnonlogparamkeys(madsdata, optparamkeys)
	paramtypes = getparamstype(madsdata)
	paramlogs = getparamslog(madsdata)
	logoptparamsmin = log10(getparamsmin(madsdata, logoptparamkeys))
	logoptparamsmax = log10(getparamsmax(madsdata, logoptparamkeys))
	nonlogoptparamsmin = getparamsmin(madsdata, nonlogoptparamkeys)
	nonlogoptparamsmax = getparamsmax(madsdata, nonlogoptparamkeys)
	logoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(logoptparamsmin, logoptparamsmax, N)
	nonlogoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(nonlogoptparamsmin, nonlogoptparamsmax, N)
	paramdicts = Array(Dict, N)
	params = getparamsinit(madsdata)
	for i = 1:N
		klog = 1
		knonlog = 1
		for j = 1:length(params)
			if paramtypes[j] == "opt"
				if paramlogs[j] == true || paramlogs[j] == "yes"
					params[j] = 10 ^ logoptparams[klog, i]
					klog += 1
				else
					params[j] = nonlogoptparams[knonlog, i]
					knonlog += 1
				end
			end
		end
		paramdicts[i] = Dict(zip(paramkeys, params))
	end
	f = makemadscommandfunction(madsdata)
	results = pmap(f, paramdicts)
	outputdicts = Array(Dict, N)
	for i = 1:N
		outputdicts[i] = Dict()
		outputdicts[i]["Parameters"] = paramdicts[i]
		outputdicts[i]["Results"] = results[i]
	end
	outputfilename = string(madsdata["Filename"][1:end-5], ".mcresults.yaml")
	dumpyamlfile(outputfilename, outputdicts)
	return outputdicts
end
