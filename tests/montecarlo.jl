import Mads

println("TEST Monte Carlo on an external call problem:")
md = Mads.loadyamlmadsfile("test-external-ascii.mads")
#Mads.setdynamicmodel(md, f)
results = Mads.montecarlo(md; N=10)
println(results)
