function rosenbrock(x::Vector)
	return (1.0 - x[1])^2 + 100.0 * (x[2] - x[1]^2)^2
end

function rosenbrock_lm(x::Vector)
	[(1.0 - x[1])^2;  100.0 * (x[2] - x[1]^2)^2]
end

function rosenbrock_gradient!(x::Vector, storage::Vector)
	storage[1] = -2.0 * (1.0 - x[1]) - 400.0 * (x[2] - x[1]^2) * x[1]
	storage[2] = 200.0 * (x[2] - x[1]^2)
end

function rosenbrock_gradient_lm(x::Vector)
	storage = Array(Float64,2,2)
	storage[1,1] = -2.0 * (1.0 - x[1])
	storage[2,1] = -400.0 * (x[2] - x[1]^2) * x[1]
	storage[1,2] = 0.
	storage[2,2] = 200.0 * (x[2] - x[1]^2)
	return storage
end

function rosenbrock_hessian!(x::Vector, storage::Matrix)
	storage[1, 1] = 2.0 - 400.0 * x[2] + 1200.0 * x[1]^2
	storage[1, 2] = -400.0 * x[1]
	storage[2, 1] = -400.0 * x[1]
	storage[2, 2] = 200.0
end

function makerosenbrock(N)
	function rosenbrock_lm(x::Vector)
		result = Array(eltype(x), 2 * (N - 1))
		for i = 1:N - 1
			result[2 * i - 1] = 1 - x[i]
			result[2 * i] = 10 * (x[i + 1] - x[i] * x[i])
		end
		return result
	end
	return rosenbrock_lm
end

function makerosenbrock_gradient(N)
	function rosenbrock_gradient_lm(x::Vector)
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
