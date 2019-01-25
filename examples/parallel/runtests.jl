import Mads
import Test
import Random
using Distributed

@Mads.stderrcapture function parallel_findpi(n)
	# Simple Monte Carlo to estimate pi
	Random.seed!(2017)
	inside = @distributed (+) for i = 1:n
		x, y = rand(2)
		x^2 + y^2 <= 1 ? 1 : 0
	end
	isapprox((4 * inside / n), 3.14, atol=1e-1)
end

@Mads.stderrcapture function time_dilation()
	# Einstein Special Relativity: time dilation
	# t' = t / sqrt(1 - v^2 / c^2)

	c = 299792458   # Speed of light (m/s)
	t = 20          # Time (s)
	v = 0.999*c     # Velocity relative to c (m/s)

	t / sqrt(1 - v^2 / c^2) < 500
end

@Mads.stderrcapture function eulers_equation()
	# Euler's equation on the nature of spheres
	# V - E + F = 2

	V = 4 # Vertices
	E = 6 # Edges
	F = 4 # Faces

	(V - E + F) == 2
end

@Mads.stderrcapture function schrodinger()
	# Schrodinger's equation in a 1D box:
	#  ψ(x) = sqrt(2/L)*sin.(nπx/L)

	L = 1 # Length of box
	x = 1 # Position from [0, L]
	n = 0 # Energy level

	psi = sqrt(2/L)*sin.(n*π*x/L)
	isapprox(psi, 0.0, atol=1e-6)
end

# if !haskey(ENV, "MADS_TRAVIS")
# 	Distributed.addprocs(2)
# end

@Test.testset "Parallel" begin
	@Test.test parallel_findpi(100000)
	@Test.test time_dilation()
	@Test.test eulers_equation()
	@Test.test schrodinger()
end

:passed

# if !haskey(ENV, "MADS_TRAVIS")
# 	rmprocs(workers())
# end
