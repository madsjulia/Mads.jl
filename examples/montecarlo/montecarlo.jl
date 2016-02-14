import Mads

info("Monte Carlo analysis ...")
md = Mads.loadmadsfile("internal-linearmodel.mads")
results = Mads.montecarlo(md; N=10)
for i in 1:length(results)
	display(results[i])
end
