import Mads
import OrdinaryDiffEq
import JSON
import Gadfly
import OrderedCollections

include("ode-driver.jl")

# load parameter data from MADS YAML file
Mads.madsinfo("Loading data ...")
workdir = Mads.getmadsdir() # get the directory where the problem is executed
if workdir == "."
	workdir = joinpath(Mads.madsdir, "examples", "ode")
end

md = Mads.loadmadsfile(joinpath(workdir, "ode.mads"))
rootname = Mads.getmadsrootname(md)

# get parameter keys
paramkeys = Mads.getparamkeys(md)
Mads.showparameters(md)

# create parameter dictionary
paramdict = OrderedCollections.OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))

# function to create a function for the ODE solver
function makefunc(parameterdict::OrderedCollections.OrderedDict)
	# ODE parameters
	omega = parameterdict["omega"]
	k = parameterdict["k"]
	function func(f, y, p, t) # function needed by the ODE solver
		# ODE: x''[t] = -\omega^2 * x[t] - k * x'[t]
		f[1] = y[2] # u' = v
		f[2] = -omega * omega * y[1] - k * y[2] # v' = -omega^2*u - k*v
	end
	return func
end

# create a function for the ODE solver
funcosc = makefunc(paramdict)
Mads.madsinfo("Solve ODE ...")
times = collect(0:.1:100)
initialconditions = [1.,0.]
prob = OrdinaryDiffEq.ODEProblem(funcosc, initialconditions, (0.0,100.0))
sol = OrdinaryDiffEq.solve(prob,Tsit5(), saveat=times)
ys = convert(Array,sol)

# draw initial solution
p = Gadfly.plot(Gadfly.layer(x=t, y=ys[:,1], Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "orange"))),
				Gadfly.layer(x=t, y=ys[:,2], Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "blue"))),
				Gadfly.Guide.manual_color_key("ODE", ["x(t)", "x'(t)"], ["orange", "blue"]))
Gadfly.draw(Gadfly.SVG(string("$rootname-solution.svg"), 6Gadfly.inch, 4Gadfly.inch), p)

# create an observation dictionary in the MADS problem dictionary
Mads.madsinfo("Create MADS Observations ...")
Mads.createobservations!(md, t, ys[:,1])
Mads.madsinfo("Show MADS Observations ...")
Mads.showobservations(md)

Mads.madsinfo("Forward run ...")
Mads.plotmatches(md)

Mads.madsinfo("Local sensitivity analysis ...")
localsaresult = Mads.localsa(md, format="PNG")
stddev = localsaresult["stddev"]
Mads.madsinfo("Posterior parameter uncertainty ranges (centered at the initial paramter estimates) ...")
f = open("$rootname-localsa-paramranges.dat", "w")
for i in 1:length(paramkeys)
	println(f, md["Parameters"][paramkeys[i]]["init"]-3*stddev[i]," < ",md["Parameters"][paramkeys[i]]["longname"], " < ", md["Parameters"][paramkeys[i]]["init"]+3*stddev[i])
end
close(f)

Mads.madsinfo("Global sensitivity analysis ...")
saltelliresult = Mads.efast(md, seed=20151001)

Mads.plotobsSAresults(md, saltelliresult; xtitle = "Time", ytitle = "State variable")

Mads.madsinfo("Spaghetti plots over the prior parameter ranges ...")
Mads.spaghettiplot(md, 100; obs_plot_dots=false, keyword="prior", seed=20151001, format="PNG")
Mads.spaghettiplots(md, 100; obs_plot_dots=false, keyword="prior", seed=20151001, format="PNG")

Mads.madsinfo("Bayesian sampling ...")
mcmcchain = Mads.bayessampling(md, seed=20151001)

Mads.madsinfo("Bayesian scatter plots ...")
Mads.scatterplotsamples(md, mcmcchain.value', rootname * "-bayes.png")

# convert the parameters in the chain to a parameter dictionary of arrays
mcmcvalues = Mads.paramarray2dict(md, mcmcchain.value')

Mads.madsinfo("Posterior (Bayesian) spaghetti plots ...")
Mads.spaghettiplots(md, mcmcvalues, keyword="posterior", obs_plot_dots=false, format="PNG")
Mads.spaghettiplot(md, mcmcvalues, keyword="posterior", obs_plot_dots=false, format="PNG")
