import Colors
import ProgressMeter
import DataFrames
import OrderedCollections
import Gadfly
import Measures
import Cairo
import Compose
import Fontconfig

colors = ["red", "blue", "green", "orange", "magenta", "cyan", "brown", "pink", "lime", "navy", "maroon", "yellow", "olive", "springgreen", "teal", "coral", "#e6beff", "beige", "purple", "#4B6F44", "#9F4576"]
ncolors = length(colors)

"""
Set the default plot format (`SVG` is the default format)

$(DocumentFunction.documentfunction(setdefaultplotformat;
argtext=Dict("format"=>"plot format")))
"""
function setdefaultplotformat(format::String)
	if occursin(r"^PNG|PDF|PS|SVG", uppercase(format))
		global graphbackend = uppercase(format)
	else
		madswarn("Requested format ($format) is not acceptable! (PNG|PDF|PS|SVG)")
	end
end

"""
Set the default plot format (`SVG` is the default format)

$(DocumentFunction.documentfunction(getdefaultplotformat;))
"""
function getdefaultplotformat()
	println("Default plot format: $graphbackend")
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
	if occursin(r"^PNG|^PDF|^PS|^SVG", format)
		if format != extension
			filename = root * "." * lowercase(format)
		end
	elseif format == "EPS"
		if !occursin(r"^EPS|^PS", extension)
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
            "keyword"=>"to be added in the filename")))

Dumps:

- plot of contaminant sources and wells
"""
function plotmadsproblem(madsdata::AbstractDict; format::String="", filename::String="", keyword::String="", hsize=8Gadfly.inch, vsize=4Gadfly.inch, gm=[])
	rectangles = Array{Float64}(undef, 0, 4)
	gadfly_source = Gadfly.Guide.annotation(Compose.compose(Compose.context()))
	dfw = DataFrames.DataFrame(x = Float64[], y = Float64[], label = String[], category = String[])
	if haskey(madsdata, "Sources")
		for i = 1:length(madsdata["Sources"])
			sourcetype = collect(keys(madsdata["Sources"][i]))[1]
			if sourcetype == "box" || sourcetype == "gauss"
				rectangle = Array{Float64}(undef, 4)
				x = madsdata["Sources"][i][sourcetype]["x"]["init"]
				y = madsdata["Sources"][i][sourcetype]["y"]["init"]
				rectangle[1] = x - madsdata["Sources"][i][sourcetype]["dx"]["init"] / 2
				rectangle[2] = y - madsdata["Sources"][i][sourcetype]["dy"]["init"] / 2
				rectangle[3] = madsdata["Sources"][i][sourcetype]["dx"]["init"]
				rectangle[4] = madsdata["Sources"][i][sourcetype]["dy"]["init"]
				rectangles = vcat(rectangles, rectangle')
			end
			push!(dfw, (x, y, "  S$i", "Sources"))
		end
	end
	if sizeof(rectangles) > 0
		gadfly_source = Gadfly.Guide.annotation(Compose.compose(Compose.context(), Compose.rectangle(rectangles[:,1],rectangles[:,2],rectangles[:,3],rectangles[:,4]),
			Compose.fill(Base.parse(Colors.Colorant, "red")),
			Compose.fillopacity(0.2),
			Compose.stroke(Base.parse(Colors.Colorant, "red"))))
	end
	for wellkey in keys(madsdata["Wells"])
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
				push!(dfw, (x, y, "  $wellkey", "Wells"))
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
	p = Gadfly.plot(dfw, x="x", y="y", label="label", color="category",
		Gadfly.Geom.point, Gadfly.Geom.label(position=:right, hide_overlaps=false),
		Gadfly.Guide.XLabel("x [m]"), Gadfly.Guide.YLabel("y [m]"), Gadfly.Guide.yticks(orientation=:vertical),
		gadfly_source,
		Gadfly.Scale.color_discrete_manual("red", "blue"),
		Gadfly.Coord.Cartesian(ymin=ymin, ymax=ymax, xmin=xmin, xmax=xmax, fixed=true),
		Gadfly.Scale.x_continuous(minvalue=xmin, maxvalue=xmax, labels=x -> @Printf.sprintf("%.0f", x)),
		Gadfly.Scale.y_continuous(minvalue=ymin, maxvalue=ymax, labels=y -> @Printf.sprintf("%.0f", y)), gm...,
		Gadfly.Theme(highlight_width = 0Gadfly.pt, key_position = :none))
	if filename == ""
		rootname = getmadsrootname(madsdata)
		filename = "$rootname-problemsetup"
	end
	if keyword != ""
		filename = "$rootname-$keyword-problemsetup"
	end
	if filename != ""
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, hsize, vsize), p)
	end
	if typeof(p) == Gadfly.Plot
		graphoutput && Mads.display(p)
	end
	return nothing
end

function plotmatches(madsdata::AbstractDict, rx::Regex=r""; kw...)
	r = forward(madsdata; all=true)
	if rx != r""
		plotmatches(madsdata, r, rx; kw...)
	else
		plotmatches(madsdata, r; kw...)
	end
end
function plotmatches(madsdata::AbstractDict, result::AbstractDict, rx::Regex; plotdata::Bool=true, filename::String="", format::String="", key2time::Function=k->0., title::String="", xtitle::String="time", ytitle::String="y", ymin=nothing, ymax=nothing, separate_files::Bool=false, hsize::Measures.Length{:mm,Float64}=8Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.imagedpi, colors::Array{String,1}=Mads.colors, display::Bool=false, notitle::Bool=false)
	newobs = empty(madsdata["Observations"])
	newresult = empty(result)
	for k in keys(madsdata["Observations"])
		if occursin(rx, k)
			newobs[k] = copy(madsdata["Observations"][k])
			if !haskey(newobs[k], "time")
				newobs[k]["time"] = key2time(k)
			end
			if !haskey(result, k)
				Mads.madswarn("Observation `$k` is missing!")
			else
				newresult[k] = result[k]
			end
			!notitle && (title = rx.pattern)
		end
	end
	newmadsdata = copy(madsdata)
	newmadsdata["Observations"] = newobs
	if haskey(newmadsdata, "Wells")
		delete!(newmadsdata, "Wells")
	end
	plotmatches(newmadsdata, newresult; plotdata=plotdata, filename=filename, format=format, title=title, xtitle=xtitle, ytitle=ytitle, ymin=ymin, ymax=ymax, separate_files=separate_files, hsize=hsize, vsize=vsize, linewidth=linewidth, pointsize=pointsize, obs_plot_dots=obs_plot_dots, noise=noise, dpi=dpi, colors=Mads.colors, display=display)
end
function plotmatches(madsdata::AbstractDict, dict_in::AbstractDict; plotdata::Bool=true, filename::String="", format::String="", title::String="", xtitle::String="time", ytitle::String="y", ymin=nothing, ymax=nothing, separate_files::Bool=false, hsize::Measures.Length{:mm,Float64}=8Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.imagedpi, colors::Array{String,1}=Mads.colors, display::Bool=true, notitle::Bool=false)
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
	pl = nothing
	if haskey(madsdata, "Wells")
		pp = Array{Gadfly.Plot}(undef, 0)
		p = Gadfly.Plot
		wk = collect(keys(madsdata["Wells"]))
		nW = length(wk)
		if length(colors) == 0 || length(colors) != nW
			colors = Array{String}(undef, nW)
			for iw = 1:nW
				colors[iw] = "blue"
			end
		end
		for iw = 1:nW
			wellname = wk[iw]
			if madsdata["Wells"][wellname]["on"]
				c = Array{Float64}(undef, 0)
				tc = Array{Float64}(undef, 0)
				d = Array{Float64}(undef, 0)
				td = Array{Float64}(undef, 0)
				if haskey(madsdata["Wells"][wellname], "obs") && madsdata["Wells"][wellname]["obs"] != nothing
					o = madsdata["Wells"][wellname]["obs"]
					nT = length(o)
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
				end
				if noise != 0
					c = c .+ (rand(nT) .* noise)
				end
				npp = length(c)
				if npp == 0
					Mads.madswarn("Well $wellname: no observations to plot!")
					continue
				end
				plot_args = Any[]
				!notitle && push!(plot_args, Gadfly.Guide.title(wellname))
				if plotdata
					if obs_plot_dots
						push!(plot_args, Gadfly.layer(x=td, y=d, Gadfly.Geom.point, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), point_size=pointsize)))
					else
						push!(plot_args, Gadfly.layer(x=td, y=d, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), line_width=linewidth)))
					end
				end
				if npp > 1
					push!(plot_args, Gadfly.layer(x=tc, y=c, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[iw]), line_width=linewidth)))
				else npp = 1
					push!(plot_args, Gadfly.layer(x=tc, y=c, Gadfly.Geom.point, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[iw]), point_size=pointsize)))
				end
				push!(plot_args, Gadfly.Coord.Cartesian(ymin=ymin, ymax=ymax))
				p = Gadfly.plot(Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle), plot_args...)
				if separate_files
					if filename == ""
						filename_w = "$rootname-match-$wellname"
					else
						extension = getextension(filename)
						rootfile = getrootname(filename)
						filename_w = "$rootfile-$wellname.$extension"
					end
					filename_w, format = setplotfileformat(filename_w, format)
					if format != "SVG" && format != "PDF"
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
		obs = Array{Float64}(undef, 0)
		tobs = Array{Float64}(undef, 0)
		ress = Array{Float64}(undef, 0)
		tress = Array{Float64}(undef, 0)
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
		pl = Gadfly.plot(Gadfly.Guide.title(title), Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle), Gadfly.Coord.Cartesian(ymin=ymin, ymax=ymax),
					Gadfly.layer(x=tress, y=ress, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "blue"), line_width=linewidth)),
					Gadfly.layer(x=tobs, y=obs, Gadfly.Geom.point, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), point_size=2Gadfly.pt, highlight_width=0Gadfly.pt)))
	end
	if pl == nothing
		Mads.madswarn("There is nothing to plot!")
		return nothing
	end
	if !separate_files
		if filename == ""
			filename = "$rootname-match"
		end
		filename, format = setplotfileformat(filename, format)
		if format != "SVG" && format != "PDF"
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, hsize, vsize; dpi=dpi), pl)
		else
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, hsize, vsize), pl)
		end
		if typeof(pl) == Gadfly.Plot
			display && Mads.display(pl)
		else
			display && Mads.display(filename)
		end
	end
	return nothing
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
            "hsize"=>"graph horizontal size [default=`8Gadfly.inch`]",
            "vsize"=>"graph vertical size [default=`4Gadfly.inch`]",
            "linewidth"=>"line width [default=`2Gadfly.pt`]",
            "pointsize"=>"data dot size [default=`2Gadfly.pt`]",
            "obs_plot_dots"=>"plot data as dots or line [default=`true`]",
            "noise"=>"random noise magnitude [default=`0`; no noise]",
            "dpi"=>"graph resolution [default=`Mads.imagedpi`]",
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
function scatterplotsamples(madsdata::AbstractDict, samples::Matrix, filename::String; format::String="", pointsize::Measures.Length{:mm,Float64}=0.9Gadfly.mm)
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamsplotname(madsdata, paramkeys)
	if plotlabels[1] == ""
		plotlabels = paramkeys
	end
	cs = Array{Compose.Context}(undef, size(samples, 2), size(samples, 2))
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
	hsize = (6 * size(samples, 2))Gadfly.inch
	vsize = (6 * size(samples, 2))Gadfly.inch
	filename, format = setplotfileformat(filename, format)
	try
		pl = Compose.gridstack(cs)
		Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize, vsize), pl)
	catch errmsg
		printerrormsg(errmsg)
		Mads.madswarn("Scatterplotsamples: Gadfly fails!")
	end
	return nothing
end

function plotwellSAresults(madsdata::AbstractDict, result::AbstractDict; xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", filename::String="", format::String="")
	if !haskey(madsdata, "Wells")
		Mads.madswarn("There is no 'Wells' data in the MADS input dataset")
	else
		for wellname in keys(madsdata["Wells"])
			if madsdata["Wells"][wellname]["on"]
				plotwellSAresults(madsdata, result, wellname; xtitle = xtitle, ytitle = ytitle, filename = filename, format = format)
			end
		end
	end
end
function plotwellSAresults(madsdata::AbstractDict, result::AbstractDict, wellname::String; xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", filename::String="", format::String="")
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
	d = Array{Float64}(undef, 2, nT)
	mes = Array{Float64}(undef, nP, nT)
	tes = Array{Float64}(undef, nP, nT)
	var = Array{Float64}(undef, nP, nT)
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
	pp = Array{Any}(undef, 0)
	pc = Gadfly.plot(dfc, x="x", y="y", Gadfly.Geom.point, Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle))
	push!(pp, pc)
	vsize = 4Gadfly.inch
	df = Array{Any}(undef, nP)
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
	Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 8Gadfly.inch, vsize), p)
	if typeof(p) == Gadfly.Plot
		graphoutput && Mads.display(p)
	end
	return nothing
end

@doc """
Plot the sensitivity analysis results for all the wells in the MADS problem dictionary (wells class expected)

$(DocumentFunction.documentfunction(plotwellSAresults;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "result"=>"sensitivity analysis results",
            "wellname"=>"well name"),
keytext=Dict("xtitle"=>"x-axis title",
            "ytitle"=>"y-axis title",
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
            "xtitle"=>"x-axis title",
            "ytitle"=>"y-axis title",
            "linewidth"=>"line width [default=`2Gadfly.pt`]",
            "pointsize"=>"point size [default=`2Gadfly.pt`]")))

Dumps:

- plot of the sensitivity analysis results for the observations
"""
function plotobsSAresults(madsdata::AbstractDict, result::AbstractDict; filter::Union{String,Regex}="", keyword::String="", filename::String="", format::String="", debug::Bool=false, separate_files::Bool=false, xtitle::String="Time [years]", ytitle::String="Concentration [ppb]", linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt)
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
	d = Array{Float64}(undef, 2, nT)
	mes = Array{Float64}(undef, nP, nT)
	tes = Array{Float64}(undef, nP, nT)
	var = Array{Float64}(undef, nP, nT)
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
	pp = Array{Any}(undef, 0)
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
	df = Array{Any}(undef, nP)
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
		if max(vdf[2]...) > floatmax(Float32)
			Mads.madswarn("TES values larger than $(floatmax(Float32))")
			maxtofloatmax!(vdf)
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
		if max(vdf[2]...) > floatmax(Float32)
			Mads.madswarn("MES values larger than $(floatmax(Float32))")
			maxtofloatmax!(vdf)
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
		if max(vdf[2]...) > floatmax(Float32)
			Mads.madswarn("Variance values larger than $(floatmax(Float32))")
			maxtofloatmax!(vdf)
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
		filename = keyword != "" ? "$rootname-$method-$keyword-$nsample" : "$rootname-$method-$nsample"
	end
	if !separate_files
		filename, format = setplotfileformat(filename, format)
		p = Gadfly.vstack(pp...)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 8Gadfly.inch, vsize ), p)
		if typeof(p) == Gadfly.Plot
			graphoutput && Mads.display(p)
		end
	else
		filename_root = Mads.getrootname(filename)
		filename_ext = Mads.getextension(filename)
		filename = filename_root * "-total_effect." * filename_ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 8Gadfly.inch, 4Gadfly.inch), ptes)
		filename = filename_root * "-main_effect." * filename_ext
		filename, format = setplotfileformat(filename, format)
		Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 8Gadfly.inch, 4Gadfly.inch), pmes)
	end
	return nothing
end

function spaghettiplots(madsdata::AbstractDict, number_of_samples::Integer; seed::Integer=-1, kw...)
	Mads.setseed(seed)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplots(madsdata::AbstractDict, paramvalues; kw...)
end
function spaghettiplots(madsdata::AbstractDict, paramdictarray::OrderedCollections.OrderedDict; format::String="", keyword::String="", xtitle::String="X", ytitle::String="Y", obs_plot_dots::Bool=true, seed::Integer=-1, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt, grayscale::Bool=false)
	Mads.setseed(seed)
	rootname = getmadsrootname(madsdata)
	func = makemadscommandfunction(madsdata; calczeroweightobs=true)
	paramkeys = getparamkeys(madsdata)
	paramdict = OrderedCollections.OrderedDict{String,Float64}(zip(paramkeys, getparamsinit(madsdata)))
	paramoptkeys = getoptparamkeys(madsdata)
	numberofsamples = length(paramdictarray[paramoptkeys[1]])
	obskeys = Mads.getobskeys(madsdata)
	obs_plot = Any[]
	if obs_plot_dots
		push!(obs_plot, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), point_size=pointsize))
		push!(obs_plot, Gadfly.Geom.point)
	else
		push!(obs_plot, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "black"), line_width=linewidth))
		push!(obs_plot, Gadfly.Geom.line)
	end
	nT = length(obskeys)
	if !haskey( madsdata, "Wells" )
		t = Array{Float64}(undef, nT)
		d = Array{Float64}(undef, nT)
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
		Y = Array{Float64}(undef, nT, numberofsamples)
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
			if grayscale
				pl = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
					Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
					[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
					Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
					for i in 1:numberofsamples]...)
			else
				pl = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
					Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
					[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
					Gadfly.Theme(default_color=Base.parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][(i-1)%6+1])))
					for i in 1:numberofsamples]...)
			end
			vsize = 4Gadfly.inch
		else
			pp = Array{Gadfly.Plot}(undef, 0)
			p = Gadfly.Plot
			vsize = 0Gadfly.inch
			startj = 1
			endj  = 0
			for wellname in keys(madsdata["Wells"])
				if madsdata["Wells"][wellname]["on"]
					o = madsdata["Wells"][wellname]["obs"]
					nTw = length(o)
					t = Array{Float64}(undef, nTw)
					d = Array{Float64}(undef, nTw)
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
					if grayscale
						p = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
							Gadfly.Guide.title(wellname),
							Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
							[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
							Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
							for i in 1:numberofsamples]...)
					else
						p = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
							Gadfly.Guide.title(wellname),
							Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
							[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
							Gadfly.Theme(default_color=Base.parse(Colors.Colorant, ["red" "blue" "green" "cyan" "magenta" "yellow"][(i-1)%6+1])))
							for i in 1:numberofsamples]...)
					end
					push!(pp, p)
					vsize += 4Gadfly.inch
					startj = endj + 1
				end
			end
			pl = length(pp) > 1 ? Gadfly.vstack(pp...) : p
		end
		filename = keyword == "" ? string("$rootname-$paramkey-$numberofsamples-spaghetti") : string("$rootname-$keyword-$paramkey-$numberofsamples-spaghetti")
		filename, format = setplotfileformat(filename, format)
		try
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 8Gadfly.inch, vsize), pl)
			if typeof(pl) == Gadfly.Plot
				graphoutput && Mads.display(pl)
			end
		catch errmsg
			printerrormsg(errmsg)
			Mads.madswarn("Spaghettiplots: Gadfly fails!")
		end
	end
	return nothing
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
            "pointsize"=>"size of the markers on the plot [default=`2Gadfly.pt`]")))

Dumps:

- A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle="Y", obs_plot_dots=true)
```
""" spaghettiplots

function spaghettiplot(madsdata::AbstractDict, number_of_samples::Integer; kw...)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplot(madsdata::AbstractDict, paramvalues; kw...)
end
function spaghettiplot(madsdata::AbstractDict, dictarray::AbstractDict; seed::Integer=-1, kw...)
	Mads.setseed(seed)
	func = makemadscommandfunction(madsdata)
	paramkeys = getparamkeys(madsdata)
	paramdict = OrderedCollections.OrderedDict{String,Float64}(zip(paramkeys, getparamsinit(madsdata)))
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
		Y = Array{Float64}(undef, nT, numberofsamples)
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
	spaghettiplot(madsdata::AbstractDict, Y; kw...)
end
function spaghettiplot(madsdata::AbstractDict, array::Array; plotdata::Bool=true, filename::String="", keyword::String="", format::String="", xtitle::String="X", ytitle::String="Y", yfit::Bool=false, obs_plot_dots::Bool=true, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=2Gadfly.pt, grayscale::Bool=false, xmin=nothing, xmax=nothing, ymin=nothing, ymax=nothing)
	madsinfo("Spaghetti plots for all the selected model parameter (type != null) ...\n")
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
			push!(obs_plot, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), point_size=pointsize, highlight_width=0Gadfly.pt))
			push!(obs_plot, Gadfly.Geom.point)
		else
			push!(obs_plot, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "black"), line_width=linewidth))
			push!(obs_plot, Gadfly.Geom.line)
		end
	end
	pa = Any[]
	if yfit
		ymin = minimum(Y, 2)
		ymax = maximum(Y, 2)
	end
	push!(pa, Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax))
	if !haskey(madsdata, "Wells")
		if plotdata
			t = getobstime(madsdata)
			d = getobstarget(madsdata)
			push!(pa, Gadfly.layer(x=t, y=d, obs_plot...))
		end
		if grayscale
			pl = Gadfly.plot(pa...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
				Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
				for i in 1:numberofsamples]... )
		else
			pl = Gadfly.plot(pa...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
				Gadfly.Theme(default_color=Base.parse(Colors.Colorant, ["red", "blue", "green", "cyan", "magenta", "yellow"][i%6+1])))
				for i in 1:numberofsamples]... )
		end
		vsize = 4Gadfly.inch
	else
		pp = Array{Gadfly.Plot}(undef, 0)
		p = Gadfly.Plot
		vsize = 0Gadfly.inch
		startj = 1
		endj  = 0
		for wellname in keys(madsdata["Wells"])
			if madsdata["Wells"][wellname]["on"]
				o = madsdata["Wells"][wellname]["obs"]
				nTw = length(o)
				if plotdata
					t = Array{Float64}(undef, nTw)
					d = Array{Float64}(undef, nTw)
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
				if grayscale
					p = Gadfly.plot(pa...,
						Gadfly.Guide.title(wellname),
						Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
						[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
						Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
						for i in 1:numberofsamples]...)
				else
					p = Gadfly.plot(pa...,
						Gadfly.Guide.title(wellname),
						Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
						[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
						Gadfly.Theme(default_color=Base.parse(Colors.Colorant, ["red", "blue", "green", "cyan", "magenta", "yellow"][i%6+1])))
						for i in 1:numberofsamples]...)
				end
				push!(pp, p)
				vsize += 4Gadfly.inch
				startj = endj + 1
				if plotdata
					deleteat!(pa, length(pa))
				end
			end
		end
		pl = length(pp) > 1 ? Gadfly.vstack(pp...) : p
	end
	if filename == ""
		filename = keyword == "" ?  "$rootname-$numberofsamples-spaghetti" : "$rootname-$keyword-$numberofsamples-spaghetti"
	end
	filename, format = setplotfileformat(filename, format)
	try
		Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, 8Gadfly.inch, vsize), pl)
	catch errmsg
		printerrormsg(errmsg)
		Mads.madswarn("Spaghettiplot: Gadfly fails!")
	end
	if typeof(pl) == Gadfly.Plot
		graphoutput && Mads.display(pl)
	end
	return nothing
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
            "pointsize"=>"size of the markers in plot [default=`2Gadfly.pt`]")))

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
            "hsize"=>"horizontal size [default=`8Gadfly.inch`]",
            "vsize"=>"vertical size [default=`4Gadfly.inch`]",
            "linewidth"=>"width of the lines in plot  [default=`2Gadfly.pt`]",
            "dpi"=>"graph resolution [default=`Mads.imagedpi`]",
            "colors"=>"colors to use in plots")))

Dumps:

- Plots of data series
"""
function plotseries(X::AbstractArray, filename::String=""; nT=size(X, 1), nS=size(X, 2), format::String="", xtitle::String = "", ytitle::String = "", title::String="", logx::Bool=false, logy::Bool=false, keytitle::String="", name::String="Signal", names::Array{String,1}=["$name $i" for i in 1:size(X,2)], combined::Bool=true, hsize::Measures.Length{:mm,Float64}=8Gadfly.inch, vsize::Measures.Length{:mm,Float64}=4Gadfly.inch, linewidth::Measures.Length{:mm,Float64}=2Gadfly.pt, pointsize::Measures.Length{:mm,Float64}=1.5Gadfly.pt, key_position=:right, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, dpi::Integer=Mads.imagedpi, colors::Array{String,1}=Mads.colors, opacity::Number=1.0, xmin=nothing, xmax=nothing, ymin=nothing, ymax=nothing, xaxis=1:size(X,1), plotline::Bool=true, code::Bool=false, colorkey::Bool=(nS>ncolors) ? false : true, background_color=nothing, gm::Any=[], gl::Any=[])
	if nT == 0 || nS == 0
		@warn "Input is not a matrix!"
		return
	end
	glog = []
	if logx
		push!(glog, Gadfly.Scale.x_log10)
		if xmin == nothing
			xmin = log10(findfirst(.!isnan.(vec(sumnan(X, 2)))))
		end
		if xmax == nothing
			xmax = log10(findlast(.!isnan.(vec(sumnan(X, 2)))))
		end
	end
	if logy
		push!(glog, Gadfly.Scale.y_log10)
		X[X.<=0] .= NaN
		if ymin == nothing
			ymin = log10(minimumnan(X))
		end
		if ymax == nothing
			ymax = log10(maximumnan(X))
			if ymin != nothing
				dy = (ymax - ymin)/10
				ymin -= dy
				ymax += dy
			end
		end
	end

	geometry = (plotline) ? [Gadfly.Geom.line(), Gadfly.Theme(line_width=linewidth)] : [Gadfly.Theme(point_size=pointsize, highlight_width=0Gadfly.pt)]
	recursivemkdir(filename)
	if !colorkey
		key_position=:none
	end
	if combined
		hsize_plot = hsize
		vsize_plot = vsize
		ncolors = length(colors)
		if ncolors == 1
			key_position=:none
			c = [Gadfly.layer(x=xaxis, y=X[:,i],
				geometry...,
				Gadfly.Theme(line_width=linewidth, point_size=pointsize, highlight_width=0Gadfly.pt, default_color=Colors.RGBA(parse(Colors.Colorant, colors[1]), opacity)))
				for i in 1:nS]..., gl...,
				glog...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				Gadfly.Guide.title(title),
				cs...,
				Gadfly.Theme(background_color=background_color, key_position=key_position, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size),
				Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), gm...
		elseif ncolors == 0 || ncolors > nS
			cs = colorkey ? [Gadfly.Guide.ColorKey(title=keytitle)] : []
			c = [Gadfly.layer(x=xaxis, y=X[:,i],
				geometry...,
				Gadfly.Theme(line_width=linewidth, point_size=pointsize, highlight_width=0Gadfly.pt, default_color=Colors.RGBA(parse(Colors.Colorant, colors[i]), opacity)), color=["$(names[i])" for j in 1:nT])
				for i in 1:nS]..., gl...,
				glog...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				Gadfly.Guide.title(title),
				cs...,
				Gadfly.Theme(background_color=background_color, key_position=key_position, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size),
				Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), gm...
		else
			cs = colorkey ? [Gadfly.Guide.manual_color_key(keytitle, names, [colors[(i-1)%ncolors+1] for i in 1:nS])] : []
			c = [Gadfly.layer(x=xaxis, y=X[:,i],
				geometry...,
				Gadfly.Theme(line_width=linewidth, point_size=pointsize, highlight_width=0Gadfly.pt, default_color=Colors.RGBA(parse(Colors.Colorant, colors[(i-1)%ncolors+1]), opacity)))
				for i in 1:nS]..., gl...,
				glog...,
				Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle),
				Gadfly.Guide.title(title),
				cs...,
				Gadfly.Theme(background_color=background_color, key_position=key_position, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size),
				Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), gm...
		end
		pS = Gadfly.plot(c...)
	else
		hsize_plot = hsize
		vsize_plot = vsize / 2 * nS
		pp = Array{Gadfly.Plot}(undef, nS)
		for i in 1:nS
			pp[i] = Gadfly.plot(Gadfly.layer(x=xaxis, y=X[:,i], glog..., geometry..., gm...), Gadfly.Guide.XLabel(xtitle), Gadfly.Guide.YLabel(ytitle), Gadfly.Theme(background_color=background_color), Gadfly.Guide.title("$(names[i])"), Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), gl...)
		end
		pS = Gadfly.vstack(pp...)
		c = nothing
	end
	try
		if filename != ""
			filename, format = setplotfileformat(filename, format)
			if format == "SVG" || format == "PDF"
				Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize_plot, vsize_plot), pS)
			else
				Gadfly.draw(Gadfly.eval((Symbol(format)))(filename, hsize_plot, vsize_plot; dpi=dpi), pS)
			end
		end
		if typeof(pS) == Gadfly.Plot
			graphoutput && Mads.display(pS)
		end
	catch errmsg
		printerrormsg(errmsg)
		Mads.madswarn("Mads.plotseries: Gadfly fails!")
	end
	if code
		return c
	else
		return nothing
	end
end

"""
Plot local sensitivity analysis results

$(DocumentFunction.documentfunction(plotlocalsa;
argtext=Dict("filenameroot"=>"problem file name root"),
keytext=Dict("keyword"=>"keyword to be added in the filename root",
            "filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.)")))

Dumps:

- `filename` : output plot file
"""
function plotlocalsa(filenameroot::String; keyword::String="", filename::String="", format::String="")
	if filename == ""
		rootname = filenameroot
		ext = ""
	else
		rootname = Mads.getrootname(filename)
		ext = "." * Mads.getextension(filename)
	end
	if keyword != ""
		rootname = string(rootname, "-", keyword)
	end
	filename = "$(filenameroot)-jacobian.dat"
	Jin = Array{Float64}(undef, 0, 0)
	if isfile(filename)
		Jin = readdlm(filename)
	end
	if sizeof(Jin) > 0
		paramkeys = Jin[1, 2:end]
		plotlabels = paramkeys
		nP = length(paramkeys)
		obskeys = Jin[2:end, 1]
		nO = length(obskeys)
		J = Jin[2:end, 2:end]
		mscale = max(abs(minimum(J)), abs(maximum(J)))
		if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
			jacmat = Gadfly.spy(J, Gadfly.Scale.x_discrete(labels = i->plotlabels[i]), Gadfly.Scale.y_discrete(labels = i->obskeys[i]),
						Gadfly.Guide.YLabel("Observations"), Gadfly.Guide.XLabel("Parameters"),
						Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
						Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red")), minvalue = -mscale, maxvalue = mscale))
			filename = "$(rootname)-jacobian" * ext
			filename, format = setplotfileformat(filename, format)
			try
				Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 3Gadfly.inch+0.25Gadfly.inch*nP, 3Gadfly.inch+0.25Gadfly.inch*nO), jacmat)
			catch
				madswarn("Gadfly could not plot!")
			end
			Mads.madsinfo("Jacobian matrix plot saved in $filename")
		end
	end
	filename = "$(filenameroot)-covariance.dat"
	Cin = Array{Float64}(undef, 0, 0)
	if isfile(filename)
		Cin = readdlm(filename)
	end
	if sizeof(Cin) > 0
		covar = Cin[2:end, 2:end]
		paramkeys = Cin[1, 2:end]
		plotlabels = paramkeys
		nP = length(paramkeys)
	end
	filename = "$(filenameroot)-eigenmatrix.dat"
	Ein = Array{Float64}(undef, 0, 0)
	if isfile(filename)
		Ein = readdlm(filename)
	end
	if sizeof(Ein) > 0
		paramkeys = Ein[1:end, 1]
		plotlabels = paramkeys
		nP = length(paramkeys)
		sortedeigenm = Ein[1:end, 2:end]
		filename = "$(filenameroot)-eigenvalues.dat"
		sortedeigenv = Array{Float64}(undef, 0)
		if isfile(filename)
			sortedeigenv = readdlm(filename)
		end
		if isdefined(Mads, :Gadfly) && !haskey(ENV, "MADS_NO_GADFLY")
			eigenmat = Gadfly.spy(sortedeigenm, Gadfly.Scale.y_discrete(labels = i->plotlabels[i]), Gadfly.Scale.x_discrete,
						Gadfly.Guide.YLabel("Parameters"), Gadfly.Guide.XLabel("Eigenvectors"),
						Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
						Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red"))))
			# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
			filename = "$(rootname)-eigenmatrix" * ext
			filename, format = setplotfileformat(filename, format)
			Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 4Gadfly.inch+0.25Gadfly.inch*nP, 4Gadfly.inch+0.25Gadfly.inch*nP), eigenmat)
			Mads.madsinfo("Eigen matrix plot saved in $filename")
			if sizeof(sortedeigenv) > 0
				eigenval = Gadfly.plot(x=1:length(sortedeigenv), y=sortedeigenv, Gadfly.Scale.x_discrete, Gadfly.Scale.y_log10,
							Gadfly.Geom.bar,
							Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
							Gadfly.Guide.YLabel("Eigenvalues"), Gadfly.Guide.XLabel("Eigenvectors"))
				filename = "$(rootname)-eigenvalues" * ext
				filename, format = setplotfileformat(filename, format)
				Gadfly.draw(Gadfly.eval(Symbol(format))(filename, 4Gadfly.inch+0.25Gadfly.inch*nP, 4Gadfly.inch), eigenval)
				Mads.madsinfo("Eigen values plot saved in $filename")
			end
		end
	end
	return nothing
end
