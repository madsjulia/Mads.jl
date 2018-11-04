import Mads
import Optim
import LsqFit
import Test

@everywhere fr = Mads.rosenbrock
@everywhere g! = Mads.rosenbrock_gradient!
@everywhere h! = Mads.rosenbrock_hessian!

Mads.madsinfo("Optimization of Rosenbrock function ...")

# Mads.madsinfo("Nelder-Mead optimization (default) of the Rosenbrock function ...")
# results = Optim.optimize(fr, [0.0, 0.0])

# Mads.madsinfo("Levenberg-Marquardt optimization in LsqFit module of the Rosenbrock function without sine transformation:")
# results = LsqFit..LevenbergMarquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)

Mads.madsinfo("Sine transformation of parameter space ...")
indexlogtransformed = []
lowerbounds = [-2.0, -2.0]
upperbounds = [2.0, 2.0]
sin_rosenbrock_lm = Mads.sinetransformfunction(Mads.rosenbrock_lm, lowerbounds, upperbounds, indexlogtransformed)
sin_rosenbrock_gradient_lm = Mads.sinetransformgradient(Mads.rosenbrock_gradient_lm, lowerbounds, upperbounds, indexlogtransformed)
Mads.madsinfo("Sine transformation:")
a = Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsinfo("Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsinfo("Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = Mads.asinetransform([-2.0,-2.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsinfo("Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = sin_rosenbrock_lm(Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds, indexlogtransformed))
Mads.madsinfo("Parameter transformation in a function: $a = $Mads.rosenbrock_lm([2.0,2.0])\n")
a = sin_rosenbrock_lm(Mads.asinetransform([1.0,1.0], lowerbounds, upperbounds, indexlogtransformed))
Mads.madsinfo("Parameter transformation in a function: $a = $Mads.rosenbrock_lm([1.0,1.0])\n")

# Mads.madsinfo("Levenberg-Marquardt optimization in Optim module of the Rosenbrock function with sine transformation:")
# results = Optim.LevenbergMarquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds, indexlogtransformed), show_trace=false)
# Mads.madsinfo("Minimum back transformed: $Mads.sinetransform(results.minimum, lowerbounds, upperbounds)\n")

Mads.madsinfo("MADS Levenberg-Marquardt optimization of the Rosenbrock function without sine transformation:")
results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], lambda_mu=2.0, np_lambda=10, show_trace=false)
return