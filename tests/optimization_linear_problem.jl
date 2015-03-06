using Mads

println("TEST Levenberg-Marquardt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
results = Mads.calibrate(mdinternal)
println(results)