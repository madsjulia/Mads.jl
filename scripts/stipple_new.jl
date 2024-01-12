import Stipple

@Stipple.vars Name begin
	name::R{String} = "World!"
end

function ui()
	[
		Stipple.h1([
			"Hello "
			Stipple.span("", @Stipple.text(:name))
		])

		Stipple.p([
			"What is your name? "
			Stipple.input("", placeholder="Type your name", @Stipple.bind(:name))
		])
	]
end

Stipple.route("/") do
	global model
	model = Name
	Stipple.init(model)
	Stipple.html(Stipple.page(model, ui()))
end

up()