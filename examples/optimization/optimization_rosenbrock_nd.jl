using Mads
ndim = 200
results = Mads.LevenbergMarquardt(Mads.makerosenbrock(ndim), Mads.makerosenbrock_gradient(ndim), zeros(ndim), lambda_mu=2.0, np_lambda=10, show_trace=false, maxJacobians=1000)
println(results)
