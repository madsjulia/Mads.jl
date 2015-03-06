using Mads

println("TEST Levenberg-Marquardt optimization of an external problem using YAML files:")
mdexternal = Mads.loadyamlmadsfile("test-external-yaml.mads")
results = Mads.calibrate(mdexternal)
println(results)
