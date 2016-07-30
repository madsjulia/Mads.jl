# Anasol


## Macros [Internal]

---

<a id="macro___code.1" class="lexicon_definition"></a>
## @code(e)
`code` the code macro is used to put a line of code (or a quote) onto the growing
gen_code function.


*source:*
[Anasol/src/gencode.jl:32](https://github.com/madsjulia/Anasol.jl/tree/02b3e58b1f2a8de4b87f111acd50e54f159a24b4/src/gencode.jl#L32)

---

<a id="macro___gen_code.1" class="lexicon_definition"></a>
## @gen_code(f)
`gen_code` rejigs the standard julia `@generate` macro so that it creates a `code`
expression variable that can be extended using the `@code` macro.  At the end of
the function it automatically outputs the result.


*source:*
[Anasol/src/gencode.jl:6](https://github.com/madsjulia/Anasol.jl/tree/02b3e58b1f2a8de4b87f111acd50e54f159a24b4/src/gencode.jl#L6)

