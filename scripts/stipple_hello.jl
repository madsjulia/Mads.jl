import Stipple

Stipple.@vars Name begin
	name::String = "World!"
end

function ui()
	[
		Stipple.h1([
			"Hello "
			Stipple.span("", Stipple.@text(:name))
		])
		Stipple.p([
			"What is your name? "
			Stipple.input("", placeholder="Type your name", Stipple.@bind(:name))
		])
	]
end

Stipple.route("/") do
	# global model
	# model = Stipple.init(Name)
	# Stipple.html(Stipple.page(model, ui()))
	# model = Name |> Stipple.init
	# Stipple.page(model, ui()) |> Stipple.html
	Stipple.html(Stipple.page(Stipple.init(Name), ui()))
end

Stipple.up()