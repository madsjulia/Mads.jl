import PyPlot
import Mads

PyPlot.svg(true)

n = 50
x = collect(linspace(-3, 3, n))
y = x

zcos = Array{Float64}(undef, n, n)
fcos(x, y) = cos(x^2 + y^2) / (1 + x^2 + y^2)
# zcos computed using for loops
for i in 1:n
	for j in 1:n
		zcos[j, i] = fcos(x[i], y[j])
	end
end
# zcos computed using broadcast
zcos = broadcast(fcos, x', y)

fig = PyPlot.figure(figsize=(8, 6))
ax = fig[:gca](projection="3d")
ax[:set_zlim](-0.5, 1.0)
xgrid, ygrid = Mads.meshgrid(x, y)
ax[:plot_surface](xgrid, ygrid, zcos, rstride=2, cstride=2, cmap=PyPlot.ColorMap("jet"), alpha=0.7, linewidth=0.25)
PyPlot.gcf()

PyPlot.clf()
PyPlot.surf(zcos)
PyPlot.gcf()

NN=10
X=zeros(NN,NN,NN)
X[1,1,1] = 1
X[NN,NN,NN] = -1
x = collect(linspace(1, NN, NN))
y = x
z = x
fig = PyPlot.figure(figsize=(8, 6))
ax = fig[:gca](projection="3d")
ax[:set_xlim](1, NN)
ax[:set_ylim](1, NN)
ax[:set_zlim](1, NN)
xgrid, ygrid = Mads.meshgrid(x, y)
ax[:contourf](xgrid, ygrid, slice(X,:,:,1), [-1, -0.5, 0, 0.5, 1], zdir="z", offset=1)
xgrid, zgrid = Mads.meshgrid(x, z)
ax[:contourf](xgrid, slice(X,:,:,10), zgrid, [-1, -0.5, 0, 0.5, 1], zdir="y", offset=10)
ygrid, zgrid = Mads.meshgrid(y, z)
cax=ax[:contourf](slice(X,1,:,:), ygrid, zgrid, [-1, -0.5, 0, 0.5, 1], zdir="x", offset=1)
PyPlot.colorbar(cax)
PyPlot.draw()

X=rand(NN,NN,NN)
xgrid, ygrid = Mads.meshgrid(x, y)
ax[:contourf](xgrid, ygrid, slice(X,:,:,1), 100, vmin=0, vmax=1, zdir="z", offset=1)
xgrid, zgrid = Mads.meshgrid(x, z)
ax[:contourf](xgrid, slice(X,:,:,10), zgrid, 100, vmin=0, vmax=1, zdir="y", offset=10)
ygrid, zgrid = Mads.meshgrid(y, z)
cax=ax[:contourf](slice(X,1,:,:), ygrid, zgrid, 100, vmin=0, vmax=1, zdir="x", offset=1)
PyPlot.colorbar(cax)
PyPlot.draw()