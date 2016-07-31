import JuMP
import MathProgBase
import Ipopt
import Gadfly

"Information Gap Decision Analysis using JuMP"
function infogap_jump(madsdata::Associative=Dict(); retries::Int=1, random::Bool=false, maxiter::Int=3000, verbosity::Int=0, seed=0)
	#madsdata = Mads.loadmadsfile("models/internal-polynomial.mads")
	#Mads.setseed(seed)
	if seed != 0
		srand(seed)
	else
		s = Int(Base.Random.GLOBAL_RNG.seed[1])
		info("Current seed: $s")
	end
	#=
	f = Mads.makemadscommandfunction(madsdata)
	pk = Mads.getoptparamkeys(madsdata)
	pmin = Mads.getparamsmin(madsdata, pk)
	pmax = Mads.getparamsmax(madsdata, pk)
	pinit = Mads.getparamsinit(madsdata, pk)
	np = length(pk)
	ok = Mads.gettargetkeys(madsdata)
	omin = Mads.getobsmin(madsdata, ok)
	omax = Mads.getobsmax(madsdata, ok)
	w = Mads.getobsweight(madsdata, ok)
	t = Mads.getobstarget(madsdata, ok)
	ti = Mads.getobstime(madsdata)
	no = length(ok)
	=#
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
	for h = (0.1, 0.2)
		phi_best = 0
		for r = 1:retries
			m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
			if r > 1 || random
				for i = 1:np
					pinit[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
				end
			end
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
			#@JuMP.NLobjective(m, Min, sum{w[i] * ((p[1] * (ti[i]^p[2]) + p[3] * ti[i] + p[4]) - t[i])^2, i=1:no})
			@JuMP.NLobjective(m, Max, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
			JuMP.solve(m)
			phi = JuMP.getobjectivevalue(m)	
			println("OF = $(phi)")
			if phi_best < phi
				phi_best = phi
				par_best = JuMP.getvalue(p)
				obs_best = JuMP.getvalue(o)
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
					pinit[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
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
			#@JuMP.NLobjective(m, Min, sum{w[i] * ((p[1] * (ti[i]^p[2]) + p[3] * ti[i] + p[4]) - t[i])^2, i=1:no})
			@JuMP.NLobjective(m, Min, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
			JuMP.solve(m)
			phi = JuMP.getobjectivevalue(m)	
			println("OF = $(phi)")
			if phi_best > phi
				phi_best = phi
				par_best = JuMP.getvalue(p)
				obs_best = JuMP.getvalue(o)
			end
		end
		println("Min h = $h OF = $(phi_best) par = $par_best")
		=#
	end
end

function infogap_jump_polinomial(madsdata::Associative=Dict(); horizons::Vector=[0.05, 0.1, 0.2, 0.5], retries::Int=1, random::Bool=false, maxiter::Int=3000, verbosity::Int=0, quiet::Bool=false, plot::Bool=false, model::Int=1, seed=0)
	if seed != 0
		srand(seed)
	else
		s = Int(Base.Random.GLOBAL_RNG.seed[1])
		!quiet && info("Current seed: $s")
	end
	no = 4
	time = [1.,2.,3.,4.]
	ti = [1.,2.,3.,4.,5.]
	obs = [1.,2.,3.,4.]
	if plot
		ldat = Gadfly.layer(x=time, y=obs, ymin=obs-1, ymax=obs+1, Gadfly.Geom.point, Gadfly.Geom.errorbar)
		f = Gadfly.plot(ldat, Gadfly.Guide.xlabel("y"), Gadfly.Guide.ylabel("x"), Gadfly.Guide.title("Infogap analysis: model setup"))
		Gadfly.draw(Gadfly.PNG(Pkg.dir("Mads") * "/examples/model_analysis/infogap_results/model_setup.png", 6Gadfly.inch, 4Gadfly.inch), f)
	end
	models = ["y = a * t + c", "y = a * t^(1.1) + b * t + c", "y = a * t^n + b * t + c", "y = a * exp(t * n) + b * t + c"]
	if model == 1
		np = 2
		pinit = [1.,1.]
		pmin = [-10,-5]
		pmax = [10,5]
		function fo(t::Number, p::Vector)
			return p[1] * t + p[2]
		end
	elseif model == 2
		np = 3
		pinit = [1.,1.,1.]
		pmin = [-10,-10,-5]
		pmax = [10,10,5]
		function fo(t::Number, p::Vector)
			return p[1] * (t ^ 1.1) + p[2] * t + p[3]
		end
	elseif model == 3
		np = 4
		pinit = [1.,1.,1.,1.]
		pmin = [-10,-10,-5,-3]
		pmax = [10,10,5,3]
		function fo(t::Number, p::Vector)
			return p[1] * (t ^ p[4]) + p[2] * t + p[3]
		end
	elseif model == 4
		np = 4
		pinit = [1.,1.,1.,1.]
		pmin = [-10,-10,-5,-3]
		pmax = [10,10,5,3]
		function fo(t::Number, p::Vector)
			return p[1] * exp(t * p[4]) + p[2] * t + p[3]
		end
	end
	plotrange = 1:0.1:5
	ymin = Array(Float64, length(plotrange))
	ymax = Array(Float64, length(plotrange))
	pi = similar(pinit)
	par_best = Array(Float64, 0)
	obs_best = Array(Float64, 0)
	hmin = Array(Float64, 0)
	hmax = Array(Float64, 0)
	for h in horizons
		for mm = ("Min", "Max")
			phi_best = (mm == "Max") ? 0 : Inf
			for r = 1:retries
				m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
				if r == 1 && !random
					for i = 1:np
						pi[i] = pinit[i]
					end
				else
					for i = 1:np
						pi[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
					end
				end
				# @show pi
				@JuMP.variable(m, p[i = 1:np], start = pi[i])
				@JuMP.variable(m, o[1:no])
				@JuMP.constraint(m, p[i = 1:np] .>= pmin[i = 1:np])
				@JuMP.constraint(m, p[i = 1:np] .<= pmax[i = 1:np])
				@JuMP.constraint(m, o[i = 1:no] .>= time[i = 1:no] - h)
				@JuMP.constraint(m, o[i = 1:no] .<= time[i = 1:no] + h)
				if model == 1
					@JuMP.NLobjective(m, symbol(mm), p[1] * ti[5] + p[2])
					@JuMP.NLconstraint(m, o[1] == p[1] * ti[1] + p[2])
					@JuMP.NLconstraint(m, o[2] == p[1] * ti[2] + p[2])
					@JuMP.NLconstraint(m, o[3] == p[1] * ti[3] + p[2])
					@JuMP.NLconstraint(m, o[4] == p[1] * ti[4] + p[2])
				elseif model == 2
					@JuMP.NLobjective(m, symbol(mm), p[1] * (ti[5]^(1.1)) + p[2] * ti[5] + p[3])
					@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^(1.1)) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^(1.1)) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^(1.1)) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^(1.1)) + p[2] * ti[4] + p[3])
				elseif model == 3
					@JuMP.NLobjective(m, symbol(mm), p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
					@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^p[4]) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^p[4]) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^p[4]) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^p[4]) + p[2] * ti[4] + p[3])
				elseif model == 4
					@JuMP.NLobjective(m, symbol(mm), p[1] * exp(ti[5] * p[4]) + p[2] * ti[5] + p[3])
					@JuMP.NLconstraint(m, o[1] == p[1] * exp(ti[1] * p[4]) + p[2] * ti[1] + p[3])
					@JuMP.NLconstraint(m, o[2] == p[1] * exp(ti[2] * p[4]) + p[2] * ti[2] + p[3])
					@JuMP.NLconstraint(m, o[3] == p[1] * exp(ti[3] * p[4]) + p[2] * ti[3] + p[3])
					@JuMP.NLconstraint(m, o[4] == p[1] * exp(ti[4] * p[4]) + p[2] * ti[4] + p[3])
				end
				JuMP.solve(m)
				phi = JuMP.getobjectivevalue(m)
				# !quiet && println("OF = $(phi)")
				if mm == "Max"
					if phi_best < phi
						phi_best = phi
						par_best = JuMP.getvalue(p)
						obs_best = JuMP.getvalue(o)
					end
				else
					if phi_best > phi
						phi_best = phi
						par_best = JuMP.getvalue(p)
						obs_best = JuMP.getvalue(o)
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
		if plot
			ldat = Gadfly.layer(x=time, y=obs, ymin=obs-h, ymax=obs+h, Gadfly.Geom.point, Gadfly.Geom.errorbar)
			lmin = Gadfly.layer(x=plotrange, y=ymin, Gadfly.Geom.line, Gadfly.Theme(default_color=parse(Colors.Colorant, "blue")))
			lmax = Gadfly.layer(x=plotrange, y=ymax, Gadfly.Geom.line, Gadfly.Theme(default_color=parse(Colors.Colorant, "red")))
			f = Gadfly.plot(ldat, lmin, lmax, Gadfly.Guide.xlabel("y"), Gadfly.Guide.ylabel("x"), Gadfly.Guide.title("Infogap analysis: h=$(h) Model: $(models[model])"))
			Gadfly.draw(Gadfly.PNG(Pkg.dir("Mads") * "/examples/model_analysis/infogap_results/model_$(model)_h_$(h).png", 6Gadfly.inch, 4Gadfly.inch), f)
		end
	end
	return hmin, hmax
end

type MadsModel <: MathProgBase.AbstractNLPEvaluator
end

no = 4
ti = [1,2,3,4,5]

function MathProgBase.initialize(d::MadsModel, requested_features::Vector{Symbol})
	for feat in requested_features
		if !(feat in [:Grad, :Jac, :Hess])
			error("Unsupported feature $feat")
		end
	end
end
MathProgBase.features_available(d::MadsModel) = [:Grad, :Jac]
function MathProgBase.eval_f(d::MadsModel, p)
	of = p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3]
	return of
end
function MathProgBase.eval_grad_f(d::MadsModel, grad_f, p)
	grad_f[1] = ti[5]^p[4]
	grad_f[2] = ti[5]
	grad_f[3] = 1
	grad_f[4] = p[1] * (ti[5]^p[4]) * log(ti[5])
end
function MathProgBase.eval_g(d::MadsModel, o, p)
	for i = 1:no
		o[i] = p[1] * (ti[i]^p[4]) + p[2] * ti[i] + p[3]
	end
end
MathProgBase.hesslag_structure(d::MadsModel) = Int[],Int[]
MathProgBase.eval_hesslag(d::MadsModel, H, p, σ, μ) = nothing
#=
MathProgBase.jac_structure(d::MadsModel) = Int[],Int[]
MathProgBase.eval_jac_g(d::MadsModel, J, p) = nothing
=#
MathProgBase.jac_structure(d::MadsModel) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
function MathProgBase.eval_jac_g(d::MadsModel, J, p)
	for i = 1:no
		J[i + 0] = ti[i]^p[4]
		J[i + 1] = ti[i]
		J[i + 2] = 1
		J[i + 3] = p[1] * (ti[i]^p[4]) * log(ti[i])
	end
end
#=
MathProgBase.hesslag_structure(d::MadsModel) = [1,2,2,3,3,3,4,4,4,4],[1,1,2,1,2,3,1,2,3,4]
function MathProgBase.eval_hesslag(d::MadsModel, H, p, σ, μ)
	H[1] = 0 #1,1
	H[2] = 0 #2,1
	H[3] = 0 #2,2
	H[4] = 0 #3,1
	H[5] = 0 #3,2
	H[6] = 0 #3,3
	H[7] = σ * (ti[5]^p[4]) * log(ti[5]) #4,1
	H[8] = 0 #4,2
	H[9] = 0 #4,3
	H[10] = σ * p[1] * m(ti[5]^p[4]) * log(ti[5])^2 # 4,4
	for i = 1:no
		H[7] += μ[i] * (ti[i]^p[4]) * log(ti[i]) #4,1
		H[10] += μ[i] * p[1] * (ti[i]^p[4]) * log(ti[i])^2 # 4,4
	end
end
=#

"Information Gap Decision Analysis using MathProgBase"
function infogap_mpb(madsdata::Associative=Dict(); retries=1, random=false, maxiter=3000, verbosity=0, solver=MathProgBase.defaultNLPsolver, seed=0, pinit=[])
	# madsdata = Mads.loadmadsfile("models/internal-polynomial.mads")
	solver = Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity)
	if seed != 0
		srand(seed)
	else
		s = Int(Base.Random.GLOBAL_RNG.seed[1])
		info("Current seed: $s")
	end
	# Mads.setseed(seed)
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
	par_best = []
	omin = [1.,2.,3.,4.]
	omax = [1.,2.,3.,4.]
	t = [1.,2.,3.,4.,0]
	np = 4
	p = [0.,1.,0.,1.]
	if sizeof(pinit) == 0 
		pinit = [1.,0.]
	end
	pmin = [-0.1,0.99,-0.1,0.99]
	pmax = [0.1,1.001,0.1,1.001]
	g = [1.0,1.0,1.0,1.0]
	for h = (0.1, 0.2)
		par_best = pinit
		phi_best = MathProgBase.eval_f(MadsModel(), par_best)
		for r = 1:retries
			m = MathProgBase.NonlinearModel(solver)
			for i = 1:no
				omin[i] = t[i] - h
				omax[i] = t[i] + h
			end
			MathProgBase.loadproblem!(m, 4, 4, pmin, pmax, omin, omax, :Max, MadsModel())
			if r > 1 || random
				for i = 1:np
					p[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
				end
				MathProgBase.setwarmstart!(m, p)
			else
				MathProgBase.setwarmstart!(m, pinit)
			end
			MathProgBase.optimize!(m)
			stat = MathProgBase.status(m)
			phi = MathProgBase.getobjval(m)
			par = MathProgBase.getsolution(m)
			println("OF = $(phi) $(stat)")
			if stat == :Optimal && phi_best < phi
				phi_best = phi
				par_best = par
			end
			#@show MathProgBase.getsolution(m)
			#MathProgBase.eval_g(MadsModel(), g, par)
			#@show g
		end
		info("done")
		of = MathProgBase.eval_f(MadsModel(), par_best)
		@show of
		MathProgBase.eval_g(MadsModel(), g, par_best)
		@show g
		@show pinit
		@show omin
		@show omax
		@show pmin
		@show pmax
		# f = Mads.forward(madsdata, par_best)
		# @show f
		println("Max h = $h OF = $(phi_best) par = $par_best")
	end
end

type MadsModelLin <: MathProgBase.AbstractNLPEvaluator
end

no = 4
ti = [1,2,3,4,5]

function MathProgBase.initialize(d::MadsModelLin, requested_features::Vector{Symbol})
	for feat in requested_features
		if !(feat in [:Grad, :Jac, :Hess])
			error("Unsupported feature $feat")
		end
	end
end
MathProgBase.features_available(d::MadsModelLin) = [:Grad, :Jac]
MathProgBase.eval_f(d::MadsModelLin, p) = p[1] * ti[5] + p[2]
function MathProgBase.eval_grad_f(d::MadsModelLin, grad_f, p)
	grad_f[1] = ti[5]
	grad_f[2] = 1
end
function MathProgBase.eval_g(d::MadsModelLin, o, p)
	for i = 1:no
		o[i] = p[1] * ti[i] + p[2]
	end
end
MathProgBase.jac_structure(d::MadsModelLin) = [1,1,2,2,3,3,4,4],[1,2,1,2,1,2,1,2]
MathProgBase.hesslag_structure(d::MadsModelLin) = Int[],Int[]
function MathProgBase.eval_jac_g(d::MadsModelLin, J, p)
	for i = 1:no
		J[i + 0] = ti[i]
		J[i + 1] = 1
	end
end

"Information Gap Decision Analysis using MathProgBase"
function infogap_mpblin(madsdata::Associative=Dict(); retries=1, random=false, maxiter=3000, verbosity=0, solver=MathProgBase.defaultNLPsolver, seed=0, pinit=[])
	# madsdata = Mads.loadmadsfile("models/internal-linear.mads")
	solver = Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity)
	if seed != 0
		srand(seed)
	else
		s = Int(Base.Random.GLOBAL_RNG.seed[1])
		info("Current seed: $s")
	end
	# Mads.setseed(seed)
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
	par_best = []
	omin = [1.,2.,3.,4.]
	omax = [1.,2.,3.,4.]
	t = [1.,2.,3.,4.,0]
	np = 2
	if sizeof(pinit) == 0 
		pinit = [1.,0.]
	end
	p = [1.,0.]
	pmin = [-10.,-5.]
	pmax = [10.,5.]
	g = [1.0,1.0,1.0,1.0]
	for h = (0.1, 0.2)
		par_best = pinit
		phi_best = MathProgBase.eval_f(MadsModelLin(), par_best)
		for r = 1:retries
			m = MathProgBase.NonlinearModel(solver)
			for i = 1:no
				omin[i] = t[i] - h
				omax[i] = t[i] + h
			end
			MathProgBase.loadproblem!(m, 2, 4, pmin, pmax, omin, omax, :Max, MadsModelLin())
			if r > 1 || random
				for i = 1:np
					p[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
				end
				MathProgBase.setwarmstart!(m, p)
			else
				MathProgBase.setwarmstart!(m, pinit)
			end
			MathProgBase.optimize!(m)
			stat = MathProgBase.status(m)
			phi = MathProgBase.getobjval(m)
			par = MathProgBase.getsolution(m)
			println("OF = $(phi) $(stat)")
			if stat == :Optimal && phi_best < phi
				phi_best = phi
				par_best = par
			end
			# @show MathProgBase.getsolution(m)
			MathProgBase.eval_g(MadsModelLin(), g, par)
			# @show g
		end
		of = MathProgBase.eval_f(MadsModelLin(), par_best)
		@show of
		MathProgBase.eval_g(MadsModelLin(), g, par_best)
		@show g
		@show pinit
		@show omin
		@show omax
		@show pmin
		@show pmax
		# f = Mads.forward(madsdata, par_best)
		# @show f
		println("Max h = $h OF = $(phi_best) par = $par_best")
	end
end