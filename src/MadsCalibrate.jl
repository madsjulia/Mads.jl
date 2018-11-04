import OrderedCollections
import DocumentFunction
using SharedArrays
using Statistics

"""
Calibrate with random initial guesses

$(DocumentFunction.documentfunction(calibraterandom;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"numberofsamples"=>"number of random initial samples [default=`1`]"),
keytext=Dict("tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function tolerance [default=`1e-3`]",
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
			"all"=>"all model results are returned [default=`false`]",
			"save_results"=>"save intermediate results [default=`true`]")))

Returns:

- model parameter dictionary with the optimal values at the minimum
- optimization algorithm results (e.g. bestresult[2].minimizer)

Example:

```julia
Mads.calibraterandom(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
```
"""
function calibraterandom(madsdata::AbstractDict, numberofsamples::Integer=1; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, usenaive::Bool=false, seed::Integer=-1, quiet::Bool=true, all::Bool=false, save_results::Bool=true)
	Mads.setseed(seed)
	paramdict = Mads.getparamdict(madsdata)
	paramsoptdict = copy(paramdict)
	paramoptvalues = Mads.getparamrandom(madsdata, numberofsamples; init_dist=Mads.haskeyword(madsdata, "init_dist"))
	allresults = Array{Float64}(undef, 0)
	local bestparameters
	local bestresult
	bestphi = Inf
	for i in 1:numberofsamples
		for paramkey in keys(paramoptvalues)
			paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
		end
		Mads.setparamsinit!(madsdata, paramsoptdict)
		parameters, results = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive, save_results=save_results)
		phi = results.minimum
		converged = results.x_converged | results.g_converged | results.f_converged # f_converged => of_conferged
		!quiet && info("Random initial guess #$i: OF = $phi (converged=$converged)")
		if phi < bestphi
			bestparameters = parameters
			bestresult = results
			bestphi = phi
		end
		if all
			if sizeof(allresults) == 0
				allresults = [phi converged parameters]
			else
				allresults = [allresults; phi converged parameters]
			end
		end
	end
	Mads.setparamsinit!(madsdata, paramdict) # restore the original initial values
	if all
		return allresults
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
			"tolOF"=>"objective function tolerance [default=`1e-3`]",
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
			"save_results"=>"save intermediate results [default=`true`]",
			"localsa"=>"perform local sensitivity analysis [default=`false`]")))

Returns:

- vector with all objective function values
- boolean vector (converged/not converged)
- array with estimate model parameters
"""
function calibraterandom_parallel(madsdata::AbstractDict, numberofsamples::Integer=1; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, usenaive::Bool=false, seed::Integer=-1, quiet::Bool=true, save_results::Bool=true, localsa::Bool=false)
	Mads.setseed(seed)
	paramdict = Mads.getparamdict(madsdata)
	paramsoptdict = copy(paramdict)
	paramoptvalues = Mads.getparamrandom(madsdata, numberofsamples; init_dist=Mads.haskeyword(madsdata, "init_dist"))
	allphi = SharedArray{Float64}(numberofsamples)
	allconverged = SharedArray{Bool}(numberofsamples)
	allparameters = SharedArray{Float64}(numberofsamples, length(keys(paramoptvalues)))
	@sync @distributed for i in 1:numberofsamples
		for paramkey in keys(paramoptvalues)
			paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
		end
		Mads.setparamsinit!(madsdata, paramsoptdict)
		parameters, results = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive, save_results=save_results, localsa=localsa)
		phi = results.minimum
		converged = results.x_converged | results.g_converged | results.f_converged # f_converged => of_conferged
		!quiet && info("Random initial guess #$i: OF = $phi (converged=$converged)")
		allphi[i] = phi
		allconverged[i] = converged
		j = 1
		for paramkey in keys(paramoptvalues)
			allparameters[i,j] = parameters[paramkey]
			j += 1
		end
	end
	Mads.setparamsinit!(madsdata, paramdict) # restore the original initial values
	return allphi, allconverged, allparameters
end


"""
Calibrate Mads model using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

$(DocumentFunction.documentfunction(calibrate;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function tolerance [default=`1e-3`]",
			"maxEval"=>"maximum number of model evaluations [default=`1000`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`100.0`]",
			"lambda_mu"=>"lambda multiplication factor [default=`10.0`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"usenaive"=>"use naive Levenberg-Marquardt solver [default=`false`]",
			"save_results"=>"save intermediate results [default=`true`]",
			"localsa"=>"perform local sensitivity analysis [default=`false`]")))

Returns:

- model parameter dictionary with the optimal values at the minimum
- optimization algorithm results (e.g. results.minimizer)
"""
function calibrate(madsdata::AbstractDict; tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, usenaive::Bool=false, save_results::Bool=true, localsa::Bool=false)
	rootname = Mads.getmadsrootname(madsdata)
	f_lm, g_lm, o_lm = Mads.makelmfunctions(madsdata)
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
	g_lm_sin = Mads.sinetransformgradient(g_lm, lowerbounds, upperbounds, indexlogtransformed, sindx=sindx)
	restart_flag = Mads.getrestart(madsdata)
	if save_results
		function interationcallback(x_best::Vector, of::Number, lambda::Number)
			x_best_real = sinetransform(x_best, lowerbounds, upperbounds, indexlogtransformed)
			if localsa || restart_flag
				Mads.localsa(madsdata; par=x_best_real, keyword="best")
			end
			outfile = open("$rootname.iterationresults", "a+")
			write(outfile, string("OF: ", of, "\n"))
			write(outfile, string("lambda: ", lambda, "\n"))
			write(outfile, string(OrderedCollections.OrderedDict{String,Float64}(zip(optparamkeys, x_best_real)), "\n"))
			close(outfile)
		end
		function jacobiancallback(x::Vector, J::Matrix)
			if localsa || restart_flag
				x_real = sinetransform(x, lowerbounds, upperbounds, indexlogtransformed)
				Mads.localsa(madsdata; par=x_real, J=J, keyword="current")
			end
		end
	else
		interationcallback = (x_best::Vector, of::Number, lambda::Number)->nothing
		jacobiancallback = (x::Vector, J::Matrix)->nothing
	end
	if usenaive == true
		results = Mads.naive_levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda)
	elseif usenaive == :lmlin
		results = LMLin.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed); tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, maxJacobians=maxJacobians, show_trace=show_trace, callback=(best_x, x, of, lambda)->interationcallback(best_x, of, lambda))
	else
		results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; root=rootname, tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, callbackiteration=interationcallback, callbackjacobian=jacobiancallback)
	end
	global modelruns += results.f_calls
	minimizer = Mads.sinetransform(results.minimizer, lowerbounds, upperbounds, indexlogtransformed)
	minimumdict = OrderedCollections.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	for i = 1:length(optparamkeys)
		minimumdict[optparamkeys[i]] = minimizer[i]
	end
	return minimumdict, results
end