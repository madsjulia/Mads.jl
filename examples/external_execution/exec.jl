import Mads

Mads.madsinfo("TEST Saltelli sensitivity analysis:")
md = Mads.loadmadsfile("exec.mads")
results = Mads.saltelli(md; N=100)
results = Mads.saltelliparallel(md, 2; N=50)
Mads.printSAresults(md, results)
