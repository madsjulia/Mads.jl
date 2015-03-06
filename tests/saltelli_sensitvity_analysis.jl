using Mads

# Saltelli senstivity analysis tests
println("TEST Saltelli senstivity analysis: Sobol test:")
mdsobol = Mads.loadyamlmadsfile("tests/test-sobol.mads")
results = Mads.saltelli(mdsobol,N=int(1e4))
Mads.saltelliprintresults(mdsobol,results)
println("TEST Saltelli senstivity analysis: Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltelli(mdsaltelli) # Fast
Mads.saltelliprintresults(mdsaltelli,results)
println("TEST Saltelli senstivity analysis (brute force): Sobol test:")
mdsobol = Mads.loadyamlmadsfile("tests/test-sobol.mads")
results = Mads.saltellibrute(mdsobol) # Slow
Mads.saltelliprintresults2(mdsobol,results)
println("TEST Saltelli senstivity analysis (brute force): Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltellibrute(mdsaltelli) # Slow
Mads.saltelliprintresults2(mdsaltelli,results)
