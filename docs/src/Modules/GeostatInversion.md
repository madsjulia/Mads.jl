# GeostatInversion.jl

GeostatInversion.jl performs inverse model analysis using parameter fields that are represented using geostatistical (stochastic) methods.

Two geostatistical methods are implemented.

- Principal Component Geostatistical Approach (PCGA)
- Randomized Geostatistical Approach (RGA).

Two versions of PCGA are implemented here

- `pcgadirect`: uses full matrices and direct solvers during iterations
- `pcgalsqr`: uses low rank representations of the matrices combined with iterative solvers during iterations

The RGA method, can use either of these approaches
- `GeostatInversion.rga(...; pcgafunc=GeostatInversion.pcgadirect)`
- `GeostatInversion.rga(...; pcgafunc=GeostatInversion.pcgalsqr)`.

References:

- [O'Malley, D., Le, E., Vesselinov, V.V., Fast Geostatistical Inversion using Randomized Matrix Decompositions and Sketchings for Heterogeneous Aquifer Characterization, AGU Fall Meeting, San Francisco, CA, December 14–18, 2015.](http://adsabs.harvard.edu/abs/2015AGUFM.T31E..03O)
- [Lin, Y, Le, E.B, O'Malley, D., Vesselinov, V.V., Bui-Thanh, T., Large-Scale Inverse Model Analyses Employing Fast Randomized Data Reduction, 2016.](https://doi.org/10.1002/2016WR020299)
- [Kitanidis](http://dx.doi.org/10.1002/2013WR014630)
- [Lee](http://dx.doi.org/10.1002/2014WR015483).

GeostatInversion.jl functions:

```@autodocs
Modules = [GeostatInversion]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.FDDerivatives

GeostatInversion.FDDerivatives functions:

```@autodocs
Modules = [GeostatInversion.FDDerivatives]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.RandMatFact

GeostatInversion.RandMatFact functions:

```@autodocs
Modules = [GeostatInversion.RandMatFact]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.FFTRF

GeostatInversion.FFTRF functions:

```@autodocs
Modules = [GeostatInversion.FFTRF]
Order   = [:function, :macro, :type]
```