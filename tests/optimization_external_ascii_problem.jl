using Mads

# external execution test using ASCII files
println("TEST Levenberg-Marquardt optimization of an external call problem using ASCII files:")
mdexternal = Mads.loadyamlmadsfile("test-external-ascii.mads")
results = Mads.calibrate(mdexternal)
println(results)
