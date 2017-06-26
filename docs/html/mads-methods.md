<div class="animatescroll"><a name="methods:top" id="methods:top"></a>

# <span>**MADS** Methods</span>

*   [Model analyses](#model-analyses)
*   [Decision support](#decision-support)
*   [Contaminant transport simulators](#contaminant-transport-simulators)
*   [Test functions](#test-functions)

### Model analyses
<a name="methods:analyses" id="methods:analyses"></a>**MADS** includes a wide range of techniques for model-based analyses that can perform local and global exploration of model parameter space:

*   <a name="methods:optimization" id="methods:optimization"></a>Optimization techniques for Parameter Estimation (**PE**), Model Inversion, Model Calibration, and Decision Support (**DS**)

     *   Several different implementations of the local Levenberg-Marquardt (**LM**) optimization technique: [GSL](http://www.gnu.org/s/gsl/), [IMSL](http://www.roguewave.com/products/imsl-numerical-libraries.aspx), [LevMar](http://www.ics.forth.gr/~lourakis/levmar/).  
    The Levenberg-Marquardt (**LM**) optimization technique can be performed using [acceleration and delayed gratification approaches](http://link.aps.org/doi/10.1103/PhysRevE.83.036701).  
    In **LM**, the inversion of Jacobian (sensitivity) matrix can be performed using a wide range of techniques: BK (Bunch and Kaufman), LU, QR, QRLS, Cholesky, and SVD (singular value) decompositions using LAPACK and SVDPACK libraries.  
    **SVD decomposition** allows for highly-parameterized inversion where the number of model parameters is substantially greater than the number of model constraints (calibration targets or model observations); a similar approach is called [SVD-assist](http://www.pesthomepage.org/Highly-parameterized_inversion.php) in [PEST](http://www.pesthomepage.org).
     *   Multi-Start Levenberg-Marquardt (**MSLM**) optimization technique
     *   Global Particle Swarm Optimization ([PSO](http://clerc.maurice.free.fr/pso/))
     *   Global Adaptive Particle Swarm Optimization [TRIBES](http://www.particleswarm.info/Tribes_2006_Cooren.pdf)
     *   Global Optimization technique coupling Particle Swarm and Levenberg-Marquardt optimization technique [SQUADS](papers/squads_v04.pdf)

*   <a name="methods:sensitivity" id="methods:sensitivity"></a>Sensitivity Analysis (**SA**) techniques

     *   Global Monte-Carlo based analysis
     *   Local eigen analysis of Jacobian matrix of model parameters
     *   [Sobol's global sensitivity indices](http://www.mlmatrix.com/uploadfile/200712418203522.pdf)
     *   Agent-based Global Uncertainty and Sensitivity [ABAGUS](papers/Harp & Vesselinov ABAGUS 2011.pdf) analysis

*   <a name="methods:sampling" id="methods:sampling"></a>Sampling (design of experiment) techniques (based on random or user provided seed):

     *   Pseudo random sampling
     *   Latin-Hypercube sampling techniques: random, center, edge
     *   [Improved Distributed Hypercube Sampling](http://people.sc.fsu.edu/~jburkardt/datasets/ihs/ihs.html) (**IDLHS**; aka **IHS**)

*   <a name="methods:uncertainty" id="methods:uncertainty"></a>Uncertainty Quantification (**UQ**) techniques

     *   Global Monte-Carlo based analysis
     *   Local analysis based on Jacobian matrix of model parameters
     *   Agent-based Global Uncertainty and Sensitivity [ABAGUS](papers/Harp & Vesselinov ABAGUS 2011.pdf) analysis

### Decision support
**MADS** includes methods for Model-based Decision Support (**DS**)

*   Bayesian analysis utilizing [DREAM](http://www.biometris.wur.nl/UK/Staff/Cajo+ter+Braak/Software+and+Data/DE-MC+and+DREAM+software+page/)
*   non-Bayesian analysis utilizing [minimax](http://www.sciencedirect.com/science/article/pii/S0004370206000245), [info-gap](papers/Harp & Vesselinov infogap source 2011.pdf) and [GLUE](http://www.sciencedirect.com/science/article/pii/S0022169401004218)
*   Global Optimization technique coupling Particle Swarm and Levenberg-Marquardt optimization techniques [SQUADS](papers/squads_v04.pdf)
*   Agent-based Global Uncertainty and Sensitivity [ABAGUS](papers/Harp & Vesselinov ABAGUS 2011.pdf) analysis

<a name="methods:simulators" id="methods:simulators"></a>

### Contaminant transport simulators
**MADS** includes several analytical simulators for representation of 3D contaminant transport in aquifers. The analytical simulation is based on the solutions developed by [Wexler (1992)](http://pubs.usgs.gov/twri/twri3-b7/) and [Park & Zhan (2001)](http://www.sciencedirect.com/science/article/pii/S016977220100136X). The solutions are solved using [GSL](http://www.gnu.org/s/gsl/) subroutines. Alternative solutions are available for contaminant sources with different geometry:

*   point source
*   plane source (along the top of the aquifer)
*   3D box (straight parallelepiped) source

<a name="methods:functions" id="methods:functions"></a>

### Test functions
**MADS** includes a series of test functions that can be applied for efficient testing of model-analysis and decision support techniques. These test functions are commonly used in the practice. The list of all the test functions built-in in **MADS** are listed in the [manual](mads-manual.md)
