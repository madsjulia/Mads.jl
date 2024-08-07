import Mads

problemdir = Mads.getproblemdir()
md = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"))
nsample = 1000
bigdtresults = Mads.bigdt(md, nsample; maxHorizon=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination_robustness_$(nsample)"))
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination_robustness_$(nsample)"), format="PNG", maxprob=0.1)
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination_robustness_zoom$(nsample)"), maxhoriz=0.4, maxprob=0.1)
