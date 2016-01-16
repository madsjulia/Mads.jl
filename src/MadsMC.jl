import BlackBoxOptim
import Lora

"""
Bayes Sampling of a given `madsdata` class

`bayessampling(madsdata; nsteps=100, burnin=1000, thinning=1)`

Arguments:

- `madsdata` : Mads data class loaded using `madsdata = Mads.loadmadsfiles("input_file_name.mads")`

- `nsteps` : 

- `burnin` : 

- `thinning` : 

Returns:

- `mcmcchain` : 

"""
function bayessampling(madsdata::Associative; nsteps::Int=100, burnin::Int=1000, thinning::Int=1)
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

"""
Brute force parallel Bayesian sampling of a given the `madsdata` class

`bayessampling(madsdata, numsequences; nsteps=100, burnin=1000, thinning=1)`

Arguments:

- `madsdata` : Mads data class loaded using `madsdata = Mads.loadmadsfiles("input_file_name.mads")`

- `numsequences` :

- `nsteps` : 

- `burnin` : 

- `thinning` : 

Returns:

- `mcmcchain` : 

"""
function bayessampling(madsdata, numsequences; nsteps::Int=100, burnin::Int=1000, thinning::Int=1)
	mcmcchain = pmap(i->bayessampling(madsdata; nsteps=nsteps, burnin=burnin, thinning=thinning), 1:numsequences)
	return mcmcchain
end

"""
Monte Carlo analysis of a given `madsdata` class

`montecarlo(madsdata; N=100)`

Arguments:

- `madsdata` : Mads data class loaded using `madsdata = Mads.loadmadsfiles("input_file_name.mads")`

- `N` : number of samples (default = 100)

Returns:

- `outputdicts` : parameter dictionary containing the data arrays

Dumps:

- YAML output file with the parameter dictionary containing the data arrays (`<mads_root_name>.mcresults.yaml`)

"""
function montecarlo(madsdata::Associative; N=100)
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
	#rootname = Mads.getmadsrootname(madsdata)
	#outputfilename = rootname * ".mcresults.yaml"
	dumpyamlfile(outputfilename, outputdicts)
	return outputdicts
end

"Convert parameter array to a parameter dictionary of arrays"
function paramarray2dict(madsdata::Associative, array)
	paramkeys = getparamkeys(madsdata)
	dict = OrderedDict()
	for i in 1:length(paramkeys)
		dict[paramkeys[i]] = array[:,i]
	end
	return dict
end

"""
Generate separate spaghetti plots for each `selected` (`type: opt`) model parameter in a given `madsdata` class

`spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true )`

Arguments:

- `madsdata` : Mads data class loaded using `madsdata = Mads.loadmadsfiles("input_file_name.mads")`

- `paramdictarray` : parameter dictionary containing the data arrays to be plotted

- `keyword` : keyword to be added in the file name used to output the produced plots

- `format` : output plot format (`png`, `pdf`, etc.)

- `xtitle` : `x` axis title

- `ytitle` : `y` axis title

- `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)

Returns: `none`

Dumps:

- Images files (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

"""
function spaghettiplots(madsdata::Associative, paramdictarray::OrderedDict; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true )
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

"""
Generate a combined spaghetti plot for the `selected` (`type: opt`) model parameter in a given `madsdata` class

`spaghettiplot(madsdata, paramdictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)`

Arguments:

- `madsdata` : Mads data class loaded using `madsdata = Mads.loadmadsfiles("input_file_name.mads")`

- `paramdictarray` : dictionary containing the parameter data arrays to be plotted

- `filename` : output file name used to output the produced plots

- `keyword` : keyword to be added in the file name used to output the produced plots (if `filename` is not defined)

- `format` : output plot format (`png`, `pdf`, etc.)

- `xtitle` : `x` axis title

- `ytitle` : `y` axis title

- `obs_plot_dots` : plot observation as dots (`true` [default] or `false`)

Returns: `none`

Dumps:

- Images files (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

"""
function spaghettiplot(madsdata::Associative, paramdictarray::OrderedDict; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
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
