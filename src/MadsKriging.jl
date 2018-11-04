import DocumentFunction
import LinearAlgebra
import Statistics

"""
Gaussian spatial covariance function

$(DocumentFunction.documentfunction(gaussiancov;
argtext=Dict("h"=>"separation distance",
            "maxcov"=>"maximum covariance",
            "scale"=>"scale")))

Returns:

- covariance
"""
gaussiancov(h::Number, maxcov::Number, scale::Number) = maxcov * exp(-(h * h) / (scale * scale))

"""
Exponential spatial covariance function

$(DocumentFunction.documentfunction(expcov;
argtext=Dict("h"=>"separation distance",
            "maxcov"=>"maximum covariance",
            "scale"=>"scale")))

Returns:

- covariance
"""
expcov(h::Number, maxcov::Number, scale::Number) = maxcov * exp(-h / scale)

"""
Spherical spatial covariance function

$(DocumentFunction.documentfunction(sphericalcov;
argtext=Dict("h"=>"separation distance",
            "maxcov"=>"max covariance",
            "scale"=>"scale")))

Returns:

- covariance
"""
sphericalcov(h::Number, maxcov::Number, scale::Number) = (h <= scale ? maxcov * (1 - 1.5 * h / (scale) + .5 * (h / scale) ^ 3) : 0.)

"""
Spherical variogram

$(DocumentFunction.documentfunction(sphericalvariogram;
argtext=Dict("h"=>"separation distance",
            "sill"=>"sill",
            "range"=>"range",
            "nugget"=>"nugget")))

Returns:

- Spherical variogram
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

$(DocumentFunction.documentfunction(exponentialvariogram;
argtext=Dict("h"=>"separation distance",
            "sill"=>"sill",
            "range"=>"range",
            "nugget"=>"nugget")))

Returns:

- Exponential variogram
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

$(DocumentFunction.documentfunction(gaussianvariogram;
argtext=Dict("h"=>"separation distance",
            "sill"=>"sill",
            "range"=>"range",
            "nugget"=>"nugget")))

Returns:

- Gaussian variogram
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

$(DocumentFunction.documentfunction(krige;
argtext=Dict("x0mat"=>"point coordinates at which to obtain kriging estimates",
            "X"=>"coordinates of the observation (conditioning) data",
            "Z"=>"values for the observation (conditioning) data",
            "cov"=>"spatial covariance function")))

Returns:

- kriging estimates at `x0mat`
"""
function krige(x0mat::AbstractMatrix, X::AbstractMatrix, Z::Vector, cov::Function)
    if size(X, 2) != length(Z)
        error("number of points and observations don't match")
    end
	result = zeros(size(x0mat, 2))
	covmat = getcovmat(X, cov)
	bigmat = [covmat ones(size(X, 2)); ones(size(X, 2))' 0.]
	ws = Array{Float64}(undef, size(x0mat, 2))
	bigvec = Array{Float64}(undef, size(X, 2) + 1)
	bigvec[end] = 1
	bigmatpinv = pinv(bigmat)
	covvec = Array{Float64}(undef, size(X, 2))
	x = Array{Float64}(undef, size(X, 2) + 1)
	for i = 1:size(x0mat, 2)
		bigvec[1:end-1] = getcovvec!(covvec, x0mat[:, i], X, cov)
		bigvec[end] = 1
		mul!(x, bigmatpinv, bigvec)
		for j = 1:size(X, 2)
			result[i] += Z[j] * x[j]
		end
	end
	return result
end

"""
Get spatial covariance matrix

$(DocumentFunction.documentfunction(getcovmat;
argtext=Dict("X"=>"matrix with coordinates of the data points (x or y)",
            "cov"=>"spatial covariance function")))

Returns:

- spatial covariance matrix
"""
function getcovmat(X::AbstractMatrix, covfunction::Function)
	covmat = Array{Float64}(undef, size(X, 2), size(X, 2))
	cov0 = covfunction(0)
	for i = 1:size(X, 2)
		covmat[i, i] = cov0
		for j = i + 1:size(X, 2)
			covmat[i, j] = covfunction(LinearAlgebra.norm(X[:, i] .- X[:, j]))
			covmat[j, i] = covmat[i, j]
		end
	end
	return covmat
end

"""
Get spatial covariance vector

$(DocumentFunction.documentfunction(getcovvec!;
argtext=Dict("covvec"=>"spatial covariance vector",
            "x0"=>"vector with coordinates of the estimation points (x or y)",
            "X"=>"matrix with coordinates of the data points",
            "cov"=>"spatial covariance function")))

Returns:

- spatial covariance vector
"""
function getcovvec!(covvec::Vector, x0::Vector, X::AbstractMatrix, cov::Function)
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

function estimationerror(w::Vector, x0::Vector, X::AbstractMatrix, cov::Function)
	covmat = getcovmat(X, cov)
	covvec = Array{Float64}(undef, size(X, 2))
	covvec = getcovvec!(covvec, x0, X, cov)
	cov0 = cov(0.)
	return estimationerror(w, covmat, covvec, cov0)
end
function estimationerror(w::Vector, covmat::AbstractMatrix, covvec::Vector, cov0::Number)
	return cov0 + dot(w, covmat * w) - 2 * dot(w, covvec)
end

@doc """
Estimate kriging error

$(DocumentFunction.documentfunction(estimationerror;
argtext=Dict("w"=>"kriging weights",
            "x0"=>"estimated locations",
            "X"=>"observation matrix",
            "cov"=>"spatial covariance function",
            "covmat"=>"covariance matrix",
            "covvec"=>"covariance vector",
            "cov0"=>"zero-separation covariance")))

Returns:

- estimation kriging error
""" estimationerror
