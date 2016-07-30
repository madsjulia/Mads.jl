include(Pkg.dir("Mads") * "/src/MadsInfoGap.jl")

infogap_jumplin(horizons=[0.05, 0.1, 0.2, 0.5], retries=1, maxiter=1000, verbosity=0, seed=2015)