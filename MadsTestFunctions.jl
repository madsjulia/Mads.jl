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