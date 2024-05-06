import Stipple
import StippleUI

Stipple.@vars Name begin
	name::String = "World!"
	names::Vector{String} = ["World!", "Stipple!"]
end

function ui()
	[
		Stipple.row([
			Stipple.cell(class="st-module", xs=5, sm=4, md=3, lg=2, xl=1,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			),
			Stipple.cell(class="st-module", xs=7, sm=8, md=9, lg=10, xl=11,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			)
		])
		Stipple.row([
			Stipple.cell(class="st-module", xs=5, sm=4, md=3, lg=2, xl=1,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			),
			Stipple.cell(class="st-module", xs=6, sm=7, md=8, lg=9, xl=10,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			)
		])
		Stipple.row([
			Stipple.cell(class="st-module", xs=5, sm=4, md=3, lg=2, xl=1,
				Stipple.select(name; options=names, class="text-p", style="font-size: 13px;", color="white", bgcolor="bg-grey-8", popupcontentclass="bg-grey-9", label="Dataset:", labelcolor="orange")
			),
			Stipple.cell(class="st-module", xs=6, sm=7, md=8, lg=9, xl=10,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			)
		])
	]
end

Stipple.route("/") do
	Stipple.page(Stipple.init(Name), ui()) |> Stipple.html
end

Stipple.up()