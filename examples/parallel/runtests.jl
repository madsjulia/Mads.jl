import Mads
import Base.Test

function parallel_findpi(n)
	# Simple Monte Carlo to estimate pi

	srand(2017)
	inside = @parallel (+) for i = 1:n
		x, y = rand(2)
		x^2 + y^2 <= 1 ? 1 : 0
	end
	@Base.Test.test isapprox((4 * inside / n), 3.14, atol=1e-2)
end

function time_dilation()
	# Einstein Special Relativity: time dilation 
	# t' = t / sqrt(1 - v^2 / c^2)

	c = 299792458   # Speed of light (m/s)
	t = 20          # Time (s)
	v = 0.999*c     # Velocity relative to c (m/s)

	t_prime = t / sqrt(1 - v^2 / c^2)
	return t_prime

end

function eulers_equation()
	# Euler's equation on the nature of spheres
	# V - E + F = 2

	V = 4 # Vertices
	E = 6 # Edges
	F = 4 # Faces

	@Base.Test.test ((V - E + F) == 2)
end

function schrodinger()
	# Schrodinger's equation in a 1D box:
	#  ψ(x) = sqrt(2/L)*sin(nπx/L)

	L = 1 # Length of box
	x = 1 # Position from [0, L]
	n = 0 # Energy level

	psi = sqrt(2/L)*sin(n*π*x/L)
	@Base.Test.test isapprox(psi, 0.0, atol=1e-6)

end

@testset "Parallel" begin
	if nprocs() > 1
		parallel_findpi(100000)
		@spawn time_dilation()
		@spawn eulers_equation()
		@spawn schrodinger()
	end
end