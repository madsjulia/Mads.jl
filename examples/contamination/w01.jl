import Mads
using DataStructures

#Base.source_path()
#cd(dirname(Base.source_path()))
#reload("../../src/MadsYAML.jl")
#reload("../../src/Mads.jl")
#pwd()
const md = Mads.loadyamlmadsfile("w01.mads")
paramkeys = Mads.getparamkeys(md)
paramdict = OrderedDict(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys))
computeconcentrations = Mads.makecomputeconcentrations(md)
forward_preds = computeconcentrations(paramdict)
#result = Mads.calibrate(md; show_trace=true)
result = Mads.saltelli(md,N=int(1e1))
#Mads.saltelliprintresults(md, result)
Mads.plotwellSAresults("w20a",md,result)
