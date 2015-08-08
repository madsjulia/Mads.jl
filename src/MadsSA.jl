using Mads
using DataStructures
using DataFrames
using Gadfly
using ProgressMeter

if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
@docstrings

#TODO use this fuction in all the MADS sampling strategies (for example, SA below)
#TODO add LHC sampling strategy
@doc "Independent sampling of MADS Model parameters" ->
function parametersample(madsdata, numsamples, parameterkey="")
	sample = DataStructures.OrderedDict()
	paramdist = getdistributions(madsdata)
	for k in keys(paramdist)
		if parameterkey == "" || parameterkey == k
			if haskey(madsdata["Parameters"][k], "type") && typeof(madsdata["Parameters"][k]["type"]) != Nothing
				values = Array(Float64,0)
				if haskey(madsdata["Parameters"][k], "log")
					flag = madsdata["Parameters"][k]["log"]
					if flag == "yes" || flag == "true"
						dist = paramdist[k]
						if typeof(dist) == Uniform
							a = log10(dist.a)
							b = log10(dist.a)
							values = 10^(a + (b - a) * Distributions.rand(numsamples))
						elseif typeof(dist) == Normal
							μ = log10(dist.μ)
							values = 10.^(μ + dist.σ * Distributions.randn(numsamples))
						end
					end
				end
				if sizeof(values) == 0
					values = Distributions.rand(paramdist[k],numsamples)
				end
				sample[k] = values
			end
		end
	end
	return sample
end

@doc "Local sensitivity analysis" ->
function localsa(madsdata)
	f_lm, g_lm = makelmfunctions(madsdata)
	paramkeys = getparamkeys(madsdata)
	initparams = getparamsinit(madsdata)
	rootname = madsrootname(madsdata)
	J = g_lm(initparams)
	writedlm("$(rootname).jacobian",J)
	jacmat = spy(J, Scale.x_discrete(labels = i->paramkeys[i]), Scale.y_discrete, Guide.YLabel("Observations"), Guide.XLabel("Parameters"), Scale.ContinuousColorScale(Scale.lab_gradient(color("green"), color("yellow"), color("red"))))
	draw(SVG("$(rootname)-jacobian.svg",6inch,12inch),jacmat)
	JpJ = J' * J
	covar = inv(JpJ)
	writedlm("$(rootname).covariance",covar)
	stddev = sqrt(diag(covar))
	correl = covar ./ (stddev * stddev')
	writedlm("$(rootname).correlation",correl)
	eigenv, eigenm = eig(covar)
	writedlm("$(rootname).eigenmatrix",eigenm)
	writedlm("$(rootname).eigenvalues",eigenv)
	eigenmat = spy(eigenm, Scale.y_discrete(labels = i->paramkeys[i]), Scale.x_discrete, Guide.YLabel("Parameters"), Guide.XLabel("Eigenvectors"), Scale.ContinuousColorScale(Scale.lab_gradient(color("green"), color("yellow"), color("red"))))
	# eigenval = plot(x=1:length(eigenv), y=eigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
	eigenval = plot(x=1:length(eigenv), y=eigenv, Scale.x_discrete, Scale.y_log10, Geom.point, Theme(default_point_size=10pt), Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
	eigenplot = vstack(eigenmat, eigenval)
	draw(SVG("$(rootname)-eigen.svg",6inch,12inch),eigenplot)
end

@doc "Saltelli (brute force)" ->
function saltellibrute(madsdata; N=int(1e4)) # TODO senstivity indeces become >1 as the sample size increases
	numsamples = int(sqrt(N))
	numoneparamsamples = int(sqrt(N))
	nummanyparamsamples = int(sqrt(N))
	# convert the distribution strings into actual distributions
	paramkeys = getoptparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getdistributions(madsdata)
	results = Array(DataStructures.OrderedDict, numsamples)
	paramdict = Dict( getparamkeys(madsdata), getparamsinit(madsdata) )
	for i = 1:numsamples
		for j in 1:length(paramkeys)
			paramdict[paramkeys[j]] = Distributions.rand(distributions[paramkeys[j]]) # TODO use parametersample
		end
		results[i] = f(paramdict) # this got to be slow to process
	end
	obskeys = getobskeys(madsdata)
	sum = DataStructures.OrderedDict()
	for i = 1:length(obskeys)
		sum[obskeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += results[j][obskeys[i]]
		end
	end
	mean = DataStructures.OrderedDict()
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
	variance = DataStructures.OrderedDict()
	for i = 1:length(obskeys)
		variance[obskeys[i]] = sum[obskeys[i]] / (numsamples - 1)
	end
	madsinfo("Compute the main effect (first order) sensitivities (indices)")
	mes = DataStructures.OrderedDict()
	for k = 1:length(obskeys)
		mes[obskeys[k]] = DataStructures.OrderedDict()
	end
	for i = 1:length(paramkeys)
		madsinfo("""Parameter : $(paramkeys[i])""")
		cond_means = Array(OrderedDict, numoneparamsamples)
		@showprogress 1 "Computing ... "  for j = 1:numoneparamsamples
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
		v = Array(Float64, numoneparamsamples)
		for k = 1:length(obskeys)
			for j = 1:numoneparamsamples
				v[j] = cond_means[j][obskeys[k]]
			end
			mes[obskeys[k]][paramkeys[i]] = std(v) ^ 2 / variance[obskeys[k]]
		end
	end
	madsinfo("Compute the total effect sensitivities (indices)") # TODO we should use the same samples for total and main effect
	tes = DataStructures.OrderedDict()
	for k = 1:length(obskeys)
		tes[obskeys[k]] = DataStructures.OrderedDict()
	end
	for i = 1:length(paramkeys)
		madsinfo("""Parameter : $(paramkeys[i])""")
		cond_vars = Array(OrderedDict, nummanyparamsamples)
		cond_means = Array(OrderedDict, nummanyparamsamples)
		@showprogress 1 "Computing ... " for j = 1:nummanyparamsamples
			cond_vars[j] = DataStructures.OrderedDict()
			cond_means[j] = DataStructures.OrderedDict()
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] = 0.
				cond_vars[j][obskeys[m]] = 0.
			end
			for m = 1:length(paramkeys)
				if m != i
					paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]]) # TODO use parametersample
				end
			end
			results = Array(DataStructures.OrderedDict, numoneparamsamples)
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
		end
	end
	[ "mes" => mes, "tes" => tes, "samplesize" => N, "method" => "saltellibrute" ]
end

@doc "Saltelli " ->
function saltelli(madsdata; N=int(100))
	paramallkeys = Mads.getparamkeys(madsdata)
	paramalldict = Dict(paramallkeys, map(key->madsdata["Parameters"][key]["init"], paramallkeys))
	paramkeys = getoptparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	distributions = getdistributions(madsdata)
	f = makemadscommandfunction(madsdata)
	A = Array(Float64, (N, length(paramkeys)))
	B = Array(Float64, (N, length(paramkeys)))
	C = Array(Float64, (N, length(paramkeys)))
	meandata = Dict{String, Dict{String, Float64}}() # mean
	variance = Dict{String, Dict{String, Float64}}() # variance
	mes = Dict{String, Dict{String, Float64}}() # main effect (first order) sensitivities
	tes = Dict{String, Dict{String, Float64}}()	# total effect sensitivities
	for i = 1:length(obskeys)
		meandata[obskeys[i]] = Dict{String, Float64}()
		variance[obskeys[i]] = Dict{String, Float64}()
		mes[obskeys[i]] = Dict{String, Float64}()
		tes[obskeys[i]] = Dict{String, Float64}()
	end
	for key in paramkeys
		delete!(paramalldict,key)
	end
	for i = 1:N
		for j = 1:length(paramkeys)
			A[i, j] = Distributions.rand(distributions[paramkeys[j]])
			B[i, j] = Distributions.rand(distributions[paramkeys[j]])
		end
	end
	madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample A ...\n""" );
	yA = hcat(map(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, A[i, :]))))), 1:size(A, 1))...)'
	madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample B ...\n""" );
	yB = hcat(map(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, B[i, :]))))), 1:size(B, 1))...)'
	for i = 1:length(paramkeys)
		for j = 1:N
			for k = 1:length(paramkeys)
				if k != i
					C[j, k] = B[j, k]
				else
					C[j, k] = A[j, k]
				end
			end
		end
		madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample C ... Parameter $(paramkeys[i])\n""" );
		yC = hcat(map(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, C[i, :]))))), 1:size(C, 1))...)'
		for j = 1:length(obskeys)
			f0A = mean(yA[:, j])
			f0B = mean(yB[:, j])
			meandata[obskeys[j]][paramkeys[i]] = .5 * (f0A + f0B)
			varA = dot(yA[:, j], yA[:, j]) / length(yA[:, j]) - f0A ^ 2
			varB = dot(yB[:, j], yB[:, j]) / length(yB[:, j]) - f0B ^ 2
			variance[obskeys[j]][paramkeys[i]] = .5 * (varA + varB)
			mes[obskeys[j]][paramkeys[i]] = (dot(yA[:, j], yC[:, j]) / length(yA[:, j]) - f0A ^ 2) / varA
			tes[obskeys[j]][paramkeys[i]] = 1 - (dot(yB[:, j], yC[:, j]) / length(yB[:, j]) - f0B ^ 2) / varB
		end
	end
	[ "mes" => mes, "tes" => tes, "samplesize" => N, "method" => "saltellimap" ]
end

names = ["saltelli", "saltellibrute"]
for mi = 1:length(names)
	q = quote
		function $(symbol(string(names[mi], "parallel")))(madsdata, numsaltellis; N=int(100))
			if numsaltellis < 1
				madserr("""Number of parallel sesistivity runs must be > 0 ($numsaltellis < 1)""")
				return
			end
			results = pmap(i->$(symbol(names[mi]))(madsdata; N=N), 1:numsaltellis)
			mesall = results["mes"]
			tesall = results["tes"]
			for i = 2:numsaltellis
				mes, tes = results[i]
				for obskey in keys(mes)
					for paramkey in keys(mes[obskey])
						#meanall[obskey][paramkey] += mean[obskey][paramkey]
						#varianceall[obskey][paramkey] += variance[obskey][paramkey]
						mesall[obskey][paramkey] += mes[obskey][paramkey]
						tesall[obskey][paramkey] += tes[obskey][paramkey]
					end
				end
			end
			for obskey in keys(mesall)
				for paramkey in keys(mesall[obskey])
					#meanall[obskey][paramkey] /= numsaltellis
					#varianceall[obskey][paramkey] /= numsaltellis
					mesall[obskey][paramkey] /= numsaltellis
					tesall[obskey][paramkey] /= numsaltellis
				end
			end
			[ "mes" => mesall, "tes" => tesall, "samplesize" => N, "method" => names[mi]*"_parallel" ]
		end # end fuction
	end # end quote
	eval(q)
end

function saltelliprintresults(madsdata, results)
	mes = results["mes"]
	tes = results["tes"]
	N = results["samplesize"]
	#=
	Mads.madsoutput("Mean\n")
	Mads.madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(mean[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	Mads.madsoutput("\nVariance\n")
	Mads.madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getparamkeys(madsdata)
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(variance[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	=#
	Mads.madsoutput("\nMain Effect Indices")
	Mads.madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(mes[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	Mads.madsoutput("\nTotal Effect Indices")
	Mads.madsoutput("\t")
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(tes[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
end

function saltelliprintresults2(madsdata, results)
	mes = results["mes"]
	tes = results["tes"]
	N = results["samplesize"]
	Mads.madsoutput("Main Effect Indices")
	Mads.madsoutput("\t")
	obskeys = getobskeys(madsdata)
	paramkeys = getoptparamkeys(madsdata)
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(mes[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	Mads.madsoutput("\nTotal Effect Indices")
	Mads.madsoutput("\t")
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(tes[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
end

function plotwellSAresults(wellname, madsdata, result)
	if !haskey(madsdata, "Wells")
		Mads.madserror("There is no 'Wells' data in the MADS input dataset")
		return
	end
  nsample = result["samplesize"]
	o = madsdata["Wells"][wellname]["obs"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(o)
	d = Array(Float64, 2, nT)
	mes = Array(Float64, nP, nT)
	tes = Array(Float64, nP, nT)
	for i in 1:nT
		t = d[1,i] = o[i][i]["t"]
		d[2,i] = o[i][i]["c"]
		obskey = wellname * "_" * string(t)
		j = 1
		for paramkey in paramkeys
			f = result["mes"][obskey][paramkey]
			mes[j,i] = isnan(f) ? 0 : f
			t = result["tes"][obskey][paramkey]
			tes[j,i] = isnan(t) ? 0 : t
			j += 1
		end
	end
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="concentration")
	pc = Gadfly.plot(dfc, x="x", y="y", Geom.line, Guide.XLabel("Time [years]"), Guide.YLabel("Concentration [ppb]") )
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		j += 1
	end
	ptes = Gadfly.plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$paramkey")
		j += 1
	end
	pmes = Gadfly.plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Main Effect"), Theme(key_position = :none) )
	p = vstack(pc, ptes, pmes)
	rootname = madsrootname(madsdata)
	method = result["method"]
	Gadfly.draw(SVG(string("$rootname-$wellname-$method-$nsample.svg"), 6inch, 9inch), p)
end

function plotobsSAresults(madsdata, result)
	if !haskey(madsdata, "Observations")
		Mads.madserror("There is no 'Observations' data in the MADS input dataset")
		return
	end
  nsample = result["samplesize"]
	obsdict = madsdata["Observations"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(obsdict)
	d = Array(Float64, 2, nT)
	mes = Array(Float64, nP, nT)
	tes = Array(Float64, nP, nT)
	i = 1
	for obskey in keys(obsdict)
		d[1,i] = obsdict[obskey]["time"]
		d[2,i] = obsdict[obskey]["target"]
		j = 1
		for paramkey in paramkeys
			f = result["mes"][obskey][paramkey]
			mes[j,i] = isnan(f) ? 0 : f
			t = result["tes"][obskey][paramkey]
			tes[j,i] = isnan(t) ? 0 : t
			j += 1
		end
		i += 1
	end
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="Observations")
	pd = Gadfly.plot(dfc, x="x", y="y", Geom.line, Guide.XLabel("x"), Guide.YLabel("y") )
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		j += 1
	end
	ptes = Gadfly.plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$paramkey")
		j += 1
	end
	pmes = Gadfly.plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Main Effect"), Theme(key_position = :none) )
	p = vstack(pd, ptes, pmes)
	rootname = madsrootname(madsdata)
	method = result["method"]
	Gadfly.draw(SVG(string("$rootname-$method-$nsample.svg"), 6inch, 9inch), p)
end
