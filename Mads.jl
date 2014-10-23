using Optim

include("tests.jl")

f = rosenbrock
g! = rosenbrock_gradient!
h! = rosenbrock_hessian!

optimize(f, [0.0, 0.0])
results = Optim.levenberg_marquardt(rosenbrock_lm, rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
println(results)

function asinetransform(params::Vector, lowerbounds::Vector, upperbounds::Vector)
	sineparams = asin((params - lowerbounds) ./ (upperbounds - lowerbounds) * 2 - 1)
	return sineparams
end

function sinetransform(sineparams::Vector, lowerbounds::Vector, upperbounds::Vector)
	params = lowerbounds + (upperbounds - lowerbounds) .* ((1 + sin(sineparams)) * .5)
	return params
end

function sinetransformfunction(f::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedf(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		return f(params)
	end
	return sinetransformedf
end

function sinetransformgradient(g::Function, lowerbounds::Vector, upperbounds::Vector)
	function sinetransformedg(sineparams::Vector)
		params = sinetransform(sineparams, lowerbounds, upperbounds)
		straightgrad = g(params)
		f(x) = cos(x) / 2
		transformgrad = (upperbounds - lowerbounds) .* f(sineparams)
		return straightgrad .* transformgrad
	end
	return sinetransformedg
end

lowerbounds = [-2, -2]
# upperbounds = [.5, .5]
upperbounds = [2, 2]
sin_rosenbrock_lm = sinetransformfunction(rosenbrock_lm, lowerbounds, upperbounds)
sin_rosenbrock_gradient_lm = sinetransformgradient(rosenbrock_gradient_lm, lowerbounds, upperbounds)
a = asinetransform([0.0, 0.0], lowerbounds, upperbounds)
println(a,"->", sinetransform(a, lowerbounds, upperbounds))
a = asinetransform([2.0,2.0], lowerbounds, upperbounds)
println(a,"->", sinetransform(a, lowerbounds, upperbounds))
a = asinetransform([-2.0,-2.0], lowerbounds, upperbounds)
println(a,"->", sinetransform(a, lowerbounds, upperbounds))
a = sin_rosenbrock_lm(asinetransform([2.0,2.0], lowerbounds, upperbounds))
println(a,"=",rosenbrock_lm([2.0,2.0]))
a = sin_rosenbrock_lm(asinetransform([1.0,1.0], lowerbounds, upperbounds))
println(a,"=",rosenbrock_lm([1.0,1.0]))
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, asinetransform([0.0, 0.0], lowerbounds, upperbounds), show_trace=false)
println(results)
println(sinetransform(results.minimum, lowerbounds, upperbounds))
