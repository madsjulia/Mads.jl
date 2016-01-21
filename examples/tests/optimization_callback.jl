using Mads
using Optim
using Logging
using Base.Test

Logging.configure(level=DEBUG)

f = Mads.rosenbrock
g! = Mads.rosenbrock_gradient!
h! = Mads.rosenbrock_hessian!

callbacksucceeded = false
function callback(x_best)
	global callbacksucceeded
	callbacksucceeded = true
	println("The callback function was called: $x_best")
end

Mads.madsinfo("TEST Levenberg-Marquardt optimization in Optim module of the Rosenbrock function without sine transformation:")
results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0]; show_trace=false, callback=callback)
@test callbacksucceeded
