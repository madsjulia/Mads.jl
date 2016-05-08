import NMF

"Non-negative Matrix Factorization using NMF"
function NMFm(X, nk; retries=100, tol=1.0e-9, maxiter=100000)
	nP = size(X)[1] # number of observation points
	nC = size(X)[2] # number of observed components/transients
	Wbest = Array(Float64, nP, nk)
	Hbest = Array(Float64, nk, nC)
	phi_best = Inf
	for i = 1:retries
		nmf_result = NMF.nnmf(X, nk; alg=:multmse, maxiter=maxiter, tol=tol)
		phi = nmf_result.objvalue
		if phi_best > phi
			phi_best = phi
			Wbest = nmf_result.W
			Hbest = nmf_result.H
		end
	end
	return Wbest, Hbest, phi_best
end

"Matrix Factorization via Levenberg Marquardt"
function MFlm(X, nk; mads=true, log_W=false, log_H=false, retries=1)
	nS = size(X)[1]
	nP = size(X)[2]
	W_size = nS * nk
	if log_W
		W_logtransformed = trues(W_size)
		W_lowerbounds = ones(W_size) * 1e-15
	else
		W_logtransformed = falses(W_size)
		W_lowerbounds = zeros(W_size)
	end
	W_upperbounds = ones(W_size)
	W_init = ones(W_size) * 0.5
	H_size = nP * nk
	if log_H
		H_logtransformed = trues(H_size)
		H_lowerbounds = ones(H_size) * 1e-15
	else
		H_logtransformed = falses(H_size)
		H_lowerbounds = zeros(H_size)
	end
	H_upperbounds = ones(H_size) * maximum(X) * 100
	H_init = ones(H_size) * 0.5
	nParam = W_size + H_size
	nObs = nP * nS
	x = [W_init; H_init]
	logtransformed = [W_logtransformed; H_logtransformed]
	lowerbounds = [W_lowerbounds; H_lowerbounds]
	upperbounds = [W_upperbounds; H_upperbounds]
	indexlogtransformed = find(logtransformed)
	lowerbounds[indexlogtransformed] = log10(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10(upperbounds[indexlogtransformed])

	function mf_reshape(x::Vector)
		W = reshape(x[1:W_size], nS, nk)
		H = reshape(x[W_size+1:end], nk, nP)
		return W, H
	end

	function mf_lm(x::Vector)
		W, H = mf_reshape(x)
		E = X - W * H
		return vec(E)
	end

	function mf_g_lm(x::Vector)
		W = reshape(x[1:W_size], nS, nk)
		H = reshape(x[W_size+1:end], nk, nP)
		Wb = zeros(nS, nk)
		Hb = zeros(nk, nP)
		J = Array(Float64, nObs, 0)
		for j = 1:nk
			for i = 1:nS
				Wb[i,j] = 1
				v = vec(-Wb * H)
				Wb[i,j] = 0
				J = [J v]
			end
		end
		for j = 1:nP
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
	if mads
		r = Mads.levenberg_marquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed), maxEval=10000, maxIter=10000, maxJacobians=10000, tolX=1e-12, tolG=1e-15)
	else
		r = Optim.levenberg_marquardt(mf_lm_sin, mf_g_lm_sin, Mads.asinetransform(x, lowerbounds, upperbounds, indexlogtransformed), maxIter=10000)
	end
	display(r)
	# println("OF = $(r.f_minimum)")
	x_final = Mads.sinetransform(r.minimum, lowerbounds, upperbounds, indexlogtransformed)
	W, H = mf_reshape(x_final)
	return W, H, r.f_minimum
end
