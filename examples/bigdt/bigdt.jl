import Mads

problemdir = Mads.getmadsdir()
md = Mads.loadyamlmadsfile(problemdir * "source_termination.mads")
Mads.plotmadsproblem(md)
bigdtresults = Mads.dobigdt(md, 100; maxHorizon=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, bigdtresults)
# mcvalues = Mads.paramarray2dict(md, chain.samples) # convert the parameters in the chain samples to a parameter dictionary of arrays
# Mads.spaghettiplot(md, mcvalues) #TODO work with Wells class
