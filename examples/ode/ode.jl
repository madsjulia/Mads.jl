using Mads
using ODE
using JSON
using Gadfly
using DataStructures

# Base.source_path()
# cd(dirname(Base.source_path()))
# reload("../../src/MadsYAML.jl")
# reload("../../src/Mads.jl")
# pwd()
# cd("codes/mads.jl")

# load parameter data from MADS YAML file
Mads.madsinfo("Loading data ...")
md = Mads.loadyamlmadsfile("examples/ode/ode.mads")
rootname = Mads.madsrootname(md)
# get parameter keys
paramkeys = Mads.getparamkeys(md)
# create parameter dictionary
paramdict = OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))
# function to create a function for the ODE solver
function makefunc(parameterdict::OrderedDict)
  function func(t, y) # function needed by the ODE solver
    # ODE: x''[t] == -\omega^2 * x[t] - k * x'[t]
    # ODE parameters
    omega = parameterdict["omega"]
    k = parameterdict["k"]
    f = similar(y)
    f[1] = y[2] # u' = v
    f[2] = -omega * omega * y[1] - k * y[2] # v' = -omega^2*u - k*v
    return f
  end
  return func
end
# create a function for the ODE solver
funcosc = makefunc(paramdict)
Mads.madsinfo("Solve ODE ...")
times = [0:.1:100]
initialconditions = [1.,0.]
t,y=ode4s(funcosc, initialconditions, times)
ys = hcat(y...).' # vecorize the output and transpose with '

#writedlm("$rootname-solution.dat",ys[:,1])
p=plot(layer(x=t,y=ys[:,1],Geom.line,Theme(default_color=color("orange"))),layer(x=t,y=ys[:,2],Geom.line))
draw(SVG(string("$rootname-solution.svg"),6inch,4inch),p)

Mads.madsinfo("Create MADS Observations ...")
# create an observation dictionary in the MADS disctionary
observations = OrderedDict{String, Float64}(zip(map(i -> string("o", i), times), ys[:,1]))
observationsdict = OrderedDict()
i = 1
for t in times
  obskey = string("o", t)
  data = OrderedDict()
  data["target"] = ys[i,1]
  data["weight"] = 1
  data["time"] = t
  data["log"] = "false"
  data["min"] = 0
  data["max"] = 1
  observationsdict[obskey] = data
  i += 1
end
md["Observations"] = observationsdict

# global SA
Mads.madsinfo("Global SA ...")
saltelliresult = Mads.saltelli(md,N=int(1e3))
f = open("$rootname-SA-results.json", "w")
JSON.print(f, saltelliresult)
close(f)
# saltelliresult = JSON.parsefile("$rootname-SA-results.json"; ordered=true, use_mmap=true)
Mads.plotobsSAresults(md,saltelliresult)

# local SA
Mads.madsinfo("Local SA ...")
localsaresult = Mads.localsa(md)

# Manual SA
Mads.madsinfo("Manual SA ...")
paramdist=Mads.getdistributions(md)
for paramkey in keys(paramdist)
  values = rand(paramdist[paramkey],100)
  Y = Array(Float64,length(times),0)
  for i in 1:100
    original = paramdict[paramkey]
    paramdict[paramkey] = values[i]
    funcosc = makefunc(paramdict)
    t,y=ode4s(funcosc, initialconditions, times)
    ys = hcat(y...).' # vecorize the output and transpose with '
    Y = hcat( Y, ys[:,1])
    paramdict[paramkey] = original
  end
  p=Gadfly.plot([layer(y=Y[:,paramkey],x=t, Geom.line,
    Theme(default_color=color(["red" "blue" "green" "cyan" "magenta" "yellow"][paramkey%6+1])))
    for paramkey in 1:size(Y)[2]]...)
  draw(SVG(string("$rootname-MSA-$paramkey.svg"),6inch,4inch),p)
end
