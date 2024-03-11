import Stipple
import StippleUI

@Stipple.vars Inverter begin
  process::Bool = false
  input::String  = ""
  # you can explicitly define the type of the variable
  output::String = ""
  images_filename::Vector{String} = []
end

function handlers(model)
  Stipple.on(model.input) do input
	  model.output[] = reverse(input)
  end
  Stipple.onbutton(model.process) do
	  model.output[] = reverse(model.output)
  end
  return model
end

function ui()
  Stipple.row(Stipple.cell(class = "st-module", [
	StippleUI.textfield(class = "q-my-md", "Input", :input, hint = "Please enter some words", @Stipple.on("keyup.enter", "process = true"))

	StippleUI.btn(class = "q-my-md", "Action!", @Stipple.click(:process), color = "primary")

	StippleUI.card(class = "q-my-md", [
	  StippleUI.card_section(Stipple.h2("Output"))
	  StippleUI.card_section("Variant 1: {{ output }}")
	  StippleUI.card_section(["Variant 2: ", Stipple.span(class = "text-red", @Stipple.text(:output))])
	])
  ]))
end

Stipple.route("/") do
  model = Inverter |> Stipple.init |> handlers
  Stipple.page(model, ui()) |> Stipple.html
end

Stipple.up()