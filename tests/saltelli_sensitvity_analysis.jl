using Mads

problemdir = Mads.getmadsdir()
Mads.madsinfo("TEST Saltelli senstivity analysis: Sobol test:")
mdsobol = Mads.loadyamlmadsfile(problemdir * "test-sobol.mads")
results = Mads.saltelli(mdsobol, N=int(5000), seed=2015)
Mads.printSAresults(mdsobol, results)
Mads.madsinfo("TEST Saltelli senstivity analysis: Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile(problemdir * "test-saltelli.mads")
results = Mads.saltelli(mdsaltelli, seed=2015) # Fast
Mads.printSAresults(mdsaltelli, results)
# Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Sobol test:") # TODO Brute force needs to be fixed
# mdsobol = Mads.loadyamlmadsfile(problemdir * "test-sobol.mads")
#results = Mads.saltellibrute(mdsobol) # Slow
#Mads.saltelliprintresults2(mdsobol,results)
# Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Linear problem:")
# mdsaltelli = Mads.loadyamlmadsfile(problemdir * "test-saltelli.mads")
#results = Mads.saltellibrute(mdsaltelli) # Slow
#Mads.saltelliprintresults2(mdsaltelli,results)
