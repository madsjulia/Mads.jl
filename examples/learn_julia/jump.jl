import JuMP
import Ipopt

function testme1(init::Vector, targets::Vector)
	global x
	global function myf(a...)
		sum((collect(a).-targets).^2)
	end

	global m = JuMP.Model(solver=Ipopt.IpoptSolver())

	global nvar = 12

	JuMP.register(m, :myf, nvar, myf, autodiff=true)
	@JuMP.variable(m, x[i=1:nvar], start=init[i])

	if VERSION >= v"0.6.0"
		xi = JuMP.getvalue(x)
		@show xi
		Base.invokelatest(myf, xi...)
	end

	# @JuMP.NLobjective(m, Min, myf(x[1], x[2], x[3])) # works
	# @JuMP.NLobjective(m, Min, :("myf(x[1], x[2], x[3])")) # does not work
	# @JuMP.NLobjective(m, Min, myf(x[1:3]...)) # does not work
	@eval @JuMP.NLobjective(m, Min, $(Expr(:call, :myf, [Expr(:ref, :x, i) for i=1:nvar]...))) # works

	JuMP.solve(m)
	result = JuMP.getvalue(x)
	@show result
	@show targets
	return result
end

function testme2(init::Vector, targets::Vector)
	nvar = length(init)
	result = wrapppertestme2(Val{nvar}, init, targets)
	@show result
	@show targets
	return result
end

@generated function wrapppertestme2{nvar}(::Type{Val{nvar}}, init::Vector, targets::Vector)
	myfcall = macroexpand(:(@Base.Cartesian.ncall $nvar myf2 i->x[i]))
	q = quote
		nvar = length(init)
		function myf2(a...)
			sum((collect(a).-targets).^2)
		end
		m = JuMP.Model(solver=Ipopt.IpoptSolver())
		JuMP.register(m, :myf, nvar, myf2, autodiff=true)
		@JuMP.variable(m, x[i=1:nvar], start=init[i])
		@JuMP.NLobjective(m, Min, $myfcall)
		JuMP.solve(m)
		return JuMP.getvalue(x)
	end
	return q
end

# testme2(rand(12), rand(12))
testme1(rand(12), rand(12))