# Anasol


## Methods [Internal]

---

<a id="method__coreexpression.1" class="lexicon_definition"></a>
## coreexpression(dispersionname,  dispersiontimedependence,  i,  sourcename,  boundaryname)
Create core expressions

*source:*
[Anasol/src/Anasol.jl:123](https://github.com/madsjulia/Anasol.jl/tree/1b6f7d35086c62a2afc18cc838af34eb5cc2cd1f/src/Anasol.jl#L123)

---

<a id="method__tt1c.1" class="lexicon_definition"></a>
## tt1c(x,  t)
1D analytical solution of contaminant flow with constant-concentration input
The source is released at x = 0 and t = 0.

Arguments:

	- `x`  : spatial locations
	- `t`  : times
	- `c0` : initial (background) concentration
	- `ci` : input concentration
	- `aL` : longitudinal dispersion
	- `u`  : transport velocity


*source:*
[Anasol/src/Anasol.jl:60](https://github.com/madsjulia/Anasol.jl/tree/1b6f7d35086c62a2afc18cc838af34eb5cc2cd1f/src/Anasol.jl#L60)

---

<a id="method__tt1i.1" class="lexicon_definition"></a>
## tt1i(x,  t)
1D analytical solution of contaminant flow with instantaneous mass input
The source is released at x = 0 and t = 0.

Arguments:

	- `x`  : spatial locations
	- `t`  : times
	- `c0` : initial (background) concentration
	- `m`  : instantaneous mass input
	- `aL` : longitudinal dispersion
	- `u`  : transport velocity
	- `ϕ`  : total (water-filled) porosity


*source:*
[Anasol/src/Anasol.jl:102](https://github.com/madsjulia/Anasol.jl/tree/1b6f7d35086c62a2afc18cc838af34eb5cc2cd1f/src/Anasol.jl#L102)

