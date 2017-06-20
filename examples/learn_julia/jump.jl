import JuMP
import Ipopt

myf(a...) = sum(collect(a).^2)

m = JuMP.Model(solver=Ipopt.IpoptSolver())

JuMP.register(m, :myf, 3, myf, autodiff=true)
@JuMP.variable(m, x[1:3] >= 0.5)
# @JuMP.NLobjective(m, Min, myf(x[1], x[2], x[3])) # works
# @JuMP.NLobjective(m, Min, myf(x[1:3]...)) # does not work
@eval @JuMP.NLobjective(m, Min, $(Expr(:call, :myf, [Expr(:ref, :x, i) for i=1:3]...))) # works


JuMP.solve(m)