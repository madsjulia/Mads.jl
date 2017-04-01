import SVR

"""
Train SVR

$(documentfunction(svrtrain))
"""
function svrtrain(madsdata::Associative, numberofsamples::Integer=100; check::Bool=false, addminmax::Bool=true, svm_type::Int32=SVR.EPSILON_SVR, kernel_type::Int32=SVR.RBF, degree::Integer=3, gamma::Float64=1/numberofsamples, coef0::Float64=0.0, C::Float64=10000.0, nu::Float64=0.5, p::Float64=0.1, cache_size::Float64=100.0, eps::Float64=0.001, shrinking::Bool=true, probability::Bool=false, verbose::Bool=false)
	paramdict = Mads.getparamrandom(madsdata, numberofsamples)
	paramarray = hcat(map(i->collect(paramdict[i]), keys(paramdict))...)
	if addminmax
		k = Mads.getoptparamkeys(madsdata)
		pmin = Mads.getparamsmin(madsdata, k)
		pmax = Mads.getparamsmax(madsdata, k)
		gmin, gmax = Mads.meshgrid(pmin, pmax)
		paramarray = [paramarray; gmin; gmax]
		numberofsamples += 2 * length(k)
	end
	predictions = Mads.forward(madsdata, paramarray)'

	npred = size(predictions, 1)
	svrmodel = Array(SVR.svmmodel, npred)
	svrpredictions2 = Array(Float64, 0, numberofsamples)
	for i=1:npred
		sm = SVR.train(predictions[i,:], paramarray'; svm_type=svm_type, kernel_type=kernel_type, gamma=gamma, coef0=coef0, C=C, nu=nu, p=p, cache_size=cache_size, eps=eps, shrinking=shrinking, probability=probability);
		if check
			y_pr = SVR.predict(sm, paramarray');
			svrpredictions2 = [svrpredictions2; y_pr']
		end
		SVR.savemodel(sm, "m$i.svr")
		SVR.freemodel(sm)
	end
	if check
		rootname = Mads.getmadsrootname(madsdata)
		Mads.spaghettiplot(madsdata, predictions, keyword="svr-training", format="PNG")
		Mads.display("$rootname-svr-training-$numberofsamples-spaghetti.png")
		info("SVR discrepancy $(maximum(abs.(svrpredictions2 .- predictions)))")
		Mads.spaghettiplot(madsdata, svrpredictions2, keyword="svr-prediction2", format="PNG")
		Mads.display("$rootname-svr-prediction2-$numberofsamples-spaghetti.png")
		svrpredictions = svrpredict(svrmodel, paramarray)
		info("SVR discrepancy $(maximum(abs.(svrpredictions .- predictions)))")
		Mads.spaghettiplot(madsdata, svrpredictions, keyword="svr-prediction", format="PNG")
		Mads.display("$rootname-svr-prediction-$numberofsamples-spaghetti.png")
	end
	return svrmodel
end

function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 1})
	npred = length(svrmodel)
	y = Array(Float64, npred)
	for i=1:npred
		sm = SVR.loadmodel("m$i.svr")
		y[i] = SVR.predict(sm, paramarray');
	end
	return y
end

function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 2})
	npred = length(svrmodel)
	y = Array(Float64, 0, size(paramarray, 1))
	for i=1:npred
		sm = SVR.loadmodel("m$i.svr")
		y = [y; SVR.predict(sm, paramarray')'];
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
		if isdefined(svrmodel, i)
			SVR.freemodel(svrmodel[i])
		end
	end
	nothing
end

"""
Make SVR model functions (executor and cleaner)

$(documentfunction(svrfree))
"""
function makesvrmodel(madsdata::Associative; numberofsamples::Integer=100, check::Bool=false, addminmax::Bool=true, svm_type::Int32=SVR.EPSILON_SVR, kernel_type::Int32=SVR.RBF, degree::Integer=3, gamma::Float64=1/numberofsamples, coef0::Float64=0.0, C::Float64=10000.0, nu::Float64=0.5, p::Float64=0.01, cache_size::Float64=100.0, eps::Float64=0.001, shrinking::Bool=true, probability::Bool=false, verbose::Bool=false)
	svrmodel = svrtrain(madsdata, numberofsamples; check=check, addminmax=addminmax, svm_type=svm_type, kernel_type=kernel_type, gamma=gamma, coef0=coef0, C=C, nu=nu, p=p, cache_size=cache_size, eps=eps, shrinking=shrinking, probability=probability);
	function svrexec(paramarray::Union{Array{Float64, 1}, Array{Float64, 2}})
		return svrpredict(svrmodel, paramarray)
	end
	function svrclean()
		svrfree(svrmodel)
	end
	return svrexec, svrclean
end