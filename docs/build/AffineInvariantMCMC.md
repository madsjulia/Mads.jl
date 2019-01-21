
<a id='AffineInvariantMCMC.jl-1'></a>

# AffineInvariantMCMC.jl


Module AffineInvariantMCMC.jl provides functions for Bayesian sampling using Affine Invariant Markov chain Monte Carlo (MCMC) Ensemble sampler (aka Emcee) based on a paper by Goodman & Weare, "Ensemble samplers with affine invariance" Communications in Applied Mathematics and Computational Science, DOI: [10.2140/camcos.2010.5.65](http://dx.doi.org/10.2140/camcos.2010.5.65), 2010.


AffineInvariantMCMC.jl module functions:

<a id='AffineInvariantMCMC.flattenmcmcarray-Tuple{Array,Array}' href='#AffineInvariantMCMC.flattenmcmcarray-Tuple{Array,Array}'>#</a>
**`AffineInvariantMCMC.flattenmcmcarray`** &mdash; *Method*.



Flatten MCMC arrays


<a target='_blank' href='https://github.com/madsjulia/AffineInvariantMCMC.jl/blob/b37792178e128b1930b8ef058ea6809bbf5b3e34/src/AffineInvariantMCMC.jl#L96' class='documenter-source'>source</a><br>

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

Goodman & Weare, "Ensemble samplers with affine invariance", Communications in Applied Mathematics and Computational Science, DOI: 10.2140/camcos.2010.5.65, 2010.


<a target='_blank' href='https://github.com/madsjulia/AffineInvariantMCMC.jl/blob/b37792178e128b1930b8ef058ea6809bbf5b3e34/src/AffineInvariantMCMC.jl#L36-L59' class='documenter-source'>source</a><br>

