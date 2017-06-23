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

@generated function testme2{nvar}(::Type{Val{nvar}}, t::Vector)
	myfcall = macroexpand(:(@Base.Cartesian.ncall $nvar myf i->x[i]))
	q = quote
		nvar = length(t)
		function myf(a...)
			sum((collect(a).-t).^2)
		end
		m = JuMP.Model(solver=Ipopt.IpoptSolver())
		JuMP.register(m, :myf, nvar, myf, autodiff=true)
		@JuMP.variable(m, x[1:nvar], start=rand())
		@JuMP.NLobjective(m, Min, $myfcall)
		JuMP.solve(m)
		return JuMP.getvalue(x)
	end
	return q
end

testme2(Val{12}, rand(12))
# testme()