import Mads
import Test

Random.seed!(2017)

@Test.testset "Functions" begin
	@Test.test isapprox(Mads.rosenbrock_gradient!(rand(2), Array{Float64}(undef, 2)), 95, atol=10)
	@Test.test Mads.rosenbrock_hessian!(rand(2),Array{Float64}(undef, 2,2)) == 200.0
	@Test.test all((Mads.makerosenbrock(2))([1,1]) .== [0,0])
	@Test.test all((Mads.makerosenbrock_gradient(2))([1,1]) .== [-1 0; -20 10])
	@Test.test all((Mads.makepowell(8))([1,1,1,1,1,1,1,1]) .== [11.0,0.0,1.0,0.0,11.0,0.0,1.0,0.0])

	@Test.test all(isapprox(Mads.makepowell_gradient(8)([1,1,1,1,1,1,1,1]), [1.0 10.0 0.0 0.0 0.0 0.0 0.0 0.0;
																			0.0 0.0 2.23607 -2.23607 0.0 0.0 0.0 0.0;
																			0.0 -2.0 4.0 0.0 0.0 0.0 0.0 0.0;
																			0.0 0.0 0.0 -0.0 0.0 0.0 0.0 0.0;
																			0.0 0.0 0.0 0.0 1.0 10.0 0.0 0.0;
																			0.0 0.0 0.0 0.0 0.0 0.0 2.23607 -2.23607;
																			0.0 0.0 0.0 0.0 0.0 -2.0 4.0 0.0;
																			0.0 0.0 0.0 0.0 0.0 0.0 0.0 -0.0], atol=1e-2))


	@Test.test all(Mads.makesphere(2)([1,1]) .== [1,1])
	@Test.test all(Mads.makesphere_gradient(2)([1,1]) .== [1 0; 0 1])
	@Test.test all(isapprox(Mads.makedixonprice(2)([1,1]), [0.0,1.41421], atol=1e-2))
	@Test.test all(isapprox(Mads.makedixonprice_gradient(2)([1,1]), [1.41421 -2.0; 0.0 8.0], atol=1e-2))
	@Test.test all(isapprox(Mads.makesumsquares(2)([1,1]), [1.0,1.41421], atol=1e-2))
	@Test.test all(isapprox(Mads.makesumsquares_gradient(2)([1,1]), [1.41421 0.0; 0.0 2.0], atol=1e-2))
	@Test.test all(isapprox(Mads.makerotatedhyperellipsoid(2)([1,1]), [1.0,1.41421], atol=1e-2))
	@Test.test all(isapprox(Mads.makerotatedhyperellipsoid_gradient(2)([1,1]), [1.41421 1.0; 0.0 1.0], atol=1e-2))
end