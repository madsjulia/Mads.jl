import RobustPmap
import LsqFit
import DocumentFunction
import LinearAlgebra

function residuals(madsdata::AbstractDict, resultvec::Vector)
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	obskeys = Mads.getobskeys(madsdata)
	weights = Mads.getobsweight(madsdata, obskeys)
	targets = Mads.getobstarget(madsdata, obskeys)
	isn = isnan.(targets)
	index = findall(isn)
	weights[index] .= 0
	targets[index] .= 0
	residuals = (resultvec .- targets) .* weights
	if ssdr
		mins = Mads.getobsmin(madsdata, obskeys)
		maxs = Mads.getobsmax(madsdata, obskeys)
		mins[index] .= -Inf
		maxs[index] .= Inf
		rmax = (resultvec .- maxs) .* weights
		rmin = (resultvec .- mins) .* weights
		rmax[rmax .< 0] .= 0
		rmin[rmin .> 0] .= 0
		residuals .+= (rmax .+ rmin)
	end
	return residuals[.!isn]
end
function residuals(madsdata::AbstractDict, resultdict::AbstractDict)
	residuals(madsdata, collect(values(resultdict)))
end
function residuals(madsdata::AbstractDict)
	resultdict = Mads.forward(madsdata)
	residuals(madsdata, collect(values(resultdict)))
end

@doc """
Compute residuals

$(DocumentFunction.documentfunction(residuals;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "resultvec"=>"result vector",
            "resultdict"=>"result dictionary")))

Returns:

-
""" residuals


function of(madsdata::AbstractDict, resultvec::Vector)
	r = residuals(madsdata, resultvec)
	sum(r .^ 2)
end
function of(madsdata::AbstractDict, resultdict::AbstractDict)
	of(madsdata, collect(values(resultdict)))
end
function of(madsdata::AbstractDict)
	resultdict = Mads.forward(madsdata)
	of(madsdata, collect(values(resultdict)))
end

@doc """
Compute objective function

$(DocumentFunction.documentfunction(of;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "resultvec"=>"result vector",
            "resultdict"=>"result dictionary")))
""" of

"""
Compute the sum of squared residuals for observations that match a regular expression

$(DocumentFunction.documentfunction(partialof;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "resultdict"=>"result dictionary",
            "regex"=>"regular expression")))

Returns:

- the sum of squared residuals for observations that match the regular expression
"""
function partialof(madsdata::AbstractDict, resultdict::AbstractDict, regex::Regex)
	obskeys = getobskeys(madsdata)
	results = Array{Float64}(undef, 0)
	weights = Array{Float64}(undef, 0)
	targets = Array{Float64}(undef, 0)
	for obskey in obskeys
		if occursin(regex, obskey)
			push!(results, resultdict[obskey]) # preserve the expected order
			push!(weights, madsdata["Observations"][obskey]["weight"])
			push!(targets, madsdata["Observations"][obskey]["target"])
		end
	end
	residuals = (results .- targets) .* weights
	return sum(residuals .^ 2)
end

function makelmfunctions(f::Function)
	f_lm = f
	function g_lm(x::Vector; dx::Array{Float64,1}=Array{Float64}(0), center::Array{Float64,1}=Array{Float64}(undef, 0))
		nO = length(center)
		if nO == 0
			center = f_lm(x)
			nO = length(center)
		end
		nP = length(x)
		jacobian = Array{Float64}(undef, (nO, nP))
		for i in 1:nP
			xi = x[i]
			x[i] += dx[i]
			jacobian[:, i] = (f_lm(x) - center) / dx[i]
			x[i] = xi
		end
		return jacobian
	end
	o_lm(x::Vector) = dot(x, x)
	return f_lm, g_lm, o_lm
end
function makelmfunctions(madsdata::AbstractDict)
	f = makemadscommandfunction(madsdata)
	restartdir = getrestartdir(madsdata)
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	sar = Mads.haskeyword(madsdata, "sar")
	o_lm(x::Vector) = sar ? sum.(abs.(x)) : dot(x, x)
	obskeys = Mads.getobskeys(madsdata)
	weights = Mads.getobsweight(madsdata, obskeys)
	targets = Mads.getobstarget(madsdata, obskeys)
	index = findall(isnan.(targets))
	weights[index] .= 0
	targets[index] .= 0
	if ssdr
		mins = Mads.getobsmin(madsdata, obskeys)
		maxs = Mads.getobsmax(madsdata, obskeys)
		mins[index] .= -Inf
		maxs[index] .= Inf
	end
	nO = length(obskeys)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	lineardx = getparamsstep(madsdata, optparamkeys)
	nP = length(optparamkeys)
	initparams = Mads.getparamdict(madsdata)
	"""
	Forward model function for Levenberg-Marquardt optimization
	"""
	function f_lm(arrayparameters::Vector)
		parameters = copy(initparams)
		for i = 1:length(arrayparameters)
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		results = Array{Float64}(undef, 0)
		for obskey in obskeys
			push!(results, resultdict[obskey]) # preserve the expected order
		end
		residuals = (results .- targets) .* weights
		if ssdr
			rmax = (results .- maxs) .* weights
			rmin = (results .- mins) .* weights
			rmax[rmax .< 0] .= 0
			rmin[rmin .> 0] .= 0
			residuals .+= (rmax .+ rmin)
		end
		return residuals
	end
	function inner_g_lm(arrayparameters_dx_center_tuple::Tuple)
		arrayparameters = arrayparameters_dx_center_tuple[1]
		dx = arrayparameters_dx_center_tuple[2]
		center = arrayparameters_dx_center_tuple[3]
		if sizeof(dx) == 0
			dx = lineardx
		end
		p = Vector{Float64}[]
		for i in 1:nP
			a = copy(arrayparameters)
			a[i] += dx[i]
			push!(p, a)
		end
		if sizeof(center) == 0
			filename = ReusableFunctions.gethashfilename(restartdir, arrayparameters)
			center = ReusableFunctions.loadresultfile(filename)
			center_computed = (center != nothing) && length(center) == nO
			if !center_computed
				push!(p, arrayparameters)
			end
		else
			center_computed = true
		end
		local fevals
		try
			fevals = RobustPmap.rpmap(f_lm, p)
		catch errmsg
			@show Base.stacktrace()
			printerrormsg(errmsg)
			Mads.madscritical("RobustPmap LM execution of forward runs fails!")
		end
		if !center_computed
			center = fevals[nP+1]
			if restartdir != ""
				ReusableFunctions.saveresultfile(restartdir, center, arrayparameters)
			end
		end
		jacobian = Array{Float64}(undef, (nO, nP))
		for j in 1:nO
			for i in 1:nP
				jacobian[j, i] = (fevals[i][j] - center[j]) / dx[i]
			end
		end
		return jacobian
	end
	reusable_inner_g_lm = makemadsreusablefunction(madsdata, inner_g_lm, "g_lm"; usedict=false)
	"""
	Gradient function for the forward model used for Levenberg-Marquardt optimization
	"""
	function g_lm(arrayparameters::Vector; dx::Array{Float64,1}=Array{Float64}(0), center::Array{Float64,1}=Array{Float64}(undef, 0)) #TODO we need the center; this is not working
		return reusable_inner_g_lm(tuple(arrayparameters, dx, center))
	end
	return f_lm, g_lm, o_lm
end

@doc """
Make forward model, gradient, objective functions needed for Levenberg-Marquardt optimization

$(DocumentFunction.documentfunction(makelmfunctions;
argtext=Dict("madsdata"=>"MADS problem dictionary", "f"=>"Function")))

Returns:

- forward model, gradient, objective functions
""" makelmfunctions

"""
Naive Levenberg-Marquardt optimization: get the LM parameter space step

$(DocumentFunction.documentfunction(naive_get_deltax;
argtext=Dict("JpJ"=>"Jacobian matrix times model parameters times transposed Jacobian matrix",
            "Jp"=>"Jacobian matrix times model parameters",
            "f0"=>"initial model observations",
            "lambda"=>"Levenberg-Marquardt lambda")))

Returns:

- the LM parameter space step
"""
function naive_get_deltax(JpJ::AbstractMatrix{Float64}, Jp::AbstractMatrix{Float64}, f0::Vector{Float64}, lambda::Number)
	u, s, v = svd(JpJ + lambda * SparseArrays.SparseMatrixCSC(Float64(1)LinearAlgebra.I, size(JpJ, 1), size(JpJ, 1)))
	deltax = (v * sparse(Diagonal(1 ./ s)) * u') * -Jp * f0
	return deltax
end

"""
Naive Levenberg-Marquardt optimization: perform LM iteration

$(DocumentFunction.documentfunction(naive_lm_iteration;
argtext=Dict("f"=>"forward model function",
            "g"=>"gradient function for the forward model",
            "o"=>"objective function",
            "x0"=>"initial parameter guess",
            "f0"=>"initial model observations",
            "lambdas"=>"Levenberg-Marquardt lambdas")))

Returns:

-
"""
function naive_lm_iteration(f::Function, g::Function, o::Function, x0::Vector{Float64}, f0::Vector{Float64}, lambdas::Vector{Float64})
	J = g(x0) # get jacobian
	Jp = J'
	JpJ = Jp * J
	deltaxs = RobustPmap.rpmap(lambda->naive_get_deltax(JpJ, Jp, f0, lambda), lambdas) # get the deltax for each lambda
	fs = RobustPmap.rpmap(deltax->f(x0 + deltax), deltaxs) # get the residuals for each deltax
	sses = RobustPmap.rpmap(o, fs) # get the sum of squared residuals for each forward run
	bestindex = argmin(sses) # find the best forward run
	return x0 + deltaxs[bestindex], sses[bestindex], fs[bestindex]
end

"""
Naive Levenberg-Marquardt optimization

$(DocumentFunction.documentfunction(naive_levenberg_marquardt;
argtext=Dict("f"=>"forward model function",
            "g"=>"gradient function for the forward model",
            "x0"=>"initial parameter guess",
            "o"=>"objective function [default=x->(x'*x)[1]]"),
keytext=Dict("maxIter"=>"maximum number of optimization iterations [default=`10`]",
            "maxEval"=>"maximum number of model evaluations [default=`101`]",
            "lambda"=>"initial Levenberg-Marquardt lambda [default=`100`]",
            "lambda_mu"=>"lambda multiplication factor μ [default=`10`]",
            "np_lambda"=>"number of parallel lambda solves [default=`10`]")))

Returns:

-
"""
function naive_levenberg_marquardt(f::Function, g::Function, x0::Vector{Float64}, o::Function=x->(x'*x)[1]; maxIter::Integer=10, maxEval::Integer=101, lambda::Number=100., lambda_mu::Number=10., np_lambda::Integer=10)
	lambdas = 10. .^ range(log10(lambda / (lambda_mu ^ (.5 * (np_lambda - 1)))), stop=log10(lambda * (lambda_mu ^ (.5 * (np_lambda - 1)))), length=np_lambda)
	currentx = x0
	currentf = f(x0)
	currentsse = Inf
	nEval = 1
	for iternum = 1:maxIter
		currentx, currentsse, currentf = naive_lm_iteration(f, g, o, currentx, currentf, lambdas)
		nEval += np_lambda * maxIter
		if maxEval < nEval
			break
		end
	end
	return LsqFit.MultivariateOptimizationResults(LsqFit.LevenbergMarquardt(), x0, currentx, currentsse, maxIter, false, false, 0.0, 0.0, false, 0.0, 0.0, true, 0.0, 0.0, true, LsqFit.OptimizationTrace{typeof(LsqFit.LevenbergMarquardt())}(), nEval, maxIter, 0)
end

"""
Levenberg-Marquardt optimization

$(DocumentFunction.documentfunction(levenberg_marquardt;
argtext=Dict("f"=>"forward model function",
            "g"=>"gradient function for the forward model",
            "x0"=>"initial parameter guess",
            "o"=>"objective function [default=`x->(x'*x)[1]`]"),
keytext=Dict("root"=>"Mads problem root name",
            "tolX"=>"parameter space tolerance [default=`1e-4`]",
            "tolG"=>"parameter space update tolerance [default=`1e-6`]",
            "tolOF"=>"objective function update tolerance [default=`1e-3`]",
            "maxEval"=>"maximum number of model evaluations [default=`1001`]",
            "maxIter"=>"maximum number of optimization iterations [default=`100`]",
            "maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
            "lambda"=>"initial Levenberg-Marquardt lambda [default=`eps(Float32)`]",
            "lambda_scale"=>"lambda scaling factor [default=`1e-3,`]",
            "lambda_mu"=>"lambda multiplication factor μ [default=`10`]",
            "lambda_nu"=>"lambda multiplication factor ν [default=`2`]",
            "np_lambda"=>"number of parallel lambda solves [default=`10`]",
            "show_trace"=>"shows solution trace [default=`false`]",
            "alwaysDoJacobian"=>"computer Jacobian each iteration [default=`false`]",
            "callbackiteration"=>"call back function for each iteration [default=`(best_x::Vector, of::Number, lambda::Number)->nothing`]",
            "callbackjacobian"=>"call back function for each Jacobian [default=`(x::Vector, J::Matrix)->nothing`]")))
"""
function levenberg_marquardt(f::Function, g::Function, x0, o::Function=x->(x'*x)[1]; root::String="", tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1001, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=eps(Float32), lambda_scale::Number=1e-3, lambda_mu::Number=10.0, lambda_nu::Number=2, np_lambda::Integer=10, show_trace::Bool=false, alwaysDoJacobian::Bool=false, callbackiteration::Function=(best_x::Vector, of::Number, lambda::Number)->nothing, callbackjacobian::Function=(x::Vector, J::Matrix)->nothing)
	# finds argmin sum(f(x).^2) using the Levenberg-Marquardt algorithm
	#          x
	# The function f should take an input vector of length n and return an output vector of length m
	# The function g is the Jacobian of f, and should be an m x n matrix
	# x0 is an initial guess for the solution
	# fargs is a tuple of additional arguments to pass to f
	# available options:
	#   tolX - search tolerance in x
	#   tolG - search tolerance in gradient
	#   tolOF - search tolerance in objective function
	#   maxIter - maximum number of iterations
	#   lambda - (inverse of) initial trust region radius
	#   lambda_mu - lambda decrease factor
	#   lambda_nu - lambda multiplication factor
	#   np_lambda - number of parallel lambdas to test
	#   show_trace - print a status summary on each iteration if true
	# returns: x, J
	#   x - least squares solution for x
	#   J - estimate of the Jacobian of f at x

	# other constants
	MAX_LAMBDA = 1e16 # minimum trust region radius
	MIN_LAMBDA = 1e-16 # maximum trust region radius
	MIN_STEP_QUALITY = 1e-3
	GOOD_STEP_QUALITY = 0.75
	MIN_DIAGONAL = 1e-6 # lower bound on values of diagonal matrix used to regularize the trust region step

	converged = false
	x_converged = false
	g_converged = false
	of_converged = false
	x = x0
	best_x = x0
	nP = length(x)
	DtDidentity = Matrix{Float64}(LinearAlgebra.I, nP, nP)
	f_calls = 0
	g_calls = 0
	if np_lambda > 1
		Mads.madsoutput("Parallel lambda search; number of parallel lambdas = $np_lambda\n");
	end

	fcur = f(x) # TODO execute the initial estimate in parallel with the first_lambda jacobian
	f_calls += 1
	best_f = fcur
	best_residual = residual = o(fcur)
	callbackiteration(x, residual, NaN)
	Mads.madsoutput("Initial OF: $residual\n");

	# Maintain a trace of the system.
	tr = LsqFit.OptimizationTrace{typeof(LsqFit.LevenbergMarquardt())}()
	if !Mads.quiet && show_trace
		d = Dict("lambda" => lambda)
		os = LsqFit.OptimizationState{typeof(LsqFit.LevenbergMarquardt())}(g_calls, o(fcur), NaN, d)
		push!(tr, os)
		println(os)
	end

	delta_xp = Array{Float64}(undef, (np_lambda, length(x)))
	trial_fp = Array{Float64}(undef, (np_lambda, length(fcur)))
	lambda_p = Array{Float64}(undef, np_lambda)
	phi = Array{Float64}(undef, np_lambda)
	first_lambda = true
	compute_jacobian = true
	failed = false
	while(~failed && ~converged && g_calls < maxJacobians && f_calls < maxEval)
		if compute_jacobian
			global J
			try
				global J = g(x, center=fcur)
			catch # many functions don't accept a "center", if they don't try it without -- this is super hack-y
				global J = g(x)
			end
			if any(isnan, J)
				Mads.madswarn("Provided Jacobian matrix contains NaN's!")
				Base.display(J)
				Mads.madswarn("Optimization will be terminated!")
				failed = true
				continue
			end
			f_calls += length(x)
			g_calls += 1
			Mads.madsoutput("Jacobian #$g_calls\n")
			callbackjacobian(x, J)
			compute_jacobian = false
		end
		Mads.madsoutput("Current Best OF: $best_residual\n");
		# Solve for:
		#    argmin 0.5*||J(x)*delta_x + f(x)||^2 + lambda*||diagm(J'*J)*delta_x||^2
		# Solving for the minimum gives:
		#    (J'*J + lambda*DtD) * delta_x == -J^T * f(x), where DtD = diagm(sum(J.^2,1))
		# Where we have used the equivalence: diagm(J'*J) = diagm(sum(J.^2, 1))
		# It is additionally useful to bound the elements of DtD below to help prevent "parameter evaporation".
		# DtD = diagm( Float64[max(x, MIN_DIAGONAL) for x in sum( J.^2, 1 )] )
		# DtDidentity used instead; seems to work better; LM in Mads.c uses DtDidentity
		JpJ = J' * J
		if LinearAlgebra.norm(JpJ) < eps(Float64)
			Mads.madswarn("Jacobian norm is too low! Parameters do not change observations.")
		end
		if first_lambda
			lambda = min(1e4, max(lambda, diag(JpJ)...)) * lambda_scale;
			first_lambda = false
		end
		lambda_current = lambda_down = lambda_up = lambda
		Mads.madsinfo(@Printf.sprintf "Iteration %02d: Starting lambda: %e" g_calls lambda_current)
		for npl = 1:np_lambda
			if npl == 1 # first lambda
				lambda_current = lambda_p[npl] = lambda
			elseif npl % 2 == 1 # even up
				lambda_up *= lambda_mu
				lambda_current = lambda_p[npl] = lambda_up
			else # odd down
				lambda_down /= lambda_mu
				lambda_current = lambda_p[npl] = lambda_down
			end
		end

		function getphianddelta_x(npl)
			lambda = lambda_p[npl]
			predicted_residual = []
			delta_x = []
			try
				Mads.madsinfo(@Printf.sprintf "#%02d lambda: %e" npl lambda);
				u, s, v = svd(JpJ + lambda * DtDidentity)
				is = similar(s)
				for i=1:length(s)
					if abs(s[i]) > eps(Float64)
						is[i] = 1 / s[i]
					else
						if sign(s[i]) == 0
							is[i] = 1 / eps(Float64)
						else
							is[i] = sign(s[i]) / eps(Float64)
						end
					end
				end
				# s = map(i->max(eps(Float32), i), s)
				delta_x = (v * sparse(Diagonal(is)) * u') * -J' * fcur
				# delta_x = (JpJ + lambda * DtDidentity) \ -J' * fcur # TODO replace with SVD
				predicted_residual = o(J * delta_x + fcur)
				# check for numerical problems in solving for delta_x by ensuring that the predicted residual is smaller than the current residual
				Mads.madsoutput("$(@Printf.sprintf "#%02d OF (est): %f" npl predicted_residual)", 3);
				if predicted_residual > residual + 2max(eps(predicted_residual), eps(residual))
					Mads.madsoutput(" -> not good", 1);
					if npl == 1
						Mads.madsoutput("Problem solving for delta_x: predicted residual increase. $predicted_residual (predicted_residual) > $residual (residual) + $(eps(predicted_residual)) (eps)", 2);
					end
				else
					Mads.madsoutput(" -> ok", 1);
				end
			catch
				Mads.madswarn(@Printf.sprintf "#%02d lambda: %e cannot be computed" npl lambda);
			end
			return predicted_residual, delta_x
		end

		local phisanddelta_xs
		try
			phisanddelta_xs = RobustPmap.rpmap(getphianddelta_x, collect(1:np_lambda))
		catch errmsg
			@show Base.stacktrace()
			printerrormsg(errmsg)
			Mads.madscritical("RobustPmap LM execution to get OF and lambdas fails!")
		end

		phi = []
		delta_xs = []
		for i=1:length(phisanddelta_xs)
			if length(phisanddelta_xs[i][2]) > 0
				push!(phi, phisanddelta_xs[i][1])
				push!(delta_xs, phisanddelta_xs[i][2])
			end
		end
		if length(delta_xs) == 0
			Mads.madswarn("Levenberg-Marquardt lambdas cannot be computed")
			Mads.madscritical("Mads quits!")
		end

		local trial_fs
		try
			trial_fs = RobustPmap.rpmap(f, map(dx->x + dx, delta_xs))
		catch errmsg
			@show Base.stacktrace()
			printerrormsg(errmsg)
			Mads.madscritical("RobustPmap LM execution of the forward models fails!")
		end

		f_calls += np_lambda
		objfuncevals = map(o, trial_fs)

		npl_best = argmin(objfuncevals)
		npl_worst = argmax(objfuncevals)
		Mads.madsoutput(@Printf.sprintf "OF     range in the parallel lambda search: min  %e max   %e\n" objfuncevals[npl_best] objfuncevals[npl_worst]);
		Mads.madsoutput(@Printf.sprintf "Lambda range in the parallel lambda search: best %e worst %e\n" lambda_p[npl_best] lambda_p[npl_worst]);
		lambda = lambda_p[npl_best] # Set lambda to the best value
		delta_x = vec(delta_xs[npl_best])
		trial_f = vec(trial_fs[npl_best])
		trial_residual = objfuncevals[npl_best]
		predicted_residual = o(J * delta_x + fcur)

		if objfuncevals[npl_best] < best_residual
			best_residual = trial_residual
			best_x = x + delta_x
			best_f = trial_f
		end

		# step quality = residual change / predicted residual change
		rho = (trial_residual - residual) / (predicted_residual - residual)
		if rho > MIN_STEP_QUALITY
			x += delta_x
			fcur = trial_f
			residual = trial_residual
			if rho > GOOD_STEP_QUALITY
				lambda = max(lambda / lambda_mu, MIN_LAMBDA) # increase trust region radius
			end
			compute_jacobian = true
		else
			lambda = min(lambda_nu * lambda, MAX_LAMBDA) # decrease trust region radius
			if np_lambda > 1
				x += delta_x
				fcur = trial_f
				residual = trial_residual
				compute_jacobian = true
			end
		end

		if !Mads.quiet && show_trace
			gradnorm = LinearAlgebra.norm(J'*fcur, Inf)
			d = Dict("g(x)" => gradnorm, "dx" => delta_x, "lambda" => lambda)
			os = LsqFit.OptimizationState{typeof(LsqFit.LevenbergMarquardt())}(g_calls, o(fcur), NaN, d)
			push!(tr, os)
			println(os)
		end
		callbackiteration(best_x, best_residual, lambda)

		# check convergence criteria:
		nx = LinearAlgebra.norm(delta_x)
		if nx < tolX * (tolX + LinearAlgebra.norm(x))
			Mads.madsinfo("Small parameter step size: $nx < $tolX (tolX)")
			x_converged = true
		end
		ng = LinearAlgebra.norm(J' * fcur, Inf)
		if ng < tolG
			Mads.madsinfo("Small gradient: $ng < $tolG (LinearAlgebra.norm(J^T * fcur) < tolG)")
			g_converged = true
		end
		if best_residual < tolOF
			Mads.madsinfo("Small objective function: $best_residual < $tolOF (tolOF)")
			of_converged = true
		end
		if g_calls >= maxJacobians
			Mads.madsinfo("Maximum number of Jacobian evaluations have been reached: $g_calls < $maxJacobians")
		end
		if f_calls >= maxEval
			Mads.madsinfo("Maximum number of Forward evaluations have been reached: $f_calls < $maxEval")
		end
		converged = g_converged | x_converged | of_converged
	end
	LsqFit.MultivariateOptimizationResults(LsqFit.LevenbergMarquardt(), x0, best_x, best_residual, g_calls, !converged, x_converged, tolX, 0.0, of_converged, tolOF, 0.0, g_converged, tolG, 0.0, false, tr, f_calls, g_calls, 0)
end
