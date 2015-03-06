using Mads
using Optim

f = Mads.rosenbrock
g! = Mads.rosenbrock_gradient!
h! = Mads.rosenbrock_hessian!

# internal opimization test
println("TEST Nelder-Mead optimization (default) of the Rosenbrock function:")
results = optimize(f, [0.0, 0.0])
println(results)
println("TEST Levenberg-Marquardt optimization of the Rosenbrock function without sine transformation:")
results = Optim.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
println(results)

lowerbounds = [-2, -2]
upperbounds = [2, 2]
sin_rosenbrock_lm = Mads.sinetransformfunction(Mads.rosenbrock_lm, lowerbounds, upperbounds)
sin_rosenbrock_gradient_lm = Mads.sinetransformgradient(Mads.rosenbrock_gradient_lm, lowerbounds, upperbounds)

println("TEST sine transformation:")
a = Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ", a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ",a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([-2.0,-2.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ", a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = sin_rosenbrock_lm(Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds))
println("TEST Parameter transformation in a function: ", a,"=", Mads.rosenbrock_lm([2.0,2.0]))
a = sin_rosenbrock_lm(Mads.asinetransform([1.0,1.0], lowerbounds, upperbounds))
println("TEST Parameter transformation in a function: ", a,"=", Mads.rosenbrock_lm([1.0,1.0]))

# internal opimization test
println("TEST Levenberg-Marquardt optimization of the Rosenbrock function with sine transformation:")
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds), show_trace=false)
println(results)
println(Mads.sinetransform(results.minimum, lowerbounds, upperbounds))
