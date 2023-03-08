
<a id='SVR.jl'></a>

<a id='SVR.jl-1'></a>

# SVR.jl


Module SVR provides Support Vector Regression (SVR) using [libSVM](https://www.csie.ntu.edu.tw/~cjlin/libsvm/) library.


SVR.jl module functions:

<a id='SVR.apredict-Tuple{AbstractVector{Float64}, AbstractArray{Float64}}' href='#SVR.apredict-Tuple{AbstractVector{Float64}, AbstractArray{Float64}}'>#</a>
**`SVR.apredict`** &mdash; *Method*.



Predict based on a libSVM model

Methods:

  * `SVR.apredict(y::AbstractVector{Float64}, x::AbstractArray{Float64}; kw...)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:290

Arguments:

  * `x::AbstractArray{Float64}` : array of independent variables
  * `y::AbstractVector{Float64}` : vector of dependent variables

Return:

  * predicted dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L279-L287' class='documenter-source'>source</a><br>

<a id='SVR.freemodel-Tuple{SVR.svmmodel}' href='#SVR.freemodel-Tuple{SVR.svmmodel}'>#</a>
**`SVR.freemodel`** &mdash; *Method*.



Free a libSVM model

Methods:

  * `SVR.freemodel(pmodel::SVR.svmmodel)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:358

Arguments:

  * `pmodel::SVR.svmmodel` : svm model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L352-L356' class='documenter-source'>source</a><br>

<a id='SVR.get_prediction_mask-Tuple{Number, Number}' href='#SVR.get_prediction_mask-Tuple{Number, Number}'>#</a>
**`SVR.get_prediction_mask`** &mdash; *Method*.



Get prediction mask

Methods:

  * `SVR.get_prediction_mask(ns::Number, ratio::Number; keepcases, debug)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:247

Arguments:

  * `ns::Number` : number of samples
  * `ratio::Number` : prediction ratio

Keywords:

  * `debug`
  * `keepcases`

Return:

  * prediction mask


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L236-L244' class='documenter-source'>source</a><br>

<a id='SVR.loadmodel-Tuple{AbstractString}' href='#SVR.loadmodel-Tuple{AbstractString}'>#</a>
**`SVR.loadmodel`** &mdash; *Method*.



Load a libSVM model

Methods:

  * `SVR.loadmodel(filename::AbstractString)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:321

Arguments:

  * `filename::AbstractString` : input file name

Returns:

  * SVM model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L311-L319' class='documenter-source'>source</a><br>

<a id='SVR.mapnodes-Tuple{AbstractArray}' href='#SVR.mapnodes-Tuple{AbstractArray}'>#</a>
**`SVR.mapnodes`** &mdash; *Method*.



Methods:

  * `SVR.mapnodes(x::AbstractArray)` : C:\Users\monty.julia\dev\SVR\src\SVRlib.jl:63

Arguments:

  * `x::AbstractArray` :


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRlib.jl#L59-L64' class='documenter-source'>source</a><br>

<a id='SVR.mapparam-Tuple{}' href='#SVR.mapparam-Tuple{}'>#</a>
**`SVR.mapparam`** &mdash; *Method*.



Methods:

  * `SVR.mapparam(; svm_type, kernel_type, degree, gamma, coef0, C, nu, epsilon, cache_size, tolerance, shrinking, probability, nr_weight, weight_label, weight)` : C:\Users\monty.julia\dev\SVR\src\SVRlib.jl:23

Keywords:

  * `C` : cost; penalty parameter of the error term [default=`1.0`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types [default=`0.0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `epsilon` : epsilon for EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`1e-9`]
  * `gamma` : coefficient for RBF, POLY and SIGMOND kernel types [default=`1.0`]
  * `kernel_type` : kernel type [default=`RBF`]
  * `nr_weight` : [default=`0`]
  * `nu` : upper bound on the fraction of training errors / lower bound of the fraction of support vectors; acceptable range (0, 1]; applied if NU_SVR model [default=`0.5`]
  * `probability` : train to estimate probabilities [default=`false`]
  * `shrinking` : apply shrinking heuristic [default=`true`]
  * `svm_type` : SVM type [default=`EPSILON_SVR`]
  * `tolerance` : tolerance; stopping criteria[default=`0.001`]
  * `weight` : [default=`Ptr{Cdouble}(0x0000000000000000)`]
  * `weight_label` : [default=`Ptr{Cint}(0x0000000000000000)`]

Returns:

  * parameter


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRlib.jl#L1-L20' class='documenter-source'>source</a><br>

<a id='SVR.predict-Tuple{SVR.svmmodel, AbstractArray{Float64}}' href='#SVR.predict-Tuple{SVR.svmmodel, AbstractArray{Float64}}'>#</a>
**`SVR.predict`** &mdash; *Method*.



Predict based on a libSVM model

Methods:

  * `SVR.predict(pmodel::SVR.svmmodel, x::AbstractArray{Float64})` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:69

Arguments:

  * `pmodel::SVR.svmmodel` : the model that prediction is based on
  * `x::AbstractArray{Float64}` : array of independent variables

Return:

  * predicted dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L58-L66' class='documenter-source'>source</a><br>

<a id='SVR.r2-Tuple{AbstractVector, AbstractVector}' href='#SVR.r2-Tuple{AbstractVector, AbstractVector}'>#</a>
**`SVR.r2`** &mdash; *Method*.



Compute the coefficient of determination (r2)

Methods:

  * `SVR.r2(x::AbstractVector, y::AbstractVector)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:403

Arguments:

  * `x::AbstractVector` : observed data
  * `y::AbstractVector` : predicted data

Returns:

  * coefficient of determination (r2)


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L393-L401' class='documenter-source'>source</a><br>

<a id='SVR.readlibsvmfile-Tuple{AbstractString}' href='#SVR.readlibsvmfile-Tuple{AbstractString}'>#</a>
**`SVR.readlibsvmfile`** &mdash; *Method*.



Read a libSVM file

Methods:

  * `SVR.readlibsvmfile(file::AbstractString)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:377

Arguments:

  * `file::AbstractString` : file name

Returns:

  * array of independent variables
  * vector of dependent variables


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L366-L375' class='documenter-source'>source</a><br>

<a id='SVR.savemodel-Tuple{SVR.svmmodel, AbstractString}' href='#SVR.savemodel-Tuple{SVR.svmmodel, AbstractString}'>#</a>
**`SVR.savemodel`** &mdash; *Method*.



Save a libSVM model

Methods:

  * `SVR.savemodel(pmodel::SVR.svmmodel, filename::AbstractString)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:343

Arguments:

  * `filename::AbstractString` : output file name
  * `pmodel::SVR.svmmodel` : svm model

Dumps:

  * file with saved model


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L332-L340' class='documenter-source'>source</a><br>

<a id='SVR.test-Tuple{}' href='#SVR.test-Tuple{}'>#</a>
**`SVR.test`** &mdash; *Method*.



Test SVR


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L3' class='documenter-source'>source</a><br>

<a id='SVR.train-Tuple{AbstractVector{Float64}, AbstractArray{Float64}}' href='#SVR.train-Tuple{AbstractVector{Float64}, AbstractArray{Float64}}'>#</a>
**`SVR.train`** &mdash; *Method*.



Train based on a libSVM model

Methods:

  * `SVR.train(y::AbstractVector{Float64}, x::AbstractArray{Float64}; svm_type, kernel_type, degree, gamma, coef0, C, nu, epsilon, cache_size, tol, shrinking, probability, verbose)` : C:\Users\monty.julia\dev\SVR\src\SVRfunctions.jl:32

Arguments:

  * `x::AbstractArray{Float64}` : array of independent variables
  * `y::AbstractVector{Float64}` : vector of dependent variables

Keywords:

  * `C` : cost; penalty parameter of the error term [default=`1.0`]
  * `cache_size` : size of the kernel cache [default=`100.0`]
  * `coef0` : independent term in kernel function; important only in POLY and  SIGMOND kernel types [default=`0.0`]
  * `degree` : degree of the polynomial kernel [default=`3`]
  * `epsilon` : epsilon in the EPSILON_SVR model; defines an epsilon-tube within which no penalty is associated in the training loss function with points predicted within a distance epsilon from the actual value [default=`1e-9`]
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


<a target='_blank' href='https://github.com/madsjulia/SVR.jl/blob/a19124b4b302a7a9091e7def28171a78438ce91e/src/SVRfunctions.jl#L8-L16' class='documenter-source'>source</a><br>

