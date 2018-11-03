
<a id='BIGUQ.jl-1'></a>

# BIGUQ.jl


Module BIGUQ provides advanced techniques for Uncertainty Quantification, Experimental Design and Decision Analysis based on Bayesian Information Gap Decision Theory (BIGDT).


References:


  * O’Malley, D., Vesselinov, V.V., A combined probabilistic/non-probabilistic decision analysis for contaminant remediation, Journal on Uncertainty Quantification, SIAM/ASA, 10.1137/140965132, 2014.
  * O’Malley, D., Vesselinov, V.V., Bayesian-Information-Gap decision theory with an application to CO2 sequestration, Water Resources Research, 10.1002/2015WR017413, 2015.
  * Grasinger, M., O'Malley, D., Vesselinov, V.V., Karra, S., Decision Analysis for Robust CO2 Injection: Application of Bayesian-Information-Gap Decision Theory, International Journal of Greenhouse Gas Control, 10.1016/j.ijggc.2016.02.017, 2016.


Relevant examples:


  * [Information Gap Analysis](http://madsjulia.github.io/Mads.jl/Examples/infogap)
  * [Decision Analysis](http://madsjulia.github.io/Mads.jl/Examples/bigdt/source_termination)


BIGUQ.jl module functions:

<a id='BIGUQ.getmcmcchain-Tuple{BIGUQ.BigDT,Any}' href='#BIGUQ.getmcmcchain-Tuple{BIGUQ.BigDT,Any}'>#</a>
**`BIGUQ.getmcmcchain`** &mdash; *Method*.



Get MCMC chain


<a target='_blank' href='https://github.com/madsjulia/BIGUQ.jl/blob/2cfce7a435713dbadbc5e3199a92c039a920bf47/src/BIGDT.jl#L22' class='documenter-source'>source</a><br>

<a id='BIGUQ.makebigdts-Tuple{BIGUQ.BigOED,Any,Any}' href='#BIGUQ.makebigdts-Tuple{BIGUQ.BigOED,Any,Any}'>#</a>
**`BIGUQ.makebigdts`** &mdash; *Method*.



Make BIGDT analyses for each possible decision assuming that the proposed observations `proposedobs` are observed


<a target='_blank' href='https://github.com/madsjulia/BIGUQ.jl/blob/2cfce7a435713dbadbc5e3199a92c039a920bf47/src/BIGOED.jl#L50' class='documenter-source'>source</a><br>

<a id='BIGUQ.makebigdts-Tuple{BIGUQ.BigOED}' href='#BIGUQ.makebigdts-Tuple{BIGUQ.BigOED}'>#</a>
**`BIGUQ.makebigdts`** &mdash; *Method*.



Makes BIGDT analyses for each possible decision assuming that no more observations will be made


<a target='_blank' href='https://github.com/madsjulia/BIGUQ.jl/blob/2cfce7a435713dbadbc5e3199a92c039a920bf47/src/BIGOED.jl#L23' class='documenter-source'>source</a><br>

<a id='BIGUQ.BigDT' href='#BIGUQ.BigDT'>#</a>
**`BIGUQ.BigDT`** &mdash; *Type*.



BigOED type


<a target='_blank' href='https://github.com/madsjulia/BIGUQ.jl/blob/2cfce7a435713dbadbc5e3199a92c039a920bf47/src/BIGDT.jl#L2' class='documenter-source'>source</a><br>

<a id='BIGUQ.BigOED' href='#BIGUQ.BigOED'>#</a>
**`BIGUQ.BigOED`** &mdash; *Type*.



BigOED type


<a target='_blank' href='https://github.com/madsjulia/BIGUQ.jl/blob/2cfce7a435713dbadbc5e3199a92c039a920bf47/src/BIGOED.jl#L1' class='documenter-source'>source</a><br>

