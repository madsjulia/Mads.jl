using Optim

include("tests.jl")

f = rosenbrock
g! = rosenbrock_gradient!
h! = rosenbrock_hessian!

optimize(f, [0.0, 0.0])
results = Optim.levenberg_marquardt(rosenbrock_lm, rosenbrock_gradient_lm, [0.0, 0.0], show_trace=true)
println(results)
