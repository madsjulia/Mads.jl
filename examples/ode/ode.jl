using Mads
using ODE
using JSON
using Gadfly
using DataStructures

# load parameter data from MADS YAML file
Mads.madsinfo("Loading data ...")
md = Mads.loadmadsfile("ode.mads")
rootname = Mads.getmadsrootname(md)

# get parameter keys
paramkeys = Mads.getparamkeys(md)
Mads.showparameters(md)

# create parameter dictionary
paramdict = OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))

# function to create a function for the ODE solver
function makefunc(parameterdict::OrderedDict)
  # ODE parameters
  omega = parameterdict["omega"]
  k = parameterdict["k"]
  function func(t, y) # function needed by the ODE solver
    # ODE: x''[t] == -\omega^2 * x[t] - k * x'[t]
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
t, y = ode23s(funcosc, initialconditions, times, points=:specified)
ys = hcat(y...)' # vecorize the output and transpose it with '

#writedlm("$rootname-solution.dat",ys[:,1])
p = plot(layer(x=t,y=ys[:,1],Geom.line,Theme(default_color=color("orange"))),layer(x=t,y=ys[:,2],Geom.line))
draw(SVG(string("$rootname-solution.svg"),6inch,4inch),p)

# create an observation dictionary in the MADS dictionary
Mads.madsinfo("Create MADS Observations ...")
Mads.createobservations!(md, t, ys[:,1])
Mads.showobservations(md)

# global SA
srand(20151001)
Mads.madsinfo("Global SA ...")
saltelliresult = Mads.saltelli(md, N=10)
f = open("$rootname-SA-results.json", "w")
JSON.print(f, saltelliresult)
close(f)
# saltelliresult = JSON.parsefile("$rootname-SA-results.json"; ordered=true, use_mmap=true)
Mads.plotobsSAresults(md, saltelliresult; xtitle = "Time", ytitle = "State variable")

# local SA
Mads.madsinfo("Local SA ...")
localsaresult = Mads.localsa(md)

# Spaghetti plots
srand(20151001)
Mads.madsinfo("Spaghetti plots over the prior ranges ...")
numberofsamples = 10
paramvalues=Mads.parametersample(md, numberofsamples)
Mads.spaghettiplot(md, paramvalues; obs_plot_dots=false)
Mads.spaghettiplots(md, paramvalues; obs_plot_dots=false)
