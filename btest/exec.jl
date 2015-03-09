using Mads

# external execution test using ASCII files
println("TEST Saltelli senstivity analysis:")
md = Mads.loadyamlmadsfile("exec.mads")
results = Mads.saltelli(md,N=int(1e4))
results = Mads.saltelliparallel(md,N=int(1e4),2)
Mads.saltelliprintresults(md,results)
