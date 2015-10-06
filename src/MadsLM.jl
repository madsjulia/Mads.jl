# sse(x) gives the L2 norm of x
sse(x) = (x'*x)[1]

function makelmfunctions(madsdata)
	f = makemadscommandfunction(madsdata)
	g = makemadscommandgradient(madsdata, f)
	#f, g = makemadscommandfunctionandgradient(madsdata)
	obskeys = getobskeys(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	initparams = Dict(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function f_lm(arrayparameters::Vector)
		parameters = copy(initparams)
		for i = 1:length(arrayparameters)
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		residuals = Array(Float64, length(madsdata["Observations"]))
		i = 1
		for obskey in obskeys
			diff = resultdict[obskey] - madsdata["Observations"][obskey]["target"]
			weight = 1
			if haskey(madsdata["Observations"][obskey], "weight")
				weight = madsdata["Observations"][obskey]["weight"]
			end
			residuals[i] = diff * weight
			i += 1
		end
		return residuals
	end
	function g_lm(arrayparameters::Vector; dx=Array(Float64,0))
		parameters = copy(initparams)
		for i = 1:length(arrayparameters)
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		gradientdict = g(parameters; dx=dx)
		jacobian = Array(Float64, (length(obskeys), length(optparamkeys)))
		for i in 1:length(obskeys)
			for j in 1:length(optparamkeys)
				jacobian[i, j] = gradientdict[obskeys[i]][optparamkeys[j]]
			end
		end
		return jacobian
	end
	return f_lm, g_lm
end

function naive_get_deltax(JpJ::Matrix, Jp::Matrix, f0::Vector, lambda::Real)
	u, s, v = svd(JpJ + lambda * speye(Float64, size(JpJ, 1)))
	deltax = (v * spdiagm(1 ./ s) * u') * -Jp * f0
	return deltax
end

function naive_lm_iteration(f::Function, g::Function, x0::Vector, f0::Vector, lambdas::Vector)
	J = g(x0) # get jacobian
	Jp = J'
	JpJ = Jp * J
	deltaxs = pmap(lambda->naive_get_deltax(JpJ, Jp, f0, lambda), lambdas) # get the deltax for each lambda
	fs = pmap(deltax->f(x0 + deltax), deltaxs) # get the residuals for each deltax
	sses = pmap(sse, fs) # get the sum of squared residuals for each forward run
	bestindex = indmin(sses) # find the best forward run
	return x0 + deltaxs[bestindex], sses[bestindex], fs[bestindex]
end

function naive_levenberg_marquardt(f::Function, g::Function, x0::Vector; maxIter=10, maxEval=101, lambda=100., lambda_mu = 10., np_lambda=10)
	lambdas = logspace(log10(lambda / (lambda_mu ^ (.5 * (np_lambda - 1)))), log10(lambda * (lambda_mu ^ (.5 * (np_lambda - 1)))), np_lambda)
	currentx = x0
	currentf = f(x0)
	currentsse = Inf
	nEval = 1
	for iternum = 1:maxIter
		currentx, currentsse, currentf = naive_lm_iteration(f, g, currentx, currentf, lambdas)
		nEval += np_lambda * maxIter
		if maxEval < nEval
			break
		end
		@show currentx
		@show currentsse
	end
	return Optim.MultivariateOptimizationResults("Naive Levenberg-Marquardt", x0, currentx, currentsse, maxIter, false, false, 0.0, false, 0.0, false, 0.0, Optim.OptimizationTrace(), nEval, maxIter)
end

function levenberg_marquardt(f::Function, g::Function, x0; root="", tolX=1e-4, tolG=1e-6, tolOF=1e-3, maxEval=1001, maxIter=100, lambda=eps(Float32), lambda_scale=1e-3, lambda_mu=10.0, lambda_nu = 2, np_lambda=10, show_trace=false, maxJacobians=100, alwaysDoJacobian=false, callback=best_x->nothing)
	# finds argmin sum(f(x).^2) using the Levenberg-Marquardt algorithm
	#          x
	# The function f should take an input vector of length n and return an output vector of length m
	# The function g is the Jacobian of f, and should be an m x n matrix
	# x0 is an initial guess for the solution
	# fargs is a tuple of additional arguments to pass to f
	# available options:
	#   tolX - search tolerance in x
	#   tolG - search tolerance in gradient
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
	const MAX_LAMBDA = 1e16 # minimum trust region radius
	const MIN_LAMBDA = 1e-16 # maximum trust region radius
	const MIN_STEP_QUALITY = 1e-3
  const GOOD_STEP_QUALITY = 0.75
	const MIN_DIAGONAL = 1e-6 # lower bound on values of diagonal matrix used to regularize the trust region step

	converged = false
	x_converged = false
	g_converged = false
	of_converged = false
	iterCt = 0
	x = x0
	best_x = x0
	nP = length(x)
	DtDidentity = eye(nP)
	delta_x = copy(x0)
	f_calls = 0
	g_calls = 0
	if np_lambda > 1
		Mads.madsoutput("""Parallel lambda search; number of parallel lambdas = $np_lambda\n"""; level = 1);
	end

	fcur = f(x) # TODO execute the initial estimate in parallel with the first_lambda jacobian
	f_calls += 1
	best_f = fcur
	best_residual = residual = sse(fcur)
	Mads.madsoutput("""Initial OF: $residual\n"""; level = 1);

	# Maintain a trace of the system.
	tr = Optim.OptimizationTrace()
	if !Mads.quiet && show_trace
		d = @Compat.compat Dict("lambda" => lambda)
		os = Optim.OptimizationState(iterCt, sse(fcur), NaN, d)
		push!(tr, os)
		println(os)
	end

	delta_xp = Array(Float64, (np_lambda, length(x)))
	trial_fp = Array(Float64, (np_lambda, length(fcur)))
	lambda_p = Array(Float64, np_lambda)
	phi = Array(Float64, np_lambda)
	first_lambda = true
	maxJacobians = max(maxJacobians, maxIter)
	compute_jacobian = true
	while ( ~converged && g_calls < maxJacobians && f_calls < maxEval)
		if compute_jacobian
			J = g(x)
			if root != ""
				writedlm("$(root)-lmjacobian.dat", J)
			end
			g_calls += 1
			Mads.madsoutput("Jacobian #$g_calls\n"; level = 1);
			compute_jacobian = false
		end
		Mads.madsoutput("""Current Best OF: $best_residual\n"""; level = 1);
		# we want to solve:
		#    argmin 0.5*||J(x)*delta_x + f(x)||^2 + lambda*||diagm(J'*J)*delta_x||^2
		# Solving for the minimum gives:
		#    (J'*J + lambda*DtD) * delta_x == -J^T * f(x), where DtD = diagm(sum(J.^2,1))
		# Where we have used the equivalence: diagm(J'*J) = diagm(sum(J.^2, 1))
		# It is additionally useful to bound the elements of DtD below to help prevent "parameter evaporation".
		# DtD = diagm( Float64[max(x, MIN_DIAGONAL) for x in sum( J.^2, 1 )] )
		# DtDidentity used instead; seems to work better; LM in Mads.c uses DtDidentity
		JpJ = J' * J
		if first_lambda
			lambda = min(1e4, max(lambda, diag(JpJ)...)) * lambda_scale;
			first_lambda = false
		end
		lambda_current = lambda_down = lambda_up = lambda
		Mads.madswarn(@sprintf "Iteration %02d: Starting lambda: %e" iterCt lambda_current)
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
			Mads.madswarn(@sprintf "#%02d lambda: %e" npl lambda);
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
			delta_x = (v * spdiagm(is) * u') * -J' * fcur
			# delta_x = (JpJ + lambda * DtDidentity) \ -J' * fcur # TODO replace with SVD
			predicted_residual = sse(J * delta_x + fcur)
			# check for numerical problems in solving for delta_x by ensuring that the predicted residual is smaller than the current residual
			Mads.madsoutput(@sprintf "#%02d OF (est): %f" npl predicted_residual; level = 4);
			if predicted_residual > residual + 2max( eps(predicted_residual), eps(residual) )
				Mads.madsoutput(" -> not good"; level = 2);
				if np_lambda == 1
					Mads.madsoutput("""Problem solving for delta_x: predicted residual increase. $predicted_residual (predicted_residual) > $residual (residual) + $(eps(predicted_residual)) (eps)"""; level = 3);
				end
			else
				Mads.madsoutput(" -> ok"; level = 2);
			end
			return predicted_residual, delta_x
		end

		phisanddelta_xs = pmap(getphianddelta_x, collect(1:np_lambda))
		phi = map(x->x[1], phisanddelta_xs)
		delta_xs = map(x->x[2], phisanddelta_xs)

		function getobjfuncevalandtrial_f(npl)
			delta_x = delta_xs[npl]
			Mads.madsoutput("""# $npl lambda: Parameter change: $delta_x\n"""; level = 3 );
			trial_f = f(x + delta_x)
			objfunceval = sse(trial_f)
			Mads.madswarn(@sprintf "#%02d lambda: %e OF: %e (predicted %e)\n\n" npl lambda_p[npl] objfunceval phi[npl] );
			return objfunceval, trial_f
		end

		objfuncevalsandtrial_fs = pmap(getobjfuncevalandtrial_f, collect(1:np_lambda))
		f_calls += np_lambda
		objfuncevals = map(x->x[1], objfuncevalsandtrial_fs)
		trial_fs = map(x->x[2], objfuncevalsandtrial_fs)

		npl_best = indmin(objfuncevals)
		npl_worst = indmax(objfuncevals)
		Mads.madsoutput(@sprintf "OF     range in the parallel lambda search: min  %e max   %e\n" objfuncevals[npl_best] objfuncevals[npl_worst]; level = 1 );
		Mads.madsoutput(@sprintf "Lambda range in the parallel lambda search: best %e worst %e\n" lambda_p[npl_best] lambda_p[npl_worst]; level = 1 );
		lambda = lambda_p[npl_best] # Set lambda to the best value
		delta_x = vec(delta_xs[npl_best])
		trial_f = vec(trial_fs[npl_best])
		trial_residual = objfuncevals[npl_best]
		predicted_residual = sse(J * delta_x + fcur)

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
				compute_jacobian = true
			end
		end

		if objfuncevals[npl_best] < best_residual
			best_residual = objfuncevals[npl_best]
			best_x = x
			best_f = fcur
		end

		if show_trace
			gradnorm = norm(J'*fcur, Inf)
			d = @Compat.compat Dict("g(x)" => gradnorm, "dx" => delta_x, "lambda" => lambda)
			os = Optim.OptimizationState(iterCt, sse(fcur), gradnorm, d)
			push!(tr, os)
			println(os)
		end
		callback(best_x)

		# check convergence criteria:
		if norm(J' * fcur, Inf) < tolG # Small gradient: norm(J^T * fcur, Inf) < tolG
			g_converged = true
		end
		if norm(delta_x) < tolX * ( tolX + norm(x) ) # Small step size: norm(delta_x) < tolX
			x_converged = true
		end
		if best_residual < tolOF # Small objective fuction < tolOF
			of_converged = true
		end
		converged = g_converged | x_converged | of_converged
	end
	Optim.MultivariateOptimizationResults("Levenberg-Marquardt", x0, best_x, sse(best_f), iterCt, !converged, x_converged, 0.0, false, 0.0, g_converged, tolG, tr, f_calls, g_calls)
end

function plotmatches(madsdata, result; filename="", format="")
	rootname = Mads.getmadsrootname(madsdata)
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	c = Array(Float64, nT)
	t = Array(Float64, nT)
	d = Array(Float64, nT)
	for i in 1:nT
		t[i] = madsdata["Observations"][obskeys[i]]["time"]
		d[i] = madsdata["Observations"][obskeys[i]]["target"]
		c[i] = result[obskeys[i]]
	end
	p=Gadfly.plot(layer(x=t,y=c,Geom.line,Theme(default_color=parse(Colors.Colorant, "blue"),line_width=3pt)),
		layer(x=t,y=d,Geom.point,Theme(default_color=parse(Colors.Colorant, "red"),default_point_size=6pt)))
	if filename == ""
		filename = "$rootname-match"
	end
	filename, format = setimagefileformat(filename, format)
	Gadfly.draw(eval(symbol(format))(filename, 6inch, 4inch), p)
	p
end
