using Optim
using Mads

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

f = rosenbrock
g! = rosenbrock_gradient!
h! = rosenbrock_hessian!

optimize(f, [0.0, 0.0])
results = Optim.levenberg_marquardt(rosenbrock_lm, rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
println(results)

lowerbounds = [-2, -2]
# upperbounds = [.5, .5]
upperbounds = [2, 2]
sin_rosenbrock_lm = Mads.sinetransformfunction(rosenbrock_lm, lowerbounds, upperbounds)
sin_rosenbrock_gradient_lm = Mads.sinetransformgradient(rosenbrock_gradient_lm, lowerbounds, upperbounds)
a = Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds)
println(a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds)
println(a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([-2.0,-2.0], lowerbounds, upperbounds)
println(a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = sin_rosenbrock_lm(Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds))
println(a,"=",rosenbrock_lm([2.0,2.0]))
a = sin_rosenbrock_lm(Mads.asinetransform([1.0,1.0], lowerbounds, upperbounds))
println(a,"=",rosenbrock_lm([1.0,1.0]))
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds), show_trace=false)
println(results)
println(Mads.sinetransform(results.minimum, lowerbounds, upperbounds))

md = Mads.loadmadsfile("test.mads")
results = Mads.calibrate(md)
println(results)
