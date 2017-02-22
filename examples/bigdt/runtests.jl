import Mads

problemdir = Mads.getmadsdir()
if isdefined(:yaml)
	md = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"))
else
	md = Mads.loadmadsfile(joinpath(problemdir, "source_termination_json.mads"), format="json")
end
nsample = 10
bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=2)
if isdefined(:Gadfly)
	f = joinpath(problemdir, "source_termination-robustness-$nsample")
	Mads.plotrobustnesscurves(md, bigdtresults; filename=f)
	Mads.rmfiles_root(f)
end