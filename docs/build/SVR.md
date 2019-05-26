
<a id='SVR.jl-1'></a>

# SVR.jl


Module SVR provides Support Vector Regression (SVR) using [libSVM](https://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.


SVR.jl module functions:

<a id='SVR.loadmodel-Tuple{String}' href='#SVR.loadmodel-Tuple{String}'>#</a>
**`SVR.loadmodel`** &mdash; *Method*.



Load a libSVM model

Methods:

  * `SVR.loadmodel(filename::String) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:289

Arguments:

  * `filename::String` : input file name

Returns:

  * SVM model

<a id='SVR.predict-Tuple{SVR.svmmodel,AbstractArray}' href='#SVR.predict-Tuple{SVR.svmmodel,AbstractArray}'>#</a>
**`SVR.predict`** &mdash; *Method*.



Predict based on a libSVM model

Methods:

  * `SVR.predict(pmodel::SVR.svmmodel, x::AbstractArray) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:246

Arguments:

  * `pmodel::SVR.svmmodel` : the model that prediction is based on
  * `x::AbstractArray` : array of independent variables

Return:

  * predicted dependent variables

<a id='SVR.savemodel-Tuple{SVR.svmmodel,String}' href='#SVR.savemodel-Tuple{SVR.svmmodel,String}'>#</a>
**`SVR.savemodel`** &mdash; *Method*.



Save a libSVM model

Methods:

  * `SVR.savemodel(pmodel::SVR.svmmodel, filename::String) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:311

Arguments:

  * `filename::String` : output file name
  * `pmodel::SVR.svmmodel` : svm model

Dumps:

  * file with saved model

<a id='SVR.train-Tuple{AbstractArray{T,1} where T,AbstractArray}' href='#SVR.train-Tuple{AbstractArray{T,1} where T,AbstractArray}'>#</a>
**`SVR.train`** &mdash; *Method*.



Train based on a libSVM model

Methods:

  * `SVR.train(y::AbstractArray{T,1} where T, x::AbstractArray; svm_type, kernel_type, degree, gamma, coef0, C, nu, eps, cache_size, tol, shrinking, probability, verbose) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:225

Arguments:

  * `x::AbstractArray` : array of independent variables
  * `y::AbstractArray{T,1} where T` : vector of dependent variables

Keywords:

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

<a id='SVR.apredict-Tuple{AbstractArray{T,1} where T,AbstractArray}' href='#SVR.apredict-Tuple{AbstractArray{T,1} where T,AbstractArray}'>#</a>
**`SVR.apredict`** &mdash; *Method*.



Predict based on a libSVM model

Methods:

  * `SVR.apredict(y::AbstractArray{T,1} where T, x::AbstractArray; kw...) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:273

Arguments:

  * `x::AbstractArray` : array of independent variables
  * `y::AbstractArray{T,1} where T` : vector of dependent variables

Return:

  * predicted dependent variables

<a id='SVR.freemodel-Tuple{SVR.svmmodel}' href='#SVR.freemodel-Tuple{SVR.svmmodel}'>#</a>
**`SVR.freemodel`** &mdash; *Method*.



Free a libSVM model

Methods:

  * `SVR.freemodel(pmodel::SVR.svmmodel) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:324

Arguments:

  * `pmodel::SVR.svmmodel` : svm model

<a id='SVR.liboutput-Tuple{Ptr{UInt8}}' href='#SVR.liboutput-Tuple{Ptr{UInt8}}'>#</a>
**`SVR.liboutput`** &mdash; *Method*.



catch lib output

Methods:

  * `SVR.liboutput(str::Ptr{UInt8}) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:85

Arguments:

  * `str::Ptr{UInt8}` : string

<a id='SVR.mapnodes-Tuple{AbstractArray}' href='#SVR.mapnodes-Tuple{AbstractArray}'>#</a>
**`SVR.mapnodes`** &mdash; *Method*.



Methods:

  * `SVR.mapnodes(x::AbstractArray) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:186

Arguments:

  * `x::AbstractArray` :

<a id='SVR.mapparam-Tuple{}' href='#SVR.mapparam-Tuple{}'>#</a>
**`SVR.mapparam`** &mdash; *Method*.



Methods:

  * `SVR.mapparam(; svm_type, kernel_type, degree, gamma, coef0, C, nu, p, cache_size, eps, shrinking, probability, nr_weight, weight_label, weight) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:163

Keywords:

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

<a id='SVR.r2-Tuple{Any,Any}' href='#SVR.r2-Tuple{Any,Any}'>#</a>
**`SVR.r2`** &mdash; *Method*.



Compute the coefficient of determination (r2)

Methods:

  * `SVR.r2(x, y) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:370

Arguments:

  * `x` : observed data
  * `y` : predicted data

Returns:

  * coefficient of determination (r2)

<a id='SVR.readlibsvmfile-Tuple{String}' href='#SVR.readlibsvmfile-Tuple{String}'>#</a>
**`SVR.readlibsvmfile`** &mdash; *Method*.



Read a libSVM file

Methods:

  * `SVR.readlibsvmfile(file::String) in SVR` : /Users/monty/.julia/packages/SVR/UlRCO/src/SVR.jl:344

Arguments:

  * `file::String` : file name

Returns:

  * array of independent variables
  * vector of dependent variables

