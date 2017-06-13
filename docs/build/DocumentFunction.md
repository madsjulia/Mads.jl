
<a id='DocumentFunction.jl-1'></a>

# DocumentFunction.jl


Document Julia Functions (methods, arguments, keywords)


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


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L109-L122' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionarguments' href='#DocumentFunction.getfunctionarguments'>#</a>
**`DocumentFunction.getfunctionarguments`** &mdash; *Function*.



Get function arguments

Arguments:

  * `f`: function to be documented"
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L147-L154' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionkeywords' href='#DocumentFunction.getfunctionkeywords'>#</a>
**`DocumentFunction.getfunctionkeywords`** &mdash; *Function*.



Get function keywords

Arguments:

  * `f`: function to be documented
  * `m`: function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L177-L184' class='documenter-source'>source</a><br>

<a id='DocumentFunction.getfunctionmethods-Tuple{Function}' href='#DocumentFunction.getfunctionmethods-Tuple{Function}'>#</a>
**`DocumentFunction.getfunctionmethods`** &mdash; *Method*.



Get function methods

Arguments:

  * `f`: function to be documented

Return:

  * array with function methods


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L37-L47' class='documenter-source'>source</a><br>

<a id='DocumentFunction.stdoutcaptureoff-Tuple{}' href='#DocumentFunction.stdoutcaptureoff-Tuple{}'>#</a>
**`DocumentFunction.stdoutcaptureoff`** &mdash; *Method*.



Restore STDOUT


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L26-L28' class='documenter-source'>source</a><br>

<a id='DocumentFunction.stdoutcaptureon-Tuple{}' href='#DocumentFunction.stdoutcaptureon-Tuple{}'>#</a>
**`DocumentFunction.stdoutcaptureon`** &mdash; *Method*.



Redirect STDOUT to a reader


<a target='_blank' href='https://github.com/madsjulia/DocumentFunction.jl/tree/8017964b2236ea37a4026b8c7f37f451728904a8/src/DocumentFunction.jl#L15-L17' class='documenter-source'>source</a><br>

