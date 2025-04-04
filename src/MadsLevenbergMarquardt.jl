import RobustPmap
import LsqFit
import DocumentFunction
import LinearAlgebra

function residuals(madsdata::AbstractDict, resultvec::AbstractVector)
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

function of(madsdata::AbstractDict, resultvec::AbstractVector; filter::Union{AbstractVector,AbstractUnitRange,Colon}=Colon())
	r = residuals(madsdata, resultvec)
	sum(r[filter] .^ 2)
end
function of(madsdata::AbstractDict, d::AbstractDict; filter::Union{AbstractVector,AbstractUnitRange,Colon}=Colon())
	v = collect(values(d))
	if isobs(madsdata, d)
		of(madsdata, v; filter=filter)
	elseif isparam(madsdata, d)
		resultdict = Mads.forward(madsdata, d)
		of(madsdata, collect(values(resultdict)); filter=filter)
	else
		@warn "Unknown input dictionary!"
	end
end
function of(madsdata::AbstractDict, M::AbstractMatrix; filter::Union{AbstractVector,AbstractUnitRange,Colon}=Colon())
	optkeys = Mads.getoptparamkeys(madsdata)
	if length(optkeys) != size(M, 2)
		@warn "Number of columns in M does not match the number of optimization parameters!"
	end
	ofv = Vector{Float64}(undef, size(M, 1))
	for i in axes(M, 1)
		d = OrderedCollections.OrderedDict(zip(optkeys, M[i, :]))
		resultdict = Mads.forward(madsdata, d)
		ofv[i] = of(madsdata, collect(values(resultdict)); filter=filter)
	end
	return ofv
end
function of(madsdata::AbstractDict; filter::Union{AbstractVector,AbstractUnitRange,Colon}=Colon())
	resultdict = Mads.forward(madsdata)
	of(madsdata, collect(values(resultdict)); filter=filter)
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
	results = Vector{Float64}(undef, 0)
	weights = Vector{Float64}(undef, 0)
	targets = Vector{Float64}(undef, 0)
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
	function g_lm(x::AbstractVector; dx::Vector{Float64}=Array{Float64}(0), center::Vector{Float64}=Vector{Float64}(undef, 0))
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
	o_lm(x::AbstractVector) = LinearAlgebra.dot(x, x)
	return f_lm, g_lm, o_lm
end
function makelmfunctions(madsdata::AbstractDict; parallel_gradients::Bool=parallel_optimization)
	if !quiet
		if parallel_gradients
			@info("Parallel gradients!")
		else
			@info("Serial gradients!")
		end
	end
	f = makemadscommandfunction(madsdata)
	restartdir = getrestartdir(madsdata, "levenberg_marquardt")
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	sar = Mads.haskeyword(madsdata, "sar")
	o_lm(x::AbstractVector) = sar ? sum.(abs.(x)) : LinearAlgebra.dot(x, x)
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
	function f_lm(arrayparameters::AbstractVector)
		parameters = copy(initparams)
		for i = eachindex(arrayparameters)
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		results = Vector{Float64}(undef, 0)
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
			center_computed = (!isnothing(center)) && length(center) == nO
			if !center_computed
				push!(p, arrayparameters)
			end
		else
			center_computed = true
		end
		local fevals
		if parallel_gradients
			try
				fevals = RobustPmap.rpmap(f_lm, p)
			catch errmsg
				@show Base.stacktrace()
				printerrormsg(errmsg)
				Mads.madscritical("RobustPmap LM execution of forward runs fails!")
			end
		else
			fevals = map(f_lm, p)
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
	function g_lm(arrayparameters::AbstractVector; dx::Vector{Float64}=Array{Float64}(0), center::Vector{Float64}=Vector{Float64}(undef, 0)) # TODO we need the center; this is not working
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
function naive_get_deltax(JpJ::AbstractMatrix{Float64}, Jp::AbstractMatrix{Float64}, f0::AbstractVector{Float64}, lambda::Number)
	u, s, v = LinearAlgebra.svd(JpJ + lambda * SparseArrays.SparseMatrixCSC(Float64(1)LinearAlgebra.I, size(JpJ, 1), size(JpJ, 1)))
	deltax = (v * SparseArrays.sparse(LinearAlgebra.Diagonal(1 ./ s)) * u') * -Jp * f0
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
function naive_lm_iteration(f::Function, g::Function, o::Function, x0::AbstractVector{Float64}, f0::AbstractVector{Float64}, lambdas::AbstractVector{Float64})
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
function naive_levenberg_marquardt(f::Function, g::Function, x0::AbstractVector{Float64}, o::Function=x->(x'*x)[1]; maxIter::Integer=10, maxEval::Integer=101, lambda::Number=100., lambda_mu::Number=10., np_lambda::Integer=10)
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
	return LsqFit.LMResults(LsqFit.LevenbergMarquardt(), currentf, currentx, currentsse, maxIter, true, true, true, 0.0, LsqFit.LMTrace{LsqFit.LevenbergMarquardt}(), nEval, maxIter)
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
			"tolOFcount"=>"number of Jacobian runs with small objective function change [default=`5`]",
			"minOF"=>"objective function update tolerance [default=`1e-3`]",
			"maxEval"=>"maximum number of model evaluations [default=`1001`]",
			"maxIter"=>"maximum number of optimization iterations [default=`100`]",
			"maxJacobians"=>"maximum number of Jacobian solves [default=`100`]",
			"lambda"=>"initial Levenberg-Marquardt lambda [default=`eps(Float32)`]",
			"lambda_scale"=>"lambda scaling factor [default=`1e-3,`]",
			"lambda_mu"=>"lambda multiplication factor μ [default=`10`]",
			"lambda_nu"=>"lambda multiplication factor ν [default=`2`]",
			"np_lambda"=>"number of parallel lambda solves [default=`10`]",
			"show_trace"=>"shows solution trace [default=`false`]",
			"callbackiteration"=>"call back function for each iteration [default=`(best_x::AbstractVector, of::Number, lambda::Number)->nothing`]",
			"callbackjacobian"=>"call back function for each Jacobian [default=`(x::AbstractVector, J::AbstractMatrix)->nothing`]",
			"callbackfinal"=>"final call back function [default=`(best_x::AbstractVector, of::Number, lambda::Number)->nothing`]")))
"""
function levenberg_marquardt(f::Function, g::Function, x0, o::Function=x->(x'*x)[1]; root::AbstractString="", tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, tolOFcount::Integer=5, minOF::Number=1e-3, maxEval::Integer=1001, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=eps(Float32), lambda_scale::Number=1e-3, lambda_mu::Number=10.0, lambda_nu::Number=2, np_lambda::Integer=10, show_trace::Bool=false, quiet::Bool=Mads.quiet, callbackinitial::Function=(best_x::AbstractVector, of::Number, lambda::Number)->nothing, callbackiteration::Function=(best_x::AbstractVector, of::Number, lambda::Number)->nothing, callbackjacobian::Function=(x::AbstractVector, J::AbstractMatrix)->nothing, callbackfinal::Function=(best_x::AbstractVector, of::Number, lambda::Number)->nothing, parallel_execution::Bool=parallel_optimization, center_provided::Bool=true)
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
		madsoutput("Parallel lambda search; number of parallel lambdas = $(np_lambda)\n", 2);
	end

	fcur = f(x) # TODO execute the initial estimate in parallel with the first_lambda jacobian
	f_calls += 1
	best_residuals = fcur
	best_of = current_of = o(fcur)
	madsoutput("Initial OF: $(current_of)\n", 2);
	callbackinitial(x, current_of, NaN)

	tr = LsqFit.LMTrace{LsqFit.LevenbergMarquardt}()
	if show_trace
		d = Dict("lambda" => lambda)
		os = LsqFit.LMState{LsqFit.LevenbergMarquardt}(g_calls, best_of, NaN, d)
		push!(tr, os)
		println(os)
	end
	if !quiet
		println("OF: $(best_of) (initial)")
	end

	delta_xp = Array{Float64}(undef, (np_lambda, length(x)))
	trial_fp = Array{Float64}(undef, (np_lambda, length(fcur)))
	lambda_p = Array{Float64}(undef, np_lambda)
	phi = Array{Float64}(undef, np_lambda)
	first_lambda = true
	compute_jacobian = true
	failed = false
	local J
	residuals = Vector{Float64}(undef, 0)
	while(~failed && ~converged && g_calls < maxJacobians && f_calls < maxEval)
		if compute_jacobian
			if center_provided
				J = g(x; center=fcur)
			else
				J = g(x)
			end
			if any(isnan, J)
				Mads.madswarn("Provided Jacobian matrix contains NaN's!")
				Mads.madswarn("Optimization will be terminated!")
				failed = true
				continue
			end
			f_calls += length(x)
			g_calls += 1
			madsoutput("Jacobian #$(g_calls)\n", 2)
			callbackjacobian(x, J)
			compute_jacobian = false
		end
		madsoutput("Current Best OF: $(best_of)\n", 2);
		# Solve for:
		#    argmin 0.5*||J(x)*delta_x + f(x)||^2 + lambda*||diagm(J'*J)*delta_x||^2
		# Solving for the minimum gives:
		#    (J'*J + lambda*DtD) * delta_x == -J^T * f(x), where DtD = diagm(sum(J.^2,1))
		# Where we use the equivalence: diagm(J'*J) = diagm(sum(J.^2, 1))
		# It is additionally useful to bind the elements of DtD below to help prevent "parameter evaporation".
		# DtD = diagm(Float64[max(x, MIN_DIAGONAL) for x in sum( J.^2, 1 )])
		# DtDidentity used instead; seems to work better; LM in Mads.c uses DtDidentity
		JpJ = J' * J
		if LinearAlgebra.norm(JpJ) < eps(Float64)
			Mads.madswarn("Jacobian norm is too low! Parameters do not change observations.")
		end
		if first_lambda
			lambda = min(1e4, max(lambda, LinearAlgebra.diag(JpJ)...)) * lambda_scale;
			first_lambda = false
		end
		lambda_current = lambda_down = lambda_up = lambda
		madsinfo(@Printf.sprintf("Iteration %02d: Starting lambda: %e", g_calls, lambda_current), 2)
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
			predicted_of = []
			delta_x = []
			madsinfo(@Printf.sprintf("#%02d lambda: %e", npl, lambda), 2)
			u, s, v = LinearAlgebra.svd(JpJ + lambda * DtDidentity)
			is = similar(s)
			for i = eachindex(s)
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
			delta_x = (v * SparseArrays.sparse(LinearAlgebra.Diagonal(is)) * u') * -J' * fcur
			# delta_x = (JpJ + lambda * DtDidentity) \ -J' * fcur # TODO replace with SVD
			predicted_of = o(J * delta_x + fcur)
			# check for numerical problems in solving for delta_x by ensuring that the predicted residual is smaller than the current residual
			madsoutput(@Printf.sprintf("#%02d OF (est): %f", npl, predicted_of), 3);
			if predicted_of > current_of + 2max(eps(predicted_of), eps(current_of))
				madsoutput(" -> not good", 3);
				if npl == 1
					madsoutput("Problem solving for delta_x: predicted residual increase. $(predicted_of) (predicted_of) > $(current_of) (current_of) + $(eps(predicted_of)) (eps)", 4);
				end
			else
				madsoutput(" -> ok", 3);
			end
			return predicted_of, delta_x
		end
		# phisanddelta_xs = []
		# for i = collect(1:np_lambda)
		# 	push!(phisanddelta_xs, getphianddelta_x(1))
		# end

		local phisanddelta_xs
		if parallel_execution
			try
				phisanddelta_xs = RobustPmap.rpmap(getphianddelta_x, collect(1:np_lambda))
			catch errmsg
				@show Base.stacktrace()
				printerrormsg(errmsg)
				Mads.madscritical("RobustPmap LM execution to compute lambdas fails!")
			end
		else
			phisanddelta_xs = map(getphianddelta_x, collect(1:np_lambda))
		end

		phi = []
		delta_xs = []
		for i = eachindex(phisanddelta_xs)
			if length(phisanddelta_xs[i][2]) > 0
				push!(phi, phisanddelta_xs[i][1])
				push!(delta_xs, phisanddelta_xs[i][2])
			end
		end
		if length(delta_xs) == 0
			Mads.madswarn("Levenberg-Marquardt lambdas cannot be computed")
			Mads.madscritical("Mads quits!")
		end

		if parallel_execution
			local trial_residuals
			try
				trial_residuals = RobustPmap.rpmap(f, map(dx->x + dx, delta_xs))
			catch errmsg
				@show Base.stacktrace()
				printerrormsg(errmsg)
				Mads.madscritical("RobustPmap LM execution of the forward models fails!")
			end
		else
			trial_residuals = map(f, map(dx->x + dx, delta_xs))
		end

		f_calls += np_lambda
		trial_ofs = map(o, trial_residuals)

		npl_best = argmin(trial_ofs)
		npl_worst = argmax(trial_ofs)
		madsoutput(@Printf.sprintf("OF     range in the parallel lambda search: min %e max %e\n", trial_ofs[npl_best], trial_ofs[npl_worst]), 2)
		madsoutput(@Printf.sprintf("Lambda range in the parallel lambda search: best %e worst %e\n", lambda_p[npl_best], lambda_p[npl_worst]), 2)
		lambda = lambda_p[npl_best] # Set lambda to the best value
		delta_x = vec(delta_xs[npl_best])
		trial_f = vec(trial_residuals[npl_best])
		trial_residual = trial_ofs[npl_best]
		predicted_of = o(J * delta_x + fcur)

		push!(residuals, trial_ofs[npl_best])
		if trial_ofs[npl_best] < best_of
			best_of = trial_residual
			best_x = x + delta_x
			best_residuals = trial_f
		end

		# step quality = current_of change / predicted current_of change
		rho = (trial_residual - current_of) / (predicted_of - current_of)
		if rho > MIN_STEP_QUALITY
			x += delta_x
			fcur = trial_f
			current_of = trial_residual
			if rho > GOOD_STEP_QUALITY
				lambda = max(lambda / lambda_mu, MIN_LAMBDA) # increase trust region radius
			end
			compute_jacobian = true
		else
			lambda = min(lambda_nu * lambda, MAX_LAMBDA) # decrease trust region radius
			if np_lambda > 1
				x += delta_x
				fcur = trial_f
				current_of = trial_residual
				compute_jacobian = true
			end
		end

		if show_trace
			gradnorm = LinearAlgebra.norm(J' * fcur, Inf)
			d = Dict("g(x)" => gradnorm, "dx" => delta_x, "lambda" => lambda)
			os = LsqFit.LMState{LsqFit.LevenbergMarquardt}(g_calls, o(fcur), gradnorm, d)
			push!(tr, os)
			println(os)
		end
		if !quiet
			println("OF: $(o(fcur)) Lambda: $(lambda)")
		end
		callbackiteration(best_x, best_of, lambda)

		# check convergence criteria:
		nx = LinearAlgebra.norm(delta_x)
		if nx < tolX * (tolX + LinearAlgebra.norm(x))
			madsinfo("Small parameter step size: $nx < $tolX (tolX)", 2)
			x_converged = true
		end
		ng = LinearAlgebra.norm(J' * fcur, Inf)
		if ng < tolG
			madsinfo("Small gradient: $ng < $tolG (LinearAlgebra.norm(J^T * fcur) < tolG)", 2)
			g_converged = true
		end
		if length(residuals) > tolOFcount
			is = sortperm(residuals)
			changeOF = residuals[is][tolOFcount] - residuals[is][1]
			if changeOF < tolOF
				madsinfo("Small objective function changes (less than $tolOF tolOF): $changeOF < $tolOF", 2)
				of_converged = true
			end
		end
		if best_of < minOF
			madsinfo("Objective function less than $minOF (tolOF): $best_of < $minOF", 2)
			of_converged = true
		end
		if g_calls >= maxJacobians
			madsinfo("Maximum number of Jacobian evaluations have been reached: $g_calls < $maxJacobians", 2)
		end
		if f_calls >= maxEval
			madsinfo("Maximum number of Forward evaluations have been reached: $f_calls < $maxEval", 2)
		end
		converged = g_converged | x_converged | of_converged
	end
	if !quiet
		println("OF: $(best_of) (final)")
	end
	callbackfinal(best_x, best_of, NaN)
	LsqFit.LMResults(LsqFit.LevenbergMarquardt(), best_residuals, best_x, best_of, g_calls, !converged, x_converged, g_converged, float(tolG), tr, f_calls, g_calls)
end
