import OrderedCollections
import RobustPmap
import JSON
import AffineInvariantMCMC
import DocumentFunction
import BlackBoxOptim

function emceesampling(madsdata::AbstractDict; numwalkers::Integer=10, nsteps::Integer=100, burnin::Integer=10, thinning::Integer=1, sigma::Number=0.01, seed::Integer=-1, weightfactor::Number=1.0)
	if numwalkers <= 1
		numwalkers = 2
	end
	Mads.setseed(seed)
	optparamkeys = getoptparamkeys(madsdata)
	p0 = Array{Float64}(undef, length(optparamkeys), numwalkers)
	pinit = getparamsinit(madsdata, optparamkeys)
	pmin = getparamsmin(madsdata, optparamkeys)
	pmax = getparamsmax(madsdata, optparamkeys)
	for i = 1:length(optparamkeys)
		mu = (pinit[i] - pmin[i]) / (pmax[i] - pmin[i])
		mu = min(1 - 1e-3, max(mu, 1e-3))
		alpha = (1 - sigma ^ 2 - sigma ^ 2 * ((1 - mu) / mu) - mu) / (sigma ^ 2 + 2 * sigma ^ 2 * ((1 - mu) / mu) + sigma ^ 2 * ((1 - mu) / mu) ^ 2)
		beta = alpha * ((1 - mu) / mu)
		d = Distributions.Beta(alpha, beta)
		p0[i, 1] = pinit[i]
		for j = 2:numwalkers
			p0[i, j] = pmin[i] + rand(d) * (pmax[i] - pmin[i])
		end
	end
	return emceesampling(madsdata, p0; numwalkers=numwalkers, nsteps=nsteps, burnin=burnin, thinning=thinning, seed=seed, weightfactor=weightfactor)
end
function emceesampling(madsdata::AbstractDict, p0::Array; numwalkers::Integer=10, nsteps::Integer=100, burnin::Integer=10, thinning::Integer=1, seed::Integer=-1, weightfactor::Number=1.0)
	@assert length(size(p0)) == 2
	Mads.setseed(seed)
	madsloglikelihood = makemadsloglikelihood(madsdata; weightfactor=weightfactor)
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	newnsteps = div(burnin, numwalkers)
	if newnsteps < 2
		newnsteps = 2
	end
	burninchain, _ = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, p0, newnsteps, 1)
	newnsteps = div(nsteps, numwalkers)
	if newnsteps < 2
		newnsteps = 2
	end
	chain, llhoods = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, burninchain[:, :, end], newnsteps, thinning)
	return AffineInvariantMCMC.flattenmcmcarray(chain, llhoods)
end

@doc """
Bayesian sampling with Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

$(DocumentFunction.documentfunction(emceesampling;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "p0"=>"initial parameters (matrix of size (number of parameters, number of walkers) or (length(Mads.getoptparamkeys(madsdata)), numwalkers))"),
keytext=Dict("numwalkers"=>"number of walkers (if in parallel this can be the number of available processors; in general, the higher the number of walkers, the better the results and computational time [default=`10`]",
            "nsteps"=>"number of final realizations in the chain [default=`100`]",
            "burnin"=>"number of initial realizations before the MCMC are recorded [default=`10`]",
            "thinning"=>"removal of any `thinning` realization [default=`1`]",
            "sigma"=>"a standard deviation parameter used to initialize the walkers [default=`0.01`]",
            "seed"=>"random seed [default=`0`]",
            "weightfactor"=>"weight factor [default=`1.0`]")))

Returns:

- MCMC chain
- log likelihoods of the final samples in the chain

Examples:

```julia
Mads.emceesampling(madsdata; numwalkers=10, nsteps=100, burnin=100, thinning=1, seed=2016, sigma=0.01)
Mads.emceesampling(madsdata, p0; numwalkers=10, nsteps=100, burnin=10, thinning=1, seed=2016)
```
""" emceesampling

if isdefined(Mads, :Klara) && isdefined(Klara, :BasicContMuvParameter)
	function bayessampling(madsdata::AbstractDict; nsteps::Integer=1000, burnin::Integer=100, thinning::Integer=1, seed::Integer=-1)
		Mads.setseed(seed)
		madsloglikelihood = makemadsloglikelihood(madsdata)
		arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
		optparamkeys = getoptparamkeys(madsdata)
		initvals = Array{Float64}(undef, length(optparamkeys))
		for i = 1:length(optparamkeys)
			initvals[i] = madsdata["Parameters"][optparamkeys[i]]["init"]
		end
		mcparams = Klara.BasicContMuvParameter(:p, logtarget=arrayloglikelihood)
		model = Klara.likelihood_model(mcparams, false)
		# sampler = Klara.MH(fill(1e-1, length(initvals)))
		sampler = Klara.RAM(fill(1e-1, length(initvals)))
		mcrange = Klara.BasicMCRange(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
		mcparams0 = Dict(:p=>initvals)
		outopts = Dict{Symbol, Any}(:monitor=>[:value, :logtarget, :loglikelihood], :diagnostics=>[:accept])
		job = Klara.BasicMCJob(model, sampler, mcrange, mcparams0, outopts=outopts, tuner=Klara.VanillaMCTuner())
		Klara.run(job)
		chain = Klara.output(job)
		return chain
	end
	function bayessampling(madsdata::AbstractDict, numsequences::Integer; nsteps::Integer=1000, burnin::Integer=100, thinning::Integer=1, seed::Integer=-1)
		if seed != 0
			mcmcchains = RobustPmap.rpmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning, seed=seed+i), 1:numsequences)
		else
			mcmcchains = RobustPmap.rpmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning), 1:numsequences)
		end
		return mcmcchains
	end

	@doc """
	Bayesian Sampling

	$(DocumentFunction.documentfunction(bayessampling;
	argtext=Dict("madsdata"=>"MADS problem dictionary",
	            "numsequences"=>"number of sequences executed in parallel"),
	keytext=Dict("nsteps"=>"number of final realizations in the chain [default=`1000`]",
	            "burnin"=>"number of initial realizations before the MCMC are recorded [default=`100`]",
	            "thinning"=>"removal of any `thinning` realization [default=`1`]",
	            "seed"=>"random seed [default=`0`]")))

	Returns:

	- MCMC chain

	Examples:

	```julia
	Mads.bayessampling(madsdata; nsteps=1000, burnin=100, thinning=1, seed=2016)
	Mads.bayessampling(madsdata, numsequences; nsteps=1000, burnin=100, thinning=1, seed=2016)
	```
	""" bayessampling
end

"""
Save MCMC chain in a file

$(DocumentFunction.documentfunction(savemcmcresults;
argtext=Dict("chain"=>"MCMC chain",
            "filename"=>"file name")))

Dumps:

- the file containing MCMC chain
"""
function savemcmcresults(chain::Array, filename::String)
	f = open(filename, "w")
	print(f, "Min: ")
	JSON.print(f, minimum(chain, 1)[:])
	println(f, "")
	print(f, "Max: ")
	JSON.print(f, maximum(chain, 1)[:])
	println(f, "")
	print(f, "Mean: ")
	JSON.print(f, mean(chain, 1)[:])
	println(f, "")
	print(f, "Variance: ")
	JSON.print(f, var(chain, 1)[:])
	#println(f, "")
	#print(f, "MCse: ")
	#JSON.print(f, Klara.mcse(chain))
	#println(f, "")
	#print(f, "MCvar: ")
	#JSON.print(f, Klara.mcvar(chain))
	#println(f, "")
	close(f)
end

"""
Monte Carlo analysis

$(DocumentFunction.documentfunction(montecarlo;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("N"=>"number of samples [default=`100`]",
            "filename"=>"file name to save Monte-Carlo results")))

Returns:

- parameter dictionary containing the data arrays

Dumps:

- YAML output file with the parameter dictionary containing the data arrays

Example:

```julia
Mads.montecarlo(madsdata; N=100)
```
"""
function montecarlo(madsdata::AbstractDict; N::Integer=100, filename::String="")
	paramkeys = getparamkeys(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	logoptparamkeys = getlogparamkeys(madsdata, optparamkeys)
	nonlogoptparamkeys = getnonlogparamkeys(madsdata, optparamkeys)
	paramtypes = getparamstype(madsdata)
	paramlogs = getparamslog(madsdata)
	logoptparamsmin = log10.(getparamsmin(madsdata, logoptparamkeys))
	logoptparamsmax = log10.(getparamsmax(madsdata, logoptparamkeys))
	nonlogoptparamsmin = getparamsmin(madsdata, nonlogoptparamkeys)
	nonlogoptparamsmax = getparamsmax(madsdata, nonlogoptparamkeys)
	logoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(logoptparamsmin, logoptparamsmax, N)
	nonlogoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(nonlogoptparamsmin, nonlogoptparamsmax, N)
	paramdicts = Array{OrderedCollections.OrderedDict}(undef, N)
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
		paramdicts[i] = OrderedCollections.OrderedDict{String,Float64}(zip(paramkeys, params))
	end
	f = makemadscommandfunction(madsdata)
	results = RobustPmap.rpmap(f, paramdicts)
	outputdicts = Array{OrderedCollections.OrderedDict}(undef, N)
	for i = 1:N
		outputdicts[i] = OrderedCollections.OrderedDict()
		outputdicts[i]["Parameters"] = paramdicts[i]
		outputdicts[i]["Results"] = results[i]
	end
	filename != "" && dumpyamlfile(filename, outputdicts)
	return outputdicts
end

"""
Convert a parameter array to a parameter dictionary of arrays

$(DocumentFunction.documentfunction(paramarray2dict;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "array"=>"parameter array")))

Returns:

- a parameter dictionary of arrays
"""
function paramarray2dict(madsdata::AbstractDict, array::Array)
	paramkeys = getoptparamkeys(madsdata)
	dict = OrderedCollections.OrderedDict()
	for i in 1:length(paramkeys)
		dict[paramkeys[i]] = array[:,i]
	end
	return dict
end

"""
Convert a parameter dictionary of arrays to a parameter array

$(DocumentFunction.documentfunction(paramdict2array;
argtext=Dict("dict"=>"parameter dictionary of arrays")))

Returns:

- a parameter array
"""
function paramdict2array(dict::AbstractDict)
	return permutedims(hcat(map(i->collect(dict[i]), collect(keys(dict)))...))
end
