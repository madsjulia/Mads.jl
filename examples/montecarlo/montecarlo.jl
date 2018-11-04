import Mads

@info("Monte Carlo analysis ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "montecarlo")
end
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
results = Mads.montecarlo(md; N=10)
for i in 1:length(results)
	display(results[i])
end
