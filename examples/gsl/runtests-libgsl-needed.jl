import Mads
using Base.Test

madsdirname = Mads.getmadsdir() # get the directory where the problem is executed
if madsdirname == ""
	madsdirname = Mads.madsdir * "/../examples/gsl/"
end

# Test callback functionality
"GSL function wrap"
function gsl_function_wrap(x::Cdouble, params::Ptr{Void})
	f = unsafe_pointer_to_objref(params)::Function
	convert(Cdouble, f(x))::Cdouble
end
const gsl_function_wrap_c = cfunction(gsl_function_wrap, Cdouble, (Cdouble, Ptr{Void}))

"GSL function type"
type GSL_Function
	func::Ptr{Void}
	params::Any
	GSL_Function(f::Function) = new(gsl_function_wrap_c, f)
end

"GSL call of QAG adaptive integration"
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

info("GSL integration of a linear model ...")
md = Mads.loadmadsfile(madsdirname * "internal-linearmodel.mads")
flinearmodel = Mads.makemadscommandfunction(md)
f2(x) = flinearmodel(Dict("a"=>0., "b"=>x))["o1"]
area, err = gsl_integration_qag(f2, 0, 1)
@test area == -0.5
area, err = gsl_integration_qag(f2, 0, 2)
@test area == -2
area, err = gsl_integration_qag(f2, 0, 3)
@test area == -4.5
