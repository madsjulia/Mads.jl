import Mads
import Gadfly
md = Mads.loadmadsfile(joinpath("models", "internal-polynomial.mads"))

Mads.mkdir("bayes_results")

Mads.setobsweights!(md, 10)
mcmcchain = Mads.bayessampling(md; nsteps=1000000, burnin=1000, thinning=1000, seed=2016)
Mads.scatterplotsamples(md, mcmcchain.value', joinpath("bayes_results", "bayes_scatter.png"))
Mads.display(joinpath("bayes_results", "bayes_scatter.png")
o = Mads.forward(md, mcmcchain.value)
Mads.spaghettiplot(md, o, filename=joinpath("bayes_results" "bayes_spaghetti.png"))
Mads.display(joinpath("bayes_results", "bayes_spaghetti.png"))