<div class="animatescroll"><a name="comparisons:top" id="comparisons:top"></a>

# **MADS** Comparisons

## **MADS** vs [PEST](http://www.pesthomepage.org/Home.php)

*   [Solving a source identification optimization problem](#test-1-solving-a-source-identification-optimization-problem)
*   [Identification of aquifer parameters based on pumping test data](#test-2-identification-of-aquifer-parameters-based-on-pumping-test-data): **MADS** is executed using PEST control files (*.pst, *.ins, *.tpl)

**MADS** is distributed with a series of example files that can be used to compare **MADS** and [PEST](http://www.pesthomepage.org/Home.php) performance. The following executions can be performed after both codes have been successfully installed.

**MADS** is applied using the build-in default values for various parameters controlling optimization process. [PEST](http://www.pesthomepage.org/Home.php) is applied using a set of commonly-used values for parameters controlling optimization process. The performance of both codes can change if different parameters are used.

## <a name="comparisons:source" id="comparisons:source"></a>Test #1: Solving a source identification optimization problem

Both codes are applied to solve a source identification optimization problem using the Levenberg-Marquardt (**LM**) optimization technique. **MADS** and [PEST](http://www.pesthomepage.org/Home.php) control files are located in directory **example/contamination**. Based on the runs presented below, **MADS** outperforms [PEST](http://www.pesthomepage.org/Home.php) in this case.

<div class="console">

$> _mads s02 ldebug_  
MADS: Model Analyses & Decision Support (v1.1) 2011  
\---------------------------------------------------  
Velimir Vesselinov (monty) vvv@lanl.gov  
http://www.ees.lanl.gov/staff/monty/mads.html

Input file name: s02.mads

Problem type: calibration

Calibration technique: single calibration using initial guesses provided in the input file  
Optimization method: opt=lm | Levenberg-Marquardt optimization  
Number of Levenberg-Marquardt iterations = will be computed internally  
Eigen analysis will be performed of the final optimization results

Global termination criteria:  
1: Maximum number of evaluations = 5000  
2: Objective function cutoff value: NOT implemented (ADD keyword cutoff=[value] to implement)  
3: Observations within defined calibration ranges: NOT implemented (ADD keyword success to implement)  
Objective function: sum of squared residuals

Sin transformation of the model parameters is applied!

Debug level (general): debug=0

Model: internal | box contaminant source

Number of model parameters: 19  
Number of optimized parameters = 11  
Number of flagged parameters = 0  
Number of fixed parameters = 8  
Number of calibration targets = 20

Execution date & time stamp: 20111107-211800

SINGLE CALIBRATION: single optimization based on initial guesses provided in the input file:  
Levenberg-Marquardt Optimization ...  
SVD decomposition  
Jacobians 1 Linear solves 0 Evaluations 12 OF 1.26022e+06 lambda 0.001  
Computed initial lambda 10  
OF 1.20597e+06 lambda 10  
OF 1.27828e+06 lambda 16.9373  
OF 1.27813e+06 lambda 33.8746  
OF 1.2781e+06 lambda 135.498 lambda is constrained to be less than 1000  
OF 1.27828e+06 lambda 1000 lambda has been already constrained; new iteration  
New Jacobian because: Lambda multiplication factor too large (nu = 32 > 16);

Jacobians 2 Linear solves 5 Evaluations 28 OF 1.20597e+06 lambda 16000  
OF 1.27826e+06 lambda 16000 lambda has been already constrained; new iteration  
OF 1.27647e+06 lambda 32000 lambda has been already constrained; new iteration  
OF 576613 lambda 128000 lambda has been already constrained; new iteration  
OF 936020 lambda 42666.7 lambda has been already constrained; new iteration  
New Jacobian because: OF declined substantially (576613 << 1.20597e+06)

...

...

Jacobians 24 Linear solves 233 Evaluations 498 OF 6788.97 lambda 333.333  
OF 2.12603e+06 lambda 333.333  
OF 27903.1 lambda 666.667 lambda is constrained to be less than 1000  
OF 9289.75 lambda 1000 lambda has been already constrained; new iteration  
OF 6790.66 lambda 8000 lambda has been already constrained; new iteration  
OF 6789.2 lambda 128000 lambda has been already constrained; new iteration  
CONVERGED: Relative change in the OF is small (1.37775e-08 < 2.55948e-08)  
LM optimization is completed. Reason: small Dp (1.37775e-08)

Eigen analysis ...  
Jacobian matrix stored (s02.jacobian)  
Covariance matrix stored (s02.covariance)  
Correlation matrix stored (s02.correlation)  
Eigen vectors and eigen values stored (s02.eigen)

Obtained fit is not very good (chi^2/dof = 754.33 > 200)

Optimized parameters:  
Source x coordinate [L] : 1105.04 stddev 98968.6 ( 210 - 1460) Estimated ranges are constrained by prior uncertainty bounds  
Source y coordinate [L] : 1468.33 stddev 87101.1 ( 1230 - 1930) Estimated ranges are constrained by prior uncertainty bounds  
Source x dimension [L] : 498.404 stddev 833.272 ( 1 - 500) Estimated ranges are constrained by prior uncertainty bounds  
Source y dimension [L] : 1.74075 stddev 13179 ( 1 - 500) Estimated ranges are constrained by prior uncertainty bounds  
Contaminant flux [M/T] : 41.7364 stddev 28026.9 ( 0.01 - 100) Estimated ranges are constrained by prior uncertainty bounds  
Start Time [T] : 1.28955e-08 stddev 90.0249 ( 0 - 43) Estimated ranges are constrained by prior uncertainty bounds  
Flow Angle [degrees] : 26.0742 stddev 28026.9 ( -30 - 30) Estimated ranges are constrained by prior uncertainty bounds  
Pore x velocity [L/T] : 11.5388 stddev 2.51973e-322 ( 0.01 - 200) Estimated ranges are constrained by prior uncertainty bounds  
Dispersivity x [L] : 138.142 stddev 3.95253e-323 ( 10 - 140) Estimated ranges are constrained by prior uncertainty bounds  
Dispersivity y [L] : 1.04174 stddev 2.12615e-314 ( 1 - 30) Estimated ranges are constrained by prior uncertainty bounds  
Dispersivity z [L] : 0.979763 stddev 2.12619e-314 ( 0.1 - 1) Estimated ranges are constrained by prior uncertainty bounds  

Model parameters:  
Source x coordinate [L] 1105.04  
Source y coordinate [L] 1468.33  
Source x dimension [L] 498.404  
Source y dimension [L] 1.74075  
Contaminant flux [M/T] 41.7364  
Start Time [T] 1.28955e-08  
Flow Angle [degrees] 26.0742  
Pore x velocity [L/T] 11.5388  
Dispersivity x [L] 138.142  
Dispersivity y [L] 1.04174  
Dispersivity z [L] 0.979763

Model predictions:  
W-1 ( 49): 0 - 4.5251e-11 = -4.5251e-11 ( -4.5251e-11) success 1 range 0 - 25  
W-2 ( 49): 0 - 0 = 0 ( 0) success 1 range 0 - 10  
W-3 ( 49): 0 - 1.65508e-05 = -1.65508e-05 (-1.65508e-05) success 1 range 0 - 25  
W-4 ( 44): 350 - 350.17 = -0.169701 ( -0.169701) success 1 range 300 - 700  
W-4 ( 49): 432 - 431.864 = 0.13567 ( 0.13567) success 1 range 300 - 700  
W-5 ( 49): 0 - 0 = 0 ( 0) success 1 range 0 - 10  
W-6 ( 49): 0 - 7.92453e-17 = -7.92453e-17 (-7.92453e-17) success 1 range 0 - 10  
W-7 ( 49): 0 - 5.64583e-16 = -5.64583e-16 (-5.64583e-16) success 1 range 0 - 10  
W-8 ( 49): 0 - 0.000445129 = -0.000445129 (-0.000445129) success 1 range 0 - 10  
W-9 ( 49): 981 - 980.91 = 0.0899824 ( 0.0899824) success 1 range 600 - 1200  
W-10#1 ( 49): 1.1 - 1.99515e-14 = 1.1 ( 1.1) success 1 range 0 - 5  
W-10#2 ( 49): 0.1 - 1.53796e-14 = 0.1 ( 0.1) success 1 range 0 - 5  
W-11#1 ( 49): 22 - 0 = 22 ( 22) success 0 range 3 - 25  
W-11#2 ( 49): 0.3 - 0 = 0.3 ( 0.3) success 1 range 0 - 5  
W-12#1 ( 49): 15 - 0.183405 = 14.8166 ( 14.8166) success 0 range 3 - 25  
W-12#2 ( 49): 0.17 - 0.0990669 = 0.0709331 ( 0.0709331) success 1 range 0 - 5  
W-13#1 ( 50): 72 - 0 = 72 ( 72) success 0 range 40 - 100  
W-13#2 ( 50): 0.26 - 0 = 0.26 ( 0.26) success 1 range 0 - 20  
W-14a ( 50): 0 - 0 = 0 ( 0) success 1 range 0 - 5  
W-14b ( 50): 30 - 0 = 30 ( 30) success 1 range 0 - 50  
Objective function: _6788.97_ Success: 0  
At least one of the predictions is outside calibration ranges!  
Number of function evaluations = 505

Model predictions that are not calibration targets:  
W-14c ( 50): 10 - 3.76349 = 6.23651 ( 6.23651) success 1 range 0 - 20  
Objective function: 38.894 Success: 1  
All the predictions are within acceptable ranges!  
Simulation time = 8 seconds  
Functional evaluations = 506  
Jacobian evaluations = 24  
Levenberg-Marquardt optimizations = 1  
Functional evaluations per second = 63  
Execution started on Mon Nov 7 21:18:00 2011  
Execution completed on Mon Nov 7 21:18:08 2011  
Execution date & time stamp: 20111107-211800  

</div>

[Back to top](#mads-comparisons)

<div class="console">

$>_pest s02pest_  
PEST Version 12.1.0\. Watermark Numerical Computing.

PEST is running in parameter estimation mode.

PEST run record: case s02pest  
(See file s02pest.rec for full details.)

Model command line:  
mads s02pest.mads-input forward >& /dev/null

Running model .....

Running model 1 time....  
Sum of squared weighted residuals (ie phi) = 1.25945E+06  

OPTIMISATION ITERATION NO. : 1  
Model calls so far : 1  
Starting phi for this iteration: 1.25945E+06

Calculating Jacobian matrix: running model 22 times .....

Lambda = 5.0000 ----->  
running model .....  
Phi = 1.20406E+06 ( 0.956 of starting phi)

Lambda = 2.5000 ----->  
running model .....  
Phi = 1.20418E+06 ( 0.956 of starting phi)

Lambda = 10.000 ----->  
running model .....  
Phi = 1.20403E+06 ( 0.956 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 1.20403E+06  
Maximum relative change: 1.0000E+30 ["st"]  

OPTIMISATION ITERATION NO. : 2  
Model calls so far : 26  
Starting phi for this iteration: 1.20403E+06

Calculating Jacobian matrix: running model 22 times .....

Lambda = 10.000 ----->  
running model .....  
Phi = 1.27738E+06 ( 1.061 times starting phi)

Lambda = 5.0000 ----->  
running model .....  
Phi = 1.27735E+06 ( 1.061 times starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 1.27735E+06  
Maximum relative change: 5.000 ["st"]  

...

...  

OPTIMISATION ITERATION NO. : 10  
Model calls so far : 221  
Starting phi for this iteration: 1.27633E+06  
All frozen parameters freed.

Calculating Jacobian matrix: running model 22 times .....  
parameter "ax" frozen: gradient and update vectors out of bounds  
parameter "ay" frozen: gradient and update vectors out of bounds  
parameter "dx" frozen: gradient and update vectors out of bounds  
parameter "st" frozen: - update vector out of bounds

Lambda = 7.81250E-02 ----->  
running model .....  
Phi = 1.27101E+06 ( 0.996 of starting phi)

Lambda = 3.90625E-02 ----->  
running model .....  
Phi = 1.27024E+06 ( 0.995 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: _1.27024E+06_  
Maximum relative change: 5.000 ["cf"]

Optimisation complete: 9 optimisation iterations have elapsed since lowest  
phi was achieved.  
Total model calls: 245

Running model one last time with best parameters.....

Recording run statistics .....

See file s02pest.rec for full run details.  
See file s02pest.sen for parameter sensitivities.  
See file s02pest.seo for observation sensitivities.  
See file s02pest.res for residuals.

</div>

[Back to top](#mads-comparisons)

## <a name="comparisons:pumping" id="comparisons:pumping"></a>Test #2: Identification of aquifer parameters based on pumping test data

Both codes are applied to identify aquifer parameters based on pumping test data using the Levenberg-Marquardt (**LM**) optimization technique. **MADS** and [PEST](http://www.pesthomepage.org/Home.php) control files are located in directory **example/contamination**. Based on the runs presented below, **MADS** outperforms [PEST](http://www.pesthomepage.org/Home.php) in this case.

In the example presented below, **MADS** is executed using [PEST](http://www.pesthomepage.org/Home.php) control files (*.pst, *.ins, *.tpl).

For this example, the code **WELLS** is needed; **WELLS** can be obtained at [wells.lanl.gov](http://wells.lanl.gov)

<div class="console">

$> _mads w01pest.pst ldebug_  
MADS: Model Analyses & Decision Support (v1.1) 2011  
\---------------------------------------------------  
Velimir Vesselinov (monty) vvv@lanl.gov  
http://www.ees.lanl.gov/staff/monty/mads.html

Input file name: w01pest.pst

PEST problem:  
Parameters = 2 (groups 1)  
Observations = 4951 (groups 1)  
Number of template files = 1  
Number of instruction files = 1  
Parameters = 2:  
k : init 1 min -10 max 10  
S : init 1 min -10 max 10  
Optimized parameters = 2  
k : init 1 min -10 max 10  
S : init 1 min -10 max 10  
Calibration targets = 4951  
o1 : value 0 weight 1  
o2 : value 5.98511376 weight 1  
o3 : value 8.023152254 weight 1  
o4 : value 8.674032233 weight 1  
o5 : value 8.970547769 weight 1  
o6 : value 9.144774497 weight 1  
o7 : value 9.253036409 weight 1  
o8 : value 9.319347478 weight 1  
o9 : value 9.376030219 weight 1  
o10 : value 9.411309295 weight 1  
o11 : value 9.454564987 weight 1  
o12 : value 9.481477303 weight 1  
o13 : value 9.511722912 weight 1  
o14 : value 9.537635484 weight 1  
o15 : value 9.552695957 weight 1  
o16 : value 9.579276955 weight 1  
o17 : value 9.593825974 weight 1  
o18 : value 9.614616686 weight 1  
o19 : value 9.629166924 weight 1  
o20 : value 9.638577014 weight 1  
...  
o4933 : value 10.08850174 weight 0  
o4934 : value 10.10152067 weight 0  
o4935 : value 10.09287471 weight 0  
o4936 : value 10.08117069 weight 0  
o4937 : value 10.0769803 weight 0  
o4938 : value 10.06021966 weight 0  
o4939 : value 10.05550135 weight 0  
o4940 : value 10.05995235 weight 0  
o4941 : value 10.06315549 weight 0  
o4942 : value 10.06027665 weight 0  
o4943 : value 10.05642215 weight 0  
o4944 : value 10.06040467 weight 0  
o4945 : value 10.05720701 weight 0  
o4946 : value 10.05537242 weight 0  
o4947 : value 10.06296956 weight 0  
o4948 : value 10.06336032 weight 0  
o4949 : value 10.0650614 weight 0  
o4950 : value 10.06270804 weight 0  
o4951 : value 10.0699632 weight 0  
Execution command: wells w01 >& /dev/null  
External files:  
- to provide current model parameters:  
w01.tpl -> w01.wells  
- to read current model predictions:  
w01.inst <- w01.s_point

Problem type: calibration

Calibration technique: single calibration using initial guesses provided in the input file  
Optimization method: opt=lm | Levenberg-Marquardt optimization  
Number of Levenberg-Marquardt iterations = will be computed internally  
Eigen analysis will be performed of the final optimization results

Global termination criteria:  
1: Maximum number of evaluations = 5000  
2: Objective function cutoff value: NOT implemented (ADD keyword cutoff=[value] to implement)  
3: Observations within defined calibration ranges: NOT implemented (ADD keyword success to implement)  
Objectve function: sum of squared residuals

Sin transformation of the model parameters is applied!

Debug level (general): debug=0

Execution date & time stamp: 20111110-205904

SINGLE CALIBRATION: single optimization based on initial guesses provided in the input file:  
Levenberg-Marquardt Optimization ...  
SVD decomposition  
Jacobians 1 Linear solves 0 Evaluations 3 OF 79661 lambda 0.001  
Computed initial lambda 0.0183802  
OF 79781.6 lambda 0.0183802  
OF 79781.6 lambda 0.0367604  
OF 79781.6 lambda 0.147042  
OF 79781.6 lambda 1.17633  
OF 3.01123e+13 lambda 18.8213  
OF 79781.6 lambda 602.283 lambda is constrained to be less than 1000  
OF 79781.6 lambda 1000 lambda has been already constrained; new iteration  
OF 79640.5 lambda 128000 lambda has been already constrained; new iteration  
OF 79549.5 lambda 42666.7 lambda has been already constrained; new iteration  
OF 78224.7 lambda 14222.2 lambda has been already constrained; new iteration  
OF 79781.6 lambda 4740.74 lambda has been already constrained; new iteration  
OF 79320.2 lambda 9481.48 lambda has been already constrained; new iteration  
OF 70921.3 lambda 37925.9 lambda has been already constrained; new iteration  
OF 79781.6 lambda 12642 lambda has been already constrained; new iteration  
OF 79531.6 lambda 25284 lambda has been already constrained; new iteration  
OF 75572.5 lambda 101136 lambda has been already constrained; new iteration  
OF 71400.5 lambda 809086 lambda has been already constrained; new iteration  
New Jacobian because: Lambda multiplication factor too large (nu = 32 > 16); Maximum number of lambda iteration is reached (10);

Jacobians 2 Linear solves 17 Evaluations 22 OF 70921.3 lambda 1.29454e+07  
OF 68146.2 lambda 1.29454e+07 lambda has been already constrained; new iteration  
OF 58714 lambda 4.31513e+06 lambda has been already constrained; new iteration  
OF 40661.7 lambda 1.43838e+06 lambda has been already constrained; new iteration  
OF 34366.6 lambda 479459 lambda has been already constrained; new iteration  
OF 33080.3 lambda 514288 lambda has been already constrained; new iteration  
New Jacobian because: OF declined substantially (33080.3 << 70921.3)

Jacobians 3 Linear solves 22 Evaluations 29 OF 33080.3 lambda 171429  
OF 6122.85 lambda 171429 lambda has been already constrained; new iteration  
OF 3547.94 lambda 57143.1 lambda has been already constrained; new iteration  
New Jacobian because: OF declined substantially (3547.94 << 33080.3)

Jacobians 4 Linear solves 24 Evaluations 33 OF 3547.94 lambda 44564.7  
OF 3212.13 lambda 44564.7 lambda has been already constrained; new iteration  
OF 2898.94 lambda 14854.9 lambda has been already constrained; new iteration  
OF 2897.37 lambda 4951.63 lambda has been already constrained; new iteration  
OF 2894.77 lambda 1650.54  
OF 2863.37 lambda 550.181  
OF 2846.55 lambda 183.394  
OF 2844.7 lambda 61.1312  
OF 2844.61 lambda 20.3771  
OF 2844.61 lambda 6.79236  
OF 2844.61 lambda 13.5847  
New Jacobian because: Maximum number of lambda iteration is reached (10);

Jacobians 5 Linear solves 34 Evaluations 45 OF 2844.61 lambda 4.52824  
OF 2844.71 lambda 4.52824  
OF 2844.71 lambda 9.05648  
OF 2844.71 lambda 36.2259  
OF 2844.71 lambda 289.807 lambda is constrained to be less than 1000  
OF 2844.71 lambda 1000 lambda has been already constrained; new iteration  
OF 2844.71 lambda 32000 lambda has been already constrained; new iteration  
OF 2844.7 lambda 2.048e+06 lambda has been already constrained; new iteration  
OF 2844.6 lambda 2.62144e+08 lambda has been already constrained; new iteration  
CONVERGED: Relative change in the OF is small (4.06252e-13 < 1.18008e-11)  
LM optimization is completed. Reason: small Dp (4.06252e-13)

Eigen analysis ...  
Jacobian matrix stored (w01pest.jacobian)  
Covariance matrix stored (w01pest.covariance)  
Correlation matrix stored (w01pest.correlation)  
Eigen vactors and eigen values stored (w01pest.eigen)

Obtained fit is relatively good (chi^2/dof = 0.574782 < 200)

Optimized parameters:  
k : -1.93341 stddev 0.000104654 ( -1.93341 - -1.93341)  
S : -2.79344 stddev 0.000151851 ( -2.79344 - -2.79344)  

Model parameters:  
k -1.93341  
S -2.79344

Model predictions:  
o1 : 0 - 0 = 0 ( 0) success 1 range 0 - 0  
o2 : 5.98511 - 0.858991 = 5.12612 ( 5.12612) success 1 range 0 - 11.9702  
o3 : 8.02315 - 1.7258 = 6.29735 ( 6.29735) success 1 range 0 - 16.0463  
o4 : 8.67403 - 2.33684 = 6.33719 ( 6.33719) success 1 range 0 - 17.3481  
o5 : 8.97055 - 2.80368 = 6.16687 ( 6.16687) success 1 range 0 - 17.9411  
o6 : 9.14477 - 3.1806 = 5.96417 ( 5.96417) success 1 range 0 - 18.2895  
o7 : 9.25304 - 3.49644 = 5.7566 ( 5.7566) success 1 range 0 - 18.5061  
o8 : 9.31935 - 3.76815 = 5.5512 ( 5.5512) success 1 range 0 - 18.6387  
o9 : 9.37603 - 4.00652 = 5.36951 ( 5.36951) success 1 range 0 - 18.7521  
o10 : 9.41131 - 4.21882 = 5.19249 ( 5.19249) success 1 range 0 - 18.8226  
o11 : 9.45456 - 4.41019 = 5.04437 ( 5.04437) success 1 range 0 - 18.9091  
o12 : 9.48148 - 4.58437 = 4.89711 ( 4.89711) success 1 range 0 - 18.963  
o13 : 9.51172 - 4.7442 = 4.76752 ( 4.76752) success 1 range 0 - 19.0234  
o14 : 9.53764 - 4.89186 = 4.64578 ( 4.64578) success 1 range 0 - 19.0753  
o15 : 9.5527 - 5.02906 = 4.52364 ( 4.52364) success 1 range 0 - 19.1054  
o16 : 9.57928 - 5.15721 = 4.42207 ( 4.42207) success 1 range 0 - 19.1586  
o17 : 9.59383 - 5.27739 = 4.31644 ( 4.31644) success 1 range 0 - 19.1877  
o18 : 9.61462 - 5.39058 = 4.22404 ( 4.22404) success 1 range 0 - 19.2292  
o19 : 9.62917 - 5.4975 = 4.13167 ( 4.13167) success 1 range 0 - 19.2583  
o20 : 9.63858 - 5.59884 = 4.03974 ( 4.03974) success 1 range 0 - 19.2772  
...  
Objective function: _2844.6_ Success: 1  
All the predictions are within calibration ranges!  
Number of function evaluations = 55  
Simulation time = 9 seconds  
Functional evaluations = 55  
Jacobian evaluations = 5  
Levenberg-Marquardt optimizations = 1  
Functional evaluations per second = 6

Execution started on Mon Nov 7 21:29:52 2011  
Execution completed on Mon Nov 7 21:29:55 2011  
Execution date & time stamp: 20111107-212952

</div>

[Back to top](#mads-comparisons)

<div class="console">

$> _pest w01pest_  
PEST Version 12.1.0\. Watermark Numerical Computing.

PEST is running in parameter estimation mode.

PEST run record: case w01pest  
(See file w01pest.rec for full details.)

Model command line:  
wells w01 >& /dev/null

Running model .....

Running model 1 time....  
Sum of squared weighted residuals (ie phi) = 79661\.  

OPTIMISATION ITERATION NO. : 1  
Model calls so far : 1  
Starting phi for this iteration: 79661\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 5.0000 ----->  
running model .....  
Phi = 77301\. ( 0.970 of starting phi)

Lambda = 2.5000 ----->  
running model .....  
Phi = 1.39812E+05 ( 1.755 times starting phi)

Lambda = 10.000 ----->  
running model .....  
Phi = 79475\. ( 0.998 of starting phi)

No more lambdas: phi rising  
Lowest phi this iteration: 77301\.  
Maximum relative change: 5.000 ["k"]  

OPTIMISATION ITERATION NO. : 2  
Model calls so far : 8  
Starting phi for this iteration: 77301\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 5.0000 ----->  
running model .....  
Phi = 75501\. ( 0.977 of starting phi)

Lambda = 2.5000 ----->  
running model .....  
Phi = 75495\. ( 0.977 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 75495\.  
Maximum relative change: 9.2185E-02 ["s"]  

OPTIMISATION ITERATION NO. : 3  
Model calls so far : 14  
Starting phi for this iteration: 75495\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 1.2500 ----->  
running model .....  
Phi = 75262\. ( 0.997 of starting phi)

Lambda = 0.62500 ----->  
running model .....  
Phi = 75244\. ( 0.997 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 75244\.  
Maximum relative change: 2.0766E-02 ["s"]  

OPTIMISATION ITERATION NO. : 4  
Model calls so far : 20  
Starting phi for this iteration: 75244\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 0.31250 ----->  
running model .....  
Phi = 74985\. ( 0.997 of starting phi)

Lambda = 0.15625 ----->  
running model .....  
Phi = 74648\. ( 0.992 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 74648\.  
Maximum relative change: 0.3539 ["s"]  

OPTIMISATION ITERATION NO. : 5  
Model calls so far : 26  
Starting phi for this iteration: 74648\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 7.81250E-02 ----->  
running model .....  
Phi = 70501\. ( 0.944 of starting phi)

Lambda = 3.90625E-02 ----->  
running model .....  
Phi = 69558\. ( 0.932 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 69558\.  
Maximum relative change: 0.5144 ["s"]  

OPTIMISATION ITERATION NO. : 6  
Model calls so far : 32  
Starting phi for this iteration: 69558\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 1.95313E-02 ----->  
running model .....  
Phi = 78495\. ( 1.128 times starting phi)

Lambda = 9.76563E-03 ----->  
running model .....  
Phi = 78599\. ( 1.130 times starting phi)

Lambda = 3.90625E-02 ----->  
running model .....  
Phi = 78261\. ( 1.125 times starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 78261\.  
Maximum relative change: 1.021 ["s"]  

OPTIMISATION ITERATION NO. : 7  
Model calls so far : 39  
Starting phi for this iteration: 78261\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 3.90625E-02 ----->  
running model .....  
Phi = 78255\. ( 1.000 of starting phi)

Lambda = 1.95313E-02 ----->  
running model .....  
Phi = 78255\. ( 1.000 of starting phi)

Lambda = 7.81250E-02 ----->  
running model .....  
Phi = 78254\. ( 1.000 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: 78254\.  
Maximum relative change: 0.5107 ["s"]  

OPTIMISATION ITERATION NO. : 8  
Model calls so far : 46  
Starting phi for this iteration: 78254\.

Calculating Jacobian matrix: running model 4 times .....

Lambda = 7.81250E-02 ----->  
running model .....  
Phi = 78219\. ( 1.000 of starting phi)

Lambda = 3.90625E-02 ----->  
running model .....  
Phi = 78222\. ( 1.000 of starting phi)

Lambda = 0.15625 ----->  
running model .....  
Phi = 78213\. ( 0.999 of starting phi)

No more lambdas: relative phi reduction between lambdas less than 0.0300  
Lowest phi this iteration: _78213_.  
Maximum relative change: 5.000 ["s"]

Optimisation complete: 3 optimisation iterations have elapsed since lowest  
phi was achieved.  
Total model calls: 53

Running model one last time with best parameters.....

Recording run statistics .....

See file w01pest.rec for full run details.  
See file w01pest.sen for parameter sensitivities.  
See file w01pest.seo for observation sensitivities.  
See file w01pest.res for residuals.

</div>

[Back to top](#mads-comparisons)
