Installation
============

Local installation
-------------------

### Clone some packages in a local directory

Here the local directory is called `codes`

```
mkdir codes
cd codes
git clone git@gitlab.com:mads/Mads.jl.git
git clone git@gitlab.com:mads/Anasol.jl.git
git clone git@gitlab.com:mads/R3Function.jl.git
git clone git@gitlab.com:mads/MPTools.jl.git
git clone git@gitlab.com:mads/BIGUQ.jl.git
```

### Create a .juliarc.jl file

Add the following line in the `.juliarc.jl` file in your home directory

`push!(LOAD_PATH, ENV["HOME"]*"/codes")`

If the file does not exist create one.

Global installation
------------------

```
Pkg.clone("git@gitlab.com:mads/Mads.jl.git")
Pkg.clone("git@gitlab.com:mads/Anasol.jl.git")
Pkg.clone("git@gitlab.com:mads/R3Function.jl.git")
Pkg.clone("git@gitlab.com:mads/MPTools.jl.git")
Pkg.clone("git@gitlab.com:mads/BIGUQ.jl.git")
```

Installation of packages
------------------------

Start julia and add the following packages:

Pkg.add("DataFrames");
Pkg.add("Logging");
Pkg.add("Distributions");
Pkg.add("DataStructures");
Pkg.add("Lora");
Pkg.add("HDF5");
Pkg.add("Optim");
Pkg.add("NLopt");
Pkg.add("ForwardDiff");
Pkg.add("ODE");
Pkg.add("ProgressMeter");
Pkg.add("Docile");
Pkg.add("Lexicon");
Pkg.add("Conda");
Pkg.add("PyCall");
Pkg.add("PyPlot");
Pkg.add("YAML");
Pkg.add("JSON");
Pkg.add("LightXML");
Pkg.add("Gadfly");
Pkg.add("JLD");
Pkg.clone("BlackBoxOptim");

MADS uses python YAML library.
If you do not have it installed the best option is to use Julia's python
environment:

```
ENV["PYTHON"]=""; # forces Julia to ignore system python
using Conda;
Conda.add("yaml");
```

To install YAML library globaly (not recommended), you will need to run:

```
brew install libyaml
sudo pip install yaml
```

Run examples
------------

In julia REPL, do the following commands:

`using Mads` # if there are still missing packages, add them

`include("Mads.jl/examples/contamination/analysis.jl")` # to peform various analyses
related to contaminant transport

`include("Mads.jl/examples/bigdt/bigdt.jl")` # to peform bigdt analysis

If you make changes in MADS code, you will need to do

`reload("Mads.jl")` # to update the code in Julia

Installation behind a firewall
------------------------------

Add in .gitconfig:

```
[url "https://"]
        insteadOf = git://
```

Set proxies:

```
export ftp_proxy=http://proxyout.<your_site>:8080
export rsync_proxy=http://proxyout.<your_site>:8080
export http_proxy=http://proxyout.<your_site>:8080
export https_proxy=http://proxyout.<your_site>:8080
export no_proxy=.<your_site>
```

For example, if you are doing this at LANL you will neet to execute the 
following lines in your bash command-line environment:

```
export ftp_proxy=http://proxyout.lanl.gov:8080
export rsync_proxy=http://proxyout.lanl.gov:8080
export http_proxy=http://proxyout.lanl.gov:8080
export https_proxy=http://proxyout.lanl.gov:8080
export no_proxy=.lanl.gov
```