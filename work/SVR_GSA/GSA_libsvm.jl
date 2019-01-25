using Distributed

Distributed.addprocs()
@everywhere import Mads
@everywhere Mads.setdir()
@everywhere md = Mads.loadmadsfile("w01.mads")
r = Mads.efast(md; N=240, M=6, gamma=4, seed = 2016)
Mads.setobstime!(md, r"o([0-9,.]+)")
Mads.plotobsSAresults(md, r, format="PNG")