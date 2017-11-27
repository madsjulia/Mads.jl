
<a id='SVR.jl-1'></a>

# SVR.jl


Module SVR provides Support Vector Regression (SVR) using [libSVM](https://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.


SVR.jl module functions:

<a id='SVR.freemodel-Tuple{SVR.svmmodel}' href='#SVR.freemodel-Tuple{SVR.svmmodel}'>#</a>
**`SVR.freemodel`** &mdash; *Method*.



Free a libSVM model

Methods

  * `SVR.freemodel(pmodel::SVR.svmmodel)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:303

Arguments

  * `pmodel::SVR.svmmodel` : svm model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L296-L300' class='documenter-source'>source</a><br>

<a id='SVR.liboutput-Tuple{Ptr{UInt8}}' href='#SVR.liboutput-Tuple{Ptr{UInt8}}'>#</a>
**`SVR.liboutput`** &mdash; *Method*.



catch lib output

Methods

  * `SVR.liboutput(str::Ptr{UInt8})` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:97

Arguments

  * `str::Ptr{UInt8}` : string


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L90-L94' class='documenter-source'>source</a><br>

<a id='SVR.loadmodel-Tuple{String}' href='#SVR.loadmodel-Tuple{String}'>#</a>
**`SVR.loadmodel`** &mdash; *Method*.



Load a libSVM model

Methods

  * `SVR.loadmodel(filename::String)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:269

Arguments

  * `filename::String` : input file name

Returns:

  * SVM model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L258-L266' class='documenter-source'>source</a><br>

<a id='SVR.mapnodes-Tuple{Array}' href='#SVR.mapnodes-Tuple{Array}'>#</a>
**`SVR.mapnodes`** &mdash; *Method*.



Methods

  * `SVR.mapnodes(x::Array)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:185

Arguments

  * `x::Array` :


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L180-L185' class='documenter-source'>source</a><br>

<a id='SVR.mapparam-Tuple{}' href='#SVR.mapparam-Tuple{}'>#</a>
**`SVR.mapparam`** &mdash; *Method*.



Methods

  * `SVR.mapparam(; svm_type, kernel_type, degree, gamma, coef0, C, nu, p, cache_size, eps, shrinking, probability, nr_weight, weight_label, weight)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:162

Keywords

  * `C` : cost; penalty parameter of the error term [default=`1.0`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types [default=`0.0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `eps` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value

[default=`0.001`]

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


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L122-L142' class='documenter-source'>source</a><br>

<a id='SVR.predict-Tuple{SVR.svmmodel,Array}' href='#SVR.predict-Tuple{SVR.svmmodel,Array}'>#</a>
**`SVR.predict`** &mdash; *Method*.



Predict based on a libSVM model

Methods

  * `SVR.predict(pmodel::SVR.svmmodel, x::Array)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:244

Arguments

  * `pmodel::SVR.svmmodel` : the model that prediction is based on
  * `x::Array` : array of independent variables

Return:

  * predicted dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L232-L240' class='documenter-source'>source</a><br>

<a id='SVR.readlibsvmfile-Tuple{String}' href='#SVR.readlibsvmfile-Tuple{String}'>#</a>
**`SVR.readlibsvmfile`** &mdash; *Method*.



Read a libSVM file

Methods

  * `SVR.readlibsvmfile(file::String)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:322

Arguments

  * `file::String` : file name

Returns:

  * array of independent variables
  * vector of dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L310-L319' class='documenter-source'>source</a><br>

<a id='SVR.savemodel-Tuple{SVR.svmmodel,String}' href='#SVR.savemodel-Tuple{SVR.svmmodel,String}'>#</a>
**`SVR.savemodel`** &mdash; *Method*.



Save a libSVM model

Methods

  * `SVR.savemodel(pmodel::SVR.svmmodel, filename::String)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:290

Arguments

  * `filename::String` : output file name
  * `pmodel::SVR.svmmodel` : svm model

Dumps:

  * file with saved model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L278-L286' class='documenter-source'>source</a><br>

<a id='SVR.train-Tuple{Array{T,1},Array}' href='#SVR.train-Tuple{Array{T,1},Array}'>#</a>
**`SVR.train`** &mdash; *Method*.



Train based on a libSVM model

Methods

  * `SVR.train(y::Array{T<:Any,1}, x::Array; svm_type, kernel_type, degree, gamma, coef0, C, nu, eps, cache_size, tol, shrinking, probability, verbose)` : /Users/monty/.julia/v0.5/SVR/src/SVR.jl:224

Arguments

  * `x::Array` : array of independent variables
  * `y::Array{T<:Any,1}` : vector of dependent variables

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


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/tree/75733703f2af3d043a2bf199565cb5fddb7de55f/src/SVR.jl#L199-L207' class='documenter-source'>source</a><br>

