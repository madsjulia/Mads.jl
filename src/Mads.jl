module Mads

import DataStructures # import is needed for parallel calls
import Distributions
import Gadfly
import Compose
import Colors
import Compat
import Optim
import Lora
import Distributions
import Logging
import JSON
import NLopt
import HDF5 # HDF5 installation is problematic on some machines
import Conda
import PyCall
import PyPlot
@PyCall.pyimport yaml # PyYAML installation is problematic on some machines
import YAML # use YAML if PyYAML is not available

if VERSION < v"0.4.0-rc"
	using Docile # default for v > 0.4
	using Lexicon
	using Dates
	typealias AbstractString String
end
if !in(dirname(Base.source_path()), LOAD_PATH)
	push!(LOAD_PATH, dirname(Base.source_path())) # add MADS path if not already there
end
include("MadsYAML.jl")
include("MadsASCII.jl")
include("MadsJSON.jl")
include("MadsIO.jl")
include("MadsTestFunctions.jl")
include("MadsMisc.jl")
include("MadsSA.jl")
include("MadsMC.jl")
include("MadsLM.jl")
include("MadsAnasol.jl")
include("MadsBIG.jl")
include("MadsLog.jl") # messages higher than specified level are printed
# Logging.configure(level=OFF) # OFF
# Logging.configure(level=CRITICAL) # ONLY CRITICAL
Logging.configure(level=Logging.DEBUG)
quiet = true
verbositylevel = 1
debuglevel = 1
modelruns = 0
madsinputfile = ""
create_tests = false # dangerous if true
const madsdir = join(split(Base.source_path(), '/')[1:end - 1], '/')

#@document
#@docstrings

@doc "Make MADS quiet" ->
function quieton()
	global quiet = true;
end

@doc "Make MADS not quiet" ->
function quietoff()
	global quiet = false;
end

function create_tests_on()
	global create_tests = true;
end

function create_tests_off()
	global create_tests = false;
end

@doc "Set MADS debug level" ->
function setdebuglevel(level::Int)
	global debuglevel = level
end

@doc "Set MADS verbosity level" ->
function setverbositylevel(level::Int)
	global verbositylevel = level
end

@doc "Reset the model runs count" ->
function resetmodelruns()
	global modelruns = 0
end

@doc "Set number of processors / threads" ->
function setnprocs(np, nt)
	n = np - nprocs()
	if n > 0
		addprocs(n)
	elseif n < 0
		rmprocs(workers()[end+n+1:end])
	end
	blas_set_num_threads(nt)
	sleep(1)
	madsoutput("Number of processors is $(nprocs()) $(workers())\n")
end

@doc "Set number of processors" ->
function setnprocs(np)
	setnprocs(np, np)
end

@doc "Save calibration results" ->
function savecalibrationresults(madsdata::Associative, results)
	#TODO map estimated parameters on a new madsdata structure
	#TODO save madsdata in yaml file using dumpyamlmadsfile
	#TODO save residuals, predictions, observations (yaml?)
end

@doc "Calibrate with random initial guesses" ->
function calibraterandom(madsdata::Associative, numberofsamples; tolX=1e-3, tolG=1e-6, maxIter=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
	paramkeys = Mads.getparamkeys(madsdata)
	paramdict = OrderedDict(zip(paramkeys, Mads.getparamsinit(madsdata)))
	paramsoptdict = paramdict
	paramoptvalues = Mads.parametersample(madsdata, numberofsamples)
	bestresult = Array(Any,2)
	bestphi = Inf
	quietchange = false
	if !Mads.quiet
		Mads.quieton()
		quietchange = true
	end
	for i in 1:numberofsamples
		for paramkey in keys(paramoptvalues)
			paramsoptdict[paramkey] = paramoptvalues[paramkey][i]
		end
		Mads.setparamsinit!(madsdata, paramsoptdict)
		result = Mads.calibrate(madsdata; tolX=tolX, tolG=tolG, maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, usenaive=usenaive)
		phi = result[2].f_minimum
		Mads.quietoff()
		Mads.madsinfo("""Random initial guess #$i: OF = $phi""")
		if !quietchange
			Mads.quieton()
		end
		if phi < bestphi
			bestresult = result
			bestphi = phi
		end
	end
	if quietchange
		Mads.quietoff()
	end
	Mads.setparamsinit!(madsdata, paramdict)
	return bestresult
end

@doc "Calibrate " ->
function calibrate(madsdata::Associative; tolX=1e-4, tolG=1e-6, tolOF=1e-3, maxEval=1000, maxIter=100, maxJacobians=100, lambda=100.0, lambda_mu=10.0, np_lambda=10, show_trace=false, usenaive=false)
	rootname = Mads.getmadsrootname(madsdata)
	f_lm, g_lm, o_lm = Mads.makelmfunctions(madsdata)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	initparams = Mads.getparamsinit(madsdata, optparamkeys)
	lowerbounds = Mads.getparamsmin(madsdata, optparamkeys)
	upperbounds = Mads.getparamsmax(madsdata, optparamkeys)
	logtransformed = Mads.getparamslog(madsdata, optparamkeys)
	indexlogtransformed = find(logtransformed)
	lowerbounds[indexlogtransformed] = log10(lowerbounds[indexlogtransformed])
	upperbounds[indexlogtransformed] = log10(upperbounds[indexlogtransformed])
	f_lm_sin = Mads.sinetransformfunction(f_lm, lowerbounds, upperbounds, indexlogtransformed)
	g_lm_sin = Mads.sinetransformgradient(g_lm, lowerbounds, upperbounds, indexlogtransformed)
	function calibratecallback(x_best)
		outfile = open("$rootname.iterationresults", "a+")
		write(outfile, string("OF: ", o_lm(f_lm_sin(x_best)), "\n"))
		write(outfile, string(Dict(zip(optparamkeys, Mads.sinetransform(x_best, lowerbounds, upperbounds, indexlogtransformed))), "\n"))
		close(outfile)
	end
	if usenaive
		results = Mads.naive_levenberg_marquardt(f_lm_sin, g_lm_sin, o_lm, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed); maxIter=maxIter, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda)
	else
		results = Mads.levenberg_marquardt(f_lm_sin, g_lm_sin, o_lm, asinetransform(initparams, lowerbounds, upperbounds, indexlogtransformed); root=rootname, tolX=tolX, tolG=tolG, tolOF=tolOF, maxEval=maxEval, maxIter=maxIter, maxJacobians=maxJacobians, lambda=lambda, lambda_mu=lambda_mu, np_lambda=np_lambda, show_trace=show_trace, callback=calibratecallback)
	end
	minimum = Mads.sinetransform(results.minimum, lowerbounds, upperbounds, indexlogtransformed)
	nonoptparamkeys = Mads.getnonoptparamkeys(madsdata)
	minimumdict = OrderedDict(zip(getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	for i = 1:length(optparamkeys)
		minimumdict[optparamkeys[i]] = minimum[i]
	end
	return minimumdict, results
end

@doc "Do a forward run using the initial or provided values for the model parameters " ->
function forward(madsdata::Associative; paramvalues=Void)
	if paramvalues == Void
		paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	end
	forward(madsdata, paramvalues)
end

@doc "Do a forward run using provided values for the model parameters " ->
function forward(madsdata::Associative, paramvalues)
	f = Mads.makemadscommandfunction(madsdata)
	return f(paramvalues)
end

@doc "Do a forward run over a 3D grid using the initial or provided values for the model parameters " ->
function forwardgrid(madsdata::Associative; paramvalues=Void)
	if paramvalues == Void
		paramvalues = Dict(zip(Mads.getparamkeys(madsdata), Mads.getparamsinit(madsdata)))
	end
	forwardgrid(madsdata, paramvalues)
end

@doc "Do a forward run over a 3D grid using provided values for the model parameters " ->
function forwardgrid(madsdatain::Associative, paramvalues)
	madsdata = copy(madsdatain)
	f = Mads.makemadscommandfunction(madsdata)
	nx = madsdata["Grid"]["xcount"]
	ny = madsdata["Grid"]["ycount"]
	nz = madsdata["Grid"]["zcount"]
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	zmin = madsdata["Grid"]["zmin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	zmax = madsdata["Grid"]["zmax"]
	time = madsdata["Grid"]["time"]
	if nx == 1
		dx = 0
	else
		dx = ( xmax - xmin ) / ( nx - 1 )
	end
	if ny == 1
		dy = 0
	else
		dy = ( ymax - ymin ) / ( ny - 1 )
	end
	if nz == 1
		dz = 0
	else
		dz = ( zmax - zmin ) / ( nz - 1 )
	end
	x = xmin
	dictwells = Dict()
	for i in 1:nx
		x += dx
		y = ymin
		for j in 1:ny
			y += dy
			z = zmin
			for k in 1:nz
				z += dz
				wellname = "w_$(i)_$(j)_$(k)"
				dictwells[wellname] = Dict()
				dictwells[wellname]["x"] = x
				dictwells[wellname]["y"] = y
				dictwells[wellname]["z0"] = z
				dictwells[wellname]["z1"] = z
				dictwells[wellname]["on"] = true
				arrayobs = Array(Dict, 0)
				dictobs = Dict()
				dictobs["t"] = time
				dictobs["c"] = 0
				dictobs["weight"] = 1
				push!(arrayobs, dictobs)
				dictwells[wellname]["obs"] = arrayobs
			end
		end
	end
	madsdata["Wells"] = dictwells
	Mads.wells2observations!(madsdata)
	forward_results = f(paramvalues)
	s = Array(Float64, nx, ny, nz)
	for i in 1:nx
		for j in 1:ny
			for k in 1:nz
				obsname = "w_$(i)_$(j)_$(k)_$(time)"
				s[i, j, k] = forward_results[obsname]
			end
		end
	end
	return s
end

@doc "Plot a 3D grid solution based on s " ->
function plotgrid(madsdata::Associative, s::Array{Float64})
	@PyCall.pyimport matplotlib.ticker as mt
	@PyCall.pyimport matplotlib.colors as mcc
	probname = Mads.getmadsrootname(madsdata; first=false)
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	t = madsdata["Grid"]["time"]
	x = Array(Float64, 0)
	y = Array(Float64, 0)
	c = Array(Float64, 0)
	l = Array(AbstractString, 0)
	for w in keys(madsdata["Wells"])
		push!(x, madsdata["Wells"][w]["x"])
		push!(y, madsdata["Wells"][w]["y"])
		push!(c, madsdata["Wells"][w]["obs"][end]["c"])
		push!(l, w)
	end
	PyPlot.figure(figsize=(8, 6))
	# PyPlot.imshow(log10(s[:,:,1]'), origin="lower", extent=[xmin, xmax, ymin, ymax], origin="lower", vmin=log10(50), cmap="jet")
	PyPlot.contourf(s[:,:,1]', cmap="jet", levels=[10,30,100,300,1000,3000,10000], locator=mt.LogLocator(), origin="lower", extent=[xmin, xmax, ymin, ymax], cmap="jet", set_under="w" )
	PyPlot.colorbar(shrink=0.5, cmap="jet")
	PyPlot.title("$probname Time = $t")
	PyPlot.scatter(x, y, marker="o", c=c, s=70, cmap="jet", norm=mcc.LogNorm())
	for i = 1:length(l)
		PyPlot.annotate(l[i], xy=(x[i], y[i]), xytext=(-2, 2), fontsize=8, textcoords="offset points", ha="right", va="bottom")
	end
end

@doc "Plot a 3D grid solution " ->
function plotgrid(madsdata::Associative)
	s = forwardgrid(madsdata)
	plotgrid(madsdata, s)
end

@doc "Plot a 3D grid solution " ->
function plotgrid(madsdata::Associative, parameters::Associative)
	s = forwardgrid(madsdata, parameters)
	plotgrid(madsdata, s)
end

# NLopt is too much of a pain to install at this point
@doc "Do a calibration using NLopt " -> # TODO switch to a mathprogbase approach
function calibratenlopt(madsdata::Associative; algorithm=:LD_LBFGS)
	const paramkeys = getparamkeys(madsdata)
	const obskeys = getobskeys(madsdata)
	parammins = Array(Float64, length(paramkeys))
	parammaxs = Array(Float64, length(paramkeys))
	paraminits = Array(Float64, length(paramkeys))
	for i = 1:length(paramkeys)
		parammins[i] = madsdata["Parameters"][paramkeys[i]]["min"]
		parammaxs[i] = madsdata["Parameters"][paramkeys[i]]["max"]
		paraminits[i] = madsdata["Parameters"][paramkeys[i]]["init"]
	end
	obs = Array(Float64, length(obskeys))
	weights = ones(Float64, length(obskeys))
	for i = 1:length(obskeys)
		obs[i] = madsdata["Observations"][obskeys[i]]["target"]
		if haskey(madsdata["Observations"][obskeys[i]], "weight")
			weights[i] = madsdata["Observations"][obskeys[i]]["weight"]
		end
	end
	fg = makemadscommandfunctionandgradient(madsdata)
	function fg_nlopt(arrayparameters::Vector, grad::Vector)
		parameters = Dict(zip(paramkeys, arrayparameters))
		resultdict, gradientdict = fg(parameters)
		residuals = Array(Float64, length(madsdata["Observations"]))
		ssr = 0
		i = 1
		for obskey in obskeys
			residuals[i] = resultdict[obskey] - obs[i]
			ssr += residuals[i] * residuals[i] * weights[i] * weights[i]
			i += 1
		end
		if length(grad) > 0
			i = 1
			for paramkey in paramkeys
				grad[i] = 0.
				j = 1
				for obskey in obskeys
					grad[i] += 2 * residuals[j] * gradientdict[obskey][paramkey]
					j += 1
				end
				i += 1
			end
		end
		return ssr
	end
	opt = NLopt.Opt(algorithm, length(paramkeys))
	NLopt.lower_bounds!(opt, parammins)
	NLopt.upper_bounds!(opt, parammaxs)
	NLopt.min_objective!(opt, fg_nlopt)
	NLopt.maxeval!(opt, round(Int, 1e3))
	minf, minx, ret = NLopt.optimize(opt, paraminits)
	return minf, minx, ret
end

@doc "Make a version of the mads file where the targets are given by the model predictions" ->
function maketruth(infilename::AbstractString, outfilename::AbstractString)
	md = loadyamlmadsfile(infilename)
	f = makemadscommandfunction(md)
	result = f(Dict(zip(getparamkeys(md), getparamsinit(md))))
	outyaml = loadyamlfile(infilename)
	if haskey(outyaml, "Observations")
		for fullobs in outyaml["Observations"]
			obskey = collect(keys(fullobs))[1]
			obs = fullobs[obskey]
			obs["target"] = result[obskey]
		end
	end
	if haskey(outyaml, "Wells")
		for fullwell in outyaml["Wells"]
			wellname = collect(keys(fullwell))[1]
			for fullobs in fullwell[wellname]["obs"]
				obskey = collect(keys(fullobs))[1]
				obs = fullobs[obskey]
				obs["target"] = result[string(wellname, "_", obs["t"])]
			end
		end
	end
	dumpyamlfile(outfilename, outyaml)
end

## Types necessary for SVR; needs to be defined here because types don't seem to work when not defined at top level
type svrOutput
	alpha::Array{Float64,1}
	b::Float64
	kernel::Function
	kernelType::ASCIIString
	train_data::Array{Float64, 2}
	varargin::Array

	svrOutput(alpha::Array{Float64,1}, b::Float64, kernel::Function, kernelType::ASCIIString, train_data::Array{Float64, 2}, varargin::Array) = new(alpha, b, kernel, kernelType, train_data, varargin); # constructor for the type
end

type svrFeature
	feature::Array{Float64,1}
end

end # Module end
