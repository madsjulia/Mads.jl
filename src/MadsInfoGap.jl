import JuMP
import MathProgBase
import Ipopt

# JuMP has issues with @JuMP.variable()

"Information Gap Decision Analysis using JuMP"
function infogap_jump(madsdata::Associative; retries=1, random=false, maxiter=100, verbosity=0, seed=0)
	Mads.setseed(seed)
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
	function fm(p...)
	end
	function gm(g, p...)
	end
	par_best = []
	obs_best = []
	for h = (0.1)
		phi_best = 0
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
		pinit = Mads.getparamsinit(madsdata, pk)
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
	end
end

type MadsModel <: MathProgBase.AbstractNLPEvaluator
end

"Information Gap Decision Analysis using MathProgBase"
function infogap_mpb(madsdata::Associative; retries=1, random=false, maxiter=100, verbosity=0, solver=MathProgBase.defaultNLPsolver, seed=0)
	solver = Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity)
	Mads.setseed(seed)
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
	function MathProgBase.initialize(d::MadsModel, requested_features::Vector{Symbol})
		for feat in requested_features
			if !(feat in [:Grad, :Jac, :Hess])
				error("Unsupported feature $feat")
			end
		end
	end
	MathProgBase.features_available(d::MadsModel) = [:Grad, :Jac]
	MathProgBase.eval_f(d::MadsModel, p) = p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3]
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
	MathProgBase.jac_structure(d::MadsModel) = [1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4],[1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4]
	# MathProgBase.hesslag_structure(d::MadsModel) = Int[],Int[]
	function MathProgBase.eval_jac_g(d::MadsModel, J, p)
		for i = 1:no
			J[i + 0] = ti[i]^p[4]
			J[i + 1] = ti[i]
			J[i + 2] = 1
			J[i + 3] = p[1] * (ti[i]^p[4]) * log(ti[i])
		end
	end
	par_best = []
	g = [1.0,1.0,1.0,1.0]
	for h = (0.1)
		phi_best = -Inf
		for r = 1:retries
			m = MathProgBase.NonlinearModel(solver)
			for i = 1:no
				omin[i] = t[i] - h * 1000
				omax[i] = t[i] + h * 1000
			end
			MathProgBase.loadproblem!(m, 4, 4, pmin, pmax, omin, omax, :Max, MadsModel())
			if r > 1 || random
				for i = 1:np
					pinit[i] = rand() * (pmax[i] - pmin[i]) + pmin[i]
				end
			end
			# MathProgBase.setwarmstart!(m, pinit)
			MathProgBase.optimize!(m)
			stat = MathProgBase.status(m)
			phi = MathProgBase.getobjval(m)
			println("OF = $(phi)")
			if phi_best < phi
				phi_best = phi
				par_best = MathProgBase.getsolution(m)
			end
			@show MathProgBase.getsolution(m)
		end
		of = MathProgBase.eval_f(MadsModel(), par_best)
		@show of
		MathProgBase.eval_g(MadsModel(), g, par_best)
		@show g
		@show pinit
		@show omin
		@show omax
		@show pmin
		@show pmax
		f = Mads.forward(madsdata, par_best)
		@show f
		println("Max h = $h OF = $(phi_best) par = $par_best")
	end
end