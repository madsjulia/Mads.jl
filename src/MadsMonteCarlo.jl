import RobustPmap
import BlackBoxOptim
import Klara
import JSON

"""
Bayesian sampling with EMCEE: Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler

```
Mads.emceesampling(madsdata; numwalkers=10, nsteps=100, burnin=100, thinning=1, seed=2016, sigma=0.01)
Mads.emceesampling(madsdata, p0; numwalkers=10, nsteps=100, burnin=10, thinning=1, seed=2016)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `p0` : initial parameters (matrix of size (length(optparams), numwalkers))
- `numwalkers` : number of walkers (if in parallel this can be the number of available processors)
- `nsteps` : number of final realizations in the chain
- `burnin` :  number of initial realizations before the MCMC are recorded
- `thinning` : removal of any `thinning` realization
- `seed` : initial random number seed
- `sigma` : a standard deviation parameter used to initialize the walkers

Returns:

- `mcmcchain` : MCMC chain
- `llhoodvals` : log likelihoods of the final samples in the chain
"""
function emceesampling(madsdata::Associative; numwalkers::Int=10, nsteps::Int=100, burnin::Int=10, thinning::Int=1, sigma::Number=0.01, seed=0)
	if numwalkers <= 1
		numwalkers = 2
	end
	Mads.setseed(seed)
	optparamkeys = getoptparamkeys(madsdata)
	p0 = Array(Float64, length(optparamkeys), numwalkers)
	pinit = getparamsinit(madsdata, optparamkeys)
	pmin = getparamsmin(madsdata, optparamkeys)
	pmax = getparamsmax(madsdata, optparamkeys)
	for i = 1:length(optparamkeys)
		mu = (pinit[i] - pmin[i]) / (pmax[i] - pmin[i])
		mu = min(1 - 1e-3, max(mu, 1e-3))
		alpha = ((1 - mu) / sigma^2 - 1 / mu)
		beta = alpha * (1 / mu - 1)
		d = Distributions.Beta(alpha, mu)
		for j = 1:numwalkers
			p0[i, j] = pmin[i] + rand(d) * (pmax[i] - pmin[i])
		end
	end
	return emceesampling(madsdata, p0; numwalkers=numwalkers, nsteps=nsteps, burnin=burnin, thinning=thinning, seed=seed)
end

function emceesampling(madsdata::Associative, p0::Array; numwalkers::Int=10, nsteps::Int=100, burnin::Int=10, thinning::Int=1, seed=0)
	@assert length(size(p0)) == 2
	Mads.setseed(seed)
	madsloglikelihood = makemadsloglikelihood(madsdata)
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	burninchain, _ = Mads.emcee(arrayloglikelihood, numwalkers, p0, Int(burnin / numwalkers), 1)
	chain, llhoods = Mads.emcee(arrayloglikelihood, numwalkers, burninchain[:, :, end], Int(nsteps / numwalkers), thinning)
	return Mads.flattenmcmcarray(chain, llhoods)
end

"""
Bayesian Sampling

```
Mads.bayessampling(madsdata; nsteps=1000, burnin=100, thinning=1, seed=2016)
Mads.bayessampling(madsdata, numsequences; nsteps=1000, burnin=100, thinning=1, seed=2016)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `numsequences` : number of sequences executed in parallel
- `nsteps` : number of final realizations in the chain
- `burnin` :  number of initial realizations before the MCMC are recorded
- `thinning` : removal of any `thinning` realization
- `seed` : initial random number seed

Returns:

- `mcmcchain` : 
"""
function bayessampling(madsdata::Associative; nsteps::Int=1000, burnin::Int=100, thinning::Int=1, seed=0)
	Mads.setseed(seed)
	madsloglikelihood = makemadsloglikelihood(madsdata)
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	optparamkeys = getoptparamkeys(madsdata)
	initvals = Array(Float64, length(optparamkeys))
	for i = 1:length(optparamkeys)
		initvals[i] = madsdata["Parameters"][optparamkeys[i]]["init"]
	end
	mcparams = Klara.BasicContMuvParameter(:p, logtarget=arrayloglikelihood)
	model = Klara.likelihood_model(mcparams, false)
	if VERSION < v"0.5.0-dev"
			sampler = Klara.RAM(fill(1e-1, length(initvals)))
	else
			sampler = Klara.MH(fill(1e-1, length(initvals)))
	end
	# sampler = Klara.RAM(fill(1e-1, length(initvals)))
	mcrange = Klara.BasicMCRange(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
	mcparams0 = Dict(:p=>initvals)
	outopts = Dict{Symbol, Any}(:monitor=>[:value, :logtarget, :loglikelihood], :diagnostics=>[:accept])
	job = Klara.BasicMCJob(model, sampler, mcrange, mcparams0, outopts=outopts, tuner=Klara.VanillaMCTuner())
	Klara.run(job)
	chain = Klara.output(job)
	return chain
end

function bayessampling(madsdata, numsequences; nsteps::Int=1000, burnin::Int=100, thinning::Int=1, seed=0)
	if seed != 0
		mcmcchains = RobustPmap.rpmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning, seed=seed+i), 1:numsequences)
	else
		mcmcchains = RobustPmap.rpmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning), 1:numsequences)
	end
	return mcmcchains
end

"Save MCMC chain in a file"
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
	println(f, "")
	print(f, "MCse: ")
	JSON.print(f, Klara.mcse(chain))
	println(f, "")
	print(f, "MCvar: ")
	JSON.print(f, Klara.mcvar(chain))
	println(f, "")
	close(f)
end

"""
Monte Carlo analysis

`Mads.montecarlo(madsdata; N=100)`

Arguments:

- `madsdata` : MADS problem dictionary sampling uniformly between mins/maxs
- `N` : number of samples (default = 100)

Returns:

- `outputdicts` : parameter dictionary containing the data arrays

Dumps:

- YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)
"""
function montecarlo(madsdata::Associative; N::Int=100, filename::String="")
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
	results = RobustPmap.rpmap(f, paramdicts)
	outputdicts = Array(Dict, N)
	for i = 1:N
		outputdicts[i] = Dict()
		outputdicts[i]["Parameters"] = paramdicts[i]
		outputdicts[i]["Results"] = results[i]
	end
	#rootname = Mads.getmadsrootname(madsdata)
	#filename = rootname * ".mcresults.yaml"
	if filename != ""
		dumpyamlfile(filename, outputdicts)
	end
	return outputdicts
end

"""
Convert parameter array to a parameter dictionary of arrays
"""
function paramarray2dict(madsdata::Associative, array::Array)
	paramkeys = getoptparamkeys(madsdata)
	dict = DataStructures.OrderedDict()
	for i in 1:length(paramkeys)
		dict[paramkeys[i]] = array[:,i]
	end
	return dict
end
