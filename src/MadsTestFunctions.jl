import DocumentFunction

"""
Rosenbrock test function (more difficult to solve)

$(DocumentFunction.documentfunction(rosenbrock2_lm;
argtext=Dict("x"=>"argument")))
"""
function rosenbrock2_lm(x::Vector)
	[10.0 * ( x[2] - x[1]^2 ); 1.0 - x[1]]
end

"""
Parameter gradients of the Rosenbrock test function

$(DocumentFunction.documentfunction(rosenbrock2_gradient_lm;
argtext=Dict("x"=>"argument")))

Returns:

- Parameter gradients
"""
function rosenbrock2_gradient_lm(x::Vector)
	j = Array{Float64}(2,2)
	j[1, 1] = -20.0 * x[1]
	j[1, 2] =  10.0
	j[2, 1] =  -1.0
	j[2, 2] =   0.0
	return j
end

"""
Rosenbrock test function

$(DocumentFunction.documentfunction(rosenbrock;
argtext=Dict("x"=>"argument")))

Returns:

- 
"""
function rosenbrock(x::Vector)
	return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

"""
Rosenbrock test function for LM optimization (returns the 2 components separately)

$(DocumentFunction.documentfunction(rosenbrock_lm;
argtext=Dict("x"=>"argument")))
"""
function rosenbrock_lm(x::Vector)
	[(1.0 - x[1])^2;  100.0 * (x[2] - x[1]^2)^2]
end

"""
Parameter gradients of the Rosenbrock test function

$(DocumentFunction.documentfunction(rosenbrock_gradient!;
argtext=Dict("x"=>"argument",
            "storage"=>"Jacobian vector")))
"""
function rosenbrock_gradient!(x::Vector, storage::Vector)
	storage[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
	storage[2] = 200.0 * (x[2] - x[1]^2)
end

"""
Parameter gradients of the Rosenbrock test function for LM optimization (returns the gradients for the 2 components separately)

$(DocumentFunction.documentfunction(rosenbrock_gradient_lm;
argtext=Dict("x"=>"argument"),
keytext=Dict("dx"=>"[default=`false`]",
            "center"=>"[default=`Array{Float64}(0)`]")))

Returns:

- storage
"""
function rosenbrock_gradient_lm(x::Vector; dx::Bool=false, center=Array{Float64}(0))
	storage = Array{Float64}(2,2)
	storage[1,1] = -2.0 * (1.0 - x[1])
	storage[2,1] = -400.0 * (x[2] - x[1]^2) * x[1]
	storage[1,2] = 0.
	storage[2,2] = 200.0 * (x[2] - x[1]^2)
	return storage
end

"""
Parameter Hessian of the Rosenbrock test function

$(DocumentFunction.documentfunction(rosenbrock_hessian!;
argtext=Dict("x"=>"argument",
            "storage"=>"Hessian matrix")))
"""
function rosenbrock_hessian!(x::Vector, storage::Matrix)
	storage[1, 1] = 2.0 - 400.0 * x[2] + 1200.0 * x[1]^2
	storage[1, 2] = -400.0 * x[1]
	storage[2, 1] = -400.0 * x[1]
	storage[2, 2] = 200.0
end

"""
Make Rosenbrock test function for LM optimization

$(DocumentFunction.documentfunction(makerosenbrock;
argtext=Dict("N"=>"number of observations")))

Returns:

- Rosenbrock test function for LM optimization
"""
function makerosenbrock(N::Integer)
	function rosenbrock_lm(x::Vector)
		result = Array{eltype(x)}(2 * (N - 1))
		for i = 1:N - 1
			result[2 * i - 1] = 1 - x[i]
			result[2 * i] = 10 * (x[i + 1] - x[i] * x[i])
		end
		return result
	end
	return rosenbrock_lm
end

"""
Make parameter gradients of the Rosenbrock test function for LM optimization

$(DocumentFunction.documentfunction(makerosenbrock_gradient;
argtext=Dict("N"=>"number of observations")))

Returns:

- parameter gradients of the Rosenbrock test function for LM optimization
"""
function makerosenbrock_gradient(N::Integer)
	function rosenbrock_gradient_lm(x::Vector; dx::Bool=false, center=Array{Float64}(0))
		result = zeros(eltype(x), (2 * (N - 1), N))
		for i = 1:N - 1
			result[2 * i - 1, i] = -1
			result[2 * i, i] = -20 * x[i]
			result[2 * i, i + 1] = 10
		end
		return result
	end
	return rosenbrock_gradient_lm
end

"""
Make Powell test function for LM optimization

$(DocumentFunction.documentfunction(makepowell;
argtext=Dict("N"=>"number of observations")))

Returns:

- Powell test function for LM optimization
"""
function makepowell(N::Integer)
	function powell(x::Vector)
		result = Array{Float64}(N)
		for i = 1:floor(Int64, 10.0/4)
			result[4*i-3] = x[4*i-3] + 10*x[4*i-2]
			result[4*i-2] = sqrt(5) * (x[4*i-1] - x[4*i])
			result[4*i-1] = (x[4*i-2] - 2*x[4*i-1])^2
			result[4*i]   = sqrt(10) * ( x[4*i-3] - x[4*i])^2
		end
		return result
	end
	return powell
end

"""
ake parameter gradients of the Powell test function for LM optimization

$(DocumentFunction.documentfunction(makepowell_gradient;
argtext=Dict("N"=>"number of observations")))

Returns:

- arameter gradients of the Powell test function for LM optimization
"""
function makepowell_gradient(N::Integer)
	function powell_gradient(x::Vector)
		result = zeros(Float64, N, N)
		for i = 1:floor(Int64, 10.0/4)
			result[4*i-3, 4*i-3] = 1
			result[4*i, 4*i-3]   = 2*sqrt(10)*(x[4*i-3] - x[4*i])

			result[4*i-3, 4*i-2] = 10
			result[4*i-1, 4*i-2] = 2*( x[4*i-2] - 2*x[4*i-1] )

			result[4*i-2, 4*i-1] = sqrt(5)
			result[4*i-1, 4*i-1] = -4*( x[4*i-2] - 2*x[4*i-1] )

			result[4*i-2, 4*i]   = -sqrt(5)
			result[4*i, 4*i]     = -2*sqrt(10)*(x[4*i-3] - x[4*i] )
		end
		return result
	end
	return powell_gradient
end

"""
Make sphere

$(DocumentFunction.documentfunction(makesphere;
argtext=Dict("N"=>"number of observations")))

Returns:

- sphere
"""
function makesphere(N::Integer)
	function sphere(x::Vector)
		result = Array{eltype(x)}(N)
		for i = 1:N
			result[i] = x[i]
		end
		return result
	end
	return sphere
end

"""
Make sphere gradient

$(DocumentFunction.documentfunction(makesphere_gradient;
argtext=Dict("N"=>"number of observations")))

Returns:

- sphere gradient
"""
function makesphere_gradient(N::Integer)
	function sphere_gradient(x::Vector)
		result = zeros(eltype(x), N, N)
		for i=1:N
			result[i, i] = 1
		end
		return result
	end
	return sphere_gradient
end

"""
Make dixon price

$(DocumentFunction.documentfunction(makedixonprice;
argtext=Dict("N"=>"number of observations")))

Returns:

- dixon price
"""
function makedixonprice(N::Integer)
	function dixonprice(x::Vector)
		result = Array{Float64}(N)
		result[1] = x[1] - 1
		for i=2:N
			result[i] = sqrt(i)*(2*x[i]^2 - x[i-1])
		end
		return result
	end
	return dixonprice
end

"""
$(DocumentFunction.documentfunction(makedixonprice;
argtext=Dict("N"=>"number of observations")))

Returns:

- dixon price gradient
"""
function makedixonprice_gradient(N::Integer)
	function dixonprice_gradient(x::Vector)
		result = zeros(Float64, N, N)
		result[1, 1] = sqrt(2)
		for i=2:N
			result[i-1, i] = -sqrt(2*i)
			result[i, i]   = 4*sqrt(2*i)*x[i]
		end
		return result
	end
	return dixonprice_gradient
end

"""
$(DocumentFunction.documentfunction(makesumsquares;
argtext=Dict("N"=>"number of observations")))
"""
function makesumsquares(N::Integer)
	function sumsquares(x::Vector)
		result = Array{Float64}(N)
		for i=1:N
			result[i] = sqrt(i)*x[i]
		end
		return result
	end
	return sumsquares
end

"""
$(DocumentFunction.documentfunction(makesumsquares_gradient;
argtext=Dict("N"=>"number of observations")))
"""
function makesumsquares_gradient(N::Integer)
	function sumsquares_gradient(x::Vector)
		result = zeros(Float64, N, N)
		for i=1:N
			result[i, i] = sqrt(2*i)
		end
		return result
	end
	return sumsquares_gradient
end

"""
$(DocumentFunction.documentfunction(makerotatedhyperellipsoid;
argtext=Dict("N"=>"number of observations")))
"""
function makerotatedhyperellipsoid(N::Integer)
	function rotatedhyperellipsoid(x::Vector)
		result = Array{Float64}(N)
		result[1] = x[1]
		for i =2:N
			sum = 0
			for j = 1:i
				sum += x[j]^2
			end
			result[i] = sqrt(sum)
		end
		return result
	end
	return rotatedhyperellipsoid
end

"""
$(DocumentFunction.documentfunction(makerotatedhyperellipsoid_gradient;
argtext=Dict("N"=>"number of observations")))
"""
function makerotatedhyperellipsoid_gradient(N::Integer)
	function rotatedhyperellipsoid_gradient(x::Vector)
		result = zeros(Float64, N, N)
		result[1, 1] = sqrt(2)
		for i = 2:N
			sum = 0
			for j = 1:i
				sum += x[j]^2
			end
			for j = 1:i
				result[j, i] = sqrt(2)*x[j]*sum^(-0.5)
			end
		end
		return result
	end
	return rotatedhyperellipsoid_gradient
end
