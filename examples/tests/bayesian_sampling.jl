using Mads

# Bayesian sampling test
Mads.madsinfo("TEST Bayesian sampling with internal model:")
mdinternal = Mads.loadmadsfile("test-internal-linearmodel.mads")
mcmcchain = Mads.bayessampling(mdinternal)
#plot(x=mcmcchain.samples[:,1], y=mcmcchain.samples[:,2])
Mads.madsinfo("TEST Bayesian sampling with external model:")
md = Mads.loadmadsfile("test-external-ascii.mads")
mcmcchain = Mads.bayessampling(md; nsteps=5, burnin=2)
Mads.madsinfo("TEST parallel Bayesian sampling with external model:")
md = Mads.loadmadsfile("test-external-ascii.mads")
mcmcchains = Mads.bayessampling(md, 4; nsteps=25, burnin=0)
