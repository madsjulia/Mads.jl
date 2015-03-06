using Mads
using Gadfly

# Bayesian sampling test
println("TEST Bayesian sampling:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
mcmcchain = Mads.bayessampling(mdinternal)
plot(x=mcmcchain.samples[:,1], y=mcmcchain.samples[:,2])
