import JuMP
import Ipopt

function testme()
	global x
	global function myf(a...)
		sum(collect(a).^2)
	end

	global m = JuMP.Model(solver=Ipopt.IpoptSolver())

	global nvar = 12

	JuMP.register(m, :myf, nvar, myf, autodiff=true)
	@JuMP.variable(m, x[1:nvar], start=rand())

	# @JuMP.NLobjective(m, Min, myf(x[1], x[2], x[3])) # works
	# @JuMP.NLobjective(m, Min, :("myf(x[1], x[2], x[3])")) # does not work
	# @JuMP.NLobjective(m, Min, myf(x[1:3]...)) # does not work
	@eval @JuMP.NLobjective(m, Min, $(Expr(:call, :myf, [Expr(:ref, :x, i) for i=1:nvar]...))) # works

	JuMP.solve(m)
end

testme()