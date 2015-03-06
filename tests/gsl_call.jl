using Mads

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