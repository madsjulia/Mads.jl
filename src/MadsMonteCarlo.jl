import OrderedCollections
import RobustPmap
import JSON
import AffineInvariantMCMC
import DocumentFunction
import BlackBoxOptim
import Random

function p10_p50_p90(x::AbstractMatrix)
	# xmean = Statistics.mean(x; dims=2)
	p10 = similar(x[:, 1])
	p50 = similar(p10)
	p90 = similar(p10)
	nt, ns = size(x)
	n10 = Int(ceil(1 + ns * 0.1))
	n50 = Int(round(1 + ns * 0.5))
	n90 = Int(floor(1 + ns * 0.9))
	if n90 > ns
		n90 = ns
	end
	for i = 1:nt
		is = sortperm(x[i, :])
		p10[i] = x[i, is][n10]
		p50[i] = x[i, is][n50]
		p90[i] = x[i, is][n90]
	end
	return p10, p50, p90
end

function loadecmeeresults(madsdata::AbstractDict, filename::AbstractString)
	if isfile(filename)
		@info("Load AffineInvariantMCMC results from $(filename) ...")
		if !Mads.jld2haskey(filename, "chain", "llhoods"; quiet=false)
			@warn("$(filename) does not contain AffineInvariantMCMC results!")
			return nothing, nothing, nothing
		end
		chain, llhoods, params, obs = JLD2.load(filename, "chain", "llhoods", "params", "obs")
		@info("AffineInvariantMCMC results loaded: number of parameters = $(size(chain, 1)); number of observation = $(size(obs, 1)); number of realizations = $(size(chain, 2))")
		if !Mads.jld2haskey(filename, "observations", "params", "obs"; quiet=false)
			@warn("$(filename) does not contain AffineInvariantMCMC observation results!")
			return chain, llhoods, nothing
		end
		observations, params, obs = JLD2.load(filename, "observations", "params", "obs")
		flag_bad_data = false
		if size(observations, 1) != length(Mads.getobskeys(madsdata))
			@warn("Different number of observations (Mads $(length(Mads.getobskeys(madsdata))) vs Input $(size(observations, 1)))!")
			flag_bad_data = true
		end
		if size(chain, 1) != length(Mads.getoptparamkeys(madsdata))
			@warn("Different number of parameters (Mads $(length(Mads.getoptparamkeys(madsdata))) vs Input $(size(chain, 1)))!")
			flag_bad_data = true
		end
		missing_observations = Vector{String}(undef, 0)
		missing_parameters = Vector{String}(undef, 0)
		if !flag_bad_data
			for o in Mads.getobskeys(madsdata)
				if !(o in obs)
					flag_bad_data = true
					push!(missing_observations, o)
				end
			end
			for p in Mads.getoptparamkeys(madsdata)
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
	else
		@warn("AffineInvariantMCMC results file $(filename) is missing!")
		return nothing, nothing, nothing
	end
end

function emceesampling(madsdata::AbstractDict; filename::AbstractString="", load::Bool=false, save::Bool=false, execute::Bool=true, numwalkers::Integer=10, nexecutions::Integer=100, burnin::Integer=numwalkers, thinning::Integer=10, sigma::Number=0.01, seed::Integer=-1, rng::Union{Nothing, Random.AbstractRNG, DataType}=nothing, kw...)
	if filename != ""
		save = true
	end
	if (load || save) && filename == ""
		np = length(Mads.getoptparams(madsdata))
		no = length(Mads.getobskeys(madsdata))
		filename = joinpath(Mads.getmadsproblemdir(madsdata), Mads.getmadsrootname(madsdata) * "_emcee_results_$(np)_$(no)_$(numwalkers)_$(nexecutions)_$(burnin)_$(thinning).jld2")
		madsinfo("Filename not provided! AffineInvariantMCMC results will be saved in $(filename) ...")
	end
	if load && filename != ""
		chain, llhoods, observations = loadecmeeresults(madsdata, filename)
		if isnothing(chain)
			if execute
				@info("AffineInvariantMCMC will be executed! No preexisting data to load ...")
			else
				@warn("No preexisting data to load! AffineInvariantMCMC will be not executed!")
				return nothing, nothing, nothing
			end
		elseif isnothing(observations)
			@info("AffineInvariantMCMC preexisting data loaded!")
			return chain, llhoods, observations
		end
	end
	Mads.setseed(seed; rng=rng)
	optparamkeys = getoptparamkeys(madsdata)
	p0 = Array{Float64}(undef, length(optparamkeys), numwalkers)
	pinit = getparamsinit(madsdata, optparamkeys)
	pmin = getparamsmin(madsdata, optparamkeys)
	pmax = getparamsmax(madsdata, optparamkeys)
	for i in eachindex(optparamkeys)
		mu = (pinit[i] - pmin[i]) / (pmax[i] - pmin[i])
		mu = min(1 - 1e-3, max(mu, 1e-3))
		alpha = (1 - sigma^2 - sigma^2 * ((1 - mu) / mu) - mu) / (sigma^2 + 2 * sigma^2 * ((1 - mu) / mu) + sigma^2 * ((1 - mu) / mu)^2)
		beta = alpha * ((1 - mu) / mu)
		d = Distributions.Beta(alpha, beta)
		p0[i, 1] = pinit[i]
		for j = 2:numwalkers
			p0[i, j] = pmin[i] + rand(Mads.rng, d) * (pmax[i] - pmin[i])
		end
	end
	chain, llhoods, observations = emceesampling(madsdata, p0; filename=filename, load=load, save=save, execute=execute, numwalkers=numwalkers, nexecutions=nexecutions, burnin=burnin, thinning=thinning, seed=seed, rng=rng, kw...)
	return chain, llhoods, observations
end
function emceesampling(madsdata::AbstractDict, p0::AbstractMatrix; filename::AbstractString="", load::Bool=false, save::Bool=false, execute::Bool=true, numwalkers::Integer=10, nexecutions::Integer=100, burnin::Integer=numwalkers, thinning::Integer=10, seed::Integer=-1, weightfactor::Number=1.0, rng::Union{Nothing, Random.AbstractRNG, DataType}=nothing, distributed_function::Bool=false, type::DataType=Float64, checkoutputs::Bool=true)
	if filename != ""
		save = true
	end
	np = length(Mads.getoptparams(madsdata))
	no = length(Mads.getobskeys(madsdata))
	if (load || save) && filename == ""
		filename = joinpath(Mads.getmadsproblemdir(madsdata), Mads.getmadsrootname(madsdata) * "_emcee_results_$(np)_$(no)_$(numwalkers)_$(nexecutions)_$(burnin)_$(thinning).jld2")
		madsinfo("Filename not provided! AffineInvariantMCMC results will be saved in $(filename) ...")
	end
	numsamples_perwalker = div(nexecutions, numwalkers)
	if numsamples_perwalker == 0
		numsamples_perwalker = 10
		nexecutions = numsamples_perwalker * numwalkers
	end
	if load && filename != ""
		bad_data = false
		@info("AffineInvariantMCMC preexisting data loading $(filename) ...")
		chain, llhoods, observations = loadecmeeresults(madsdata, filename)
		if isnothing(chain)
			@warn("Empty!")
			bad_data = true
		else
			if size(chain, 2) != div(nexecutions, thinning)
				@warn("Preexisting data does not match the number of walkers and steps!")
				bad_data = true
			elseif size(chain, 1) != np
				@warn("Preexisting data does not match the number of parameters!")
				bad_data = true
			elseif size(observations, 1) != no
				@warn("Preexisting data does not match the number of observations!")
				bad_data = true
			elseif size(observations, 2) != size(chain, 2) != length(llhoods)
				@warn("Preexisting data dimension do not match!")
				bad_data = true
			end
		end
		if bad_data
			if execute
				@info("AffineInvariantMCMC will be executed! No preexisting data to load ...")
			else
				@warn("No preexisting data to load! AffineInvariantMCMC will be not executed!")
				return nothing, nothing, nothing
			end
		else
			@info("AffineInvariantMCMC preexisting data loaded!")
			return chain, llhoods, observations
		end
	end
	Mads.setseed(seed; rng=rng)
	madsloglikelihood = makemadsloglikelihood(madsdata; weightfactor=weightfactor)
	arrayloglikelihood = Mads.makearrayloglikelihood(madsdata, madsloglikelihood)
	if distributed_function
		Distributed.@everywhere arrayloglikelihood_distributed = Mads.makearrayloglikelihood($madsdata, $madsloglikelihood)
		arrayloglikelihood = (x) -> Core.eval(Main, :arrayloglikelihood_distributed)(x)
	end
	numsamples_perwalker_burnin = div(burnin, numwalkers)
	if numsamples_perwalker_burnin == 0
		numsamples_perwalker_burnin = 10
	end
	numsamples = numsamples_perwalker_burnin * numwalkers
	@info("AffineInvariantMCMC burning stage (total number of executions $(numsamples), final burning chain size $(numsamples_perwalker_burnin * numwalkers))...")
	burninchain, _ = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, p0, numsamples_perwalker_burnin, 1; filename="", load=false, save=false, rng=Mads.rng, type=type, checkoutputs=checkoutputs)
	numsamples = numsamples_perwalker * numwalkers
	@info("AffineInvariantMCMC exploration stage (total number of executions $(numsamples), final chain size $(div(numsamples_perwalker, thinning) * numwalkers))...")
	chain, llhoods = AffineInvariantMCMC.sample(arrayloglikelihood, numwalkers, burninchain[:, :, end], numsamples_perwalker, thinning; filename="", load=false, save=false, rng=Mads.rng, type=type, checkoutputs=checkoutputs)
	chain, llhoods = AffineInvariantMCMC.flattenmcmcarray(chain, llhoods)
	if save
		madsinfo("Saving AffineInvariantMCMC results in $(filename) ...")
		JLD2.save(filename, "chain", chain, "llhoods", llhoods, "params", Mads.getoptparamkeys(madsdata), "obs", Mads.getobskeys(madsdata))
	end
	observations = Mads.forward(madsdata, permutedims(chain))
	if save
		madsinfo("Saving AffineInvariantMCMC forward runs in $(filename) ...")
		Mads.jld2append(filename, "observations", observations)
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
		for j in eachindex(params)
			if paramtypes[j] == "opt"
				if paramlogs[j] == true || paramlogs[j] == "yes"
					params[j] = 10^logoptparams[klog, i]
					klog += 1
				else
					params[j] = nonlogoptparams[knonlog, i]
					knonlog += 1
				end
			end
		end
		paramdicts[i] = OrderedCollections.OrderedDict{Union{String, Symbol}, Float64}(zip(paramkeys, params))
	end
	if compute
		f = makemadscommandfunction(madsdata)
		results = RobustPmap.rpmap(f, paramdicts)
		outputdicts = Array{OrderedCollections.OrderedDict}(undef, N)
		for i = 1:N
			outputdicts[i] = OrderedCollections.OrderedDict{String, OrderedCollections.OrderedDict}()
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
	for i in eachindex(paramkeys)
		dict[paramkeys[i]] = array[:, i]
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
	return permutedims(hcat(collect(values(dict))...))
end