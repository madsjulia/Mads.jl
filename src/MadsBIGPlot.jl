import Gadfly

"""
Plot BIG-DT robustness curves

Arguments:

- `madsdata` : MADS problem dictionary
- `bigdtresults` : BIG-DT results
- `filename` : output file name used to dump plots
- `format` : output plot format (`png`, `pdf`, etc.)
"""
function plotrobustnesscurves(madsdata::Associative, bigdtresults::Dict; filename="", format="", maxprob=1.0, maxhoriz=Inf)
	maxfailureprobs = bigdtresults["maxfailureprobs"]
	horizons = bigdtresults["horizons"]
	if filename == ""
		rootname = Mads.getmadsrootname(madsdata)
		filename =  rootname * "-robustness"
	end
	filename, format = setimagefileformat(filename, format)
	#layers = Array(Any, size(maxfailureprobs, 2))
	df = DataFrames.DataFrame(horizon=[], maxfailureprob=[], Choices=[])
	maxhoriz = min(maxhoriz, max(horizons...))
	for i = 1:size(maxfailureprobs, 2)
		df = vcat(df, DataFrames.DataFrame(horizon=horizons, maxfailureprob=maxfailureprobs[:, i], Choices=madsdata["Choices"][i]["name"]))
		#layers[i] = Gadfly.layer(x=horizons, y=maxfailureprobs[:, i], Gadfly.Geom.line)
	end
	#p = Gadfly.plot(layers..., Gadfly.Guide.xlabel("Horizon of uncertainty"), Gadfly.Guide.ylabel("Maximum probability of failure"))
	p = Gadfly.plot(df, x="horizon", y="maxfailureprob", color="Choices", Gadfly.Geom.line,
									Gadfly.Guide.xlabel("Horizon of uncertainty"), Gadfly.Guide.ylabel("Maximum probability of failure"),
									Gadfly.Scale.x_continuous(maxvalue=maxhoriz), Gadfly.Scale.y_continuous(maxvalue=maxprob),
									Gadfly.Scale.color_discrete_manual(["red" "blue" "green" "cyan" "magenta" "yellow"]...))
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 4Gadfly.inch, 3Gadfly.inch), p)
	if typeof(p) == Gadfly.Plot{}
		p
	end
end
