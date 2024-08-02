import Stipple
import StipplePlotly

@Stipple.vars UIMapBox begin
	data::Vector{StipplePlotly.PlotData} = [
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
	layout::StipplePlotly.PlotLayout = StipplePlotly.PlotLayout(
		mapbox = StipplePlotly.PlotLayoutMapbox(; style="stamen-terrain", zoom=5, center=StipplePlotly.MCenter(-73, 46)),
		paper_bgcolor="#000",
		showlegend= true
	)
	config::StipplePlotly.PlotConfig = StipplePlotly.PlotConfig()
end

ui_model_map = UIMapBox |> Stipple.init

ui_model_map = Stipple.init(UIMapBox)

function ui_map(ui_model_map)
	Stipple.page(ui_model_map, class = "container", [
		Stipple.header("Mapbox")
		StipplePlotly.plot(:data; layout=:layout, config="{displaylogo:false, scrollzoom:true}")
		Stipple.footer("Footer")
	])
end

Stipple.route("/") do
	Stipple.init(UIMapBox) |> ui_map |> Stipple.html
end

Stipple.down()
Stipple.up(; async=true)