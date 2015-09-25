using Mads

Mads.quieton()

mdsobol = Mads.loadyamlmadsfile("../tests/test-sobol.mads")
results = Mads.efast(mdsobol, N=385, seed=2015)

Mads.quietoff()