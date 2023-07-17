import Mads

@info("Monte Carlo analysis ...")
workdir = Mads.getproblemdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.dir, "examples", "montecarlo")
end
md = Mads.loadmadsfile(joinpath(workdir, "internal-linearmodel.mads"))
results = Mads.montecarlo(md; N=10)
for i = eachindex(results)
	display(results[i])
end
