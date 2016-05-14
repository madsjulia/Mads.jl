import Mads

Mads.madsinfo("Monte Carlo analysis ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == ""
	workdir = Mads.madsdir * "/../examples/montecarlo/"
end
md = Mads.loadmadsfile(workdir * "internal-linearmodel.mads")
results = Mads.montecarlo(md; N=10)

return