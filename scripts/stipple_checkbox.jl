import Stipple
import StippleUI

@Stipple.reactive! mutable struct UIModelCheckBox <: Stipple.ReactiveModel
	click::Stipple.R{Int64} = 0
	checks::Stipple.R{Vector{Bool}} = falses(2)
end

function ui(ui_model_check_box)
	Stipple.page(ui_model_check_box, class="container", [
		Stipple.cell(class="st-module", [
			Stipple.button("Click", @StippleUI.click("click += 1"))
		]),
		StippleUI.separator(),
		Stipple.h5("Clicks: {{this.checks.length}}"),
		Stipple.Html.div(
			StippleUI.quasar(:checkbox, label = Stipple.R"'checkbox ' + index", fieldname = Stipple.R"checks[index]"),
			Stipple.@recur("(item, index) in checks")
		)
	])
end

function handlers(ui_model_check_box)
	Stipple.on(ui_model_check_box.isready) do ready
		ready || return
		push!(ui_model_check_box)
	end

	Stipple.on(ui_model_check_box.click) do (_...)
		push!(ui_model_check_box.checks[], false)
		Stipple.notify(ui_model_check_box.checks)
	end
	return ui_model_check_box
end

ui_model_check_box = handlers(Stipple.init(UIModelCheckBox))

Stipple.route("/") do
	Stipple.html(ui(ui_model_check_box); context = @__MODULE__)
end

Stipple.down()
Stipple.up(; async=true)