import Mads

problemdir = Mads.getmadsdir()
md = Mads.loadyamlmadsfile(problemdir * "source_termination.mads")
Mads.plotmadsproblem(md)
bigdtresults = Mads.dobigdt(md, 100; maxHorizon=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, bigdtresults; format="PDF")
