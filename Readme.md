Installation
============

Local installation
-------------------

### Create a .juliarc file

Add the following line in the `.juliarc.jl` file in your home directory

`push!(LOAD_PATH, ENV["HOME"]*"/codes")`

### Clone some packages in the codes directory

```
mkdir codes
cd codes
git clone git@gitlab.com:mads/Mads.jl.git
git clone git@gitlab.com:omalled/Anasol.jl.git
git clone git@gitlab.com:omalled/R3Function.jl.git
git clone git@gitlab.com:omalled/MPToools.jl.git
git clone git@gitlab.com:omalled/BIGUQ.jl.git
```

### Add more packages

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
Pkg.add("LightXML");
Pkg.add("Docile");
Pkg.add("Lexicon");
Pkg.add("PyCall");
Pkg.add("PyPlot");
Pkg.add("Conda");
Pkg.add("YAML");
Pkg.add("JSON");
Pkg.add("Gadfly");
Pkg.add("JLD");
Pkg.clone("BlackBoxOptim");

### Run examples

In julia REPL, do the following commands:

`reload("Mads.jl")` # if there are still missing packages, add them

`reload("Mads.jl/examples/bigdt/bigdt.jl")` # to peform bigdt analysis

Global installation
------------------

```
Pkg.clone("git@gitlab.com:omalled/Anasol.jl.git")
Pkg.clone("git@gitlab.com:omalled/R3Function.jl.git")
Pkg.clone("git@gitlab.com:omalled/MPToools.jl.git")
Pkg.clone("git@gitlab.com:omalled/BIGUQ.jl.git")
Pkg.clone("git@gitlab.com:mads/Mads.jl.git")
```

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