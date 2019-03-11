import Gadfly
import Mads

Random.seed!(2016)

t = 0:0.005:5
t0 = -5:0.005:0
tf = ([t0; t] + 5) * 10

# signal 1
zz = 0.1
ww = 20
wn = ww / sqrt(1 - zz^2)
y1 = exp(-zz * wn * t)
y2 = sin.(ww * t) .+ rand(1001)
ys1 = y1 .* y2

# signal 2
t1 = 0:0.003:3
y1 = sin.(10 * t1) * -1
y1[1:483] = 0
y1[664:end] = 0
ys2 = y1[end:-1:1] .* y2

xm = [0, 1, 2, 3]
ym = [0, 1, 2]
xg, yg = Mads.meshgrid(xm, ym)

s1 = (1.5, 2.1)
s2 = (2.3, 1.8)

pg = Array{Gadfly.Plot}(undef, length(xm), length(ym))

function shift(d::Number, y::Vector)
	i = Int(floor(d * 300))
	if i > 999
		i = 999
	end
	[zeros(1+i); y; zeros(1000-i)] .+ rand(2002) ./ 10
end

for i = 1:length(xm)
	for j = 1:length(ym)
		x = xg[j, i]
		y = yg[j, i]
		d1 = sqrt((x-s1[1])^2 + (y-s1[2])^2)
		d2 = sqrt((x-s2[1])^2 + (y-s2[2])^2)
		s = shift(d1, ys1) + shift(d2, ys2)
		pg[i, j] = Gadfly.plot(x=tf, y=s, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=Base.parse(Colors.Colorant, "blue"), background_color=Base.parse(Colors.Colorant, "white")))
	end
end

p = Gadfly.gridstack(pg);
Gadfly.draw(Gadfly.PNG("waves-tensor.png", length(ym) * 5Gadfly.inch, length(xm) * 3Gadfly.inch, dpi=300), p)