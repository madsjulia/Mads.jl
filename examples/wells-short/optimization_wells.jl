using Mads

println("TEST Levenberg-Marquardt optimization of an external call problem using wells:")
mdwells = Mads.loadyamlmadsfile("w01.mads")
results = Mads.calibrate(mdwells)
println(results)
