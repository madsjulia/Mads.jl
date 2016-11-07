import Mads

problemdir = Mads.getmadsdir()
if isdefined(:yaml)
	md = Mads.loadmadsfile(problemdir * "source_termination.mads")
else
	md = Mads.loadmadsfile(problemdir * "source_termination_json.mads", format="json")
end
nsample = 10
bigdtresults = Mads.dobigdt(md, nsample; maxHorizon=0.8, numlikelihoods=2)
if isdefined(:Gadfly)
	f = problemdir * "source_termination-robustness-$nsample"
	Mads.plotrobustnesscurves(md, bigdtresults; filename=f)
	run(`bash -c "rm -f $(f).*"`)
end