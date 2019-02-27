import JuMP
import Ipopt

function testme1(init::Vector, targets::Vector)
	@assert length(init) == length(targets)
	global x
	global function myf1(a...)
		sum((collect(a).-targets).^2)
	end

	global m = JuMP.Model(solver=Ipopt.IpoptSolver())

	global nvar = length(init)

	JuMP.register(m, :myf1, nvar, myf1, autodiff=true)
	@JuMP.variable(m, x[i=1:nvar], start=init[i])

	# @JuMP.NLobjective(m, Min, myf1(x[1], x[2], x[3])) # works
	# @JuMP.NLobjective(m, Min, :("myf1(x[1], x[2], x[3])")) # does not work
	# @JuMP.NLobjective(m, Min, myf1(x[1:3]...)) # does not work
	@eval @JuMP.NLobjective(m, Min, $(Expr(:call, :myf1, [Expr(:ref, :x, i) for i=1:nvar]...))) # works

	JuMP.optimize!(m)
	result = JuMP.value.(x)
	@show result
	@show targets
	return result
end

function testme2(init::Vector, targets::Vector)
	@assert length(init) == length(targets)
	nvar = length(init)
	function myf2(a...)
		sum((collect(a).-targets).^2)
	end
	result = generatedtestme2(Val{nvar}, init, myf2)
	@show result
	@show targets
	return result
end

@generated function generatedtestme2{nvar}(::Type{Val{nvar}}, init::Vector, myf2::Function)
	myfcall = macroexpand(:(@Base.Cartesian.ncall $nvar myf2 i->x[i]))
	q = quote
		nvar = length(init)
		m = JuMP.Model(solver=Ipopt.IpoptSolver())
		JuMP.register(m, :myf2, nvar, myf2, autodiff=true)
		@JuMP.variable(m, x[i=1:nvar], start=init[i])
		@JuMP.NLobjective(m, Min, $myfcall)
		JuMP.optimize!(m)
		return JuMP.value.(x)
	end
	return q
end

testme1(rand(12), rand(12))
testme2(rand(12), rand(12))