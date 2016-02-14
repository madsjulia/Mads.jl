using Mads

info("Parallel Saltelli sensitivity analysis: Sobol test ...")
mdsobol = Mads.loadmadsfile("sobol.mads")
results = Mads.saltelliparallel(mdsobol, N=500, 2)
Mads.printSAresults(mdsobol, results)

info("Parallel Saltelli sensitivity analysis: Linear problem ...")
mdsaltelli = Mads.loadmadsfile("saltelli.mads")
results = Mads.saltelliparallel(mdsaltelli, N=500, 2)
Mads.printSAresults(mdsaltelli, results)

# Mads.madsinfo("Parallel Saltelli sensitivity analysis (brute force): Sobol test:") # TODO Brute force needs to be fixed
# mdsobol = Mads.loadmadsfile("sobol.mads")
# results = Mads.saltellibruteparallel(mdsobol, 2) # Slow
# Mads.saltelliprintresults2(mdsobol, results)

# Mads.madsinfo("Parallel Saltelli sensitivity analysis (brute force): Linear problem:")
# mdsaltelli = Mads.loadmadsfile("saltelli.mads")
# results = Mads.saltellibruteparallel(mdsaltelli,2) # Slow
# Mads.saltelliprintresults2(mdsaltelli, results)
