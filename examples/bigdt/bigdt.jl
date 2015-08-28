import Mads

problemdir = string((dirname(Base.source_path())))*"/"
Mads.madsinfo("Problem directory: $(problemdir)")

md = Mads.loadyamlmadsfile(problemdir * "w01.mads")
maxfailureprobs, horizons = Mads.dobigdt(md, 100; hakunamatata=0.8, numlikelihoods=5)
Mads.plotrobustnesscurves(md, maxfailureprobs, horizons, "robustness.svg")
# mcvalues = Mads.paramarray2dict(md, chain.samples) # convert the parameters in the chain samples to a parameter dictionary of arrays
# Mads.spaghettiplot(md, mcvalues) #TODO work with Wells class
