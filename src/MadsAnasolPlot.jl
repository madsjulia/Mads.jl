import Measures

"""
Plot injected/reduced contaminant mass

$(DocumentFunction.documentfunction(plotmass;
argtext=Dict("lambda"=>"array with all the lambda values",
            "mass_injected"=>"array with associated total injected mass",
            "mass_reduced"=>"array with associated total reduced mass",
            "filename"=>"output filename for the generated plot"),
keytext=Dict("format"=>"output plot format (`png`, `pdf`, etc.)")))

Dumps:

- image file with name `filename` and in specified `format`
"""
function plotmass(lambda::AbstractVector{Float64}, mass_injected::AbstractVector{Float64}, mass_reduced::AbstractVector{Float64}, filename::AbstractString; format::AbstractString="", hsize::Measures.AbsoluteLength=6Gadfly.inch, vsize::Measures.AbsoluteLength=6Gadfly.inch)
	p1 = Gadfly.plot(x=lambda, y=mass_reduced, Gadfly.Guide.xlabel("Reaction Rate Constant [1/T]"), Gadfly.Guide.ylabel("Mass Reduced [kg]"), Gadfly.Geom.point, Gadfly.Scale.x_log10, Gadfly.Scale.y_log10)
	# Base.display(p1)
	p2 = Gadfly.plot(x=mass_injected, y=mass_reduced, Gadfly.Guide.xlabel("Mass Injected [kg]"), Gadfly.Guide.ylabel("Mass Reduced [kg]"), Gadfly.Geom.point, Gadfly.Scale.x_log10, Gadfly.Scale.y_log10)
	# Base.display(p2)
	p3 = Gadfly.plot(x=mass_injected, y=mass_reduced./mass_injected, Gadfly.Guide.xlabel("Mass Injected [kg]"), Gadfly.Guide.ylabel("Fraction of the Reduced Mass [-]"), Gadfly.Geom.point, Gadfly.Scale.x_log10, Gadfly.Scale.y_log10)
	# Base.display(p3)
	p = Gadfly.vstack(p1, p2, p3)
	plotfileformat(p, filename, hsize, vsize; format=format, dpi=imagedpi)
	return
end
