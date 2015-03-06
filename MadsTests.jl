using Optim
using Gadfly
cd(dirname(@__FILE__))
using Mads
using Distributions
Logging.configure(level=Logging.OFF)

f = Mads.rosenbrock
g! = Mads.rosenbrock_gradient!
h! = Mads.rosenbrock_hessian!

# internal opimization test
println("TEST Nelder-Mead optimization (default) of the Rosenbrock function:")
results = optimize(f, [0.0, 0.0])
println(results)
println("TEST Levenberg-Marquardt optimization of the Rosenbrock function without sine transformation:")
results = Optim.levenberg_marquardt(Mads.rosenbrock_lm, Mads.rosenbrock_gradient_lm, [0.0, 0.0], show_trace=false)
println(results)

lowerbounds = [-2, -2]
upperbounds = [2, 2]
sin_rosenbrock_lm = Mads.sinetransformfunction(Mads.rosenbrock_lm, lowerbounds, upperbounds)
sin_rosenbrock_gradient_lm = Mads.sinetransformgradient(Mads.rosenbrock_gradient_lm, lowerbounds, upperbounds)

println("TEST sine transformation:")
a = Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ", a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ",a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = Mads.asinetransform([-2.0,-2.0], lowerbounds, upperbounds)
println("TEST Parameter transformation: ", a,"->", Mads.sinetransform(a, lowerbounds, upperbounds))
a = sin_rosenbrock_lm(Mads.asinetransform([2.0,2.0], lowerbounds, upperbounds))
println("TEST Parameter transformation in a function: ", a,"=", Mads.rosenbrock_lm([2.0,2.0]))
a = sin_rosenbrock_lm(Mads.asinetransform([1.0,1.0], lowerbounds, upperbounds))
println("TEST Parameter transformation in a function: ", a,"=", Mads.rosenbrock_lm([1.0,1.0]))

# internal opimization test
println("TEST Levenberg-Marquardt optimization of the Rosenbrock function with sine transformation:")
results = Optim.levenberg_marquardt(sin_rosenbrock_lm, sin_rosenbrock_gradient_lm, Mads.asinetransform([0.0, 0.0], lowerbounds, upperbounds), show_trace=false)
println(results)
println(Mads.sinetransform(results.minimum, lowerbounds, upperbounds))

#=
println("TEST Levenberg-Marquardt optimization of an external call problem using wells:")
cd("examples/wells-short")
mdwells = Mads.loadyamlmadsfile("w01_yaml.mads")
results = Mads.calibrate(mdwells)
cd("../..")
println(results)
=#

#= WORKS but slow
# external execution test using YAML files
println("TEST Levenberg-Marquardt optimization of an external call problem using YAML files:")
cd("tests")
mdexternal = Mads.loadyamlmadsfile("test-external-yaml.mads")
results = Mads.calibrate(mdexternal)
cd("..")
println(results)
=#

# external execution test using ASCII files
println("TEST Levenberg-Marquardt optimization of an external call problem using ASCII files:")
cd("tests")
mdexternal = Mads.loadyamlmadsfile("test-external-ascii.mads")
results = Mads.calibrate(mdexternal)
cd("..")
println(results)

# internal execution test
println("TEST Levenberg-Marquardt optimization of an internal call problem:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
results = Mads.calibrate(mdinternal)
println(results)

# Saltelli senstivity analysis tests
println("TEST Saltelli senstivity analysis:")
mdsobol = Mads.loadyamlmadsfile("tests/test-sobol.mads")
results = Mads.saltelli(mdsobol,N=int(1e4))
Mads.saltelliprintresults(mdsaltelli,results)
println("TEST Saltelli senstivity analysis:")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltelli(mdsaltelli)
results = Mads.saltelliparallel(mdsaltelli,2)
Mads.saltelliprintresults(mdsaltelli,results)
println("TEST Saltelli senstivity analysis (brute force):")
mdsaltelli = Mads.loadyamlmadsfile("tests/test-saltelli.mads")
results = Mads.saltellibrute(mdsaltelli)
results = Mads.saltellibruteparallel(mdsaltelli,2)
Mads.saltelliprintresults(mdsaltelli,results)

# Bayesian sampling test
println("TEST Bayesian sampling:")
mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
mcmcchain = Mads.bayessampling(mdinternal)
plot(x=mcmcchain.samples[:,1], y=mcmcchain.samples[:,2])

# Test callback funcitonality
function gsl_function_wrap(x::Cdouble, params::Ptr{Void})
	f = unsafe_pointer_to_objref(params)::Function
	convert(Cdouble, f(x))::Cdouble
end
const gsl_function_wrap_c = cfunction(gsl_function_wrap, Cdouble, (Cdouble, Ptr{Void}))

type GSL_Function
	func::Ptr{Void}
	params::Any
	GSL_Function(f::Function) = new(gsl_function_wrap_c, f)
end

function gsl_integration_qag(f::Function, a::Real, b::Real, epsrel::Real=1e-12, maxintervals::Integer=10^7)
	s = ccall((:gsl_integration_workspace_alloc,:libgsl), Ptr{Void}, (Csize_t,), maxintervals)
	result = Array(Cdouble,1)
	abserr = Array(Cdouble,1)
	ccall((:gsl_integration_qag,:libgsl), Cint,
				(Ptr{GSL_Function}, Cdouble, Cdouble, Cdouble, Csize_t, Cint, Ptr{Void}, Ptr{Cdouble}, Ptr{Cdouble}),
				&GSL_Function(f), a, b, epsrel, maxintervals, 1, s, result, abserr)
	ccall((:gsl_integration_workspace_free,:libgsl), Void, (Ptr{Void},), s)
	return (result[1], abserr[1])
end

mdinternal = Mads.loadyamlmadsfile("tests/test-internal.mads")
f = Mads.makemadscommandfunction(mdinternal)
f2(x) = f(["a"=>0., "b"=>x])["o1"]
println(gsl_integration_qag(f2, 0, 1))
println(gsl_integration_qag(f2, 0, 2))
println(gsl_integration_qag(f2, 0, 3))
