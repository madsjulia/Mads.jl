using Stipple, StippleUI
using Genie.Renderer.Html
using Colors
using FileIO

const IMGPATH = "img/demo.png"

@reactive mutable struct Dashboard <: ReactiveModel
	imageurl::R{String} = IMGPATH
	newimage::R{Bool} = false
end

function handlers(model)
	on(model.newimage) do x
		# if button value was set to false, ignore
		x == false && return nothing

		# get and save the new image
		image = rand(RGB, 100, 100)
		save(joinpath(@__DIR__, "public", IMGPATH), image)

		# add an (invalid) anchor to the imagepath in order to trigger a reload in the Quasar/Vue backend
		model.imageurl[] = "/$IMGPATH#$(Base.time())"

		# reset the button
		model.newimage[] = false
	end
	return model
end

function ui(model)
	page(model, [
		heading("Image Demo"),

		row(cell(class="st-module", [
			btn(label="New Image", click!! = "newimage=true"),
			imageview(src=:imageurl, spinnercolor="white", style="height: 140px; max-width: 150px")
		])),

		footer(class="st-footer q-pa-md", cell([
			img(class="st-logo", src="/img/st-logo.svg"),
			span(" &copy; 2020 - Happy coding ...")
		]))
	], title = "Image Demo")
end

route("/") do
	model = init(Dashboard, debounce=1) |> handlers

	html(ui(model), context = @__MODULE__)
end

up(open_browser = true)