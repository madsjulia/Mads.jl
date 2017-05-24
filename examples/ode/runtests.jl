import Mads
import DataStructures
import JLD
import Base.Test

@Mads.tryimport ODE

# function to create a function for the ODE solver
@Mads.stderrcapture function makefunc(parameterdict::DataStructures.OrderedDict)
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

if isdefined(:ODE)
	# load parameter data from MADS YAML file
	Mads.madsinfo("Loading data ...")
	workdir = Mads.getmadsdir() # get the directory where the problem is executed
	if workdir == "."
		workdir = joinpath(Mads.madsdir, "..", "examples", "ode")
	end

	md = Mads.loadmadsfile(joinpath(workdir, "ode.mads"))
	rootname = Mads.getmadsrootname(md)

	# get parameter keys
	paramkeys = Mads.getparamkeys(md)
	# Mads.showparameters(md)

	# create parameter dictionary
	paramdict = DataStructures.OrderedDict(zip(paramkeys, map(key->md["Parameters"][key]["init"], paramkeys)))

	@Base.Test.testset "ODE Solver" begin
		# create a function for the ODE solver
		funcosc = makefunc(paramdict)
		Mads.madsinfo("Solve ODE ...")
		times = collect(0:.1:100)
		initialconditions = [1.,0.]
		t, y = ODE.ode23s(funcosc, initialconditions, times, points=:specified)
		ys = hcat(y...)' # vectorizing the output and transposing it with '

		# Write good test results to directory
		if Mads.create_tests
			d = joinpath(workdir, "test_results")
			Mads.mkdir(d)

			JLD.save(joinpath(d, "ode_solver_t.jld"), "t", t)
			JLD.save(joinpath(d, "ode_solver_y.jld"), "ys", ys)
		end

		good_ode_t = JLD.load(joinpath(workdir, "test_results", "ode_solver_t.jld"), "t")
		good_ode_ys = JLD.load(joinpath(workdir, "test_results", "ode_solver_y.jld"), "ys")

		@Base.Test.test isapprox(t, good_ode_t, atol=1e-6)
		@Base.Test.test isapprox(ys, good_ode_ys, atol=1e-6)

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
else
	warn("ODE is missing")
end