import Gadfly

Random.seed!(2016)

t = collect(0:0.0025:5)
tf = t * 20

xm = [0, 1, 2, 3]
ym = [0, 1, 2]
xg, yg = Mads.meshgrid(xm, ym)

s1 = (1.5, 2.1)
s2 = (2.3, 1.8)

pg = Array{Gadfly.Plot}(undef, length(xm), length(ym))

function shift(d::Number, t::Vector, scale::Number)
	ss = d * 1
	s = sin.(scale * t + ss) .+ rand(2001) ./ 10
	q = Int(floor((4-d)^2 * 100))
	for i = 1:q
		s[i] *= i/q
	end
	for i = q:length(s)
		s[i] *= q/i
	end
	return s
end

for i = 1:length(xm)
	for j = 1:length(ym)
		x = xg[j, i]
		y = yg[j, i]
		d1 = sqrt((x-s1[1])^2 + (y-s1[2])^2)
		d2 = sqrt((x-s2[1])^2 + (y-s2[2])^2)
		s = shift(d1, t, 20) + shift(d2, t, 10)
		pg[i, j] = Gadfly.plot(x=tf, y=s, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=Base.parse(Colors.Colorant, "red"), background_color=Base.parse(Colors.Colorant, "white")))
	end
end

p = Gadfly.gridstack(pg);
Gadfly.draw(Gadfly.PNG("heat-tensor.png", length(ym) * 5Gadfly.inch, length(xm) * 3Gadfly.inch, dpi=300), p)