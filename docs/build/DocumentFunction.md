
<a id='DocumentFunction.jl'></a>

<a id='DocumentFunction.jl-1'></a>

# DocumentFunction.jl


Module provides tools for documenting Julia functions providing information about function methods, arguments and keywords.


DocumentFunction.jl module functions:

<a id='DocumentFunction.documentfunction' href='#DocumentFunction.documentfunction'>#</a>
**`DocumentFunction.documentfunction`** &mdash; *Function*.



Create function documentation

Arguments:

  * `f`: function to be documented

Keywords:

  * `maintext`: function description
  * `argtext`: dictionary with text for each argument
  * `keytext`: dictionary with text for each keyword
  * `location`: show/hide function location on the disk


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/7b40d6574a6b37d32466a6d7e1d3b739e6200454/src/DocumentFunction.jl#L113-L126' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionarguments' href='#DocumentFunction.getfunctionarguments'>#</a>
**`DocumentFunction.getfunctionarguments`** &mdash; *Function*.



Get function arguments

Arguments:

  * `f`: function to be documented"
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/7b40d6574a6b37d32466a6d7e1d3b739e6200454/src/DocumentFunction.jl#L152-L159' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionkeywords' href='#DocumentFunction.getfunctionkeywords'>#</a>
**`DocumentFunction.getfunctionkeywords`** &mdash; *Function*.



Get function keywords

Arguments:

  * `f`: function to be documented
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/7b40d6574a6b37d32466a6d7e1d3b739e6200454/src/DocumentFunction.jl#L183-L190' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionmethods-Tuple{Function}' href='#DocumentFunction.getfunctionmethods-Tuple{Function}'>#</a>
**`DocumentFunction.getfunctionmethods`** &mdash; *Method*.



Get function methods

Arguments:

  * `f`: function to be documented

Return:

  * array with function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/blob/7b40d6574a6b37d32466a6d7e1d3b739e6200454/src/DocumentFunction.jl#L14-L24' class='documenter-source'>source</a><br>

