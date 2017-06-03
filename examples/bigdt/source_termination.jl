import Mads

problemdir = Mads.getmadsdir()
md = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"))
nsample = 1000
bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination-robustness-$nsample"))
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination-robustness-$nsample"), format="PNG", maxprob=0.1)
Mads.plotrobustnesscurves(md, bigdtresults; filename=joinpath(problemdir, "source_termination-robustness-zoom-$nsample"), maxhoriz=0.4, maxprob=0.1)
