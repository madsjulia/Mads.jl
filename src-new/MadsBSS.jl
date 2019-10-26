import DocumentFunction
import NMF
import LsqFit
import JuMP
import Ipopt

"""
Non-negative Matrix Factorization using NMF

$(DocumentFunction.documentfunction(NMFm;
argtext=Dict("X"=>"matrix to factorize",
            "nk"=>"number of features to extract"),
keytext=Dict("retries"=>"number of solution retries [default=`1`]",
            "tol"=>"solution tolerance [default=`1.0e-9`]",
            "maxiter"=>"maximum number of iterations [default=`10000`]")))

Returns:

- NMF results
"""
function NMFm(X::Array, nk::Integer; retries::Integer=1, tol::Number=1.0e-9, maxiter::Integer=10000)
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array{Float64}(undef, nP, nk)
	Hbest = Array{Float64}(undef, nk, nC)
	phi_best = Inf
	for i = 1:retries
		nmf_result = NMF.nnmf(X, nk; maxiter=maxiter, tol=tol)
		phi = nmf_result.objvalue
		println("OF = $(phi)")
		if phi_best > phi
			phi_best = phi
			Wbest = nmf_result.W
			Hbest = nmf_result.H
		end
	end
	return Wbest, Hbest, phi_best
end

"""
Non-negative Matrix Factorization using JuMP/Ipopt

$(DocumentFunction.documentfunction(NMFipopt;
argtext=Dict("X"=>"matrix to factorize",
            "nk"=>"number of features to extract",
            "retries"=>"number of solution retries [default=`1`]"),
keytext=Dict("tol"=>"solution tolerance [default=`1.0e-9`]",
            "random"=>"random initial guesses [default=`false`]",
            "maxiter"=>"maximum number of iterations [default=`100000`]",
            "maxguess"=>"guess about the maximum for the H (feature) matrix [default=`1`]",
            "initW"=>"initial W (weight) matrix",
            "initH"=>"initial H (feature) matrix",
            "verbosity"=>"verbosity output level [default=`0`]",
            "quiet"=>"quiet [default=`false`]")))

Returns:

- NMF results
"""
function NMFipopt(X::Matrix, nk::Integer, retries::Integer=1; random::Bool=false, maxiter::Integer=100000, maxguess::Number=1, initW::Matrix=Array{Float64}(undef, 0, 0), initH::Matrix=Array{Float64}(undef, 0, 0), verbosity::Integer=0, quiet::Bool=false)
	Xc = copy(X)
	weights = ones(size(Xc))
	nans = isnan.(Xc)
	Xc[nans] .= 0
	weights[nans] .= 0
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array{Float64}(undef, nP, nk)
	Hbest = Array{Float64}(undef, nk, nC)
	phi_best = Inf
	for r = 1:retries
		m = JuMP.Model(JuMP.with_optimizer(Ipopt.Optimizer; max_iter=maxiter, print_level=verbosity))
		#IMPORTANT the order at which parameters are defined is very important
		if r == 1 && sizeof(initW) != 0
			@JuMP.variable(m, W[i=1:nP, k=1:nk] >= 0., start=initW[i, k])
		elseif r > 1 || random
			@JuMP.variable(m, W[1:nP, 1:nk] >= 0., start=rand())
		else
			@JuMP.variable(m, W[1:nP, 1:nk] >= 0., start=0.5)
		end
		if r == 1 && sizeof(initH) != 0
			@JuMP.variable(m, H[k=1:nk, j=1:nC] >= 0., start=initH[k, j])
		elseif r > 1 || random
			@JuMP.variable(m, H[1:nk, 1:nC] >= 0., start=maxguess * rand())
		else
			@JuMP.variable(m, H[1:nk, 1:nC] >= 0., start=maxguess / 2)
		end
		@JuMP.constraint(m, W .<= 1) # this is very important constraint to make optimization faster
		@JuMP.NLobjective(m, Min, sum(sum(weights[i, j] * (sum(W[i, k] * H[k, j] for k=1:nk) - Xc[i, j])^2 for i=1:nP) for j=1:nC))
		JuMP.optimize!(m)
		phi = JuMP.objective_value(m)
		!quiet && println("OF = $(phi)")
		if phi_best > phi
			phi_best = phi
			Wbest = JuMP.value.(W)
			Hbest = JuMP.value.(H)
		end
	end
	return Wbest, Hbest, phi_best
end

function MFlm(X::Matrix{T}, range::AbstractRange{Int}; kw...) where {T}
	maxsources = maximum(collect(range))
	W = Array{Array{T, 2}}(undef, maxsources)
	H = Array{Array{T, 2}}(undef, maxsources)
	fitquality = Array{T}(undef, maxsources)
	for numsources in range
		W[numsources], H[numsources], fitquality[numsources] = Mads.MFlm(X, numsources; kw...)
	end
	return W, H, fitquality
end

"""
Matrix Factorization using Levenberg Marquardt

$(DocumentFunction.documentfunction(MFlm;
argtext=Dict("X"=>"matrix to factorize",
            "nk"=>"number of features to extract"),
keytext=Dict("mads"=>"use MADS Levenberg-Marquardt algorithm [default=`true`]",
            "log_W"=>"log-transform W (weight) matrix [default=`false`]",
            "log_H"=>"log-transform H (feature) matrix[default=`false`]",
            "retries"=>"number of solution retries [default=`1`]",
            "tol"=>"solution tolerance [default=`1.0e-9`]",
            "maxiter"=>"maximum number of iterations [default=`10000`]",
            "initW"=>"initial W (weight) matrix",
            "initH"=>"initial H (feature) matrix")))

Returns:

- NMF results
"""
function MFlm(X::Matrix{T}, nk::Integer; method::Symbol=:mads, log_W::Bool=false, log_H::Bool=false, retries::Integer=1, initW::Matrix=Array{T}(undef, 0, 0), initH::Matrix=Array{T}(undef, 0, 0), tolX::Number=1e-4, tolG::Number=1e-6, tolOF::Number=1e-3, maxEval::Integer=1000, maxIter::Integer=100, maxJacobians::Integer=100, lambda::Number=100.0, lambda_mu::Number=10.0, np_lambda::Integer=10, show_trace::Bool=false, quiet::Bool=true) where {T}
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array{T}(undef, nP, nk)
	Hbest = Array{T}(undef, nk, nC)
	W_size = nP * nk
	if log_W
		W_logtransformed = trues(W_size)
		W_lowerbounds = ones(W_size) * 1e-15
	else
		W_logtransformed = falses(W_size)
		W_lowerbounds = zeros(W_size)
	end
	if sizeof(initW) > 0
		W_init = vec(initW)
	else
		W_init = ones(W_size) * 0.5
	end
	W_upperbounds = ones(W_size) * max(1, maximum(W_init))
	H_size = nC * nk
	if log_H
		H_logtransformed = trues(H_size)
		H_lowerbounds = ones(H_size) * 1e-15
	else
		H_logtransformed = falses(H_size)
		H_lowerbounds = zeros(H_size)
	end
	nanmask = isnan.(X)
	if sizeof(initH) > 0
		H_init = vec(initH)
	else
		H_init = ones(H_size)
	end
	H_upperbounds = ones(H_size) * max(maximum(X[.!nanmask]), maximum(H_init))
	x = [W_init; H_init]
	nParam = W_size + H_size
	nObs = nP * nC
	logtransformed = [W_logtransformed; H_logtransformed]
	lowerbounds = [W_lowerbounds; H_lowerbounds]
	upperbounds = [W_upperbounds; H_upperbounds]
	indexlogtransformed = findall(logtransformed)
	lowerbounds[indexlogtransformed] = log10.(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10.(upperbounds[indexlogtransformed])

	function mf_reshape(x::Vector)
		W = reshape(x[1:W_size], nP, nk)
		H = reshape(x[W_size+1:end], nk, nC)
		return W, H
	end

	function mf_lm(x::Vector)
		W, H = mf_reshape(x)
		E = X - W * H
		E[nanmask] .= 0
		return vec(E)
	end

	function mf_g_lm(x::Vector; dx=nothing, center=nothing)
		W, H = mf_reshape(x)
		Wb = zeros(nP, nk)
		Hb = zeros(nk, nC)
		J = Array{Float64}(undef, nObs, 0)
		for j = 1:nk
			for i = 1:nP
				Wb[i,j] = 1
				v = vec(-Wb * H)
				Wb[i,j] = 0
				J = [J v]
			end
		end
		for j = 1:nC
			for i = 1:nk
				Hb[i,j] = 1
				v = vec(-W * Hb)
				Hb[i,j] = 0
				J = [J v]
			end
		end
		return J
	end

	mf_lm_sin = Mads.sinetransformfunction(mf_lm, lowerbounds, upperbounds, indexlogtransformed)
	mf_g_lm_sin = Mads.sinetransformgradient(mf_g_lm, lowerbounds, upperbounds, indexlogtransformed)
	phi_best = Inf
	for i = 1:retries
		if i > 1
			W_init = rand(W_size)
			H_init = ones(H_size)
			x = [W_init; H_init]
		end
		if method == :mads
			r = Mads.levenberg_marquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed); tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace)
		elseif method == :madsmin
			_, r = Mads.minimize(mf_lm, x; upperbounds=upperbounds, lowerbounds=lowerbounds, logtransformed=logtransformed, tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace)
		elseif method == :lsqfit
			r = LsqFit.levenberg_marquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed); maxIter=maxIter)
		else
			Mads.madserror("Unknown method!")
			return;
		end
		phi = r.minimum
		# Base.display(r)
		println("OF = $(phi)")
		if phi_best > phi
			phi_best = phi
			x_best = Mads.sinetransform(r.minimizer, lowerbounds, upperbounds, indexlogtransformed)
			Wbest, Hbest = mf_reshape(x_best)
		end
	end
	println("Signals: $(@Printf.sprintf("%2d", nk)) Fit: $(@Printf.sprintf("%12.7g", phi_best))")
	return Wbest, Hbest, phi_best
end
