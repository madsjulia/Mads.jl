import PyCall
import PyPlot
import Mads

m3d = PyCall.pyimport("mpl_toolkits.mplot3d")
PyPlot.matplotlib.rc("font", size=15)

color = "gray"
PyPlot.matplotlib.rc("text"; color=color)
PyPlot.matplotlib.rc("axes"; labelcolor=color)
PyPlot.matplotlib.rc("xtick"; color=color)
PyPlot.matplotlib.rc("ytick"; color=color)

PyPlot.svg(true)

n = 50
x = collect(range(-3, 3; length=n))
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

PyPlot.clf()
fig = PyPlot.figure(figsize=(8, 6))
ax = fig.gca(projection="3d")
ax.set_zlim(-0.5, 1.0)
xgrid, ygrid = Mads.meshgrid(x, y)
ax.plot_surface(xgrid, ygrid, zcos, rstride=2, cstride=2, cmap=PyPlot.ColorMap("jet"), alpha=0.7, linewidth=0.25)
PyPlot.gcf()

PyPlot.clf()
PyPlot.surf(zcos)
PyPlot.gcf()

PyPlot.clf()
X = zeros(40, 30, 20);
nx, ny, nz = size(X)
X[1,1,1] = 1
X[end,end,end] = -1
fig = PyPlot.figure(figsize=(8, 6))
fig.patch.set_facecolor("none")
fig.patch.set_alpha(0.0)
ax = fig.gca(projection="3d")
ax.patch.set_facecolor("none")
ax.patch.set_alpha(0.0)
ax.set_xlim(1, nx)
ax.set_ylim(1, ny)
ax.set_zlim(1, nz)
xgrid, ygrid = Mads.meshgrid(nx, ny)
ax.contourf(xgrid, ygrid, X[:,:,end], [-1, -0.5, 0, 0.5, 1], zdir="z", offset=nz)
xgrid, zgrid = Mads.meshgrid(nx, nz)
ax.contourf(xgrid, X[:,1,:], zgrid, [-1, -0.5, 0, 0.5, 1], zdir="y", offset=1)
ygrid, zgrid = Mads.meshgrid(ny, nz)
cax = ax.contourf(X[1,:,:], ygrid, zgrid, [-1, -0.5, 0, 0.5, 1], zdir="x", offset=nx)
# PyPlot.colorbar(cax)
PyPlot.draw()
PyPlot.gcf()

PyPlot.clf()
X = rand(40, 30, 20)
nx, ny, nz = size(X)
fig = PyPlot.figure(figsize=(8, 6))
fig.patch.set_facecolor("none")
fig.patch.set_alpha(0.0)
ax = fig.gca(projection="3d")
ax.patch.set_facecolor("none")
ax.patch.set_alpha(0.0)
ax.set_xlim(1, nx)
ax.set_ylim(1, ny)
ax.set_zlim(1, nz)
# ax.axis("off")
xgrid, ygrid = Mads.meshgrid(nx, ny)
ax.contourf(xgrid, ygrid, X[:,:,end], 100, vmin=0, vmax=1, zdir="z", offset=nz)
xgrid, zgrid = Mads.meshgrid(nx, nz)
ax.contourf(xgrid, X[:,1,:], zgrid, 100, vmin=0, vmax=1, zdir="y", offset=1)
ygrid, zgrid = Mads.meshgrid(ny, nz)
cax = ax.contourf(X[end,:,:], ygrid, zgrid, 100, vmin=0, vmax=1, zdir="x", offset=nx)
# PyPlot.colorbar(cax)
PyPlot.draw()
PyPlot.gcf()