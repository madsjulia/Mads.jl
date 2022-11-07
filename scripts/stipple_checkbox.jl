import Stipple
import StippleUI

@Stipple.reactive! mutable struct Model <: Stipple.ReactiveModel
	click::Stipple.R{Int64} = 0
	checks::Stipple.R{Vector{Bool}} = falses(2)
end

function ui(model)
	Stipple.page(model, class="container", [
		Stipple.cell(class="st-module", [
			Stipple.button("Click", @StippleUI.click("click += 1"))
		]),
		StippleUI.separator(),
		# Stipple.h5("Clicks: $(length(model.checks[]))"), # this does not work
		Stipple.h5("Clicks: {{this.checks.length}}"),
		Stipple.Html.div(
			StippleUI.quasar(:checkbox, label = Stipple.R"'checkbox ' + index", fieldname = Stipple.R"checks[index]"),
			Stipple.@recur("(item, index) in checks")
		)
		# StippleUI.checkbox(Stipple.R"'checkbox ' + index", Stipple.R"checks[index]"),
		# Stipple.@recur("(item, index) in checks")
	])
end

function handlers(model)
	Stipple.on(model.isready) do ready
		ready || return
		push!(model)
	end

	Stipple.on(model.click) do (_...)
		push!(model.checks[], false)
		@show model.checks[] # the array increases
		Stipple.notify(model.checks) # notify does not work
	end
	return model
end

model = handlers(Stipple.init(Model))

Stipple.route("/") do
	Stipple.html(ui(model); context = @__MODULE__)
end

Stipple.down()
Stipple.up(async = true)