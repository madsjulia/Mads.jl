import Colors
import Compose
import ProgressMeter
import DataFrames
import DataStructures
import Gadfly
import Measures

"""
Set the default plot format (`SVG` is the default format)

$(DocumentFunction.documentfunction(setdefaultplotformat;
argtext=Dict("format"=>"plot format")))
"""
function setdefaultplotformat(format::String)
	if ismatch(r"^PNG|PDF|PS|SVG", uppercase(format))
		global graphbackend = uppercase(format);
	else
		madswarn("Requested format ($format) is not acceptable! (PNG|PDF|PS|SVG)")
	end
end

"""
Set image file `format` based on the `filename` extension, or sets the `filename` extension based on the requested `format`. The default `format` is `SVG`. `PNG`, `PDF`, `ESP`, and `PS` are also supported.

$(DocumentFunction.documentfunction(setplotfileformat;
argtext=Dict("filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]")))

Returns:

- output file name
- output plot format (`png`, `pdf`, etc.)
"""
function setplotfileformat(filename::String, format::String)
	format = uppercase(format)
	extension = uppercase(getextension(filename))
	root = Mads.getrootname(filename)
	if format == ""
		format = extension
	end
	if ismatch(r"^PNG|^PDF|^PS|^SVG", format)
		if format != extension
			filename = root * "." * lowercase(format)
		end
	elseif format == "EPS"
		if !ismatch(r"^EPS|^PS", extension)
			filename = root * ".eps"
		end
		format = "PS"
	else
		if graphbackend != extension
			filename = root * "." * lowercase(graphbackend)
		end
		format = graphbackend
	end
	return filename, format
end

"""
Plot contaminant sources and wells defined in MADS problem dictionary

$(DocumentFunction.documentfunction(plotmadsproblem;
argtext=Dict("madsdata"=>"MADS problem dictionary"),
keytext=Dict("format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "filename"=>"output file name",
            "keyword"=>"to be added in the filename",
            "imagefile"=>"dump image file [default=`false`]")))

Dumps:

- plot of contaminant sources and wells
"""
function plotmadsproblem(madsdata::Associative; format::String="", filename::String="", keyword::String="", imagefile::Bool=false)
	rectangles = Array{Float64}(0, 4)
	gadfly_source = Gadfly.Guide.annotation(Compose.compose(Compose.context()))
	if haskey(madsdata, "Sources")
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			if sourcetype == "box" || sourcetype == "gauss"
				rectangle = Array{Float64}(4)
				rectangle[1] = madsdata["Sources"][i][sourcetype]["x"]["init"] - madsdata["Sources"][i][sourcetype]["dx"]["init"] / 2
				rectangle[2] = madsdata["Sources"][i][sourcetype]["y"]["init"] - madsdata["Sources"][i][sourcetype]["dy"]["init"] / 2
				rectangle[3] = madsdata["Sources"][i][sourcetype]["dx"]["init"]
				rectangle[4] = madsdata["Sources"][i][sourcetype]["dy"]["init"]
				rectangles = vcat(rectangles, rectangle')
			end
		end
	end
	if sizeof(rectangles) > 0
		gadfly_source = Gadfly.Guide.annotation(Compose.compose(Compose.context(), Compose.rectangle(rectangles[:,1],rectangles[:,2],rectangles[:,3],rectangles[:,4]),
			Compose.fill(parse(Colors.Colorant, "orange")),
			Compose.fillopacity(0.2),
			Compose.stroke(parse(Colors.Colorant, "orange"))))
	end
	dfw = DataFrames.DataFrame(x = Float64[], y = Float64[], label = String[], category = String[])
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
	p = Gadfly.plot(dfw, x="x", y="y", label="label", color="category", Gadfly.Geom.point, Gadfly.Geom.label,
		Gadfly.Guide.XLabel("x [m]"), Gadfly.Guide.YLabel("y [m]"), Gadfly.Guide.yticks(orientation=:vertical),
		gadfly_source,
		Gadfly.Coord.Cartesian(ymin=ymin, ymax=ymax, xmin=xmin, xmax=xmax),
		Gadfly.Scale.x_continuous(minvalue=xmin, maxvalue=xmax, labels=x -> @sprintf("%.0f", x)),
		Gadfly.Scale.y_continuous(minvalue=ymin, maxvalue=ymax, labels=y -> @sprintf("%.0f", y)))
	if filename == ""
		rootname = getmadsrootname(madsdata)
		filename = "$rootname-problemsetup"
	end
	if keyword != ""
		filename = "$rootname-$keyword-problemsetup"
	end
	filename, format = setplotfileformat(filename, format)
	imagefile && Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), p)
	if typeof(p) == Gadfly.Plot{}
		p
	end
end

function plotmatches(madsdata::Associative, rx::Regex=r""; plotdata::Bool=true, filename::String="", format::String="", title::String="", xtitle::String="time", ytitle::String="y", separate_files::Bool=false, hsize::Measures.Length{:mm,Float64}=6Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.dpi, colors::Array{String,1}=Array{String}(0), display::Bool=false)
	r = forward(madsdata; all=true)
	if rx != r""
		plotmatches(madsdata, r, rx; filename=filename, format=format, xtitle=xtitle, ytitle=ytitle, separate_files=separate_files, hsize=hsize, vsize=vsize, linewidth=linewidth, pointsize=pointsize, obs_plot_dots=obs_plot_dots, noise=noise, dpi=dpi, colors=colors, display=display)
	else
		plotmatches(madsdata, r; plotdata=plotdata, filename=filename, format=format, xtitle=xtitle, ytitle=ytitle, separate_files=separate_files, hsize=hsize, vsize=vsize, linewidth=linewidth, pointsize=pointsize, obs_plot_dots=obs_plot_dots, noise=noise, dpi=dpi, colors=colors, display=display)
	end
end
function plotmatches(madsdata::Associative, result::Associative, rx::Regex; plotdata::Bool=true, filename::String="", format::String="", key2time::Function=k->0., title::String="", xtitle::String="time", ytitle::String="y", separate_files::Bool=false, hsize::Measures.Length{:mm,Float64}=6Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.dpi, colors::Array{String,1}=Array{String}(0), display::Bool=false)
	newobs = similar(madsdata["Observations"])
	newresult = similar(result)
	for k in keys(madsdata["Observations"])
		if ismatch(rx, k)
			newobs[k] = copy(madsdata["Observations"][k])
			if !haskey(newobs[k], "time")
				newobs[k]["time"] = key2time(k)
			end
			if !haskey(result, k)
				warn("Observation `$k` is missing!")
			else
				newresult[k] = result[k]
			end
			title = rx.pattern
		end
	end
	newmadsdata = copy(madsdata)
	newmadsdata["Observations"] = newobs
	if haskey(newmadsdata, "Wells")
		delete!(newmadsdata, "Wells")
	end
	plotmatches(newmadsdata, newresult; plotdata=plotdata, filename=filename, format=format, title=title, xtitle=xtitle, ytitle=ytitle, separate_files=separate_files, hsize=hsize, vsize=vsize, linewidth=linewidth, pointsize=pointsize, obs_plot_dots=obs_plot_dots, noise=noise, dpi=dpi, colors=colors, display=display)
end
function plotmatches(madsdata::Associative, dict_in::Associative; plotdata::Bool=true, filename::String="", format::String="", title::String="", xtitle::String="time", ytitle::String="y", separate_files::Bool=false, hsize::Measures.Length{:mm,Float64}=6Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.dpi, colors::Array{String,1}=Array{String}(0), display::Bool=false)
	obs_flag = isobs(madsdata, dict_in)
	if obs_flag
		result = dict_in
	else
		par_flag = isparam(madsdata, dict_in)
		if par_flag
			result = forward(madsdata, dict_in; all=true)
		else
			madswarn("Provided dictionary does not define either parameters or observations")
			return
		end
	end
	rootname = getmadsrootname(madsdata)
	pl = Any{}
	if haskey(madsdata, "Wells")
		pp = Array{Gadfly.Plot}(0)
		p = Gadfly.Plot{}
		wk = collect(keys(madsdata["Wells"]))
		nW = length(wk)
		if length(colors) == 0 || length(colors) != nW
			colors = Array{String}(nW)
			for iw = 1:nW
				colors[iw] = "blue"
			end
		end
		for iw = 1:nW
			wellname = wk[iw]
			if madsdata["Wells"][wellname]["on"]
				o = madsdata["Wells"][wellname]["obs"]
				nT = length(o)
				c = Array{Float64}(0)
				tc = Array{Float64}(0)
				d = Array{Float64}(0)
				td = Array{Float64}(0)
				for i in 1:nT
					time = gettime(o[i])
					t = gettarget(o[i])
					w = getweight(o[i])
					if w == NaN || w > 0
						push!(td, time)
						push!(d, t)
					end
					obskey = wellname * "_" * string(time)
					if haskey(result, obskey)
						push!(tc, time)
						push!(c, result[obskey])
					end
				end
				if noise != 0
					c = c .+ (rand(nT) .* noise)
				end
				npp = length(c)
				plot_args = Any[]
				if plotdata
					if obs_plot_dots
						push!(plot_args, Gadfly.layer(x=td, y=d, Gadfly.Geom.point, Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), point_size=pointsize)))
					else
						push!(plot_args, Gadfly.layer(x=td, y=d, Gadfly.Geom.line, Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), line_width=linewidth)))
					end
				end
				if npp > 1
					push!(plot_args, Gadfly.layer(x=tc, y=c, Gadfly.Geom.line, Gadfly.Theme(default_color=parse(Colors.Colorant, colors[iw]), line_width=linewidth)))
				else npp = 1
					push!(plot_args, Gadfly.layer(x=tc, y=c, Gadfly.Geom.point, Gadfly.Theme(default_color=parse(Colors.Colorant, colors[iw]), point_size=pointsize)))
				end
				p = Gadfly.plot(Gadfly.Guide.title(wellname), Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle), plot_args...)
				if separate_files
					if filename == ""
						filename_w = "$rootname-match-$wellname"
					else
						extension = getextension(filename)
						rootfile = getrootname(filename)
						filename_w = "$rootfile-$wellname.$extension"
					end
					filename_w, format = setplotfileformat(filename_w, format)
					if format != "SVG"
						Gadfly.draw(Gadfly.eval(Symbol(format))(filename_w, hsize, vsize; dpi=dpi), p)
					else
						Gadfly.draw(Gadfly.eval(Symbol(format))(filename_w, hsize, vsize), p)
					end
					display && Mads.display(filename_w)
				else
					push!(pp, p)
				end
			end
		end
		if length(pp) > 0
			vsize = vsize * length(pp)
			pl = Gadfly.vstack(pp...)
		end
	elseif haskey(madsdata, "Observations")
		obskeys = Mads.getobskeys(madsdata)
		nT = length(obskeys)
		obs = Array{Float64}(0)
		tobs = Any[]
		ress = Array{Float64}(0)
		tress = Any[]
		time_missing = false
		for i in 1:nT
			if !haskey(madsdata["Observations"][obskeys[i]], "time")
				time_missing = true
				continue
			end
			time = madsdata["Observations"][obskeys[i]]["time"]
			skipnext = false
			if !haskey(madsdata["Observations"][obskeys[i]], "weight") || madsdata["Observations"][obskeys[i]]["weight"] > 0
				push!(tobs, time)
				push!(obs, madsdata["Observations"][obskeys[i]]["target"])
			else
				skipnext = !isa(time, Real)#skip plotting the model prediction is "time" is not a number and the weight is zero
			end
			if !skipnext
				push!(tress, time)
				push!(ress, result[obskeys[i]])
			end
		end
		if time_missing
			madswarn("Some of the observations do not have `time` field specified!")
		end
		if length(tress) + length(tobs) == 0
			madswarn("No data to plot")
		end
		pl = Gadfly.plot(Gadfly.Guide.title(title), Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
					Gadfly.layer(x=tress, y=ress, Gadfly.Geom.line, Gadfly.Theme(default_color=parse(Colors.Colorant, "blue"), line_width=linewidth)),
					Gadfly.layer(x=tobs, y=obs, Gadfly.Geom.point, Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), point_size=4Gadfly.pt, highlight_width=0Gadfly.pt)))
		didplot = true
		vsize += 4Gadfly.inch
	end
	if !separate_files
		if filename == ""
			filename = "$rootname-match"
		end
		filename, format = setplotfileformat(filename, format)
		if format != "SVG"
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, hsize, vsize; dpi=dpi), pl)
		else
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, hsize, vsize), pl)
		end
		if typeof(pl) == Gadfly.Plot{}
			pl
		else
			display && Mads.display(filename)
		end
	end
end

@doc """
Plot the matches between model predictions and observations

$(DocumentFunction.documentfunction(plotmatches;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "rx"=>"regular expression to filter the outputs",
            "result"=>"dictionary with model predictions",
            "dict_in"=>"dictionary with model parameters"),
keytext=Dict("plotdata"=>"plot data (if `false` model predictions are ploted only) [default=`true`]",
            "format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "filename"=>"output file name",
            "title"=>"graph title",
            "xtitle"=>"x-axis title [default=`\"Time\"`]",
            "ytitle"=>"y-axis title [default=`\"y\"`]",
            "key2time"=>"user provided function to convert observation keys to observation times",
            "separate_files"=>"plot data for multiple wells separately [default=`false`]",
            "hsize"=>"graph horizontal size [default=`6Gadfly.inch`]",
            "vsize"=>"graph vertical size [default=`4Gadfly.inch`]",
            "linewidth"=>"line width [default=`2Gadfly.pt`]",
            "pointsize"=>"data dot size [default=`4Gadfly.pt`]",
            "obs_plot_dots"=>"plot data as dots or line [default=`true`]",
            "noise"=>"random noise magnitude [default=`0`; no noise]",
            "dpi"=>"graph resolution [default=`Mads.dpi`]",
            "colors"=>"array with plot colors",
            "display"=>"display plots [default=`false`]")))

Dumps:

- plot of the matches between model predictions and observations

Examples:

```julia
Mads.plotmatches(madsdata; filename="", format="")
Mads.plotmatches(madsdata, dict_in; filename="", format="")
Mads.plotmatches(madsdata, result; filename="", format="")
Mads.plotmatches(madsdata, result, r"NO3"; filename="", format="")
```
""" plotmatches

"""
Create histogram/scatter plots of model parameter samples

$(DocumentFunction.documentfunction(scatterplotsamples;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "samples"=>"matrix with model parameters",
            "filename"=>"output file name"),
keytext=Dict("format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "pointsize"=>"point size [default=`0.9Gadfly.mm`]")))

Dumps:

- histogram/scatter plots of model parameter samples
"""
function scatterplotsamples(madsdata::Associative, samples::Matrix, filename::String; format::String="", pointsize::Measures.Length{:mm,Float64}=0.9Gadfly.mm)
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	cs = Array{Compose.Context}(size(samples, 2), size(samples, 2))
	for i in 1:size(samples, 2)
		for j in 1:size(samples, 2)
			if i == j
				cs[i, j] = Gadfly.render(Gadfly.plot(x=samples[:, i], Gadfly.Geom.histogram,
					Gadfly.Guide.XLabel(plotlabels[i]),
					Gadfly.Theme(major_label_font_size=24Gadfly.pt, minor_label_font_size=12Gadfly.pt)
					))
			else
				cs[j, i] = Gadfly.render(Gadfly.plot(x=samples[:, i], y=samples[:, j],
					Gadfly.Guide.XLabel(plotlabels[i]), Gadfly.Guide.YLabel(plotlabels[j]),
					Gadfly.Theme(major_label_font_size=24Gadfly.pt, minor_label_font_size=12Gadfly.pt, point_size=pointsize)
					))
			end
		end
	end
	hsize = (3 * size(samples, 2))Gadfly.inch
	vsize = (3 * size(samples, 2))Gadfly.inch
	filename, format = setplotfileformat(filename, format)
	try
		pl = Compose.gridstack(cs)
		Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize, vsize), pl)
		if typeof(pl) == Gadfly.Plot{}
			pl
		end
	catch e
		printerrormsg(e)
		Mads.madswarn("Scatterplotsamples: Gadfly fails!")
	end
end

function plotwellSAresults(madsdata::Associative, result; xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", filename::String="", format::String="")
	if !haskey(madsdata, "Wells")
		Mads.madswarn("There is no 'Wells' data in the MADS input dataset")
		return
	end
	for wellname in keys(madsdata["Wells"])
		if madsdata["Wells"][wellname]["on"]
			plotwellSAresults(madsdata, result, wellname; xtitle = xtitle, ytitle = ytitle, filename = filename, format = format)
		end
	end
end
function plotwellSAresults(madsdata::Associative, result, wellname; xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", filename::String="", format::String="")
	if !haskey(madsdata, "Wells")
		Mads.madswarn("There is no 'Wells' class in the MADS input dataset")
		return
	end
	if !haskey(madsdata["Wells"], wellname)
		Mads.madswarn("There is no well with name $wellname in 'Wells' class of the MADS input dataset")
		return
	end
	o = madsdata["Wells"][wellname]["obs"]
	nsample = result["samplesize"]
	paramkeys = getoptparamkeys(madsdata)
	nP = length(paramkeys)
	nT = length(o)
	d = Array{Float64}(2, nT)
	mes = Array{Float64}(nP, nT)
	tes = Array{Float64}(nP, nT)
	var = Array{Float64}(nP, nT)
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
	dfc = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="concentration")
	pp = Array{Any}(0)
	pc = Gadfly.plot(dfc, x="x", y="y", Gadfly.Geom.point, Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle))
	push!(pp, pc)
	vsize = 4Gadfly.inch
	df = Array{Any}(nP)
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
	vdf = vcat(df...)
	if length(vdf[1]) > 0
		ptes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel("Total Effect"), Gadfly.Theme(key_position = :top) )
		push!(pp, ptes)
		vsize += 4Gadfly.inch
	end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
	vdf = vcat(df...)
	if length(vdf[1]) > 0
		pmes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel("Main Effect"), Gadfly.Theme(key_position = :none))
		push!(pp, pmes)
		vsize += 4Gadfly.inch
	end
	j = 1
	for paramkey in paramkeys
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(var[j,:]), parameter="$paramkey")
		deleteNaN!(df[j])
		j += 1
	end
	vdf = vcat(df...)
	if length(vdf[1]) > 0
		pvar = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel("Output Variance"), Gadfly.Theme(key_position = :none) )
		push!(pp, pvar)
		vsize += 4Gadfly.inch
	end
	p = Gadfly.vstack(pp...)
	rootname = getmadsrootname(madsdata)
	method = result["method"]
	if filename == ""
		filename = "$rootname-$wellname-$method-$nsample"
	end
	filename, format = setplotfileformat(filename, format)
	Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, vsize), p)
	if typeof(p) == Gadfly.Plot{}
		p
	end
end

@doc """
Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

$(DocumentFunction.documentfunction(plotwellSAresults;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "result"=>"sensitivity analysis results",
            "wellname"=>"well name"),
keytext=Dict("xtitle"=>"x-axis title [default=`\"Time \[years\]\"`]",
            "ytitle"=>"y-axis title [default=`\"Concentration \[ppb\]\"`]",
            "filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]")))

Dumps:

- Plot of the sensitivity analysis results for all the wells in the MADS problem dictionary
""" plotwellSAresults

"""
Plot the sensitivity analysis results for the observations

$(DocumentFunction.documentfunction(plotobsSAresults;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "result"=>"sensitivity analysis results"),
keytext=Dict("filter"=>"string or regex to plot only observations containing `filter`",
            "keyword"=>"to be added in the auto-generated filename",
            "filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "debug"=>"[default=`false`]",
            "separate_files"=>"plot data for multiple wells separately [default=`false`]",
            "xtitle"=>"x-axis title [default=`\"Time \[years\]\"`]",
            "ytitle"=>"y-axis title [default=`\"Concentration \[ppb\]\"`]",
            "linewidth"=>"line width [default=`2Gadfly.pt`]",
            "pointsize"=>"point size [default=`2Gadfly.pt`]")))

Dumps:

- plot of the sensitivity analysis results for the observations
"""
function plotobsSAresults(madsdata::Associative, result::Associative; filter::Union{String,Regex}="", keyword::String="", filename::String="", format::String="", debug::Bool=false, separate_files::Bool=false, xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt)
	if !haskey(madsdata, "Observations")
		Mads.madswarn("There is no 'Observations' class in the MADS input dataset")
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
	obskeys = Mads.filterkeys(obsdict, filter)
	nT = length(obskeys)
	d = Array{Float64}(2, nT)
	mes = Array{Float64}(nP, nT)
	tes = Array{Float64}(nP, nT)
	var = Array{Float64}(nP, nT)
	i = 1
	for obskey in obskeys
		d[1,i] = obsdict[obskey]["time"]
		d[2,i] = haskey(obsdict[obskey], "target") ? obsdict[obskey]["target"] : NaN
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
	dfc = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(d[2,:]), parameter="Observations")
	pp = Array{Any}(0)
	pd = Gadfly.plot(dfc, x="x", y="y", Gadfly.Geom.line, Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle) )
	push!(pp, pd)
	if debug
		# println(dfc)
		println("DAT xmax $(max(dfc[1]...)) xmin $(min(dfc[1]...)) ymax $(max(dfc[2]...)) ymin $(min(dfc[2]...))")
		# writetable("dfc.dat", dfc)
	end
	# vsize = 4Gadfly.inch
	vsize = 0Gadfly.inch
	###################################################### TES
	df = Array{Any}(nP)
	for j in 1:length(plotlabels)
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(tes[j,:]), parameter="$(plotlabels[j])")
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
			Mads.madswarn("TES values larger than $(realmax(Float32))")
			maxtorealmax!(vdf)
			println("TES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		ptes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
				Gadfly.Theme(line_width=linewidth, point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
				Gadfly.Coord.Cartesian(ymin=0, ymax=1),
				# Gadfly.Scale.y_continuous(minvalue=0, maxvalue=1),
				Gadfly.Guide.XLabel(xtitle),
				Gadfly.Guide.YLabel("Total Effect") ) # only none and default works
		push!(pp, ptes)
		vsize += 4Gadfly.inch
	end
	###################################################### MES
	for j in 1:length(plotlabels)
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(mes[j,:]), parameter="$(plotlabels[j])")
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
			Mads.madswarn("MES values larger than $(realmax(Float32))")
			maxtorealmax!(vdf)
			println("MES xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		pmes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
				Gadfly.Theme(line_width=linewidth, point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
				Gadfly.Coord.Cartesian(ymin=0, ymax=1),
				# Gadfly.Scale.y_continuous(minvalue=0, maxvalue=1),
				Gadfly.Guide.XLabel(xtitle),
				Gadfly.Guide.YLabel("Main Effect") ) # only none and default works: , Theme(key_position = :none)
		push!(pp, pmes)
		vsize += 4Gadfly.inch
	end
	###################################################### VAR
	for j in 1:length(plotlabels)
		df[j] = DataFrames.DataFrame(x=collect(d[1,:]), y=collect(var[j,:]), parameter="$(plotlabels[j])")
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
			Mads.madswarn("Variance values larger than $(realmax(Float32))")
			maxtorealmax!(vdf)
			println("VAR xmax $(max(vdf[1]...)) xmin $(min(vdf[1]...)) ymax $(max(vdf[2]...)) ymin $(min(vdf[2]...))")
		end
		pvar = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter",
			Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
			Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel("Output Variance") ) # only none and default works: , Theme(key_position = :none)
		push!(pp, pvar)
		vsize += 4Gadfly.inch
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
		filename, format = setplotfileformat(filename, format)
		p = Gadfly.vstack(pp...)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, vsize ), p)
		if typeof(p) == Gadfly.Plot{}
			p
		end
	else
		filename_root = Mads.getrootname(filename)
		filename_ext = Mads.getextension(filename)
		filename = filename_root * "-total_effect." * filename_ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), ptes)
		filename = filename_root * "-main_effect." * filename_ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, 4Gadfly.inch), pmes)
	end
end

function spaghettiplots(madsdata::Associative, number_of_samples::Integer; format::String="", keyword::String="", xtitle::String="X", ytitle::String="Y", obs_plot_dots::Bool=true, seed::Integer=0, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplots(madsdata::Associative, paramvalues; format=format, keyword=keyword, xtitle=xtitle, ytitle=ytitle, obs_plot_dots=obs_plot_dots, seed=seed, linewidth=linewidth, pointsize=pointsize)
end
function spaghettiplots(madsdata::Associative, paramdictarray::DataStructures.OrderedDict; format::String="", keyword::String="", xtitle::String="X", ytitle::String="Y", obs_plot_dots::Bool=true, seed::Integer=0, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt)
	Mads.setseed(seed)
	rootname = getmadsrootname(madsdata)
	func = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	paramdict = DataStructures.OrderedDict{String,Float64}(zip(paramkeys, getparamsinit(madsdata)))
	paramoptkeys = getoptparamkeys(madsdata)
	numberofsamples = length(paramdictarray[paramoptkeys[1]])
	obskeys = Mads.getobskeys(madsdata)
	obs_plot = Any[]
	if obs_plot_dots
		push!(obs_plot, Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), point_size=pointsize))
		push!(obs_plot, Gadfly.Geom.point)
	else
		push!(obs_plot, Gadfly.Theme(default_color=parse(Colors.Colorant, "black"), line_width=linewidth))
		push!(obs_plot, Gadfly.Geom.line)
	end
	nT = length(obskeys)
	if !haskey( madsdata, "Wells" )
		t = Array{Float64}(nT)
		d = Array{Float64}(nT)
		for i in 1:nT
			if haskey( madsdata["Observations"][obskeys[i]], "time")
				t[i] = madsdata["Observations"][obskeys[i]]["time"]
			else
				madswarn("Observation time is missing for observation $(obskeys[i])!")
				t[i] = 0
			end
			if haskey( madsdata["Observations"][obskeys[i]], "target")
				d[i] = madsdata["Observations"][obskeys[i]]["target"]
			else
				d[i] = 0
			end
		end
	end
	vsize = 0Gadfly.inch
	Mads.madsoutput("Spaghetti plots for each selected model parameter (type != null) ...\n")
	for paramkey in paramoptkeys
		Mads.madsoutput("Parameter: $paramkey ...\n")
		Y = Array{Float64}(nT, numberofsamples)
		@ProgressMeter.showprogress 4 "Computing ..." for i in 1:numberofsamples
			original = paramdict[paramkey]
			paramdict[paramkey] = paramdictarray[paramkey][i]
			result = func(paramdict)
			for j in 1:nT
				Y[j,i] = result[obskeys[j]]
			end
			paramdict[paramkey] = original
		end
		if !haskey( madsdata, "Wells" )
			pl = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
					Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
					[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
					Gadfly.Theme(default_color=parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][(i-1)%6+1])))
					for i in 1:numberofsamples]...)
			vsize = 4Gadfly.inch
		else
			pp = Array{Gadfly.Plot}(0)
			p = Gadfly.Plot{}
			vsize = 0Gadfly.inch
			startj = 1
			endj  = 0
			for wellname in keys(madsdata["Wells"])
				if madsdata["Wells"][wellname]["on"]
					o = madsdata["Wells"][wellname]["obs"]
					nTw = length(o)
					t = Array{Float64}(nTw)
					d = Array{Float64}(nTw)
					for i in 1:nTw
						t[i] = o[i]["t"]
						if haskey(o[i], "c")
							d[i] = o[i]["c"]
						elseif haskey(o[i], "target")
							d[i] = o[i]["target"]
						else
							madswarn("Observation/calibration data are missing for well $(wellname)!")
							t[i] = 0
							d[i] = 0
						end
					end
					endj += nTw
					p = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
							Gadfly.Guide.title(wellname),
							Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
							[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
							Gadfly.Theme(default_color=parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][(i-1)%6+1])))
							for i in 1:numberofsamples]...)
					push!(pp, p)
					vsize += 4Gadfly.inch
					startj = endj + 1
				end
			end
			pl = length(pp) > 1 ? Gadfly.vstack(pp...) : p
		end
		if keyword == ""
			filename = string("$rootname-$paramkey-$numberofsamples-spaghetti")
		else
			filename = string("$rootname-$keyword-$paramkey-$numberofsamples-spaghetti")
		end
		filename, format = setplotfileformat(filename, format)
		try
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 6Gadfly.inch, vsize), pl)
		catch e
			printerrormsg(e)
			Mads.madswarn("Spaghettiplots: Gadfly fails!")
		end
	end
end

@doc """
Generate separate spaghetti plots for each `selected` (`type != null`) model parameter

$(DocumentFunction.documentfunction(spaghettiplots;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "number_of_samples"=>"number of samples",
            "paramdictarray"=>"parameter dictionary containing the data arrays to be plotted"),
keytext=Dict("format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "keyword"=>"keyword to be added in the file name used to output the produced plots",
            "xtitle"=>"`x` axis title [default=`X`]",
            "ytitle"=>"`y` axis title [default=`Y`]",
            "obs_plot_dots"=>"plot observation as dots (`true` (default) or `false`)",
            "seed"=>"random seed [default=`0`]",
            "linewidth"=>"width of the lines on the plot [default=`2Gadfly.pt`]",
            "pointsize"=>"size of the markers on the plot [default=`4Gadfly.pt`]")))

Dumps:

- A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```
""" spaghettiplots

function spaghettiplot(madsdata::Associative, number_of_samples::Integer; plotdata::Bool=true, filename::String="", keyword::String="", format::String="", xtitle::String="X", ytitle::String="Y", yfit::Bool=false, obs_plot_dots::Bool=true, seed::Integer=0, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplot(madsdata::Associative, paramvalues; plotdata=plotdata, format=format, filename=filename, keyword=keyword, xtitle=xtitle, ytitle=ytitle, yfit=yfit, obs_plot_dots=obs_plot_dots, seed=seed, linewidth=linewidth, pointsize=pointsize)
end
function spaghettiplot(madsdata::Associative, dictarray::Associative; plotdata::Bool=true, filename::String="", keyword::String="", format::String="", xtitle::String="X", ytitle::String="Y", yfit::Bool=false, obs_plot_dots::Bool=true, seed::Integer=0, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt)
	Mads.setseed(seed)
	func = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	paramdict = DataStructures.OrderedDict{String,Float64}(zip(paramkeys, getparamsinit(madsdata)))
	paramoptkeys = getoptparamkeys(madsdata)
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	flag_params = true
	Y = []
	for paramkey in paramoptkeys
		if !haskey(dictarray, paramkey)
			flag_params = false
		end
	end
	if flag_params
		numberofsamples = length(dictarray[paramoptkeys[1]])
		Y = Array{Float64}(nT, numberofsamples)
		@ProgressMeter.showprogress 4 "Computing ..." for i in 1:numberofsamples
			for paramkey in paramoptkeys
				paramdict[paramkey] = dictarray[paramkey][i]
			end
			result = func(paramdict)
			for j in 1:nT
				Y[j,i] = result[obskeys[j]]
			end
		end
	else
		numberofsamples = length(dictarray)
		Y = hcat(map(i->collect(values(o[i])), 1:numberofsamples)...)'
		if size(Y)[2] != nT
			madswarn("Number of observations does not match!")
			return
		end
	end
	spaghettiplot(madsdata::Associative, Y; plotdata=plotdata, format=format, filename=filename, keyword=keyword, xtitle=xtitle, ytitle=ytitle, yfit=yfit, obs_plot_dots=obs_plot_dots, seed=seed, linewidth=linewidth, pointsize=pointsize)
end
function spaghettiplot(madsdata::Associative, array::Array; plotdata::Bool=true, filename::String="", keyword::String="", format::String="", xtitle::String="X", ytitle::String="Y", yfit::Bool=false, obs_plot_dots::Bool=true, seed::Integer=0, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=4Gadfly.pt)
	madsoutput("Spaghetti plots for all the selected model parameter (type != null) ...\n")
	rootname = getmadsrootname(madsdata)
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	s = size(array)
	if length(s) > 2
		madswarn("Incorrect array size: size(Y) = $(size(Y))")
		return
	end
	Y = []
	if s[1] == nT
		Y = array
		numberofsamples = s[2]
	elseif length(s) == 2 && s[2] == nT
		Y = array'
		numberofsamples = s[1]
	elseif length(s) == 1
		numberofsamples = s[1]
		Y = hcat(map(i->collect(values(array[i])), 1:numberofsamples)...)
		if size(Y)[1] != nT
			madswarn("Incorrect array size: size(array) = $(s) => size(Y) = $(size(Y))")
			return
		end
	else
		madswarn("Incorrect array size: size(array) = $(s)")
		return
	end
	obs_plot = Any[]
	if plotdata
		if obs_plot_dots
			push!(obs_plot, Gadfly.Theme(default_color=parse(Colors.Colorant, "red"), point_size=pointsize))
			push!(obs_plot, Gadfly.Geom.point)
		else
			push!(obs_plot, Gadfly.Theme(default_color=parse(Colors.Colorant, "black"), line_width=linewidth))
			push!(obs_plot, Gadfly.Geom.line)
		end
	end
	pa = Any[]
	if yfit
		ymin = minimum(Y, 2)
		ymax = maximum(Y, 2)
		push!(pa, Gadfly.Coord.Cartesian(xmin=ymin, xmax=ymax))
	end
	if !haskey(madsdata, "Wells")
		if plotdata
			t = getobstime(madsdata)
			d = getobstarget(madsdata)
			push!(pa, Gadfly.layer(x=t, y=d, obs_plot...))
		end
		pl = Gadfly.plot(pa...,
			Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
			[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
			Gadfly.Theme(default_color=parse(Colors.Colorant, ["red", "blue", "green", "cyan", "magenta", "yellow"][i%6+1])))
			for i in 1:numberofsamples]... )
		vsize = 4Gadfly.inch
	else
		pp = Array{Gadfly.Plot}(0)
		p = Gadfly.Plot{}
		vsize = 0Gadfly.inch
		startj = 1
		endj  = 0
		for wellname in keys(madsdata["Wells"])
			if madsdata["Wells"][wellname]["on"]
				o = madsdata["Wells"][wellname]["obs"]
				nTw = length(o)
				if plotdata
					t = Array{Float64}(nTw)
					d = Array{Float64}(nTw)
					for i in 1:nTw
						t[i] = o[i]["t"]
						if haskey(o[i], "c")
							d[i] = o[i]["c"]
						elseif haskey(o[i], "target")
							d[i] = o[i]["target"]
						else
							madswarn("Observation/calibration data are missing for well $(wellname)!")
							t[i] = 0
							d[i] = 0
						end
					end
					push!(pa, Gadfly.layer(x=t, y=d, obs_plot...))
				end
				endj += nTw
				p = Gadfly.plot(pa...,
						Gadfly.Guide.title(wellname),
						Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
						[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
						Gadfly.Theme(default_color=parse(Colors.Colorant, ["red", "blue", "green", "cyan", "magenta", "yellow"][i%6+1])))
						for i in 1:numberofsamples]...)
				push!(pp, p)
				vsize += 4Gadfly.inch
				startj = endj + 1
			end
		end
		pl = length(pp) > 1 ? Gadfly.vstack(pp...) : p
	end
	if filename == ""
		if keyword == ""
			filename = "$rootname-$numberofsamples-spaghetti"
		else
			filename = "$rootname-$keyword-$numberofsamples-spaghetti"
		end
	end
	filename, format = setplotfileformat(filename, format)
	try
		Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, 6Gadfly.inch, vsize), pl)
	catch e
		printerrormsg(e)
		Mads.madswarn("Spaghettiplot: Gadfly fails!")
	end
	if typeof(pl) == Gadfly.Plot{}
		pl
	end
end

@doc """
Generate a combined spaghetti plot for the `selected` (`type != null`) model parameter

$(DocumentFunction.documentfunction(spaghettiplot;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "number_of_samples"=>"number of samples",
            "dictarray"=>"dictionary array containing the data arrays to be plotted",
            "array"=>"data arrays to be plotted"),
keytext=Dict("plotdata"=>"plot data (if `false` model predictions are plotted only) [default=`true`]",
            "filename"=>"output file name used to output the produced plots",
            "keyword"=>"keyword to be added in the file name used to output the produced plots (if `filename` is not defined)",
            "format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "xtitle"=>"`x` axis title [default=`X`]",
            "ytitle"=>"`y` axis title [default=`Y`]",
            "yfit"=>"fit vertical axis range [default=`false`]",
            "obs_plot_dots"=>"plot observation as dots (`true` [default] or `false`)",
            "seed"=>"random seed [default=`0`]",
            "linewidth"=>"width of the lines in plot [default=`2Gadfly.pt`]",
            "pointsize"=>"size of the markers in plot [default=`4Gadfly.pt`]")))

Dumps:

- Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplot(madsdata, dictarray; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, array; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```
""" spaghettiplot


"""
Create plots of data series

$(DocumentFunction.documentfunction(plotseries;
argtext=Dict("X"=>"matrix with the series data",
            "filename"=>"output file name"),
keytext=Dict("format"=>"output plot format (`png`, `pdf`, etc.) [default=`Mads.graphbackend`]",
            "xtitle"=>"x-axis title [default=`X`]",
            "ytitle"=>"y-axis title [default=`Y`]",
            "title"=>"plot title [default=`Sources`]",
            "name"=>"series name [default=`Sources`]",
            "combined"=>"combine plots [default=`true`]",
            "hsize"=>"horizontal size [default=`6Gadfly.inch`]",
            "vsize"=>"vertical size [default=`4Gadfly.inch`]",
            "linewidth"=>"width of the lines in plot  [default=`2Gadfly.pt`]",
            "dpi"=>"graph resolution [default=`Mads.dpi`]",
            "colors"=>"colors to use in plots")))

Dumps:

- Plots of data series
"""
function plotseries(X::Matrix, filename::String=""; format::String="", xtitle::String = "X", ytitle::String = "Y", title::String="Sources", name::String="Source", combined::Bool=true, hsize::Measures.Length{:mm,Float64}=6Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, dpi::Integer=Mads.dpi, colors::Array{String,1}=Array{String}(0))
	nT = size(X)[1]
	nS = size(X)[2]
	if combined
		hsize_plot = hsize
		vsize_plot = vsize
		ncolors = length(colors)
		@show filename
		if ncolors == 0 || ncolors != nS
			pS = Gadfly.plot([Gadfly.layer(x=1:nT, y=X[:,i],
				Gadfly.Geom.line,
				Gadfly.Theme(line_width=linewidth),
				color = ["$name $i" for j in 1:nT])
				for i in 1:nS]...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				Gadfly.Guide.colorkey(title))
		else
			pS = Gadfly.plot([Gadfly.layer(x=1:nT, y=X[:,i],
				Gadfly.Geom.line,
				Gadfly.Theme(line_width=linewidth, default_color=parse(Colors.Colorant, colors[(i-1)%ncolors+1])))
				for i in 1:nS]...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				Gadfly.Guide.manual_color_key(title, ["$name $i" for i in 1:nS], [colors[(i-1)%ncolors+1] for i in 1:nS]))
		end
	else
		hsize_plot = hsize
		vsize_plot = vsize / 2 * nS
		pp = Array{Gadfly.Plot}(nS)
		for i in 1:nS
			pp[i] = Gadfly.plot(x=1:nT, y=X[:,i], Gadfly.Geom.line, Gadfly.Theme(line_width=linewidth), Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle), Gadfly.Guide.title("$name $i"))
		end
		pS = Gadfly.vstack(pp...)
	end
	try
		if filename != ""
			filename, format = setplotfileformat(filename, format)
			if format == "SVG"
				Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize_plot, vsize_plot), pS)
			else
				Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize_plot, vsize_plot; dpi=dpi), pS)
			end
		end
		if typeof(pS) == Gadfly.Plot{}
			pS
		end
	catch e
		printerrormsg(e)
		Mads.madswarn("Plotseries: Gadfly fails!")
	end
end
