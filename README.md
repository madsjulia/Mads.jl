Installation
============

After starting Julia, execute:

```
Pkg.add("Mads")
```

Installation of MADS behind a firewall
------------------------------

Julia uses git for package management. Add in the `.gitconfig` file in your home directory:

```
[url "https://"]
        insteadOf = git://
```

or execute:

```
git config --global url."https://".insteadOf git://
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

MADS & YAML
-----------

MADS uses the Python YAML library.
If you do not have it installed, the best option is to use Julia's Python
environment. In Julia REPL, execute the following:

```
ENV["PYTHON"]="" # forces Julia to ignore system python
using Conda
Conda.add("yaml")
```

To install the Python YAML library globally (not recommended), you will need to run:

```
brew install libyaml
sudo pip install yaml
```

Run MADS examples
------------

In Julia REPL, do the following commands:

`import Mads`

To explore getting-started instructions, execute:

`Mads.help()`

There are various examples located in the `examples` directory of the `Mads` repository.

For example, execute

`include(Mads.madsdir * "/../examples/contamination/analysis.jl")`

to perform various analyses related to contaminant transport, or execute

`include(Mads.madsdir * "/../examples/bigdt/bigdt.jl")`

to perform BIG-DT analysis.

If you make changes in the MADS code, you will need to do

`reload("Mads.jl")` 

to update the MADS code in Julia.
