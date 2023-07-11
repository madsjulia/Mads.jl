import Colors
import ProgressMeter
import DataFrames
import OrderedCollections
import Gadfly
import Measures
import Compose
import DelimitedFiles

colors = ["red", "blue", "green", "orange", "magenta", "cyan", "brown", "pink", "lime", "navy", "maroon", "yellow", "olive", "springgreen", "teal", "coral", "#e6beff", "beige", "purple", "#4B6F44", "#9F4576"]
ncolors = length(colors)

"""
Set the default plot format (`SVG` is the default format)

$(DocumentFunction.documentfunction(setdefaultplotformat;
argtext=Dict("format"=>"plot format")))
"""
function setdefaultplotformat(format::AbstractString)
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
function setplotfileformat(filename::AbstractString, format::AbstractString)
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
	return filename, Symbol(format)
end

function plotfileformat(p, filename::AbstractString, hsize, vsize; format=uppercase(getextension(filename)), dpi=imagedpi)
	if typeof(p) === nothing
		madswarn("Plotting nothing!")
		return
	end
	maxsize = 40Compose.inch
	if vsize > maxsize && hsize > maxsize
		m = max(hsize, vsize)
		hsize *= maxsize.value / m.value
		vsize *= maxsize.value / m.value
	elseif vsize > maxsize
		hsize /= vsize / maxsize.value
		vsize = maxsize
	elseif hsize > maxsize
		vsize /= hsize / maxsize.value
		hsize = maxsize
	end
	filename, format = setplotfileformat(filename, format)
	recursivemkdir(filename)
	if typeof(format) <: AbstractString
		format = Symbol(format)
	end
	if format == :PNG
		Gadfly.draw(Gadfly.PNG(filename, hsize, vsize; dpi=dpi), p)
	else
		Gadfly.draw(Gadfly.eval(format)(filename, hsize, vsize), p)
	end
	return nothing
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
function plotmadsproblem(madsdata::AbstractDict; format::AbstractString="", filename::AbstractString="", keyword::AbstractString="", hsize=8Gadfly.inch, vsize=4Gadfly.inch, quiet::Bool=!Mads.graphoutput, gm::AbstractVector=[])
	rectangles = Array{Float64}(undef, 0, 4)
	gadfly_source = Gadfly.Guide.annotation(Compose.compose(Compose.context()))
	dfw = DataFrames.DataFrame(x = Float64[], y = Float64[], label = AbstractString[], category = AbstractString[])
	if haskey(madsdata, "Sources")
		for i = eachindex(madsdata["Sources"])
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
				if dfw[!, 1][i] == x && dfw[!, 2][i] == y
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
	xmin = min(dfw[!, 1]..., rectangles[:,1]...)
	ymin = min(dfw[!, 2]..., rectangles[:,2]...)
	xmax = max(dfw[!, 1]..., xo...)
	ymax = max(dfw[!, 2]..., yo...)
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
		Gadfly.Scale.x_continuous(minvalue=xmin, maxvalue=xmax, labels=x->@Printf.sprintf("%.0f", x)),
		Gadfly.Scale.y_continuous(minvalue=ymin, maxvalue=ymax, labels=y->@Printf.sprintf("%.0f", y)), gm...,
		Gadfly.Theme(highlight_width=0Gadfly.pt, key_position=:none))
	if filename == ""
		rootname = getmadsrootname(madsdata)
		filename = "$rootname-problemsetup"
	end
	if keyword != ""
		filename = "$rootname-$keyword-problemsetup"
	end
	if filename != ""
		plotfileformat(p, filename, hsize, vsize; format=format)
	end
	!quiet && Mads.display(p; gw=hsize, gh=vsize)
	return nothing
end

function plotmatches(madsdata::AbstractDict, rx::Union{AbstractString,Regex}=r""; kw...)
	r = forward(madsdata; all=true)
	if rx != r""
		plotmatches(madsdata, r, rx; kw...)
	else
		plotmatches(madsdata, r; kw...)
	end
end
function plotmatches(madsdata::AbstractDict, result::AbstractDict, rx::Union{AbstractString,Regex}; title::AbstractString="", notitle::Bool=false, kw...)
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
			!notitle && (title = typeof(rx) == Regex ? rx.pattern : rx)
		end
	end
	newmadsdata = copy(madsdata)
	newmadsdata["Observations"] = newobs
	if haskey(newmadsdata, "Wells")
		delete!(newmadsdata, "Wells")
	end
	plotmatches(newmadsdata, newresult; title=title, notitle=notitle, kw...)
end
function plotmatches(madsdata::AbstractDict, dict_in::AbstractDict; plotdata::Bool=true, filename::AbstractString="", format::AbstractString="", title::AbstractString="", xtitle::AbstractString="Time", ytitle::AbstractString="Observation", ymin=nothing, ymax=nothing,  xmin=nothing, xmax=nothing, separate_files::Bool=false, hsize::Measures.AbsoluteLength=8Gadfly.inch, vsize::Measures.AbsoluteLength=4Gadfly.inch, linewidth::Measures.AbsoluteLength=4Gadfly.pt, pointsize::Measures.AbsoluteLength=4Gadfly.pt, obs_plot_dots::Bool=true, noise::Number=0, dpi::Number=Mads.imagedpi, colors::Vector{String}=Mads.colors, display::Bool=true, notitle::Bool=false, truthtitle::AbstractString="Truth", predictiontitle::AbstractString="Prediction", gmk=[Gadfly.Guide.manual_color_key("", [truthtitle, predictiontitle], ["red", "blue"]; shape=[Gadfly.Shape.circle, Gadfly.Shape.hline], size=[pointsize * 1.3; linewidth * 3])])
	obs_flag = isobs(madsdata, dict_in)
	if obs_flag
		result = dict_in
		r = result
	else
		par_flag = isparam(madsdata, dict_in)
		if par_flag
			result = forward(madsdata, dict_in; all=true)
			r = forward(madsdata, dict_in)
		else
			madswarn("Provided dictionary does not define either parameters or observations")
			return
		end
	end
	if title == ""
		title = "OF = $(round(Mads.of(madsdata, r); sigdigits=3))"
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
				c = Vector{Float64}(undef, 0)
				tc = Vector{Float64}(undef, 0)
				d = Vector{Float64}(undef, 0)
				td = Vector{Float64}(undef, 0)
				if haskey(madsdata["Wells"][wellname], "obs") && madsdata["Wells"][wellname]["obs"] !== nothing
					o = madsdata["Wells"][wellname]["obs"]
					nT = length(o)
					for i in 1:nT
						time = gettime(o[i])
						t = gettarget(o[i])
						w = getweight(o[i])
						if !isnan(w) || w > 0
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
					c = c .+ (rand(Mads.rng, nT) .* noise)
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
				else
					push!(plot_args, Gadfly.layer(x=tc, y=c, Gadfly.Geom.point, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[iw]), point_size=pointsize)))
				end
				push!(plot_args, Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax))
				p = Gadfly.plot(Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical), plot_args..., Gadfly.Theme(highlight_width=0Gadfly.pt), gmk...)
				if separate_files
					if filename == ""
						filename_w = "$rootname-match-$wellname"
					else
						extension = getextension(filename)
						rootfile = getrootname(filename)
						filename_w = "$rootfile-$wellname.$extension"
					end
					plotfileformat(p, filename_w, hsize, vsize; format=format, dpi=dpi)
					display && Mads.display(p; gw=hsize, gh=vsize)
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
		obs = Vector{Float64}(undef, 0)
		tobs = Vector{Float64}(undef, 0)
		vresults = Vector{Float64}(undef, 0)
		tresults = Vector{Float64}(undef, 0)
		time_missing = 0
		for i in 1:nT
			if !haskey(madsdata["Observations"][obskeys[i]], "time")
				time_missing += 1
				time = NaN
			else
				time = madsdata["Observations"][obskeys[i]]["time"]
			end
			if haskey(madsdata["Observations"][obskeys[i]], "weight") && madsdata["Observations"][obskeys[i]]["weight"] > 0
				push!(tobs, time)
				push!(obs, madsdata["Observations"][obskeys[i]]["target"])
			end
			push!(tresults, time)
			push!(vresults, result[obskeys[i]])
		end
		if time_missing == nT
			madswarn("All observations do not have `time` field specified!")
			tobs = collect(1:nT)
			tresults = tobs
		elseif time_missing > 0
			madswarn("Some observations do not have `time` field specified!")
		end
		pl = Gadfly.plot(Gadfly.Guide.title(title), Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
			Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
			Gadfly.layer(x=tresults, y=vresults, Gadfly.Geom.line, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "blue"), line_width=linewidth)),
			Gadfly.layer(x=tobs, y=obs, Gadfly.Geom.point, Gadfly.Theme(default_color=Base.parse(Colors.Colorant, "red"), point_size=pointsize, highlight_width=0Gadfly.pt)),
			Gadfly.Theme(highlight_width=0Gadfly.pt),
			gmk...)
	end
	if pl === nothing
		Mads.madswarn("There is nothing to plot!")
		return nothing
	end
	if !separate_files
		if filename == "" && rootname != ""
			filename = "$rootname-match"
		end
		if filename != ""
			plotfileformat(pl, filename, hsize, vsize; format=format, dpi=dpi)
		end
		if typeof(pl) == Gadfly.Plot || typeof(pl) == Compose.Context
			display && Mads.display(pl; gw=hsize, gh=vsize)
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
function scatterplotsamples(madsdata::AbstractDict, samples::AbstractMatrix, filename::AbstractString; np=size(samples, 2), format::AbstractString="", pointsize::Measures.AbsoluteLength=3Gadfly.pt * 4 / np, major_label_font_size::Measures.AbsoluteLength=24Gadfly.pt * 4 / np, minor_label_font_size::Measures.AbsoluteLength=12Gadfly.pt * 4 / np, highlight_width=1Gadfly.pt * 4 / np, dpi=Mads.imagedpi)
	@assert np == size(samples, 2)
	paramkeys = getoptparamkeys(madsdata)
	plotlabels = getparamlabels(madsdata, paramkeys)
	cs = Array{Compose.Context}(undef, np, np)
	for i in 1:np
		for j in 1:np
			if i == j
				cs[i, j] = Gadfly.render(Gadfly.plot(x=samples[:, i], Gadfly.Geom.histogram,
					Gadfly.Guide.XLabel(plotlabels[i]),
					Gadfly.Theme(major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size)
					))
			else
				cs[j, i] = Gadfly.render(Gadfly.plot(x=samples[:, i], y=samples[:, j],
					Gadfly.Guide.XLabel(plotlabels[i]), Gadfly.Guide.YLabel(plotlabels[j]),
					Gadfly.Theme(major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size, point_size=pointsize, highlight_width=highlight_width)
					))
			end
		end
	end
	hsize = (6 * np)Gadfly.inch
	vsize = (6 * np)Gadfly.inch
	try
		pl = Compose.gridstack(cs)
		plotfileformat(pl, filename, hsize, vsize; format=format, dpi=dpi)
	catch errmsg
		printerrormsg(errmsg)
		Mads.madswarn("Scatterplotsamples: Gadfly fails!")
	end
	return nothing
end

function plotwellSAresults(madsdata::AbstractDict, result::AbstractDict; xtitle::AbstractString="Time", ytitle::AbstractString="", filename::AbstractString="", format::AbstractString="", quiet::Bool=!Mads.graphoutput)
	if !haskey(madsdata, "Wells")
		Mads.madswarn("There is no 'Wells' data in the MADS input dataset")
	else
		for wellname in keys(madsdata["Wells"])
			if madsdata["Wells"][wellname]["on"]
				plotwellSAresults(madsdata, result, wellname; xtitle=xtitle, ytitle=ytitle, filename=filename, format=format, quiet=quiet)
			end
		end
	end
end
function plotwellSAresults(madsdata::AbstractDict, result::AbstractDict, wellname::AbstractString; xtitle::AbstractString="Time", ytitle::AbstractString="", filename::AbstractString="", format::AbstractString="", quiet::Bool=!Mads.graphoutput)
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
	pc = Gadfly.plot(dfc, x="x", y="y", Gadfly.Geom.point, Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical))
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
	if length(vdf[!, 1]) > 0
		ptes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel("Total Effect"), Gadfly.Theme(key_position=:top))
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
	if length(vdf[!, 1]) > 0
		pmes = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel("Main Effect"), Gadfly.Theme(key_position=:none))
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
	if length(vdf[!, 1]) > 0
		pvar = Gadfly.plot(vdf, x="x", y="y", Gadfly.Geom.line, color="parameter", Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel("Output Variance"), Gadfly.Theme(key_position=:none) )
		push!(pp, pvar)
		vsize += 4Gadfly.inch
	end
	p = Gadfly.vstack(pp...)
	rootname = getmadsrootname(madsdata)
	method = result["method"]
	if filename == ""
		filename = "$rootname-$wellname-$method-$nsample"
	end
	plotfileformat(p, filename, 8Gadfly.inch, vsize; format=format, dpi=imagedpi)
	!quiet && Mads.display(p; gw=8Gadfly.inch, gh=vsize)
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
function plotobsSAresults(madsdata::AbstractDict, result::AbstractDict; filter::Union{String,Regex}="", keyword::AbstractString="", filename::AbstractString="", format::AbstractString="", separate_files::Bool=true, xtitle::AbstractString="Time", ytitle::AbstractString="", plotlabels::Union{AbstractVector,Nothing}=nothing, quiet::Bool=!Mads.graphoutput, order::Bool=true, select::Union{AbstractVector,AbstractRange,Colon}=Colon(), kw...)
	if !haskey(madsdata, "Observations")
		Mads.madswarn("There is no 'Observations' class in the MADS input dataset")
		return
	end
	nsample = result["samplesize"]
	obsdict = madsdata["Observations"]
	paramkeys = getoptparamkeys(madsdata)
	if plotlabels === nothing
		plotlabels = getparamlabels(madsdata, paramkeys)
	end
	nP = length(paramkeys)
	obskeys = Mads.filterkeys(obsdict, filter)
	nT = length(obskeys)
	d = Array{Float64}(undef, 2, nT)
	mes = Array{Float64}(undef, nT, nP)
	tes = Array{Float64}(undef, nT, nP)
	var = Array{Float64}(undef, nT, nP)
	for (i, obskey) in enumerate(obskeys)
		if haskey(obsdict[obskey], "time")
			d[1,i] = obsdict[obskey]["time"]
		else
			madserror("Observation dictionary does not have `time` field!")
		end
		d[2,i] = haskey(obsdict[obskey], "target") ? obsdict[obskey]["target"] : NaN
		for (j, paramkey) in enumerate(paramkeys)
			mes[i,j] = result["mes"][obskey][paramkey]
			tes[i,j] = result["tes"][obskey][paramkey]
			var[i,j] = result["var"][obskey][paramkey]
		end
	end
	mintes = minimumnan(tes)
	if mintes < 0
		tes = tes .- mintes
	end
	tes ./=  maximumnan(tes)
	minmes = minimumnan(mes)
	if minmes < 0
		mes = mes .- minmes
	end
	mes ./=  maximumnan(mes)
	smags = order ? sortperm(vec(sum(tes; dims=1)); rev=true) : collect(1:nP)
	pp = Array{Any}(undef, 0)
	if ytitle != ""
		pd = Mads.plotseries(d[2,:]; xaxis=d[1,:], xtitle=xtitle, ytitle=ytitle, returnplot=true, colorkey=false, kw...)
		push!(pp, pd)
	end
	ptes = Mads.plotseries(tes[:,smags[select]]; xaxis=d[1,:], xtitle=xtitle, ytitle = "Total Effect", returnplot=true, names=plotlabels[smags[select]], kw...)
	push!(pp, ptes)
	pmes = Mads.plotseries(mes[:,smags[select]]; xaxis=d[1,:], xtitle=xtitle, ytitle = "Main Effect", returnplot=true, names=plotlabels[smags[select]], kw...)
	push!(pp, pmes)
	pvar = Mads.plotseries(var[:,smags[select]]; xaxis=d[1,:], xtitle=xtitle, ytitle = "Variance", returnplot=true, names=plotlabels[smags[select]], kw...)
	push!(pp, pvar)

	if !order
		smags = sortperm(vec(sum(tes; dims=1)); rev=true)
	end

	ranking = [paramkeys plotlabels][smags[select],:]
	@info("Paramter ranking (labels/keys)")
	display(ranking)

	if filename == ""
		method = result["method"]
		rootname = Mads.getmadsrootname(madsdata)
		filename = keyword != "" ? "$rootname-$method-$keyword-$nsample" : "$rootname-$method-$nsample"
	end
	DelimitedFiles.writedlm(filename * ".txt", ranking)
	if !separate_files
		p = Gadfly.vstack(pp...)
		plotfileformat(p, filename, 12Gadfly.inch, 16Gadfly.inch; format=format, dpi=imagedpi)
		!quiet && Mads.display(p; gw=12Gadfly.inch, gh=vsize)
	else
		filename_root = Mads.getrootname(filename)
		filename_ext = Mads.getextension(filename)
		filename = filename_root * "-total_effect." * filename_ext
		plotfileformat(ptes, filename, 8Gadfly.inch, 4Gadfly.inch; format=format, dpi=imagedpi)
		filename = filename_root * "-main_effect." * filename_ext
		plotfileformat(pmes, filename, 8Gadfly.inch, 4Gadfly.inch; format=format, dpi=imagedpi)
		filename = filename_root * "-variance." * filename_ext
		plotfileformat(pvar, filename, 8Gadfly.inch, 4Gadfly.inch; format=format, dpi=imagedpi)
	end
	return [paramkeys plotlabels][smags[select],:]
end

function spaghettiplots(madsdata::AbstractDict, number_of_samples::Integer; seed::Integer=-1, rng=nothing, kw...)
	Mads.setseed(seed; rng=rng)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplots(madsdata::AbstractDict, paramvalues; kw...)
end
function spaghettiplots(madsdata::AbstractDict, paramdictarray::OrderedCollections.OrderedDict; format::AbstractString="", keyword::AbstractString="", xtitle::AbstractString="", ytitle::AbstractString="", obs_plot_dots::Bool=true, seed::Integer=-1, rng=nothing, linewidth::Measures.AbsoluteLength=2Gadfly.pt, pointsize::Measures.AbsoluteLength=4Gadfly.pt, grayscale::Bool=false, quiet::Bool=!Mads.graphoutput)
	Mads.setseed(seed; rng=rng)
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
				t[i] = NaN
			end
			if haskey( madsdata["Observations"][obskeys[i]], "target") && madsdata["Observations"][obskeys[i]]["weight"] > 0
				d[i] = madsdata["Observations"][obskeys[i]]["target"]
			else
				d[i] = NaN
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
					Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
					[Gadfly.layer(x=t, y=Y[:,i], Gadfly.Geom.line,
					Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
					for i in 1:numberofsamples]...)
			else
				pl = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
					Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
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
							Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
							[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
							Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
							for i in 1:numberofsamples]...)
					else
						p = Gadfly.plot(Gadfly.layer(x=t, y=d, obs_plot...),
							Gadfly.Guide.title(wellname),
							Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
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
		plotfileformat(pl, filename, 8Gadfly.inch, vsize; format=format, dpi=imagedpi)
		!quiet && Mads.display(pl; gw=8Gadfly.inch, gh=vsize)
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
            "pointsize"=>"size of the markers on the plot [default=`4Gadfly.pt`]")))

Dumps:

- A series of image files with spaghetti plots for each `selected` (`type != null`) model parameter (`<mads_rootname>-<keyword>-<param_key>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplots(madsdata, paramdictarray; format="", keyword="", xtitle="X", ytitle = "Y", obs_plot_dots=true)
Mads.spaghettiplots(madsdata, number_of_samples; format="", keyword="", xtitle="X", ytitle = "Y", obs_plot_dots=true)
```
""" spaghettiplots

function spaghettiplot(madsdata::AbstractDict, number_of_samples::Integer; kw...)
	paramvalues = getparamrandom(madsdata, number_of_samples)
	spaghettiplot(madsdata::AbstractDict, paramvalues; kw...)
end
function spaghettiplot(madsdata::AbstractDict, dictarray::AbstractDict; seed::Integer=-1, rng=nothing, kw...)
	Mads.setseed(seed; rng=rng)
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
function spaghettiplot(madsdata::AbstractDict, matrix::AbstractMatrix; plotdata::Bool=true, filename::AbstractString="", keyword::AbstractString="", format::AbstractString="", title::AbstractString="", xtitle::AbstractString="", ytitle::AbstractString="", yfit::Bool=false, obs_plot_dots::Bool=true, linewidth::Measures.AbsoluteLength=2Gadfly.pt, pointsize::Measures.AbsoluteLength=4Gadfly.pt, grayscale::Bool=false, xmin=nothing, xmax=nothing, ymin=nothing, ymax=nothing, quiet::Bool=!Mads.graphoutput, colors::AbstractVector=["red", "blue", "green", "cyan", "magenta", "yellow"], gm::AbstractVector=[])
	madsinfo("Spaghetti plots for all the selected model parameter (type != null) ...\n")
	rootname = getmadsrootname(madsdata)
	obskeys = Mads.getobskeys(madsdata)
	nT = length(obskeys)
	s = size(matrix)
	local Y
	if s[1] == nT
		Y = matrix
		numberofsamples = s[2]
	elseif s[2] == nT
		Y = permutedims(matrix)
		numberofsamples = s[1]
	else
		madswarn("Incorrect matrix size: size(matrix) = $(s)")
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
		ymin = minimumnan(Y, 2)
		ymax = maximumnan(Y, 2)
	end
	push!(pa, Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax))
	if !haskey(madsdata, "Wells")
		if plotdata
			t = getobstime(madsdata)
			d = getobstarget(madsdata)
			w = getobsweight(madsdata)
			d[w .== 0] .= NaN
			push!(pa, Gadfly.layer(x=t, y=d, obs_plot...))
		end
		colindex = Gadfly.Col.index(1:numberofsamples...)
		colormap =
			if grayscale
				function(nc)
					[Gadfly.parse_colorant(["red"]); repeat(Gadfly.parse_colorant(["gray"]), inner=nc-1)]
				end
			else
				palette = Gadfly.parse_colorant(colors)
				function(nc)
					palette[rem.((1:nc) .- 1, length(palette)) .+ 1]
				end
			end
		pl = Gadfly.plot(pa..., Gadfly.layer(Y, x=repeat(t; inner=numberofsamples), y=Gadfly.Col.value(1:numberofsamples...),
			color=colindex, group=colindex, Gadfly.Geom.line()),
			Gadfly.Scale.color_discrete(colormap),
			Gadfly.Theme(key_position=:none, line_width=linewidth, point_size=pointsize, highlight_width=0Gadfly.pt, discrete_highlight_color=c->nothing),
			Gadfly.Guide.title(title),
			Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
			gm...)
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
						Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
						[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
						Gadfly.Theme(default_color=Colors.RGBA(0.25, 0.25, 0.25, 0.2)))
						for i in 1:numberofsamples]..., gm...)
				else
					p = Gadfly.plot(pa...,
						Gadfly.Guide.title(wellname),
						Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
						[Gadfly.layer(x=t, y=Y[startj:endj,i], Gadfly.Geom.line,
						Gadfly.Theme(default_color=Base.parse(Colors.Colorant, colors[i%6+1])))
						for i in 1:numberofsamples]..., gm...)
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
	if filename == "" && rootname != ""
		filename = keyword == "" ?  "$rootname-$numberofsamples-spaghetti" : "$rootname-$keyword-$numberofsamples-spaghetti"
	end
	if filename != ""
		plotfileformat(pl, filename, 8Gadfly.inch, vsize; format=format, dpi=imagedpi)
	end
	!quiet && Mads.display(pl; gw=8Gadfly.inch, gh=vsize)
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
            "pointsize"=>"size of the markers in plot [default=`4Gadfly.pt`]")))

Dumps:

- Image file with a spaghetti plot (`<mads_rootname>-<keyword>-<number_of_samples>-spaghetti.<default_image_extension>`)

Example:

```julia
Mads.spaghettiplot(madsdata, dictarray; filename="", keyword = "", format="", xtitle="X", ytitle = "Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, array; filename="", keyword = "", format="", xtitle="X", ytitle = "Y", obs_plot_dots=true)
Mads.spaghettiplot(madsdata, number_of_samples; filename="", keyword = "", format="", xtitle="X", ytitle = "Y", obs_plot_dots=true)
```
""" spaghettiplot

function plotseries(dict::AbstractDict, filename::AbstractString=""; separate_files::Bool=false, normalize::Bool=false, names=string.(keys(dict)), kw...)
	if separate_files
		if filename != ""
			f, e = splitext(filename)
		end
		for (i, k) in enumerate(keys(dict))
			fn = filename == "" ? filename : f * "_" * "$(names[i])" * e
			v = normalize ? dict[k] ./ maximum(dict[k]) : dict[k]
			plotseries(v, fn; title=names[i], kw...)
		end
	else
		m = Matrix{Float64}(undef, length(dict[first(keys(dict))]), length(keys(dict)))
		for (i, k) in enumerate(keys(dict))
			m[:,i] = dict[k]
		end
		if normalize
			m ./= maximum(m; dims=1)
		end
		plotseries(m, filename; names=names, kw...)
	end
end

function plotseries(df::DataFrames.DataFrame, filename::AbstractString=""; separate_files::Bool=false, normalize::Bool=false, names=string.(names(df)), kw...)
	m = Matrix(df)
	if normalize
		m ./= maximum(m; dims=1)
	end
	if separate_files
		if filename != ""
			f, e = splitext(filename)
		end
		for i = 1:size(m, 2)
			fn = filename == "" ? filename : f * "_" * names[i] * e
			plotseries(m[:, i], fn; title=names[i], kw...)
		end
	else
		plotseries(m, filename; names=names, kw...)
	end
end
function plotseries(X::AbstractArray, filename::AbstractString=""; nT::Integer=size(X, 1), nS::Integer=size(X, 2), format::AbstractString="", xtitle::AbstractString = "", ytitle::AbstractString = "", title::AbstractString="", logx::Bool=false, logy::Bool=false, keytitle::AbstractString="", name::AbstractString="Signal", names::Vector{String}=["$name $i" for i in 1:nS], combined::Bool=true, hsize::Measures.AbsoluteLength=8Gadfly.inch, vsize::Measures.AbsoluteLength=4Gadfly.inch, linewidth::Measures.AbsoluteLength=2Gadfly.pt, linestyle::Union{Symbol,AbstractVector}=:solid, pointsize::Measures.AbsoluteLength=2Gadfly.pt, key_position::Symbol=:right, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, dpi::Integer=Mads.imagedpi, colors::Vector{String}=Mads.colors, opacity::Number=1.0, xmin=nothing, xmax=nothing, ymin=nothing, ymax=nothing, xaxis=1:nT, plotline::Bool=true, plotdots::Bool=!plotline, nextgray::Bool=false, lastcolored::Bool=false, code::Bool=false, returnplot::Bool=false, colorkey::Bool=(nS>ncolors) ? false : true, background_color=nothing, gm::Any=[], gl::Any=[], quiet::Bool=!Mads.graphoutput, truth::Bool=false, gall::Bool=false)
	if nT == 0 || nS == 0
		@warn "Input is empty $(size(X)); a matrix or a vector is needed!"
		return
	end
	if name == ""
		names = ["" for i in 1:size(X,2)]
	end
	glog = []
	if logx
		push!(glog, Gadfly.Scale.x_log10)
		if xmin === nothing
			xmin = log10(minimumnan(xaxis[xaxis .!= 0.]))
		end
		if xmax === nothing
			xmax = log10(maximumnan(xaxis))
		end
	end
	if logy
		push!(glog, Gadfly.Scale.y_log10)
		ixzero = X .<= 0
		X[ixzero] .= NaN
		if ymin === nothing
			ymin = log10(minimumnan(X[X .!= 0.]))
		end
		if ymax === nothing
			ymax = log10(maximumnan(X))
			if ymin !== nothing
				dy = (ymax - ymin)/10
				ymin -= dy
				ymax += dy
			end
		end
	else
		ixzero = nothing
	end

	geometry = (plotline) ? [Gadfly.Geom.line()] : [Gadfly.Geom.point()]
	geometry = (plotdots) ? [Gadfly.Geom.point()] : [Gadfly.Geom.line()]
	geometry = (plotline && plotdots) ? [Gadfly.Geom.line(), Gadfly.Geom.point()] : geometry
	mck = []
	ncolors = length(colors)
	if truth && nS > 1
		geometry = [[Gadfly.Geom.point() Gadfly.Geom.line()]; repeat([Gadfly.Geom.line() Gadfly.Geom.line()], nS-1)]
		geometry = Vector{Any}(undef, nS)
		geometry[1] = [Gadfly.Geom.line(), Gadfly.Geom.point()]
		geometry[2:end] = repeat([[Gadfly.Geom.line()]], nS-1)
		linestylea = [:solid; repeat([:solid], nS-1)]
		linewidthea =[linewidth / 2; repeat([linewidth * 2], nS-1)]
		if nS <= ncolors && !nextgray
			mck = [Gadfly.Guide.manual_color_key("", names, colors[1:nS]; shape=[Gadfly.Shape.circle; repeat([Gadfly.Shape.hline], nS-1)], size=[pointsize * 1.5; repeat([linewidth * 3], nS-1)])]
			key_position = :none
			# pointsize = 1.5 * linewidth
		end
	else
		geometry = repeat([geometry], nS)
		linestylea = typeof(linestyle) == Symbol ? repeat([linestyle], nS) : linestyle
		linewidthea = repeat([linewidth], nS)
	end
	if !colorkey || nS == 1 || nextgray
		key_position = :none
	end
	if combined
		hsize_plot = hsize
		vsize_plot = vsize
		if key_position == :none
			colorkey = false
		end
		if !gall || code
			if nextgray
				cs = []
				if lastcolored
					default_colors = [[Colors.RGBA(parse(Colors.Colorant, "gray"), opacity) for i in 2:nS]; Colors.RGBA(parse(Colors.Colorant, colors[1]), opacity)]
				else
					default_colors = [Colors.RGBA(parse(Colors.Colorant, colors[1]), opacity); [Colors.RGBA(parse(Colors.Colorant, "gray"), opacity) for i in 2:nS]]
				end
			else
				if nS <= ncolors
					cs = colorkey ? [Gadfly.Guide.manual_color_key(keytitle, names, [colors[i] for i in 1:nS])] : []
					default_colors = [Colors.RGBA(parse(Colors.Colorant, colors[i]), opacity) for i in 1:nS]
				else
					cs = colorkey ? [Gadfly.Guide.manual_color_key(keytitle, names, [colors[(i-1)%ncolors+1] for i in 1:nS])] : []
					default_colors = [Colors.RGBA(parse(Colors.Colorant, colors[(i-1)%ncolors+1]), opacity) for i in 1:nS]
				end
			end
			c = [Gadfly.layer(x=xaxis, y=X[:,i],
					geometry[i]...,
					Gadfly.Theme(line_width=linewidthea[i], line_style=[linestylea[i]], point_size=pointsize, highlight_width=0Gadfly.pt, discrete_highlight_color=c->nothing, default_color=default_colors[i]))
					for i in 1:nS]...,
				mck...,
				gl...,
				glog...,
				Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
				Gadfly.Guide.title(title),
				cs...,
				Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
				Gadfly.Theme(background_color=background_color, discrete_highlight_color=c->nothing, key_position=key_position, highlight_width=0Gadfly.pt, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size),
				gm...
			pS = Gadfly.plot(c...)
		else
			cs = colorkey ? [Gadfly.Guide.ColorKey(title=keytitle)] : []
			if nextgray
				palette = Gadfly.parse_colorant(["gray"])
			else
				if length(colors) > 1
					palette = Gadfly.parse_colorant(colors[1:end])
				else
					palette = Gadfly.parse_colorant(colors)
				end
			end
			colormap =
				if nextgray
					if lastcolored
						function(nc)
							[palette[rem.((1:(nc-1)) .- 1, length(palette)) .+ 1]; Gadfly.parse_colorant(["red"])]
						end
					else
						function(nc)
							[Gadfly.parse_colorant(["red"]); palette[rem.((1:(nc-1)) .- 1, length(palette)) .+ 1]]
						end
					end
				else
					function(nc)
						palette[rem.((1:nc) .- 1, length(palette)) .+ 1]
					end
				end
			colindex = Gadfly.Col.index(1:nS...)
			geometry = (plotline) ? [Gadfly.Geom.line()] : [Gadfly.Geom.point()]
			geometry = (plotdots) ? [Gadfly.Geom.point()] : [Gadfly.Geom.line()]
			geometry = (plotline && plotdots) ? [Gadfly.Geom.line(), Gadfly.Geom.point()] : geometry
			pS = Gadfly.plot(X, x=repeat(xaxis, inner=nS), y=Gadfly.Col.value(1:nS...),
				color=colindex, group=colindex,
				Gadfly.Scale.color_discrete(colormap),
				geometry...,
				gl...,
				Gadfly.Theme(line_width=linewidth, line_style=[linestyle], point_size=pointsize, highlight_width=0Gadfly.pt, background_color=background_color, discrete_highlight_color=c->nothing, key_position=key_position, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size),
				glog...,
				Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical),
				Gadfly.Guide.title(title),
				cs...,
				Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax),
				gm...
			)
			c = nothing
		end
	else
		hsize_plot = hsize
		vsize_plot = vsize * nS
		pp = Array{Gadfly.Plot}(undef, nS)
		for i in 1:nS
			pp[i] = Gadfly.plot(Gadfly.layer(x=xaxis, y=X[:,i], glog..., geometry[i]..., gm...), Gadfly.Guide.XLabel(xtitle; orientation=:horizontal), Gadfly.Guide.YLabel(ytitle; orientation=:vertical), Gadfly.Theme(line_width=linewidth, line_style=[linestyle], point_size=pointsize, highlight_width=0Gadfly.pt, background_color=background_color, discrete_highlight_color=c->nothing, key_position=key_position, major_label_font_size=major_label_font_size, minor_label_font_size=minor_label_font_size), Gadfly.Guide.title("$(names[i])"), Gadfly.Coord.Cartesian(xmin=xmin, xmax=xmax, ymin=ymin, ymax=ymax), gl...)
		end
		pS = Gadfly.vstack(pp...)
		c = nothing
	end
	try
		if filename != ""
			plotfileformat(pS, filename, hsize_plot, vsize_plot; format=format, dpi=dpi)
		end
		!quiet && Mads.display(pS; gw=hsize_plot, gh=vsize_plot)
	catch errmsg
		printerrormsg(errmsg)
		Mads.madswarn("Mads.plotseries: Gadfly fails!")
		ixzero !== nothing && (X[ixzero] .= 0)
		return false
	end
	ixzero !== nothing && (X[ixzero] .= 0)
	if returnplot
		return pS
	elseif code
		return c
	else
		return nothing
	end
end
@doc """
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
""" plotseries

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
function plotlocalsa(filenameroot::AbstractString; keyword::AbstractString="", filename::AbstractString="", format::AbstractString="")
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
		Jin = DelimitedFiles.readdlm(filename)
	end
	if sizeof(Jin) > 0
		paramkeys = Jin[1, 2:end]
		plotlabels = paramkeys
		nP = length(paramkeys)
		obskeys = Jin[2:end, 1]
		nO = length(obskeys)
		J = Jin[2:end, 2:end]
		mscale = max(abs(minimumnan(J)), abs(maximumnan(J)))
		if !haskey(ENV, "MADS_NO_GADFLY")
			jacmat = Gadfly.spy(J, Gadfly.Scale.x_discrete(labels = i->plotlabels[i]), Gadfly.Scale.y_discrete(labels = i->obskeys[i]),
						Gadfly.Guide.YLabel("Observations"), Gadfly.Guide.XLabel("Parameters"),
						Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
						Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red")), minvalue = -mscale, maxvalue = mscale))
			filename = "$(rootname)-jacobian" * ext
			plotfileformat(jacmat, filename, 3Gadfly.inch+0.25Gadfly.inch*nP, 3Gadfly.inch+0.25Gadfly.inch*nO; format=format, dpi=imagedpi)
			Mads.madsinfo("Jacobian matrix plot saved in $filename")
		end
	end
	filename = "$(filenameroot)-covariance.dat"
	Cin = Array{Float64}(undef, 0, 0)
	if isfile(filename)
		Cin = DelimitedFiles.readdlm(filename)
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
		Ein = DelimitedFiles.readdlm(filename)
	end
	if sizeof(Ein) > 0
		paramkeys = Ein[1:end, 1]
		plotlabels = paramkeys
		nP = length(paramkeys)
		sortedeigenm = Ein[1:end, 2:end]
		filename = "$(filenameroot)-eigenvalues.dat"
		sortedeigenv = Vector{Float64}(undef, 0)
		if isfile(filename)
			sortedeigenv = DelimitedFiles.readdlm(filename)
		end
		if !haskey(ENV, "MADS_NO_GADFLY")
			eigenmat = Gadfly.spy(sortedeigenm, Gadfly.Scale.y_discrete(labels = i->plotlabels[i]), Gadfly.Scale.x_discrete,
						Gadfly.Guide.YLabel("Parameters"), Gadfly.Guide.XLabel("Eigenvectors"),
						Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
						Gadfly.Scale.ContinuousColorScale(Gadfly.Scale.lab_gradient(Base.parse(Colors.Colorant, "green"), Base.parse(Colors.Colorant, "yellow"), Base.parse(Colors.Colorant, "red"))))
			# eigenval = plot(x=1:length(sortedeigenv), y=sortedeigenv, Scale.x_discrete, Scale.y_log10, Geom.bar, Guide.YLabel("Eigenvalues"), Guide.XLabel("Eigenvectors"))
			filename = "$(rootname)-eigenmatrix" * ext
			plotfileformat(eigenmat, filename, 4Gadfly.inch+0.25Gadfly.inch*nP, 4Gadfly.inch+0.25Gadfly.inch*nP; format=format, dpi=imagedpi)
			Mads.madsinfo("Eigen matrix plot saved in $filename")
			if sizeof(sortedeigenv) > 0
				eigenval = Gadfly.plot(x=1:length(sortedeigenv), y=sortedeigenv, Gadfly.Scale.x_discrete, Gadfly.Scale.y_log10,
							Gadfly.Geom.bar,
							Gadfly.Theme(point_size=20Gadfly.pt, major_label_font_size=14Gadfly.pt, minor_label_font_size=12Gadfly.pt, key_title_font_size=16Gadfly.pt, key_label_font_size=12Gadfly.pt),
							Gadfly.Guide.YLabel("Eigenvalues"), Gadfly.Guide.XLabel("Eigenvectors"))
				filename = "$(rootname)-eigenvalues" * ext
				plotfileformat(eigenval, filename, 4Gadfly.inch+0.25Gadfly.inch*nP, 4Gadfly.inch; format=format, dpi=imagedpi)
				Mads.madsinfo("Eigen values plot saved in $filename")
			end
		end
	end
	return nothing
end
