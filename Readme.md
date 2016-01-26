Installation
============

Local MADS installation
-------------------

### Clone some packages in a local directory

Below the local directory is called `codes`

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

Global MADS installation
------------------

```
Pkg.clone("git@gitlab.com:mads/Mads.jl.git")
Pkg.clone("git@gitlab.com:mads/Anasol.jl.git")
Pkg.clone("git@gitlab.com:mads/R3Function.jl.git")
Pkg.clone("git@gitlab.com:mads/MPTools.jl.git")
Pkg.clone("git@gitlab.com:mads/BIGUQ.jl.git")
```

Installation of MADS packages
-----------------------------

Start Julia and add the following packages:

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

MADS uses a Python YAML library.
If you do not have it installed, the best option is to use Julia's python
environment:

```
ENV["PYTHON"]=""; # forces Julia to ignore system python
using Conda;
Conda.add("yaml");
```

To install the Python YAML library globally (not recommended), you will need to run:

```
brew install libyaml
sudo pip install yaml
```

Run MADS examples
------------

In Julia REPL, do the following commands:

`using Mads` # if there are still missing packages, add them

To explore getting-started instructions, execute:

`Mads.help()`

There are various examples located in the `Mads.jl/examples` directory of the Mads.jl repository.

For example, execute

`include("Mads.jl/examples/contamination/analysis.jl")`

to perform various analyses related to contaminant transport, or execute

`include("Mads.jl/examples/bigdt/bigdt.jl")`

to perform BIG-DT analysis.

If you make changes in the MADS code, you will need to do

`reload("Mads.jl")` 

to update the MADS code in Julia.

Installation of MADS behind a firewall
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

For example, if you are doing this at LANL, you will need to execute the 
following lines in your bash command-line environment:

```
export ftp_proxy=http://proxyout.lanl.gov:8080
export rsync_proxy=http://proxyout.lanl.gov:8080
export http_proxy=http://proxyout.lanl.gov:8080
export https_proxy=http://proxyout.lanl.gov:8080
export no_proxy=.lanl.gov
```