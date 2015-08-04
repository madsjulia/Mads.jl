using Mads
using DataStructures
using DataFrames
using Gadfly

if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
@docstrings

#TODO use this fuction in all the MADS sampling strategies (for example, SA below)
#TODO add LHC sampling strategy
@doc "Independent sampling of MADS Model parameters" ->
function parametersample(madsdata, numsamples)
	sample = OrderedDict()
	paramdist = getdistributions(madsdata)
	for k in keys(paramdist)
		if haskey(madsdata["Parameters"][k], "type") && typeof(madsdata["Parameters"][k]["type"]) != Nothing
			values = Array(Float64,0)
			if haskey(madsdata["Parameters"][k], "log")
				flag = madsdata["Parameters"][k]["log"]
				if flag == "yes" || flag == "true"
					dist = paramdist[k]
					if typeof(dist) == Uniform
						dist.a = log10(dist.a)
						dist.b = log10(dist.a)
						values = 10.^rand(dist,numsamples)
					elseif typeof(dist) == Normal
						dist.μ = log10(dist.μ)
						values = 10.^rand(dist,numsamples)
					end
				end
			end
			if sizeof(values) == 0
				values = rand(paramdist[k],numsamples)
			end
			sample[k] = values
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
function saltellibrute(madsdata; N=int(1e4))
	numsamples = int(sqrt(N))
	numoneparamsamples = int(sqrt(N))
	nummanyparamsamples = int(sqrt(N))
	# convert the distribution strings into actual distributions
	paramkeys = getparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getdistributions(madsdata)
	results = Array(OrderedDict, numsamples)
	paramdict = Dict()
	for i = 1:numsamples
		for j in 1:length(paramkeys)
			paramdict[paramkeys[j]] = Distributions.rand(distributions[paramkeys[j]])
		end
		results[i] = f(paramdict)
	end
	obskeys = getobskeys(madsdata)
	sum = Dict()
	for i = 1:length(obskeys)
		sum[obskeys[i]] = 0.
	end
	for j = 1:numsamples
		for i = 1:length(obskeys)
			sum[obskeys[i]] += results[j][obskeys[i]]
		end
	end
	mean = OrderedDict()
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
	variance = OrderedDict()
	for i = 1:length(obskeys)
		variance[obskeys[i]] = sum[obskeys[i]] / (numsamples - 1)
	end
	# compute the first order sensitivities
	fos = OrderedDict()
	for k = 1:length(obskeys)
		fos[obskeys[k]] = OrderedDict()
	end
	for i = 1:length(paramkeys)
		cond_means = Array(Dict, numoneparamsamples)
		for j = 1:numoneparamsamples
			cond_means[j] = OrderedDict()
			for k = 1:length(obskeys)
				cond_means[j][obskeys[k]] = 0.
			end
			paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
			for k = 1:nummanyparamsamples
				for m = 1:length(paramkeys)
					if m != i
						paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
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
			for m = 1:numoneparamsamples
				v[m] = cond_means[m][obskeys[k]]
			end
			fos[obskeys[k]][paramkeys[i]] = std(v) ^ 2 / variance[obskeys[k]]
		end
	end
	# compute the total effect
	te = Dict()
	for k = 1:length(obskeys)
		te[obskeys[k]] = Dict()
	end
	for i = 1:length(paramkeys)
		cond_vars = Array(Dict, nummanyparamsamples)
		cond_means = Array(Dict, nummanyparamsamples)
		for j = 1:nummanyparamsamples
			cond_vars[j] = OrderedDict()
			cond_means[j] = OrderedDict()
			for m = 1:length(obskeys)
				cond_means[j][obskeys[m]] = 0.
				cond_vars[j][obskeys[m]] = 0.
			end
			for m = 1:length(paramkeys)
				if m != i
					paramdict[paramkeys[m]] = Distributions.rand(distributions[paramkeys[m]])
				end
			end
			results = Array(OrderedDict, numoneparamsamples)
			for k = 1:numoneparamsamples
				paramdict[paramkeys[i]] = Distributions.rand(distributions[paramkeys[i]])
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
			te[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples / variance[obskeys[j]]
		end
	end
	return fos, te
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
	fos = Dict{String, Dict{String, Float64}}() # first order sensitivities
	te = Dict{String, Dict{String, Float64}}()	# total effect
	for i = 1:length(obskeys)
		meandata[obskeys[i]] = Dict{String, Float64}()
		variance[obskeys[i]] = Dict{String, Float64}()
		fos[obskeys[i]] = Dict{String, Float64}()
		te[obskeys[i]] = Dict{String, Float64}()
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
	yA = hcat(pmap(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, A[i, :]))))), 1:size(A, 1))...)'
	madsoutput( """Computing model outputs to calculate total output mean and variance ... Sample B ...\n""" );
	yB = hcat(pmap(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, B[i, :]))))), 1:size(B, 1))...)'
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
		yC = hcat(pmap(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, C[i, :]))))), 1:size(C, 1))...)'
		for j = 1:length(obskeys)
			f0 = .5 * (mean(yA[:, j]) + mean(yB[:, j]))
			meandata[obskeys[j]][paramkeys[i]] = f0;
			var = .5 * ((dot(yA[:, j], yA[:, j]) - f0 ^ 2) + (dot(yB[:, j], yB[:, j]) - f0 ^ 2))
			variance[obskeys[j]][paramkeys[i]] = var
			fos[obskeys[j]][paramkeys[i]] = (dot(yA[:, j], yC[:, j]) - f0 ^ 2) / var
			te[obskeys[j]][paramkeys[i]] = 1 - (dot(yB[:, j], yC[:, j]) - f0 ^ 2) / var
		end
	end
	return fos, te
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
			fosall, teall = results[1]
			for i = 2:numsaltellis
				fos, te = results[i]
				for obskey in keys(fos)
					for paramkey in keys(fos[obskey])
						#meanall[obskey][paramkey] += mean[obskey][paramkey]
						#varianceall[obskey][paramkey] += variance[obskey][paramkey]
						fosall[obskey][paramkey] += fos[obskey][paramkey]
						teall[obskey][paramkey] += te[obskey][paramkey]
					end
				end
			end
			for obskey in keys(fosall)
				for paramkey in keys(fosall[obskey])
					#meanall[obskey][paramkey] /= numsaltellis
					#varianceall[obskey][paramkey] /= numsaltellis
					fosall[obskey][paramkey] /= numsaltellis
					teall[obskey][paramkey] /= numsaltellis
				end
			end
			return fosall, teall
		end # end fuction
	end # end quote
	eval(q)
end

function saltelliprintresults(madsdata, results)
	fos, te = results
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
	Mads.madsoutput("\nFirst order sensitivity")
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
			Mads.madsoutput("\t$(fos[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	Mads.madsoutput("\nTotal effect")
	Mads.madsoutput("\t")
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(te[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
end

function saltelliprintresults2(madsdata, results)
	fos, te = results
	Mads.madsoutput("First order sensitivity")
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
			Mads.madsoutput("\t$(fos[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
	Mads.madsoutput("\nTotal effect")
	Mads.madsoutput("\t")
	for paramkey in paramkeys
		Mads.madsoutput("\t$(paramkey)")
	end
	Mads.madsoutput("\n")
	for obskey in obskeys
		Mads.madsoutput(obskey)
		for paramkey in paramkeys
			Mads.madsoutput("\t$(te[obskey][paramkey])")
		end
		Mads.madsoutput("\n")
	end
end

function plotwellSAresults(wellname, madsdata, result)
	if !haskey(madsdata, "Wells")
		Mads.madserror("There is no 'Wells' data in the MADS input dataset")
		return
	end
	o = madsdata["Wells"][wellname]["obs"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(o)
	d = Array(Float64, 2, nT)
	fos = Array(Float64, nP, nT)
	te = Array(Float64, nP, nT)
	for i in 1:nT
		t = d[1,i] = o[i][i]["t"]
		d[2,i] = o[i][i]["c"]
		obskey = wellname * "_" * string(t)
		j = 1
		for paramkey in paramkeys
			fos[j,i] = result[1][obskey][paramkey]
			te[j,i] = result[2][obskey][paramkey]
			j += 1
		end
	end
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="concentration")
	pc = plot(dfc, x="x", y="y", Geom.line, Guide.XLabel("Time [years]"), Guide.YLabel("Concentration [ppb]") )
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(te[j,:]), parameter="$paramkey")
		j += 1
	end
	pte = plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(fos[j,:]), parameter="$paramkey")
		j += 1
	end
	pfos = plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("First order senstivity"), Theme(key_position = :none) )
	p = vstack(pc, pte, pfos)
	draw(SVG(string("$wellname-SA-results.svg"), 6inch, 9inch), p)
end

function plotobsSAresults(madsdata, result)
	if !haskey(madsdata, "Observations")
		Mads.madserror("There is no 'Observations' data in the MADS input dataset")
		return
	end
	obsdict = madsdata["Observations"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(obsdict)
	d = Array(Float64, 2, nT)
	fos = Array(Float64, nP, nT)
	te = Array(Float64, nP, nT)
	i = 1
	for obskey in keys(obsdict)
		d[1,i] = obsdict[obskey]["time"]
		d[2,i] = obsdict[obskey]["target"]
		j = 1
		for paramkey in paramkeys
			fos[j,i] = result[1][obskey][paramkey] # first order sensitivity
			te[j,i] = result[2][obskey][paramkey] # total effect
			j += 1
		end
		i += 1
	end
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="Observations")
	pd = plot(dfc, x="x", y="y", Geom.line, Guide.XLabel("x"), Guide.YLabel("y") )
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(te[j,:]), parameter="$paramkey")
		j += 1
	end
	pte = plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(fos[j,:]), parameter="$paramkey")
		j += 1
	end
	pfos = plot(vcat(df...), x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("First order senstivity"), Theme(key_position = :none) )
	p = vstack(pd, pte, pfos)
	rootname = madsrootname(madsdata)
	draw(SVG(string("$rootname-SA-results.svg"), 6inch, 9inch), p)
end
