import OrderedCollections
import Distributed
import SharedArrays
import Statistics
import ProgressMeter
import JLD2

"""
Calibrate with random initial guesses

$(DocumentFunction.documentfunction(calibraterandom;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"numberofsamples"=>"number of random initial samples [default=`1`]"),
keytext=Dict("tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function update tolerance [default=`1e-3`]",
			"tolOFcount"=>"number of Jacobian runs with small objective function change [default=`5`]",
			"maxEval"=>"maximum number of model evaluations [default=`1000`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`100.0`]",
			"lambda_mu"=>"lambda multiplication factor [default=`10.0`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"usenaive"=>"use naive Levenberg-Marquardt solver [default=`false`]",
			"seed"=>"random seed [default=`0`]",
			"quiet"=>"[default=`true`]",
			"all_results"=>"all model results are returned [default=`false`]",
			"store_optimization_progress"=>"save intermediate results [default=`true`]")))

Returns:

- model parameter dictionary with the optimal values at the minimum
- optimization algorithm results (e.g. bestresult[2].minimizer)

Example:

```julia
Mads.calibraterandom(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
```
"""
function calibraterandom(madsdata::AbstractDict, numberofsamples::Integer=1; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, tolOFcount::Integer=5, minOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, usenaive::Bool=false, seed::Integer=-1, rng::Union{Nothing,Random.AbstractRNG,DataType}=nothing, quiet::Bool=true, all_results::Bool=false, store_optimization_progress::Bool=true, save_results::Bool=false, first_init::Bool=true)
	if numberofsamples < 1
		numberofsamples = 1
	end
	Mads.setseed(seed; rng=rng)
	paramdict = Mads.getparamdict(madsdata)
	paramsoptdict = copy(paramdict)
	paramoptvalues = Mads.getparamrandom(madsdata, numberofsamples; init_dist=Mads.haskeyword(madsdata, "init_dist"))
	nparam = length(Mads.getparamsinit(madsdata))
	nobs = sum(Mads.getobsweight(madsdata) .> 0)
	allphi = Vector{Float64}(undef, numberofsamples)
	allconverged = Vector{Bool}(undef, numberofsamples)
	allparameters = Matrix{Float64}(undef, numberofsamples, length(keys(paramoptvalues)))
	local bestparameters
	bestphi = Inf
	@ProgressMeter.showprogress 5 "Calibrating ..." for i in 1:numberofsamples
		if i == 1 && first_init
			!quiet && @info("Using initial values for the first run!")
		else
			for paramkey in keys(paramoptvalues)
				paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
			end
			Mads.setparamsinit!(madsdata, paramsoptdict)
		end
		parameters, results = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, tolOF=tolOF, tolOFcount=tolOFcount, minOF=minOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive, store_optimization_progress=store_optimization_progress)
		allphi[i] = results.minimum
		allconverged[i] = results.x_converged | results.g_converged # f_converged => of_conferged
		!quiet && @info("Random initial guess #$(i): OF = $(allphi[i]) (converged=$(allconverged[i]))")
		if allphi[i] < bestphi || i == 1
			bestparameters = parameters
			bestphi = allphi[i]
		end
		if all_results
			allparameters[i,:] = [parameters[paramkey] for paramkey in keys(paramoptvalues)]
		end
	end
	if save_results
		@info("Saving results to $(joinpath(Mads.getmadsproblemdir(madsdata), "calibrate_random_results_$(nparam)_$(nobs)_$(numberofsamples).jld2")) ...")
		JLD2.save(joinpath(Mads.getmadsproblemdir(madsdata), "calibrate_random_results_$(nparam)_$(nobs)_$(numberofsamples).jld2"), "phi", allphi, "converged", allconverged, "parameters", allparameters)
	end
	Mads.setparamsinit!(madsdata, paramdict) # restore the original initial values
	bestresult = Mads.forward(madsdata, bestparameters)
	if all_results
		return bestparameters, bestresult, allphi, allparameters
	else
		return bestparameters, bestresult
	end
end

"""
Calibrate with random initial guesses in parallel

$(DocumentFunction.documentfunction(calibraterandom_parallel;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"numberofsamples"=>"number of random initial samples [default=`1`]"),
keytext=Dict("tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function update tolerance [default=`1e-3`]",
			"tolOFcount"=>"number of Jacobian runs with small objective function change [default=`5`]",
			"maxEval"=>"maximum number of model evaluations [default=`1000`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`100.0`]",
			"lambda_mu"=>"lambda multiplication factor [default=`10.0`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"usenaive"=>"use naive Levenberg-Marquardt solver [default=`false`]",
			"seed"=>"random seed [default=`0`]",
			"quiet"=>"suppress output [default=`true`]",
			"store_optimization_progress"=>"save intermediate results [default=`true`]",
			"localsa"=>"perform local sensitivity analysis [default=`false`]")))

Returns:

- vector with all objective function values
- boolean vector (converged/not converged)
- array with estimate model parameters
"""
function calibraterandom_parallel(madsdata::AbstractDict, numberofsamples::Integer=1; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, tolOFcount::Integer=5, minOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, usenaive::Bool=false, seed::Integer=-1, rng::Union{Nothing,Random.AbstractRNG,DataType}=nothing, quiet::Bool=true, store_optimization_progress::Bool=true, save_results::Bool=false, first_init::Bool=true, localsa::Bool=false, all_results::Bool=true)
	Mads.setseed(seed; rng=rng)
	paramdict = Mads.getparamdict(madsdata)
	paramsoptdict = copy(paramdict)
	paramoptvalues = Mads.getparamrandom(madsdata, numberofsamples; init_dist=Mads.haskeyword(madsdata, "init_dist"))
	nparam = length(Mads.getparamsinit(madsdata))
	nobs = sum(Mads.getobsweight(madsdata) .> 0)
	allphi = SharedArrays.SharedArray{Float64}(numberofsamples)
	allconverged = SharedArrays.SharedArray{Bool}(numberofsamples)
	allparameters = SharedArrays.SharedArray{Float64}(numberofsamples, length(keys(paramoptvalues)))
	@sync @Distributed.distributed for i in 1:numberofsamples
		if i == 1 && first_init
			!quiet && @info("Using initial values for the first run!")
		else
			for paramkey in keys(paramoptvalues)
				paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
			end
			Mads.setparamsinit!(madsdata, paramsoptdict)
		end
		parameters, results = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, tolOF=tolOF, tolOFcount=tolOFcount, minOF=minOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive, store_optimization_progress=store_optimization_progress, localsa=localsa, parallel_optimization=false)
		phi = results.minimum
		converged = results.x_converged | results.g_converged # f_converged => of_conferged
		if !quiet
			if i == 1 && first_init
				@info("First run using initial values #$(i): OF = $(phi) (converged=$(converged))")
			else
				@info("Random initial guess #$(i): OF = $(phi) (converged=$(converged))")
			end
		end
		allphi[i] = phi
		allconverged[i] = converged
		for (j, paramkey) in enumerate(keys(paramoptvalues))
			allparameters[i,j] = parameters[paramkey]
		end
	end
	Mads.setparamsinit!(madsdata, paramdict) # restore the original initial values
	if all(isnan.(allphi))
		@warn("Something is very wrong! All the objective function estimates are NaN!")
	end
	if save_results
		@info("Saving results to $(joinpath(Mads.getmadsproblemdir(madsdata), "calibrate_random_results_$(nparam)_$(nobs)_$(numberofsamples).jld2")) ...")
		JLD2.save(joinpath(Mads.getmadsproblemdir(madsdata), "calibrate_random_results_$(nparam)_$(nobs)_$(numberofsamples).jld2"), "phi", allphi, "converged", allconverged, "parameters", allparameters)
	end
	ibest = first(sortperm(allphi))
	for (j, paramkey) in enumerate(keys(paramoptvalues))
		paramdict[paramkey] = allparameters[ibest, j]
	end
	bestresult = Mads.forward(madsdata, paramdict)
	if all_results
		return paramdict, bestresult, collect(allphi), collect(allparameters)
	else
		return paramdict, bestresult
	end
end

"""
Calibrate Mads model using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

$(DocumentFunction.documentfunction(calibrate;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function update tolerance [default=`1e-3`]",
			"tolOFcount"=>"number of Jacobian runs with small objective function change [default=`5`]",
			"minOF"=>"objective function update tolerance [default=`1e-3`]",
			"maxEval"=>"maximum number of model evaluations [default=`1000`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`100.0`]",
			"lambda_mu"=>"lambda multiplication factor [default=`10.0`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"usenaive"=>"use naive Levenberg-Marquardt solver [default=`false`]",
			"store_optimization_progress"=>"save intermediate results [default=`true`]",
			"localsa"=>"perform local sensitivity analysis [default=`false`]")))

Returns:

- model parameter dictionary with the optimal values at the minimum
- optimization algorithm results (e.g. results.minimizer)
"""
function calibrate(madsdata::AbstractDict; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, tolOFcount::Integer=5, minOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, quiet::Bool=Mads.quiet, usenaive::Bool=false, store_optimization_progress::Bool=true, localsa::Bool=false, parallel_optimization::Bool=parallel_optimization)
	rootname = Mads.getmadsrootname(madsdata)
	madsdir = Mads.getmadsproblemdir(madsdata)
	if !isdir(madsdir)
		Mads.recursivemkdir(madsdir)
	end
	f_lm, g_lm, o_lm = Mads.makelmfunctions(madsdata; parallel_gradients=parallel_optimization)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	initparams = Mads.getparamsinit(madsdata, optparamkeys)
	lowerbounds = Mads.getparamsmin(madsdata, optparamkeys)
	upperbounds = Mads.getparamsmax(madsdata, optparamkeys)
	logtransformed = Mads.getparamslog(madsdata, optparamkeys)
	indexlogtransformed = findall(logtransformed)
	lowerbounds[indexlogtransformed] = log10.(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10.(upperbounds[indexlogtransformed])
	sindx = Mads.getsindx(madsdata)
	f_lm_sin = Mads.sinetransformfunction(f_lm, lowerbounds, upperbounds, indexlogtransformed)
	g_lm_sin = Mads.sinetransformgradient(g_lm, lowerbounds, upperbounds, indexlogtransformed; sindx=sindx)
	restart_flag = Mads.getrestart(madsdata)
	if store_optimization_progress && rootname != ""
		Mads.recursivemkdir(rootname)
		if isfile("$(rootname).initialresults")
			rmfile("$(rootname).initialresults")
		end
		if isfile("$(rootname).iterationresults")
			rmfile("$(rootname).iterationresults")
		end
		if isfile("$(rootname).finalresults")
			rmfile("$(rootname).finalresults")
		end
		function initialcallback(x_init::AbstractVector, of::Number, lambda::Number)
			x_init_real = sinetransform(x_init, lowerbounds, upperbounds, indexlogtransformed)
			outfile = open("$(rootname).initialresults", "a+")
			write(outfile, string("OF: ", of, "\n"))
			write(outfile, string("lambda: ", lambda, "\n"))
			write(outfile, string(OrderedCollections.OrderedDict{Union{String,Symbol},Float64}(zip(optparamkeys, x_init_real)), "\n"))
			close(outfile)
		end
		function interationcallback(x_best::AbstractVector, of::Number, lambda::Number)
			x_best_real = sinetransform(x_best, lowerbounds, upperbounds, indexlogtransformed)
			outfile = open("$(rootname).iterationresults", "a+")
			write(outfile, string("OF: ", of, "\n"))
			write(outfile, string("lambda: ", lambda, "\n"))
			write(outfile, string(OrderedCollections.OrderedDict{Union{String,Symbol},Float64}(zip(optparamkeys, x_best_real)), "\n"))
			close(outfile)
		end
		function jacobiancallback(x::AbstractVector, J::AbstractMatrix)
			if localsa || restart_flag
				x_real = sinetransform(x, lowerbounds, upperbounds, indexlogtransformed)
				Mads.localsa(madsdata; par=x_real, J=J, keyword="current")
			end
		end
		function finalcallback(x_best::AbstractVector, of::Number, lambda::Number)
			x_best_real = sinetransform(x_best, lowerbounds, upperbounds, indexlogtransformed)
			if localsa || restart_flag
				Mads.localsa(madsdata; par=x_best_real, keyword="best")
			end
			outfile = open("$(rootname).finalresults", "a+")
			write(outfile, string("OF: ", of, "\n"))
			write(outfile, string("lambda: ", lambda, "\n"))
			write(outfile, string(OrderedCollections.OrderedDict{Union{String,Symbol},Float64}(zip(optparamkeys, x_best_real)), "\n"))
			close(outfile)
		end
	else
		initialcallback = (x_best::AbstractVector, of::Number, lambda::Number)->nothing
		interationcallback = (x_best::AbstractVector, of::Number, lambda::Number)->nothing
		jacobiancallback = (x::AbstractVector, J::AbstractMatrix)->nothing
		finalcallback = (x_best::AbstractVector, of::Number, lambda::Number)->nothing
	end
	if usenaive == true
		results = Mads.naive_levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda)
	elseif usenaive == :lmlin
		results = LMLin.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed); tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, maxJacobians=maxJacobians, show_trace=show_trace, callback=(best_x, x, of, lambda)->interationcallback(best_x, of, lambda))
	else
		results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; root=rootname, tolX=tolX, tolG=tolG, tolOF=tolOF, tolOFcount=tolOFcount, minOF=minOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, quiet=quiet, callbackinitial=initialcallback, callbackiteration=interationcallback, callbackjacobian=jacobiancallback, callbackfinal=finalcallback, parallel_execution=parallel_optimization)
	end
	global modelruns += results.f_calls
	minimizer = Mads.sinetransform(results.minimizer, lowerbounds, upperbounds, indexlogtransformed)
	minimumdict = OrderedCollections.OrderedDict{Union{String,Symbol},Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	for i = eachindex(optparamkeys)
		minimumdict[optparamkeys[i]] = minimizer[i]
	end
	return minimumdict, results
end