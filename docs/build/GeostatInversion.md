
<a id='GeostatInversion.jl-1'></a>

# GeostatInversion.jl


This package provides methods for inverse analysis using parameter fields that are represented using geostatistical (stochastic) methods. Currently, two geostatistical methods are implemented. One is the Principal Component Geostatistical Approach (PCGA) proposed by [Kitanidis](http://dx.doi.org/10.1002/2013WR014630) & [Lee](http://dx.doi.org/10.1002/2014WR015483). The other utilizes a Randomized Geostatistical Approach (RGA) that builds on PCGA.


Randomized Geostatistical Approach (RGA) references:


  * [O'Malley, D., Le, E., Vesselinov, V.V., Fast Geostatistical Inversion using Randomized Matrix Decompositions and Sketchings for Heterogeneous Aquifer Characterization, AGU Fall Meeting, San Francisco, CA, December 14–18, 2015.](http://adsabs.harvard.edu/abs/2015AGUFM.T31E..03O)
  * [Lin, Y, Le, E.B, O'Malley, D., Vesselinov, V.V., Bui-Thanh, T., Large-Scale Inverse Model Analyses Employing Fast Randomized Data Reduction, 2016.](submitted)


Two versions of PCGA are implemented in this package


  * `pcgadirect`, which uses full matrices and direct solvers during iterations
  * `pcgalsqr`, which uses low rank representations of the matrices combined with iterative solvers during iterations


The RGA method, `rga`, can use either of these approaches using the keyword argument. That is, by doing `rga(...; pcgafunc=GeostatInversion.pcgadirect)` or `rga(...; pcgafunc=GeostatInversion.pcgalsqr)`.


GeostatInversion.jl module functions:

<a id='GeostatInversion.getxis' href='#GeostatInversion.getxis'>#</a>
**`GeostatInversion.getxis`** &mdash; *Function*.



Get the parameter subspace that will be explored during the inverse analysis

```
getxis(samplefield::Function, numfields::Int, numxis::Int, p::Int, q::Int=3, seed=nothing)
getxis(Q::Matrix, numxis::Int, p::Int, q::Int=3, seed=nothing)
```

Arguments:

  * samplefield : a function that takes no arguments and returns a sample of the field
  * Q : the covariance matrix of the parameter field
  * numfields : the number of fields that will be used to find the subspace
  * numxis : the dimension of the subspace
  * p : oversampling parameter when estimating the range of the covariance matrix (see Halko et al, SIAM Rev., 2011)
  * q : number of power iterations when estimating the range of the covariance matrix (see Halko et al, SIAM Rev., 2011)
  * seed : an optional seed to use when doing the randomized matrix factorization


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/GeostatInversion.jl#L37-L54' class='documenter-source'>source</a><br>

<a id='GeostatInversion.pcgadirect-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1}}' href='#GeostatInversion.pcgadirect-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1}}'>#</a>
**`GeostatInversion.pcgadirect`** &mdash; *Method*.



Direct principal component geostatistical approach

```
pcgadirect(forwardmodel::Function, s0::Vector, X::Vector, xis::Array{Array{Float64, 1}, 1}, R, y::Vector; maxiters::Int=5, delta::Float64=sqrt(eps(Float64)), xtol::Float64=1e-6, callback=(s, obs_cal)->nothing)
```

Arguments:

  * forwardmodel : param to obs map h(s)
  * s0 : initial guess
  * X : mean of parameter prior (replace with B*X drift matrix later for p>1)
  * xis : K columns of Z = randSVDzetas(Q,K,p,q) where Q is the parameter covariance matrix
  * R : covariance of measurement error (data misfit term)
  * y : data vector
  * maxiters : maximum # of PCGA iterations
  * delta : the finite difference step size
  * xtol : convergence tolerence for the parameters
  * callback : a function of the form `(params, observations)->...` that is called during each iteration


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/direct.jl#L1-L20' class='documenter-source'>source</a><br>

<a id='GeostatInversion.pcgalsqr-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1}}' href='#GeostatInversion.pcgalsqr-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1}}'>#</a>
**`GeostatInversion.pcgalsqr`** &mdash; *Method*.



Iterative principal component geostatistical approach

```
pcgalsqr(forwardmodel::Function, s0::Vector, X::Vector, xis::Array{Array{Float64, 1}, 1}, R, y::Vector; maxiters::Int=5, delta::Float64=sqrt(eps(Float64)), xtol::Float64=1e-6)
```

Arguments:

  * forwardmodel : param to obs map h(s)
  * s0 : initial guess
  * X : mean of parameter prior (replace with B*X drift matrix later for p>1)
  * xis : K columns of Z = randSVDzetas(Q,K,p,q) where Q is the parameter covariance matrix
  * R : covariance of measurement error (data misfit term)
  * y : data vector
  * maxiters : maximum # of PCGA iterations
  * delta : the finite difference step size
  * xtol : convergence tolerence for the parameters


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/lsqr.jl#L1-L19' class='documenter-source'>source</a><br>

<a id='GeostatInversion.rga-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1},Any}' href='#GeostatInversion.rga-Tuple{Function,Array{T,1},Array{T,1},Array{Array{Float64,1},1},Any,Array{T,1},Any}'>#</a>
**`GeostatInversion.rga`** &mdash; *Method*.



Randomized (principal component) geostatistical approach

Example:

```
function rga(forwardmodel::Function, s0::Vector, X::Vector, xis::Array{Array{Float64, 1}, 1}, R, y::Vector, S; maxiters::Int=5, delta::Float64=sqrt(eps(Float64)), xtol::Float64=1e-6, pcgafunc=pcgadirect, callback=(s, obs_cal)->nothing)
```

Arguments:

  * forwardmodel : param to obs map h(s)
  * s0 : initial guess
  * X : mean of parameter prior (replace with B*X drift matrix later for p>1)
  * xis : K columns of Z = randSVDzetas(Q,K,p,q) where Q is the parameter covariance matrix
  * R : covariance of measurement error (data misfit term)
  * y : data vector
  * S : sketching matrix
  * maxiters : maximum # of PCGA iterations
  * delta : the finite difference step size
  * xtol : convergence tolerance for the parameters
  * callback : a function of the form `(params, observations)->...` that is called during each iteration


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/GeostatInversion.jl#L75-L97' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.FDDerivatives-1'></a>

## Module GeostatInversion.FDDerivatives


GeostatInversion.FDDerivatives module functions:

<a id='GeostatInversion.FDDerivatives.makegradient' href='#GeostatInversion.FDDerivatives.makegradient'>#</a>
**`GeostatInversion.FDDerivatives.makegradient`** &mdash; *Function*.



Create Gradient function


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/FDDerivatives.jl#L22' class='documenter-source'>source</a><br>

<a id='GeostatInversion.FDDerivatives.makejacobian' href='#GeostatInversion.FDDerivatives.makejacobian'>#</a>
**`GeostatInversion.FDDerivatives.makejacobian`** &mdash; *Function*.



Create Jacobian function


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/FDDerivatives.jl#L3' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.RandMatFact-1'></a>

## Module GeostatInversion.RandMatFact


GeostatInversion.RandMatFact module functions:

<a id='GeostatInversion.RandMatFact.randsvd-Tuple{Any,Int64,Int64,Int64}' href='#GeostatInversion.RandMatFact.randsvd-Tuple{Any,Int64,Int64,Int64}'>#</a>
**`GeostatInversion.RandMatFact.randsvd`** &mdash; *Method*.



Random SVD based on algorithm 5.1 from Halko et al.


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/RandMatFact.jl#L75' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.FFTRF-1'></a>

## Module GeostatInversion.FFTRF


GeostatInversion.FFTRF module functions:

<a id='GeostatInversion.FFTRF.reducek-Tuple{Any,Type{Val{N}}}' href='#GeostatInversion.FFTRF.reducek-Tuple{Any,Type{Val{N}}}'>#</a>
**`GeostatInversion.FFTRF.reducek`** &mdash; *Method*.



Reduce k


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/b059d7988abfc525c8733dd511ac92a0c8e45b2f/src/FFTRF.jl#L6' class='documenter-source'>source</a><br>

