# Comment

# Expression
3 * 6 + 4
pi
r = sin.(pi / 2)

# Chinese can be used
朱莉婭 = 5
r = 朱莉婭 * 4

# Function
function double(x)
	return 2 * x
end
double(x) = 2 * x

double(10)

x = rand(5, 5)

const ϕ = golden

function foo(z)
	c = (φ-2)+(φ-1)im
	max = 80
	for n = 1:max
		abs(z) ≥ 2 && return n-1
		z = z^2 + c
	end
	return max
end

foo(0)
foo(0.1+0.5im)

foo(x, y) = foo(x + y*im)

foo_grid(n) = broadcast(foo, linspace(-0.5, 1, n)', linspace(-1, 0.5, n))

# Can you see the pattern?

foo_grid(10)

# Let's try it as an image:

using Images
convert(Image, scale(foo_grid(500), 1/80))
