import Stipple
import StipplePlotly

@Stipple.reactive! mutable struct Model <: Stipple.ReactiveModel
	data::Stipple.R{Vector{StipplePlotly.PlotData}} = [
		StipplePlotly.PlotData(
			plot = StipplePlotly.Charts.PLOT_TYPE_SCATTERMAPBOX,
			lon = [-74, -70, -70, -74],
			lat = [47, 47, 45, 45],
			marker = StipplePlotly.PlotDataMarker(size=10, color="red")
		)
		StipplePlotly.PlotData(
			plot = StipplePlotly.Charts.PLOT_TYPE_SCATTERMAPBOX,
			lon = [-74, -70, -70, -74],
			lat = [47.7, 47.5, 45.5, 45.5],
			marker = StipplePlotly.PlotDataMarker(size=10, color="orange")
		)
	]
	layout::Stipple.R{StipplePlotly.PlotLayout} = StipplePlotly.PlotLayout(
		mapbox = StipplePlotly.PlotLayoutMapbox(style="stamen-terrain", zoom =5, center = StipplePlotly.MCenter(-73, 46)),
		showlegend= false,
		height= 450,
		width= 600
	)
	config::Stipple.R{StipplePlotly.PlotConfig} = StipplePlotly.PlotConfig()
end

model = Model |> Stipple.init

function ui(model)
	Stipple.page(
		model,
		class = "container",
		StipplePlotly.plot(:data, layout = :layout, config = :config)
	)
end

Stipple.route("/") do
	Stipple.init(Model) |> ui |> Stipple.html
end

Stipple.up()