import PyPlot
import DocumentFunction

function plotgrid(madsdata::AbstractDict, s::Array{Float64}; addtitle::Bool=true, title::String="", filename::String="", format::String="")
	if !haskey(madsdata, "Grid")
		madswarn("Grid properties are not defined in the Mads dictionary")
		return
	end
	if isdefined(Mads, :PyCall)
		Core.eval(Mads, :(@PyCall.pyimport matplotlib.ticker as mt))
		# Core.eval(Mads, :(@PyCall.pyimport matplotlib.colors as mcc))
	end
	probname = Mads.getmadsrootname(madsdata; first=false)
	xmin = madsdata["Grid"]["xmin"]
	ymin = madsdata["Grid"]["ymin"]
	xmax = madsdata["Grid"]["xmax"]
	ymax = madsdata["Grid"]["ymax"]
	t = madsdata["Grid"]["time"]
	x = Array{Float64}(undef, 0)
	y = Array{Float64}(undef, 0)
	c = Array{Float64}(undef, 0)
	l = Array{String}(undef, 0)
	for w in keys(madsdata["Wells"])
		push!(x, madsdata["Wells"][w]["x"])
		push!(y, madsdata["Wells"][w]["y"])
		push!(c, madsdata["Wells"][w]["obs"][end]["c"])
		push!(l, w)
	end
	w, h = PyPlot.plt.figaspect(0.5)
	PyPlot.figure(figsize=(w, h))
	PyPlot.subplot(111, aspect=1)
	# PyPlot.imshow(log10(s[:,:,1]'), origin="lower", extent=[xmin, xmax, ymin, ymax], origin="lower", vmin=log10(50), cmap="jet")
	levels = [10,30,100,300,1000,3000,10000,30000,100000]
	PyPlot.contourf(permutedims(s[:,:,1]), cmap="jet", levels=levels, locator=mt.LogLocator(), origin="lower", extent=[xmin, xmax, ymin, ymax]) # set_under="w",   set_aspect="equal",  removed
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
	alpha[1] = alpha[2] = 0
	PyPlot.scatter(plotx, ploty, marker="o", c=log10.(plotc), s=70, cmap="jet")
	for i = 1:length(l)
		PyPlot.annotate(l[i], xy=(x[i], y[i]), xytext=(-2, 2), fontsize=8, textcoords="offset points", ha="right", va="bottom")
	end
	PyPlot.close()
end

function plotgrid(madsdata::AbstractDict; addtitle::Bool=true, title::String="", filename::String="", format::String="")
	paramvalues = Mads.getparamdict(madsdata)
	plotgrid(madsdata, paramvalues; addtitle=addtitle, title=title, filename=filename, format=format)
end

function plotgrid(madsdata::AbstractDict, parameters::AbstractDict; addtitle::Bool=true, title::String="", filename::String="", format::String="")
	s = forwardgrid(madsdata, parameters)
	if typeof(s) != Nothing
		plotgrid(madsdata, s; addtitle=addtitle, title=title, filename=filename, format=format)
	end
end

@doc """
Plot a 3D grid solution based on model predictions in array `s`, initial parameters, or user provided parameter values

$(DocumentFunction.documentfunction(plotgrid;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "parameters"=>"dictionary with model parameters",
            "s"=>"model predictions array"),
keytext=Dict("addtitle"=>"add plot title [default=`true`]",
            "title"=>"plot title",
            "filename"=>"output file name",
            "format"=>"output plot format (`png`, `pdf`, etc.)")))

Examples:

```julia
Mads.plotgrid(madsdata, s; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata; addtitle=true, title="", filename="", format="")
Mads.plotgrid(madsdata, parameters; addtitle=true, title="", filename="", format="")
```
""" plotgrid
