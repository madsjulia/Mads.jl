# Anasol.jl

Module Anasol.jl provides a series of analytical solutions for groundwater contaminant transport in 1, 2, and 3 dimensions.
The provided solutions have:

* different source types
	- instantaneous contaminant release
	- continuous contaminant release with a unit flux
	- continuous contaminant release with a given constant flux
* different source shapes
	- constrained (within predefined limits)
	- distributed (assuming normal distribution)
* different dispersion models
	- classical (Fickian)
	- fractional Brownian
* different boundaries along each axis
	- infinite (no boundary)
	- reflecting
	- absorbing

Functions have the following arguments:

- `t`: time to compute the concentration
- `x`: spatial coordinates of the point to compute the concentration
- `x01`/`x02`/`x03`: contaminant source coordinates
- `sigma01`/`sigma02`/`sigma01`: contaminant source sizes (if a constrained source) or standard deviations (if a distributed source)
- `sourcestrength`: user-provided function defining time-dependent source strength
- `t0`/`t1`: contaminant release times (source is released  between `t0` and `t1`)
- `v1`/`v2`/`v3`: groundwater flow velocity components
- `sigma1`/`sigma2`/`sigma3`: groundwater flow dispersion components
- `lambda`: half-life contaminant decay
- `H1`/`H2`/`H3`: Hurst coefficients in the case of fractional Brownian dispersion
- `xb1`/`xb2`/`xb3`: locations of the domain boundaries

Anasol.jl module functions:

```@autodocs
Modules = [Anasol]
Order   = [:function, :macro, :type]
```
