import Dash
import CSV
import JSON
import JSONTables
import DataFrames

df = DataFrames.DataFrame(label=["Cats", "Dogs", "Horses"], lat=[1.3, 2.1, 5.5], lon=[2.3, 1.1, 2.5], height=[30.1, 50.1, 200.1], width=[10.1, 10.1, 10.1])
app = Dash.dash()

app.layout = Dash.html_div([
	Dash.dash_datatable(
		id="interactive-datatable",
		columns=[
			Dict("name"=>i, "id"=>i, "deletable"=>true, "selectable"=>true) for i in names(df)
		],
		data=Dict.(pairs.(eachrow(df))),
		editable=true,
		filter_action="native",
		sort_action="native",
		sort_mode="multi",
		column_selectable="single",
		row_selectable="multi",
		row_deletable=true,
		selected_columns=[],
		selected_rows=[],
		page_action="native",
		page_current= 0,
		page_size= 10
	),
	Dash.html_div(id="interactive-datatable-container")
])

Dash.callback!(app,
	Dash.Output("interactive-datatable", "style_data_conditional"),
	Dash.Input("interactive-datatable", "selected_columns")
) do selected_columns
	return [Dict(
		"if"=>Dict("column_id"=>i),
		"background_color"=>"#CCC"
	) for i in selected_columns]
end

Dash.callback!(app,
	Dash.Output("interactive-datatable-container", "children"),
	Dash.Input("interactive-datatable", "derived_virtual_data"),
	Dash.Input("interactive-datatable", "derived_virtual_selected_rows")
) do rows, derived_virtual_selected_rows
	# When the table is first rendered, `derived_virtual_data` and
	# `derived_virtual_selected_rows` will be `None`. This is due to an
	# idiosyncrasy in Dash (nonsupplied properties are always None and Dash
	# calls the dependent callbacks when the component is first rendered).
	# So, if `rows` is `None`, then the component was just rendered
	# and its value will be the same as the component"s dataframe.
	# Instead of setting `None` in here, you could also set
	# `derived_virtual_data=df.to_rows("dict")` when you initialize
	# the component.
	if derived_virtual_selected_rows isa Nothing
		derived_virtual_selected_rows = []
	end
	# jtable = JSONTables.jsontable(rows)
	# display(jtable)
	# dff = (rows isa Nothing) ? df : DataFrames.DataFrame(jtable)
	# @show dff
	dff = df
	colors = [(i in derived_virtual_selected_rows ? "#7FDBFF" : "#0074D9") for i in 1:DataFrames.nrow(dff)]
	return [
		if column in names(dff)
			Dash.dcc_graph(
				id = column,
				figure = Dict(
					"data"=>[
						Dict(
							"x"=>dff[!, "label"],
							"y"=>dff[!, column],
							"type"=>"bar",
							"marker"=>Dict("color"=>colors),
						)
					],
					"layout"=>Dict(
						"xaxis"=>Dict("automargin"=>true),
						"yaxis"=>Dict(
							"automargin"=>true,
							"title"=>Dict("text"=>column)
						),
						"height"=>250,
						"margin"=>Dict("t"=>10, "l"=>10, "r"=>10),
					),
				),
			)
			# check if column exists - user may have deleted it
			# If `column.deletable=False`, then you don't
			# need to do this check.
		end
		for column in ["lat", "lon"]
	]
end

Dash.run_server(app, "127.0.0.1"; debug=true)

