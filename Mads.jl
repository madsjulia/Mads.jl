using Optim

include("tests.jl")

f = rosenbrock
g! = rosenbrock_gradient!
h! = rosenbrock_hessian!

optimize(f, [0.0, 0.0])
results = Optim.levenberg_marquardt(rosenbrock_lm, rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
println(results)

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector)
	sineparams = asind((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return params
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector)
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sind(sineparams)) * .5)
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedgradient(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		straightgrad = g(params)
		f(x) = (upperbounds - lowerbounds) .* (cosd(sineparams) * .5 * pi / 180)
		transformgrad = (upperbounds - lowerbounds) .* f(params)
		return straightgrad .* transformgrad
	end
	return sinetransformedgradient
end

lowerbounds = [-2, -2]
# upperbounds = [.5, .5]
upperbounds = [2, 2]
sin_rosenbrock_lm = sinetransformfunction(rosenbrock_lm, lowerbounds, upperbounds)
sin_rosenbrock_gradient_lm = sinetransformgradient(rosenbrock_gradient_lm, lowerbounds, upperbounds)
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, asinetransform([0.0, 0.0], lowerbounds, upperbounds), show_trace=false)
println(results)
println(sinetransform(results.minimum, lowerbounds, upperbounds))
