## eFAST_sensitivity_analysis_parallel.jl
# Test problem for eFAST algorithm embedded in Mads

# Loading packages (some must be loaded on every processor)
import Distributions
import Docile
import ProgressMeter
import Mads
import JSON

## Necessary modules (no matter if we are reading from mads or using as a standalone)
@everywhere include("/home/jlaughli/Julia Code/eFAST_distributeX.jl");
#include("/Users/jlaughli/Desktop/Julia Code/eFAST_getCompFreq.jl");
#include("/Users/jlaughli/Desktop/Julia Code/eFAST_optimalSearch.jl");
@everywhere include("/home/jlaughli/Julia Code/eFAST_Parallel_kL.jl")

# Saltelli senstivity analysis tests
# FOR SOME REASON USING MADS WON'T LOAD THESE (for me)!
#include("/Users/jlaughli/codes/mads.jl/src/MadsAnasol.jl");
#include("/Users/jlaughli/codes/mads.jl/src/MadsIO.jl")
#include("/Users/jlaughli/codes/mads.jl/src/MadsYAML_noPyYAML.jl")
#@everywhere include("/Users/jlaughli/codes/mads.jl/src/MadsLog.jl")

Mads.madsinfo("TEST eFAST senstivity analysis:")

# Load in .mads data file to analyze
md = Mads.loadmadsfile("/home/jlaughli/Julia Code/examples/contamination/w01_w1a_w10a_w20a.mads")

# Run eFAST algorithm and calculate results
resultsefast = Mads.efast(md,N=int(15000), M=6, gamma=4)
# N might change after running efast due to optimization algorithm
N = resultsefast["samplesize"];

# Print results (sensitivity indices)
#Mads.printSAresults(md,resultsefast)

# get MADS rootname
rootname = Mads.getmadsrootname(md)
Mads.madsinfo("""Mads root name: $(rootname)""")

# Save eFAST results as JSON file
f = open("$rootname-eFAST-results-N=$N.json", "w")
JSON.print(f, resultsefast)
close(f)

# Load eFAST results
# resultsefast = JSON.parsefile("$rootname-eFAST-results-N=$N.json"; ordered=true, use_mmap=true)

