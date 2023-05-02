# Example Problems

- [Model Diagnostics](model_diagnostics/model_diagnostics.md)
- [Model Calibration](model_inversion_contamination/model_inversion_contamination.md)
- [Uncertainty Quantification](bayesian_sampling/bayesian_sampling.md)
- [Decision Analysis](bigdt/source_termination/source_termination.md)
- [Information Gap Decision Analysis](infogap/infogap.md)
- [Machine Learning](machine_learning/machine_learning.md)
  - [Contaminant Source Identification](contaminant_source_identification/contaminant_source_identification.md)
  - [Blind Source Separation](blind_source_separation/blind_source_separation.md)
- Contamination
  - [Contaminant Transport](contamination/contamination.md)
  - [Contaminant Model Inversion](model_inversion_contamination/model_inversion_contamination.md)
  - [Contaminant Source Identification](contaminant_source_identification/contaminant_source_identification.md)
  - [Contaminant Remediation](bigdt/source_termination/source_termination.md)
- [ODE Analysis](ode/ode.md)

***

Many other examples located in the [examples](https://github.com/madsjulia/Mads.jl/tree/master/examples) directory of the `MADS` repository.

For example, execute

```julia
include(joinpath(Mads.dir, "examples", "contamination", "contamination.jl"))
```

to perform various example analyses related to groundwater contaminant transport, or execute

```julia
include(joinpath(Mads.dir, "examples", "bigdt", "bigdt.jl"))
```

to perform Bayesian Information Gap Decision Theory (BIG-DT) analysis.
