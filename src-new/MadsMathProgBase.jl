import DocumentFunction
import MathProgBase

"""
MadsModel type applied for MathProgBase analyses
"""
mutable struct MadsModel <: MathProgBase.AbstractNLPEvaluator
end

"""
Define `MadsModel` type applied for Mads execution using `MathProgBase`

$(DocumentFunction.documentfunction(madsmathprogbase;
argtext=Dict("madsdata"=>"MADS problem dictionary [default=`Dict()`]")))
"""
function madsmathprogbase(madsdata::AbstractDict=Dict())
	f = makemadscommandfunction(madsdata)
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	sar = Mads.haskeyword(madsdata, "sar")
	restartdir = getrestartdir(madsdata)
	o_function(x::Vector) = sar ? sum.(abs.(x)) : dot(x, x)
	obskeys = Mads.getobskeys(madsdata)
	weights = Mads.getobsweight(madsdata, obskeys)
	targets = Mads.getobstarget(madsdata, obskeys)
	index = findall(isnan.(targets))
	weights[index] = 0
	targets[index] = 0
	if ssdr
		mins = Mads.getobsmin(madsdata, obskeys)
		maxs = Mads.getobsmax(madsdata, obskeys)
		mins[index] = -Inf
		maxs[index] = Inf
	end
	nO = length(obskeys)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	lineardx = Mads.getparamsstep(madsdata, optparamkeys)
	nP = length(optparamkeys)
	initparams = Mads.getparamdict(madsdata)

	o_mpb, grad_o_mpb, f_mpb, g_mpb = makempbfunctions(madsdata)

	@eval function MathProgBase.initialize(d::MadsModel, requested_features::Vector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	@eval MathProgBase.features_available(d::MadsModel) = [:Grad, :Jac]
	@eval function MathProgBase.eval_f(d::MadsModel, p::Vector)
		return o_mpb(p)
	end
	@eval function MathProgBase.eval_grad_f(d::MadsModel, grad_f::Vector, p::Vector)
		grad_f = grad_o_mpb(p, dx=lineardx)
	end
	@eval function MathProgBase.eval_g(d::MadsModel, o::Vector, p::Vector)
		o = f_mpb(p)
	end
	#=
	MathProgBase.jac_structure(d::MadsModel) = Int[],Int[]
	MathProgBase.eval_jac_g(d::MadsModel, J, p) = nothing
	MathProgBase.jac_structure(d::MadsModel) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
	=#
	@eval MathProgBase.jac_structure(d::MadsModel) = [repeat(collect(1:nP); inner=nO)],[repeat(collect(1:nP); outer=nO)]
	@eval function MathProgBase.eval_jac_g(d::MadsModel, J::Vector, p::Vector)
		center = f_mpb(p)
		fevals = g_mpb(p, dx=lineardx)
		ji = 0
		for j in 1:nO
			for i in 1:nP
				J[ji + i] = (fevals[i][j] - center[j]) / dx[i]
			end
			ji += nP
		end
	end
	@eval MathProgBase.hesslag_structure(d::MadsModel) = Int[],Int[]
	@eval MathProgBase.eval_hesslag(d::MadsModel, H, p, σ, μ) = nothing
end

"""
Make forward model, gradient, objective functions needed for MathProgBase optimization

$(DocumentFunction.documentfunction(makempbfunctions;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- forward model, gradient, objective functions
"""
function makempbfunctions(madsdata::AbstractDict)
	"""
	Objective function for MathProgBase optimization
	"""
	function o_mpb(arrayparameters::Vector)
		residuals = f_mpb(arrayparameters)
		return o_function(residuals)
	end
	"""
	Objective function gradient for MathProgBase optimization
	"""
	function grad_o_mpb(arrayparameters::Vector; dx::Array{Float64,1}=Array{Float64}(undef, 0))
		if sizeof(dx) == 0
			dx = lineardx
		end
		of = o_mpb(arrayparameters)
		fevals = g_mpb(arrayparameters, dx=dx)
		grad_o = Array{Float64}(undef, nP)
		for i in 1:nP
			of_i = o_function(fevals[i])
			grad_o = (of_j - o) / dx[i]
		end
		return grad_o
	end
	"""
	Forward model function for MathProgBase optimization
	"""
	function f_mpb(arrayparameters::Vector)
		parameters = copy(initparams)
		for i = 1:nP
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		results = Array{Float64}(undef, 0)
		for obskey in obskeys
			push!(results, resultdict[obskey]) # preserve the expected order
		end
		if ssdr
			rmax = (results .- maxs) .* weights
			rmin = (results .- mins) .* weights
			rmax[rmax .< 0] = 0
			rmin[rmin .> 0] = 0
			residuals .+= (rmax .+ rmin)
		end
		return residuals
	end
	"""
	Inner gradient function for the forward model used for MathProgBase optimization
	"""
	function inner_g_mpb(argtuple::Vector)
		arrayparameters = argtuple[1]
		dx = argtuple[2]
		if sizeof(dx) == 0
			dx = lineardx
		end
		filename = ReusableFunctions.gethashfilename(restartdir, arrayparameters)
		center = ReusableFunctions.loadresultfile(filename)
		center_computed = (center != nothing) && length(center) == nO
		p = Vector{Float64}[]
		for i in 1:nP
			a = copy(arrayparameters)
			a[i] += dx[i]
			push!(p, a)
		end
		if !center_computed
			push!(p, arrayparameters)
		end
		fevals = RobustPmap.rpmap(f_mpb, p)
		if !center_computed
			if restartdir != ""
				ReusableFunctions.saveresultfile(restartdir, fevals[nP+1], arrayparameters)
			end
			return fevals[1:nP]
		else
			return fevals
		end
	end
	"""
	Reusable inner gradient function for the forward model used for MathProgBase optimization
	"""
	reusable_inner_g_mpb = makemadsreusablefunction(madsdata, inner_g_mpb, "g_mpb"; usedict=false)
	"""
	Gradient function for the forward model used for MathProgBase optimization
	"""
	function g_mpb(arrayparameters::Vector; dx::Array{Float64,1}=lineardx)
		return reusable_inner_g_mpb(arrayparameters, dx)
	end
	return o_mpb, grad_o_mpb, f_mpb, g_mpb
end
