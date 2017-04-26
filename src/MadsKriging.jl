"""
Gaussian spatial covariance function

$(DocumentFunction.documentfunction(gaussiancov))
"""
gaussiancov(h::Number, maxcov::Number, scale::Number) = maxcov * exp(-(h * h) / (scale * scale))

"""
Exponential spatial covariance function

$(DocumentFunction.documentfunction(expcov))
"""
expcov(h::Number, maxcov::Number, scale::Number) = maxcov * exp(-h / scale)

"""
Spherical spatial covariance function

$(DocumentFunction.documentfunction(sphericalcov))
"""
sphericalcov(h::Number, maxcov::Number, scale::Number) = (h <= scale ? maxcov * (1 - 1.5 * h / (scale) + .5 * (h / scale) ^ 3) : 0.)

"""
Spherical variogram

$(DocumentFunction.documentfunction(sphericalvariogram))
"""
function sphericalvariogram(h::Number, sill::Number, range::Number, nugget::Number)
	if h == 0.
		return 0.
	elseif h < range
		return (sill - nugget) * ((3 * h / (2 * range) - h ^ 3 / (2 * range ^ 3))) + nugget
	else
		return sill
	end
end

"""
Exponential variogram

$(DocumentFunction.documentfunction(exponentialvariogram))
"""
function exponentialvariogram(h::Number, sill::Number, range::Number, nugget::Number)
	if h == 0.
		return 0.
	else
		return (sill - nugget) * (1 - exp(-h / (3 * range))) + nugget
	end
end

"""
Gaussian variogram

$(DocumentFunction.documentfunction(gaussianvariogram))
"""
function gaussianvariogram(h::Number, sill::Number, range::Number, nugget::Number)
	if h == 0.
		return 0.
	else
		return (sill - nugget) * (1 - exp(-h * h / (3 * range * range))) + nugget
	end
end

"""
Kriging

$(DocumentFunction.documentfunction(krige))
"""
function krige(x0mat::Array, X::Matrix, Z::Vector, cov::Function)
	result = zeros(size(x0mat, 2))
	covmat = getcovmat(X, cov)
	bigmat = [covmat ones(size(X, 2)); ones(size(X, 2))' 0.]
	ws = Array{Float64}(size(x0mat, 2))
	bigvec = Array{Float64}(size(X, 2) + 1)
	bigvec[end] = 1
	bigmatpinv = pinv(bigmat)
	covvec = Array{Float64}(size(X, 2))
	x = Array{Float64}(size(X, 2) + 1)
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

"""
Get spatial covariance matrix

$(DocumentFunction.documentfunction(getcovmat))
"""
function getcovmat(X::Matrix, cov::Function)
	covmat = Array{Float64}((size(X, 2), size(X, 2)))
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

"""
Get spatial covariance vector

$(DocumentFunction.documentfunction(getcovvec!))
"""
function getcovvec!(covvec::Array, x0::Vector, X::Matrix, cov::Function)
	for i = 1:size(X, 2)
		d = 0.
		for j = 1:size(X, 1)
			d += (X[j, i] - x0[j]) ^ 2
		end
		d = sqrt.(d)
		covvec[i] = cov(d)
	end
	return covvec
end

"""
Estimate kriging error

$(DocumentFunction.documentfunction(estimationerror))
"""
function estimationerror(w::Vector, x0::Vector, X::Matrix, cov::Function)
	covmat = getcovmat(X, cov)
	covvec = Array{Float64}(size(X, 2))
	covvec = getcovvec!(covvec, x0, X, cov)
	cov0 = cov(0.)
	return estimationerror(w, x0, X, covmat, covvec, cov0)
end
function estimationerror(w::Vector, x0::Vector, X::Matrix, covmat::Matrix, covvec::Vector, cov0::Number)
	return cov0 + dot(w, covmat * w) - 2 * dot(w, covvec)
end
