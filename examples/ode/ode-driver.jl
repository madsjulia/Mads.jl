import ODE
import DataStructures

function madsmodelrun(parameters::Associative)
	omega = parameters["omega"]
	k = parameters["k"]
	function makefunc(parameters::Associative)
		function func(t, y)
			# x''[t] == -\omega^2 * x[t] - k * x'[t]
			f = similar(y)
			f[1] = y[2] # u' = v
			f[2] = -omega * omega * y[1] - k * y[2] # v' = -omega^2*u - k*v
			f
		end
		return func
	end

	funcosc = makefunc(parameters)
	times = collect(0:.1:100)
	initialconditions = [1.,0.]
	t, y = ODE.ode23s(funcosc, initialconditions, times, points=:specified)
	ys = hcat(y...).' # vecorize the output and transpose with '
	predictions = DataStructures.OrderedDict{AbstractString, Float64}(zip(map(i -> string("o", i), times), ys[:,1]))
	return predictions
end
