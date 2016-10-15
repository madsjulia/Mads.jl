gaussiancov(h, maxcov, scale) = maxcov * exp(-(h * h) / (scale * scale))
expcov(h, maxcov, scale) = maxcov * exp(-h / scale)
sphericalcov(h, maxcov, scale) = (h <= scale ? maxcov * (1 - 1.5 * h / (scale) + .5 * (h / scale) ^ 3) : 0.)

function krige(x0mat::Matrix, X::Matrix, Z::Vector, cov)
	result = zeros(size(x0mat, 2))
	covmat = getcovmat(X, cov)
	bigmat = [covmat ones(size(X, 2)); ones(size(X, 2))' 0.]
	ws = Array(Float64, size(x0mat, 2))
	bigvec = Array(Float64, size(X, 2) + 1)
	bigvec[end] = 1
	bigmatpinv = pinv(bigmat)
	covvec = Array(Float64, size(X, 2))
	x = Array(Float64, size(X, 2) + 1)
	for i = 1:size(x0mat, 2)
		bigvec[1:end-1] = getcovvec!(covvec, x0mat[:, i], X, cov)
		bigvec[end] = 1
		A_mul_B!(x, bigmatpinv, bigvec)
		for j = 1:size(X, 2)
			result[i] += Z[j] * x[j]
		end
	end
	return result
end

function getcovmat(X::Matrix, cov::Function)
	covmat = Array(Float64, (size(X, 2), size(X, 2)))
	cov0 = cov(0)
	for i = 1:size(X, 2)
		covmat[i, i] = cov0
		for j = i + 1:size(X, 2)
			covmat[i, j] = cov(norm(X[:, i] - X[:, j]))
			covmat[j, i] = covmat[i, j]
		end
	end
	return covmat
end

function getcovvec!(covvec, x0::Vector, X::Matrix, cov::Function)
	for i = 1:size(X, 2)
		d = 0.
		for j = 1:size(X, 1)
			d += (X[j, i] - x0[j]) ^ 2
		end
		d = sqrt(d)
		covvec[i] = cov(d)
	end
	return covvec
end

function estimationerror(w::Vector, x0::Vector, X::Matrix, cov::Function)
	covmat = getcovmat(X, cov)
	covvec = getcovvec(x0, X, cov)
	cov0 = cov(0.)
	return estimationerror(w, x0, X, covmat, covvec, cov0)
end

function estimationerror(w::Vector, x0::Vector, X::Matrix, covmat::Matrix, covvec::Vector, cov0::Number)
	return cov0 + dot(w, covmat * w) - 2 * dot(w, covvec)
end
