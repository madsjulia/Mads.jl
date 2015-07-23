using Mads
pwd()
Base.source_path()
cd(dirname(Base.source_path()))
pwd()
# Saltelli senstivity analysis tests
Mads.madsinfo("TEST Saltelli senstivity analysis: Sobol test:")
mdsobol = Mads.loadyamlmadsfile("test-sobol.mads")
results = Mads.saltelli(mdsobol,N=int(1e5))
Mads.saltelliprintresults(mdsobol,results)
Mads.madsinfo("TEST Saltelli senstivity analysis: Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("test-saltelli.mads")
results = Mads.saltelli(mdsaltelli) # Fast
Mads.saltelliprintresults(mdsaltelli,results)
Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Sobol test:")
mdsobol = Mads.loadyamlmadsfile("test-sobol.mads")
results = Mads.saltellibrute(mdsobol) # Slow
Mads.saltelliprintresults2(mdsobol,results)
Mads.madsinfo("TEST Saltelli senstivity analysis (brute force): Linear problem:")
mdsaltelli = Mads.loadyamlmadsfile("test-saltelli.mads")
results = Mads.saltellibrute(mdsaltelli) # Slow
Mads.saltelliprintresults2(mdsaltelli,results)
