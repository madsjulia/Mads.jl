import Gadfly

Random.seed!(100)
x = 1:10
y = rand(10)

Gadfly.plot(x=x, y=y)
Gadfly.plot(x=x, y=y, Gadfly.Geom.point, Gadfly.Geom.line)
Gadfly.plot(x=x, y=2.^y,
	Gadfly.Scale.y_sqrt, Gadfly.Geom.point, Gadfly.Geom.smooth,
	Gadfly.Guide.xlabel("Time"), Gadfly.Guide.ylabel("Response"), Gadfly.Guide.title("Training"))
func_plot(x) = sin.(x) + sqrt(x)
Gadfly.plot([sin, cos, sqrt, func_plot], 0, 25)

import PyPlot

PyPlot.svg(true)
PyPlot.clf()
PyPlot.figure()
PyPlot.plot(x, y)
PyPlot.gcf()
PyPlot.clf()
PyPlot.close()

PyPlot.figure()
x = linspace(0, 25, 100)
PyPlot.plot(x, sin.(x))
PyPlot.plot(x, cos(x))
PyPlot.plot(x, sqrt(x))
PyPlot.plot(x, func_plot(x))
PyPlot.legend(["sin", "cos", "sqrt", "func_plot"], loc="lower left")
PyPlot.gcf()

PyPlot.clf()
PyPlot.close()