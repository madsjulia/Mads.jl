import Mads
import Test

using Distributed

callbacksucceeded = false
@Mads.stderrcapture function callback(x_best::Vector, of::Number, lambda::Number)
	global callbacksucceeded
	callbacksucceeded = true
	# println("The callback function was called: $x_best, $of, $lambda")
end

Mads.madsinfo("Levenberg-Marquardt optimization of the Rosenbrock function with callback")
results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0]; show_trace=false, callbackiteration=callback)
@Test.test callbacksucceeded
