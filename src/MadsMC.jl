import RobustPmap
import BlackBoxOptim
import Lora
import JSON

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
	mcparams = Lora.BasicContMuvParameter(:p, logtarget=arrayloglikelihood)
	model = Lora.likelihood_model(mcparams, false)
	if Base.isbindingresolved(Lora, :RAM)
		sampler = Lora.RAM(fill(1e-1, length(initvals)), 0.3)
	else
		madswarn("Robust Adaptive Metropolis (RAM) method is not available")
		sampler = Lora.MH(fill(1e-1, length(initvals)))
	end
	mcrange = Lora.BasicMCRange(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
	mcparams0 = Dict(:p=>initvals)
	outopts = Dict{Symbol, Any}(:monitor=>[:value, :logtarget, :loglikelihood], :diagnostics=>[:accept])
	job = Lora.BasicMCJob(model, sampler, mcrange, mcparams0, outopts=outopts, tuner=Lora.VanillaMCTuner())
	Lora.run(job)
	chain = Lora.output(job)
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
function savemcmcresults(chain::Array, filename::AbstractString)
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
	JSON.print(f, Lora.mcse(chain))
	println(f, "")
	print(f, "MCvar: ")
	JSON.print(f, Lora.mcvar(chain))
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
function montecarlo(madsdata::Associative; N::Int=100, filename::AbstractString="")
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
