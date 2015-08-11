import Mads
import Lora 

md = Mads.loadyamlmadsfile("w01.mads")
chain = Mads.bayessampling(md; nsteps=int(1e5), burnin=int(1e4), thinning=100)
Lora.describe(chain)
Mads.scatterplotsamples(chain.samples, Mads.getoptparamkeys(md), "results.svg")
