import Gadfly

"""
Local sensitivity analysis based on eigen analysis of covariance matrix

Arguments:

- `madsdata` : MADS problem dictionary
- `madsdata` : MADS problem dictionary
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
- `par` : parameter set
- `obs` : observations for the parameter set
"""
function localsa(madsdata::Associative; format::AbstractString="", filename::AbstractString="", datafiles=true, imagefiles=true, par=Array(Float64,0), obs=Array(Float64,0))
	if filename == ""
		rootname = Mads.getmadsrootname(madsdata)
		ext = ""
	else
		rootname = Mads.getrootname(filename)
		ext = "." * Mads.getextension(filename)
	end
	g = makelocalsafunction(madsdata)
	paramkeys = getoptparamkeys(madsdata)
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
	end
	J = g(param, center=obs)
	if any(isnan, J)
		Mads.madswarn("Local sensitivity analysis cannot be performed; provided Jacobian matrix contains NaN's")
		display(J)
		Mads.madscritical("Mads quits!")
	end
	datafiles && writedlm("$(rootname)-jacobian.dat", J)
	mscale = max(abs(minimum(J)), abs(maximum(J)))
	if imagefiles && isdefined(:Gadfly)
		jacmat = Gadfly.spy(J, Gadfly.Scale.x_discrete(labels = i->plotlabels[i]), Gadfly.Scale.y_discrete,
					Gadfly.Guide.YLabel("Observations"), Gadfly.Guide.XLabel("Parameters"),
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red")), minvalue = -mscale, maxvalue = mscale))
		filename = "$(rootname)-jacobian" * ext
		filename, format = setimagefileformat(filename, format)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6Gadfly.inch, 12Gadfly.inch), jacmat)
		Mads.madsinfo("Jacobian matrix plot saved in $filename")
	end
	JpJ = J' * J
	covar = Array(Float64, 0)
	try
		u, s, v = svd(JpJ)
		covar = v * inv(diagm(s)) * u'
	catch "LAPACKException(12)"
		try
			covar = inv(JpJ)
		catch "SingularException(4)"
			Mads.madserror("Singular covariance matrix! Local sensitivity analysis fails.")
			return
		end
	end
	stddev = sqrt(abs(diag(covar)))
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
	eigenv = abs(eigenv)
	index = sortperm(eigenv)
	sortedeigenv = eigenv[index]
	sortedeigenm = real(eigenm[:,index])
	datafiles && writedlm("$(rootname)-eigenmatrix.dat", sortedeigenm)
	datafiles && writedlm("$(rootname)-eigenvalues.dat", sortedeigenv)
	if imagefiles && isdefined(:Gadfly)
		eigenmat = Gadfly.spy(sortedeigenm, Gadfly.Scale.y_discrete(labels = i->plotlabels[i]), Gadfly.Scale.x_discrete,
					Gadfly.Guide.YLabel("Parameters"), Gadfly.Guide.XLabel("Eigenvectors"),
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(parse(Colors.Colorant, "green"), parse(Colors.Colorant, "yellow"), parse(Colors.Colorant, "red"))))
		# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenmatrix" * ext
		filename, format = setimagefileformat(filename, format)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename,6Gadfly.inch,6Gadfly.inch), eigenmat)
		Mads.madsinfo("Eigen matrix plot saved in $filename")
		eigenval = Gadfly.plot(x=1:length(sortedeigenv), y=sortedeigenv, Gadfly.Scale.x_discrete, Gadfly.Scale.y_log10,
					Gadfly.Geom.bar,
					Gadfly.Theme(default_point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
					Gadfly.Guide.YLabel("Eigenvalues"), Gadfly.Guide.XLabel("Eigenvectors"))
		filename = "$(rootname)-eigenvalues" * ext
		filename, format = setimagefileformat(filename, format)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), eigenval)
		Mads.madsinfo("Eigen values plot saved in $filename")
	end
	Dict("jacobian"=>J, "covar"=>covar, "stddev"=>stddev, "eigenmatrix"=>sortedeigenm, "eigenvalues"=>sortedeigenv)
end

"Plot the sensitivity analysis results for each well (Specific plot requested by Monty)"
function plotSAresults_monty(wellname, madsdata, result)
	if !haskey(madsdata, "Wells")
		Mads.madserror("There is no 'Wells' data in the MADS input dataset")
		return
	end
	nsample = result["samplesize"]
	o = madsdata["Wells"][wellname]["obs"]
	paramkeys = Mads.getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(o)
	d = Array(Float64, 2, nT)
	tes = Array(Float64, nP, nT)
	# Deleting "Voids" from results (tes[1:3])
	for zz=1:3
		for k = 1:7
			result["tes"]["$(wellname)_$zz"][paramkeys[k]] = NaN
		end
	end
	# Setting tes/concentration matrices
	for i in 1:nT
		t = d[1,i] = o[i]["t"]
		d[2,i] = o[i]["c"]
		obskey = wellname * "_" * string(t)
		j = 1
		for paramkey in paramkeys
			tes[j,i] = result["tes"][obskey][paramkey]
			j += 1
		end
	end
	# Calculating concentration from initial values (using model)
	paramallkeys  = Mads.getparamkeys(madsdata)
	paramalldict  = DataStructures.OrderedDict(zip(paramallkeys, map(key->madsdata["Parameters"][key]["init"], paramallkeys)))
	f 			  = Mads.makemadscommandfunction(madsdata)
	Ytemp = f(paramalldict)
	# Since md might include more wells then wellname, this finds results only for wellname
	wstr = Array(AbstractString,(50,1))
	for i = 1:50
		wstr[i] = wellname*"_$i"
	end
	# Finding concentration just for wellname
	Y = zeros(50,1)
	for i = 1:50
		Y[i] = Ytemp[wstr[i]]
	end
	# Concentrations will be normalized to be from 0 to 1
	maxconcentration = maximum(Y)
	# Normalizing concentration
	Y = Y./maxconcentration
	# Rounding maxconcentration to 3 sig figs
	maxconcentration = signif(maxconcentration,3)
	# Data frame for concentration
	dfc = DataFrames.DataFrame(x=[1:50], y = Y[:], parameter="c")
	# Changing paramkeys so they don't include "source1_"
	for k = 1:nP
		if length(paramkeys[k]) > 6
			if paramkeys[k][1:6] == "source"
				paramkeys[k] = paramkeys[k][9:end]
			end
		end
	end
	# Data frame for total effect
	df = Array(Any, nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		#deleteNaN!(df[j])
		j += 1
	end
	if isdefined(:Gadfly)
		vdf = vcat(df...)
		# Setting default colors for parameters	
		a = Gadfly.Scale.color_discrete_hue()
		# index 6 is grey
		if nP >= 6
			pcolors = a.f(nP+1)
			pcolors = vcat(pcolors[6], pcolors[1:5], pcolors[7:nP+1])
		else
			pcolors = a.f(nP+6)
			pcolors = vcat(pcolors[6], pcolors[1:nP])
		end
		# Combining dataframes
		bigdf = vcat(dfc,vdf)
		# Plotting
		ptes = Gadfly.plot(bigdf, x="x", y="y", Geom.line, color = "parameter", Guide.XLabel(xtitle), Guide.YLabel("Total Effect/Normalized Concentration"),
											 Guide.title("$(wellname) - Max Concentration: $(maxconcentration)"), Theme(key_position = :bottom, line_width=.03Gadfly.inch),
											 Gadfly.Scale.color_discrete_manual(pcolors...))
		# Creating .svg file for plot (in current directory)
		rootname = Mads.getmadsrootname(madsdata)
		method = result["method"]
		Gadfly.draw(SVG(string("$rootname-$wellname-$method-$(nsample)_montyplot.svg"), 9Gadfly.inch, 6Gadfly.inch), ptes)
	end
end
