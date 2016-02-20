import Mads

problemdir = Mads.getmadsdir()
md = Mads.loadmadsfile(problemdir * "source_termination.mads")
nsample = 10
bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=2)
Mads.plotrobustnesscurves(md, bigdtresults; filename=problemdir * "source_termination-robustness-$nsample")