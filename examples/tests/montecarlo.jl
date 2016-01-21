using Mads

Mads.madsinfo("TEST Monte Carlo on an external call problem:")
md = Mads.loadmadsfile("test-external-ascii.mads")
#Mads.setdynamicmodel(md, f)
results = Mads.montecarlo(md; N=10)
Mads.madsoutput("$results\n")
