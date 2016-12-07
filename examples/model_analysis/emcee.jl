import Mads

md = Mads.loadmadsfile("models/internal-polynomial.mads")

if !isdir("emcee_results")
	mkdir("emcee_results")
end

Mads.setobsweights!(md, 10)
chain, llhoods = Mads.emceesampling(md; numwalkers=100, nsteps=1000000, burnin=100000, thinning=100, seed=2016, sigma=0.01)
Mads.scatterplotsamples(md, chain', "emcee_results/emcee_scatter.png")
o = Mads.forward(md, chain')
Mads.spaghettiplot(md, o, filename="emcee_results/emcee_spaghetti.png")
