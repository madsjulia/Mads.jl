import MetaProgTools
import ProgressMeter
import Distributions
import DataStructures
import DataFrames
import StatsBase
import JSON
import JLD

if !haskey(ENV, "MADS_NO_GADFLY")
	@tryimport Gadfly
end

"""
Make gradient function needed for local sensitivity analysis

$(DocumentFunction.documentfunction(makelocalsafunction;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("multiplycenterbyweights"=>"multiply center by observation weights [default=`true`]")))

Returns:

- gradient function
"""
function makelocalsafunction(madsdata::Associative; multiplycenterbyweights::Bool=true)
	f = makemadscommandfunction(madsdata)
	restartdir = getrestartdir(madsdata)
	obskeys = Mads.getobskeys(madsdata)
	weights = Mads.getobsweight(madsdata)
	nO = length(obskeys)
	optparamkeys = Mads.getoptparamkeys(madsdata)
	lineardx = getparamsstep(madsdata, optparamkeys)
	nP = length(optparamkeys)
	initparams = DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	function func(arrayparameters::Vector)
		parameters = copy(initparams)
		for i = 1:length(arrayparameters)
			parameters[optparamkeys[i]] = arrayparameters[i]
		end
		resultdict = f(parameters)
		results = Array{Float64}(0)
		for obskey in obskeys
			push!(results, resultdict[obskey]) # preserve the expected order
		end
		return results .* weights
	end
	function inner_grad(arrayparameters_dx_center_tuple::Tuple)
		arrayparameters = arrayparameters_dx_center_tuple[1]
		dx = arrayparameters_dx_center_tuple[2]
		center = arrayparameters_dx_center_tuple[3]
		if sizeof(center) > 0 && multiplycenterbyweights
			center = center .* weights
		end
		if sizeof(dx) == 0
			dx = lineardx
		end
		p = Vector{Float64}[]
		for i in 1:nP
			a = copy(arrayparameters)
			a[i] += dx[i]
			push!(p, a)
		end
		if sizeof(center) == 0
			filename = ReusableFunctions.gethashfilename(restartdir, arrayparameters)
			center = ReusableFunctions.loadresultfile(filename)
			center_computed = (center != nothing) && length(center) == nO
			if !center_computed
				push!(p, arrayparameters)
			end
		else
			center_computed = true
		end
		fevals = RobustPmap.rpmap(func, p)
		if !center_computed
			center = fevals[nP+1]
			if restartdir != ""
				ReusableFunctions.saveresultfile(restartdir, center, arrayparameters)
			end
		end
		jacobian = Array{Float64}((nO, nP))
		for j in 1:nO
			for i in 1:nP
				jacobian[j, i] = (fevals[i][j] - center[j]) / dx[i]
			end
		end
		return jacobian
	end
	reusable_inner_grad = makemadsreusablefunction(madsdata, inner_grad, "g_lm"; usedict=false)
	"""
	Gradient function for the forward model used for local sensitivity analysis
	"""
	function grad(arrayparameters::Vector{Float64}; dx::Array{Float64,1}=Array{Float64}(0), center::Array{Float64,1}=Array{Float64}(0))
		return reusable_inner_grad(tuple(arrayparameters, dx, center))
	end
	return grad
end

"""
Local sensitivity analysis based on eigen analysis of the parameter covariance matrix

$(DocumentFunction.documentfunction(localsa;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("sinspace"=>"apply sin transformation [default=`true`]",
            "keyword"=>"keyword to be added in the filename root",
            "filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.)",
            "datafiles"=>"flag to write data files [default=`true`]",
            "imagefiles"=>"flag to create image files [default=`Mads.graphoutput`]",
            "par"=>"parameter set",
            "obs"=>"observations for the parameter set",
            "J"=>"Jacobian matrix")))

Dumps:

- `filename` : output plot file
"""
function localsa(madsdata::Associative; sinspace::Bool=true, keyword::String="", filename::String="", format::String="", datafiles::Bool=true, imagefiles::Bool=graphoutput, par::Array{Float64,1}=Array{Float64}(0), obs::Array{Float64,1}=Array{Float64}(0), J::Array{Float64,2}=Array{Float64}((0,0)))
	if filename == ""
		rootname = Mads.getmadsrootname(madsdata)
		ext = ""
	else
		rootname = Mads.getrootname(filename)
		ext = "." * Mads.getextension(filename)
	end
	if keyword != ""
		rootname = string(rootname, "-", keyword)
	end
	paramkeys = getoptparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	nP = length(paramkeys)
	nPi = sizeof(par)
	if nPi == 0
		param = getparamsinit(madsdata, paramkeys)
	elseif nPi != nP
		param = getoptparams(madsdata, par, paramkeys)
	else
		param = par
	end
	if sizeof(J) == 0
		g = makelocalsafunction(madsdata)
		if sinspace
			lowerbounds = Mads.getparamsmin(madsdata, paramkeys)
			upperbounds = Mads.getparamsmax(madsdata, paramkeys)
			logtransformed = Mads.getparamslog(madsdata, paramkeys)
			indexlogtransformed = find(logtransformed)
			lowerbounds[indexlogtransformed] = log10.(lowerbounds[indexlogtransformed])
			upperbounds[indexlogtransformed] = log10.(upperbounds[indexlogtransformed])
			sinparam = asinetransform(param, lowerbounds, upperbounds, indexlogtransformed)
			sindx = Mads.getsindx(madsdata)
			g_sin = Mads.sinetransformgradient(g, lowerbounds, upperbounds, indexlogtransformed, sindx=sindx)
			J = g_sin(sinparam, center=obs)
		else
			J = g(param, center=obs)
		end
	end
	if any(isnan, J)
		Mads.madswarn("Local sensitivity analysis cannot be performed; provided Jacobian matrix contains NaN's")
		Base.display(J)
		Mads.madscritical("Mads quits!")
	end
	datafiles && writedlm("$(rootname)-jacobian.dat", [transposevector(["Obs"; paramkeys]); obskeys J])
	mscale = max(abs(minimum(J)), abs(maximum(J)))
	if imagefiles && isdefined(:Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
		jacmat = Gadfly.spy(J, Gadfly.Scale.x_discrete(labels = i->plotlabels[i]), Gadfly.Scale.y_discrete,
					Gadfly.Guide.YLabel("Observations"), Gadfly.Guide.XLabel("Parameters"),
					Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = -mscale, maxvalue = mscale))
		filename = "$(rootname)-jacobian" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 12Gadfly.inch), jacmat)
		Mads.madsinfo("Jacobian matrix plot saved in $filename")
	end
	JpJ = J' * J
	covar = Array{Float64}(0)
	try
		u, s, v = svd(JpJ)
		covar = v * inv(diagm(s)) * u'
	catch "LAPACKException(12)"
		try
			covar = inv(JpJ)
		catch "SingularException(4)"
			Mads.madswarn("Singular covariance matrix! Local sensitivity analysis fails.")
			return
		end
	end
	stddev = sqrt.(abs.(diag(covar)))
	if datafiles
		writedlm("$(rootname)-covariance.dat", covar)
		f = open("$(rootname)-stddev.dat", "w")
		for i in 1:nP
			write(f, "$(paramkeys[i]) $(param[i]) $(stddev[i])\n")
		end
		close(f)
	end
	correl = covar ./ diag(covar)
	datafiles && writedlm("$(rootname)-correlation.dat", correl)
	eigenv, eigenm = eig(covar)
	eigenv = abs.(eigenv)
	index = sortperm(eigenv)
	sortedeigenv = eigenv[index]
	sortedeigenm = real(eigenm[:,index])
	datafiles && writedlm("$(rootname)-eigenmatrix.dat", [paramkeys sortedeigenm])
	datafiles && writedlm("$(rootname)-eigenvalues.dat", sortedeigenv)
	if imagefiles && isdefined(:Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
		eigenmat = Gadfly.spy(sortedeigenm, Gadfly.Scale.y_discrete(labels = i->plotlabels[i]), Gadfly.Scale.x_discrete,
					Gadfly.Guide.YLabel("Parameters"), Gadfly.Guide.XLabel("Eigenvectors"),
					Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))))
		# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenmatrix" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename,6Gadfly.inch,6Gadfly.inch), eigenmat)
		Mads.madsinfo("Eigen matrix plot saved in $filename")
		eigenval = Gadfly.plot(x=1:length(sortedeigenv), y=sortedeigenv, Gadfly.Scale.x_discrete, Gadfly.Scale.y_log10,
					Gadfly.Geom.bar,
					Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Guide.YLabel("Eigenvalues"), Gadfly.Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenvalues" * ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), eigenval)
		Mads.madsinfo("Eigen values plot saved in $filename")
	end
	Dict("of"=>of, "jacobian"=>J, "covar"=>covar, "stddev"=>stddev, "eigenmatrix"=>sortedeigenm, "eigenvalues"=>sortedeigenv)
end

"""
$(DocumentFunction.documentfunction(sampling;
argtext=Dict("param"=>"Parameter vector",
            "J"=>"Jacobian matrix",
            "numsamples"=>"Number of samples"),
keytext=Dict("seed"=>"random esee [default=`0`]",
             "scale"=>"data scaling [default=`1`]")))

Returns:

- generated samples (vector or array)
- vector of log-likelihoods
"""
function sampling(param::Vector, J::Array, numsamples::Number; seed::Integer=0, scale::Number=1)
	u, d, v = svd(J' * J)
	done = false
	uo = u
	dd = d
	vo = v
	gooddirections = []
	local dist
	numdirections = length(d)
	numgooddirections = numdirections
	while !done
		try
			covmat = (v * diagm(1 ./ d) * u') .* scale
			dist = Distributions.MvNormal(zeros(numgooddirections), covmat)
			done = true
		catch errmsg
			# printerrormsg(errmsg)
			numgooddirections -= 1
			if numgooddirections <= 0
				done = true
				madswarn("Reduction in sampling directions failed!")
				return
			end
			gooddirections = vo[:, 1:numgooddirections]
			newJ = J * gooddirections
			u, d, v = svd(newJ' * newJ)
		end
	end
	madsinfo("Reduction in sampling directions ... (from $(numdirections) to $(numgooddirections))")
	setseed(seed)
	gooddsamples = Distributions.rand(dist, numsamples)
	llhoods = map(i->Distributions.loglikelihood(dist, gooddsamples[:, i:i]''), 1:numsamples)
	if numdirections > numgooddirections
		samples = gooddirections * gooddsamples
	else
		samples = gooddsamples
	end
	for i = 1:size(samples, 2)
		samples[:, i] += param
	end
	return samples, llhoods
end

"""
Reweigh samples using importance sampling -- returns a vector of log-likelihoods after reweighing

$(DocumentFunction.documentfunction(reweighsamples;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "predictions"=>"the model predictions for each of the samples",
            "oldllhoods"=>"the log likelihoods of the parameters in the old distribution")))

Returns:

- vector of log-likelihoods after reweighing
"""
function reweighsamples(madsdata::Associative, predictions::Array, oldllhoods::Vector)
	obskeys = getobskeys(madsdata)
	weights = getobsweight(madsdata)
	targets = getobstarget(madsdata)
	newllhoods = -oldllhoods
	j = 1
	for okey in obskeys
		if haskey(madsdata["Observations"][okey], "weight")
			newllhoods -= .5 * weights[j] ^ 2 * (predictions[:, j] - targets[j]) .^ 2
		end
		j += 1
	end
	return newllhoods - maximum(newllhoods) # normalize likelihoods so the most likely thing has likelihood 1
end

"""
Get important samples

$(DocumentFunction.documentfunction(getimportantsamples;
argtext=Dict("samples"=>"array of samples",
            "llhoods"=>"vector of log-likelihoods")))

Returns:

- array of important samples
"""
function getimportantsamples(samples::Array, llhoods::Vector)
	sortedlhoods = sort(exp.(llhoods), rev=true)
	sortedprobs = sortedlhoods / sum(sortedlhoods)
	cumprob = 0.
	i = 1
	while cumprob < .95
		cumprob += sortedprobs[i]
		i += 1
	end
	thresholdllhood = log(sortedlhoods[i - 1])
	imp_samples = Array{Float64}(size(samples, 2), 0)
	for i = 1:length(llhoods)
		if llhoods[i] > thresholdllhood
			imp_samples = hcat(imp_samples, vec(samples[i, :]))
		end
	end
	return imp_samples
end

"""
Get weighted mean and variance samples

$(DocumentFunction.documentfunction(weightedstats;
argtext=Dict("samples"=>"array of samples",
            "llhoods"=>"vector of log-likelihoods")))

Returns:

- vector of sample means
- vector of sample variances
"""
function weightedstats(samples::Array, llhoods::Vector)
	wv = StatsBase.WeightVec(exp.(llhoods))
	return mean(samples, wv, 1), var(samples, wv, 1)
end

function getparamrandom(madsdata::Associative, numsamples::Integer=1, parameterkey::String=""; init_dist::Bool=false)
	if parameterkey != ""
		return getparamrandom(madsdata, parameterkey; numsamples=numsamples, init_dist=init_dist)
	else
		sample = DataStructures.OrderedDict()
		paramkeys = getoptparamkeys(madsdata)
		paramdist = getparamdistributions(madsdata; init_dist=init_dist)
		for k in paramkeys
			sample[k] = getparamrandom(madsdata, k; numsamples=numsamples, paramdist=paramdist)
		end
		return sample
	end
end
function getparamrandom(madsdata::Associative, parameterkey::String; numsamples::Integer=1, paramdist::Associative=Dict(), init_dist::Bool=false)
	if haskey(madsdata["Parameters"], parameterkey)
		if length(paramdist) == 0
			paramdist = getparamdistributions(madsdata; init_dist=init_dist)
		end
		if Mads.islog(madsdata, parameterkey)
			dist = paramdist[parameterkey]
			if typeof(dist) <: Distributions.Uniform
				a = log10(dist.a)
				b = log10(dist.b)
				return 10.^(a + (b - a) * Distributions.rand(numsamples))
			elseif typeof(dist) <: Distributions.Normal
				μ = log10(dist.μ)
				return 10.^(μ + dist.σ * Distributions.randn(numsamples))
			end
		end
		return Distributions.rand(paramdist[parameterkey], numsamples)
	end
	return Void
end

@doc """
Get independent sampling of model parameters defined in the MADS problem dictionary

$(DocumentFunction.documentfunction(getparamrandom;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameterkey"=>"model parameter key",
            "numsamples"=>"number of samples,  [default=`1`]"),
keytext=Dict("init_dist"=>"if `true` use the distribution set for initialization in the MADS problem dictionary (defined using `init_dist` parameter field); if `false` (default) use the regular distribution set in the MADS problem dictionary (defined using `dist` parameter field)",
            "numsamples"=>"number of samples",
            "paramdist"=>"dictionary of parameter distributions")))

Returns:

- generated sample
""" getparamrandom

"""
Saltelli sensitivity analysis (brute force)

$(DocumentFunction.documentfunction(saltellibrute;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("N"=>"number of samples [default=`1000`]",
            "seed"=>"random seed [default=`0`]",
            "restartdir"=>"directory where files will be stored containing model results for fast simulation restarts")))
"""
function saltellibrute(madsdata::Associative; N::Integer=1000, seed::Integer=0, restartdir::String="") # TODO Saltelli (brute force) does not seem to work; not sure
	setseed(seed)
	numsamples = round(Int,sqrt(N))
	numoneparamsamples = numsamples
	nummanyparamsamples = numsamples
	# convert the distribution strings into actual distributions
	paramkeys = getoptparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getparamdistributions(madsdata)
	results = Array{DataStructures.OrderedDict}(numsamples)
	paramdict = DataStructures.OrderedDict{String,Float64}(zip(getparamkeys(madsdata), getparamsinit(madsdata)))
	for i = 1:numsamples
		for j in 1:length(paramkeys)
			paramdict[paramkeys[j]] = Distributions.rand(distributions[paramkeys[j]]) # TODO use parametersample
		end
		results[i] = f(paramdict) # this got to be slow to process
	end
	obskeys = getobskeys(madsdata)
	sum = DataStructures.OrderedDict{String,Float64}()
	for i = 1:length(obskeys)
		sum[obskeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += results[j][obskeys[i]]
		end
	end
	mean = DataStructures.OrderedDict{String,Float64}()
	for i = 1:length(obskeys)
		mean[obskeys[i]] = sum[obskeys[i]] / numsamples
	end
	for i = 1:length(paramkeys)
		sum[paramkeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += (results[j][obskeys[i]] - mean[obskeys[i]]) ^ 2
		end
	end
	variance = DataStructures.OrderedDict{String,Float64}()
	for i = 1:length(obskeys)
		variance[obskeys[i]] = sum[obskeys[i]] / (numsamples - 1)
	end
	madsinfo("Compute the main effect (first order) sensitivities (indices)")
	mes = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	for k = 1:length(obskeys)
		mes[obskeys[k]] = DataStructures.OrderedDict{String,Float64}()
	end
	for i = 1:length(paramkeys)
		madsinfo("""Parameter : $(paramkeys[i])""")
		cond_means = Array{DataStructures.OrderedDict}(numoneparamsamples)
		@ProgressMeter.showprogress 1 "Computing ... "  for j = 1:numoneparamsamples
			cond_means[j] = DataStructures.OrderedDict()
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] = 0.
			end
			paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]]) # TODO use parametersample
			for k = 1:nummanyparamsamples
				for m = 1:length(paramkeys)
					if m != i
						paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]]) # TODO use parametersample
					end
				end
				results = f(paramdict)
				for k = 1:length(obskeys)
					cond_means[j][obskeys[k]] += results[obskeys[k]]
				end
			end
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] /= nummanyparamsamples
			end
		end
		v = Array{Float64}(numoneparamsamples)
		for k = 1:length(obskeys)
			for j = 1:numoneparamsamples
				v[j] = cond_means[j][obskeys[k]]
			end
			mes[obskeys[k]][paramkeys[i]] = std(v) ^ 2 / variance[obskeys[k]]
		end
	end
	madsinfo("Compute the total effect sensitivities (indices)") # TODO we should use the same samples for total and main effect
	tes = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	var = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	for k = 1:length(obskeys)
		tes[obskeys[k]] = DataStructures.OrderedDict{String,Float64}()
		var[obskeys[k]] = DataStructures.OrderedDict{String,Float64}()
	end
	for i = 1:length(paramkeys)
		madsinfo("""Parameter : $(paramkeys[i])""")
		cond_vars = Array{DataStructures.OrderedDict}(nummanyparamsamples)
		cond_means = Array{DataStructures.OrderedDict}(nummanyparamsamples)
		@ProgressMeter.showprogress 1 "Computing ... " for j = 1:nummanyparamsamples
			cond_vars[j] = DataStructures.OrderedDict{String,Float64}()
			cond_means[j] = DataStructures.OrderedDict{String,Float64}()
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] = 0.
				cond_vars[j][obskeys[m]] = 0.
			end
			for m = 1:length(paramkeys)
				if m != i
					paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]]) # TODO use parametersample
				end
			end
			results = Array{DataStructures.OrderedDict}(numoneparamsamples)
			for k = 1:numoneparamsamples
				paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]]) # TODO use parametersample
				results[k] = f(paramdict)
				for m = 1:length(obskeys)
					cond_means[j][obskeys[m]] += results[k][obskeys[m]]
				end
			end
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] /= numoneparamsamples
			end
			for k = 1:numoneparamsamples
				for m = 1:length(obskeys)
					cond_vars[j][obskeys[m]] += (results[k][obskeys[m]] - cond_means[j][obskeys[m]]) ^ 2
				end
			end
			for m = 1:length(obskeys)
				cond_vars[j][obskeys[m]] /= numoneparamsamples - 1
			end
		end
		for j = 1:length(obskeys)
			runningsum = 0.
			for m = 1:nummanyparamsamples
				runningsum += cond_vars[m][obskeys[j]]
			end
			tes[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples / variance[obskeys[j]]
			var[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples
		end
	end
	Dict("mes" => mes, "tes" => tes, "var" => var, "samplesize" => N, "seed" => seed, "method" => "saltellibrute")
end

"""
Load Saltelli sensitivity analysis results for fast simulation restarts

$(DocumentFunction.documentfunction(loadsaltellirestart!;
argtext=Dict("evalmat"=>"loaded array",
"matname"=>"matrix (array) name (defines the name of the loaded file)",
"restartdir"=>"directory where files will be stored containing model results for fast simulation restarts")))

Returns:

- `true` when successfully loaded, `false` when it is not
"""
function loadsaltellirestart!(evalmat::Array, matname::String, restartdir::String)
	if restartdir == ""
		return false
	end
	filename = joinpath(restartdir, string(matname, "_", myid(), ".jld"))
	if !isfile(filename)
		return false
	end
	mat = JLD.load(filename, "mat")
	copy!(evalmat, mat)
	return true
end

"""
Save Saltelli sensitivity analysis results for fast simulation restarts

$(DocumentFunction.documentfunction(savesaltellirestart;
argtext=Dict("evalmat"=>"saved array",
"matname"=>"matrix (array) name (defines the name of the loaded file)",
"restartdir"=>"directory where files will be stored containing model results for fast simulation restarts")))
"""
function savesaltellirestart(evalmat::Array, matname::String, restartdir::String)
	if restartdir != ""
		Mads.mkdir(restartdir)
		JLD.save(joinpath(restartdir, string(matname, "_", myid(), ".jld")), "mat", evalmat)
	end
	return nothing
end

"""
Saltelli sensitivity analysis

$(DocumentFunction.documentfunction(saltelli;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("N"=>"number of samples [default=`100`]",
            "seed"=>"random seed [default=`0`]",
            "restartdir"=>"directory where files will be stored containing model results for fast simulation restarts",
            "parallel"=>"set to true if the model runs should be performed in parallel [default=`false`]",
            "checkpointfrequency"=>"check point frequency [default=`N`]")))
"""
function saltelli(madsdata::Associative; N::Integer=100, seed::Integer=0, restartdir::String="", parallel::Bool=false, checkpointfrequency::Integer=N)
	Mads.setseed(seed)
	Mads.madsoutput("Number of samples: $N\n");
	paramallkeys = Mads.getparamkeys(madsdata)
	paramalldict = DataStructures.OrderedDict{String,Float64}(zip(paramallkeys, Mads.getparamsinit(madsdata)))
	paramoptkeys = Mads.getoptparamkeys(madsdata)
	nP = length(paramoptkeys)
	Mads.madsoutput("Number of model paramters to be analyzed: $(nP) \n");
	Mads.madsoutput("Number of model evaluations to be perforemed: $(N * 2 + N * nP) \n");
	obskeys = Mads.getobskeys(madsdata)
	nO = length(obskeys)
	distributions = Mads.getparamdistributions(madsdata)
	f = Mads.makemadscommandfunction(madsdata)
	A = Array{Float64}((N, 0))
	B = Array{Float64}((N, 0))
	C = Array{Float64}((N, nP))
	variance = DataStructures.OrderedDict{String, DataStructures.OrderedDict{String, Float64}}() # variance
	mes = DataStructures.OrderedDict{String, DataStructures.OrderedDict{String, Float64}}() # main effect (first order) sensitivities
	tes = DataStructures.OrderedDict{String, DataStructures.OrderedDict{String, Float64}}()	# total effect sensitivities
	for i = 1:nO
		variance[obskeys[i]] = DataStructures.OrderedDict{String, Float64}()
		mes[obskeys[i]] = DataStructures.OrderedDict{String, Float64}()
		tes[obskeys[i]] = DataStructures.OrderedDict{String, Float64}()
	end
	for key in paramoptkeys
		delete!(paramalldict, key)
	end
	for j = 1:nP
		s1 = Mads.getparamrandom(madsdata, N, paramoptkeys[j])
		s2 = Mads.getparamrandom(madsdata, N, paramoptkeys[j])
		A = [A s1]
		B = [B s2]
	end
	Mads.madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample A ...\n""" );
	function farray(Ai)
		feval = f(merge(paramalldict, DataStructures.OrderedDict{String,Float64}(zip(paramoptkeys, Ai))))
		result = Array{Float64}(length(obskeys))
		for i = 1:length(obskeys)
			result[i] = feval[obskeys[i]]
		end
		return result
	end
	yA = Array{Float64}(N, length(obskeys))
	if restartdir == ""
		restartdir = getrestartdir(madsdata)
	end
	flagrestart = restartdir != ""
	if parallel
		Avecs = Array{Array{Float64, 1}}(size(A, 1))
		for i = 1:N
			Avecs[i] = vec(A[i, :])
		end
		if flagrestart
			pmapresult = RobustPmap.crpmap(farray, checkpointfrequency, joinpath(restartdir, "yA"), Avecs; t=Array{Float64, 1})
		else
			pmapresult = RobustPmap.rpmap(farray, Avecs; t=Array{Float64, 1})
		end
		for i = 1:N
			for j = 1:length(obskeys)
				yA[i, j] = pmapresult[i][j]
			end
		end
	else
		if !loadsaltellirestart!(yA, "yA", restartdir)
			for i = 1:N
				feval = f(merge(paramalldict, DataStructures.OrderedDict{String,Float64}(zip(paramoptkeys, A[i, :]))))
				for j = 1:length(obskeys)
					yA[i, j] = feval[obskeys[j]]
				end
			end
			savesaltellirestart(yA, "yA", restartdir)
		end
	end
	Mads.madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample B ...\n""" );
	yB = Array{Float64}(N, length(obskeys))
	if parallel
		Bvecs = Array{Array{Float64, 1}}(size(B, 1))
		for i = 1:N
			Bvecs[i] = vec(B[i, :])
		end
		if flagrestart
			pmapresult = RobustPmap.crpmap(farray, checkpointfrequency, joinpath(restartdir, "yB"), Bvecs; t=Array{Float64, 1})
		else
			pmapresult = RobustPmap.rpmap(farray, Bvecs; t=Array{Float64, 1})
		end
		for i = 1:N
			for j = 1:length(obskeys)
				yB[i, j] = pmapresult[i][j]
			end
		end
	else
		if !loadsaltellirestart!(yB, "yB", restartdir)
			for i = 1:N
				feval = f(merge(paramalldict, DataStructures.OrderedDict{String,Float64}(zip(paramoptkeys, B[i, :]))))
				for j = 1:length(obskeys)
					yB[i, j] = feval[obskeys[j]]
				end
			end
			savesaltellirestart(yB, "yB", restartdir)
		end
	end
	for i = 1:nP
		for j = 1:N
			for k = 1:nP
				if k == i
					C[j, k] = B[j, k]
				else
					C[j, k] = A[j, k]
				end
			end
		end
		Mads.madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample C ... Parameter $(paramoptkeys[i])\n""" );
		yC = Array{Float64}(N, length(obskeys))
		if parallel
			Cvecs = Array{Array{Float64, 1}}(size(C, 1))
			for j = 1:N
				Cvecs[j] = vec(C[j, :])
			end
			if flagrestart
				pmapresult = RobustPmap.crpmap(farray, checkpointfrequency, joinpath(restartdir, "yC$i"), Cvecs; t=Array{Float64, 1})
			else
				pmapresult = RobustPmap.rpmap(farray, Cvecs; t=Array{Float64, 1})
			end
			for j = 1:N
				for k = 1:length(obskeys)
					yC[j, k] = pmapresult[j][k]
				end
			end
		else
			if !loadsaltellirestart!(yC, "yC$(i)", restartdir)
				for j = 1:N
					feval = f(merge(paramalldict, DataStructures.OrderedDict{String,Float64}(zip(paramoptkeys, C[j, :]))))
					for k = 1:length(obskeys)
						yC[j, k] = feval[obskeys[k]]
					end
				end
				savesaltellirestart(yC, "yC$(i)", restartdir)
			end
		end
		maxnnans = 0
		for j = 1:nO
			yAnonan = isnan.(yA[:,j])
			yBnonan = isnan.(yB[:,j])
			yCnonan = isnan.(yC[:,j])
			nonan = ( yAnonan .+ yBnonan .+ yCnonan ) .== 0
			yT = vcat( yA[nonan,j], yB[nonan,j] ) # this should not include C
			nanindices = find(~nonan)
			# println("$nanindices")
			nnans = length(nanindices)
			if nnans > maxnnans
				maxnnans = nnans
			end
			nnonnans = N - nnans
			# f0T = mean(yT)
			# f0A = mean( yA[nonan,j] )
			# f0B = mean( yB[nonan,j] )
			# f0C = mean( yC[nonan,j] )
			varT = var( yT )
			# varA = abs( ( dot(  yA[nonan,j], yA[nonan,j] ) - f0A^2 * nnonnans ) / ( nnonnans - 1 ) )
			# varA = var( yA[nonan,j] ) # this is faster
			# varB = abs( ( dot( yB[nonan,j], yB[nonan,j] ) - f0B^2 * nnonnans ) / ( nnonnans - 1 ) )
			# varB = var( yB[nonan,j] ) # this is faster
			varC = var( yC[nonan,j] )
			# varP = abs( ( dot( yB[nonan, j], yC[nonan, j] ) / nnonnans - f0B * f0C ) ) # Orignial
			# varP2 = abs( ( dot( yB[nonan, j], yC[nonan, j] ) - f0B * f0C * nnonnans ) / ( nnonnans - 1 ) ) # Imporved
			varP3 = abs( mean( yB[nonan,j] .* ( yC[nonan, j] - yA[nonan,j] ) ) ) # Recommended
			# varP4 = mean( ( yB[nonan,j] - yC[nonan, j] ).^2 ) / 2 # Mads.c; very different from all the other estimates
			# println("varP $varP varP2 $varP2 varP3 $varP3 varP4 $varP4")
			# varPnot = abs( ( dot( yA[nonan, j], yC[nonan, j] ) / nnonnans - f0A * f0C ) ) # Orignial
			# varPnot2 = abs( ( dot( yA[nonan, j], yC[nonan, j] ) - f0A * f0C * nnonnans ) / ( nnonnans - 1 ) ) # Imporved
			# varPnot3 = mean( ( yA[nonan,j] - yC[nonan, j] ).^2 ) / 2 # Recommended; also used in Mads.c
			expPnot =  mean( ( yA[nonan,j] - yC[nonan, j] ).^2 ) / 2
			# println("varPnot $varPnot varPnot2 $varPnot2 varPnot3 $varPnot3")
			variance[obskeys[j]][paramoptkeys[i]] = varC
# 			if varA < eps(Float64) && varP < eps(Float64)
# 				tes[obskeys[j]][paramoptkeys[i]] = mes[obskeys[j]][paramoptkeys[i]] = NaN
# 			else
# 				mes[obskeys[j]][paramoptkeys[i]] = min( 1, max( 0, varP / varA ) ) # varT or varA? i think it should be varA
# 				tes[obskeys[j]][paramoptkeys[i]] = min( 1, max( 0, 1 - varPnot / varB) ) # varT or varA; i think it should be varA; i do not think should be varB?
# 			end
			# mes[obskeys[j]][paramoptkeys[i]] = varP / varT
			# tes[obskeys[j]][paramoptkeys[i]] = 1 - varPnot / varT
			# varianceA[obskeys[j]][paramoptkeys[i]] = varT
			# varianceB[obskeys[j]][paramoptkeys[i]] = 1 - varPnot / varB
			# varianceB[obskeys[j]][paramoptkeys[i]] = varC
			mes[obskeys[j]][paramoptkeys[i]] = varP3 / varT
			# tes[obskeys[j]][paramoptkeys[i]] = 1 - varPnot / varB
			tes[obskeys[j]][paramoptkeys[i]] = expPnot / varT
			# println("N $N nnonnans $nnonnans f0A $f0A f0B $f0B varA $varA varB $varB varP $varP varPnot $varPnot mes $(varP / varA) tes $(1 - varPnot / varB)")
		end
		if maxnnans > 0
			Mads.madswarn("""There are $(maxnnans) NaN's""")
		end
	end
	Dict("mes" => mes, "tes" => tes, "var" => variance, "samplesize" => N, "seed" => seed, "method" => "saltelli")
end

"""
Compute sensitivities for each model parameter; averaging the sensitivity indices over the entire observation range

$(DocumentFunction.documentfunction(computeparametersensitities;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "saresults"=>"dictionary with sensitivity analysis results")))
"""
function computeparametersensitities(madsdata::Associative, saresults::Associative)
	paramkeys = getoptparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	mes = saresults["mes"]
	tes = saresults["tes"]
	var = saresults["var"]
	pvar = DataStructures.OrderedDict{String, Float64}() # parameter variance
	pmes = DataStructures.OrderedDict{String, Float64}() # parameter main effect (first order) sensitivities
	ptes = DataStructures.OrderedDict{String, Float64}()	# parameter total effect sensitivities
	for i = 1:length(paramkeys)
		pv = pm = pt = 0
		for j = 1:length(obskeys)
			m = typeof(saresults["mes"][obskeys[j]][paramkeys[i]]) == Void ? 0 : saresults["mes"][obskeys[j]][paramkeys[i]]
			t = typeof(saresults["tes"][obskeys[j]][paramkeys[i]]) == Void ? 0 : saresults["tes"][obskeys[j]][paramkeys[i]]
			v = typeof(saresults["var"][obskeys[j]][paramkeys[i]]) == Void ? 0 : saresults["var"][obskeys[j]][paramkeys[i]]
			pv += isnan.(v) ? 0 : v
			pm += isnan.(m) ? 0 : m
			pt += isnan.(t) ? 0 : t
		end
		pvar[paramkeys[i]] = pv / length(obskeys)
		pmes[paramkeys[i]] = pm / length(obskeys)
		ptes[paramkeys[i]] = pt / length(obskeys)
	end
	Dict("var" => pvar, "mes" => pmes, "tes" => ptes)
end

# Parallelization of Saltelli functions
saltelli_functions = ["saltelli", "saltellibrute"]
index = 0
for mi = 1:length(saltelli_functions)
	index = mi
	q = quote
		@doc "Parallel version of $(saltelli_functions[index])" ->
		function $(Symbol(string(saltelli_functions[mi], "parallel")))(madsdata::Associative, numsaltellis::Integer; N::Integer=100, seed::Integer=0, restartdir::String="")
			Mads.setseed(seed)
			if numsaltellis < 1
				madserror("Number of parallel sensitivity runs must be > 0 ($numsaltellis < 1)")
				return
			end
			results = RobustPmap.rpmap(i->$(Symbol(saltelli_functions[mi]))(madsdata; N=N, seed=seed+i, restartdir=restartdir), 1:numsaltellis)
			mesall = results[1]["mes"]
			tesall = results[1]["tes"]
			varall = results[1]["var"]
			for i = 2:numsaltellis
				mes, tes, var = results[i]["mes"], results[i]["tes"], results[i]["var"]
				for obskey in keys(mes)
					for paramkey in keys(mes[obskey])
						#meanall[obskey][paramkey] += mean[obskey][paramkey]
						#varianceall[obskey][paramkey] += variance[obskey][paramkey]
						mesall[obskey][paramkey] += mes[obskey][paramkey]
						tesall[obskey][paramkey] += tes[obskey][paramkey]
						varall[obskey][paramkey] += var[obskey][paramkey]
					end
				end
			end
			for obskey in keys(mesall)
				for paramkey in keys(mesall[obskey])
					#meanall[obskey][paramkey] /= numsaltellis
					#varianceall[obskey][paramkey] /= numsaltellis
					mesall[obskey][paramkey] /= numsaltellis
					tesall[obskey][paramkey] /= numsaltellis
					varall[obskey][paramkey] /= numsaltellis
				end
			end
			Dict("mes" => mesall, "tes" => tesall, "var" => varall, "samplesize" => N * numsaltellis, "seed" => seed, "method" => $(saltelli_functions[mi])*"_parallel")
		end # end function
	end # end quote
	eval(q)
end

"""
Print sensitivity analysis results

$(DocumentFunction.documentfunction(printSAresults;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "results"=>"dictionary with sensitivity analysis results")))
"""
function printSAresults(madsdata::Associative, results::Associative)
	mes = results["mes"]
	tes = results["tes"]
	N = results["samplesize"]
	#=
	madsoutput("Mean\n")
	madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		madsoutput("\t$(paramkey)")
	end
	madsoutput("\n")
	for obskey in obskeys
		madsoutput(obskey)
		for paramkey in paramkeys
			madsoutput("\t$(mean[obskey][paramkey])")
		end
		madsoutput("\n")
	end
	madsoutput("\nVariance\n")
	madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		madsoutput("\t$(paramkey)")
	end
	madsoutput("\n")
	for obskey in obskeys
		madsoutput(obskey)
		for paramkey in paramkeys
			madsoutput("\t$(variance[obskey][paramkey])")
		end
		madsoutput("\n")
	end
	=#
	print("\nMain Effect Indices\n")
	print("obs")
	obskeys = getobskeys(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	print("\tSum")
	print("\n")
	for obskey in obskeys
		print(obskey)
		sum = 0
		for paramkey in paramkeys
			sum += mes[obskey][paramkey]
			print("\t$(@sprintf("%f",mes[obskey][paramkey]))")
		end
		print("\t$(sum)")
		print("\n")
	end
	print("\nTotal Effect Indices\n")
	print("obs")
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	print("\tSum")
	print("\n")
	for obskey in obskeys
		print(obskey)
		sum = 0
		for paramkey in paramkeys
			sum += tes[obskey][paramkey]
			print("\t$(@sprintf("%f",tes[obskey][paramkey]))")
		end
		print("\t$(sum)")
		print("\n")
	end
	print("\n")
end

"""
Print sensitivity analysis results (method 2)

$(DocumentFunction.documentfunction(printSAresults2;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "results"=>"dictionary with sensitivity analysis results")))
"""
function printSAresults2(madsdata::Associative, results::Associative)
	mes = results["mes"]
	tes = results["tes"]
	N = results["samplesize"]
	print("Main Effect Indices")
	print("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	print("\n")
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(mes[obskey][paramkey])")
		end
		print("\n")
	end
	print("\nTotal Effect Indices")
	print("\t")
	for paramkey in paramkeys
		print("\t$(paramkey)")
	end
	print("\n")
	for obskey in obskeys
		print(obskey)
		for paramkey in paramkeys
			print("\t$(tes[obskey][paramkey])")
		end
		print("\n")
	end
end

"""
Convert Void's into NaN's in a dictionary

$(DocumentFunction.documentfunction(void2nan!;
argtext=Dict("dict"=>"dictionary")))
"""
function void2nan!(dict::Associative) # TODO generalize using while loop and recursive calls ....
	for i in keys(dict)
		if typeof(dict[i]) <: Dict || typeof(dict[i]) <: DataStructures.OrderedDict
			for j in keys(dict[i])
				if typeof(dict[i][j]) == Void
					dict[i][j] = NaN
				end
				if typeof(dict[i][j]) <: Dict || typeof(dict[i][j]) <: DataStructures.OrderedDict
					for k = keys(dict[i][j])
						if typeof(dict[i][j][k]) == Void
							dict[i][j][k] = NaN
						end
					end
				end
			end
		end
	end
end

"""
Delete rows with NaN in a dataframe `df`

$(DocumentFunction.documentfunction(deleteNaN!;
argtext=Dict("df"=>"dataframe")))
"""
function deleteNaN!(df::DataFrames.DataFrame)
	for i in 1:length(df)
		if typeof(df[i][1]) <: Number
			DataFrames.deleterows!(df, find(isnan.(df[i][:])))
			if size(df)[1] == 0
				return
			end
		end
	end
end

"""
Scale down values larger than max(Float32) in a dataframe `df` so that Gadfly can plot the data

$(DocumentFunction.documentfunction(maxtorealmax!;
argtext=Dict("df"=>"dataframe")))
"""
function maxtorealmax!(df::DataFrames.DataFrame)
	limit = realmax(Float32)
	for i in 1:length(df)
		if typeof(df[i][1]) <: Number
			for j in 1:length(df[i])
				if df[i][j] > limit
					df[i][j] = limit
				end
			end
		end
	end
end

"""
Sensitivity analysis using Saltelli's extended Fourier Amplitude Sensitivity Testing (eFAST) method

$(DocumentFunction.documentfunction(efast;
argtext=Dict("md"=>"MADS problem dictionary"),
keytext=Dict("N"=>"number of samples [default=`100`]",
            "M"=>"maximum number of harmonics [default=`6`]",
            "gamma"=>"multiplication factor (Saltelli 1999 recommends gamma = 2 or 4) [default=`4`]",
            "plotresults"=>"plot results [default=`Mads.graphoutput`]",
            "seed"=>"random seed [default=`0`]",
            "issvr"=>"use SVR [default=`false`]",
            "truncateRanges"=>"truncate parameter ranges [default=`0`]",
            "checkpointfrequency"=>"check point frequency [default=`N`]",
            "restartdir"=>"directory where files will be stored containing model results for fast simulation restarts [default=`\"efastcheckpoints\"`]",
            "restart"=>"save restart information [default=`false`]")))

Dumps:

- plot of results, default from `graphoutput`
"""
function efast(md::Associative; N::Integer=100, M::Integer=6, gamma::Number=4, plotresults::Bool=graphoutput, seed::Integer=0, issvr::Bool=false, truncateRanges::Number=0, checkpointfrequency::Integer=N, restartdir::String="efastcheckpoints", restart::Bool=false)
	# a:         Sensitivity of each Sobol parameter (low: very sensitive, high; not sensitive)
	# A and B:   Real & Imaginary components of Fourier coefficients, respectively. Used to calculate sensitivty.
	# AV:        Sum of total variances (divided by # of resamples to get mean total variance, V)
	# AVci:      Sum of complementary variance indices (divided by # of resamples to get mean, Vci)
	# AVi:       Sum of main effect variance indices (divided by # of resamples to get mean, Vi)
	# ismads:    Boolean that tells us whether our system is analyzed in mads or as a standalone
	# InputData: Different size depending on whether we are analyzing a mads system or using eFAST as a standalone.  If analyzing a mads problem,
	# 			 InputData will have two columns, where the first column holds the saltelli_functions of parameters we are analyzing and the second holds
	#			 the probability distributions of the parameters.  If using eFAST as a standalone, InputData will have 6 columns, holding, respectively,
	#			 the name, distribution type, initial value, min/mean, max/std, and a boolean.  If distribution type is uniform columns 4 and 5 will hold
	# 			 the min/max values, if the distribution type is normal or lognormal columns 4 and 5 will hold mean/std.  Boolean tells us whether the
	# 			 parameter is being analyzed or not (1 for yes, 0 for no).  After passing through eFASt_interpretDAta.jl InputData will be the same as
	#			 in mads (2 columns)
	# M:         Max # of harmonics
	# n:         Total # of input parameters
	# nprime:    # of input parameters that we are ANALYZING
	# ny:        # of outputs our model returns (if ny == 1 then system is not dynamic (model output is scalar))
	# Nr:        # of resamples
	# Ns:        Sample points along a single search curve (Ns_total = Ns*Nr)
	# Ns_total:  Total amount of sample points including all resamples (computational cost
	#            of calculating all main and total indices is C=Ns_total*nprime)
	# phi:       Random phase shift between (0 2pi)
	# P:         P = nworkers(); (Number of processors
	# resultvec: Components of resultvec are [AV, AVi, AVci] which correspond to "all" (sum) of total variance, variance component for
	#            parameter i, and complementary variance for parameter i.  Sum is over ALL RESAMPLES (so resultvec is divided by Nr at end).
	#            If system has dynamic output (i.e. ny>1) then each component of resultvec will have length ny.
	# resultmat: When looping with parameters on the outside, an extra dimension is needed in order to store all results. Analogous to resultvec
	#            but holds all results for every parameter.
	# Si:        "Main effect" sensitivity index for parameter i
	# Sti:       "Total effect" sensitivity index for parameter i
	# Wi:        Maximum frequency, corresponds to parameter we are attempting to analyze
	#            (So to calculate all indices, each parameter will be assigned Wi at some point)
	# W_comp:    Vector of complementary frequencies
	# W_vec:     Vector of all frequencies including Wi and complementary frequencies.
	# X:         2-d array of model input (Ns x n)
	# Y:         2-d array of model output (Ns x Nr) (Or higher dimension if we are running mads or user defines dynamic system)
	#
	##
	if restart
		restartdir = getrestartdir(md)
	end

	Mads.setseed(seed)

	## Setting pathfiles
	efastpath = "/n/srv/jlaughli/Desktop/Julia Code/"

	function eFAST_getCompFreq(Wi, nprime, M)
		if nprime == 1 # Special case if n' == 1 -> W_comp is the null set
			W_comp = []
			Wcmax = 0
			return W_comp, Wcmax
		end
		# Max complementary frequency (to avoid interference) with Wi
		Wcmax = floor(Int, 1 / M * (Wi / 2))
		if Wi <= nprime - 1 # CASE 1: Very small Wcmax (W_comp is all ones)
			W_comp = ones(1, nprime - 1)
		elseif Wcmax < nprime - 1 # CASE 2: Wcmax < nprime - 1
			step   = 1
			loops  = ceil((nprime - 1) / Wcmax) #loops rounded up
			# W_comp has a step size of 1, might need to repeat W_comp frequencies to avoid going over Wcmax
			W_comp = []
			for i = 1:loops
				W_comp = [W_comp; collect(1:step:Wcmax)]
			end
			W_comp = W_comp[1:(nprime - 1)] # Reducing W_comp to a vector of size nprime
		elseif Wcmax >= nprime-1 # CASE 3: wcmax >= nprime -1 Most typical case
			step   = round(Wcmax / (nprime - 1))
			W_comp = 1 : step : step * (nprime - 1)
		end
		return W_comp, Wcmax
	end

	function eFAST_optimalSearch(Ns_total, M, gamma)
		# Iterate through different integer values of Nr (# of resamples)
		# If loop finishes, script will adjust Ns upwards to obtain an optimal
		for Nr = 1:50
			Wi = (Ns_total / Nr - 1) / (gamma * M)        # Based on Nyquist Freq
			# Based on (Saltelli 1999), Wi/Nr should be between 16-64
			# ceil(Wi) == floor(Wi) checks if Wi is an integer frequency
			if 16 <= Wi/Nr && Wi/Nr <= 64 && ceil(Wi - eps(Float32)) == floor(Wi + eps(Float32))
				Wi = Int(Wi)
				Ns = Int(Ns_total / Nr)
				if iseven(Ns)
					Ns += 1
					Ns_total = Ns * Nr
				end
				return Nr, Wi, Ns, Ns_total
			end
		end
		# If the loop above could not find optimal Wi/Nr pairing based on given Ns & M
		# If script reaches this point, this loop adjusts Ns (upwards) to obtain
		# optimal Nr/Wi pairing.
		Ns0 = Ns_total # Freezing original Ns value given
		for Nr = 1:100
			for Ns_total = Ns0 + 1:1:Ns0 + 5000
				Wi = (Ns_total / Nr - 1) / ( gamma * M)
				if 16 <= Wi/Nr && Wi/Nr <= 64 && ceil(Wi - eps(Float32)) == floor(Wi + eps(Float32))
					Wi = round(Int, Wi)
					Ns = round(Int, Ns_total / Nr)
					if iseven(Ns)
						Ns += 1
						Ns_total = Ns * Nr
					end
					Mads.madsoutput("Ns_total has been adjusted (upwards) to obtain optimal Nr/Wi pairing!\n");
					Mads.madsoutput("Ns_total = $(Ns_total) ... Nr = $Nr ... Wi = $Wi ... Ns = $Ns\n");
					return Nr, Wi, Ns, Ns_total
				end
			end
		end
		# If script reaches this section of code, adjustments must be made to Ns boundaries
		madserror("ERROR! Change bounds in eFAST_optimalSearch or choose different Ns/M")
	end

	function eFAST_distributeX(X, nprime, InputData, ismads)
		if ismads == 0 ## If we are using this as a standalone (reading input from csv):
			# Store X (which only contains transformations for parameters of interest)
			# in temporary array so we can create larger X including parameters we hold constant.
			tempX = X
			X = zeros(Ns,n)
			for k = 1:n
				# If the value we assigned to parameter k is a distribution, apply said distribution to its search curve
				# Otherwise, set it as a constant (for parameters we are not analyzing)
				if issubtype(typeof(InputData[k,2]), Distributions.Distribution)
					X[:,k] = quantile(InputData[k,2],tempX[:,k])
				else
					X[:,k] = InputData[k,2]
				end #End if
			end # End k=1:n
		else # If we are using this as part of mads (reading input from mads):
			# Attributing data matrix to vectors
			# dist provides all necessary information on distribution (type, min, max, mean, std)
			(name, dist) = (InputData[:,1], InputData[:,2])
			for k = 1:nprime
				# If parameter is one we are analyzing then we will assign numbers according to its probability dist
				# Otherwise, we will simply set it at a constant (i.e. its initial value)
				# This returns true if the parameter k is a distribution (i.e. it IS a parameter we are interested in)
				if issubtype(typeof(InputData[k,2]), Distributions.Distribution)
					# dist contains all data about distribution so this will apply any necessary distributions to X
					X[:,k] = quantile(dist[k],X[:,k])
				else
					madscritical("ERROR in assinging Input Data! (Check InputData matrix and/or eFAST_distributeX.jl")
					return
				end # End if
			end # End k=1:nprime (looping over parameters of interest)
		end
		return X
	end

	function eFAST_Parallel_kL(kL)
		# 0 -> We are removing the phase shift FOR SVR
		phase = 1
		## Redistributing constCell
		ismads = constCell[1]
		if ismads == 0
			(ismads, P, nprime, ny, Nr, Ns, M, Wi, W_comp, S_vec, InputData, issvr, seed) = constCell
			issvr = 0; directOutput = 0
		else
			(ismads, P, nprime, ny, Nr, Ns, M, Wi, W_comp,S_vec, InputData, paramalldict, paramkeys, issvr, directOutput, f, seed) = constCell
		end

		# If we want to use a seed for our random phis
		# +kL because we want to have the same string of seeds for any initial seed
		srand(seed+kL)

		# Determining which parameter we are on
		k = Int(ceil(kL/Nr))

		# Initializing
		W_vec   = zeros(1,nprime) 	   # W_vec (Frequencies)
		phi_mat = zeros(nprime,Ns)    # Phi matrix (phase shift corresponding to each resample)

		## Creating W_vec (kth element is Wi)
		W_vec[k] = Wi
		## Edge cases
		# As long as nprime!=1 our W_vec will have complementary frequencies
		if nprime !=1
			if k != 1
				W_vec[1:(k-1)] = W_comp[1:(k-1)]
			end
			if k != nprime
				W_vec[(k+1):nprime] = W_comp[k:(nprime-1)]
			end
		end

		# Slight inefficiency as it creates a phi_mat every time (rather than Nr times)
		# Random Phase Shift
		phi = rand(1,nprime) * 2 * pi
		for j = 1:Ns
			phi_mat[:,j] = phi'
		end

		## Preallocate/Initialize
		A     = 0
		B     = 0                          # Fourier coefficients
		Wi 	  = maximum(W_vec)				# Maximum frequency (i.e. the frequency for our parameter of interest)
		Wcmax = maximum(W_comp)				# Maximum frequency in complementary set

		# Adding on the random phase shift
		alpha = W_vec' * S_vec' + phi_mat    # W*S + phi
		# If we want a simpler system this removes the phase shift
		if phase == 0
			alpha = W_vec'*S_vec'
		end
		X = .5 + asin.(sin.(alpha'))/pi # Transformation function Saltelli suggests

		# In this function we assign probability distributions to parameters we are analyzing
		# and set parameters that we aren't analyzing to constants.
		# It is not important to us in calculating sensitivity so we only save it
		# for long enough to calculate Y.
		# QUESTION do we need LHC sampling?
		X = eFAST_distributeX(X, nprime, InputData, ismads)

		# Pre-allocating Model Output
		Y = zeros(Ns, ny)

		# IF WE ARE READING OUTPUT OF MODEL DIRECTLY!

		if directOutput==1
			info("Output taken directly from data file. Parameter k = $k ($(paramkeys[k])) ...")
			Y = OutputData[:,:,k]
			## CALCULATING MODEL OUTPUT (SVR)
			# If we are using svrobj as our surrogate model function, calculate Y as such:
		elseif issvr
			## Need to convert data into SVR form
			# Boolean determining whether inputs are in log scale or not!   ACCORDING TO NATALIA WE SHOULD NOT HAVE TO SCALE
			islog = 0
			X_svr = Array{Float64}((Ns*ny,nprime+1))
			predictedY = zeros(size(X_svr,1))
			for i = 1:Ns
				for j = 1:ny
					X_svr[50*(i-1) + j, 1:nprime] = X[i,:]
					X_svr[50*(i-1) + j, nprime+1] = j
				end
			end

			# Converting X to log scale
			if islog == 1
				X_svr[:,(1:nprime)] = log(X_svr[:,(1:nprime)])
			end

			# Compute model output
			info("Computing surrogate model (SVR) for parameter k = $k ($(paramkeys[k])) ...")
			for i = 1 : ny
				idx = find( x-> (x == i), X_svr[:,(nprime+1)])
				predictedY[idx] = predictSVR(X_svr[idx,:], svrobj[i])
			end

			# Converting Y back to format we use for eFAST
			Y = reshape(predictedY',(ny,Ns))'

			## CALCULATING MODEL OUTPUT (Mads)
			# If we are analyzing a mads problem, we calculate our model output as such:
		elseif ismads == 1
			#= This seems like weird test to decide if things should be done in parallel or serial...I suggest we drop it and always pmap
			if P <= Nr*nprime+(Nr+1)
				### Adding transformations of X and Y from svrobj into here to accurately compare runtimes of mads and svr
				#X_svr = Array{Float64}((Ns*ny,nprime+1))
				#predictedY = zeros(size(X_svr,1))
				#for i = 1:Ns
				#  for j = 1:ny
				#    X_svr[50*(i-1) + j, 1:nprime] = X[i,:]
				#    X_svr[50*(i-1) + j, nprime+1] = j
				#  end
				#end
				#if islog == 1
				#	X_svr[:,(1:nprime)] = log(X_svr[:,(1:nprime)])
				#end
				#println("x_svr reshaped test")

				# If # of processors is <= Nr*nprime+(Nr+1) compute model output in serial
				Mads.madsoutput("""Compute model output in serial ... $(P) <= $(Nr*nprime+(Nr+1)) ...\n""")
				@showprogress 1 "Computing models in serial - Parameter k = $k ($(paramkeys[k])) ... " for i = 1:Ns
					Y[i, :] = collect(values(f(merge(paramalldict, DataStructures.OrderedDict{String,Float64}(zip(paramkeys, X[i, :]))))))
				end
			else
				=#
				# If # of processors is > Nr*nprime+(Nr+1) compute model output in parallel
				Mads.madsoutput("""Compute model output in parallel ... $(P) > $(Nr*nprime+(Nr+1)) ...\n""")
				Mads.madsoutput("""Computing models in parallel - Parameter k = $k ($(paramkeys[k])) ...\n""")
				if restart
					Y = hcat(RobustPmap.crpmap(i->collect(values(f(merge(paramalldict, DataStructures.OrderedDict{String, Float64}(zip(paramkeys, X[i, :])))))), checkpointfrequency, joinpath(restartdir, "efast_$(kL)_$k"), 1:size(X, 1))...)'
				else
					Y = hcat(RobustPmap.rpmap(i->collect(values(f(merge(paramalldict, DataStructures.OrderedDict{String, Float64}(zip(paramkeys, X[i, :])))))), 1:size(X, 1))...)'
				end
			#end #End if (processors)

			## CALCULATING MODEL OUTPUT (Standalone)
			# If we are using this program as a standalone, we enter our model function here:
		elseif ismads == 0
			# If # of processors is <= Nr*nprime+(Nr+1) compute model output serially
			if P <= Nr*nprime+(Nr+1)
				for i = 1:Ns
					info("Calculating model output (not mads or svr) from .jl file in serial - Parameter k = $k ($(paramkeys[k])) ...")
					# Replace this with whatever model we are analyzing
					Y[i,:] = defineModel_Sobol(X[i,:])
				end
				# If # of processors is > Nr*nprime+(Nr+1) compute model output in parallel
			else
				info("Calculating model output (not mads or svr) from .jl file in parallel - Parameter k = $k ($(paramkeys[k])) ...")
				Y = zeros(1,ny)
				Y = @parallel (vcat) for j = 1:Ns
					defineModel_Sobol(X[j,:])
				end #End Parallel for loop
			end #End if (processors)
		end #End if isdefined(:OutputData)

		## CALCULATING FOURIER COEFFICIENTS
		## If length(Y[1,:]) == 1, system is *not dynamic* and we don't need to add an extra dimension
		if ny == 1
			# These will be the sums of variances over all resamplings (Nr loops)
			AVi = AVci = AV = 0                     # Initializing Variances to 0

			Mads.madsoutput("Calculating Fourier coefficients for observations ...\n")
			## Calculating Si and Sti (main and total sensitivity indices)
			# Subtract the average value from Y
			Y = (Y - mean(Y))'
			## Calculating Fourier coefficients associated with MAIN INDICES
			# p corresponds to the harmonics of Wi
			for p = 1:M
				A = dot(Y[:], cos.(Wi*p*S_vec))
				B = dot(Y[:], sin.(Wi*p*S_vec))
				AVi += A^2 + B^2
			end
			# 1/Ns taken out of both A and B for optimization!
			AVi = AVi / Ns^2
			## Calculating Fourier coefficients associated with COMPLEMENTARY FREQUENCIES
			for j = 1:Wcmax * M
				A = dot(Y[:], cos.(j * S_vec))
				B = dot(Y[:], sin.(j * S_vec))
				AVci = AVci + A^2 + B^2
			end
			AVci = AVci / Ns^2
			## Total Variance By definition of variance: V(Y) = (Y - mean(Y))^2
			AV = dot(Y[:], Y[:]) / Ns
			# Storing results in a vector format
			resultvec = [AV AVi AVci]
		elseif ny > 1
			## If system is dynamic, we must add an extra dimension to calculate sensitivity indices for each point
			# These will be the sums of variances over all resamplings (Nr loops)
			AV   = zeros(ny,1)                   # Initializing Variances to 0
			AVi  = zeros(ny,1)
			AVci = zeros(ny,1)
			## Calculating Si and Sti (main and total sensitivity indices)
			# Looping over each point in time
			@ProgressMeter.showprogress 1 "Calculating Fourier coefficients for observations ... " for i = 1:ny
				# Subtract the average value from Y
				Y[:,i] = (Y[:,i] - mean(Y[:,i]))'
				## Calculating Fourier coefficients associated with MAIN INDICES
				# p corresponds to the harmonics of Wi
				for p = 1:M
					A = dot(Y[:,i], cos.(Wi * p * S_vec))
					B = dot(Y[:,i], sin.(Wi * p * S_vec))
					AVi[i]  = AVi[i] + A^2 + B^2
				end
				# 1/Ns taken out of both A and B for optimization!
				AVi[i] = AVi[i] / Ns^2
				## Calculating Fourier coefficients associated with COMPLEMENTARY FREQUENCIES
				for j = 1:Wcmax * M
					A = dot(Y[:,i], cos.(j * S_vec))
					B = dot(Y[:,i], sin.(j * S_vec))
					AVci[i] = AVci[i] + A^2 + B^2
				end
				AVci[i] = AVci[i] / Ns^2
				## Total Variance By definition of variance: V(Y) = (Y - mean(Y))^2
				AV[i] = dot(Y[:,i], Y[:,i]) / Ns
			end #END for i = 1:ny
			# Storing results in matrix format
			resultvec = hcat(AV, AVi, AVci)
		end #END if length(Y[1,:]) > 1
		return resultvec # resultvec will be an array of size (ny,3)
	end

	# Define the following if we are using svrobj
	if issvr
		function svrJSONConvert(svrobjJSON::Array{Any,1})
			svrobjJSON = svrobjJSON[1]
			totalSVRObject = size(svrobjJSON,1)
			svrobj = Array{svrOutput}(totalSVRObject, 1)
			for svrObjectI = 1 : totalSVRObject
				alpha = float(svrobjJSON[svrObjectI]["alpha"])
				b = float(svrobjJSON[svrObjectI]["b"])
				kernel = svrobjJSON[svrObjectI]["kernelType"]
				varargin = float(svrobjJSON[svrObjectI]["varargin"])
				train_data = Array{Float64}(size(svrobjJSON[svrObjectI]["train_data"][1],1), size(svrobjJSON[svrObjectI]["train_data"],1))
				for i = 1 : size(svrobjJSON[svrObjectI]["train_data"], 1)
					train_data[:,i] = float(svrobjJSON[svrObjectI]["train_data"][i])
				end
				if kernel == "gaussian"
					lambda = varargin[1]
					kernel_function = (x,y)->exp(-lambda*norm(x.feature-y.feature,2)^2)
				elseif kernel == "spline"
					Mads.madserror("Spline kernel is not implemented!")
					# kernel_function(a,b) = prod(arrayfun(@(x,y) 1 + x*y+x*y*min(x,y)-(x+y)/2*min(x,y)^2+1/3*min(x,y)^3,a.feature,b.feature))
				elseif kernel == "periodic"
					l = varargin[1]
					p = varargin[2]
					kernel_function = (x,y)->exp(-2*sin.(pi*norm(x.feature-y.feature,2)/p)^2/l^2)
				elseif kernel == "tangent"
					a = varargin[1]
					c = varargin[2]
					kernel_function = (x,y)->prod(tanh(a*x.feature'*y.feature+c))
				else
					throw("Error!")
				end
				svrobj[svrObjectI] = svrOutput(alpha, b, kernel_function, kernel, train_data, varargin)
			end
			return totalSVRObject, svrobj
		end

		# ***************************************************************************************************
		# SVR prediction function based on svrOutput object
		# ***************************************************************************************************
		function predictSVR(data::Array{Float64,2}, svrobj::svrOutput)
			n_predict = size(x, 1)
			output = Array{Float64}(n_predict)
			for i = 1:n_predict
				output[i] = svr_eval(data[i,:], svrobj)
			end
			return output
		end

		function predictSVR(data::Array{Float64,1}, svrobj::svrOutput)
			n_predict = size(x, 1)
			output = Array{Float64}(n_predict)
			for i = 1:n_predict
				output[i] = svr_eval(data[i,:], svrobj)
			end
			return output
		end

		function svr_eval(x::Array{Float64,2}, svrobj::svrOutput)
			n_predict = size(x, 1)
			sx = Array{svrFeature}(n_predict)
			for i = 1:n_predict
				sx[i] = svrFeature(vec(x[i,:]))
			end
			n_train = size(svrobj.train_data, 1)
			sy = Array{svrFeature}(n_train)
			for i = 1:n_train
				sy[i] = svrFeature(vec(svrobj.train_data[i,:]))
			end
			f = 0
			for i = 1:n_train
				f += svrobj.alpha[i] * svrobj.kernel( sx[1], sy[i])
			end
			f = f #+ svrobj.b
			f = f / 2
			return f
		end

		function svr_eval(x::Float64, svrobj::svrOutput)
			n_predict = size(x, 1)
			sx = Array{svrFeature}(n_predict)
			for i = 1:n_predict
				sx[i] = svrFeature([x[i,]])
			end
			n_train = size(svrobj.train_data, 1)
			sy =Array{svrFeature}(n_train)
			for i = 1:n_train
				sy[i] = svrFeature([svrobj.train_data[i,]])
			end
			f = 0
			for i = 1:n_train
				f += svrobj.alpha[i] * svrobj.kernel( sx[1], sy[i])
			end
			f = f #+ svrobj.b
			f = f / 2
			return f
		end
	end
	################################### END - DEFINING MODULES

	## Set GSA Parameters
	# M        = 6          # Max # of Harmonics (usually set to 4 or 6)
	# Lower values of M tend to underestimate main sensitivity indices.
	Ns_total = N # Total Number of samples over all search curves (minimum for eFAST method is 65)
	# Choosing a small Ns will increase speed but decrease accuracy
	# Ns_total = 65 will only work if M=4 and gamma = 2 (Wi >= 8 is the actual constraint)
	# gamma    = 4          # To adjust equation Wi = (Ns_total/Nr - 1)/(gamma*M)
	# Saltelli 1999 suggests gamma = 2 or 4; higher gammas typically give more accurate results and are even *sometmies* faster.

	# Are we reading from a .mads file or are we running this as a standalone (input: .csv, output: .exe)?
	# 1 for MADS, 0 for standalone. Basically determines IO of script.
	ismads         = 1
	# 1 if we are reading model output directly (e.g. from .csv), 0 if we are using some sort of script to calculate model output
	directOutput   = 0
	# 1 if we are using svr model function (svrobj) to calculate Y
	#issvr          = 1 #defined in function
	# Plot results as .svg file
	# plotresults    = 0 #defined in function
	# Truncate ranges of parameter space (for SVR)
	if issvr
		truncateRanges = 1
		increaserange  = 0
	end

	###### For convenience - Sets booleans automatically (uncomment to use)
	## Reading from SVR surrogate model on wells
	#(ismads, directOutput, issvr, plotresults, truncateRanges) = (1,0,1,0,1)
	## Calculating SA of wells using mads model (NOT SVR)
	#(ismads, directOutput, issvr, plotresults, truncateRanges) = (1,0,0,0,1)
	## Using Sobol function
	#(ismads, directOutput, issvr, plotresults, truncateRanges) = (0,0,0,0,0)

	# Number of processors (for parallel computing)
	# Different values of P will determine how program is parallelized
	# If P > 1 -> Program will parallelize resamplings & parameters
	# If P > Nr*nprime + 1 -> (Nr*nprime + 1) is the amount of processors necessary to fully parallelize all resamplings over
	# every parameter (including +1 for the master).  If P is larger than this extra cores will be allocated to computing
	# the model output quicker.
	P = nworkers()
	madsoutput("Number of processors is $P\n")

	paramallkeys  = getparamkeys(md)
	# Values of this dictionary are intial values
	paramalldict  = DataStructures.OrderedDict{String,Float64}(zip(paramallkeys, map(key->md["Parameters"][key]["init"], paramallkeys)))
	# Only the parameters we wish to analyze
	paramkeys     = getoptparamkeys(md)
	# All the observation sites and time points we will analyze them at
	obskeys       = getobskeys(md)
	# Get distributions for the parameters we will be performing SA on
	distributions = getparamdistributions(md)

	# Function for model output
	f = makemadscommandfunction(md)

	# Pre-allocating InputData Matrix
	InputData = Array{Any}(length(paramkeys),2)

	### InputData will hold PROBABILITY DISTRIBUTIONS for the parameters we are analyzing (Other parameters stored in paramalldict)
	for i = 1:length(paramkeys)
		InputData[i,1] = paramkeys[i]
		InputData[i,2] = distributions[paramkeys[i]]
	end

	# Total number of parameters
	n      = length(paramallkeys)
	# Number of parameters we are analyzing
	nprime = length(paramkeys)
	# ny > 1 means system is dynamic (model output is a vector)
	ny     = length(obskeys)

	##### Truncate paramkeys here
	#paramkeys = paramkeys[1:2]

	if truncateRanges ==1
		##### Truncated ranges Boian asked for (ranges were too large for SVR)
		############## FORCED INPUT ##############
		percentDict = Dict("vx"=>.20, "ax"=>.50, "ts_dsp"=>.30, "source1_f"=>.10, "source1_t0"=>.20, "source1_x"=>.05, "source1_t1"=>.10)
		#Increasing ranges
		if increaserange == 1
			#percentDict = ["vx"=>.40, "ax"=>.95, "ts_dsp"=>.60, "source1_f"=>.20, "source1_t0"=>.40, "source1_x"=>.10, "source1_t1"=>.20]
			percentDict["source1_t1"] = .40
		end

		logdistribution = 1
		for k = 1:length(paramkeys)
			# Initial value for parameter k
			initvalue 	   = paramalldict["$(paramkeys[k])"]
			percentvalue   = percentDict["$(paramkeys[k])"]

			# Special case for source1_t0 since initial value == max value
			if logdistribution == 1
				if paramkeys[k] == "source1_t0"
					InputData[k,2] = Uniform(log(initvalue - 2*initvalue*percentvalue), log(initvalue))
				else
					InputData[k,2] = Uniform(log(initvalue - initvalue*percentvalue), log(initvalue + initvalue*percentvalue))
				end
			else
				if paramkeys[k] == "source1_t0"
					InputData[k,2] = Uniform(initvalue - 2*initvalue*percentvalue, initvalue)
				else
					InputData[k,2] = Uniform(initvalue - initvalue*percentvalue, initvalue + initvalue*percentvalue)
				end
			end
		end
	end

	# This is here to delete parameters of interest from paramalldict
	# The parameters of interest will be calculated by eFAST_distributeX
	# We utilize the "merge" function to combine the two when we are calculating model output
	for key in paramkeys
		delete!(paramalldict, key)
	end

	## Here we define additional parameters (importantly, the frequency for our "Group of Interest", Wi)
	# This function chooses an optimal Nr/Wi pair (based on Saltelli 1999)
	# Adjusts Ns (upwards) if necessary

	Nr, Wi, Ns, Ns_total = eFAST_optimalSearch(Ns_total, M, gamma)

	forced = 0
	if forced == 1
		## Forced inputs here:
		# Note: Ns must be odd, eFAST_optimalSearch.jl will adjust for this if necessary but if you use a forced input
		# make sure to keep this in mind.
		# Ns =
		Wi = int(100)
		Nr = int(ceil(Ns_total/(gamma*M*Wi+1)))

		Ns       = int((gamma*M*Wi+1))
		if mod(Ns,2) != 1
			Ns += 1
		end
		Ns_total = int(Ns*Nr)
		info("eFAST parameters after forced inputs: \n Ns_total = $(Nr*Ns) Nr = $Nr ... Wi = $Wi ... Ns = $Ns")
	end

	## For debugging and/or graphs
	# step  = (M*Wi - 1)/Ns
	# omega = 1 : step : M*Wi - step  # Frequency domain, can be used to plot power spectrum

	## Error Check (Wi=8 is the minimum frequency required for eFAST. Ns_total must be at least 65 to satisfy this criterion)
	if Wi<8
		madscritical("ERROR! Choose larger Ns_total value! (Ns_total = 65 is minimum for eFAST)")
		return
	end

	## If our output is read directly from some sort of data file rather than using a model function

	# svrtruncate is simply a boolean to truncate output .csv file (NOT INPUT RANGES)!! (For some reason model output is listed in second column)
	# Do NOT set this boolean to 1 unless if output is from surrogate model
	svrtruncate = 0
	if directOutput == 1
		# Reading in data
		tempOutputData = Array{Any}((Ns*ny, 1, nprime))
		OutputData     = Array{Any}((Ns, ny, nprime))
		if svrtruncate == 1
			tempOutputData = Array{Any}((Ns*ny, 2,nprime))
		end
		for k = 1:nprime
			#OutputDataSource = "/Users/jlaughli/Desktop/Julia Code/For SVR/After 8-20-15/eFAST/svr results/res_eFAST_$(paramkeys[k])_5%_mads_output_N=625_predicted.csv"
			OutputDataSource = "/Users/jlaughli/Desktop/Julia Code/Data/For Testing/eFAST_$(paramkeys[k])_5%_mads_output_N=625.csv"
			tempOutputData[:,:,k] = readcsv(OutputDataSource)
		end
		if svrtruncate == 1
			tempOutputData = tempOutputData[:,2,:]
		end

		for k = 1:nprime
			OutputData[:,:,k] = reshape(tempOutputData[:,:,k], (ny,Ns))'
		end
		ny = int(length(OutputData[1,:,1]))
		# Converting data into similar format (PROB NEED TO ADD IN PHASE SHIFT HERE, change OutputData to a 3d array)
	end

	## Begin eFAST analysis:

	## Start timer
	tic()

	madsinfo("""Begin eFAST analysis ... """)

	# This script determines complementary frequencies
	(W_comp, Wcmax) = eFAST_getCompFreq(Wi, nprime, M)

	# New domain [-pi pi] spaced by Ns points
	S_vec = linspace(-pi, pi, Ns)

	## Preallocation
	resultmat = zeros(nprime,3,Nr)   # Matrix holding all results (decomposed variance)
	Var       = zeros(ny,nprime)     # Output variance
	Si        = zeros(ny,nprime)     # Main sensitivity indices
	Sti       = zeros(ny,nprime)     # Total sensitivity indices
	W_vec     = zeros(1,nprime)      # W_vec (Frequencies)

	########## DIFFERENT CASES DEPENDING ON # OF PROCESSORS
	#if P <= nprime*Nr + 1
	# Parallelized over n AND Nr

	#if P > nprime*Nr + 1
	# nworkers() is quite high, we choose to parallelize over n, Nr, AND also model output

	if P>1
		madsinfo("""Parallelizing resamplings AND parameters""");
	else
		madsinfo("""No Parallelization!""");
	end

	## Storing constants inside of a cell
	# Less constants if not mads
	if ismads == 0
		constCell = Any[ismads, P, nprime, ny, Nr, Ns, M, Wi, W_comp, S_vec, InputData, issvr, seed]
	else
		constCell = Any[ismads, P, nprime, ny, Nr, Ns, M, Wi, W_comp, S_vec, InputData, paramalldict, paramkeys, issvr, directOutput, f, seed]
	end

	## Sends arguments to processors p
	function sendto(p; args...)
		for i in p
			for (nm, val) in args
				@spawnat(i, eval(Main, Expr(:(=), nm, val)))
			end
		end
	end

	## Sends all variables stored in constCell to workers dedicated to parallelization across parameters and resamplings
	if P > Nr * nprime + 1
		# We still may need to send f to workers only calculating model output??
		# sendto(collect(2:nprime*Nr), constCell = constCell)
		sendto(workers(), constCell = constCell)
	elseif P > 1
		# If there are less workers than resamplings * parameters, we send to all workers available
		sendto(workers(), constCell = constCell)
	end

	## If we are using svrobj as our model function:
	if issvr
		# Include necessary functions on every processor to calculate svrobj
		svrObjFileName = "svr_objects_trained_with_c_1.0e6_eps_0.1"
		totalSVRObjects, svrobj = svrJSONConvert(JSON.parsefile(string(efastpath*"svrobj/well10a/",svrObjFileName,".json")))

		# Send svrobj to all processors
		sendto(workers(), svrobj = svrobj)
		sendto(workers(), totalSVRObjects = totalSVRObjects)
	end

	## If we are reading output directly from file
	if directOutput == 1
		sendto(workers(), OutputData = OutputData)
	end

	### Calculating decomposed variances in parallel ###
	allresults = map((kL)->eFAST_Parallel_kL(kL), 1:nprime*Nr)

	## Summing & normalizing decomposed variances to obtain sensitivity indices
	for k = 1:nprime
		# Sum of variances across all resamples
		resultvec = sum(allresults[(1:Nr) + Nr * ( k - 1 )])

		## Calculating Sensitivity indices (main and total)
		V        = resultvec[:,1] / Nr
		Vi       = 2 * resultvec[:,2] / Nr
		Vci      = 2 * resultvec[:,3] / Nr
		# Main effect indices (i.e. decomposed variance, before normalization)
		Var[:,k] = Vi
		# Normalizing vs mean over loops
		Si[:,k]  = Vi ./ V
		Sti[:,k] = 1 - Vci ./ V
	end
	Mads.madsinfo("""End eFAST analysis ... """);
	Mads.madsinfo("""Elapsed time for eFAST is $(toq())"""); ## End timer & display elapsed time

	# Save results as dictionary
	tes = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	mes = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	var = DataStructures.OrderedDict{String,DataStructures.OrderedDict}()
	for j = 1:length(obskeys)
		tes[obskeys[j]] = DataStructures.OrderedDict{String,Float64}()
		mes[obskeys[j]] = DataStructures.OrderedDict{String,Float64}()
		var[obskeys[j]] = DataStructures.OrderedDict{String,Float64}()
	end
	for k = 1:length(paramkeys)
		for j = 1:length(obskeys)
			var[obskeys[j]][paramkeys[k]] = Var[j,k]
			tes[obskeys[j]][paramkeys[k]] = Sti[j,k]
			mes[obskeys[j]][paramkeys[k]] = Si[j,k]
		end
	end

	if issvr
		info("returning results efast analysis of SVR model")
		return Dict("mes" => mes, "tes" => tes, "var" => var, "samplesize" => Ns_total, "method" => "efast(SVR)", "seed" => seed)
	else
		return Dict("mes" => mes, "tes" => tes, "var" => var, "samplesize" => Ns_total, "method" => "efast", "seed" => seed)
	end

	# Plot results as .svg file
	if plotresults
		madsinfo("""Plotting eFAST results as .svg file ... """)
		Mads.plotwellSAresults(md,resultsefast,"w10a")
	end

end
