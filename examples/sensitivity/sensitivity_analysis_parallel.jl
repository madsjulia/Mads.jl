using Mads
using Base.Test

problemdir = Mads.getmadsdir()

info("Parallel Saltelli sensitivity analysis: Sobol test ...")
mdsobol = Mads.loadmadsfile(problemdir * "sobol.mads")
results = Mads.saltelliparallel(mdsobol, N=500, 2)
Mads.printSAresults(mdsobol, results)

info("Parallel Saltelli sensitivity analysis: Linear problem ...")
mdsaltelli = Mads.loadmadsfile(problemdir * "saltelli.mads")
results = Mads.saltelliparallel(mdsaltelli, N=500, 2)
Mads.printSAresults(mdsaltelli, results)

rm("saltellirestart", recursive=true)
results1 = Mads.saltelliparallel(mdsaltelli, 2; N=500, restartdir="saltellirestart")
results2 = Mads.saltelliparallel(mdsaltelli, 2; N=500, restartdir="saltellirestart")
@test results1 == results2
# Mads.madsinfo("Parallel Saltelli sensitivity analysis (brute force): Sobol test:") # TODO Brute force needs to be fixed
# mdsobol = Mads.loadmadsfile("sobol.mads")
# results = Mads.saltellibruteparallel(mdsobol, 2) # Slow
# Mads.saltelliprintresults2(mdsobol, results)

# Mads.madsinfo("Parallel Saltelli sensitivity analysis (brute force): Linear problem:")
# mdsaltelli = Mads.loadmadsfile("saltelli.mads")
# results = Mads.saltellibruteparallel(mdsaltelli,2) # Slow
# Mads.saltelliprintresults2(mdsaltelli, results)
