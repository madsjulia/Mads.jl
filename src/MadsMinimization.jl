"""
Minimize Julia function using a constrained Levenberg-Marquardt technique

`Mads.calibrate(madsdata; tolX=1e-3, tolG=1e-6, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)`

$(DocumentFunction.documentfunction(calibrate;
argtext=Dict("f"=>"Julia function",
			"x"=>"vector of function arguments containing initial guesses"),
keytext=Dict("lowerbounds"=>"vector of lower bounds of the function arguments",
			"upperbounds"=>"vector of upper bounds of the function arguments",
			"logtransformed"=>"boolean vector of the log-transformed function arguments",
			"tolX"=>"parameter space tolerance [default=`1e-4`]",
			"tolG"=>"parameter space update tolerance [default=`1e-6`]",
			"tolOF"=>"objective function tolerance [default=`1e-3`]",
			"maxEval"=>"maximum number of model evaluations [default=`1000`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`100.0`]",
			"lambda_mu"=>"lambda multiplication factor [default=`10.0`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"sindx"=>"sin-space parameter step applied to compute numerical derivatives [default=`0.1`]")))

Returns:

- vector with the optimal parameter values at the minimum
- optimization algorithm results (e.g. results.minimizer)
"""
function minimize(f::Function, x::Vector; lowerbounds::Array{Float64,1}=(ones(length(X)) * -1e+8), upperbounds::Array{Float64,1}=ones(length(X)) * 1e+8, logtransformed::Array{Bool,1}=collect(falses(length(X))), tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, sindx::Float64=0.1)
	f_lm, g_lm, o_lm = Mads.makelmfunctions(f)
	lb = copy(lowerbounds)
	ub = copy(upperbounds)
	indexlogtransformed = find(logtransformed)
	lb[indexlogtransformed] = log10.(lb[indexlogtransformed])
	ub[indexlogtransformed] = log10.(ub[indexlogtransformed])
	initparams = Mads.asinetransform(x, lb, ub, indexlogtransformed)
	f_lm_sin = Mads.sinetransformfunction(f_lm, lb, ub, indexlogtransformed)
	g_lm_sin = Mads.sinetransformgradient(g_lm, lb, ub, indexlogtransformed, sindx=sindx)
	results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, initparams, o_lm; tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace)
	minimizer = Mads.sinetransform(results.minimizer, lb, ub, indexlogtransformed)
	return minimizer, results
end