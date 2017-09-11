import Mads
import JuMP
import Ipopt
import NLopt

srand(1)
d = collect(linspace(0,3,100))
y = exp.(-1.3*d) + 0.05*randn(size(d))

function func_nlopt(r...)
	x = collect(r)
	sum((exp.(-d*x[1])-y).^2)
end

function func_mads(x)
	exp.(-d*x[1])-y
end

nvar = 1

info("NLopt")
m = JuMP.Model(solver=NLopt.NLoptSolver(algorithm=:LD_LBFGS))
JuMP.register(m, :func_nlopt, nvar, func_nlopt, autodiff=true)
@JuMP.variable(m, x[i=1:nvar], start=2)
JuMP.setNLobjective(m, :Min, Expr(:call, :func_nlopt, [x[i] for i=1:nvar]...))
@time JuMP.solve(m)
JuMP.getvalue(x)

info("Ipopt")
m = JuMP.Model(solver=Ipopt.IpoptSolver())
JuMP.register(m, :func_nlopt, nvar, func_nlopt, autodiff=true)
@JuMP.variable(m, x[i=1:nvar], start=2)
JuMP.setNLobjective(m, :Min, Expr(:call, :func_nlopt, [x[i] for i=1:nvar]...))
@time JuMP.solve(m)
JuMP.getvalue(x)

info("Mads")
@time minimizer, results = Mads.minimize(func_mads, [2.]; upperbounds=[4.], lowerbounds=[0.])