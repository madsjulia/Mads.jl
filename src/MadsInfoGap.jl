import DocumentFunction
import JuMP
import MathOptInterface
import Colors

@Mads.tryimport Ipopt
if !haskey(ENV, "MADS_NO_GADFLY")
	@Mads.tryimport Gadfly
end

"""
Information Gap Decision Analysis using JuMP

$(DocumentFunction.documentfunction(infogap_jump;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("horizons"=>"info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]",
            "retries"=>"number of solution retries [default=`1`]",
            "random"=>"random initial guesses [default=`false`]",
            "maxiter"=>"maximum number of iterations [default=`3000`]",
            "verbosity"=>"verbosity output level [default=`0`]",
            "seed"=>"random seed [default=`0`]")))
"""
function infogap_jump(madsdata::AbstractDict=Dict(); horizons::AbstractVector=[0.05, 0.1, 0.2, 0.5], retries::Int=1, random::Bool=false, maxiter::Integer=3000, verbosity::Integer=0, seed::Integer=-1)
	setseed(seed, quiet)
	no = 4
	np = 4
	t = [1.,2.,3.,4.,0]
	ti = [1,2,3,4,5]
	omin = [1.,2.,3.,4.]
	omax = [1.,2.,3.,4.]
	pinit = [0.,1.,0.,1.]
	pmin = [-0.1,0.99,-0.1,0.99]
	pmax = [0.1,1.001,0.1,1.001]
	par_best = []
	obs_best = []
	for h in horizons
		phi_best = 0
		for r = 1:retries
			m = JuMP.Model(Ipopt.Optimizer)
			JuMP.set_optimizer_attributes(m, "max_iter" => maxiter, "print_level" => verbosity)
			if r > 1 || random
				for i = 1:np
					pinit[i] = rand(Mads.rng) * (pmax[i] - pmin[i]) + pmin[i]
				end
			end
			@JuMP.variable(m, p[i=1:np], start=pinit[i])
			@JuMP.variable(m, o[1:no])
			@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^p[4]) + p[2] * ti[1] + p[3])
			@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^p[4]) + p[2] * ti[2] + p[3])
			@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^p[4]) + p[2] * ti[3] + p[3])
			@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^p[4]) + p[2] * ti[4] + p[3])
			@JuMP.constraint(m, p[1:np] .>= pmin[1:np])
			@JuMP.constraint(m, p[1:np] .<= pmax[1:np])
			# @JuMP.constraint(m, o[1:no] .>= omin[1:no])
			# @JuMP.constraint(m, o[1:no] .<= omax[1:no])
			@JuMP.constraint(m, o[1:no] .>= t[1:no]-h)
			@JuMP.constraint(m, o[1:no] .<= t[1:no]+h)
			# @JuMP.NLobjective(m, Min, sum(w[i] * ((p[1] * (ti[i]^p[2]) + p[3] * ti[i] + p[4]) - t[i])^2 for i=1:no))
			@JuMP.NLobjective(m, Max, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
			JuMP.optimize!(m)
			phi = JuMP.objective_value(m)
			println("OF = $(phi)")
			if phi_best < phi
				phi_best = phi
				par_best = JuMP.value.(p)
				obs_best = JuMP.value.(o)
			end
		end
		println("Max h = $h OF = $(phi_best) par = $par_best")
		#=
		pinit = [0.,1.,0.,1.]
		phi_best = Inf
		for r = 1:retries
			m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
			if r > 1 || random
				for i = 1:np
					pinit[i] = rand(Mads.rng) * (pmax[i] - pmin[i]) + pmin[i]
				end
			end
			@show pinit
			@JuMP.variable(m, p[i=1:np], start=pinit[i])
			@JuMP.variable(m, o[1:no])
			@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^p[4]) + p[2] * ti[1] + p[3])
			@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^p[4]) + p[2] * ti[2] + p[3])
			@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^p[4]) + p[2] * ti[3] + p[3])
			@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^p[4]) + p[2] * ti[4] + p[3])
			@JuMP.constraint(m, p[i=1:np] .>= pmin[i=1:np])
			@JuMP.constraint(m, p[i=1:np] .<= pmax[i=1:np])
			#@JuMP.constraint(m, o[i=1:no] .>= omin[i=1:no])
			#@JuMP.constraint(m, o[i=1:no] .<= omax[i=1:no])
			@JuMP.constraint(m, o[i=1:no] .>= t[i=1:no]-h)
			@JuMP.constraint(m, o[i=1:no] .<= t[i=1:no]+h)
			#@JuMP.NLobjective(m, Min, sum(w[i] * ((p[1] * (ti[i]^p[2]) + p[3] * ti[i] + p[4]) - t[i])^2 for i=1:no))
			@JuMP.NLobjective(m, Min, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
			JuMP.optimize!(m)
			phi = JuMP.objective_value(m)
			println("OF = $(phi)")
			if phi_best > phi
				phi_best = phi
				par_best = JuMP.value.(p)
				obs_best = JuMP.value.(o)
			end
		end
		println("Min h = $h OF = $(phi_best) par = $par_best")
		=#
	end
end

"""
Information Gap Decision Analysis using JuMP

$(DocumentFunction.documentfunction(infogap_jump_polynomial;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("horizons"=>"info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]",
            "retries"=>"number of solution retries [default=`1`]",
            "random"=>"random initial guesses [default=`false`]",
            "maxiter"=>"maximum number of iterations [default=`3000`]",
            "verbosity"=>"verbosity output level [default=`0`]",
            "quiet"=>"quiet [default=`false`]",
            "plot"=>"activate plotting [default=`false`]",
            "model"=>"model id [default=`1`]",
            "seed"=>"random seed [default=`0`]")))

Returns:

- hmin, hmax
"""
function infogap_jump_polynomial(madsdata::AbstractDict=Dict(); horizons::AbstractVector=[0.05, 0.1, 0.2, 0.5], retries::Integer=1, random::Bool=false, maxiter::Integer=3000, verbosity::Integer=0, quiet::Bool=false, plot::Bool=false, model::Integer=1, seed::Integer=-1)
	setseed(seed, quiet)
	no = 4
	time = [1.,2.,3.,4.]
	ti = [1.,2.,3.,4.,5.]
	obs = [1.,2.,3.,4.]
	if !haskey(ENV, "MADS_NO_GADFLY") && plot
		ldat = Gadfly.layer(x=time, y=obs, ymin=obs .- 1, ymax=obs .+ 1, Gadfly.Geom.point, Gadfly.Geom.errorbar)
		f = Gadfly.plot(ldat, Gadfly.Guide.xlabel("y"), Gadfly.Guide.ylabel("x"), Gadfly.Guide.title("Infogap analysis: model setup"))
		Gadfly.draw(Gadfly.PNG(joinpath(Mads.dir, "examples", "model_analysis", "infogap_results", "model_setup.png"), 6Gadfly.inch, 4Gadfly.inch), f)
	end
	models = ["y = a * t + c", "y = a * t^(1.1) + b * t + c", "y = a * t^n + b * t + c", "y = a * exp(t * n) + b * t + c"]
	if model == 1
		np = 2
		pinit = [1.,1.]
		pmin = [-10,-5]
		pmax = [10,5]
		function fo1(t::Number, p::AbstractVector)
			return p[1] * t + p[2]
		end
		fo = fo1
	elseif model == 2
		np = 3
		pinit = [1.,1.,1.]
		pmin = [-10,-10,-5]
		pmax = [10,10,5]
		function fo2(t::Number, p::AbstractVector)
			return p[1] * (t ^ 1.1) + p[2] * t + p[3]
		end
		fo = fo2
	elseif model == 3
		np = 4
		pinit = [1.,1.,1.,1.]
		pmin = [-10,-10,-5,-3]
		pmax = [10,10,5,3]
		function fo3(t::Number, p::AbstractVector)
			return p[1] * (t ^ p[4]) + p[2] * t + p[3]
		end
		fo = fo3
	elseif model == 4
		np = 4
		pinit = [1.,1.,1.,1.]
		pmin = [-10,-10,-5,-3]
		pmax = [10,10,5,3]
		function fo4(t::Number, p::AbstractVector)
			return p[1] * exp(t * p[4]) + p[2] * t + p[3]
		end
		fo = fo4
	end
	plotrange = 1:0.1:5
	ymin = Array{Float64}(undef, length(plotrange))
	ymax = Array{Float64}(undef, length(plotrange))
	pi = similar(pinit)
	par_best = Array{Float64}(undef, 0)
	obs_best = Array{Float64}(undef, 0)
	hmin = Array{Float64}(undef, 0)
	hmax = Array{Float64}(undef, 0)
	for h in horizons
		for mm in ("Min", "Max")
			phi_best = (mm == "Max") ? -Inf : Inf
			for r = 1:retries
				m = JuMP.Model(Ipopt.Optimizer)
				JuMP.set_optimizer_attributes(m, "max_iter" => maxiter, "print_level" => verbosity)
				if r == 1 && !random
					for i = 1:np
						pi[i] = pinit[i]
					end
				else
					for i = 1:np
						pi[i] = rand(Mads.rng) * (pmax[i] - pmin[i]) + pmin[i]
					end
				end
				# @show pi
				@JuMP.variable(m, p[i = 1:np], start = pi[i])
				@JuMP.variable(m, o[1:no])
				@JuMP.constraint(m, p[1:np] .>= pmin[1:np])
				@JuMP.constraint(m, p[1:np] .<= pmax[1:np])
				@JuMP.constraint(m, o[1:no] .>= time[1:no] .- h)
				@JuMP.constraint(m, o[1:no] .<= time[1:no] .+ h)
				if model == 1
					if mm == "Max"
						@JuMP.NLobjective(m, Max, p[1] * ti[5] + p[2])
					else
						@JuMP.NLobjective(m, Min, p[1] * ti[5] + p[2])
					end
					@JuMP.NLconstraint(m, o[1] == p[1] * ti[1] + p[2])
					@JuMP.NLconstraint(m, o[2] == p[1] * ti[2] + p[2])
					@JuMP.NLconstraint(m, o[3] == p[1] * ti[3] + p[2])
					@JuMP.NLconstraint(m, o[4] == p[1] * ti[4] + p[2])
				elseif model == 2
					if mm == "Max"
						@JuMP.NLobjective(m, Max, p[1] * (ti[5]^(1.1)) + p[2] * ti[5] + p[3])
					else
						@JuMP.NLobjective(m, Min, p[1] * (ti[5]^(1.1)) + p[2] * ti[5] + p[3])
					end
					@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^(1.1)) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^(1.1)) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^(1.1)) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^(1.1)) + p[2] * ti[4] + p[3])
				elseif model == 3
					if mm == "Max"
						@JuMP.NLobjective(m, Max, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
					else
						@JuMP.NLobjective(m, Min, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
					end
					@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^p[4]) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^p[4]) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^p[4]) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^p[4]) + p[2] * ti[4] + p[3])
				elseif model == 4
					if mm == "Max"
						@JuMP.NLobjective(m, Max, p[1] * exp(ti[5] * p[4]) + p[2] * ti[5] + p[3])
					else
						@JuMP.NLobjective(m, Min, p[1] * exp(ti[5] * p[4]) + p[2] * ti[5] + p[3])
					end
					@JuMP.NLconstraint(m, o[1] == p[1] * exp(ti[1] * p[4]) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * exp(ti[2] * p[4]) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * exp(ti[3] * p[4]) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * exp(ti[4] * p[4]) + p[2] * ti[4] + p[3])
				end
				JuMP.optimize!(m)
				phi = JuMP.objective_value(m)
				# !quiet && println("OF = $(phi)")
				if mm == "Max"
					if phi_best < phi
						phi_best = phi
						par_best = JuMP.value.(p)
						obs_best = JuMP.value.(o)
					end
				else
					if phi_best > phi
						phi_best = phi
						par_best = JuMP.value.(p)
						obs_best = JuMP.value.(o)
					end
				end
			end
			!quiet && println("$(mm) h = $h OF = $(phi_best) par = $par_best")
			if mm == "Min"
				push!(hmin, phi_best)
				ymin = map(t->fo(t, par_best), plotrange)
			else
				push!(hmax, phi_best)
				ymax = map(t->fo(t, par_best), plotrange)
			end
		end
		if !haskey(ENV, "MADS_NO_GADFLY") && plot
			ldat = Gadfly.layer(x=time, y=obs, ymin=obs .- h, ymax=obs .+ h, Gadfly.Geom.point, Gadfly.Geom.errorbar)
			lmin = Gadfly.layer(x=plotrange, y=ymin, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "blue")))
			lmax = Gadfly.layer(x=plotrange, y=ymax, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red")))
			f = Gadfly.plot(ldat, lmin, lmax, Gadfly.Guide.xlabel("y"), Gadfly.Guide.ylabel("x"), Gadfly.Guide.title("Infogap analysis: h=$(h) Model: $(models[model])"))
			Gadfly.draw(Gadfly.PNG(joinpath(Mads.dir, "examples", "model_analysis", "infogap_results", "model_$(model)_h_$(h).png"), 6Gadfly.inch, 4Gadfly.inch), f)
		end
	end
	return hmin, hmax
end

mutable struct MadsModelPoly <: MathOptInterface.AbstractNLPEvaluator
end

"""
Information Gap Decision Analysis using MathOptInterface

$(DocumentFunction.documentfunction(infogap_moi_polynomial;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("horizons"=>"info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]",
            "retries"=>"number of solution retries [default=`1`]",
            "random"=>"random initial guesses [default=`false`]",
            "maxiter"=>"maximum number of iterations [default=`3000`]",
            "verbosity"=>"verbosity output level [default=`0`]",
            "seed"=>"random seed [default=`0`]",
            "pinit"=>"vector with initial parameters")))
"""
function infogap_moi_polynomial(madsdata::AbstractDict=Dict(); horizons::AbstractVector=[0.05, 0.1, 0.2, 0.5], retries::Integer=1, random::Bool=false, maxiter::Integer=3000, verbosity::Integer=0, seed::Integer=-1, rng=nothing, pinit::AbstractVector=[])
	setseed(seed, quiet)

	p = [0.,1.,0.,1.]
	np = length(p)
	if sizeof(pinit) == 0
		pinit = p
	end
	pmin = [-10,-10,-5,-3]
	pmax = [10,10,5,3]

	t = [1.,2.,3.,4.,5.]
	no = 4

	@eval function MathOptInterface.initialize(d::MadsModelPoly, requested_features::AbstractVector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	@eval MathOptInterface.features_available(d::MadsModelPoly) = [:Grad, :Jac]
	@eval function MathOptInterface.eval_f(d::MadsModelPoly, p::AbstractVector)
		of = p[1] * (t[5]^p[4]) + p[2] * t[5] + p[3]
		return of
	end
	@eval function MathOptInterface.eval_grad_f(d::MadsModelPoly, grad_f::AbstractVector, p::AbstractVector)
		grad_f[1] = t[5]^p[4]
		grad_f[2] = t[5]
		grad_f[3] = 1
		grad_f[4] = p[1] * (t[5]^p[4]) * log(t[5])
	end
	@eval function MathOptInterface.eval_g(d::MadsModelPoly, o::AbstractVector, p::AbstractVector)
		for i = 1:no
			o[i] = p[1] * (t[i]^p[4]) + p[2] * t[i] + p[3]
		end
	end
	@eval MathOptInterface.hessian_lagrangian_structure(d::MadsModelPoly) = Int[],Int[]
	@eval MathOptInterface.eval_hessian_lagrangian(d::MadsModelPoly, H, p, σ, μ) = nothing
	#=
	MathOptInterface.jacobian_structure(d::MadsModelPoly) = Int[],Int[]
	MathOptInterface.eval_jac_g(d::MadsModelPoly, J, p) = nothing
	=#
	@eval MathOptInterface.jacobian_structure(d::MadsModelPoly) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
	@eval function MathOptInterface.eval_jac_g(d::MadsModelPoly, J::AbstractVector, p::AbstractVector)
		ji = 0
		for i = 1:no
			J[ji + 1] = t[i]^p[4]
			J[ji + 2] = t[i]
			J[ji + 3] = 1
			J[ji + 4] = p[1] * (t[i]^p[4]) * log(t[i])
			ji += 4
		end
	end
	# madsdata = Mads.loadmadsfile("models/internal-polynomial.mads")
	solver = Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity)
	# Mads.setseed(seed; rng=rng)
	# f = Mads.makemadscommandfunction(madsdata)
	# pk = Mads.getoptparamkeys(madsdata)
	# pmin = Mads.getparamsmin(madsdata, pk)
	# pmax = Mads.getparamsmax(madsdata, pk)
	# pinit = Mads.getparamsinit(madsdata, pk)
	# np = length(pk)
	# ok = Mads.gettargetkeys(madsdata)
	# omin = Mads.getobsmin(madsdata, ok)
	# omax = Mads.getobsmax(madsdata, ok)
	# w = Mads.getobsweight(madsdata, ok)
	# t = Mads.getobstarget(madsdata, ok)
	# ti = Mads.getobstime(madsdata)
	# no = length(ok)

	par_best = Array{Float64}(undef, np)
	omin = Array{Float64}(undef, no)
	omax = Array{Float64}(undef, no)
	g = Array{Float64}(undef, no)
	for h in horizons
		par_best = pinit
		phi_best = MathOptInterface.eval_f(MadsModelPoly(), par_best)
		for mm = ("Min", "Max")
			phi_best = (mm == "Max") ? -Inf : Inf
			for r = 1:retries
				m = MathOptInterface.NonlinearModel(solver)
				for i = 1:no
					omin[i] = t[i] - h
					omax[i] = t[i] + h
				end
				MathOptInterface.loadproblem!(m, np, no, pmin, pmax, omin, omax, Symbol(mm), MadsModelPoly())
				if r > 1 || random
					for i = 1:np
						p[i] = rand(Mads.rng) * (pmax[i] - pmin[i]) + pmin[i]
					end
					MathOptInterface.setwarmstart!(m, p)
				else
					MathOptInterface.setwarmstart!(m, pinit)
				end
				MathOptInterface.optimize!(m)
				stat = MathOptInterface.status(m)
				phi = MathOptInterface.getobjval(m)
				par = MathOptInterface.getsolution(m)
				# println("OF = $(phi) $(stat)")
				if stat != :Infeasible
					if mm == "Max"
						if phi_best < phi
							phi_best = phi
							par_best = par
						end
					else
						if phi_best > phi
							phi_best = phi
							par_best = par
						end
					end
				end
				# @show MathOptInterface.getsolution(m)
			end
			# of = MathOptInterface.eval_f(MadsModelPoly(), par_best)
			# MathOptInterface.eval_g(MadsModelPoly(), g, par_best)
			# println("Optimal observations: $g")
			# f = Mads.forward(madsdata, par_best)
			# @show f
			println("$mm h = $h OF = $(phi_best) par = $par_best")
		end
	end
end

mutable struct MadsModelLin <: MathOptInterface.AbstractNLPEvaluator
end

"""
Information Gap Decision Analysis using MathOptInterface

$(DocumentFunction.documentfunction(infogap_moi_lin;
argtext=Dict("madsdata"=>"Mads problem dictionary"),
keytext=Dict("horizons"=>"info-gap horizons of uncertainty [default=`[0.05, 0.1, 0.2, 0.5]`]",
            "retries"=>"number of solution retries [default=`1`]",
            "random"=>"random initial guesses [default=`false`]",
            "maxiter"=>"maximum number of iterations [default=`3000`]",
            "verbosity"=>"verbosity output level [default=`0`]",
            "seed"=>"random seed [default=`0`]",
            "pinit"=>"vector with initial parameters")))
"""
function infogap_moi_lin(madsdata::AbstractDict=Dict(); horizons::AbstractVector=[0.05, 0.1, 0.2, 0.5], retries::Integer=1, random::Bool=false, maxiter::Integer=3000, verbosity::Integer=0, seed::Integer=-1, pinit::AbstractVector=[])
	setseed(seed, quiet)

	p = [1.,0.]
	np = length(p)
	if sizeof(pinit) == 0
		pinit = p
	end
	pmin = [-10.,-5.]
	pmax = [10.,5.]

	t = [1.,2.,3.,4.,5.]
	no = 4
	@eval function MathOptInterface.initialize(d::MadsModelLin, requested_features::AbstractVector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	@eval MathOptInterface.features_available(d::MadsModelLin) = [:Grad, :Jac]
	@eval function MathOptInterface.eval_f(d::MadsModelLin, p::AbstractVector)
		return p[1] * t[5] + p[2]
	end
	@eval function MathOptInterface.eval_grad_f(d::MadsModelLin, grad_f::AbstractVector, p::AbstractVector)
		grad_f[1] = t[5]
		grad_f[2] = 1
	end
	@eval function MathOptInterface.eval_g(d::MadsModelLin, o::AbstractVector, p::AbstractVector)
		for i = 1:no
			o[i] = p[1] * t[i] + p[2]
		end
	end
	@eval MathOptInterface.jacobian_structure(d::MadsModelLin) = [1,1,2,2,3,3,4,4],[1,2,1,2,1,2,1,2]
	@eval MathOptInterface.hessian_lagrangian_structure(d::MadsModelLin) = Int[],Int[]
	@eval function MathOptInterface.eval_jac_g(d::MadsModelLin, J::AbstractVector, p::AbstractVector)
		ji = 1
		for i = 1:no
			J[ji + 0] = t[i]
			J[ji + 1] = 1
			ji += 2
		end
	end
	solver = Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity)

	par_best = Array{Float64}(undef, np)
	omin = Array{Float64}(undef, no)
	omax = Array{Float64}(undef, no)
	g = Array{Float64}(undef, no)
	for h in horizons
		par_best = pinit
		phi_best = MathOptInterface.eval_f(MadsModelLin(), par_best)
		for mm = ("Min", "Max")
			phi_best = (mm == "Max") ? -Inf : Inf
			for r = 1:retries
				m = MathOptInterface.NonlinearModel(solver)
				for i = 1:no
					omin[i] = t[i] - h
					omax[i] = t[i] + h
				end
				MathOptInterface.loadproblem!(m, np, no, pmin, pmax, omin, omax, Symbol(mm), MadsModelLin())
				if r > 1 || random
					for i = 1:np
						p[i] = rand(Mads.rng) * (pmax[i] - pmin[i]) + pmin[i]
					end
					MathOptInterface.setwarmstart!(m, p)
				else
					MathOptInterface.setwarmstart!(m, pinit)
				end
				MathOptInterface.optimize!(m)
				stat = MathOptInterface.status(m)
				phi = MathOptInterface.getobjval(m)
				par = MathOptInterface.getsolution(m)
				# println("OF = $(phi) $(stat)")
				if stat != :Infeasible
					if mm == "Max"
						if phi_best < phi
							phi_best = phi
							par_best = par
						end
					else
						if phi_best > phi
							phi_best = phi
							par_best = par
						end
					end
				end
				#@show MathOptInterface.getsolution(m)
			end
			# of = MathOptInterface.eval_f(MadsModelLin(), par_best)
			# MathOptInterface.eval_g(MadsModelLin(), g, par_best)
			# println("Optimal observations: $g")
			# f = Mads.forward(madsdata, par_best)
			# @show f
			println("$mm h = $h OF = $(phi_best) par = $par_best")
		end
	end
end
