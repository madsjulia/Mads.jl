import NMF
import JuMP
import Ipopt
import Optim

"Non-negative Matrix Factorization using NMF"
function NMFm(X, nk; retries=1, tol=1.0e-9, maxiter=10000)
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array(Float64, nP, nk)
	Hbest = Array(Float64, nk, nC)
	phi_best = Inf
	for i = 1:retries
		nmf_result = NMF.nnmf(X, nk; alg=:multmse, maxiter=maxiter, tol=tol)
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

"Non-negative Matrix Factorization using JuMP/NLopt"
function NMFnlopt(X, nk; retries=1, tol=1.0e-9, random=false, maxiter=100000, maxguess=10., initW=nothing, initH=nothing, verbosity=0)
	Xc = copy(X)
	weights = ones(size(Xc))
	nans = isnan(Xc)
	Xc[nans] = 0
	weights[nans] = 0
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array(Float64, nP, nk)
	Hbest = Array(Float64, nk, nC)
	phi_best = Inf
	for r = 1:retries
		m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
		if r == 1 && initW != nothing
			@JuMP.variable(m, W[i=1:nP, k=1:nk] >= 0., start=initW[i, k])
		elseif r > 1 || random
			@JuMP.variable(m, W[1:nP, 1:nk] >= 0., start=rand())
		else
			@JuMP.variable(m, W[1:nP, 1:nk] >= 0.)
		end
		if r == 1 && initH != nothing
			@JuMP.variable(m, H[k=1:nk, j=1:nC] >= 0., start=initH[k, j])
		elseif r > 1 || random
			@JuMP.variable(m, H[1:nk, 1:nC] >= 0., start=maxguess * rand())
		else 
			@JuMP.variable(m, H[1:nk, 1:nC] >= 0., start=maxguess / 2)
		end
		@JuMP.constraint(m, W .<= 1)
		@JuMP.NLobjective(m, Min, sum{sum{weights[i, j] * (sum{W[i, k] * H[k, j], k=1:nk} - Xc[i, j])^2, i=1:nP}, j=1:nC})
		JuMP.solve(m)
		phi = JuMP.getobjectivevalue(m)	
		println("OF = $(phi)")
		if phi_best > phi
			phi_best = phi
			Wbest = JuMP.getvalue(W)
			Hbest = JuMP.getvalue(H)
		end
	end
	return Wbest, Hbest, phi_best
end

"Matrix Factorization via Levenberg Marquardt"
function MFlm(X, nk; mads=true, log_W=false, log_H=false, retries=1, tol=1.0e-9, maxiter=10000, initW=nothing, initH=nothing)
	nP = size(X, 1) # number of observation points
	nC = size(X, 2) # number of observed components/transients
	Wbest = Array(Float64, nP, nk)
	Hbest = Array(Float64, nk, nC)
	W_size = nP * nk
	if log_W
		W_logtransformed = trues(W_size)
		W_lowerbounds = ones(W_size) * 1e-15
	else
		W_logtransformed = falses(W_size)
		W_lowerbounds = zeros(W_size)
	end
	W_upperbounds = ones(W_size)
	if initW != nothing
		W_init = initW
	else
		W_init = ones(W_size) * 0.5
	end
	H_size = nC * nk
	if log_H
		H_logtransformed = trues(H_size)
		H_lowerbounds = ones(H_size) * 1e-15
	else
		H_logtransformed = falses(H_size)
		H_lowerbounds = zeros(H_size)
	end
	H_upperbounds = ones(H_size) * maximum(X) * 100
	if initH != nothing
		H_init = initH
	else
		H_init = ones(H_size)
	end
	x = [W_init; H_init]
	nParam = W_size + H_size
	nObs = nP * nC
	logtransformed = [W_logtransformed; H_logtransformed]
	lowerbounds = [W_lowerbounds; H_lowerbounds]
	upperbounds = [W_upperbounds; H_upperbounds]
	indexlogtransformed = find(logtransformed)
	lowerbounds[indexlogtransformed] = log10(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10(upperbounds[indexlogtransformed])

	function mf_reshape(x::Vector)
		W = reshape(x[1:W_size], nP, nk)
		H = reshape(x[W_size+1:end], nk, nC)
		return W, H
	end

	function mf_lm(x::Vector)
		W, H = mf_reshape(x)
		E = X - W * H
		return vec(E)
	end

	function mf_g_lm(x::Vector)
		W, H = mf_reshape(x)
		Wb = zeros(nP, nk)
		Hb = zeros(nk, nC)
		J = Array(Float64, nObs, 0)
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
	mf_g_lm_sin = Mads.sinetransformfunction(mf_g_lm, lowerbounds, upperbounds, indexlogtransformed)
	phi_best = Inf
	for i = 1:retries
		if retries > 1
			W_init = rand(W_size)
			H_init = ones(H_size)
			x = [W_init; H_init]
		end
		if mads
			r = Mads.levenberg_marquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed), maxEval=maxiter, maxIter=maxiter, maxJacobians=maxiter, tolX=tol, tolG=1e-16)
		else
			r = Optim.LevenbergMarquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed), maxIter=maxiter)
		end
		phi = r.f_minimum
		#display(r)
		println("OF = $(phi)")
		if phi_best > phi
			phi_best = phi
			x_best = Mads.sinetransform(r.minimum, lowerbounds, upperbounds, indexlogtransformed)
			Wbest, Hbest = mf_reshape(x_best)
		end
	end
	return Wbest, Hbest, phi_best
end
