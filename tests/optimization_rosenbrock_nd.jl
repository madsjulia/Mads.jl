using Mads
ndim = 2000
results = Mads.levenberg_marquardt(Mads.makerosenbrock(ndim), Mads.makerosenbrock_gradient(ndim), zeros(ndim), lambda_mu=2.0, np_lambda=10, show_trace=false, maxIter=1000)
println(results)
