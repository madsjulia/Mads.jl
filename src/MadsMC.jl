import BlackBoxOptim
import Lora
if VERSION < v"0.4.0-dev"
	using Docile # default for v > 0.4
end
# @document
#@docstrings

@doc "Bayes Sampling " ->
function bayessampling(madsdata; nsteps=round(Int, 1e2), burnin=round(Int, 1e3), thinning=1)
	#TODO make it sample only over the opt params
	madsloglikelihood = makemadsloglikelihood(madsdata)
	arrayloglikelihood = makearrayloglikelihood(madsdata, madsloglikelihood)
	optparamkeys = getoptparamkeys(madsdata)
	initvals = Array(Float64, length(optparamkeys))
	for i = 1:length(optparamkeys)
		initvals[i] = madsdata["Parameters"][optparamkeys[i]]["init"]
	end
	mcmcmodel = Lora.model(arrayloglikelihood, init=initvals)
	sampler = Lora.RAM(1e-1, 0.3)
	smc = Lora.SerialMC(nsteps=nsteps + burnin, burnin=burnin, thinning=thinning)
	mcmcchain = Lora.run(mcmcmodel, sampler, smc)
	return mcmcchain
end

@doc "Brute force parallel Bayesian sampling " ->
function bayessampling(madsdata, numsequences; nsteps=round(Int, 1e2), burnin=round(Int, 1e3))
	mcmcchains = pmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin), 1:numsequences)
	return mcmcchains
end

@doc "Do a forward Monte Carlo analysis " ->
function montecarlo(madsdata; N=round(Int, 1e2))
	paramkeys = getparamkeys(madsdata)
	optparamkeys = getoptparamkeys(madsdata)
	logoptparamkeys = getlogparamkeys(madsdata, optparamkeys)
	nonlogoptparamkeys = getnonlogparamkeys(madsdata, optparamkeys)
	paramtypes = getparamstype(madsdata)
	paramlogs = getparamslog(madsdata)
	logoptparamsmin = log10(getparamsmin(madsdata, logoptparamkeys))
	logoptparamsmax = log10(getparamsmax(madsdata, logoptparamkeys))
	nonlogoptparamsmin = getparamsmin(madsdata, nonlogoptparamkeys)
	nonlogoptparamsmax = getparamsmax(madsdata, nonlogoptparamkeys)
	logoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(logoptparamsmin, logoptparamsmax, N)
	nonlogoptparams = BlackBoxOptim.Utils.latin_hypercube_sampling(nonlogoptparamsmin, nonlogoptparamsmax, N)
	paramdicts = Array(Dict, N)
	params = getparamsinit(madsdata)
	for i = 1:N
		klog = 1
		knonlog = 1
		for j = 1:length(params)
			if paramtypes[j] != nohting
				if paramlogs[j] == true || paramlogs[j] == "yes"
					params[j] = 10 ^ logoptparams[klog, i]
					klog += 1
				else
					params[j] = nonlogoptparams[knonlog, i]
					knonlog += 1
				end
			end
		end
		paramdicts[i] = Dict(zip(paramkeys, params))
	end
	f = makemadscommandfunction(madsdata)
	results = pmap(f, paramdicts)
	outputdicts = Array(Dict, N)
	for i = 1:N
		outputdicts[i] = Dict()
		outputdicts[i]["Parameters"] = paramdicts[i]
		outputdicts[i]["Results"] = results[i]
	end
	outputfilename = string(madsdata["Filename"][1:end-5], ".mcresults.yaml")
	dumpyamlfile(outputfilename, outputdicts)
	return outputdicts
end

@doc "Convert parameter array to a parameter dictionary of arrays" ->
function paramarray2dict(madsdata, array)
	paramkeys = getparamkeys(madsdata)
	dict = OrderedDict()
	for i in 1:length(paramkeys)
		dict[paramkeys[i]] = array[:,i]
	end
	return dict
end

@doc "Generate spaghetti plots for each model parameter separtely " ->
function spaghettiplots(madsdata, paramdictarray::OrderedDict; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true )
	rootname = getmadsrootname(madsdata)
	func = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	paramdict = OrderedDict( zip(paramkeys, getparamsinit(madsdata)) )
	paramoptkeys = getoptparamkeys(madsdata)
	numberofsamples = length(paramdictarray[paramoptkeys[1]])
	obskeys = Mads.getobskeys(madsdata)
	if obs_plot_dots
		obs_plot1 = """Gadfly.Geom.point"""
		obs_plot2 = """Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=3pt)"""
	else
		obs_plot1 = """Gadfly.Geom.line"""
		obs_plot2 = """Gadfly.Theme(default_color=parse(Colors.Colorant, "black"), line_width=1mm)"""
	end
	nT = length(obskeys)
	if !haskey( madsdata, "Wells" )
		t = Array(Float64, nT)
		d = Array(Float64, nT)
		for i in 1:nT
			t[i] = madsdata["Observations"][obskeys[i]]["time"]
			d[i] = madsdata["Observations"][obskeys[i]]["target"]
		end
	end
	vsize = 0inch
	Mads.madsoutput("Sensitivty analysis spaghetti plots for each selected model parameter (type != null) ...\n")
	for paramkey in paramoptkeys
		Mads.madsoutput("Parameter: $paramkey ...\n")
		Y = Array(Float64, nT, numberofsamples)
		@showprogress 4 "Computing ..." for i in 1:numberofsamples
			original = paramdict[paramkey]
			paramdict[paramkey] = paramdictarray[paramkey][i]
			result = func(paramdict)
			for j in 1:nT
				Y[j,i] = result[obskeys[j]]
			end
			paramdict[paramkey] = original
		end
		if !haskey( madsdata, "Wells" )
			pl = Gadfly.plot(Gadfly.layer(x=t, y=d, eval(parse(obs_plot1)), eval(parse(obs_plot2))),
								Guide.XLabel(xtitle), Guide.YLabel(ytitle),
								[Gadfly.layer(x=t, y=Y[:,i], Geom.line,
								Gadfly.Theme(default_color=parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][i%6+1])))
								for i in 1:numberofsamples]...)
			vsize = 4inch
		else
			pp = Array(Gadfly.Plot{}, 0)
			p = Gadfly.Plot{}
			vsize = 0inch
			startj = 1
			endj  = 0
			for wellname in keys(madsdata["Wells"])
				if madsdata["Wells"][wellname]["on"]
					o = madsdata["Wells"][wellname]["obs"]
					nTw = length(o)
					t = Array(Float64, nTw)
					d = Array(Float64, nTw)
					for i in 1:nTw
						t[i] = o[i]["t"]
						d[i] = o[i]["c"]
					end
					endj += nTw
					p = Gadfly.plot(Gadfly.layer(x=t, y=d, eval(parse(obs_plot1)), eval(parse(obs_plot2))),
										Guide.XLabel(xtitle), Guide.YLabel(ytitle),
										[Gadfly.layer(x=t, y=Y[startj:endj,i], Geom.line,
										Gadfly.Theme(default_color=parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][i%6+1])))
										for i in 1:numberofsamples]...)
					push!(pp, p)
					vsize += 4inch
					startj = endj + 1
				end
			end
			if length(pp) > 1
				pl = Gadfly.vstack(pp...)
			else
				pl = p
			end
		end
		if keyword == ""
			filename = string("$rootname-$paramkey-$numberofsamples-spaghetti")
		else
			filename = string("$rootname-$keyword-$paramkey-$numberofsamples-spaghetti")
		end
		filename, format = Mads.setimagefileformat(filename, format)
		try
			Gadfly.draw( Gadfly.eval((symbol(format)))(filename, 6inch, vsize), pl)
		catch "At least one finite value must be provided to formatter.":$
			Mads.madswarn("Gadfly fails!")
		end
	end
end

@doc "Generate Monte-Carlo spaghetti plots for all the selected model parameter " ->
function spaghettiplot(madsdata, paramdictarray::OrderedDict; keyword = "", filename="", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
	rootname = getmadsrootname(madsdata)
	func = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	paramdict = OrderedDict( zip(paramkeys, getparamsinit(madsdata)) )
	paramoptkeys = getoptparamkeys(madsdata)
	numberofsamples = length(paramdictarray[paramoptkeys[1]])
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	t = Array(Float64, nT )
	d = Array(Float64, nT )
	if obs_plot_dots
		obs_plot1 = """Gadfly.Geom.point"""
		obs_plot2 = """Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=3pt)"""
	else
		obs_plot1 = """Gadfly.Geom.line"""
		obs_plot2 = """Gadfly.Theme(default_color=parse(Colors.Colorant, "black"), line_width=1mm)"""
	end
	for i in 1:nT
		t[i] = madsdata["Observations"][obskeys[i]]["time"]
		d[i] = madsdata["Observations"][obskeys[i]]["target"]
	end
	Y = Array(Float64,nT,numberofsamples)
	madsoutput("Monte-Carlo spaghetti plots for all the selected model parameter (type != null) ...\n")
	@showprogress 4 "Computing ..." for i in 1:numberofsamples
		for paramkey in paramoptkeys
			paramdict[paramkey] = paramdictarray[paramkey][i]
		end
		result = func(paramdict)
		for j in 1:nT
			Y[j,i] = result[obskeys[j]]
		end
	end
	p = Gadfly.plot(layer(x=t, y=d, eval(parse(obs_plot1)), eval(parse(obs_plot2))),
					Guide.XLabel(xtitle), Guide.YLabel(ytitle),
					[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
					Gadfly.Theme(default_color=parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][i%6+1])))
					for i in 1:numberofsamples]... )
	if filename == ""
		if keyword == ""
			filename = "$rootname-$numberofsamples-spaghetti"
		else
			filename = "$rootname-$keyword-$numberofsamples-spaghetti"
		end
	end
	filename, format = setimagefileformat(filename, format)
	try
		Gadfly.draw(Gadfly.eval((symbol(format)))(filename, 6inch,4inch), p)
	catch "At least one finite value must be provided to formatter."
		Mads.madswarn("Gadfly fails!")
	end
end
