import Gadfly

srand(2016)

t = 0:0.005:5
t0 = -5:0.005:0

z = 0.2
w = 10
wn = w / sqrt(1 - z^2)
y1 = exp(-z * wn * t)
y3 = rand(1001)
y2 = sin(w * t) .+ y3
y = y1 .* y2
tf = ([t0; t] + 5) * 10
yf1 = [zeros(1001); y]
yf2 = [zeros(501); y; zeros(500)]
yf3 = [zeros(201); y; zeros(800)]

p = Gadfly.plot(x=tf, y=yf, Gadfly.Geom.line)
Gadfly.draw(Gadfly.PNG("wave-1.png", 8Gadfly.inch, 4Gadfly.inch), p)

p = Gadfly.plot(x=tf, y=yf2, Gadfly.Geom.line)
Gadfly.draw(Gadfly.PNG("wave-2.png", 8Gadfly.inch, 4Gadfly.inch), p)

p = Gadfly.plot(x=tf, y=yf3, Gadfly.Geom.line)
Gadfly.draw(Gadfly.PNG("wave-3.png", 8Gadfly.inch, 4Gadfly.inch), p)