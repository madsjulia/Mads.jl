import Mads
import Base.Test

if VERSION >= v"0.7"
	using Distributed
end

@Mads.stderrcapture fopt(x) = [x[1], 2.0 - x[2]]
@Mads.stderrcapture gopt(x) = [1.0 0.0; 0.0 -1.0]

results = Mads.naive_levenberg_marquardt(fopt, gopt, [100.0, 100.0])
@Base.Test.test norm(results.minimizer - [0.0, 2.0]) < 0.01

results = Mads.levenberg_marquardt(fopt, gopt, [100.0, 100.0])
@Base.Test.test norm(results.minimizer - [0.0, 2.0]) < 0.01

results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [-1.2, 1.0], tolOF=1e-24)
@Base.Test.test norm(results.minimizer - [1.0, 1.0]) < 0.01

# needs smaller tolerance to work
results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], np_lambda=4, tolX=1e-8, tolG=1e-12)
@Base.Test.test norm(results.minimizer - [1.0, 1.0]) < 0.01

# needs even smaller tolerance to work
results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], tolX=1e-12, tolG=1e-12)
@Base.Test.test norm(results.minimizer - [1.0, 1.0]) < 0.01

return
