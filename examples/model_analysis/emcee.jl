import Mads

md = Mads.loadmadsfile(joinpath("models", "internal-polynomial.mads"))

Mads.mkdir("emcee_results")

Mads.setobsweights!(md, 10)
chain, llhoods = Mads.emceesampling(md; numwalkers=100, nsteps=1000000, burnin=100000, thinning=100, seed=2016, sigma=0.01)
Mads.scatterplotsamples(md, chain', joinpath("emcee_results", "emcee_scatter.png"))
o = Mads.forward(md, chain')
Mads.spaghettiplot(md, o, filename=joinpath("emcee_results", "emcee_spaghetti.png"))
