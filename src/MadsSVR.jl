import SVR
import OrderedCollections
import DocumentFunction

function svrtrain(madsdata::AbstractDict, paramarray::Array{Float64,2}; check::Bool=false, savesvr::Bool=false, addminmax::Bool=true, svm_type::Int32=SVR.EPSILON_SVR, kernel_type::Int32=SVR.RBF, degree::Integer=3, gamma::Float64=1/numberofsamples, coef0::Float64=0.0, C::Float64=1000.0, nu::Float64=0.5, cache_size::Float64=100.0, eps::Float64=0.1, shrinking::Bool=true, probability::Bool=false, verbose::Bool=false, tol::Float64=0.001)
	numberofsamples = size(paramarray, 1)
	predictions = Mads.forward(madsdata, permutedims(paramarray))

	npred = size(predictions, 1)
	svrmodel = Array{SVR.svmmodel}(undef, npred)
	svrpredictions2 = Array{Float64}(undef, 0, numberofsamples)
	for i=1:npred
		sm = SVR.train(predictions[i,:], permutedims(paramarray); svm_type=svm_type, kernel_type=kernel_type, gamma=gamma, coef0=coef0, C=C, nu=nu, eps=eps, shrinking=shrinking, probability=probability, tol=tol, cache_size=cache_size);
		svrmodel[i] = sm
		if check
			y_pr = SVR.predict(sm, paramarray');
			svrpredictions2 = [svrpredictions2; y_pr']
		end
		if savesvr
			Mads.mkdir("svrmodels")
			SVR.savemodel(sm, joinpath("svrmodels", "$r-$i-$numberofsamples.svr"))
		end
	end
	if check
		rootname = Mads.getmadsrootname(madsdata)
		Mads.spaghettiplot(madsdata, predictions, keyword="svr-training", format="SVG")
		Mads.display("$rootname-svr-training-$numberofsamples-spaghetti.svg")
		@info("SVR discrepancy $(maximum(abs.(svrpredictions2 .- predictions)))")
		Mads.spaghettiplot(madsdata, svrpredictions2, keyword="svr-prediction2", format="SVG")
		Mads.display("$rootname-svr-prediction2-$numberofsamples-spaghetti.svg")
		svrpredictions = svrpredict(svrmodel, paramarray)
		@info("SVR discrepancy $(maximum(abs.(svrpredictions .- predictions)))")
		Mads.spaghettiplot(madsdata, svrpredictions, keyword="svr-prediction", format="SVG")
		Mads.display("$rootname-svr-prediction-$numberofsamples-spaghetti.svg")
	end
	return svrmodel
end
function svrtrain(madsdata::AbstractDict, numberofsamples::Integer=100; addminmax::Bool=true, kw...)
	rootname = splitdir(Mads.getmadsrootname(madsdata))[end]
	paramdict = Mads.getparamrandom(madsdata, numberofsamples)
	paramarray = hcat(map(i->collect(paramdict[i]), collect(keys(paramdict)))...)
	if addminmax
		k = Mads.getoptparamkeys(madsdata)
		pmin = Mads.getparamsmin(madsdata, k)
		pmax = Mads.getparamsmax(madsdata, k)
		pinit = Mads.getparamsinit(madsdata, k)
		gmin, gmax = Mads.meshgrid(pmin, pmax)
		paramarray = [paramarray; gmin; gmax; pinit']
		numberofsamples += 2 * length(k) + 1
	end
	svrtrain(madsdata, paramarray; kw...)
end

@doc """
Train SVR

$(DocumentFunction.documentfunction(svrtrain;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"numberofsamples"=>"number of random samples in the training set [default=`100`]"),
keytext=Dict("check"=>"check SVR performance [default=`false`]",
			"addminmax"=>"add parameter minimum / maximum range values in the training set [default=`true`]",
			"loadsvr"=>"load SVR models [default=`false`]",
			"savesvr"=>"save SVR models [default=`false`]",
			"svm_type"=>"SVM type [default=`SVR.EPSILON_SVR`]",
			"eps"=>"epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]",
			"nu"=>"upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]",
			"kernel_type"=>"kernel type[default=`SVR.RBF`]",
			"degree"=>"degree of the polynomial kernel [default=`3`]",
			"gamma"=>"coefficient for RBF, POLY and SIGMOND kernel types [default=`1/numberofsamples`]",
			"coef0"=>"independent term in kernel function; important only in POLY and  SIGMOND kernel types
[default=`0`]",
			"C"=>"cost; penalty parameter of the error term [default=`1000.0`]",
			"cache_size"=>"size of the kernel cache [default=`100.0`]",
			"shrinking"=>"apply shrinking heuristic [default=`true`]",
			"probability"=>"train to estimate probabilities [default=`false`]",
			"tol"=>"tolerance of termination criterion [default=`0.001`]",
			"verbose"=>"verbose output [default=`false`]",
			"seed"=>"random seed [default=`0`]")))

Returns:

- Array of SVR models
""" svrtrain

#=
function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 1})
	npred = length(svrmodel)
	y = Array(Float64, npred)
	for i=1:npred
		y[i] = SVR.predict(svrmodel[i], paramarray');
	end
	return y
end
=#
function svrpredict(svrmodel::Array{SVR.svmmodel, 1}, paramarray::Array{Float64, 2})
	npred = length(svrmodel)
	y = Array{Float64}(undef, 0, size(paramarray, 1))
	for i=1:npred
		y = [y; permutedims(SVR.predict(svrmodel[i], permutedims(paramarray)))];
	end
	return y
end

@doc """
Predict SVR

$(DocumentFunction.documentfunction(svrpredict;
argtext=Dict("svrmodel"=>"array of SVR models",
			"paramarray"=>"parameter array")))

Returns:

- SVR predicted observations (dependent variables) for a given set of parameters (independent variables)
""" svrpredict

"""
Free SVR

$(DocumentFunction.documentfunction(svrfree;
argtext=Dict("svrmodel"=>"array of SVR models")))
"""
function svrfree(svrmodel::Array{SVR.svmmodel, 1})
	npred = length(svrmodel)
	for i=1:npred
		if isassigned(svrmodel, i)
			SVR.freemodel(svrmodel[i])
		end
	end
	nothing
end

"""
Dump SVR models in files

$(DocumentFunction.documentfunction(svrdump;
argtext=Dict("svrmodel"=>"array of SVR models",
			"rootname"=>"root name",
			"numberofsamples"=>"number of samples")))
"""
function svrdump(svrmodel::Array{SVR.svmmodel, 1}, rootname::String, numberofsamples::Int)
	npred = length(svrmodel)
	Mads.mkdir("svrmodels")
	for i=1:npred
		if isassigned(svrmodel, i)
			SVR.savemodel(svrmodel[i], joinpath("svrmodels", "$rootname-$i-$numberofsamples.svr"))
		end
	end
	nothing
end

"""
Load SVR models from files

$(DocumentFunction.documentfunction(svrload;
argtext=Dict("npred"=>"number of model predictions",
			"rootname"=>"root name",
			"numberofsamples"=>"number of samples")))

Returns:

- Array of SVR models for each model prediction
"""
function svrload(npred::Int, rootname::String, numberofsamples::Int)
	svrmodel = Array{SVR.svmmodel}(undef, npred)
	for i=1:npred
		filename = joinpath("svrmodels", "$rootname-$i-$numberofsamples.svr")
		if isfile(filename)
			svrmodel[i] = SVR.loadmodel(filename)
		else
			Mads.madswarn("$filename does not exist")
		end
	end
	return svrmodel
end

"""
Make SVR model functions (executor and cleaner)

$(DocumentFunction.documentfunction(makesvrmodel;
argtext=Dict("madsdata"=>"MADS problem dictionary",
			"numberofsamples"=>"number of samples [default=`100`]"),
keytext=Dict("check"=>"check SVR performance [default=`false`]",
			"addminmax"=>"add parameter minimum / maximum range values in the training set [default=`true`]",
			"loadsvr"=>"load SVR models [default=`false`]",
			"savesvr"=>"save SVR models [default=`false`]",
			"svm_type"=>"SVM type [default=`SVR.EPSILON_SVR`]",
			"eps"=>"epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]",
			"nu"=>"upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]",
			"kernel_type"=>"kernel type[default=`SVR.RBF`]",
			"degree"=>"degree of the polynomial kernel [default=`3`]",
			"gamma"=>"coefficient for RBF, POLY and SIGMOND kernel types [default=`1/numberofsamples`]",
			"coef0"=>"independent term in kernel function; important only in POLY and  SIGMOND kernel types
[default=`0`]",
			"C"=>"cost; penalty parameter of the error term [default=`1000.0`]",
			"cache_size"=>"size of the kernel cache [default=`100.0`]",
			"shrinking"=>"apply shrinking heuristic [default=`true`]",
			"probability"=>"train to estimate probabilities [default=`false`]",
			"tol"=>"tolerance of termination criterion [default=`0.001`]",
			"verbose"=>"verbose output [default=`false`]",
			"seed"=>"random seed [default=`0`]")))

Returns:

- function performing SVR predictions
- function loading existing SVR models
- function saving SVR models
- function removing SVR models from the memory
"""
function makesvrmodel(madsdata::AbstractDict, numberofsamples::Integer=100; check::Bool=false, addminmax::Bool=true, loadsvr::Bool=false, savesvr::Bool=false, svm_type::Int32=SVR.EPSILON_SVR, kernel_type::Int32=SVR.RBF, degree::Integer=3, gamma::Float64=1/numberofsamples, coef0::Float64=0.0, C::Float64=1000.0, nu::Float64=0.5, eps::Float64=0.001, cache_size::Float64=100.0, tol::Float64=0.001, shrinking::Bool=true, probability::Bool=false, verbose::Bool=false, seed::Integer=-1)
	rootname = splitdir(Mads.getmadsrootname(madsdata))[end]
	optnames = Mads.getoptparamkeys(madsdata)
	obsnames = Mads.getobskeys(madsdata)
	npreds = length(obsnames)
	function svrexec(paramarray::Union{Array{Float64, 1}, Array{Float64, 2}})
		return svrpredict(svrmodel, paramarray)
	end
	function svrexec(paramdict::AbstractDict)
		if length(paramdict[optnames[1]]) == 1
			d = OrderedCollections.OrderedDict{String, Float64}()
			for k in optnames
				d[k] = paramdict[k]
			end
			parvector = collect(values(d))
			n = length(parvector)
			parvector = reshape(parvector, 1, n)
			p = svrpredict(svrmodel, parvector)
			d = OrderedCollections.OrderedDict{String, Float64}(zip(obsnames, p))
		else
			paramarray = hcat(map(i->collect(paramdict[i]), collect(keys(paramdict)))...)
			d = svrpredict(svrmodel, paramarray)
		end
		return d
	end
	function svrclean()
		svrfree(svrmodel)
	end
	function svrsave()
		svrdump(svrmodel, rootname, numberofsamples)
	end
	function svrread()
		svrmodel = svrload(npreds, rootname, numberofsamples)
		nothing
	end

	if loadsvr
		svrread()
	else
		svrmodel = svrtrain(madsdata, numberofsamples; check=check, addminmax=addminmax, savesvr=savesvr, svm_type=svm_type, kernel_type=kernel_type, gamma=gamma, coef0=coef0, C=C, eps=eps, nu=nu, cache_size=cache_size, shrinking=shrinking, probability=probability, tol=tol);
	end

	return svrexec, svrread, svrsave, svrclean
end
