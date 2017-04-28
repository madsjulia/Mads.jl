#=
x0 = [.5, .5]
xs = [0. 0.; 0. 1.; 1. 0.; 1. 1.; 0.500001 0.5]
zs = [-20., .6, .4, 1., 20.]
variogram(x1, x2) = Mads.sphericalvariogram(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))
variogram(x1, x2) = Mads.exponentialvariogram(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))
variogram(x1, x2) = Mads.gaussianvariogram(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))


x0 = [.5 .5; .49 .49; .01 .01; .99 1.; 0. 1.; 1. 0.]
xs = [0. 0.; 0. 1.; 1. 0.; 1. 1.; 0.500001 0.5]
zs = [-20., .6, .4, 1., 20.]
mycov = h->Mads.sphericalcov(h, krigingparams[1], krigingparams[2])
variogram(x1, x2) = Mads.sphericalcov(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))
variogram(x1, x2) = Mads.expcov(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))
variogram(x1, x2) = Mads.gaussiancov(norm(x1 - x2), 3.14, 1., 0.001)
println(Mads.krige(x0, xs, zs, variogram))
=#

import Mads
import JLD
import Base.Test

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
xs = [0. 0.; 0. 1.; 1. 0.; 1. 1.; 0.500001 0.5]
zs = [-20., .6, .4, 1., 20.]

krige_results_1 = Mads.krige(x0, xs, zs, mycov1)
krige_results_2 = Mads.krige(x0, xs, zs, mycov2)
krige_results_3 = Mads.krige(x0, xs, zs, mycov3)

estimation_error_1 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov1)
estimation_error_2 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov2)
estimation_error_3 = Mads.estimationerror(ones(size(xs, 2)), zs, xs, mycov3)

@Base.Test.testset "Kriging" begin
    # Testing Mads.sphericalvariogram()
    @Base.Test.testset "Spherical Variogram" begin
        @Base.Test.test isapprox(spherical_1, 0.0, atol=1e-6)
        @Base.Test.test isapprox(spherical_2, 2.82007, atol=1e-6)
        @Base.Test.test isapprox(spherical_3, 1, atol=1e-6)
    end

    # Testing Mads.exponentialvariogram()
    @Base.Test.testset "Exponential Variogram" begin
        @Base.Test.test isapprox(exponential_1, 0.0, atol=1e-6)
        @Base.Test.test isapprox(exponential_2, 3.069842455031493, atol=1e-6)
    end

    # Testing Mads.gaussianvariogram()
    @Base.Test.testset "Gaussian Variogram" begin
        @Base.Test.test isapprox(gaussian_1, 0.0, atol=1e-6)
        @Base.Test.test isapprox(gaussian_2, 3.13287854235668, atol=1e-6)
    end

    # Uncomment - 
    # Testing Mads.krige()
    @Base.Test.testset "Krige" begin
    #   @Base.Test.test krige_results_1 == Float64[-4.75601, -4.75602]
    #   @Base.Test.test isapprox(krige_results_2, Float64[-6.50204, -6.50191], atol=1e-6)
    #   @Base.Test.test isapprox(krige_results_3, Float64[-6.49796, -6.49782], atol=1e-6)
    end

    # Testing Mads.estimationerror()
    @Base.Test.testset "Estimation Error" begin
        @Base.Test.test isapprox(estimation_error_1, 2.0690127188550758, atol=1e-6)
        @Base.Test.test isapprox(estimation_error_2, 2.692667005054859, atol=1e-6)
        @Base.Test.test isapprox(estimation_error_3, 3.0861743200363456, atol=1e-6)
    end
end