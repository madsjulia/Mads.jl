
<a id='Anasol.jl-1'></a>

# Anasol.jl


Module Anasol.jl provides a series of analytical solutions for groundwater contaminant transport in 1, 2, and 3 dimensions. The provided solutions have:


  * different source types


```
- instantaneous contaminant release
- continuous contaminant release with a unit flux
- continuous contaminant release with a given constant flux
```


  * different source shapes


```
- constrained (within predefined limits)
- distributed (assuming normal distribution)
```


  * different dispersion models


```
- classical (Fickian)
- fractional Brownian
```


  * different boundaries along each axis


```
- infinite (no boundary)
- reflecting
- absorbing
```


Functions have the following arguments:


  * `t`: time to compute the concentration
  * `x`: spatial coordinates of the point to compute the concentration
  * `x01`/`x02`/`x03`: contaminant source coordinates
  * `sigma01`/`sigma02`/`sigma01`: contaminant source sizes (if a constrained source) or standard deviations (if a distributed source)
  * `sourcestrength`: user-provided function defining time-dependent source strength
  * `t0`/`t1`: contaminant release times (source is released  between `t0` and `t1`)
  * `v1`/`v2`/`v3`: groundwater flow velocity components
  * `sigma1`/`sigma2`/`sigma3`: groundwater flow dispersion components
  * `lambda`: half-life contaminant decay
  * `H1`/`H2`/`H3`: Hurst coefficients in the case of fractional Brownian dispersion
  * `xb1`/`xb2`/`xb3`: locations of the domain boundaries


Anasol.jl module functions:

<a id='Anasol.documentationoff-Tuple{}' href='#Anasol.documentationoff-Tuple{}'>#</a>
**`Anasol.documentationoff`** &mdash; *Method*.



Do not make documentation

Methods:

  * `Anasol.documentationoff() in Anasol` : /Users/monty/.julia/dev/Anasol/src/Anasol.jl:237


<a target='_blank' href='https://github.com/madsjulia/Anasol.jl/blob/f1fcebd1bda0c09f26ce406cd4cc6e3b5af1b799/src/Anasol.jl#L231-L235' class='documenter-source'>source</a><br>

<a id='Anasol.documentationon-Tuple{}' href='#Anasol.documentationon-Tuple{}'>#</a>
**`Anasol.documentationon`** &mdash; *Method*.



Make documentation

Methods:

  * `Anasol.documentationon() in Anasol` : /Users/monty/.julia/dev/Anasol/src/Anasol.jl:228


<a target='_blank' href='https://github.com/madsjulia/Anasol.jl/blob/f1fcebd1bda0c09f26ce406cd4cc6e3b5af1b799/src/Anasol.jl#L222-L226' class='documenter-source'>source</a><br>

<a id='Anasol.@code-Tuple{Any}' href='#Anasol.@code-Tuple{Any}'>#</a>
**`Anasol.@code`** &mdash; *Macro*.



`code` the code macro is used to put a line of code (or a quote) onto the growing gen_code function.


<a target='_blank' href='https://github.com/madsjulia/Anasol.jl/blob/f1fcebd1bda0c09f26ce406cd4cc6e3b5af1b799/src/gencode.jl#L28-L31' class='documenter-source'>source</a><br>

<a id='Anasol.@gen_code-Tuple{Any}' href='#Anasol.@gen_code-Tuple{Any}'>#</a>
**`Anasol.@gen_code`** &mdash; *Macro*.



`gen_code` rejigs the standard julia `@generate` macro so that it creates a `code` expression variable that can be extended using the `@code` macro. At the end of the function it automatically outputs the result.


<a target='_blank' href='https://github.com/madsjulia/Anasol.jl/blob/f1fcebd1bda0c09f26ce406cd4cc6e3b5af1b799/src/gencode.jl#L1-L5' class='documenter-source'>source</a><br>

