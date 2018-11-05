import Mads
import Test

spherical_1 = Mads.sphericalvariogram(0, 1, 10, 3.14)
spherical_2 = Mads.sphericalvariogram(1, 1, 10, 3.14)
spherical_3 = Mads.sphericalvariogram(20, 1, 10, 3.14)

exponential_1 = Mads.exponentialvariogram(0, 1, 10, 3.14)
exponential_2 = Mads.exponentialvariogram(1, 1, 10, 3.14)

gaussian_1 = Mads.gaussianvariogram(0, 1, 10, 3.14)
gaussian_2 = Mads.gaussianvariogram(1, 1, 10, 3.14)

mycov1 = h->Mads.gaussiancov(h, 2, 300)
mycov2 = h->Mads.expcov(h, 2, 300)
mycov3 = h->Mads.sphericalcov(h, 2, 300)

x0 = [.5 .5; .49 .49; .01 .01; .99 1.; 0. 1.; 1. 0.]
xs = [0. 0.; 0. 1.; 1. 0.; 1. 1.; 0.500001 0.5]'
zs = [-20., .6, .4, 1., 20.]

krige_results_1 = Mads.krige(x0, xs, zs, mycov1)
krige_results_2 = Mads.krige(x0, xs, zs, mycov2)
krige_results_3 = Mads.krige(x0, xs, zs, mycov3)

estimation_error_1 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov1)
estimation_error_2 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov2)
estimation_error_3 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov3)

@Test.testset "Kriging" begin
	@Test.testset "Spherical Variogram" begin
		@Test.test isapprox(spherical_1, 0.0, atol=1e-6)
		@Test.test isapprox(spherical_2, 2.82007, atol=1e-6)
		@Test.test isapprox(spherical_3, 1, atol=1e-6)
	end

	@Test.testset "Exponential Variogram" begin
		@Test.test isapprox(exponential_1, 0.0, atol=1e-6)
		@Test.test isapprox(exponential_2, 3.069842455031493, atol=1e-6)
	end

	@Test.testset "Gaussian Variogram" begin
		@Test.test isapprox(gaussian_1, 0.0, atol=1e-6)
		@Test.test isapprox(gaussian_2, 3.13287854235668, atol=1e-6)
	end

	@Test.testset "Krige" begin
	   @Test.test isapprox(krige_results_1, [19.8891, 19.8891], atol=0.1)
	   @Test.test isapprox(krige_results_2, [19.4586, 19.4586], atol=0.1)
	   @Test.test isapprox(krige_results_3, [19.4586, 19.4586], atol=0.1)
	 end

	@Test.testset "Estimation Error" begin
		@Test.test isapprox(estimation_error_1, 32.09281702460199, atol=1e-6)
		@Test.test isapprox(estimation_error_2, 33.19278009478499, atol=1e-6)
		@Test.test isapprox(estimation_error_3, 33.854178427022, atol=1e-6)
	end
end

:passed