import SVR

"""
Train SVR

$(documentfunction(svrtrain))
"""
function svrtrain(madsdata::Associative, numberofsamples::Integer=100; svm_type::Int32=EPSILON_SVR, kernel_type::Int32=RBF, degree::Integer=3, gamma::Float64=10000.0, coef0::Float64=0.0, C::Float64=10000.0, nu::Float64=0.5, p::Float64=0.001, cache_size::Float64=100.0, eps::Float64=0.001, shrinking::Bool=true, probability::Bool=false, verbose::Bool=false)
	paramdict = Mads.getparamrandom(md, numberofsamples)
	paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
	predictions = Mads.forward(md, paramdict)'

	npred = length(predictions)
	svrmodel = Array(SVR.svmmodel, npred)
	for i=1:npred
		svrmodel[i] = SVR.train(predictions[i,:], paramarray'; svm_type=svm_type, kernel_type=kernel_type, gamma=gamma, coef0=coef0, C=C, nu=nu, p=p, cache_size=cache_size, eps=eps, shrinking=shrinking, probability=probability);
	end
	return svrmodel
end

function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 1})
	npred = length(svrmodel)
	y = Array(Float64, npred)
	for i=1:npred
		y[i] = SVR.predict(svrmodel[i], paramarray');
	end
	return y
end

function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 2})
	npred = length(svrmodel)
	y = Array(Float64, 0, size(paramarray, 2))
	for i=1:npred
		y = [y; SVR.predict(svrmodel[i], paramarray')'];
	end
	return y
end

@doc """
Train SVR

$(documentfunction(svrpredict))
""" svrpredict

"""
Free SVR 

$(documentfunction(svrfree))
"""
function svrfree(svrmodel::Array{SVR.svmmodel, 1})
	npred = length(svrmodel)
	for i=1:npred
		SVR.freemodel(svrmodel[i])
	end
end