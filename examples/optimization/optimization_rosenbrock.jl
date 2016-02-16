import Mads
using Base.Test

f = Mads.rosenbrock
g! = Mads.rosenbrock_gradient!
h! = Mads.rosenbrock_hessian!

info("Optimization of Rosenbrock function ...")

info("Nelder-Mead optimization (default) of the Rosenbrock function ...")
results = Optim.optimize(f, [0.0, 0.0])

info("Levenberg-Marquardt optimization in Optim module of the Rosenbrock function without sine transformation:")
results = Optim.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
Mads.madsoutput("""$results\n""")

info("Sine transformation of parameter space ...")
indexlogtransformed = []
lowerbounds = [-2.0, -2.0]
upperbounds = [2.0, 2.0]
sin_rosenbrock_lm = Mads.sinetransformfunction(Mads.rosenbrock_lm, lowerbounds, upperbounds, indexlogtransformed)
sin_rosenbrock_gradient_lm = Mads.sinetransformgradient(Mads.rosenbrock_gradient_lm, lowerbounds, upperbounds, indexlogtransformed)
Mads.madsoutput("TEST sine transformation:")
a = Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsoutput("TEST Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsoutput("TEST Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = Mads.asinetransform([-2.0,-2.0], lowerbounds, upperbounds, indexlogtransformed)
Mads.madsoutput("TEST Parameter transformation: $a -> $Mads.sinetransform(a, lowerbounds, upperbounds)\n")
a = sin_rosenbrock_lm(Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds, indexlogtransformed))
Mads.madsoutput("TEST Parameter transformation in a function: $a = $Mads.rosenbrock_lm([2.0,2.0])\n")
a = sin_rosenbrock_lm(Mads.asinetransform([1.0,1.0], lowerbounds, upperbounds, indexlogtransformed))
Mads.madsoutput("TEST Parameter transformation in a function: $a = $Mads.rosenbrock_lm([1.0,1.0])\n")

info("Levenberg-Marquardt optimization in Optim module of the Rosenbrock function with sine transformation:")
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds, indexlogtransformed), show_trace=false)
Mads.madsoutput("""$results\n""")
Mads.madsoutput(" * Minimum back transformed: $Mads.sinetransform(results.minimum, lowerbounds, upperbounds)\n")

info("MADS Levenberg-Marquardt optimization of the Rosenbrock function without sine transformation:")
results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], lambda_mu=2.0, np_lambda=10, show_trace=false)
Mads.madsoutput("""$results\n""")
