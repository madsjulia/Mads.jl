<div class="animatescroll"><a name="manual:top" id="manual:top"></a>

# **MADS** Manual

*   [Overview and Features](#overview-and-features)
*   [Execution](#mads-execution)
*   [Command-line keywords and options](#mads-command-line-keywords-and-options)
*   [Input and output files](#mads-input-and-output-files)
*   [Format of MADS input files](#format-of-mads-input-files)
*   [Compilation](#mads-compilation)
*   [Verification](#mads-verification)
*   [Test examples](#mads-test-examples)

### Overview and Features
<a name="manual:overview" id="manual:overview"></a>

**MADS** (Model Analyses & Decision Support) is an object-oriented code that is capable of performing various types of model analyses, and supporting model-based decision making. The code can be executed under different computational modes, which include (1) sensitivity analysis, (2) model calibration (parameter estimation), (3) uncertainty quantification, (4) model selection, (5) model averaging, and (6) decision analysis.

**MADS** can be externally coupled with any existing model simulator through integrated modules that read/write input and output files using a set of template and instruction files. **MADS** can also work with existing control, template and instruction files developed for the code [PEST (Doherty 2009)](http://www.pesthomepage.org/Home.php).

**MADS** is internally coupled with a series of built-in analytical simulators (currently the analytical solutions are for contaminant transport in aquifer only). In addition, **MADS** can be used as a library (toolbox) for internal coupling with any existing object-oriented simulator using object-oriented programming.

**MADS** provides (1) efficient parallelization, (2) runtime control, restart, and preemptive termination, (3) advanced Latin-Hypercube sampling techniques (including [Improved Distributed Sampling](http://people.sc.fsu.edu/~jburkardt/f_src/ihs/ihs.html)), (4) several gradient-based Levenberg-Marquardt optimization methods (including [LevMar](http://www.ics.forth.gr/~lourakis/levmar/)), (5) advanced single- and multi-objective global optimization methods (including Particle Swarm Optimization, [PSO](http://www.particleswarm.info/), [TRIBES](http://clerc.maurice.free.fr/pso/Tribes/Tribes_MO/Tribes_MO.html), and SQUADS), and (6) local and global sensitivity and uncertainty analyses (including ABAGUS), and (7) information gap remediation decision analyses (under development).

**MADS** is written in C/C++ and tested on various Unix platforms (Linux, Mac OS X, Cygwin MS Windows). The **MADS** simulations are performed using command-line execution. A graphic user interface (GUI) using Java/Eclipse is currently under development as well.

**MADS** is characterized by several unique features:

*   Provides an integrated computational framework for a wide range of model-based analyses, and supports model-based decision making.
*   **MADS** is designed to be capable to work in an adaptive mode with minimum input from the user.
    For example, ‘**mads s01**’ is sufficient to perform calibration of problem ‘**s01**’ and ‘**mads montecarlo s01**’ is sufficient to perform uncertainty analysis of problem ‘**s01**’. All the parameters controlling the performance of these analyses are estimated internally by **MADS**.
    Nevertheless, if needed, the user has the flexibility to specify a wide range of options.
*   The same problem input file(in the previous case, ‘**s01.mads**’)is sufficient and can be applied to perform all the possible model analyses supported by **MADS**.
    Different analyses can be invoked using different command-line keywords and options.
    If preferred, the keywords can be provided on the first line of the problem input file as well.
*   Most of the model analysis can be performed using a discretized parameter space (e.g. **PPSD**, **IGPD**, **ABAGUS**).
    This can substantially reduce the computational effort to perform various model analyses (e.g. calibration, uncertainty quantification, and sensitivity analysis, performance assessment).
*   Highly-parameterized inversion where the number of model parameters is substantially greater than the number of model constraints (calibration targets or model observations); a similar approach is called [SVD-assist](http://www.pesthomepage.org/Highly-parameterized_inversion.php) in [PEST](http://www.pesthomepage.org).
*   Permits the use of 'acceptable' calibration ranges for each optimization target.
    In this way, the model solutions can be constrained to produce predictions within acceptable calibration ranges.
    This feature is implemented using the keyword ‘**<u>[obsrange](#calibration-termination-criteria)</u>**’.
*   Allows the use of an acceptable calibration range for the objective function.
    In this way, acceptable model solutions can be identified as those producing objective functions below a predefined cutoff value. Once the objective function is decreased below the cutoff value, the optimization is terminated. This feature is implemented using the keyword ‘**<u>[cutoff](#calibration-termination-criteria)</u>**’.
*   Implements a series of alternative objective functions (OF).
*   By default, all the model parameters are internally normalized and transformed in a manner that substantially improves the optimization process.
*   Provides the option to perform a series of optimizations with random initial guesses for optimization parameters.
*   Provides the option to automatically retry the optimization process using a series of random initial guesses for optimization parameters until an acceptable calibration is achieved (keyword ‘**[retry](#calibration-options)**’).
*   Automatically detects and utilizes multi-processor resources for parallel execution.
*   Analyzes the runtime performance of the available parallel hosts (processors); hosts not capable of performing the requested parallel jobs are dynamically ignored.
*   Tracks the multiple model files during parallel execution automatically; for the user, there is no difference between serial (using single processor) and parallel modes of execution.
*   Performs automatic bookkeeping of all the model results for efficient restart and rerun of **MADS** jobs (e.g. if the previous job was not completed) and additional posterior analyses.
*   Allows the user to perform different types of analyses based on model results stored during previous **MADS** runs; for example, model runs obtained during model calibration can be utilized in posterior Monte Carlo analyses.
*   Provides a built-in protection against simultaneous execution of conflicting **MADS** runs in the same working directory.
*   Automatically renames the files obtained during previous **MADS** runs by default using unique date & time information in the file names to avoid overwriting.
*   Object-oriented design of **MADS** allows for relatively easy integration with other object-oriented optimization or sampling techniques.

[Back to top](#mads-manual)

## <a name="manual:execution" id="manual:execution"></a>**MADS** Execution:

```bash
mads [ problem_name | input_file_name ] [ keywords | options ]
```

**MADS** execution requires at minimum either a **problem name (_problem_name_)** or **problem input file (_input_file_name_)**.

**problem name (_problem_name_)**: Problem root name defines the file names of various **MADS** input and outputs files. A problem input file named **_problem_name_.mads** is expected to exist.

**problem input file (_input_file_name_)**: an input file that can completely define the simulated problem. The file follows a predefined **MADS** format. It includes information about the simulation type, model parameters, and model observations (calibration targets).

The root of the input file defines the **_problem_name_** used to specify file names of various files associated with simulation outputs. For example, the file named **_problem_name_.results** contains the model results, and the file named **_problem_name_-rerun.mads** contains information that allows the last simulation to be restarted with the previous runs calibration results. All the possible model analyses can be performed using the same problem input file **(_input_file_name_)**.

**MADS** is compatible to work with [PEST](http://www.pesthomepage.org/Home.php) control, template and instruction files. To work with [PEST](http://www.pesthomepage.org/Home.php) files, **input_file_name** should be a [PEST](http://www.pesthomepage.org/Home.php) control file **_problem_name_.pst**.

After the **_problem_name_** or the **_input_file_name_** a series of keywords and options can be provided (all optional). All the keywords are case insensitive. If there are no keywords or options, model calibration will be performed by default. The keywords and options can be provided to **MADS** either on the command-line or on the first line of the problem input file (**_problem_name_.mads**).

The keywords and options can be specified in any order; if there are contradictions (for example both ‘**<u>montecarlo</u>**’ and ‘**<u>calibrate</u>**’ are provided), the priorities are defined by the keyword order in the problem input file followed by the command-line queue (e.g. the last command-line keyword can overwrite any previous definitions).

Executing **MADS** without any arguments (‘**mads**’) produces screen output describing **MADS** keywords and options for quick reference.

[Back to top](#mads-manual)

## <a name="manual:keywords" id="manual:keywords"></a>**MADS** Command-line keywords and options:

## Problem type keywords (all the keywords and options are case insensitive):

<a name="manual:forward" id="manual:forward"></a>**<u>forward</u>**: Perform a single forward model simulation based on the model parameters provided in the input problem file. The results are stored in a file named **_problem_name_.results**.

<a name="manual:create" id="manual:create"></a>**<u>create</u>**: Create a **MADS** input file with calibration targets based on current model parameters. If the keyword is specified, **MADS** will perform a single forward model simulation based on the model parameters provided in the input problem file. A file named **_problem_name_-truth.mads** is created with the simulated values inserted as calibration target values. The simulation results are stored in a file named **_problem_name_.results**.

<a name="manual:calibrate" id="manual:calibrate"></a>**<u>calibrate</u>**: Perform a calibration run where the model parameters are calibrated against the calibration targets. This process can also be called model inversion or parameter estimation. This is the default **MADS** problem type (if no other problem type keywords are specified). The calibration results are stored in a file named **_problem_name_.results**. Calibration can be performed using various optimization techniques (global and local), objective functions, weighting schemes, and optimization constraints. The analyses can be performed using various schemes for computing the initial guesses for optimization parameters. The calibrations can be performed in parallel (available resources are automatically detected) and automatically restarted.

<a name="manual:montecarlo" id="manual:montecarlo"></a>**<u>montecarlo</u>**: Perform an uncertainty analysis using Monte Carlo sampling. The sampling results are stored in files named (1) **_problem_name_.mcrnd*** (including all the Monte Carlo runs), and (2) **_problem_name_.results** (representing the result with the lowest objective function). Various alternative sampling techniques can be selected using the keyword ‘**<u>smp</u>**’. The sample runs can be performed in parallel (available resources are automatically detected) and automatically restarted.

<a name="manual:gsens" id="manual:gsens"></a>**<u>gsens</u>**:Perform a global sensitivity analysis. Currently, the <u>Sobol Non-linear Sensitivity method (Sobol. IM, 1993</u> [Global sensitivity indices for nonlinear mathematical models and their Monte Carlo estimates](http://linkinghub.elsevier.com/retrieve/pii/S0378475400002706)<u>)</u> is implemented. **MADS** uses Monte Carlo estimation of the Sobol indices, requiring 2 independent random samples with equal dimensions. The number of model evaluations is _n_ * (_N_ + 1) where _n_ is the size of the samples and _N_ is the number of Sobol indices (model parameters). The global sensitivity analysis results are stored in files named **_problem_name_.gsens***.

<a name="manual:lsens" id="manual:lsens"></a>**<u>lsens</u>**<u>:</u> Perform a local sensitivity analysis computing the Jacobian matrix either for the initial values provided in the input file or for the final calibration results (depending on the combination of keywords). The local sensitivity analysis results are stored in files named **_problem_name_.sensitivity**.

<a name="manual:eigen" id="manual:eigen"></a>**<u>eigen</u>**<u>:</u> Perform an eigen analysis of the Jacobian matrix either for the initial values provided in the input file or for the final calibration results (depending on the combination of keywords). The eigen analysis results are stored in files named **_problem_name_.eigen**.

<a name="manual:abagus" id="manual:abagus"></a>**<u>abagus</u>**: Perform an Agent-Based Global Uncertainty & Sensitivity Analysis (**ABAGUS**). The **ABAGUS** run identifies optimization parameter sets producing objective function values below a predefined cutoff value (keyword '**cutoff'**) or within predefined calibration ranges for each target (keyword **'[obsrange](#calibration-termination-criteria)**') on a discretized parameter space. The ABAGUS results, including optimization parameter values and their associated objective function value are stored in files named **_problem_name_.pssa**.

<a name="manual:postpua" id="manual:postpua"></a>**<u>postpua</u>**: Perform an analysis of predictive uncertainties (currently processing **ABAGUS** outputs only; the Monte Carlo outputs will be added in the future). Desired predictions are identified as “**observations**” with weight>0\.

<a name="manual:infogap" id="manual:infogap"></a>**<u>infogap</u>**: Perform an information gap decision analysis. Results are stored in files named **_problem_name-pred_**k**_.igap_**, where k is the index of the performance metric prediction (one file is generated for each performance metric prediction). Performance metric predictions are identified in **_problem_name.mads_** as “**observations**” with weight=-1.

Examples for executing different types of model-based analyses with **MADS** are presented in [Examples](mads-examples.md), [Demos](mads-demos.md), [Screenshots](mads-screenshots.md), and [Comparisons](mads-comparisons.md) sections.

[Back to top](#mads-manual)

## Calibration method keywords:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

single

</td>

<td class="keywordsright">

**_single calibration using initial guesses provided in the input file_**;
this type of calibration is performed by default; the keyword does not need to be provided

</td>

</tr>

<tr>

<td class="keywordsleft">

igrnd

</td>

<td class="keywordsright">

**_sequential multi-start (multi-try) calibrations using a set of random initial values_**;
the number of initial guess realizations is defined by **real**=X

</td>

</tr>

<tr>

<td class="keywordsleft">

igpd

</td>

<td class="keywordsright">

**_sequential multi-start (multi-try) calibrations using a set of discretized initial values_**;
the parameter space discretization is defined in the **MADS** input file

</td>

</tr>

<tr>

<td class="keywordsleft">

ppsd

</td>

<td class="keywordsright">

**_sequential multi-start (multi-try) calibrations using Partial Parameter Space Discretization (**PPSD**) method_**;
in this case, the discretized model parameters are kept fixed during each multi-start (multi-try) calibration;
the parameter space discretization is defined in the **MADS** input file.

</td>

</tr>

</tbody>

</table>

### <a name="manual:terminate" id="manual:terminate"></a>Calibration termination criteria:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

eval=[integer]

</td>

<td class="keywordsright">

terminate calibration if the **_number of functional evaluations exceeds a predefined value_** [default eval=5000]

</td>

</tr>

<tr>

<td class="keywordsleft">

cutoff=[real]

</td>

<td class="keywordsright">

terminate calibration (or collect solution in the case of **abagus**) if the **_objective function is below the cutoff value_** [default cutoff=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

parerror=[real]

</td>

<td class="keywordsright">

terminate calibration (or collect solution in the case of **abagus**) if the **_estimated model parameters are within a predefined absolute error_** range from their known true values
applied in the case of test functions with known solution
[default parerror=0; i.e. termination criteria is not applied]

</td>

</tr>

<tr>

<td class="keywordsleft">

obsrange

</td>

<td class="keywordsright">

terminate calibration (or collect solution in the case of **abagus**) if **_model predictions are within predefined calibration ranges_**

</td>

</tr>

<tr>

<td class="keywordsleft">

obserror=[real]

</td>

<td class="keywordsright">

terminate calibration (or collect solution in the case of **abagus**) if **_model predictions are within a predefined absolute error range from their observed values_**
[default obserror=0; i.e. termination criteria is not applied]

</td>

</tr>

</tbody>

</table>

### <a name="manual:caliboptions" id="manual:caliboptions"></a>Calibration options:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

retry=[integer]

</td>

<td class="keywordsright">

number of retries in the case of multi-try (multi-start) model analyses [default retry=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

iter=[integer]

</td>

<td class="keywordsright">

number of Levenberg-Marquardt iterations [default iter=50]

</td>

</tr>

<tr>

<td class="keywordsleft">

particles=[integer]

</td>

<td class="keywordsright">

number of initial particles or tribes [default particles=10+2*sqrt(Number_of_parameters)]

</td>

</tr>

<tr>

<td class="keywordsleft">

lmfactor=[double]

</td>

<td class="keywordsright">

multiplier applied to compute when to initiate LM searches within **SQUADS** algorithm [default lmfactor=1]

</td>

</tr>

<tr>

<td class="keywordsleft">

leigen OR eigen

</td>

<td class="keywordsright">

eigen analysis of the final optimized solution

</td>

</tr>

</tbody>

</table>

[Back to top](#mads-manual)

## Optimization method (**opt=**[string]; various combinations are possible, e.g. pso_std_lm_gsl):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

opt=lm

</td>

<td class="keywordsright">

Local Levenberg-Marquardt optimization [default]

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=lm_levmar

</td>

<td class="keywordsright">

Local Levenberg-Marquardt optimization using **LevMar** library

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=lm_gsl

</td>

<td class="keywordsright">

Local Levenberg-Marquardt optimization using **GSL** library

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=pso

</td>

<td class="keywordsright">

Global Particle Swarm optimization (default Standard2006)

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=apso

</td>

<td class="keywordsright">

Global Adaptive Particle Swarm optimization (default **TRIBES**)

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=swarm

</td>

<td class="keywordsright">

Global Particle Swarm optimization Standard2006 (also opt=pso_std)

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=tribes

</td>

<td class="keywordsright">

Global Particle Swarm optimization **TRIBES** (also opt=pso_tribes)

</td>

</tr>

<tr>

<td class="keywordsleft">

opt=squads

</td>

<td class="keywordsright">

**SQUADS**: Adaptive hybrid optimization using coupled local and global optimization techniques

</td>

</tr>

</tbody>

</table>

## Sampling method (**smp=**[string] OR **mslm=**[string] for Multi-Start Levenberg-Marquardt (**MSLM**) analysis using multiple retries with different random initial guesses for unknown model parameters):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

smp=olh

</td>

<td class="keywordsright">

Optimal Latin Hypercube Sampling [default] (if real = 1 **RANDOM**; if real > **IDLHS**; if real > 500 **LHS**)
Sampling is performed using internally computed or user provided seed.

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=lhs

</td>

<td class="keywordsright">

Latin Hypercube Sampling (**LHS**) [default smp=lhs_random]

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=lhs_random

</td>

<td class="keywordsright">

Latin Hypercube Sampling (**LHS**) with random placement of the particles within hypercube cells

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=lhs_center

</td>

<td class="keywordsright">

Latin Hypercube Sampling (**LHS**) with particle placement at the center of the hypercube cells

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=lhs_edge

</td>

<td class="keywordsright">

Latin Hypercube Sampling (**LHS**) with particle placement at the edges of the hypercube cells

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=idlhs

</td>

<td class="keywordsright">

Improved Distributed Latin Hypercube Sampling (**IDLHS**; aka **IHS**)

</td>

</tr>

<tr>

<td class="keywordsleft">

smp=random

</td>

<td class="keywordsright">

Random sampling

</td>

</tr>

</tbody>

</table>

## Sampling options:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

real=[integer]

</td>

<td class="keywordsright">

number of random realizations (samples) [default real=100]

</td>

</tr>

<tr>

<td class="keywordsleft">

case=[integer]

</td>

<td class="keywordsright">

execute a single case from all the realizations (samples) (applied in **PPSD**, **IGPD**, **IGRND**, **MONTECARLO** model-based analyses)

</td>

</tr>

<tr>

<td class="keywordsleft">

seed=[integer]

</td>

<td class="keywordsright">

random seed value [randomly generated by default]

</td>

</tr>

</tbody>

</table>

## Objective function options:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

ssr

</td>

<td class="keywordsright">

sum of the squared residuals [default]

</td>

</tr>

<tr>

<td class="keywordsleft">

ssd0

</td>

<td class="keywordsright">

sum of the squared discrepancies

</td>

</tr>

<tr>

<td class="keywordsleft">

ssda

</td>

<td class="keywordsright">

sum of the squared discrepancies and absolute residuals

</td>

</tr>

<tr>

<td class="keywordsleft">

ssdr

</td>

<td class="keywordsright">

sum of the squared discrepancies and squared residuals

</td>

</tr>

</tbody>

</table>

[Back to top](#mads-manual)

## Transformation of parameter space and observations (calibration targets):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

nosin

</td>

<td class="keywordsright">

Sin transformation of optimized parameters is not applied [parameters are sin transformed by default]

</td>

</tr>

<tr>

<td class="keywordsleft">

plog=[-1,0,1]

</td>

<td class="keywordsright">

All (plog=1) or no (plog=0) optimization parameters are log-transformed [default: log transformation is designated for each parameter in the input file (plog=-1)]

</td>

</tr>

<tr>

<td class="keywordsleft">

olog=[-1,0,1]

</td>

<td class="keywordsright">

All (olog=1) or no (olog=0) observations (simulated and measured) are log-transformed [default: log transformation is designated for each observation in the input file (olog=-1)]

</td>

</tr>

<tr>

<td class="keywordsleft">

oweight=[-1,0,1,2]

</td>

<td class="keywordsright">

Weights for all the observation residuals in **_problem_name.mads_** are overwritten: 0 = zero weight, 1 = unit weight, 2 = weight inversely proportional to observation [default: designated weights in **_problem_name.mads_** are used (oweight=-1)]

</td>

</tr>

</tbody>

</table>

## Parallelization:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

np=[integer]

</td>

<td class="keywordsright">

number of requested parallel jobs [optional]

</td>

</tr>

<tr>

<td class="keywordsleft">

rstfile=[string]

</td>

<td class="keywordsright">

name of existing zip restart file to be used (created by previous Parallel **MADS** run) [optional]

</td>

</tr>

<tr>

<td class="keywordsleft">

restart=[integer]

</td>

<td class="keywordsright">

restart=1 (default; automatic restart if possible); restart=0 (force no restart); restart=2 (force restart); by default the analyses will be restarted automatically (restart=1)

</td>

</tr>

</tbody>

</table>

## **ABAGUS** (Agent-Based Global Uncertainty & Sensitivity Analysis) options (**abagus**):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

infile=[string]

</td>

<td class="keywordsright">

name of previous **ABAGUS** results file to be used to initialize KD-tree [default=NULL]

</td>

</tr>

<tr>

<td class="keywordsleft">

energy=[integer]

</td>

<td class="keywordsright">

initial energy for swarm [default energy=10000]

</td>

</tr>

<tr>

<td class="keywordsleft">

cutoff=[real]

</td>

<td class="keywordsright">

maximum objective function value for acceptable solutions to be collected

</td>

</tr>

<tr>

<td class="keywordsleft">

obsrange

</td>

<td class="keywordsright">

collect solutions that produce simulations within predefined calibration ranges for each target

</td>

</tr>

</tbody>

</table>

## Information gap decision analysis options (**infogap**):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

infile=[string]

</td>

<td class="keywordsright">

name of **ABAGUS** results file to perform information gap decision analysis

</td>

</tr>

</tbody>

</table>

## Predictive uncertainty analysis options (**postpua**):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

infile=[string]

</td>

<td class="keywordsright">

name of **ABAGUS** results file to perform predictive uncertainty analysis

</td>

</tr>

</tbody>

</table>

[Back to top](#mads-manual)

## Build-in analytical solutions:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

point

</td>

<td class="keywordsright">

point contaminant source in 3D flow domain

</td>

</tr>

<tr>

<td class="keywordsleft">

plane

</td>

<td class="keywordsright">

areal contaminant source in 3D flow domain

</td>

</tr>

<tr>

<td class="keywordsleft">

box

</td>

<td class="keywordsright">

block contaminant source in 3D flow domain

</td>

</tr>

</tbody>

</table>

## Built-in test problems for global optimization / uncertainty-quantification techniques (local techniques will not work):

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

test=[integer]

</td>

<td class="keywordsright">

test problem ID [default=1]:
1: Parabola
2: Griewank
3: Rosenbrock
4: De Jong's Function #4
5: Step
6: Alpine function (Clerc's Function #1)
7: Rastrigin
8: Krishna Kumar
9: 2D Tripod function
10: Shekel's Foxholes 2D
11: Shekel's Foxholes 5D
12: Shekel's Foxholes 10D
20: Shekel's Foxholes 2D (alternative; global methods only)
21: Polynomial fitting (global methods only)
22: Ackley (global methods only)
23: Eason 2D (global methods only)
31: Rosenbrock (simplified)
32: Griewank (alternative)
33: Rosenbrock (alternative)
34: Powell's Quadratic
35: Booth
36: Beale
37: Parsopoulos

Curve-fitting test functions:
40: Sin/Cos data fitting (2 parameters)
41: Sin/Cos data fitting (4 parameters)
42: Sin/Cos data fitting (2 parameters; simplified)
43: Exp data fitting I (5 parameters)
44: Exp data fitting II (11 parameters)

</td>

</tr>

<tr>

<td class="keywordsleft">

dim=[integer]

</td>

<td class="keywordsright">

dimensionality of parameter space for the test problem (fixed for some of the problems) [default=2]

</td>

</tr>

<tr>

<td class="keywordsleft">

npar=[integer]

</td>

<td class="keywordsright">

number of model parameters for the data fitting (fixed for some of the problems) [default=2]

</td>

</tr>

<tr>

<td class="keywordsleft">

nobs=[integer]

</td>

<td class="keywordsright">

number of observations for the data fitting test problem (fixed for some of the problems) [default=2]

</td>

</tr>

<tr>

<td class="keywordsleft">

pardomain=[float]

</td>

<td class="keywordsright">

parameter space domain size [default pardomain=100]

</td>

</tr>

</tbody>

</table>

## Debugging / verbose levels:

<table class="keywords">

<tbody>

<tr>

<td class="keywordsleft">

debug=[0-5]

</td>

<td class="keywordsright">

general debugging [default debug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

fdebug=[0-5]

</td>

<td class="keywordsright">

model evaluation debugging [default fdebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

ldebug=[0-3]

</td>

<td class="keywordsright">

Levenberg-Marquardt (**LM**) optimization debugging [default ldebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

pdebug=[0-3]

</td>

<td class="keywordsright">

Particle Swarm optimization debugging [default pdebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

mdebug=[0-3]

</td>

<td class="keywordsright">

Random sampling debugging [default mdebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

odebug=[0-1]

</td>

<td class="keywordsright">

Objective function progress [default odebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

tpldebug=[0-3]

</td>

<td class="keywordsright">

Debug the writing of external files [default tpldebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

insdebug=[0-3]

</td>

<td class="keywordsright">

Debug the reading of external files [default insdebug=0]

</td>

</tr>

<tr>

<td class="keywordsleft">

pardebug=[0-3]

</td>

<td class="keywordsright">

Debug the parallel execution [default pardebug=0]

</td>

</tr>

</tbody>

</table>

## <a name="manual:files" id="manual:files"></a>**MADS** Input and output files

_problem_name_**.mads**: an input file that can completely define the analyzed problem. The file follows a predefined **MADS** input format. It includes information about the simulation type, model parameters, and model observations.
_problem_name_**.results**: an output file containing the **MADS** results
_problem_name_**.residuals**: an output file containing the residuals between model predictions and calibration targets (if applicable)
_problem_name_**.jacobian**: an output file containing the Jacobian (local sensitivity) matrix
_problem_name_**.covariance**: an output file containing the covariance matrix
_problem_name_**.correlation**: an output file containing the correlation matrix
_problem_name_**.eigen**: an output file containing the eigen matrix and eigen values
_problem_name_**.phi**: an output file containing information about the final objective function
_problem_name_**.ofe**: an output file containing information about the objective function minimization progress as a function of model evaluations
_problem_name_**.mcrnd***: output files containing Monte Carlo (**MC**) analysis results
_problem_name_**.igrnd***: output files containing Random Initial Guesses (**IGRND**) results
_problem_name_**.igpd***: output files containing Partially Discretized Initial Guesses (**IGPD**) results
_problem_name_**.ppsd***: output files containing Partial Parameter Space Discretization (**PPSD**) results
_problem_name_**-rerun.mads**: an output file that can be used as a **MADS** input file. It contains all the information needed to restart the last calibration. The model parameters are modified to represent the current best estimates. The file follows a predefined **MADS** input format.
_problem_name_**._igap_**: output files containing remediation information gap (**infogap**) results
_problem_name_**._pssa_**: output files containing **ABAGUS** results
_problem_name_**._pua_**: output files containing predictive uncertainty analysis (**postpua**) results

[Back to top](#mads-manual)

## <a name="manual:format" id="manual:format"></a>Format of **MADS** input files

## **MADS** Problem files (***.mads**)

The **MADS** input problem files provide information about the model parameters needed to execute the model simulator and the model observations (calibration targets) that will be applied to evaluate the model performance. The input file typically has the following format (this example file called **w01.mads** is located in directory **example/wells-short**):

[![](manual_images/mads-file-format.jpg)[click to enlarge]](manual_images/mads-file-format.jpg "MADS File Format")

The key data blocks in the **MADS** problem file are defined above.

The format associated with model parameters and observations is defined below.

[![](manual_images/mads-file-format2.jpg)[click to enlarge]](manual_images/mads-file-format2.jpg "MADS File Format: Model parameters")

[![](manual_images/mads-file-format3.jpg)[click to enlarge]](manual_images/mads-file-format3.jpg "MADS File Format: Model observations")

Instead of **MADS** problem file, **MADS** can also read and work with the standard [PEST](http://www.pesthomepage.org/Home.php) control (problem) files (‘***.pst**’) without any conversion.

## **MADS** Template files (***.tpl**)

The **MADS** template files provide the current values of the model parameters to the external simulator. In this case, the file ‘**w01.tpl**’ is applied to create the model input file ‘**w01.wells**’. The file ‘**w01.tpl**’ is located in directory ‘**example/wells-short**’. The template input file typically has the following format:

[![](manual_images/mads-file-format4.jpg)[click to enlarge]](manual_images/mads-file-format4.jpg "MADS File Format: Template file")

In this case, the template file is based on the **WELLS** ([wells.lanl.gov](http://wells.lanl.gov)) input file where two of the input model parameters (‘**Permeability**’ and ‘**Storage coefficient**’) will be replaced by **MADS** with the current values associated with these model parameters. The model parameters are defined in the **MADS** problem file ‘**w01.mads**’ and labeled as “**k**” and “**S**”. The first line with the keyword ‘**template**’ is optional. In this case, it defines the special variable symbol “**%**” that is going to be applied to define the fields where model parameters will be placed. If the first line is missing, the special variable symbol “**#**” is assumed by default. More than one template files can be applied to generate a series of model input files. Each model parameter can appear multiple times in the template files.

The easiest way to create a template file is to take an existing model input file and replace the model parameters provided to **MADS** for analysis with the name of model parameters as defined in the **MADS** problem file. The model parameter names should be surrounded with the special variable symbol.

The **MADS** template file format is similar to the format implemented in the code [PEST](http://www.pesthomepage.org/Home.php). In fact, **MADS** can use the standard [PEST](http://www.pesthomepage.org/Home.php) template files as well without any conversion.

The template files can be debugged using the keyword ‘**tpldebug**’ (for example:‘**mads w01 tbldebug**’).

## **MADS** Instruction files (***.inst**)

The **MADS** instruction files are applied to read the current model observations (predictions) obtained from the external simulator based on the current model parameters. In this case, the file ‘**w01.inst**’ is applied to read the model output file ‘**w01.s_point**’. There are several alternative versions of the instruction file (‘__w01-v*.inst__’) provided in directory ‘**example/wells-short**’. The instruction files typically have the following format:

[![](manual_images/mads-file-format5.jpg)[click to enlarge]](manual_images/mads-file-format5.jpg "MADS File Format: Instruction file")

The observation names are shown in ‘**red**’ and are specified in the **MADS** control file. All the instruction files presented above are equivalent in terms that all of them are extracting the same information from the model output file ‘**w01.s_point**’. The file format is somewhat similar to the format implemented in the code [PEST](http://www.pesthomepage.org/Home.php). In fact, **MADS** can use the standard [PEST](http://www.pesthomepage.org/Home.php) instruction files as well without any conversion.

The first line with the keyword ‘**instruction**’ is optional. In the case of ‘**w01-v1.inst**’, it defines that the special search symbol “**%**” is going to be applied to search for numeric or character patterns in the model output file, the special observation symbol “**!**” is going to be applied to define the location of the observations within the model output file. If the first line is missing as in the case of ‘**w01-v4.inst**’, the symbols “**@**” and “**!**” are assumed by default for the search and observation tokens, respectively. Each consecutive instruction line in the instruction file starts with either (1) the letter “**l**” or (2) the special search symbol. In the case of  “**l**”, the following number defines how many lines to be skipped (for example, “**l1**” means go to the next line; “**l2**” means skip one line). In the case of search symbol, the content of the model output file is skipped until search phrase is found. The letter “**w**” forces skipping of white-character spaces. The keyword “**dum**” defines dummy observations that are ignored.

Note that the search phrase “**@0@**” in files ‘**w01-v3.inst**’ and ‘**w01-v4.inst**’ can be dangerous since the digit “**0**” can occur in many locations in the model output file.

Comparing ‘**w01-v3.inst**’ and ‘**w01-v4.inst**’ it is clear that the search pattern does not need to include the entire number of characters that are expected to be in the model output file. The search pattern also does not need to be at the beginning of the line.

The instruction files can be debugged using the keyword ‘**insdebug**’ (for example: ‘**mads w01 insdebug**’).

## <a name="manual:compilation" id="manual:compilation"></a>**MADS** Compilation

To compile, extract the provided **mads.tgz** file (**tar xvf mads.tgz**) and execute '**make**'. GSL, LAPACK and BLAS libraries are expected to be available.

*   [GSL](ftp://ftp.gnu.org/gnu/gsl/):                     ftp://ftp.gnu.org/gnu/gsl/
*   [LAPACK](http://www.netlib.org/lapack/):              http://www.netlib.org/lapack/
*   [BLAS](http://www.netlib.org/blas/):                   http://www.netlib.org/blas/

If **macports** is installed ([www.macports.org](http://www.macports.org)), these packages can be installed on MAC OS X machines using the following commands (requiring administrative privileges):

*   sudo port install blas
*   sudo port install lapack
*   sudo port install gsl

[Back to top](#mads-manual)

## <a name="manual:verification" id="manual:verification"></a>**MADS** Verification

To verify that **MADS** is running properly, execute '**make verify**'.

## <a name="manual:examples" id="manual:examples"></a>**MADS** Test Examples

To run some of the available **MADS** examples, execute '**make examples**'.

[Back to top](#mads-manual)
