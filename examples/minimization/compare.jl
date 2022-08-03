import Mads
import JuMP
import Ipopt
import NLopt
import Random

Random.seed!(1)
xtrue = 1.3
btrue = 3
d = collect(range(0; stop=3, length=100))
y = exp.(-d .* xtrue) .+ btrue .+ 0.05 * randn(size(d))
Mads.plotseries(y; xaxis=d)

function func_jump(x...)
	sum(((exp.(-d * x[1]) .+ x[2]) .- y) .^ 2)
end

function func_mads(x)
	exp.(-d .* x[1]) .+ x[2] .- y
end

nvar = 2

@info("NLopt")
m = JuMP.Model(NLopt.Optimizer)
JuMP.set_optimizer_attribute(m, "algorithm", :LD_MMA)
JuMP.register(m, :func_jump, nvar, func_jump; autodiff=true)
@JuMP.variable(m, x[1:nvar]; start=2)
@JuMP.NLobjective(m, Min, func_jump(x...))
@time JuMP.optimize!(m)
@show xtrue, btrue, JuMP.value.(x)

@info("Ipopt")
m = JuMP.Model(Ipopt.Optimizer)
JuMP.register(m, :func_jump, nvar, func_jump; autodiff=true)
@JuMP.variable(m, x[1:nvar]; start=2)
@JuMP.NLobjective(m, Min, func_jump(x...))
@time JuMP.optimize!(m)
@show xtrue, btrue, JuMP.value.(x)

@info("Mads")
@time minimizer, results = Mads.minimize(func_mads2, [2., 2.]; upperbounds=[4., 4.], lowerbounds=[0., 0.])
@show xtrue, btrue, minimizer