import Stipple
import StippleUI

Stipple.@vars Name begin
	name::String = "World!"
end

function ui()
	[
		Stipple.row([
			Stipple.p(class="st-module", "Hello, Stipple long long long long long long long long long long long long long long long long long long long long long long!"),
			Stipple.p(class="st-module", "Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
		])
		Stipple.row([
			Stipple.cell(class="st-module", Stipple.p("Hello, Stipple long long long long long long long long long long long long long long long long long long long long long long!")),
			Stipple.cell(class="st-module", Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!"))
		])
		Stipple.row([
			Stipple.cell(class="st-module", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			]),
			Stipple.cell(class="st-module", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			])
		])
		Stipple.row([
			Stipple.cell(class="st-module st-col col-2 col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			]),
			Stipple.cell(class="st-module st-col col-2 col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xl-6", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			])
		])
		Stipple.row([
			Stipple.cell(class="st-module st-col col-2 col-xs-5 col-sm-3 col-md-6", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			]),
			Stipple.cell(class="st-module st-col col-2 col-xs-6 col-sm-8 col-md-6", [
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			])
		])
		Stipple.row(size=10, [
			Stipple.cell(xs=5, sm=3, md=4, lg=1, xl=2,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			),
			Stipple.cell(xs=5, sm=8, md=6, lg=6, xl=6,
				Stipple.p("Hello, World long long long long long long long long long long long long long long long long long long long long long long long!")
			)
		])
		Stipple.row([
			Stipple.cell(class="st-module", size=2, xs=4, sm=3, md=4, lg=1, xl=2,
				StippleUI.textfield(class = "q-my-md", "Who am I?", :input, hint = "Please enter some words")
			),
			Stipple.cell(class="st-module", size=2, xs=6, sm=8, md=6, lg=6, xl=6,
				StippleUI.textfield(class = "q-my-md", "Input", :input, hint = "Please enter some words")
			)
		])
	]
end

Stipple.route("/") do
	Stipple.page(Stipple.init(Name), ui()) |> Stipple.html
end

Stipple.up()