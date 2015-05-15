using Mads

# Saltelli senstivity analysis tests
Mads.madsinfo("TEST Parallel saltelli senstivity analysis: Sobol test:")
mdsobol = Mads.loadyamlmadsfile("tests/test-sobol.mads")
results = Mads.saltelliparallel(mdsobol,N=int(1e4),2)
Mads.saltelliprintresults(mdsobol,results)
Mads.madsinfo("TEST Parallel saltelli senstivity analysis: Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltelliparallel(mdsaltelli,2) # Fast
Mads.saltelliprintresults(mdsaltelli,results)
Mads.madsinfo("TEST Parallel saltelli senstivity analysis (brute force): Sobol test:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltellibruteparallel(mdsobol,2) # Slow
Mads.saltelliprintresults2(mdsobol,results)
Mads.madsinfo("TEST Parallel saltelli senstivity analysis (brute force): Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltellibruteparallel(mdsaltelli,2) # Slow
Mads.saltelliprintresults2(mdsaltelli,results)
