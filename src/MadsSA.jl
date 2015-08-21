using Mads
using DataStructures
using DataFrames
using Gadfly
using Distributions
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
	paramdist = getparamdistributions(madsdata)
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
	nP = length(paramkeys)
	initparams = getparamsinit(madsdata)
	rootname = getmadsrootname(madsdata)
	J = g_lm(initparams)
	writedlm("$(rootname)-jacobian.dat", J)
	mscale = max(abs(minimum(J)), abs(maximum(J)))
	jacmat = spy(J, Scale.x_discrete(labels = i->paramkeys[i]), Scale.y_discrete, Guide.YLabel("Observations"), Guide.XLabel("Parameters"),
							 Scale.ContinuousColorScale(Scale.lab_gradient(color("green"), color("yellow"), color("red")), minvalue = -mscale, maxvalue = mscale))
	draw(SVG("$(rootname)-jacobian.svg",6inch,12inch),jacmat)
	JpJ = J' * J
	# covar = inv(JpJ) # produces resulut similar to svd
	u, s, v = svd(JpJ)
	covar = ( v * inv(diagm(s)) * u' )
	writedlm("$(rootname)-covariance.dat", covar)
	stddev = sqrt(abs(diag(covar)))
	f = open("$(rootname)-stddev.dat", "w")
	for i in 1:nP
		write(f, "$(paramkeys[i]) $(initparams[i]) $(stddev[i])\n")
	end
	close(f)
	correl = covar ./ diag(covar)
	writedlm("$(rootname)-correlation.dat", correl)
	eigenv, eigenm = eig(covar)
  eigenv = abs(eigenv)
	index=sortperm(eigenv)
	sortedeigenv = eigenv[index]
	sortedeigenm = eigenm[:,index]
	writedlm("$(rootname)-eigenmatrix.dat", sortedeigenm)
	writedlm("$(rootname)-eigenvalues.dat", sortedeigenv)
	eigenmat = spy(sortedeigenm, Scale.y_discrete(labels = i->paramkeys[i]), Scale.x_discrete, Guide.YLabel("Parameters"), Guide.XLabel("Eigenvectors"), Scale.ContinuousColorScale(Scale.lab_gradient(color("green"), color("yellow"), color("red"))))
	# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
	eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.point, Theme(default_point_size=10pt), Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
	eigenplot = vstack(eigenmat, eigenval)
	draw(SVG("$(rootname)-eigen.svg",6inch,12inch),eigenplot)
	["eigenmatrix"=>sortedeigenm, "eigenvalues"=>sortedeigenv, "stddev"=>stddev]
end

@doc "Saltelli (brute force)" ->
function saltellibrute(madsdata; N=int(1e4)) # TODO Saltelli (brute force) does not seem to work; not sure
	numsamples = int(sqrt(N))
	numoneparamsamples = int(sqrt(N))
	nummanyparamsamples = int(sqrt(N))
	# convert the distribution strings into actual distributions
	paramkeys = getoptparamkeys(madsdata)
	# find the mean and variance
	f = makemadscommandfunction(madsdata)
	distributions = getparamdistributions(madsdata)
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
	var = DataStructures.OrderedDict()
	for k = 1:length(obskeys)
		tes[obskeys[k]] = DataStructures.OrderedDict()
		var[obskeys[k]] = DataStructures.OrderedDict()
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
			var[obskeys[j]][paramkeys[i]] = runningsum / nummanyparamsamples
		end
	end
	[ "mes" => mes, "tes" => tes, "var" => var, "samplesize" => N, "method" => "saltellibrute" ]
end

@doc "Saltelli " ->
function saltelli(madsdata; N=int(100))
	paramallkeys = Mads.getparamkeys(madsdata)
	paramalldict = Dict(paramallkeys, getparamsinit(madsdata))
	paramkeys = getoptparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	distributions = getparamdistributions(madsdata)
	f = makemadscommandfunction(madsdata)
	A = Array(Float64, (N, length(paramkeys)))
	B = Array(Float64, (N, length(paramkeys)))
	C = Array(Float64, (N, length(paramkeys)))
	meandata = OrderedDict{String, OrderedDict{String, Float64}}() # mean
	variance = OrderedDict{String, OrderedDict{String, Float64}}() # variance
	mes = OrderedDict{String, OrderedDict{String, Float64}}() # main effect (first order) sensitivities
	tes = OrderedDict{String, OrderedDict{String, Float64}}()	# total effect sensitivities
	for i = 1:length(obskeys)
		meandata[obskeys[i]] = OrderedDict{String, Float64}()
		variance[obskeys[i]] = OrderedDict{String, Float64}()
		mes[obskeys[i]] = OrderedDict{String, Float64}()
		tes[obskeys[i]] = OrderedDict{String, Float64}()
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
			varA = abs(dot(yA[:, j], yA[:, j]) / length(yA[:, j]) - f0A ^ 2)
			varB = abs(dot(yB[:, j], yB[:, j]) / length(yB[:, j]) - f0B ^ 2)
			# varT = .5 * (varA + varB)
			# varMax = max(varA, varB)
			varP = abs((dot(yA[:, j], yC[:, j]) / length(yA[:, j]) - f0A ^ 2)) # we can get negarive values for varP which does not make sense
			varPnot = abs((dot(yB[:, j], yC[:, j]) / length(yB[:, j]) - f0B ^ 2))
			variance[obskeys[j]][paramkeys[i]] = varP
			mes[obskeys[j]][paramkeys[i]] = varP / varA # varT or varA? i think it should be varA
      if varA < eps(Float64) && varP < eps(Float64)
        mes[obskeys[j]][paramkeys[i]] = NaN;
      end
			tes[obskeys[j]][paramkeys[i]] = 1 - varPnot / varB # varT or varA; i think it should be varA; i do not think should be varB?
		end
	end
	[ "mes" => mes, "tes" => tes, "var" => variance, "samplesize" => N, "method" => "saltellimap" ]
end

function computeparametersensitities(madsdata, saresults)
	paramkeys = getoptparamkeys(madsdata)
	obskeys = getobskeys(madsdata)
	mes = saresults["mes"]
	tes = saresults["tes"]
	var = saresults["var"]
	pvar = OrderedDict{String, Float64}() # parameter variance
	pmes = OrderedDict{String, Float64}() # parameter main effect (first order) sensitivities
	ptes = OrderedDict{String, Float64}()	# parameter total effect sensitivities
	for i = 1:length(paramkeys)
		pv = pm = pt = 0
		for j = 1:length(obskeys)
			if typeof(saresults["mes"][obskeys[j]][paramkeys[i]]) == Nothing
				m = 0
			else
				m = saresults["mes"][obskeys[j]][paramkeys[i]]
			end
			if typeof(saresults["tes"][obskeys[j]][paramkeys[i]]) == Nothing
				t = 0
			else
				t = saresults["tes"][obskeys[j]][paramkeys[i]]
			end
			if typeof(saresults["var"][obskeys[j]][paramkeys[i]]) == Nothing
				v = 0
			else
				v = saresults["var"][obskeys[j]][paramkeys[i]]
			end
			pv += isnan(v) ? 0 : v
			pm += isnan(m) ? 0 : m
			pt += isnan(t) ? 0 : t
		end
		pvar[paramkeys[i]] = pv / length(obskeys)
		pmes[paramkeys[i]] = pm / length(obskeys)
		ptes[paramkeys[i]] = pt / length(obskeys)
	end
	[ "var" => pvar, "mes" => pmes, "tes" => ptes]
end

names = ["saltelli", "saltellibrute"]
for mi = 1:length(names)
	q = quote
		function $(symbol(string(names[mi], "parallel")))(madsdata, numsaltellis; N=int(100))
			if numsaltellis < 1
				madserr("Number of parallel sesistivity runs must be > 0 ($numsaltellis < 1)")
				return
			end
			results = pmap(i->$(symbol(names[mi]))(madsdata; N=N), 1:numsaltellis)
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
			[ "mes" => mesall, "tes" => tesall, "var" => varall, "samplesize" => N, "method" => $(names[mi])*"_parallel" ]
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
	var = Array(Float64, nP, nT)
	for i in 1:nT
		t = d[1,i] = o[i][i]["t"]
		d[2,i] = o[i][i]["c"]
		obskey = wellname * "_" * string(t)
		j = 1
		for paramkey in paramkeys
			mes[j,i] = result["mes"][obskey][paramkey]
			tes[j,i] = result["tes"][obskey][paramkey]
			var[j,i] = result["var"][obskey][paramkey]
			j += 1
		end
	end
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="concentration")
  pp = Array(Any, 0)
	pc = Gadfly.plot(dfc, x="x", y="y", Geom.point, Guide.XLabel("Time [years]"), Guide.YLabel("Concentration [ppb]") )
  push!(pp, pc)
  vsize = 4inch
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
	  ptes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
    push!(pp, ptes)
    vsize += 4inch
  end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
	  pmes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Main Effect"), Theme(key_position = :none) )
    push!(pp, pmes)
    vsize += 4inch
  end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(var[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
  	pvar = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("Time [years]"), Guide.YLabel("Output Variance"), Theme(key_position = :none) )
    push!(pp, pvar)
    vsize += 4inch
  end
  p = vstack(pp...)
	rootname = getmadsrootname(madsdata)
	method = result["method"]
	Gadfly.draw(SVG(string("$rootname-$wellname-$method-$nsample.svg"), 6inch, vsize), p)
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
	var = Array(Float64, nP, nT)
	i = 1
	for obskey in keys(obsdict)
		d[1,i] = obsdict[obskey]["time"]
		d[2,i] = obsdict[obskey]["target"]
		j = 1
		for paramkey in paramkeys
			mes[j,i] = result["mes"][obskey][paramkey]
			tes[j,i] = result["tes"][obskey][paramkey]
			var[j,i] = result["var"][obskey][paramkey]
			j += 1
		end
		i += 1
	end
	# mes = mes./maximum(mes,2) # normalize 0 to 1
	tes = tes.-minimum(tes,2)
	# tes = tes./maximum(tes,2)
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="Observations")
  pp = Array(Any, 0)
	pd = Gadfly.plot(dfc, x="x", y="y", Geom.point, Guide.XLabel("x"), Guide.YLabel("y") )
  push!(pp, pd)
  vsize = 4inch
	df = Array(Any, nP)
	j = 1
 	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
	  ptes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Total Effect"), Theme(key_position = :none) ) # only none and default works
    push!(pp, ptes)
    vsize += 4inch
  end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
	  pmes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Main Effect"), Theme(key_position = :none) ) # only none and default works
    push!(pp, pmes)
    vsize += 4inch
  end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(var[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
  vdf = vcat(df...)
  if length(vdf[1]) > 0
	  pvar = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel("x"), Guide.YLabel("Output Variance") ) # only none and default works
	  push!(pp, pvar)
    vsize += 4inch
  end
	rootname = getmadsrootname(madsdata)
  p = vstack(pp...)
	method = result["method"]
	Gadfly.draw(SVG(string("$rootname-$method-$nsample.svg"), 6inch, vsize), p)
end

@doc "Convert Nothing's to NaN's in a dictionary" ->
function nothing2nan!(dict) # TODO generalize using while loop and recursive calls ....
	for i in keys(dict)
		if typeof(dict[i]) <: Dict || typeof(dict[i]) <: OrderedDict
			for j in keys(dict[i])
				if typeof(dict[i][j]) == Nothing
					dict[i][j] = NaN
				end
				if typeof(dict[i][j]) <: Dict || typeof(dict[i][j]) <: OrderedDict
					for k = keys(dict[i][j])
						if typeof(dict[i][j][k]) == Nothing
							dict[i][j][k] = NaN
						end
					end
				end
			end
		end
	end
end

@doc "Delete rows with NaN" ->
function deleteNaN!(df::DataFrame)
	for i in 1:length(df)
		if typeof(df[i][1]) <: Number
			deleterows!(df,find(isnan(df[i][:])))
      if length(df[i]) == 0
        return
      end
		end
	end
end

@doc "Saltelli's eFAST " ->
function efast(md; N=int(100), M=6, gamma=4, plotresults=0)
#
#
#
#    MAKE SURE TO UTILIZE PARALLEL COMPUTING:
#    Either:
#      - Load julia using ./julia -p n
#      - addprocs(n) before running this main script
#     *n is the number of processors
#
#	 Make sure all necessary packages are loaded on every processor (can use @everywhere)
#
#
#
#
#
## eFAST_Main_Parallel.jl
# This is the main script for eFAST (utilizing Parallel Computing)
#
# GSA of Sobol Function
#
# Algoirthm based on Saltelli extended Fourier Amplituded Sensitivty Testing (eFAST) method
#
#
# Important variables used:
#
# a:         Sensitivity of each Sobol parameter (low: very sensitive, high; not sensitive)
# A and B:   Real & Imaginary components of Fourier coefficients, respectively. Used to calculate sensitivty.
# AV:        Sum of total variances (divided by # of resamples to get mean total variance, V)
# AVci:      Sum of complementary variance indices (divided by # of resamples to get mean, Vci)
# AVi:       Sum of main effect variance indices (divided by # of resamples to get mean, Vi)
# ismads:    Boolean that tells us whether our system is analyzed in mads or as a standalone
# InputData: Different size depending on whether we are analyzing a mads system or using eFAST as a standalone.  If analyzing a mads problem,
# 			 InputData will have two columns, where the first column holds the names of parameters we are analyzing and the second holds
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
# P:         P = nprocs(); (Number of processors
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

################################### BEGIN - DEFINING MODULES ###################################

## Defining necessary components of source code for eFAST_MAIN to work
function eFAST_getCompFreq(Wi, nprime, M)

## Special case if n' == 1 -> W_comp is the null set
if nprime == 1
    W_comp = []; Wcmax = 0;
    return W_comp, Wcmax
end




# Max complementary frequency (to avoid interference) with Wi
Wcmax = floor(1/M*(Wi/2));


##
# CASE 1: Very small Wcmax
# (W_comp is all ones)
if Wi <= nprime-1
    W_comp = ones(1,nprime-1);

##
# CASE 2: Wcmax < nprime - 1
# (W_comp has a step size of 1, might need to repeat W_comp frequencies to
# avoid going over Wcmax)
	elseif Wcmax < nprime-1
    step   = 1;
    loops  = ceil((nprime-1)/Wcmax); #loops rounded up
    W_comp = [];                #initializing W_comp
    for i = 1:loops
        W_comp = [W_comp, [1:step:Wcmax]];
    end
    # Reducing W_comp to a vector of size nprime
    W_comp = W_comp[1:(nprime-1)];

## Most typical case:
# CASE 3: wcmax >= nprime -1

	elseif Wcmax >= nprime-1
    step   = round(Wcmax/(nprime-1));
    W_comp = 1 : step : step*(nprime-1);
	end
Wcmax = int(Wcmax);
return W_comp, Wcmax
end



function eFAST_optimalSearch(Ns_total,M,gamma)
	## Main Loop
	# Iterate through different integer values of Nr (# of resamples)
	# If loop finishes, script will adjust Ns upwards to obtain an optimal
	# Nr/Wi pairing
	Nr = 0; Wi = 0;
	for Nr = 1:50
		Wi = (Ns_total/Nr - 1)/(gamma*M);        #Based on Nyquist Freq

		# Based on (Saltelli 1999), Wi/Nr should be between 16-64
		# ceil(Wi) == floor(Wi) checks if Wi is an integer frequency
		if 16 <= Wi/Nr && Wi/Nr <= 64 && ceil(Wi) == floor(Wi)
			Ns = Ns_total/Nr;

			# Checking to see that Ns is odd
			if mod(Ns,2) != 1
				Ns += 1
				Ns_total = Ns*Nr
			end

			return int64(Nr), int64(Wi), int64(Ns), int64(Ns_total)
		end
	end

	##
	# Main loop could not find optimal Wi/Nr pairing based on given Ns & M
	# If script reaches this point, this loop adjusts Ns (upwards) to obtain
	# optimal Nr/Wi pairing.

	# Freezing original Ns value given
	Ns0 = Ns_total;

	for Nr = 1:100
		for Ns_total = Ns0+1 : 1 : Ns0+5000
			Wi = (Ns_total/Nr-1)/(gamma*M);
			if 16 <= Wi/Nr && Wi/Nr <= 64 && ceil(Wi) == floor(Wi)
				Ns = Ns_total/Nr;

				# Checking to see that Ns is odd
				if mod(Ns,2) != 1
					Ns += 1
					Ns_total = Ns*Nr
				end

				println("Ns_total has been adjusted (upwards) to obtain optimal Nr/Wi pairing!");
				println("Ns_total = $(Ns*Nr) ... Nr = $Nr ... Wi = $Wi ... Ns = $Ns")
				return int64(Nr), int64(Wi), int64(Ns), int64(Ns_total)
			end
		end
	end

	##
	# If script reaches this section of code, adjustments must be made to Ns,
	# boundaries
	println("ERROR! Change bounds of eFAST_optimalSearch.m or choose different Ns/M");

end



function eFAST_distributeX(X, nprime, InputData, ismads)
## If we are using this as a standalone (reading input from csv):
if ismads == 0
    # Store X (which only contains transformations for parameters of interst)
    # in temporary array so we can create larger X including parameters we hold constant.
    tempX = X;
    X = zeros(Ns,n);
    for k = 1:n
        # If the value we assigned to parameter k is a distribution, apply said distribution to its search curve
        # Otherwise, set it as a constant (for parameters we are not analyzing)
        if issubtype(typeof(InputData[k,2]), Distribution)
          X[:,k] = quantile(InputData[k,2],tempX[:,k]);
        else
          X[:,k] = InputData[k,2];
        end #End if
    end # End k=1:n
end # End if ismads==0



## If we are using this as part of mads (reading input from mads):
if ismads == 1
# Attributing data matrix to vectors
# dist provides all necessary information on distribution (type, min, max, mean, std)
(name, dist) = (InputData[:,1], InputData[:,2])

    for k = 1:nprime
      # If parameter is one we are analyzing then we will assign numbers according to its probability dist
      # Otherwise, we will simply set it at a constant (i.e. its initial value)
      # This returns true if the parameter k is a distribution (i.e. it IS a parameter we are interested in)
      if issubtype(typeof(InputData[k,2]), Distribution)
        # dist contains all data about distribution so this will apply any necessary distributions to X
        X[:,k] = quantile(dist[k],X[:,k]);
      else
        println("ERROR in assinging Input Data! (Check InputData matrix and/or eFAST_distributeX.jl")
        return
      end # End if
    end # End k=1:nprime (looping over parameters of interest)

end # End if ismads==1 statement

return X
end # End function


function eFAST_Parallel_kL(kL)

	# Redistributing constCell
	(P, nprime, ny, Nr, Ns, M, Wi, W_comp,S_vec, InputData, ismads, paramalldict,paramkeys, f) = constCell;


	# Determining which parameter we are on
	k = int(ceil(kL/Nr));

	# Initializing
  	W_vec   = zeros(1,nprime); 	   # W_vec (Frequencies)
	phi_mat = zeros(nprime,Ns);    # Phi matrix (phase shift corresponding to each resample)

	
	## Creating W_vec (kth element is Wi)
	W_vec[k] = Wi;
	## Edge cases
	# As long as nprime!=1 our W_vec will have complementary frequencies
	if nprime !=1		
		if k != 1
			W_vec[1:(k-1)] = W_comp[1:(k-1)];
		end
		if k != nprime
			W_vec[(k+1):nprime] = W_comp[k:(nprime-1)];
		end
	end


	# Slight inefficiency as it creates a phi_mat every time (rather than Nr times)
	# Random Phase Shift
	phi = rand(1,nprime)*2*pi;
	for j = 1:Ns
		phi_mat[:,j] = phi';
	end


	## Preallocate/Initialize
	A     = 0;
	B     = 0;                          # Fourier coefficients
	Wi 	  = maximum(W_vec)				# Maximum frequency (i.e. the frequency for our parameter of interest)
	Wcmax = maximum(W_comp)				# Maximum frequency in complementary set


	# Adding on the random phase shift
	alpha = W_vec'*S_vec' + phi_mat;           # W*S + phi
	X = .5 + asin(sin(alpha'))/pi;   #Transformation function Saltelli suggests

	# In this function we assign probability distributions to parameters we are analyzing
	# and set parameters that we aren't analyzing to constants.
	# It is not important to us in calculating sensitivity so we only save it
	# for long enough to calculate Y.
	# QUESTION do we need LHC sampling?
	X = eFAST_distributeX(X, nprime, InputData, ismads); 

	# Pre-allocating Model Output
	Y = zeros(Ns, ny);

	## CALCULATING MODEL OUTPUT (Mads)
	# If we are analyzing a mads problem, we calculate our model output as such:
	if ismads == 1
		if P <= Nr*nprime+(Nr+1)
			# If # of processors is <= Nr*nprime+(Nr+1) compute model ouput serially
			#madsinfo("""Compute model ouput in serial ... $(P) <= $(Nr*nprime+(Nr+1)) ... """)
			@showprogress 1 "Computing models in serial - Parameter k = $k ($(paramkeys[k])) ... " for i = 1:Ns
				Y[i,:] = collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, X[i, :])))))
			end
		else
			# If # of processors is > Nr*nprime+(Nr+1) compute model output in parallel
      #madsinfo("""Compute model ouput in parallel ... $(P) > $(Nr*nprime+(Nr+1)) ... """)
			Y = hcat(pmap(i->collect(values(f(merge(paramalldict,Dict{String, Float64}(paramkeys, X[i, :]))))), 1:size(X, 1))...)'
		end #End if (processors)
	end #End if ismads == 1

	## CALCULATING MODEL OUTPUT (Standalone)
	# If we using this program as a standalone, we enter our model function here:
	if ismads == 0
		# If # of processors is <= Nr*nprime+(Nr+1) compute model ouput serially
		if P <= Nr*nprime+(Nr+1)
			for i = 1:Ns
				# Replace this with whatever model we are analyzing
				Y[i,:] = defineModel_Sobol(X[i,:])
			end

			# If # of processors is > Nr*nprime+(Nr+1) compute model output in parallel
		else
			Y = zeros(1,ny);
			Y = @parallel (vcat) for j = 1:Ns
				defineModel_Sobol(X[j,:]);
			end #End Parallel for loop
		end #End if (processors)
	end #End if ismads ==0



	## CALCULATING FOURIER COEFFICIENTS
	## If length(Y[1,:]) == 1, system is *not dynamic* and we don't need to add an extra dimension
	if ny == 1
		# These will be the sums of variances over all resamplings (Nr loops)
		AVi = 0; AVci = 0; AV = 0;                     # Initializing Variances to 0

		## Calculating Si and Sti (main and total sensitivity indices)
		# Subtract the average value from Y
		Y[:] = (Y[:] - mean(Y[:]))';

		## Calculating Fourier coefficients associated with MAIN INDICES
		# p corresponds to the harmonics of Wi
		for p = 1 : 1 : M
			A = dot(Y[:],cos(Wi*p*S_vec));
			B = dot(Y[:],sin(Wi*p*S_vec));
			AVi  = AVi + A^2 + B^2;
		end
		# 1/Ns taken out of both A and B for optimization!
		AVi = AVi/(Ns^2);

		## Calculating Fourier coefficients associated with COMPLEMENTARY FREQUENCIES
		for j = 1 : 1 : Wcmax*M
			A = dot(Y[:],cos(j*S_vec));
			B = dot(Y[:],sin(j*S_vec));
			AVci = AVci + A^2 + B^2;
		end
		AVci = AVci/(Ns^2);

		## Total Variance
		# By definition of variance: V(Y) = (Y - mean(Y))^2
		AV = dot(Y[:],Y[:])/Ns;

		# Storing results in a vector format
		resultvec = [AV AVi AVci];
	elseif ny > 1
		## If system is dynamic, we must add an extra dimension to calculate sensitivity indices for each point
		# These will be the sums of variances over all resamplings (Nr loops)
		AV   = zeros(ny,1);                   # Initializing Variances to 0
		AVi  = zeros(ny,1);
		AVci = zeros(ny,1);

		## Calculating Si and Sti (main and total sensitivity indices)
		# Looping over each point in time
		@showprogress 2 "Calculating Fourier coefficients for observations ... "  for i = 1:ny
			# Subtract the average value from Y
			Y[:,i] = (Y[:,i] - mean(Y[:,i]))';

			## Calculating Fourier coefficients associated with MAIN INDICES
			# p corresponds to the harmonics of Wi
			for p = 1 : 1 : M
				A = dot(Y[:,i],cos(Wi*p*S_vec));
				B = dot(Y[:,i],sin(Wi*p*S_vec));
				AVi[i]  = AVi[i] + A^2 + B^2;
			end
			# 1/Ns taken out of both A and B for optimization!
			AVi[i] = AVi[i]/(Ns^2);

			## Calculating Fourier coefficients associated with COMPLEMENTARY FREQUENCIES
			for j = 1 : 1 : Wcmax*M
				A = dot(Y[:,i],cos(j*S_vec));
				B = dot(Y[:,i],sin(j*S_vec));
				AVci[i] = AVci[i] + A^2 + B^2;
			end
			AVci[i] = AVci[i]/(Ns^2);

			## Total Variance
			# By definition of variance: V(Y) = (Y - mean(Y))^2
			AV[i] = dot(Y[:,i],Y[:,i])/Ns;
		end #END for i = 1:ny

		# Storing results in matrix format
		resultvec = hcat(AV, AVi, AVci);
	end #END if length(Y[1,:]) > 1

	# resultvec will be an array of size (ny,3)
	return resultvec


end

################################### END - DEFINING MODULES ###################################

# Are we reading from a .mads file or are we running this as a standalone (input: .csv, output: .exe)?
# 1 for MADS, 0 for standalone. Basically determines IO of script.
ismads = true;
# Plot results as .svg file
plotresults = 0;

# Number of processors (for parallel computing)
# Different values of P will determine how program is parallelized
# If P > 1 -> Program will parallelize resamplings & parameters
# If P > Nr*nprime + 1 -> (Nr*nprime + 1) is the amount of processors necessary to fully parallelize all resamplings over
# every parameter (including +1 for the master).  If P is larger than this extra cores will be allocated to computing 
# the model output quicker.
P = nprocs();

## Packages (commented out because we cannot use packages in functions. However, might be an issue with
#  @everywhere macro??)
#@everywhere using DataStructures
# Provides distributions for parameters
#@everywhere using Distributions
#require("DataStructures")
########## Although it would be nice to have this inside the if statement of ismads == 1, for some reason julia won't compile
# Need to add this in if version is < 0.4 so we can use @doc macro
#if VERSION < v"0.4.0-dev"
#@everywhere using Docile # default for v > 0.4
#end

#import Mads
#using Mads
#@everywhere using ProgressMeter


## Necessary modules (no matter if we are reading from mads or using as a standalone)
#@everywhere include("/Users/jlaughli/Desktop/Julia Code/eFAST_distributeX.jl");
#include("/Users/jlaughli/Desktop/Julia Code/eFAST_getCompFreq.jl");
#include("/Users/jlaughli/Desktop/Julia Code/eFAST_optimalSearch.jl");
#@everywhere include("/Users/jlaughli/Desktop/Julia Code/eFAST_Parallel_kL.jl")


## I/O if we are reading from mads
# Keys for all parameters
paramallkeys  = Mads.getparamkeys(md)
# Values of this dictionary are intial values
paramalldict  = DataStructures.OrderedDict(zip(paramallkeys, map(key->md["Parameters"][key]["init"], paramallkeys)))
# Only the parameters we wish to analyze
paramkeys     = Mads.getoptparamkeys(md)
# All the observation sites and time points we will analyze them at
obskeys       = Mads.getobskeys(md)
# Get distributions for the parameters we will be performing SA on
distributions = Mads.getparamdistributions(md)

# Function for model output
f = Mads.makemadscommandfunction(md)

# This is here to delete parameters of interest from paramalldict
# The parameters of interest will be calculated by eFAST_distributeX
# We utilize the "merge" function to combine the two when we are calculating model output
for key in paramkeys
	delete!(paramalldict,key)
end

# Pre-allocating InputData Matrix
InputData = Array(Any,length(paramkeys),2);

### InputData will hold PROBABILITY DISTRIBUTIONS for the parameters we are analyzing (Other parameters stored in paramalldict)
for i = 1:length(paramkeys)
	InputData[i,1] = paramkeys[i];
	InputData[i,2] = distributions[paramkeys[i]]
end

# Total number of parameters
n      = length(paramallkeys);
# Number of parameters we are analyzing
nprime = length(paramkeys);
# ny > 1 means system is dynamic (model output is a vector)
ny     = length(obskeys);




# Changing directory back to that of main script
#Base.source_path();
#cd(dirname(Base.source_path()));

## Set Input Parameters
# Define range of sobol inputs ([0 1] in this case).
# n = Total # of input parameters, range = range of inputs
# a = Sensitivity of each input (a=0: very sensitive, a=99: hardly sensitive)
# (n, range, a) = defineInput_Sobol([0 1]);

##
## Set GSA Parameters
##
M        = 6;          # Max # of Harmonics (usually set to 4 or 6)
# Lower values of M tend to underestimate main sensitivity indices.
Ns_total = N;       # Total Number of samples over all search curves (minimum for eFAST method is 65)
# Choosing a small Ns will increase speed but decrease accuracy
# Ns_total = 65 will only work if M=4 and gamma = 2 (Wi >= 8 is the actual constraint)
gamma    = 4;          # To adjust equation Wi = (Ns_total/Nr - 1)/(gamma*M)
# Saltelli 1999 suggests gamma = 2 or 4; higher gammas typically give more accurate results
# and are even *sometmies* faster.
##
##
##

## Here we define additional parameters (importantly, the frequency for our "Group of Interest", Wi)
# This function chooses an optimal Nr/Wi pair (based on Saltelli 1999)
# Adjusts Ns (upwards) if necessary
(Nr, Wi, Ns, Ns_total) = eFAST_optimalSearch(Ns_total,M,gamma);


forced = 0;
if forced == 1
## Forced inputs here:
# Note: Ns must be odd, eFAST_optimalSearch.jl will adjust for this if necessary but if you use a forced input
# make sure to keep this in mind.
# Ns =
Wi = int(100);
Nr = int(ceil(Ns_total/(gamma*M*Wi+1)));

Ns       = int((gamma*M*Wi+1));
if mod(Ns,2) != 1
	Ns += 1
end
Ns_total = int(Ns*Nr);
println("eFAST parameters after forced inputs: \n Ns_total = $(Nr*Ns) Nr = $Nr ... Wi = $Wi ... Ns = $Ns")
end


## For debugging and/or graphs
# step  = (M*Wi - 1)/Ns;
# omega = 1 : step : M*Wi - step;  # Frequency domain, can be used to plot power spectrum

## Error Check (Wi=8 is the minimum frequency required for eFAST. Ns_total must be at least 65 to satisfy this criterion)
if Wi<8
println("ERROR! Choose larger Ns_total value! (Ns_total = 65 is minimum for eFAST)")
return
end

##
##
## Begin eFAST analysis:
##
##

## Start timer
tic();


madsinfo("""Begin eFAST analysis ... """)

# This script determines complementary frequencies
(W_comp, Wcmax) = eFAST_getCompFreq(Wi, nprime, M);

# New domain [-pi pi] spaced by Ns points
S_vec = linspace(-pi, pi, Ns);

## Preallocation
resultmat = zeros(nprime,3,Nr);  # Matrix holding all results (decomposed variance)
Var       = zeros(ny,nprime)     # Output variance
Si        = zeros(ny,nprime)     # Main sensitivity indices
Sti       = zeros(ny,nprime)     # Total sensitivity indices
W_vec     = zeros(1,nprime);     # W_vec (Frequencies)

########## DIFFERENT CASES DEPENDING ON # OF PROCESSORS
#if P <= nprime*Nr + 1
# Parallelized over n AND Nr

#if P > nprime*Nr + 1
# nprocs() is quite high, we choose to parallelize over n, Nr, AND also model output


if P>1
	madsinfo("""Parallelizing resamplings AND parameters""")
end

# Storing constants inside of a cell
constCell = {P, nprime, ny, Nr, Ns, M, Wi, W_comp,S_vec, InputData, ismads, paramalldict,paramkeys, f};

## Sends arguments to processors p
function sendto(p; args...)
	for i in p
	    for (nm, val) in args
	        @spawnat(i, eval(Main, Expr(:(=), nm, val)))
	    end
	end
end

## Sends all variables stored in constCell to workers dedicated to parallelization across parameters and resamplings
if P > Nr*nprime + 1
	# We still may need to send f to workers only calculating model output??
	sendto(collect(2:nprime*Nr), constCell = constCell);
# If there are less workers than resamplings*parameters, we send to all workers available
else
	sendto(workers(), constCell = constCell);
end


### Calculating decomposed variances in parallel ###
allresults = pmap((kL)->eFAST_Parallel_kL(kL), 1:nprime*Nr);



## Summing & normalizing decomposed variances to obtain sensitivity indices
for k = 1:nprime
	# Sum of variances across all resamples
	resultvec = sum(allresults[(1:Nr) + Nr*(k-1)]);

	## Calculating Sensitivity indices (main and total)
	V         = resultvec[:,1]/Nr
	Vi        = 2*resultvec[:,2]/Nr
	Vci       = 2*resultvec[:,3]/Nr
	# Total output variance
	Var[:,k]  = Vi
	# Normalizing vs mean over loops
	Si[:,k]   = Vi./V
	Sti[:,k]  = 1 - Vci./V
end


# end

##
##
## End eFAST analysis:
##
##


madsinfo("""End eFAST analysis ... """)


## End timer & display elapsed time
toc(); println("(Not including setup time for modules)")

# Save results as dictionary
if ismads == 1
		tes = DataStructures.OrderedDict()
		mes = DataStructures.OrderedDict()
		var = DataStructures.OrderedDict()
		for j = 1:length(obskeys)
			tes[obskeys[j]] = DataStructures.OrderedDict()
			mes[obskeys[j]] = DataStructures.OrderedDict()
			var[obskeys[j]] = DataStructures.OrderedDict()
		end
		for k = 1:length(paramkeys)
			for j = 1:length(obskeys)
				var[obskeys[j]][paramkeys[k]] = Var[j,k]
				tes[obskeys[j]][paramkeys[k]] = Sti[j,k]
				mes[obskeys[j]][paramkeys[k]] = Si[j,k]
			end
		end

		return resultsefast = ["mes" => mes, "tes" => tes, "var" => var, "samplesize" => Ns_total, "method" => "efast" ]
	
		# Plot results as .svg file	
		if plotresults == 1
			madsinfo("""Plotting eFAST results as .svg file ... """)
			Mads.plotwellSAresults("w1a",md,resultsefast)
		end
end #END if plotresults


## Displaying Results
# println("Si: $Si")
# println("Sti: $Sti")
end



