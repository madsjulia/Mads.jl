# Comment

# Expressions
3 * 6 + 4
pi
r = sin(pi / 2)

# Chinese can be used
朱莉婭 = 5
r = 朱莉婭 * 4

# Function
function double(x)
	return 2 * x
end
double(x) = 2 * x

double(10)

const φ = golden

function foo(z)
	c = (φ - 2) + (φ - 1)im
	max = 80
	for n = 1:max
		abs(z) ≥ 2 && return n - 1
		z = z^2 + c
	end
	return max
end

foo(0)
foo(0.1 + 0.5im)

foo(x, y) = foo(x + y*im)

# this function uses the global function foo
function foo_grid(n)
	zcos = Array{Float64}(undef, n, n)
	x = collect(linspace(-0.5, 1, n))
	y = collect(linspace(-0.5, 1, n))
	for i in 1:n
			for j in 1:n
					zcos[j, i] = foo(x[i], y[j])
			end
	end
	return zcos
end

# alternative way to define foo_grid
foo_grid(n) = broadcast(foo, linspace(-0.5, 1, n)', linspace(-1, 0.5, n))

foo_grid(500)

import Images
Images.convert(Image, Images.scale(foo_grid(500), 1/80))