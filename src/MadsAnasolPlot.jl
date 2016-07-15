import Gadfly

"""
Plot injected/reduced contaminant mass

- `Mads.plotmass(lambda, mass_injected, mass_reduced, filename="file_name")`

Arguments:

- `lambda` : array with all the lambda values
- `mass_injected` : array with associated total injected mass
- `mass_reduced` : array with associated total reduced mass
- `filename` : output filename for the generated plot
- `format` : output plot format (`png`, `pdf`, etc.)

Dumps: image file with name `filename` and in specified `format`
"""
function plotmass(lambda, mass_injected, mass_reduced, filename::AbstractString; format="")
	p1 = Gadfly.plot(x=lambda, y=mass_reduced, Gadfly.Guide.xlabel("Reaction Rate Constant [1/d]"), Gadfly.Guide.ylabel("Mass Reduced [kg]"), Geom.point, Scale.x_log10, Scale.y_log10)
	display(p1)
	p2 = Gadfly.plot(x=mass_injected, y=mass_reduced, Gadfly.Guide.xlabel("Mass Injected [kg]"), Gadfly.Guide.ylabel("Mass Reduced [kg]"), Geom.point, Scale.x_log10, Scale.y_log10)
	display(p2)
	p3 = Gadfly.plot(x=mass_injected, y=mass_reduced./mass_injected, Gadfly.Guide.xlabel("Mass Injected [kg]"), Gadfly.Guide.ylabel("Fraction of the Reduced Mass [-]"), Geom.point, Scale.x_log10, Scale.y_log10)
	display(p3)
	filename, format = setimagefileformat(filename, format)
	p = Gadfly.vstack(p1, p2, p3)
	Gadfly.draw(Gadfly.eval(symbol(format))(filename, 6Gadfly.inch, 8Gadfly.inch), p)
	return
end
