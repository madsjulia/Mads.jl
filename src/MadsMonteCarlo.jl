import OrderedCollections
import RobustPmap
import JSON
import AffineInvariantMCMC
import DocumentFunction
import BlackBoxOptim
import Random

function p10_p50_p90(x::AbstractMatrix{Number})
	xmean = Statistics.mean(x; dims=2)
	p10 = similar(xmean)
	p90 = similar(xmean)
	nt, ns = size(x)
	n10 = Int(floor(ns * 0.1))
	n90 = Int(ceil(ns * 0.9))
	for i = 1:nt
		is = sortperm(x[i,:])
		p10[i] = x[i,is][n10]
		p90[i] = x[i,is][n90]
	end
	return p10, xmean, p90
end

function loadecmeeresults(madsdata::AbstractDict, filename::AbstractString)
	if isfile(filename)
		@info("Load AffineInvariantMCMC results from $(filename) ...")
		chain, llhoods, observations, params, obs = JLD2.load(f_emcee_parameters_jld, "chain",  "llhoods", "observations", "params", "obs")
		@info("AffineInvariantMCMC results loaded: number of parameters = $(size(chain, 1)); number of realizations = $(size(chain, 2))")
		flag_bad_data = false
		if length(observations) != length(madsdata["Observations"])
			@warn("Different number of observations (Mads $(length(madsdata["Observations"])) vs Input $(size(observations, 1))!")
			flag_bad_data = true
		end
		if size(chain, 1) != length(madsdata["Parameters"])
			@warn("Different number of parameters (Mads $(length(madsdata["Parameters"])) vs Input $(size(chain, 1)))!")
			flag_bad_data = true
		end
		missing_observations = Vector{String}(undef, 0)
		missing_parameters = Vector{String}(undef, 0)
		if !flag_bad_data
			for o in keys(madsdata(["Observations"]))
				if !(o in obs)
					flag_bad_data = true
					push!(missing_observations, o)
				end
			end
			for p in keys(madsdata(["Parameters"]))
				if !(p in params)
					flag_bad_data = true
					push!(missing_parameters, p)
				end
			end
		end
		if flag_bad_data
			@warn("Loaded data is not compatible with the solved problem!")
			if length(missing_observations) > 0
				@info("Missing observations: $(missing_observations)")
			end
			if length(missing_parameters) > 0
				@info("Missing parameters: $(missing_parameters)")
			end
			return nothing, nothing, nothing
		else
			return chain, llhoods, observations
		end
	end
end

function emceesampling(madsdata::AbstractDict; filename::AbstractString, load::Bool=true, save::Bool=true, execute::Bool=true, numwalkers::Integer=10, sigma::Number=0.01, seed::Integer=-1, rng::Union{Nothing,Random.AbstractRNG}=nothing, kw...)
	if load
		chain, llhoods, observations = loadecmeeresults(madsdata, filename)
		if isnothing(chain)
			if execute
				@info("AffineInvariantMCMC will be executed!")
			else
				return nothing, nothing, nothing
			end
		else
			return chain, llhoods, observations
		end
	end
	if numwalkers <= 1
		numwalkers = 2
	end
	Mads.setseed(seed; rng=rng)
	optparamkeys = getoptparamkeys(madsdata)
	p0 = Array{Float64}(undef, length(optparamkeys), numwalkers)
	pinit = getparamsinit(madsdata, optparamkeys)
	pmin = getparamsmin(madsdata, optparamkeys)
	pmax = getparamsmax(madsdata, optparamkeys)
	for i = eachindex(optparamkeys)
		mu = (pinit[i] - pmin[i]) / (pmax[i] - pmin[i])
		mu = min(1 - 1e-3, max(mu, 1e-3))
		alpha = (1 - sigma ^ 2 - sigma ^ 2 * ((1 - mu) / mu) - mu) / (sigma ^ 2 + 2 * sigma ^ 2 * ((1 - mu) / mu) + sigma ^ 2 * ((1 - mu) / mu) ^ 2)
		beta = alpha * ((1 - mu) / mu)
		d = Distributions.Beta(alpha, beta)
		p0[i, 1] = pinit[i]
		for j = 2:numwalkers
			p0[i, j] = pmin[i] + rand(Mads.rng, d) * (pmax[i] - pmin[i])
		end
	end
	chain, llhoods, observations = emceesampling(madsdata, p0; numwalkers=numwalkers, seed=seed, rng=rng, save=false, kw...)
	if save && filename != ""
		JLD2.save(filename, "chain", chain, "llhoods", llhoods, "observations", observations)
	end
	return chain, llhoods, observations
end

function emceesampling(madsdata::AbstractDict, p0::AbstractMatrix; filename::AbstractString, load::Bool=true, save::Bool=true, execute::Bool=true, numwalkers::Integer=10, nsteps::Integer=100, burnin::Integer=10, thinning::Integer=1, seed::Integer=-1, weightfactor::Number=1.0, rng::Union{Nothing,Random.AbstractRNG}=nothing, distributed_function::Bool=false)
	if load
		chain, llhoods, observations = loadecmeeresults(madsdata, filename)
		if isnothing(chain)
			if execute
				@info("AffineInvariantMCMC will be executed!")
			else
				return nothing, nothing, nothing
			end
		else
			return chain, llhoods, observations
		end
	end
	Mads.setseed(seed; rng=rng)
	madsloglikelihood = makemadsloglikelihood(madsdata; weightfactor=weightfactor)
	arrayloglikelihood = Mads.makearrayloglikelihood(madsdata, madsloglikelihood)
	if distributed_function
		@Distributed.everywhere arrayloglikelihood_distributed = Mads.makearrayloglikelihood($madsdata, $madsloglikelihood)
		arrayloglikelihood = (x)->Core.eval(Main, :arrayloglikelihood_distributed)(x)
	end
	newnsteps = div(burnin, numwalkers)
	if newnsteps < 2
		newnsteps = 2
	end
	burninchain, _ = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, p0, newnsteps, 1; rng=Mads.rng, save=false)
	newnsteps = div(nsteps, numwalkers)
	if newnsteps < 2
		newnsteps = 2
	end
	chain, llhoods = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, burninchain[:, :, end], newnsteps, thinning; rng=Mads.rng, save=false)
	chain, llhoods =  AffineInvariantMCMC.flattenmcmcarray(chain, llhoods)
	observations = Mads.forward(madsdata, permutedims(chain))
	if save && filename != ""
		JLD2.save(filename, "chain", chain, "llhoods", llhoods, "observations", observations)
	end
	return chain, llhoods, observations
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
- log-likelihoods of the final samples in the chain

Examples:

```julia
Mads.emceesampling(madsdata; numwalkers=10, nsteps=100, burnin=100, thinning=1, seed=2016, sigma=0.01)
Mads.emceesampling(madsdata, p0; numwalkers=10, nsteps=100, burnin=10, thinning=1, seed=2016)
```
""" emceesampling

if isdefined(Mads, :Klara)
	# && isdefined(Klara, :BasicContMuvParameter)
	function bayessampling(madsdata::AbstractDict; nsteps::Integer=1000, burnin::Integer=100, thinning::Integer=1, seed::Integer=-1, rng::Union{Nothing,Random.AbstractRNG}=nothing)
		Mads.setseed(seed; rng=rng)
		madsloglikelihood = makemadsloglikelihood(madsdata)
		arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
		optparamkeys = getoptparamkeys(madsdata)
		initvals = Array{Float64}(undef, length(optparamkeys))
		for i = eachindex(optparamkeys)
			initvals[i] = madsdata["Parameters"][optparamkeys[i]]["init"]
		end
		# mcparams = Klara.BasicContMuvParameter(:p, logtarget=arrayloglikelihood)
		# model = Klara.likelihood_model(mcparams, false)
		# # sampler = Klara.MH(fill(1e-1, length(initvals)))
		# sampler = Klara.RAM(fill(1e-1, length(initvals)))
		# mcrange = Klara.BasicMCRange(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
		# mcparams0 = Dict(:p=>initvals)
		# outopts = Dict{Symbol, Any}(:monitor=>[:value, :logtarget, :loglikelihood], :diagnostics=>[:accept])
		# job = Klara.BasicMCJob(model, sampler, mcrange, mcparams0, outopts=outopts, tuner=Klara.VanillaMCTuner())
		# Klara.run(job)
		# chain = Klara.output(job)
		# return chain
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
function savemcmcresults(chain::AbstractArray, filename::AbstractString)
	f = open(filename, "w")
	print(f, "Min: ")
	JSON.print(f, minimum(chain, 1)[:])
	println(f, "")
	print(f, "Max: ")
	JSON.print(f, maximum(chain, 1)[:])
	println(f, "")
	print(f, "Mean: ")
	JSON.print(f, Statistics.mean(chain; dims=1)[:])
	println(f, "")
	print(f, "Variance: ")
	JSON.print(f, Statistics.var(chain; dims=1)[:])
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
function montecarlo(madsdata::AbstractDict; compute::Bool=true, N::Integer=100, filename::AbstractString="")
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
	logoptparams = renormalizematrix(logoptparams, logoptparamsmin, logoptparamsmax)
	nonlogoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(nonlogoptparamsmin, nonlogoptparamsmax, N)
	nonlogoptparams = renormalizematrix(nonlogoptparams, nonlogoptparamsmin, nonlogoptparamsmax)
	paramdicts = Array{OrderedCollections.OrderedDict}(undef, N)
	params = getparamsinit(madsdata)
	for i = 1:N
		klog = 1
		knonlog = 1
		for j = eachindex(params)
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
	if compute
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
	else
		return permutedims(hcat(collect.(values.(paramdicts))...))
	end
end

function renormalizematrix(m::Matrix{Float64}, bmin::Vector{Float64}, bmax::Vector{Float64})
	if sizeof(m) == 0
		return m
	end
	imin = minimum(m; dims=2)
	imax = maximum(m; dims=2)
	mn = (m .- imin) ./ (imax .- imin)
	return mn .* (bmax .- bmin) .+ bmin
end

"""
Convert a parameter array to a parameter dictionary of arrays

$(DocumentFunction.documentfunction(paramarray2dict;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "array"=>"parameter array")))

Returns:

- a parameter dictionary of arrays
"""
function paramarray2dict(madsdata::AbstractDict, array::AbstractArray)
	paramkeys = getoptparamkeys(madsdata)
	dict = OrderedCollections.OrderedDict()
	for i = eachindex(paramkeys)
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
