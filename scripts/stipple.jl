import Stipple
import StipplePlotly

@Stipple.reactive! mutable struct UIModelMap <: Stipple.ReactiveModel
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
		mapbox = StipplePlotly.PlotLayoutMapbox(; style="stamen-terrain", zoom=5, center=StipplePlotly.MCenter(-73, 46)),
		showlegend= false,
		height= 450,
		width= 600
	)
	config::Stipple.R{StipplePlotly.PlotConfig} = StipplePlotly.PlotConfig()
end

ui_model_map = UIModelMap |> Stipple.init

ui_model_map = Stipple.init(UIModelMap)

function ui_map(ui_model_map)
	Stipple.page(
		ui_model_map,
		class = "container",
		StipplePlotly.plot(:data; layout=:layout, config="{displaylogo:false, scrollzoom:true}")
	)
end

Stipple.route("/") do
	Stipple.init(UIModelMap) |> ui_map |> Stipple.html
end

Stipple.down()
Stipple.up(; async=true)