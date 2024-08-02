import Stipple
import StippleUI

@Stipple.vars Inverter begin
	process::Bool = false
	input::String = ""
	output::String
end

function handlers(model)
	Stipple.on(model.input) do input
		model.output[] = input |> reverse
	end
	Stipple.onbutton(model.process) do
		model.output[] = model.output[] |> reverse
	end
	return model
end

function ui()
	row(cell(class = "st-module", [
		textfield(class = "q-my-md", "Input", :input, hint = "Please enter some words", @on("keyup.enter", "process = true"))

		btn(class = "q-my-md", "Action!", @click(:process), color = "primary")

		card(class = "q-my-md", [
			card_section(h2("Output"))
			card_section("Variant 1: {{ output }}")
			card_section(["Variant 2: ", span(class = "text-red", @text(:output))])
		])
	]))
end

route("/") do
	model = Inverter |> init |> handlers
	page(model, ui()) |> html
end

Genie.isrunning(:webserver) || up()