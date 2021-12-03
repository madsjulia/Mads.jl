
<a id='DocumentFunction.jl'></a>

<a id='DocumentFunction.jl-1'></a>

# DocumentFunction.jl


Module provides tools for documenting Julia functions providing information about function methods, arguments and keywords.


DocumentFunction.jl module functions:

<a id='DocumentFunction.documentfunction' href='#DocumentFunction.documentfunction'>#</a>
**`DocumentFunction.documentfunction`** &mdash; *Function*.



Create function documentation

Arguments:

  * `f`: function to be documented"

Keywords:

  * `maintext`: function description
  * `argtext`: dictionary with text for each argument
  * `keytext`: dictionary with text for each keyword
  * `location`: show/hide function location on the disk


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/a018a2f0cb210f3daa0e7e188f49233838b29466/src/DocumentFunction.jl#L108-L121' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionarguments' href='#DocumentFunction.getfunctionarguments'>#</a>
**`DocumentFunction.getfunctionarguments`** &mdash; *Function*.



Get function arguments

Arguments:

  * `f`: function to be documented"
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/a018a2f0cb210f3daa0e7e188f49233838b29466/src/DocumentFunction.jl#L147-L154' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionkeywords' href='#DocumentFunction.getfunctionkeywords'>#</a>
**`DocumentFunction.getfunctionkeywords`** &mdash; *Function*.



Get function keywords

Arguments:

  * `f`: function to be documented
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/a018a2f0cb210f3daa0e7e188f49233838b29466/src/DocumentFunction.jl#L178-L185' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionmethods-Tuple{Function}' href='#DocumentFunction.getfunctionmethods-Tuple{Function}'>#</a>
**`DocumentFunction.getfunctionmethods`** &mdash; *Method*.



Get function methods

Arguments:

  * `f`: function to be documented

Return:

  * array with function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/a018a2f0cb210f3daa0e7e188f49233838b29466/src/DocumentFunction.jl#L17-L27' class='documenter-source'>source</a><br>

