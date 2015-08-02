using Mads
using ODE
using Gadfly
using DataStructures

# Base.source_path()
# cd(dirname(Base.source_path()))
# reload("../../src/MadsYAML.jl")
# reload("../../src/Mads.jl")
# pwd()
# cd("codes/mads.jl")

# load parameter data from MADS YAML file
md = Mads.loadyamlmadsfile("examples/ode/ode.mads")
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

times = [0:.1:100]
initialconditions = [1.,0.]
t,y=ode4s(funcosc, initialconditions, times)
ys = hcat(y...).' # vecorize the output and transpose with '

#writedlm("ode.results",ys[:,1])
p=plot(layer(x=t,y=ys[:,1],Geom.line,Theme(default_color=color("orange"))),layer(x=t,y=ys[:,2],Geom.line))
draw(SVG(string("ode-results.svg"),6inch,4inch),p)

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
saltelliresult = Mads.saltelli(md,N=int(1e3))
Mads.plotobsSAresults(md,saltelliresult)

# local SA
localsaresult = Mads.localsa(md)

# Manual SA
paramdist=Mads.getdistributions(md)
omegavalues = rand(paramdist["omega"],100)
Y = Array(Float64,length(times),0)
for i in 1:100
  original = paramdict["omega"]
  paramdict["omega"] = omegavalues[i]
  funcosc = makefunc(paramdict)
  t,y=ode4s(funcosc, initialconditions, times)
  ys = hcat(y...).' # vecorize the output and transpose with '
  Y = hcat( Y, ys[:,1])
  paramdict["omega"] = original
end
p=Gadfly.plot([layer(y=Y[:,i],x=t, Geom.line,
  Theme(default_color=color(["red" "blue" "green" "cyan" "magenta" "yellow"][i%6+1])))
  for i in 1:size(Y)[2]]...)
