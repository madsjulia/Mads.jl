using Mads

problemdir = Mads.getmadsdir()

info("Saltelli Monte-Carlo sensitivity analysis: Sobol test ...")
mdsobol = Mads.loadmadsfile(problemdir * "sobol.mads")
results = Mads.saltelli(mdsobol, N=5000, seed=2015)
Mads.printSAresults(mdsobol, results)

info("Saltelli eFAST sensitivity analysis: Sobol test ...")
results = Mads.efast(mdsobol, N=385, seed=2015) # in this case 385 model runs is the smallest possible
Mads.printSAresults(mdsobol, results)

info("Saltelli Monte-Carlo sensitivity analysis: Linear problem ...")
mdsaltelli = Mads.loadmadsfile(problemdir * "saltelli.mads")
results = Mads.saltelli(mdsaltelli, N=5000, seed=2015) # Fast
Mads.printSAresults(mdsaltelli, results)

info("Saltelli eFAST sensitivity analysis: Linear problem ...")
results = Mads.efast(mdsaltelli, N=385, seed=2015) # in this case 385 model runs is the smallest possible
Mads.printSAresults(mdsaltelli, results)

# Mads.madsinfo("Saltelli senstivity analysis (brute force): Sobol test:") # TODO Brute force needs to be fixed
# mdsobol = Mads.loadmadsfile(problemdir * "sobol.mads")
# results = Mads.saltellibrute(mdsobol) # Slow
# Mads.printSAresults(mdsobol, results)

# Mads.madsinfo("Saltelli senstivity analysis (brute force): Linear problem:")
# mdsaltelli = Mads.loadmadsfile(problemdir * "saltelli.mads")
# results = Mads.saltellibrute(mdsaltelli) # Slow
# Mads.printSAresults(mdsaltelli, results)
