using Mads
using Base.Test

@everywhere fopt(x) = [x[1], 2.0 - x[2]]
@everywhere gopt(x) = [1.0 0.0; 0.0 -1.0]

results = Mads.naive_levenberg_marquardt(fopt, gopt, [100.0, 100.0])
@test norm(results.minimum - [0.0, 2.0]) < 0.01

results = Mads.levenberg_marquardt(fopt, gopt, [100.0, 100.0])
@test norm(results.minimum - [0.0, 2.0]) < 0.01

results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [-1.2, 1.0], tolOF=1e-24)
@test norm(results.minimum - [1.0, 1.0]) < 0.01

# needs smaller tolerance to work
results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], np_lambda=4, tolX=1e-8, tolG=1e-12)
@test norm(results.minimum - [1.0, 1.0]) < 0.01

# needs even smaller tolerance to work
results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], tolX=1e-12, tolG=1e-12)
@test norm(results.minimum - [1.0, 1.0]) < 0.01

return
