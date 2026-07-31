import Mads

function run_source_termination(; nsample::Int=1000, problemdir::String=@__DIR__, outputdir::String=problemdir)::AbstractDict
	md::AbstractDict = Mads.loadmadsfile(joinpath(problemdir, "source_termination.mads"))
	bigdtresults::AbstractDict = Mads.bigdt(md, nsample; maxHorizon=0.8, numlikelihoods=5)
	robustness_root::String = joinpath(outputdir, "source_termination-robustness-$(nsample)")
	robustness_zoom_root::String = joinpath(outputdir, "source_termination-robustness-zoom-$(nsample)")
	Mads.plotrobustnesscurves(md, bigdtresults; filename=robustness_root)
	Mads.plotrobustnesscurves(md, bigdtresults; filename=robustness_root, format="PNG", maxprob=0.1)
	Mads.plotrobustnesscurves(md, bigdtresults; filename=robustness_zoom_root, format="PNG", maxhoriz=0.4, maxprob=0.1)
	return bigdtresults
end

if abspath(PROGRAM_FILE) == @__FILE__
	run_source_termination()
end
