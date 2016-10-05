import Mads

md = Mads.loadmadsfile("models/internal-polynomial.mads")

if !isdir("emcee_results")
	mkdir("emcee_results")
end

chain, llhoods = Mads.emcee(md; numwalkers=nworkers()+1, nsteps=10000, burnin=1000, thinning=100, seed=2016, sigma=0.01)
Mads.scatterplotsamples(md, chain', "emcee_results/emcee_scatter.png")
o = Mads.forward(md, chain')
Mads.spaghettiplot(md, o, filename="emcee_results/emcee_spaghetti.png")
