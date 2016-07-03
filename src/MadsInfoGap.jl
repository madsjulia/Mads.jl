import JuMP
import Ipopt

"Information Gap Decision Analysis"
function infogap(madsdata::Associative; retries=1, random=false, maxiter=100000, verbosity=0)
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
	for h = (0.1, 1, 2, 5, 10)
		phi_best = 0
		for r = 1:retries
			m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
			if r > 1 || random
				@JuMP.variable(m, p[i=1:np], start=rand() * (pmax[i] - pmin[i]) + pmin[i])
			else
				@JuMP.variable(m, p[i=1:np], start=pinit[i])
			end
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
			# println("OF = $(phi)")
			if phi_best < phi
				phi_best = phi
				par_best = JuMP.getvalue(p)
				obs_best = JuMP.getvalue(o)
			end
		end
		println("Max h = $h OF = $(phi_best) par = $par_best")
		phi_best = Inf
		for r = 1:retries
			m = JuMP.Model(solver=Ipopt.IpoptSolver(max_iter=maxiter, print_level=verbosity))
			if r > 1 || random
				@JuMP.variable(m, p[i=1:np], start=rand() * (pmax[i] - pmin[i]) + pmin[i])
			else
				@JuMP.variable(m, p[i=1:np], start=pinit[i])
			end
			# @show JuMP.getvalue(p)
			@JuMP.variable(m, o[1:no])
			@JuMP.NLconstraint(m, o[1] == p[1] * (ti[1]^p[4]) + p[2] * ti[1] + p[3])
			@JuMP.NLconstraint(m, o[2] == p[1] * (ti[2]^p[4]) + p[2] * ti[2] + p[3])
			@JuMP.NLconstraint(m, o[3] == p[1] * (ti[3]^p[4]) + p[2] * ti[3] + p[3])
			@JuMP.NLconstraint(m, o[4] == p[1] * (ti[4]^p[4]) + p[2] * ti[4] + p[3])
			@JuMP.constraint(m, p[i=1:np] .>= pmin[i=1:np])
			@JuMP.constraint(m, p[i=1:np] .<= pmax[i=1:np])
			#@JuMP.constraint(m, o[i=1:no] .>= omin[i=1:no])
			#JuMP.constraint(m, o[i=1:no] .<= omax[i=1:no])
			@JuMP.constraint(m, o[i=1:no] .>= t[i=1:no]-h)
			@JuMP.constraint(m, o[i=1:no] .<= t[i=1:no]+h)
			#@JuMP.NLobjective(m, Min, sum{w[i] * ((p[1] * (ti[i]^p[2]) + p[3] * ti[i] + p[4]) - t[i])^2, i=1:no})
			@JuMP.NLobjective(m, Min, p[1] * (ti[5]^p[4]) + p[2] * ti[5] + p[3])
			JuMP.solve(m)
			phi = JuMP.getobjectivevalue(m)	
			# println("OF = $(phi)")
			if phi_best > phi
				phi_best = phi
				par_best = JuMP.getvalue(p)
				obs_best = JuMP.getvalue(o)
			end
		end
		println("Min h = $h OF = $(phi_best) par = $par_best")
	end
end