import Stipple
import StippleUI

mutable struct Test
	a::Int64
	b::String
	Test() = new(0, "")
end

@Stipple.reactive! mutable struct UIModelCheckBox <: Stipple.ReactiveModel
	click::Stipple.R{Int64} = 0
	test::Test = Test()
	test2::Stipple.R{Test} = Test()
	checks::Stipple.R{Vector{Bool}} = falses(2)
end

function ui(ui_model_check_box)
	Stipple.page(ui_model_check_box, class="container", [
		Stipple.cell(class="st-module", [
			Stipple.button("Click", @StippleUI.click("click += 1"))
		]),
		StippleUI.separator(),
		Stipple.h5("Clicks: {{this.checks.length}}"),
		Stipple.p([
			"Clicks: "
			Stipple.span(ui_model_check_box.click, @Stipple.text(:click))
		  ]),
		Stipple.h5("Test: $(ui_model_check_box.test)"),
		Stipple.h5("Test: $(ui_model_check_box.test2[])"),
		Stipple.p([
			"Value: "
			Stipple.span(ui_model_check_box.test2.a, @Stipple.text(:(test2.a)))
		  ]),
		Stipple.h5("Test: {{this.test.a}}"),
		Stipple.h5("Test2: {{this.test2.a}}"),
		Stipple.Html.div(
			StippleUI.quasar(:checkbox, label = Stipple.R"'checkbox ' + index", fieldname = Stipple.R"checks[index]"),
			Stipple.@recur("(item, index) in checks")
		)
	])
end

function handlers(ui_model_check_box)
	Stipple.on(ui_model_check_box.isready) do ready
		ui_model_check_box.test.a = 5
		ui_model_check_box.test2[].a = 6
		ready || return
		push!(ui_model_check_box)
	end

	Stipple.on(ui_model_check_box.click) do (_...)
		ui_model_check_box.test.a += 1
		ui_model_check_box.test2[].a += 1
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