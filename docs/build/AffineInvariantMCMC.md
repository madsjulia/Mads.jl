
<a id='AffineInvariantMCMC.jl-1'></a>

# AffineInvariantMCMC.jl


AffineInvariantMCMC.jl module functions:

<a id='AffineInvariantMCMC.flattenmcmcarray-Tuple{Array,Array}' href='#AffineInvariantMCMC.flattenmcmcarray-Tuple{Array,Array}'>#</a>
**`AffineInvariantMCMC.flattenmcmcarray`** &mdash; *Method*.



Flatten MCMC arrays


<a target='_blank' href='https://github.com/madsjulia/AffineInvariantMCMC.jl/tree/06052b2d0c7998f7796132a2b3ec133618f14fbe/src/AffineInvariantMCMC.jl#L96' class='documenter-source'>source</a><br>

<a id='AffineInvariantMCMC.sample' href='#AffineInvariantMCMC.sample'>#</a>
**`AffineInvariantMCMC.sample`** &mdash; *Function*.



Bayesian sampling using Goodman & Weare's Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee)

```
AffineInvariantMCMC.sample(llhood, numwalkers=10, numsamples_perwalker=100, thinning=1)
```

Arguments:

  * `llhood` : function estimating loglikelihood (for example, generated using Mads.makearrayloglikelihood())
  * `numwalkers` : number of walkers
  * `x0` : normalized initial parameters (matrix of size (length(params), numwalkers))
  * `thinning` : removal of any `thinning` realization
  * `a` :

Returns:

  * `mcmcchain` : final MCMC chain
  * `llhoodvals` : log likelihoods of the final samples in the chain

Reference:

Goodman, Jonathan, and Jonathan Weare. "Ensemble samplers with affine invariance." Communications in applied mathematics and computational science 5.1 (2010): 65-80.


<a target='_blank' href='https://github.com/madsjulia/AffineInvariantMCMC.jl/tree/06052b2d0c7998f7796132a2b3ec133618f14fbe/src/AffineInvariantMCMC.jl#L36-L59' class='documenter-source'>source</a><br>

