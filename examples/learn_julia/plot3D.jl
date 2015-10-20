using PyPlot
using Distributions
using QuantEcon

PyPlot.svg(true)

n = 50
x = collect(linspace(-3, 3, n))
y = x

zcos = Array(Float64, n, n)
fcos(x, y) = cos(x^2 + y^2) / (1 + x^2 + y^2)
for i in 1:n
    for j in 1:n
        zcos[j, i] = fcos(x[i], y[j])
    end
end

fig = PyPlot.figure(figsize=(8, 6))
ax = fig[:gca](projection="3d")
ax[:set_zlim](-0.5, 1.0)
xgrid, ygrid = QuantEcon.meshgrid(x, y)
ax[:plot_surface](xgrid, ygrid, zcos, rstride=2, cstride=2, cmap=ColorMap("jet"), alpha=0.7, linewidth=0.25)
PyPlot.gcf()

PyPlot.clf()
PyPlot.surf(zcos)
PyPlot.gcf()
