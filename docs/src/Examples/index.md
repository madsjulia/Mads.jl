# Examples

- [Model Diagnostics](model_diagnostics/model_diagnostics.md)
- [Decision Analysis](bigdt/source_termination/index.md)
- [Information Gap Decision Analysis](infogap/index.md)
- [Uncertainty Quantification](bayesian_sampling/index.md)
- [Machine Learning](machine_learning/index.md)
  - [Contaminant Source Identification](contaminant_source_identification/index.md)
  - [Blind Source Separation](blind_source_separation/index.md)
- [Contaminant Transport](contamination/index.md)
- [ODE Analysis](ode/index.md)

***

Many other examples located in the [examples](https://github.com/madsjulia/Mads.jl/tree/master/examples) directory of the `Mads` repository.

For example, execute

```julia
include(joinpath(Mads.dir, "examples", "contamination", "contamination.jl"))
```

to perform various example analyses related to groundwater contaminant transport, or execute

```julia
include(joinpath(Mads.dir, "examples", "bigdt", "bigdt.jl"))
```

to perform Bayesian Information Gap Decision Theory (BIG-DT) analysis.
