@doc "Set image file format" ->
function setimagefileformat(filename, format)
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

@doc "Plot MADS problem" ->
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
	filename, format = setimagefileformat(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, 4inch), p)
	p
end

@doc "Plot a 3D grid solution based on s " ->
function plotgrid(madsdata::Associative, s::Array{Float64})
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
	PyPlot.figure(figsize=(8, 6))
	# PyPlot.imshow(log10(s[:,:,1]'), origin="lower", extent=[xmin, xmax, ymin, ymax], origin="lower", vmin=log10(50), cmap="jet")
	PyPlot.contourf(s[:,:,1]', cmap="jet", levels=[10,30,100,300,1000,3000,10000,30000,100000], locator=mt.LogLocator(), axis="scaling", origin="lower", extent=[xmin, xmax, ymin, ymax], cmap="jet", set_under="w" )
	PyPlot.colorbar(shrink=0.5, cmap="jet")
	PyPlot.title("$probname Time = $t")
	PyPlot.scatter(x, y, marker="o", c=c, s=70, cmap="jet", norm=mcc.LogNorm())
	for i = 1:length(l)
		PyPlot.annotate(l[i], xy=(x[i], y[i]), xytext=(-2, 2), fontsize=8, textcoords="offset points", ha="right", va="bottom")
	end
	#I think this fixes the aspect ratio. It works in another code, but isn't tested here
	w, h = PyPlot.plt[:figaspect](0.5)
	PyPlot.figure(figsize=(w, h))
	PyPlot.subplot(111, aspect=1)
end

@doc "Plot a 3D grid solution " ->
function plotgrid(madsdata::Associative)
	s = forwardgrid(madsdata)
	plotgrid(madsdata, s)
end

@doc "Plot a 3D grid solution " ->
function plotgrid(madsdata::Associative, parameters::Associative)
	s = forwardgrid(madsdata, parameters)
	plotgrid(madsdata, s)
end

function plotmatches(madsdata, result; filename="", format="")
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
				c = Array(Float64, nT)
				t = Array(Float64, nT)
				d = Array(Float64, nT)
				for i in 1:nT
					time = t[i] = o[i]["t"]
					d[i] = o[i]["c"]
					obskey = wellname * "_" * string(time)
					c[i] = result[obskey]
				end
				p = Gadfly.plot(Guide.title(wellname),layer(x=t, y=c, Geom.line, Theme(default_color=parse(Colors.Colorant, "blue"), line_width=3pt)),
						layer(x=t, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
				push!(pp, p)
				vsize += 4inch
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
		c = Array(Float64, nT)
		t = Array(Float64, nT)
		d = Array(Float64, nT)
		for i in 1:nT
			t[i] = madsdata["Observations"][obskeys[i]]["time"]
			d[i] = madsdata["Observations"][obskeys[i]]["target"]
			c[i] = result[obskeys[i]]
		end
		pl = Gadfly.plot(layer(x=t, y=c, Geom.line, Theme(default_color=parse(Colors.Colorant, "blue"), line_width=3pt)),
					layer(x=t, y=d, Geom.point, Theme(default_color=parse(Colors.Colorant, "red"), default_point_size=4pt)))
		vsize = 4inch
	end
	if filename == ""
		filename = "$rootname-match"
	end
	filename, format = setimagefileformat(filename, format)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6inch, vsize), pl)
	if typeof(pl) == Gadfly.Plot{}
		pl
	end
end
