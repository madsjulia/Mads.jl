using Mads

problemdir = Mads.getmadsdir()

Mads.madsinfo("TEST Saltelli Monte-Carlo senstivity analysis: Sobol test:")
mdsobol = Mads.loadmadsfile(problemdir * "test-sobol.mads")
results = Mads.saltelli(mdsobol, N=5000, seed=2015)
Mads.printSAresults(mdsobol, results)

Mads.madsinfo("TEST Saltelli eFAST senstivity analysis: Sobol test:")
results = Mads.efast(mdsobol, N=385, seed=2015) # in this case 385 model runs is the smallest possible
Mads.printSAresults(mdsobol, results)

Mads.madsinfo("TEST Saltelli Monte-Carlo senstivity analysis: Linear problem:")
mdsaltelli = Mads.loadmadsfile(problemdir * "test-saltelli.mads")
results = Mads.saltelli(mdsaltelli, N=5000, seed=2015) # Fast
Mads.printSAresults(mdsaltelli, results)

Mads.madsinfo("TEST Saltelli eFAST senstivity analysis: Linear problem:")
results = Mads.efast(mdsaltelli, N=385, seed=2015) # in this case 385 model runs is the smallest possible
Mads.printSAresults(mdsaltelli, results)

# Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Sobol test:") # TODO Brute force needs to be fixed
# mdsobol = Mads.loadmadsfile(problemdir * "test-sobol.mads")
#results = Mads.saltellibrute(mdsobol) # Slow
#Mads.printSAresults(mdsobol,results)

# Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Linear problem:")
# mdsaltelli = Mads.loadmadsfile(problemdir * "test-saltelli.mads")
#results = Mads.saltellibrute(mdsaltelli) # Slow
#Mads.printSAresults(mdsaltelli,results)
