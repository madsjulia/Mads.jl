"""
Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

`Mads.setimagefileformat!(filename, format)`

Arguments:

- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)

Returns:

- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function setimagefileformat!(filename, format)
	format = uppercase(format)
	extension = uppercase(getextension(filename))
	root = Mads.getrootname(filename)
	if format == ""
		format = extension
	end
	if ismatch(r"^PNG|PDF|PS|SVG", format)
		if format != extension
			filename = root * "." * lowercase(format)
		end
	elseif format == "EPS"
		if !ismatch(r"^EPS|PS", extension)
			filename = root * ".eps"
		end
		format = "PS"
	else
		if "SVG" != extension
			filename = root * ".svg"
		end
		format = "SVG"
	end
	return filename, format
end

"""
Plot contaminant sources and wells defined in MADS problem dictionary

Arguments:

- `madsdata` : MADS problem dictionary
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotmadsproblem(madsdata::Associative; format="", filename="")
	if haskey(madsdata, "Sources")
		rectangles = Array(Float64, 0, 4)
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			if sourcetype == "box"
				rectangle = Array(Float64, 4)
				rectangle[1] = madsdata["Sources"][i][sourcetype]["x"]["init"] - madsdata["Sources"][i][sourcetype]["dx"]["init"] / 2
				rectangle[2] = madsdata["Sources"][i][sourcetype]["y"]["init"] - madsdata["Sources"][i][sourcetype]["dy"]["init"] / 2
				rectangle[3] = madsdata["Sources"][i][sourcetype]["dx"]["init"]
				rectangle[4] = madsdata["Sources"][i][sourcetype]["dy"]["init"]
				rectangles = vcat(rectangles, rectangle')
			end
		end
	end
	dfw = DataFrame(x = Float64[], y = Float64[], label = AbstractString[], category = AbstractString[])
	for wellkey in collect(keys(madsdata["Wells"]))
		if madsdata["Wells"][wellkey]["on"]
			match = false
			x = madsdata["Wells"][wellkey]["x"]
			y = madsdata["Wells"][wellkey]["y"]
			for i = 1:size(dfw)[1]
				if dfw[1][i] == x && dfw[2][i] == y
					match = true
					break
				end
			end
			if !match
				push!(dfw, (x, y, wellkey, "Wells"))
			end
		end
	end
	xo = rectangles[:,1] + rectangles[:,3]
	yo = rectangles[:,2] + rectangles[:,4]
	xmin = min(dfw[1]..., rectangles[:,1]...)
	ymin = min(dfw[2]..., rectangles[:,2]...)
	xmax = max(dfw[1]..., xo...)
	ymax = max(dfw[2]..., yo...)
	dx = xmax - xmin
	dy = ymax - ymin
	xmin = xmin - dx / 6
	xmax = xmax + dx / 6
	ymin = ymin - dy / 6
	ymax = ymax + dy / 6
	p = Gadfly.plot(dfw, x="x", y="y", label="label", color="category", Geom.point, Geom.label,
		Guide.XLabel("x [m]"), Guide.YLabel("y [m]"), Guide.yticks(orientation=:vertical),
		Guide.annotation(Compose.compose(Compose.context(), Compose.rectangle(rectangles[:,1],rectangles[:,2],rectangles[:,3],rectangles[:,4]),
		Compose.fill(parse(Colors.Colorant, "orange")),
		Compose.fillopacity(0.2),
		Compose.stroke(parse(Colors.Colorant, "orange")))),
		Scale.x_continuous(minvalue=xmin, maxvalue=xmax, labels=x -> @sprintf("%.0f", x)),
		Scale.y_continuous(minvalue=ymin, maxvalue=ymax, labels=y -> @sprintf("%.0f", y)))
	if filename == ""
		rootname = getmadsrootname(madsdata)
		filename = "$rootname-problemsetup"
	end
	filename, format = setimagefileformat!(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, 4inch), p)
	if typeof(p) == Gadfly.Plot{}
		p
	end
end

"""
Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

```
plotgrid(madsdata, s; addtitle=true, title="", filename="", format="")
plotgrid(madsdata; addtitle=true, title="", filename="", format="")
plotgrid(madsdata, parameters; addtitle=true, title="", filename="", format="")
```

Arguments:

- `madsdata` : MADS problem dictionary
- `parameters` : dictionary with model parameters
- `s` : model predictions array
- `addtitle` : add plot title [true]
- `title` : plot title
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotgrid(madsdata::Associative, s::Array{Float64}; addtitle=true, title="", filename="", format="")
	@PyCall.pyimport matplotlib.ticker as mt
	@PyCall.pyimport matplotlib.colors as mcc
	probname = Mads.getmadsrootname(madsdata; first=false)
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	t = madsdata["Grid"]["time"]
	x = Array(Float64, 0)
	y = Array(Float64, 0)
	c = Array(Float64, 0)
	l = Array(AbstractString, 0)
	for w in keys(madsdata["Wells"])
		push!(x, madsdata["Wells"][w]["x"])
		push!(y, madsdata["Wells"][w]["y"])
		push!(c, madsdata["Wells"][w]["obs"][end]["c"])
		push!(l, w)
	end
	w, h = PyPlot.plt[:figaspect](0.5)
	PyPlot.figure(figsize=(w, h))
	PyPlot.subplot(111, aspect=1)
	# PyPlot.imshow(log10(s[:,:,1]'), origin="lower", extent=[xmin, xmax, ymin, ymax], origin="lower", vmin=log10(50), cmap="jet")
	levels = [10,30,100,300,1000,3000,10000,30000,100000]
	PyPlot.contourf(s[:,:,1]', cmap="jet", levels=levels, set_aspect="equal", set_aspect="auto", locator=mt.LogLocator(), origin="lower", extent=[xmin, xmax, ymin, ymax], cmap="jet", set_under="w" )
	PyPlot.colorbar(shrink=0.5, cmap="jet")
	if addtitle
		if title == ""
			PyPlot.title("$probname Time = $t")
		else
			PyPlot.title(title)
		end
	end
	plotx = [x[1]; x[1]; x]
	ploty = [y[1]; y[1]; y]
	plotc = [minimum(levels); maximum(levels); map(x->min(maximum(levels), max(minimum(levels), x)), c)]
	alpha = ones(length(plotx))
	alpha[1] = alpha[2] = 0#make the two points corresponding to the minimum and maximum of the levels transparent
	PyPlot.scatter(plotx, ploty, marker="o", c=log10(plotc), s=70, cmap="jet")
	for i = 1:length(l)
		PyPlot.annotate(l[i], xy=(x[i], y[i]), xytext=(-2, 2), fontsize=8, textcoords="offset points", ha="right", va="bottom")
	end
	#I think this fixes the aspect ratio. It works in another code, but isn't tested here
end

function plotgrid(madsdata::Associative; addtitle=true, title="", filename="", format="")
	s = forwardgrid(madsdata)
	plotgrid(madsdata, s; addtitle=addtitle, title=title, filename=filename, format=format)
end

function plotgrid(madsdata::Associative, parameters::Associative; addtitle=true, title="", filename="", format="")
	s = forwardgrid(madsdata, parameters)
	plotgrid(madsdata, s; addtitle=addtitle, title=title, filename=filename, format=format)
end


"""
Plot the matches between model predictions and observations

```
plotmatches(madsdata; filename="", format="")
plotmatches(madsdata, result; filename="", format="")
```

Arguments:

- `madsdata` : MADS problem dictionary
- `result` : dictionary with model predictions
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotmatches(madsdata_in::Associative; filename="", format="")
	madsdata = deepcopy(madsdata_in)
	if haskey(madsdata, "Wells")
		setwellweights!(madsdata, 1)
	elseif haskey(madsdata, "Observations")
		setobsweights!(madsdata, 1)
	end
	r = forward(madsdata)
	plotmatches(madsdata_in, r, filename=filename, format=format)
end

function plotmatches(madsdata::Associative, result::Associative; filename="", format="")
	rootname = Mads.getmadsrootname(madsdata)
	vsize = 0inch
	pl = Gadfly.Plot{}
	if haskey(madsdata, "Wells")
		pp = Array(Gadfly.Plot{}, 0)
		p = Gadfly.Plot{}
		for wellname in keys(madsdata["Wells"])
			if madsdata["Wells"][wellname]["on"]
				o = madsdata["Wells"][wellname]["obs"]
				nT = length(o)
				c = Array(Float64, 0)
				tc = Array(Float64, 0)
				d = Array(Float64, 0)
				td = Array(Float64, 0)
				for i in 1:nT
					time = o[i]["t"]
					obskey = wellname * "_" * string(time)
					if o[i]["weight"] > eps(Float64)
						push!(td, time)
						push!(d, o[i]["c"])
					end
					if result[obskey] > eps(Float64)
						push!(tc, time)
						push!(c, result[obskey])
					end
				end
				npp = length(c)
				if npp > 1
					p = Gadfly.plot(Guide.title(wellname),
							layer(x=tc, y=c, Geom.line, Theme(default_color=parse(Colors.Colorant, "blue"), line_width=3pt)),
					    layer(x=td, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
					vsize += 4inch
					push!(pp, p)
				else npp = 1
						p = Gadfly.plot(Guide.title(wellname),
							layer(x=tc, y=c, Geom.point, Theme(default_color=parse(Colors.Colorant, "blue"), default_point_size=4pt)),
					    layer(x=td, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
					vsize += 4inch
					push!(pp, p)
				end
			end
		end
		if length(pp) > 1
			pl = Gadfly.vstack(pp...)
		else
			pl = p
		end
	elseif haskey(madsdata, "Observations")
		obskeys = Mads.getobskeys(madsdata)
		nT = length(obskeys)
		c = Array(Float64, 0)
		tc = Array(Float64, 0)
		d = Array(Float64, 0)
		td = Array(Float64, 0)
		for i in 1:nT
			time = madsdata["Observations"][obskeys[i]]["time"]
			if madsdata["Observations"][obskeys[i]]["weight"] > eps(Float64)
				push!(tc, time)
				push!(d, madsdata["Observations"][obskeys[i]]["target"])
			end
			if result[obskey[i]] > eps(Float64)
				push!(tc, time)
				push!(c, result[obskeys[i]])
			end
		end
		npp = length(c)
		if npp > 1
			pl = Gadfly.plot(Guide.title(wellname),
						layer(x=tc, y=c, Geom.line, Theme(default_color=parse(Colors.Colorant, "blue"), line_width=3pt)),
						layer(x=td, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
			vsize += 4inch
		elseif npp == 1
			pl = Gadfly.plot(Guide.title(wellname),
						layer(x=tc, y=c, Geom.point, Theme(default_color=parse(Colors.Colorant, "blue"), default_point_size=4pt)),
						layer(x=td, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
			vsize = 4inch
		end
	end
	if filename == ""
		filename = "$rootname-match"
	end
	filename, format = setimagefileformat!(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, vsize), pl)
	if typeof(pl) == Gadfly.Plot{}
		pl
	end
end

"""
Create histogram/scatter plots of model parameter samples

Arguments:

- `madsdata` : MADS problem dictionary
- `samples` : matrix with model parameters
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function scatterplotsamples(madsdata, samples::Matrix, filename::AbstractString; format="")
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	cs = Array(Compose.Context, (size(samples, 2), size(samples, 2)))
	for i in 1:size(samples, 2)
		for j in 1:size(samples, 2)
			if i == j
				cs[i, j] = Gadfly.render(plot(x=samples[:, i], Gadfly.Geom.histogram, 
					Gadfly.Guide.xlabel(plotlabels[i]),
					Gadfly.Theme(major_label_font_size=24pt, minor_label_font_size=12pt) 
					))
			else
				cs[i, j] = Gadfly.render(plot(x=samples[:, i], y=samples[:, j], 
					Gadfly.Guide.xlabel(plotlabels[i]), Gadfly.Guide.ylabel(plotlabels[j]),
					Gadfly.Theme(major_label_font_size=24pt, minor_label_font_size=12pt)
					))
			end
		end
	end
	hsize = (3 * size(samples, 2))inch
	vsize = (3 * size(samples, 2))inch
	filename, format = Mads.setimagefileformat!(filename, format)
	try
		Gadfly.draw( Gadfly.eval((symbol(format)))(filename, hsize, vsize), Compose.gridstack(cs))
	catch "At least one finite value must be provided to formatter."
		Mads.madswarn("Gadfly fails!")
	end
end

"""
Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

Arguments:

- `madsdata` : MADS problem dictionary
- `result` : sensitivity analysis results
- `xtitle` : x-axis title
- `ytitle` : y-axis title
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotwellSAresults(madsdata, result; xtitle = "Time [years]", ytitle = "Concentration [ppb]", filename = "", format="")
	if !haskey(madsdata, "Wells")
		Mads.madserror("There is no 'Wells' data in the MADS input dataset")
		return
	end
	for wellname in keys(madsdata["Wells"])
		if madsdata["Wells"][wellname]["on"]
			plotwellSAresults(madsdata, result, wellname; xtitle = xtitle, ytitle = ytitle, filename = filename, format = format)
		end
	end
end

"""
Plot the sensitivity analysis results for a given well in the MADS problem dictionary (wells class expected)

Arguments:

- `madsdata` : MADS problem dictionary
- `result` : sensitivity analysis results
- `wellname` : well name
- `xtitle` : x-axis title
- `ytitle` : y-axis title
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotwellSAresults(madsdata, result, wellname; xtitle = "Time [years]", ytitle = "Concentration [ppb]", filename = "", format="")
	if !haskey(madsdata, "Wells")
		Mads.madserror("There is no 'Wells' class in the MADS input dataset")
		return
	end
	if !haskey(madsdata["Wells"], wellname)
		Mads.madserror("There is no well with name $wellname in 'Wells' class of the MADS input dataset")
		return
	end
	o = madsdata["Wells"][wellname]["obs"]
	nsample = result["samplesize"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(o)
	d = Array(Float64, 2, nT)
	mes = Array(Float64, nP, nT)
	tes = Array(Float64, nP, nT)
	var = Array(Float64, nP, nT)
	for i in 1:nT
		t = d[1,i] = o[i]["t"]
		d[2,i] = o[i]["c"]
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
	pc = Gadfly.plot(dfc, x="x", y="y", Geom.point, Guide.XLabel(xtitle), Guide.YLabel(ytitle) )
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
		ptes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel(xtitle), Guide.YLabel("Total Effect"), Theme(key_position = :top) )
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
		pmes = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel(xtitle), Guide.YLabel("Main Effect"), Theme(key_position = :none) )
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
		pvar = Gadfly.plot(vdf, x="x", y="y", Geom.line, color="parameter", Guide.XLabel(xtitle), Guide.YLabel("Output Variance"), Theme(key_position = :none) )
		push!(pp, pvar)
		vsize += 4inch
	end
	p = Gadfly.vstack(pp...)
	rootname = getmadsrootname(madsdata)
	method = result["method"]
	if filename == ""
		filename = "$rootname-$wellname-$method-$nsample"
	end
	filename, format = Mads.setimagefileformat!(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, vsize), p)
end

"""
Plot the sensitivity analysis results for the observations

Arguments:

- `madsdata` : MADS problem dictionary
- `result` : sensitivity analysis results
- `filter` : string or regex to plot only observations containing `filter`
- `keyword` : to be added in the auto-generated filename
- `filename` : output file name
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotobsSAresults(madsdata, result; filter="", keyword="", filename="", format="", debug=false, separate_files=false, xtitle = "Time [years]", ytitle = "Concentration [ppb]")
	if !haskey(madsdata, "Observations")
		Mads.madserror("There is no 'Observations' class in the MADS input dataset")
		return
	end
	nsample = result["samplesize"]
	obsdict = madsdata["Observations"]
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	nP = length(paramkeys)
	nT = length(Mads.filterkeys(obsdict, filter))
	d = Array(Float64, 2, nT)
	mes = Array(Float64, nP, nT)
	tes = Array(Float64, nP, nT)
	var = Array(Float64, nP, nT)
	i = 1
	for obskey in Mads.filterkeys(obsdict, filter)
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
	mintes = minimum( tes )
	if mintes < 0
		tes = tes - mintes # normalize 0 to 1
	end
	maxtes = maximum( tes )
	if maxtes > 1
		tes = tes / maxtes # normalize 0 to 1
	end
	###################################################### DATA
	dfc = DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="Observations")
	pp = Array(Any, 0)
	pd = Gadfly.plot(dfc, x="x", y="y", Geom.line, Guide.XLabel(xtitle), Guide.YLabel(ytitle) )
	push!(pp, pd)
	if debug
		# println(dfc)
		println("DAT xmax $(max(dfc[1]...)) xmin $(min(dfc[1]...)) ymax $(max(dfc[2]...)) ymin $(min(dfc[2]...))")
		# writetable("dfc.dat", dfc)
	end
	# vsize = 4inch
	vsize = 0inch
	###################################################### TES
	df = Array(Any, nP)
	for j in 1:length(plotlabels)
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$(plotlabels[j])")
		deleteNaN!(df[j])
	end
	vdf = vcat(df...)
	if debug
		# println(vdf)
		println("TES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		writetable("tes.dat", vdf)
	end
	if length(vdf[1]) > 0
		if max(vdf[2]...) > realmax(Float32)
			Mads.madswarn("""TES values larger than $(realmax(Float32))""")
			maxtorealmaxFloat32!(vdf)
			println("TES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		ptes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
				Gadfly.Theme(line_width=1.5pt, default_point_size=20pt, major_label_font_size=14pt, minor_label_font_size=12pt, key_title_font_size=16pt, key_label_font_size=12pt),
					Gadfly.Scale.y_continuous(minvalue=0, maxvalue=1),
					Gadfly.Guide.XLabel(xtitle),
					Gadfly.Guide.YLabel("Total Effect") ) # only none and default works
		push!(pp, ptes)
		vsize += 4inch
	end
	###################################################### MES
	for j in 1:length(plotlabels)
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$(plotlabels[j])")
		deleteNaN!(df[j])
	end
	vdf = vcat(df...)
	if debug
		# println(vdf)
		println("MES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		# writetable("mes.dat", vdf)
	end
	if length(vdf[1]) > 0
		if max(vdf[2]...) > realmax(Float32)
			Mads.madswarn("""MES values larger than $(realmax(Float32))""")
			maxtorealmaxFloat32!(vdf)
			println("MES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		pmes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
				Gadfly.Theme(line_width=1.5pt, default_point_size=20pt, major_label_font_size=14pt, minor_label_font_size=12pt, key_title_font_size=16pt, key_label_font_size=12pt),
				Gadfly.Scale.y_continuous(minvalue=0, maxvalue=1),
				Gadfly.Guide.XLabel(xtitle),
				Gadfly.Guide.YLabel("Main Effect") ) # only none and default works: , Theme(key_position = :none)
		push!(pp, pmes)
		vsize += 4inch
	end
	###################################################### VAR
	for j in 1:length(plotlabels)
		df[j] = DataFrame(x=collect(d[1,:]), y=collect(var[j,:]), parameter="$(plotlabels[j])")
		deleteNaN!(df[j])
	end
	vdf = vcat(df...)
	if debug
		# println(vdf)
		println("VAR xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		# writetable("var.dat", vdf)
	end
	if length(vdf[1]) > 0
		if max(vdf[2]...) > realmax(Float32)
			Mads.madswarn("""Variance values larger than $(realmax(Float32))""")
			maxtorealmaxFloat32!(vdf)
			println("VAR xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		pvar = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
			Gadfly.Theme(default_point_size=20pt, major_label_font_size=14pt, minor_label_font_size=12pt, key_title_font_size=16pt, key_label_font_size=12pt),
			Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel("Output Variance") ) # only none and default works: , Theme(key_position = :none)
		push!(pp, pvar)
		vsize += 4inch
	end
	######################################################
	if filename == ""
		method = result["method"]
		rootname = Mads.getmadsrootname(madsdata)
		if keyword != ""
			filename = "$rootname-$method-$keyword-$nsample"
		else
			filename = "$rootname-$method-$nsample"
		end
	end
	if !separate_files
		# p1 = Gadfly.vstack(pp[1:3]...)
		# p2 = Gadfly.vstack(pp[4:6]...)
		# p = Gadfly.hstack(p1,p2)
		filename, format = Mads.setimagefileformat!(filename, format)
		p = Gadfly.vstack(pp...)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, vsize ), p)
	else
		filename_root = Mads.getrootname(filename)
		filename_ext = Mads.getextension(filename)
		filename = filename_root * "-total_effect." * filename_ext
		filename, format = Mads.setimagefileformat!(filename, format)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, 4inch), ptes)
		filename = filename_root * "-main_effect." * filename_ext
		filename, format = Mads.setimagefileformat!(filename, format)
		Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, 4inch), pmes)
	end
end
