
<a id='GeostatInversion.jl-1'></a>

# GeostatInversion.jl


Module for Geostatistical Inversion.


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


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/GeostatInversion.jl#L37-L54' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/direct.jl#L1-L20' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/lsqr.jl#L1-L19' class='documenter-source'>source</a><br>

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


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/GeostatInversion.jl#L75-L97' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.FDDerivatives-1'></a>

## Module GeostatInversion.FDDerivatives


GeostatInversion.FDDerivatives module functions:

<a id='GeostatInversion.FDDerivatives.makegradient' href='#GeostatInversion.FDDerivatives.makegradient'>#</a>
**`GeostatInversion.FDDerivatives.makegradient`** &mdash; *Function*.



Create Gradient function


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/FDDerivatives.jl#L22' class='documenter-source'>source</a><br>

<a id='GeostatInversion.FDDerivatives.makejacobian' href='#GeostatInversion.FDDerivatives.makejacobian'>#</a>
**`GeostatInversion.FDDerivatives.makejacobian`** &mdash; *Function*.



Create Jacobian function


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/FDDerivatives.jl#L3' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.RandMatFact-1'></a>

## Module GeostatInversion.RandMatFact


GeostatInversion.RandMatFact module functions:

<a id='GeostatInversion.RandMatFact.randsvd-Tuple{Any,Int64,Int64,Int64}' href='#GeostatInversion.RandMatFact.randsvd-Tuple{Any,Int64,Int64,Int64}'>#</a>
**`GeostatInversion.RandMatFact.randsvd`** &mdash; *Method*.



Random SVD based on algorithm 5.1 from Halko et al.


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/RandMatFact.jl#L75' class='documenter-source'>source</a><br>


<a id='Module-GeostatInversion.FFTRF-1'></a>

## Module GeostatInversion.FFTRF


GeostatInversion.FFTRF module functions:

<a id='GeostatInversion.FFTRF.reducek-Tuple{Any,Any}' href='#GeostatInversion.FFTRF.reducek-Tuple{Any,Any}'>#</a>
**`GeostatInversion.FFTRF.reducek`** &mdash; *Method*.



Reduce k


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/FFTRF.jl#L20' class='documenter-source'>source</a><br>

<a id='GeostatInversion.FFTRF.@tryimport-Tuple{Symbol}' href='#GeostatInversion.FFTRF.@tryimport-Tuple{Symbol}'>#</a>
**`GeostatInversion.FFTRF.@tryimport`** &mdash; *Macro*.



Try to import a module


<a target='_blank' href='https://github.com/madsjulia/GeostatInversion.jl/tree/9c2175e94994330b735a015c1b6086d2401a3ece/src/FFTRF.jl#L3' class='documenter-source'>source</a><br>

