import PyPlot

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
	if isdefined(:PyCall)
		eval(:(@PyCall.pyimport matplotlib.ticker as mt))
		eval(:(@PyCall.pyimport matplotlib.colors as mcc))
	end
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
	alpha[1] = alpha[2] = 0
	PyPlot.scatter(plotx, ploty, marker="o", c=log10(plotc), s=70, cmap="jet")
	for i = 1:length(l)
		PyPlot.annotate(l[i], xy=(x[i], y[i]), xytext=(-2, 2), fontsize=8, textcoords="offset points", ha="right", va="bottom")
	end
end

function plotgrid(madsdata::Associative; addtitle=true, title="", filename="", format="")
	s = forwardgrid(madsdata)
	plotgrid(madsdata, s; addtitle=addtitle, title=title, filename=filename, format=format)
end

function plotgrid(madsdata::Associative, parameters::Associative; addtitle=true, title="", filename="", format="")
	s = forwardgrid(madsdata, parameters)
	plotgrid(madsdata, s; addtitle=addtitle, title=title, filename=filename, format=format)
end