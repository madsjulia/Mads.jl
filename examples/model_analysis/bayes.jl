import Mads
import Gadfly
md = Mads.loadmadsfile("models/internal-polynomial.mads")

Mads.mkdir("bayes_results")

Mads.setobsweights!(md, 10)
mcmcchain = Mads.bayessampling(md; nsteps=1000000, burnin=1000, thinning=1000, seed=2016)
Mads.scatterplotsamples(md, mcmcchain.value', "bayes_results/bayes_scatter.png")
Mads.display("bayes_results/bayes_scatter.png")
o = Mads.forward(md, mcmcchain.value)
Mads.spaghettiplot(md, o, filename="bayes_results/bayes_spaghetti.png")
Mads.display("bayes_results/bayes_spaghetti.png")