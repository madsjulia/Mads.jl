import DataStructures
import Optim

"""
Calibrate with random initial guesses

```
Mads.calibraterandom(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
Mads.calibraterandom(madsdata, numberofsamples; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
```

Arguments:

- `madsdata` : MADS problem dictionary
- `numberofsamples` : number of random initial samples
- `tolX` : parameter space tolerance
- `tolG` : parameter space update tolerance
- `maxEval` : maximum number of model evaluations
- `maxIter` : maximum number of optimization iterations
- `maxJacobians` : maximum number of Jacobian solves
- `lambda` : initial Levenberg-Marquardt lambda 
- `lambda_mu` : lambda multiplication factor [10]
- `np_lambda` : number of parallel lambda solves
- `show_trace` : shows solution trace [default=false]
- `save_results` : save intermediate results [default=true]
- `usenaive` : use naive Levenberg-Marquardt solver
- `seed` : initial random seed

Returns:

- `bestresult` : optimal results tuple: [1] model parameter dictionary with the optimal values at the minimum; [2] optimization algorithm results (e.g. bestresult[2].minimum)

"""
function calibraterandom(madsdata::Associative, numberofsamples=1; tolX=1e-4, tolG=1e-6, tolOF=1e-3, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false, seed=0, quiet=true, all=false, save_results=true)
	Mads.setseed(seed)
	paramkeys = Mads.getparamkeys(madsdata)
	paramdict = DataStructures.OrderedDict(zip(paramkeys, Mads.getparamsinit(madsdata)))
	paramsoptdict = paramdict
	paramoptvalues = Mads.parametersample(madsdata, numberofsamples; init_dist=Mads.haskeyword(madsdata, "init_dist"))
	if all
		allresults = Any[]
	end
	bestparameters = Any[]
	bestresult = Array(Any,2)
	bestphi = Inf
	for i in 1:numberofsamples
		for paramkey in keys(paramoptvalues)
			paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
		end
		Mads.setparamsinit!(madsdata, paramsoptdict)
		parameters, results = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, maxJacobians=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive, save_results=save_results)
		phi = results.f_minimum
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
Calibrate

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

Arguments:

- `madsdata` : MADS problem dictionary
- `tolX` : parameter space tolerance
- `tolG` : parameter space update tolerance
- `maxEval` : maximum number of model evaluations
- `maxIter` : maximum number of optimization iterations
- `maxJacobians` : maximum number of Jacobian solves
- `lambda` : initial Levenberg-Marquardt lambda 
- `lambda_mu` : lambda multiplication factor [10]
- `np_lambda` : number of parallel lambda solves
- `show_trace` : shows solution trace [default=false]
- `save_results` : save intermediate results [default=true]
- `usenaive` : use naive Levenberg-Marquardt solver

Returns:

- `minimumdict` : model parameter dictionary with the optimal values at the minimum
- `results` : optimization algorithm results (e.g. results.minimum)

"""
function calibrate(madsdata::Associative; tolX=1e-4, tolG=1e-6, tolOF=1e-3, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false, save_results=true)
	rootname = Mads.getmadsrootname(madsdata)
	f_lm, g_lm, o_lm = Mads.makelmfunctions(madsdata)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	initparams = Mads.getparamsinit(madsdata, optparamkeys)
	lowerbounds = Mads.getparamsmin(madsdata, optparamkeys)
	upperbounds = Mads.getparamsmax(madsdata, optparamkeys)
	logtransformed = Mads.getparamslog(madsdata, optparamkeys)
	indexlogtransformed = find(logtransformed)
	lowerbounds[indexlogtransformed] = log10(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10(upperbounds[indexlogtransformed])
	sindx = 0.1
	if Mads.haskeyword(madsdata, "sindx")
		sindx = madsdata["Problem"]["sindx"]
		if typeof(sindx) == ASCIIString
			sindx = float(sindx)
		end
	end
	f_lm_sin = Mads.sinetransformfunction(f_lm, lowerbounds, upperbounds, indexlogtransformed)
	g_lm_sin = Mads.sinetransformgradient(g_lm, lowerbounds, upperbounds, indexlogtransformed, sindx=sindx)
	if save_results
		function calibratecallback(x_best, of, lambda)
			outfile = open("$rootname.iterationresults", "a+")
			write(outfile, string("OF: ", of, "\n"))
			write(outfile, string("lambda: ", lambda, "\n"))
			write(outfile, string(Dict(zip(optparamkeys, Mads.sinetransform(x_best, lowerbounds, upperbounds, indexlogtransformed))), "\n"))
			close(outfile)
		end
	else
		calibratecallback(x_best, of, lambda) = nothing
	end
	if usenaive == true
		results = Mads.naive_levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda)
	elseif usenaive == :lmlin
		results = LMLin.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed); tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, maxJacobians=maxJacobians, show_trace=show_trace, callback=(best_x, x, of, lambda)->calibratecallback(best_x, of, lambda))
	else
		results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed), o_lm; root=rootname, tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, callback=calibratecallback)
	end
	minimum = Mads.sinetransform(results.minimum, lowerbounds, upperbounds, indexlogtransformed)
	nonoptparamkeys = Mads.getnonoptparamkeys(madsdata)
	minimumdict = DataStructures.OrderedDict(zip(getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	for i = 1:length(optparamkeys)
		minimumdict[optparamkeys[i]] = minimum[i]
	end
	return minimumdict, results
end

# NLopt is too much of a pain to install at this point
"Do a calibration using NLopt "
function calibratenlopt(madsdata::Associative; algorithm=:LD_LBFGS) # TODO switch to a mathprogbase approach
	const paramkeys = getparamkeys(madsdata)
	const obskeys = getobskeys(madsdata)
	parammins = Array(Float64, length(paramkeys))
	parammaxs = Array(Float64, length(paramkeys))
	paraminits = Array(Float64, length(paramkeys))
	for i = 1:length(paramkeys)
		parammins[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		parammaxs[i] = madsdata["Parameters"][paramkeys[i]]["max"]
		paraminits[i] = madsdata["Parameters"][paramkeys[i]]["init"]
	end
	obs = Array(Float64, length(obskeys))
	weights = ones(Float64, length(obskeys))
	for i = 1:length(obskeys)
		obs[i] = madsdata["Observations"][obskeys[i]]["target"]
		if haskey(madsdata["Observations"][obskeys[i]], "weight")
			weights[i] = madsdata["Observations"][obskeys[i]]["weight"]
		end
	end
	fg = makemadscommandfunctionandgradient(madsdata)
	function fg_nlopt(arrayparameters::Vector, grad::Vector)
		parameters = Dict(zip(paramkeys, arrayparameters))
		resultdict, gradientdict = fg(parameters)
		residuals = Array(Float64, length(madsdata["Observations"]))
		ssr = 0
		i = 1
		for obskey in obskeys
			residuals[i] = resultdict[obskey] - obs[i]
			ssr += residuals[i] * residuals[i] * weights[i] * weights[i]
			i += 1
		end
		if length(grad) > 0
			i = 1
			for paramkey in paramkeys
				grad[i] = 0.
				j = 1
				for obskey in obskeys
					grad[i] += 2 * residuals[j] * gradientdict[obskey][paramkey]
					j += 1
				end
				i += 1
			end
		end
		return ssr
	end
	opt = NLopt.Opt(algorithm, length(paramkeys))
	NLopt.lower_bounds!(opt, parammins)
	NLopt.upper_bounds!(opt, parammaxs)
	NLopt.min_objective!(opt, fg_nlopt)
	NLopt.maxeval!(opt, round(Int, 1e3))
	minf, minx, ret = NLopt.optimize(opt, paraminits)
	return minf, minx, ret
end
