import Gadfly

"""
Plot BIG-DT robustness curves

$(DocumentFunction.documentfunction(plotrobustnesscurves;
argtext=Dict("madsdata"=>"MADS problem dictionary",
            "bigdtresults"=>"BIG-DT results"),
keytext=Dict("filename"=>"output file name used to dump plots",
            "format"=>"output plot format (`png`, `pdf`, etc.)",
            "maxprob"=>"maximum probability [default=`1.0`]",
            "maxhoriz"=>"maximum horizon [default=`Inf`]")))

Dumps:

- image file with name `filename` and in specified `format`
"""
function plotrobustnesscurves(madsdata::AbstractDict, bigdtresults::AbstractDict; filename::AbstractString="", format::AbstractString="", maxprob::Number=1.0, maxhoriz::Number=Inf)
	maxfailureprobs = bigdtresults["maxfailureprobs"]
	horizons = bigdtresults["horizons"]
	if filename == ""
		rootname = Mads.getmadsrootname(madsdata)
		filename = rootname * "_robustness"
	end
	#layers = Array{Any}(undef, size(maxfailureprobs, 2))
	df = DataFrames.DataFrame(horizon=[], maxfailureprob=[], Choices=[])
	maxhoriz = min(maxhoriz, max(horizons...))
	for i in axes(maxfailureprobs, 2)
		df = vcat(df, DataFrames.DataFrame(horizon=horizons, maxfailureprob=maxfailureprobs[:, i], Choices=madsdata["Choices"][i]["name"]))
		#layers[i] = Gadfly.layer(x=horizons, y=maxfailureprobs[:, i], Gadfly.Geom.line)
	end
	#p = Gadfly.plot(layers..., Gadfly.Guide.xlabel("Horizon of uncertainty"), Gadfly.Guide.ylabel("Maximum probability of failure"))
	p = Gadfly.plot(df, x="horizon", y="maxfailureprob", color="Choices", Gadfly.Geom.line,
		Gadfly.Guide.xlabel("Horizon of uncertainty"), Gadfly.Guide.ylabel("Maximum probability of failure"),
		Gadfly.Scale.x_continuous(maxvalue=maxhoriz), Gadfly.Scale.y_continuous(maxvalue=maxprob),
		Gadfly.Scale.color_discrete_manual("red", "blue", "green", "cyan", "magenta", "yellow"))
	plotfileformat(p, filename, 4Gadfly.inch, 3Gadfly.inch; format=format, dpi=imagedpi)
	if typeof(p) === Gadfly.Plot
		p
	end
end
