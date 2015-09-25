using Mads

f(x) = [x[1], 2.0 - x[2]]
g(x) = [1.0 0.0; 0.0 -1.0]

results = Mads.levenberg_marquardt(f, g, [100.0, 100.0], quiet=true)
@test norm(results.minimum - [0.0, 2.0]) < 0.01

results = Mads.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [-1.2, 1.0], quiet=true)
@test norm(results.minimum - [1.0, 1.0]) < 0.01

results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], quiet=true, np_lambda=4, tolX=1e-8, tolG=1e-12)
@test norm(results.minimum - [1.0, 1.0]) < 0.01

results = Mads.levenberg_marquardt(Mads.rosenbrock2_lm, Mads.rosenbrock2_gradient_lm, [-1.2, 1.0], quiet=true, tolX=1e-12, tolG=1e-12)
@test norm(results.minimum - [1.0, 1.0]) < 0.01