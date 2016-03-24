import BlackBoxOptim
import Lora

"""
Bayes Sampling

```
Mads.bayessampling(madsdata; nsteps=100, burnin=1000, thinning=1)
Mads.bayessampling(madsdata, numsequences; nsteps=100, burnin=1000, thinning=1)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `numsequences` : number of sequences executed in parallel
- `nsteps` :  
- `burnin` :  
- `thinning` :   

Returns:

- `mcmcchain` : 
"""
function bayessampling(madsdata::Associative; nsteps::Int=100, burnin::Int=1000, thinning::Int=1)
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
	job = Lora.BasicMCJob(model, sampler, mcrange, mcparams0, tuner=Lora.VanillaMCTuner())
	Lora.run(job)
	chain = Lora.output(job)
	return chain
end

function bayessampling(madsdata, numsequences; nsteps::Int=100, burnin::Int=1000, thinning::Int=1)
	mcmcchains = RobustPmap.rpmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning), 1:numsequences)
	return mcmcchains
end

function savemcmcresults(chain, filename::AbstractString)
	f = open(filename, "w")
	print(f, "Min: ")
	JSON.print(f, minimum(chain.value,2)[:])
	println(f, "")
	print(f, "Max: ")
	JSON.print(f, maximum(chain.value,2)[:])
	println(f, "")
	print(f, "Mean: ")
	JSON.print(f, mean(chain.value,2)[:])
	println(f, "")
	print(f, "Variance: ")
	JSON.print(f, var(chain.value,2)[:])
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

- `madsdata` : MADS problem dictionary
- `N` : number of samples (default = 100)

Returns:

- `outputdicts` : parameter dictionary containing the data arrays

Dumps:

- YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)
"""
function montecarlo(madsdata::Associative; N=100, filename="")
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
			if paramtypes[j] != Void
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
function paramarray2dict(madsdata::Associative, array)
	paramkeys = getoptparamkeys(madsdata)
	dict = OrderedDict()
	for i in 1:length(paramkeys)
		dict[paramkeys[i]] = array[:,i]
	end
	return dict
end