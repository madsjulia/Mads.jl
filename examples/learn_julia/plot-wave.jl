import Gadfly

srand(2016)

t = 0:0.005:5
t0 = -5:0.005:0

z = 0.1
w = 20
wn = w / sqrt(1 - z^2)
y1 = exp(-z * wn * t)
y2 = sin(w * t) .+ rand(1001)
y = y1 .* y2
tf = ([t0; t] + 5) * 10
yf11 = [zeros(1001); y] .+ rand(2002) ./ 10
yf12 = [zeros(501); y; zeros(500)] .+ rand(2002) ./ 10
yf13 = [zeros(201); y; zeros(800)] .+ rand(2002) ./ 10

p = Gadfly.plot(x=tf, y=yf11, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "red")))
Gadfly.draw(Gadfly.PNG("wave1-1.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf12, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "blue")))
Gadfly.draw(Gadfly.PNG("wave1-2.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf13, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "green")))
Gadfly.draw(Gadfly.PNG("wave1-3.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

t1 = 0:0.003:3
y1 = sin(10 * t1) * -1
y1[1:483] = 0
y1[664:end] = 0
y2 = sin(50 * t) .+ rand(1001)
y = y1[end:-1:1] .* y2
tf = ([t0; t] + 5) * 10
yf21 = [zeros(901); y; zeros(100)] .+ rand(2002) ./ 10
yf22 = [zeros(601); y; zeros(400)] .+ rand(2002) ./ 10
yf23 = [zeros(101); y; zeros(900)] .+ rand(2002) ./ 10

p = Gadfly.plot(x=tf, y=yf21, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "red")))
Gadfly.draw(Gadfly.PNG("wave2-1.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf22, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "blue")))
Gadfly.draw(Gadfly.PNG("wave2-2.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf23, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "green")))
Gadfly.draw(Gadfly.PNG("wave2-3.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf11 .+ yf21, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "red")))
Gadfly.draw(Gadfly.PNG("waves-1.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf12 .+ yf22, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "blue")))
Gadfly.draw(Gadfly.PNG("waves-2.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)

p = Gadfly.plot(x=tf, y=yf13 .+ yf23, Gadfly.Geom.line, Gadfly.Coord.Cartesian(ymin=-2, ymax=2), Gadfly.Theme(line_width=2Gadfly.pt, default_color=parse(Colors.Colorant, "green")))
Gadfly.draw(Gadfly.PNG("waves-3.png", 8Gadfly.inch, 4Gadfly.inch, dpi=300), p)