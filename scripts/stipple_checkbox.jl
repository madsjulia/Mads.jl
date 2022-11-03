import Stipple
import StippleUI

@Stipple.reactive! mutable struct Model <: Stipple.ReactiveModel
	click::Stipple.R{Int64} = 0
	checks::Stipple.R{Vector{Bool}} = falses(0)
end

function ui(model)
	Stipple.on(model.click) do (_...)
		push!(model.checks[], false)
		@show model.checks[] # the array increases
		Stipple.notify(model.checks)
	end
	Stipple.page(model, class="container", [
		Stipple.cell(class="st-module", [
			Stipple.button("Click", @StippleUI.click("click += 1"))
		]),
		StippleUI.separator(),
		# However, length(model.checks[]) stays equal to zero
		[StippleUI.checkbox("Checkbox $i", Symbol("checks[$(i-1)]")) for i in 1:length(model.checks[])]...,

	])
end

model = Stipple.init(Model)

Stipple.route("/") do
	Stipple.html(ui(model); context = @__MODULE__)
end

Stipple.down()
Stipple.up(async = true)