import DocumentFunction
import MathOptInterface

"""
MadsModel type applied for MathOptInterface analyses
"""
mutable struct MadsModel <: MathOptInterface.AbstractNLPEvaluator
end

"""
Define `MadsModel` type applied for Mads execution using `MathOptInterface`

$(DocumentFunction.documentfunction(madsMathOptInterface;
argtext=Dict("madsdata"=>"MADS problem dictionary [default=`Dict()`]")))
"""
function madsMathOptInterface(madsdata::AbstractDict=Dict())
	f = makemadscommandfunction(madsdata)
	ssdr = Mads.haskeyword(madsdata, "ssdr")
	sar = Mads.haskeyword(madsdata, "sar")
	restartdir = getrestartdir(madsdata)
	o_function(x::AbstractVector) = sar ? sum.(abs.(x)) : LinearAlgebra.dot(x, x)
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

	o_moi, grad_o_moi, f_moi, g_moi = makemoifunctions(madsdata)

	@eval function MathOptInterface.initialize(d::MadsModel, requested_features::AbstractVector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	@eval MathOptInterface.features_available(d::MadsModel) = [:Grad, :Jac]
	@eval function MathOptInterface.eval_objective(d::MadsModel, p::AbstractVector)
		return o_moi(p)
	end
	@eval function MathOptInterface.eval_objective_gradient(d::MadsModel, grad_f::AbstractVector, p::AbstractVector)
		grad_f = grad_o_moi(p; dx=lineardx)
	end
	@eval function MathOptInterface.eval_objective_gradient(d::MadsModel, o::AbstractVector, p::AbstractVector)
		o = f_moi(p)
	end
	#=
	MathOptInterface.jacobian_structure(d::MadsModel) = Int[], Int[]
	MathOptInterface.eval_jac_g(d::MadsModel, J, p) = nothing
	MathOptInterface.jacobian_structure(d::MadsModel) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4], [1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
	=#
	@eval MathOptInterface.jacobian_structure(d::MadsModel) = [repeat(collect(1:nP); inner=nO)],[repeat(collect(1:nP); outer=nO)]
	@eval function MathOptInterface.eval_jac_g(d::MadsModel, J::AbstractVector, p::AbstractVector)
		center = f_moi(p)
		fevals = g_moi(p, dx=lineardx)
		ji = 0
		for j in 1:nO
			for i in 1:nP
				J[ji + i] = (fevals[i][j] - center[j]) / dx[i]
			end
			ji += nP
		end
	end
	@eval MathOptInterface.hessian_lagrangian_structure(d::MadsModel) = Int[], Int[]
	@eval MathOptInterface.eval_hessian_lagrangian(d::MadsModel, H, p, σ, μ) = nothing
end

"""
Make forward model, gradient, objective functions needed for MathOptInterface optimization

$(DocumentFunction.documentfunction(makemoifunctions;
argtext=Dict("madsdata"=>"MADS problem dictionary")))

Returns:

- forward model, gradient, objective functions
"""
function makemoifunctions(madsdata::AbstractDict)
	"""
	Objective function for MathOptInterface optimization
	"""
	function o_moi(arrayparameters::AbstractVector)
		residuals = f_moi(arrayparameters)
		return o_function(residuals)
	end
	"""
	Objective function gradient for MathOptInterface optimization
	"""
	function grad_o_moi(arrayparameters::AbstractVector; dx::Vector{Float64}=Vector{Float64}(undef, 0))
		if sizeof(dx) == 0
			dx = lineardx
		end
		of = o_moi(arrayparameters)
		fevals = g_moi(arrayparameters, dx=dx)
		grad_o = Array{Float64}(undef, nP)
		for i in 1:nP
			of_i = o_function(fevals[i])
			grad_o = (of_j - o) / dx[i]
		end
		return grad_o
	end
	"""
	Forward model function for MathOptInterface optimization
	"""
	function f_moi(arrayparameters::AbstractVector)
		parameters = copy(initparams)
		for i = 1:nP
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		results = Vector{Float64}(undef, 0)
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
	Inner gradient function for the forward model used for MathOptInterface optimization
	"""
	function inner_g_moi(argtuple::AbstractVector)
		arrayparameters = argtuple[1]
		dx = argtuple[2]
		if sizeof(dx) == 0
			dx = lineardx
		end
		filename = ReusableFunctions.gethashfilename(restartdir, arrayparameters)
		center = ReusableFunctions.loadresultfile(filename)
		center_computed = (center !== nothing) && length(center) == nO
		p = Vector{Float64}[]
		for i in 1:nP
			a = copy(arrayparameters)
			a[i] += dx[i]
			push!(p, a)
		end
		if !center_computed
			push!(p, arrayparameters)
		end
		fevals = RobustPmap.rpmap(f_moi, p)
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
	Reusable inner gradient function for the forward model used for MathOptInterface optimization
	"""
	reusable_inner_g_moi = makemadsreusablefunction(madsdata, inner_g_moi, "g_moi"; usedict=false)
	"""
	Gradient function for the forward model used for MathOptInterface optimization
	"""
	function g_moi(arrayparameters::AbstractVector; dx::Vector{Float64}=lineardx)
		return reusable_inner_g_moi(arrayparameters, dx)
	end
	return o_moi, grad_o_moi, f_moi, g_moi
end
