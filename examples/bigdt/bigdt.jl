import Mads

problemdir = Mads.getmadsdir()
md = Mads.loadyamlmadsfile(problemdir * "source_termination.mads")
Mads.plotmadsproblem(md)
nsample = 1000
bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, bigdtresults; filename="source_termination-robustness-$nsample", format="PDF")
