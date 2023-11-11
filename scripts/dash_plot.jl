import Dash
import Plotly
import PlotlyJS
import DataFrames
import Statistics
import Sockets
import HTTP

global dash_df
global dash_server
global dash_task
global dash_stop = false

function load_dataframes(gdata::Data; execute::Bool=false, edges::Bool=false)
	# Source data
	if isdefined(gdata, :sources)
		nsources = length(gdata.sources)
		lat = Vector{Float64}(undef, nsources)
		lon = Vector{Float64}(undef, nsources)
		label = Vector{String}(undef, nsources)
		name = Vector{String}(undef, nsources)
		id = Vector{String}(undef, nsources)
		for i = 1:nsources
			lat[i] = gdata.sources[i].lat
			lon[i] = gdata.sources[i].lon
			label[i] = string(gdata.sources[i].label)
			name[i] = "Source $i"
			id[i] = string(gdata.sources[i].label)
		end
		df_source = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	else
		@warn("Source data is missing!")
		df_source = DataFrames.DataFrame()
	end
	# Sink data
	if isdefined(gdata, :sinks)
		nsinks = length(gdata.sinks)
		lat = Vector{Float64}(undef, nsinks)
		lon = Vector{Float64}(undef, nsinks)
		label = Vector{String}(undef, nsinks)
		name = Vector{String}(undef, nsinks)
		id = Vector{String}(undef, nsinks)
		for i = 1:nsinks
			lat[i] = gdata.sinks[i].lat
			lon[i] = gdata.sinks[i].lon
			label[i] = string(gdata.sinks[i].label)
			name[i] = "Sink $i"
			id[i] = string(gdata.sinks[i].label)
		end
		df_sink = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	else
		@warn("Sink data is missing!")
		df_sink = DataFrames.DataFrame()
	end
	# Candidate network
	if !isdefined(gdata, :graphEdgeRoutes) && execute
		@warn("Candidate network data is missing! Generation of the candidate network will be executed ...")
		generateCandidateNetwork!(gdata)
	end
	if isdefined(gdata, :graphEdgeRoutes)
		label = Vector{String}(undef, 0)
		name = Vector{String}(undef, 0)
		id = Vector{String}(undef, 0)
		if edges
			lat = Vector{Vector{Float64}}(undef, 0)
			lon = Vector{Vector{Float64}}(undef, 0)
			i = 1
			for (key, route) in gdata.graphEdgeRoutes
				latv = Vector{Float64}(undef, 0)
				lonv = Vector{Float64}(undef, 0)
				for cellNum in route
					lon_temp, lat_temp = cellToLocation(gdata, cellNum)
					push!(latv, lat_temp)
					push!(lonv, lon_temp)
				end
				if gdata.projectionVersion == 2
					coordinates = AEACPXYtoLatLon(lonv, latv)
					push!(lat, coordinates[:,1])
					push!(lon, coordinates[:,2])
				else
					push!(lat, latv)
					push!(lon, lonv)
				end
				push!(label, "$(i)")
				push!(name, "$(key)")
				push!(id, "$(i)")
				i += 1
			end
		else
			lat = Vector{Union{Missing,Float64}}(undef, 0)
			lon = Vector{Union{Missing,Float64}}(undef, 0)
			if gdata.projectionVersion == 2
				i = 1
				for (key, route) in gdata.graphEdgeRoutes
					x = Vector{Float64}(undef, 0)
					y = Vector{Float64}(undef, 0)
					for cellNum in route
						x_temp, y_temp = cellToLocation(gdata, cellNum)
						push!(x, x_temp)
						push!(y, y_temp)
					end
					coordinates = AEACPXYtoLatLon(x, y)
					for v in coordinates[:,1]
						push!(lat, v)
					end
					for v in coordinates[:,2]
						push!(lon, v)
						push!(label, "$(i)")
						push!(name, "$(key)")
						push!(id, "$(i)")
					end
					# separate edges with missing values
					push!(lat, missing)
					push!(lon, missing)
					push!(label, "")
					push!(id, "")
					push!(name, "")
					i += 1
				end
			else
				i = 1
				for (key, route) in gdata.graphEdgeRoutes
					for cellNum in route
						lon_temp, lat_temp = cellToLocation(gdata, cellNum) # convert cellNum to lat, lon
						push!(lat, lat_temp)
						push!(lon, lon_temp)
						push!(label, "$(i)")
						push!(name, "$(key)")
						push!(id, "$(i)")
					end
					# separate edges with missing values
					push!(lat, missing)
					push!(lon, missing)
					push!(label, "")
					push!(name, "")
					push!(id, "")
					i += 1
				end
			end
		end
		df_network = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	else
		@warn("Candidate network data is missing!")
		df_network = DataFrames.DataFrame()
	end

	# Delaunay Pairs
	if !isdefined(gdata, :delaunayPairs) && execute
		@warn("Delaunay network data is missing! Generation of the Delaunay network will be executed ...")
		gdata.delaunayPairs = generateDelaunayNetwork(gdata, sourceSinkToCells(gdata))
	end
	if isdefined(gdata, :delaunayPairs)
		label = Vector{String}(undef, 0)
		name = Vector{String}(undef, 0)
		id = Vector{String}(undef, 0)
		if edges
			lat = Vector{Vector{Float64}}(undef, 0)
			lon = Vector{Vector{Float64}}(undef, 0)

			for i in eachindex(gdata.delaunayPairs) # iterate through each edge
				# convert vertex 1 (as a cellNum) to lat, lon and store
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v1)
					lat_temp1, lon_temp1 = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp1, lat_temp1 = cellToLocation(gdata, gdata.delaunayPairs[i].v1)
				end
				# convert vertex 2 (as a cellNum) to lat, lon and store
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v2)
					lat_temp2, lon_temp2 = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp2, lat_temp2 = cellToLocation(gdata, gdata.delaunayPairs[i].v2)
				end
				push!(lat, [lat_temp1, lat_temp2])
				push!(lon, [lon_temp1, lon_temp2])
				push!(label, "$(i)")
				push!(name, "$(i)")
				push!(id, "$(i)")
			end
		else
			lat = Vector{Union{Missing,Float64}}(undef, 0)
			lon = Vector{Union{Missing,Float64}}(undef, 0)
			for i in eachindex(gdata.delaunayPairs) # iterate through each edge
				# convert vertex 1 (as a cellNum) to lat, lon and store
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v1)
					lat_temp, lon_temp = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp, lat_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v1)
				end
				push!(lat, lat_temp)
				push!(lon, lon_temp)
				push!(label, "$(i)")
				push!(name, "$(i)")
				push!(id, "$(i)")
				# convert vertex 2 (as a cellNum) to lat, lon and store
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v2)
					lat_temp, lon_temp = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp, lat_temp = cellToLocation(gdata, gdata.delaunayPairs[i].v2)
				end
				push!(lat, lat_temp)
				push!(lon, lon_temp)
				push!(label, "$(i)")
				push!(name, "$(i)")
				push!(id, "$(i)")
				# separate edges with missing values
				push!(lat, missing)
				push!(lon, missing)
				push!(label, "")
				push!(name, "")
				push!(id, "")
			end
		end
		df_delaunay = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	else
		@warn("Delaunay network data is missing!")
		df_delaunay = DataFrames.DataFrame()
	end
	return df_source, df_sink, df_network, df_delaunay
end

function load_solution_delaunay_pairs(gdata::Data, solution::SimccsSolution; edges::Bool=false)
	label = Vector{String}(undef, 0)
	name = Vector{String}(undef, 0)
	id = Vector{String}(undef, 0)
	if edges
		lat = Vector{Vector{Float64}}(undef, 0)
		lon = Vector{Vector{Float64}}(undef, 0)
		i = 1
		for edge in eachindex(solution.pipelineFlow) # iterate through each edge
			if solution.pipelineFlow[edge] > eps(Float16)
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, edge.v1)
					lat_temp1, lon_temp1 = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp1, lat_temp1 = cellToLocation(gdata, edge.v1)
				end
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, edge.v2)
					lat_temp2, lon_temp2 = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp2, lat_temp2 = cellToLocation(gdata, edge.v2)
				end
				push!(lat, [lat_temp1, lat_temp2])
				push!(lon, [lon_temp1, lon_temp2])
				push!(label, "Flow = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
				push!(name, "$(edge.v1)=>$(edge.v2)")
				push!(id, "$(i)")
				i += 1
			end
		end
	else
		lat = Vector{Union{Missing,Float64}}(undef, 0)
		lon = Vector{Union{Missing,Float64}}(undef, 0)
		i = 1
		for edge in eachindex(solution.pipelineFlow) # iterate through each edge
			if solution.pipelineFlow[edge] > eps(Float16)
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, edge.v1)
					lat_temp, lon_temp = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp, lat_temp = cellToLocation(gdata, edge.v1)
				end
				push!(lat, lat_temp)
				push!(lon, lon_temp)
				push!(label, "Flow = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
				push!(name, "$(edge.v1)=>$(edge.v2)")
				push!(id, "$(i)")
				if gdata.projectionVersion == 2
					x_temp, y_temp = cellToLocation(gdata, edge.v2)
					lat_temp, lon_temp = AEACPXYtoLatLon([x_temp], [y_temp])
				else
					lon_temp, lat_temp = cellToLocation(gdata, edge.v2)
				end
				push!(lat, lat_temp)
				push!(lon, lon_temp)
				push!(label, "Flow = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
				push!(name, "$(edge.v1)=>$(edge.v2)")
				push!(id, "$(i)")
				push!(lat, missing)
				push!(lon, missing)
				push!(label, "")
				push!(name, "")
				push!(id, "")
			end
		end
	end
	df_solution = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	return df_solution
end

function load_solution_candidtate_network(gdata::Data, solution::SimccsSolution; edges::Bool=false)
	label = Vector{String}(undef, 0)
	name = Vector{String}(undef, 0)
	id = Vector{String}(undef, 0)
	if edges
		lat = Vector{Vector{Float64}}(undef, 0)
		lon = Vector{Vector{Float64}}(undef, 0)
		i = 1
		for edge in eachindex(solution.pipelineFlow) # iterate through each edge
			if solution.pipelineFlow[edge] > eps(Float16)
				key = Edge(edge.v1, edge.v2)
				if haskey(gdata.graphEdgeRoutes, key)
					route = gdata.graphEdgeRoutes[key]
					latv = Vector{Float64}(undef, 0)
					lonv = Vector{Float64}(undef, 0)
					for cellNum in route
						lon_temp, lat_temp = cellToLocation(gdata, cellNum)
						push!(latv, lat_temp)
						push!(lonv, lon_temp)
					end
					if gdata.projectionVersion == 2
						coordinates = AEACPXYtoLatLon(lonv, latv)
						push!(lat, coordinates[:,1])
						push!(lon, coordinates[:,2])
					else
						push!(lat, latv)
						push!(lon, lonv)
					end
					push!(label, "Flow = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
					push!(name, "$(key)")
					push!(id, "$(i)")
					i += 1
				else
					@error("$key does not exist!")
					throw("Error: data and solution do not match!")
				end
			end
		end
	else
		lat = Vector{Union{Missing,Float64}}(undef, 0)
		lon = Vector{Union{Missing,Float64}}(undef, 0)
		if gdata.projectionVersion == 2
			i = 1
			for edge in eachindex(solution.pipelineFlow) # iterate through each edge
				if solution.pipelineFlow[edge] > eps(Float16)
					key = Edge(edge.v1, edge.v2)
					if haskey(gdata.graphEdgeRoutes, key)
						route = gdata.graphEdgeRoutes[key]
						x = Vector{Float64}(undef, 0)
						y = Vector{Float64}(undef, 0)
						for cellNum in route
							x_temp, y_temp = cellToLocation(gdata, cellNum)
							push!(x, x_temp)
							push!(y, y_temp)
						end
						coordinates = AEACPXYtoLatLon(x, y)
						for v in coordinates[:,2]
							push!(lon, v)
						end
						for v in coordinates[:,1]
							push!(lat, v)
							push!(label, "Flow = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
							push!(name, "$(edge.v1)=>$(edge.v2)")
							push!(id, "$(i)")
						end
						# separate edges with missing values
						push!(lat, missing)
						push!(lon, missing)
						push!(label, "")
						push!(name, "")
						push!(id, "")
						i += 1
					else
						@error("$key does not exist!")
						throw("Error: data and solution do not match!")
					end
				end
			end
		else
			i = 1
			for edge in eachindex(solution.pipelineFlow) # iterate through each edge
				if solution.pipelineFlow[edge] > eps(Float16)
					key = Edge(edge.v1, edge.v2)
					if haskey(gdata.graphEdgeRoutes, key)
						route = gdata.graphEdgeRoutes[key]
						x = Vector{Float64}(undef, 0)
						y = Vector{Float64}(undef, 0)
						for cellNum in route
							lon_temp, lat_temp = cellToLocation(gdata, cellNum) # convert cellNum to lat, lon
							push!(lat, lat_temp)
							push!(lon, lon_temp)
							push!(label, "Q = $(round(solution.pipelineFlow[edge]; sigdigits=3))<br>Cost = $(round(solution.pipelineCost[edge]; sigdigits=3))")
							push!(name, "$(edge.v1)=>$(edge.v2)")
							push!(id, "$(i)")
						end
						# separate edges with missing values
						push!(lat, missing)
						push!(lon, missing)
						push!(label, "")
						push!(name, "")
						push!(id, "")
						i += 1
					else
						@error("$key does not exist!")
						throw("Error: data and solution do not match!")
					end
				end
			end
		end
	end
	df_solution = DataFrames.DataFrame(; id=id, label=label, name=name, lat=lat, lon=lon)
	return df_solution
end

function map(gdata::Data; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata; edges=false)
	map(; df_source=df_source, df_sink=df_sink, df_network=df_network, df_delaunay=df_delaunay, kw...)
end

function map(gdata::Data, solution::SimccsSolution; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata; edges=false)
	df_solution = load_solution_candidtate_network(gdata, solution; edges=false)
	map(; df_source=df_source, df_sink=df_sink, df_network=df_network, df_delaunay=df_delaunay, df_solution=df_solution, kw...)
end

function map(; df_source::DataFrames.DataFrame=DataFrames.DataFrame(), df_sink::DataFrames.DataFrame=DataFrames.DataFrame(), df_network::DataFrames.DataFrame=DataFrames.DataFrame(), df_delaunay::DataFrames.DataFrame=DataFrames.DataFrame(), df_solution::DataFrames.DataFrame=DataFrames.DataFrame(), filename::AbstractString="", figuredir::AbstractString=".")
	if size(df_solution, 1) > 1
		visibility = "legendonly"
	else
		visibility = ""
	end
	traces = []
	lon = Vector{Float64}(undef, 0)
	lat = Vector{Float64}(undef, 0)
	if size(df_source, 1) > 0
		sources = PlotlyJS.scattermapbox(;
			lon = df_source[!, :lon],
			lat = df_source[!, :lat],
			name = "Sources",
			hoverinfo = "text",
			text = df_source[!, :label],
			marker = Plotly.attr(; size=10, color="red")
		)
		lon = vcat(lon, df_source[!, :lon])
		lat = vcat(lat, df_source[!, :lat])
		push!(traces, sources)
	end
	if size(df_sink, 1) > 0
		sinks = PlotlyJS.scattermapbox(;
			lon = df_sink[!, :lon],
			lat = df_sink[!, :lat],
			name = "Sinks",
			hoverinfo = "text",
			text = df_sink[!, :label],
			marker = Plotly.attr(; size=10, color="orange")
		)
		lon = vcat(lon, df_sink[!, :lon])
		lat = vcat(lat, df_sink[!, :lat])
		push!(traces, sinks)
	end
	if size(df_network, 1) > 0
		network = PlotlyJS.scattermapbox(;
			lon = df_network[!, :lon],
			lat = df_network[!, :lat],
			name = "Candidate Network",
			mode = "lines",
			connectgaps = false,
			hoverinfo = "text",
			visible = visibility,
			text = df_network[!, :label],
			marker = Plotly.attr(; size=10, color="purple")
		)
		lon = vcat(lon, collect(skipmissing(df_network[!, :lon])))
		lat = vcat(lat, collect(skipmissing(df_network[!, :lat])))
		push!(traces, network)
	end
	if size(df_delaunay, 1) > 0
		delaunay = PlotlyJS.scattermapbox(;
			lon = df_delaunay[!, :lon],
			lat = df_delaunay[!, :lat],
			name = "Delaunay Network",
			mode = "lines",
			connectgaps = false,
			hoverinfo = "text",
			visible = visibility,
			text = df_delaunay[!, :label],
			marker = Plotly.attr(; size=10, color="green")
		)
		lon = vcat(lon, collect(skipmissing(df_delaunay[!, :lon])))
		lat = vcat(lat, collect(skipmissing(df_delaunay[!, :lat])))
		push!(traces, delaunay)
	end
	if size(df_solution, 1) > 0
		solution = PlotlyJS.scattermapbox(;
			lon = df_solution[!, :lon],
			lat = df_solution[!, :lat],
			name = "Solution",
			mode = "lines",
			connectgaps = false,
			hoverinfo = "text",
			text = df_solution[!, :label],
			marker = Plotly.attr(; size=10, color="green")
		)
		lon = vcat(lon, collect(skipmissing(df_solution[!, :lon])))
		lat = vcat(lat, collect(skipmissing(df_solution[!, :lat])))
		push!(traces, solution)
	end
	lonmin = minimum(lon)
	latmin = minimum(lat)
	lonmax = maximum(lon)
	latmax = maximum(lat)
	lonr = lonmax - lonmin
	latr = latmax - latmin
	lonc = lonmin + lonr / 2
	latc = latmin + latr / 2
	dx = max(lonr, latr)
	zoom = dx > 20 ? 3 : 4
	layout = PlotlyJS.Layout(;
		plot_bgcolor = "#fff",
		mapbox = Plotly.attr(; style="stamen-terrain", zoom=zoom, center=Plotly.attr(; lon=lonc, lat=latc)),
		showlegend = true)
	p = PlotlyJS.plot(convert(Array{typeof(traces[1])}, traces), layout)
	if filename != ""
		fn = joinpathcheck(figuredir, filename)
		recursivemkdir(fn)
		PlotlyJS.savefig(p, fn; format="html")
	end
	return p
end

function map_sources(gdata::Data; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata)
	map_data(df_source; name="Sources", mode="markers", kw...)
end

function map_sinks(gdata::Data; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata)
	map_data(df_sink; name="Sinks", mode="markers", kw...)
end

function map_candidate_network(gdata::Data; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata; edges=true)
	map_data(df_network; name="Candidate Network", edges=true, kw...)
end

function map_delaunay_network(gdata::Data; kw...)
	df_source, df_sink, df_network, df_delaunay = load_dataframes(gdata; edges=true)
	map_data(df_delaunay; name="Delaunay", edges=true, kw...)
end

function map_solution(gdata::Data, solution::SimccsSolution; kw...)
	df_solution = load_solution_candidtate_network(gdata, solution; edges=true)
	map_data(df_solution; name="SimccsSolution", edges=true, kw...)
end

function map_data(df::DataFrames.DataFrame; port::Integer=8050, ip=string(Sockets.getipaddr()), name::AbstractString="", color::AbstractString="#0074D9", color_selected::AbstractString="#7FDBFF", mode::AbstractString="markers", edges::Bool=false)
	if edges
		lon = vcat(df[!, :lon]...)
		lat = vcat(df[!, :lat]...)
	else
		lon = collect(skipmissing(df[!, :lon]))
		lat = collect(skipmissing(df[!, :lat]))
	end
	lonmin = minimum(lon)
	latmin = minimum(lat)
	lonmax = maximum(lon)
	latmax = maximum(lat)
	lonr = lonmax - lonmin
	latr = latmax - latmin
	lonc = lonmin + lonr / 2
	latc = latmin + latr / 2
	dx = max(lonr, latr)
	zoom = dx > 20 ? 3 : 4
	layout = PlotlyJS.Layout(;
		plot_bgcolor = "#fff",
		height = 800,
		mapbox = Plotly.attr(; style="stamen-terrain", zoom=zoom, center=Plotly.attr(; lon=lonc, lat=latc)),
		showlegend = true)
	app = Dash.dash(; suppress_callback_exceptions=true)
	app.layout = Dash.html_div([
		Dash.dash_datatable(
			id="interactive-table",
			columns=[Dict("name"=>i, "id"=>i, "deletable"=>true, "selectable"=>true) for i in names(df)[1:end-2]],
			data=Dict.(pairs.(eachrow(df))),
			editable=true,
			filter_action="native",
			sort_action="native",
			sort_mode="multi",
			column_selectable="single",
			row_selectable="multi",
			row_deletable=true,
			selected_rows=[],
			selected_columns=[],
			page_action="native",
			page_current=0,
			page_size=10
		),
		Dash.html_div(id="interactive-map")
	])
	Dash.callback!(app,
		Dash.Output("interactive-table", "style_data_conditional"),
		Dash.Input("interactive-table", "selected_columns")
	) do selected_columns
		return [Dict("if"=>Dict("column_id"=>i), "background_color"=>"#CCC") for i in selected_columns]
	end
	Dash.callback!(app,
		Dash.Output("interactive-map", "children"),
		Dash.Input("interactive-table", "derived_virtual_data"),
		Dash.Input("interactive-table", "derived_virtual_selected_rows")
	) do derived_virtual_data, derived_virtual_selected_rows
		dff = (derived_virtual_data isa Nothing) ? df : DataFrames.DataFrame(derived_virtual_data)
		global dash_df = dff
		if derived_virtual_selected_rows isa Nothing
			derived_virtual_selected_rows = []
		else
			derived_virtual_selected_rows = derived_virtual_selected_rows .+ 1
		end
		if edges
			traces = []
			for i in 1:DataFrames.nrow(dff)
				r = dff[i, :]
				colorl = i in derived_virtual_selected_rows ? color_selected : color
				push!(traces, PlotlyJS.scattermapbox(;
					lon = r.lon,
					lat = r.lat,
					name = name * " line $i",
					mode = "lines",
					hoverinfo = "none",
					showlegend = false,
					line = Plotly.attr(color=colorl; width=2)
				))
			end
			for i in 1:DataFrames.nrow(dff)
				colorp = i in derived_virtual_selected_rows ? color_selected : color
				r = dff[i, :]
				if length(r.lon) > 2
					lon = [r.lon[convert(Int64, floor(length(r.lon) / 2))]]
					lat = [r.lat[convert(Int64, floor(length(r.lat) / 2))]]
				else
					lon = [sum(r.lon) / length(r.lon)]
					lat = [sum(r.lat) / length(r.lat)]
				end
				push!(traces, PlotlyJS.scattermapbox(;
					lon = lon,
					lat = lat,
					name = name * " point $i",
					mode = "markers",
					hoverinfo = "text",
					text = [r.id],
					showlegend = false,
					marker = Plotly.attr(; size=9, color=colorp)
				))
			end
			p = convert(Array{typeof(traces[1])}, traces)
		else
			colors = [(i in derived_virtual_selected_rows ? color_selected : color) for i in 1:DataFrames.nrow(dff)]
			p = PlotlyJS.scattermapbox(;
				lon = dff[!, :lon],
				lat = dff[!, :lat],
				name = name,
				mode = mode,
				connectgaps = false,
				hoverinfo = "text",
				text = dff[!, :id],
				line = Plotly.attr(color=colors),
				marker = Plotly.attr(; size=10, color=colors)
			)
		end
		return [Dash.dcc_graph(id="interactive-plot", figure=PlotlyJS.plot(p, layout))]
	end
	Dash.callback!(app,
		Dash.Output("interactive-table", "selected_rows"),
		Dash.Input("interactive-plot", "selectedData"),
		Dash.Input("interactive-plot", "clickData")
	) do selectedData, clickData
		if !(selectedData isa Nothing)
			if edges
				# @show selectedData
				ids = [parse(Int64, i.text) for i in selectedData.points]
				lbs = parse.(Int64, dash_df[!, :id])
				s = indexin(ids, lbs) .- 1
			else
				s = [i.pointIndex for i in selectedData.points]
			end
			return s
		elseif !(clickData isa Nothing)
			if edges
				# @show clickData
				ids = Vector{Int64}(undef, 0)
				for i in clickData.points
					if haskey(i, :text)
						push!(ids, parse(Int64, i.text))
					end
				end
				lbs = parse.(Int64, dash_df[!, :id])
				s = indexin(ids, lbs) .- 1
			else
				s = [i.pointIndex for i in clickData.points]
			end
			return s
		else
			Dash.throw(Dash.PreventUpdate())
		end
	end
	stop_dash_server()
	start_dash_server(app; ip=ip, port=port)
end

function start_dash_server(app; port::Integer=8050, ip=string(Sockets.getipaddr()))
	Dash.enable_dev_tools!(app; debug=true, dev_tools_ui=true, dev_tools_serve_dev_bundles=true)
	handler = Dash.make_handler(app)
	global dash_server = Sockets.listen(Dash.get_inetaddr(ip, port))
	global dash_task = @async HTTP.serve(handler, ip, port; server=dash_server, verbose=true)
end

function stop_dash_server()
	if isdefined(SimCCSpro, :dash_server)
		close(dash_server)
	end
end