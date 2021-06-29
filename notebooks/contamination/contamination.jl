# Mads Notebook: Example Contamination Problem

## Problem setup

Import Mads

Change the working directory

Load Mads input file

Generate a plot of the loaded problem showing the well locations and the location of the contaminant source:

There are 20 monitoring wells.
Each well has 2 measurement ports: shallow (3 m below the water table labeled `a`) and deep (33 m below the water table labeled `b`).
Contaminant concentrations are observed for 50 years at each well.
The contaminant transport is solved using the `Anasol` package in Mads.

### Unknown model parameters

* Start time of contaminant release $t_0$
* End time of contaminant release $t_1$
* Advective pore velocity $v$

### Reduced model setup 

Analysis of the data from only 2 monitoring locations: `w13a` and `w20a`.

Generate a plot of the updated problem showing the 2 well locations applied in the analyses as well as the location of the contaminant source:

## Initial estimates

Plot initial estimates of the contamiant concentrations at the 2 monitoring wells based on the initial model parameters: 

## Model calibration

Execute model calibration based on the concentrations observed in the two monitoring wells:

Compute forward model predictions based on the calibrated model parameters:

Plot the predicted estimates of the contamiant concentrations at the 2 monitoring wells based on the estimated model parameters based on the performed model calibration: 

Initial values of the optimized model parameters are:

Estimated values of the optimized model parameters are:

