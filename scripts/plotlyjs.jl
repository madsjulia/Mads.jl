import Plotly
import PlotlyJS
import CSV
import DataFrames

nm = tempname()
url = "https://raw.githubusercontent.com/plotly/datasets/master/2014_us_cities.csv"
download(url, nm)
df = CSV.read(nm, DataFrames.DataFrame)
rm(nm)

trace = PlotlyJS.scattergeo(; locationmode="USA-states",
					lat=df[!, :lat],
					lon=df[!, :lon],
					hoverinfo="text",
					text=[string(x[:name], " pop: ", x[:pop]) for x in eachrow(df)],
					marker_size=df[!, :pop] / 50_000,
					marker_line_color="black", marker_line_width=2)

geo = PlotlyJS.attr(scope="usa",
			projection_type="albers usa",
			showland=true,
			landcolor="rgb(217, 217, 217)",
			subunitwidth=1,
			countrywidth=1,
			subunitcolor="rgb(255,255,255)",
			countrycolor="rgb(255,255,255)")

layout = PlotlyJS.Layout(; title="2014 US City Populations", showlegend=false, geo=geo)
PlotlyJS.plot(trace, layout)