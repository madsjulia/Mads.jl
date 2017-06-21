# GeostatInversion.jl

This package provides methods for inverse analysis using parameter fields that are represented using geostatistical (stochastic) methods.
Currently, two geostatistical methods are implemented.
One is the Principal Component Geostatistical Approach (PCGA) proposed by [Kitanidis](http://dx.doi.org/10.1002/2013WR014630) & [Lee](http://dx.doi.org/10.1002/2014WR015483).
The other utilizes a Randomized Geostatistical Approach (RGA) that builds on PCGA.

Randomized Geostatistical Approach (RGA) references:

- [O'Malley, D., Le, E., Vesselinov, V.V., Fast Geostatistical Inversion using Randomized Matrix Decompositions and Sketchings for Heterogeneous Aquifer Characterization, AGU Fall Meeting, San Francisco, CA, December 14–18, 2015.](http://adsabs.harvard.edu/abs/2015AGUFM.T31E..03O)
- [Lin, Y, Le, E.B, O'Malley, D., Vesselinov, V.V., Bui-Thanh, T., Large-Scale Inverse Model Analyses Employing Fast Randomized Data Reduction, 2016.](submitted)

Two versions of PCGA are implemented in this package

- `pcgadirect`, which uses full matrices and direct solvers during iterations
- `pcgalsqr`, which uses low rank representations of the matrices combined with iterative solvers during iterations

The RGA method, `rga`, can use either of these approaches using the keyword argument. That is, by doing `rga(...; pcgafunc=GeostatInversion.pcgadirect)` or `rga(...; pcgafunc=GeostatInversion.pcgalsqr)`.

GeostatInversion.jl module functions:

```@autodocs
Modules = [GeostatInversion]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.FDDerivatives

GeostatInversion.FDDerivatives module functions:

```@autodocs
Modules = [GeostatInversion.FDDerivatives]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.RandMatFact

GeostatInversion.RandMatFact module functions:

```@autodocs
Modules = [GeostatInversion.RandMatFact]
Order   = [:function, :macro, :type]
```

## Module GeostatInversion.FFTRF

GeostatInversion.FFTRF module functions:

```@autodocs
Modules = [GeostatInversion.FFTRF]
Order   = [:function, :macro, :type]
```

