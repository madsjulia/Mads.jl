import Mads

Random.seed!(1)
d = collect(range(0, stop=3, length=100))
y1 = exp.(-1.3*d) + 0.05*randn(size(d))

@Mads.stderrcapture function func1(x)
	exp.(-d .* x[1]) .- y1
end

y2 = 2 .* d .+ 1 .+ 0.05 .* randn(size(d))

@Mads.stderrcapture function func2(x)
	(x[1] .* d .+ x[2]) .- y2
end

minimizer_a1, results = Mads.minimize(func1, [2.]; upperbounds=[4.], lowerbounds=[0.], logtransformed=[false])
minimizer_l1, results = Mads.minimize(func1, [2.]; upperbounds=[4.], lowerbounds=[1e-6], logtransformed=[true])

minimizer_a2, results = Mads.minimize(func2, [1.5, 0.5]; upperbounds=[4.,1], lowerbounds=[0.,0.], logtransformed=[false, false])
minimizer_l2, results = Mads.minimize(func2, [1.5, 1.5]; upperbounds=[4.,2.], lowerbounds=[1e-6,1e-3], logtransformed=[true, true])

@Test.testset "Minimization" begin
	@Test.test isapprox(minimizer_a1[1], 1.3237; atol=1e-2)
	@Test.test isapprox(minimizer_l1[1], 1.3225; atol=1e-2)
	@Test.test isapprox(minimizer_a2[1], 2.017; atol=1e-2)
	@Test.test isapprox(minimizer_a2[2], 0.972; atol=1e-2)
	@Test.test isapprox(minimizer_l2[1], 2.016; atol=1e-2)
	@Test.test isapprox(minimizer_l2[2], 0.972; atol=1e-2)
end

:passed