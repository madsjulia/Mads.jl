
<a id='SVR.jl-1'></a>

# SVR.jl


Module SVR provides Support Vector Regression (SVR) using [libSVM](https://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.


SVR.jl module functions:

<a id='SVR.apredict-Tuple{Array{T,1} where T,Array}' href='#SVR.apredict-Tuple{Array{T,1} where T,Array}'>#</a>
**`SVR.apredict`** &mdash; *Method*.



Predict based on a libSVM model

Methods

  * `SVR.apredict(y::Array{T,1} where T, x::Array; kw...) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:269

Arguments

  * `x::Array` : array of independent variables
  * `y::Array{T,1} where T` : vector of dependent variables

Return:

  * predicted dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L257-L265' class='documenter-source'>source</a><br>

<a id='SVR.freemodel-Tuple{SVR.svmmodel}' href='#SVR.freemodel-Tuple{SVR.svmmodel}'>#</a>
**`SVR.freemodel`** &mdash; *Method*.



Free a libSVM model

Methods

  * `SVR.freemodel(pmodel::SVR.svmmodel) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:319

Arguments

  * `pmodel::SVR.svmmodel` : svm model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L312-L316' class='documenter-source'>source</a><br>

<a id='SVR.liboutput-Tuple{Ptr{UInt8}}' href='#SVR.liboutput-Tuple{Ptr{UInt8}}'>#</a>
**`SVR.liboutput`** &mdash; *Method*.



catch lib output

Methods

  * `SVR.liboutput(str::Ptr{UInt8}) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:97

Arguments

  * `str::Ptr{UInt8}` : string


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L90-L94' class='documenter-source'>source</a><br>

<a id='SVR.loadmodel-Tuple{String}' href='#SVR.loadmodel-Tuple{String}'>#</a>
**`SVR.loadmodel`** &mdash; *Method*.



Load a libSVM model

Methods

  * `SVR.loadmodel(filename::String) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:285

Arguments

  * `filename::String` : input file name

Returns:

  * SVM model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L274-L282' class='documenter-source'>source</a><br>

<a id='SVR.mapnodes-Tuple{Array}' href='#SVR.mapnodes-Tuple{Array}'>#</a>
**`SVR.mapnodes`** &mdash; *Method*.



Methods

  * `SVR.mapnodes(x::Array) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:184

Arguments

  * `x::Array` :


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L179-L184' class='documenter-source'>source</a><br>

<a id='SVR.mapparam-Tuple{}' href='#SVR.mapparam-Tuple{}'>#</a>
**`SVR.mapparam`** &mdash; *Method*.



Methods

  * `SVR.mapparam(; svm_type, kernel_type, degree, gamma, coef0, C, nu, p, cache_size, eps, shrinking, probability, nr_weight, weight_label, weight) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:161

Keywords

  * `C` : cost; penalty parameter of the error term [default=`1.0`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types [default=`0.0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `eps` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.001`]
  * `gamma` : coefficient for RBF, POLY and SIGMOND kernel types [default=`1.0`]
  * `kernel_type` : kernel type [default=`RBF`]
  * `nr_weight` : [default=`0`]
  * `nu` : upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]
  * `p` : epsilon for EPSILON_SVR [default=`0.1`]
  * `probability` : train to estimate probabilities [default=`false`]
  * `shrinking` : apply shrinking heuristic [default=`true`]
  * `svm_type` : SVM type [default=`EPSILON_SVR`]
  * `weight` : [default=`Ptr{Cdouble}(0x0000000000000000)`]
  * `weight_label` : [default=`Ptr{Cint}(0x0000000000000000)`]

Returns:

  * parameter


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L122-L141' class='documenter-source'>source</a><br>

<a id='SVR.predict-Tuple{SVR.svmmodel,Array}' href='#SVR.predict-Tuple{SVR.svmmodel,Array}'>#</a>
**`SVR.predict`** &mdash; *Method*.



Predict based on a libSVM model

Methods

  * `SVR.predict(pmodel::SVR.svmmodel, x::Array) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:243

Arguments

  * `pmodel::SVR.svmmodel` : the model that prediction is based on
  * `x::Array` : array of independent variables

Return:

  * predicted dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L231-L239' class='documenter-source'>source</a><br>

<a id='SVR.r2-Tuple{Any,Any}' href='#SVR.r2-Tuple{Any,Any}'>#</a>
**`SVR.r2`** &mdash; *Method*.



Compute the coefficient of determination (r2)

Methods

  * `SVR.r2(x, y) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:364

Arguments

  * `x` : observed data
  * `y` : predicted data

Returns:

  * coefficient of determination (r2)


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L353-L361' class='documenter-source'>source</a><br>

<a id='SVR.readlibsvmfile-Tuple{String}' href='#SVR.readlibsvmfile-Tuple{String}'>#</a>
**`SVR.readlibsvmfile`** &mdash; *Method*.



Read a libSVM file

Methods

  * `SVR.readlibsvmfile(file::String) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:338

Arguments

  * `file::String` : file name

Returns:

  * array of independent variables
  * vector of dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L326-L335' class='documenter-source'>source</a><br>

<a id='SVR.savemodel-Tuple{SVR.svmmodel,String}' href='#SVR.savemodel-Tuple{SVR.svmmodel,String}'>#</a>
**`SVR.savemodel`** &mdash; *Method*.



Save a libSVM model

Methods

  * `SVR.savemodel(pmodel::SVR.svmmodel, filename::String) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:306

Arguments

  * `filename::String` : output file name
  * `pmodel::SVR.svmmodel` : svm model

Dumps:

  * file with saved model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L294-L302' class='documenter-source'>source</a><br>

<a id='SVR.train-Tuple{Array{T,1} where T,Array}' href='#SVR.train-Tuple{Array{T,1} where T,Array}'>#</a>
**`SVR.train`** &mdash; *Method*.



Train based on a libSVM model

Methods

  * `SVR.train(y::Array{T,1} where T, x::Array; svm_type, kernel_type, degree, gamma, coef0, C, nu, eps, cache_size, tol, shrinking, probability, verbose) in SVR` : /Users/monty/.julia/v0.6/SVR/src/SVR.jl:223

Arguments

  * `x::Array` : array of independent variables
  * `y::Array{T,1} where T` : vector of dependent variables

Keywords

  * `C` : cost; penalty parameter of the error term [default=`1.0`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types [default=`0.0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `eps` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`0.1`]
  * `gamma` : coefficient for RBF, POLY and SIGMOND kernel types [default=`1/size(x, 1)`]
  * `kernel_type` : kernel type [default=`RBF`]
  * `nu` : upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]
  * `probability` : train to estimate probabilities [default=`false`]
  * `shrinking` : apply shrinking heuristic [default=`true`]
  * `svm_type` : SVM type [default=`EPSILON_SVR`]
  * `tol` : tolerance of termination criterion [default=`0.001`]
  * `verbose` : verbose output [default=`false`]

Returns:

  * SVM model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/6d123d00ca2f2be6fdcd5ecd9d3c422ad445a1ef/src/SVR.jl#L198-L206' class='documenter-source'>source</a><br>

