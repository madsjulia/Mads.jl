<div class="animatescroll"><a name="features:top" id="features:top"></a>

# **MADS** Features

**MADS** is characterized by several unique features:

*   Provides an integrated computational framework for a wide range of model-based analyses, and supports model-based decision making.
*   By design, works in an adaptive mode with minimum input from the user.  
    For example, ‘**mads s01**’ is sufficient to perform calibration of problem ‘**s01**’ and ‘**mads montecarlo s01**’ is sufficient to perform uncertainty analysis of problem ‘**s01**’ ([MADS manual](mads-manual.md)). All the parameters controlling the performance of these analyses are estimated internally by **MADS**. Nevertheless, if needed, the user has the flexibility to specify a wide range of options (as demonstrated in **MADS** [manual](mads-manual.md) and [execution examples](#examples)).
*   The same problem input file(in the previous case, ‘**s01.mads**’)is sufficient and can be applied to perform all the possible model analyses supported by **MADS**.  
    Different analyses can be invoked using different command-line keywords and options.  
    If preferred, the keywords can be provided on the first line of the problem input file as well.
*   Most of the model analysis can be performed using a discretized parameter space (e.g. **PPSD**, **IGPD**, **ABAGUS**). This can substantially reduce the computational effort to perform model analyses of computationally intensive models and complex parameter spaces ([MADS manual](mads-manual.md)).
*   Highly-parameterized inversion where the number of model parameters is substantially greater than the number of model constraints (calibration targets or model observations); a similar approach is called [SVD assist](http://www.pesthomepage.org/Highly-paraameterized_inversion.php) in [PEST](http://www.pesthomepage.org) ([svdassist](http://www.pesthomepage.org/Highly-paraameterized_inversion.php)).
*   Permits the use of 'acceptable' calibration ranges for each optimization target.  
    In this way, the model solutions can be constrained to produce predictions within acceptable calibration ranges.  
    This feature is implemented using the keyword ‘**<u>obsrange</u>**’ ([MADS manual](mads-manual.md#calibration-termination-criteria)).
*   Allows the use of an acceptable calibration range for the objective function.  
    In this way, acceptable model solutions can be identified as those producing objective functions below a predefined cutoff value. Once the objective function is decreased below the cutoff value, the optimization is terminated. This feature is implemented using the keyword ‘**<u>cutoff</u>**’ ([MADS manual](mads-manual.md#calibration-termination-criteria)).
*   Implements a series of alternative objective functions (OF).
*   By default, all the model parameters are internally normalized and transformed in a manner that substantially improves the optimization process.
*   Provides an option to perform a series of optimizations with random initial guesses for optimization parameters.
*   Provides an option to automatically retry the optimization process using a series of random initial guesses for optimization parameters until an acceptable calibration is achieved (keyword ‘**retry’**; [MADS manual](mads-manual.md#calibration-method-keywords)).
*   Automatically detects and utilizes the available multi-processor resources for parallelization of m.
*   Analyzes the runtime performance of the available parallel hosts (processors); hosts not capable of performing the requested parallel jobs are dynamically ignored.
*   Tracks the multiple model files during parallel execution automatically; for the user, there is no difference between serial (using single processor) and parallel modes of execution.
*   Performs automatic bookkeeping of all the model results for efficient restart and rerun of MADS jobs (e.g. if the previous job was not completed) and additional posterior analyses.
*   Allows the user to perform different types of analyses based on model results stored during previous MADS runs; for example, model runs obtained during model calibration can be utilized in posterior Monte Carlo analyses.
*   Provides a built-in protection against simultaneous execution of conflicting MADS runs in the same working directory.
*   Automatically renames the files obtained during previous MADS runs by default using unique date & time information in the file names to avoid overwriting.
*   Object-oriented design of MADS allows for relatively easy integration with other object-oriented optimization or sampling techniques.

</div>
