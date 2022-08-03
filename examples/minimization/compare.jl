import Mads
import JuMP
import Ipopt
import NLopt
import Random

Random.seed!(1)
xtrue = 1.3
d = collect(range(0, stop=3, length=100))
y = exp.(-d * xtrue) + 0.05 * randn(size(d))
Mads.plotseries(y; xaxis=d)

function func_nlopt(r...)
	x = collect(r)
	sum((exp.(-d*x[1])-y).^2)
end

function func_mads(x)
	exp.(-d*x[1])-y
end

nvar = 1

@info("NLopt")
m = JuMP.Model(NLopt.Optimizer)
JuMP.set_optimizer_attribute(m, "algorithm", :LD_MMA)
JuMP.register(m, :func_nlopt, nvar, func_nlopt; autodiff=true)
@JuMP.variable(m, x[1:nvar]; start=2)
@JuMP.NLobjective(m, Min, func_nlopt(x[1]))
@time JuMP.optimize!(m)
@show xtrue, JuMP.value.(x)

@info("Ipopt")
m = JuMP.Model(Ipopt.Optimizer)
JuMP.register(m, :func_nlopt, nvar, func_nlopt; autodiff=true)
@JuMP.variable(m, x[1:nvar]; start=2)
@JuMP.NLobjective(m, Min, func_nlopt(x[1]))
@time JuMP.optimize!(m)
@show xtrue, JuMP.value.(x)

@info("Mads")
@time minimizer, results = Mads.minimize(func_mads, [2.]; upperbounds=[4.], lowerbounds=[0.])
@show xtrue, minimizer