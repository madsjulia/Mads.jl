import Mads
@Mads.tryimportmain OrderedCollections
import JLD2
import FileIO
import Test
import OrdinaryDiffEq

Mads.veryquieton()
Mads.graphoff()

# function to create a function for the ODE solver
@Mads.stderrcapture function makefunc(parameterdict::OrderedCollections.OrderedDict)
	# ODE parameters
	omega = parameterdict["omega"]
	k = parameterdict["k"]
	function func(f, y, p, t) # function needed by the ODE solver
		# ODE: x''[t] == -\omega^2 * x[t] - k * x'[t]
		f[1] = y[2] # u' = v
		f[2] = -omega * omega * y[1] - k * y[2] # v' = -omega^2*u - k*v
	end
	return func
end

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
# Mads.showparameters(md)

# create parameter dictionary
paramdict = OrderedCollections.OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))

@Test.testset "ODE Solver" begin
	# create a function for the ODE solver
	funcosc = makefunc(paramdict)
	Mads.madsinfo("Solve ODE ...")
	t = collect(0:.1:100)
	initialconditions = [1., 0.]
	odeprob = OrdinaryDiffEq.ODEProblem(funcosc, initialconditions, (0.0, 100.0))
	sol = OrdinaryDiffEq.solve(odeprob, OrdinaryDiffEq.Tsit5(), saveat=t)
	ys = convert(Array, sol)'

	# Write good test results to directory
	if Mads.create_tests
		dirt = joinpath(workdir, "test_results")
		Mads.mkdir(dirt)

		FileIO.save(joinpath(dirt, "ode_solver_t.jld2"), "t", t)
		FileIO.save(joinpath(dirt, "ode_solver_y.jld2"), "ys", ys)
	end

	good_ode_t = FileIO.load(joinpath(workdir, "test_results", "ode_solver_t.jld2"), "t")
	good_ode_ys = FileIO.load(joinpath(workdir, "test_results", "ode_solver_y.jld2"), "ys")

	@Test.test isapprox(t, good_ode_t, atol=1e-6)
	@Test.test isapprox(ys, good_ode_ys, atol=1e-6)

	# create an observation dictionary in the MADS problem dictionary
	Mads.madsinfo("Create MADS Observations ...")
	Mads.createobservations!(md, t, ys[:,1], weight = 10)
	Mads.createobservations!(md, t, ys[:,1], weight_type = "inverse", logtransform=true)
	Mads.createobservations!(md, Dict("a"=>1,"c"=>1), weight = 10)
	Mads.createobservations!(md, Dict("a"=>1,"c"=>1), weight_type = "inverse", logtransform=true)
	Mads.createobservations!(md, t, ys[:,1])
	# Mads.madsinfo("Show MADS Observations ...")
	# Mads.showobservations(md)
end

Mads.veryquietoff()
Mads.graphon()

:passed