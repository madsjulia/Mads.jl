import Mads
using Lora 

md = Mads.loadyamlmadsfile("w01.mads")
chain = Mads.bayessampling(md; nsteps=int(1e4), burnin=int(1e3))
describe(chain)
