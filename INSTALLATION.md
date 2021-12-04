# Installation

After starting Julia, execute:


```julia
import Pkg; Pkg.add("Mads")
```

## Installation without PYTHON

MADS uses PyYAML and matplotlib.
To avoid using these modules, set the following environmental variable:

(bash)
```bash
export MADS_NO_PYTHON=""
```

or

(tcsh)
```tcsh
setenv MADS_NO_PYTHON ""
```

or

(julia)
```julia
ENV["MADS_NO_PYTHON"] = ""
```

## Installation without plotting modules

MADS uses Gadfly and matplotlib for plotting.
To avoid using these modules, set the following environmental variable:

(bash)
```bash
export MADS_NO_PLOT=""
```

or

(tcsh)
```tcsh
setenv MADS_NO_PLOT ""
```

or

(julia)
```julia
ENV["MADS_NO_PLOT"] = ""
```

## Installation behind a firewall

Set proxies executing the following lines in the bash command-line environment:

```bash
export ftp_proxy=http://proxyout.<your_site>:8080
export rsync_proxy=http://proxyout.<your_site>:8080
export http_proxy=http://proxyout.<your_site>:8080
export https_proxy=http://proxyout.<your_site>:8080
export no_proxy=.<your_site>
```

For example, at LANL, you will need to execute the following lines in the bash command-line environment:

```bash
export ftp_proxy=http://proxyout.lanl.gov:8080
export rsync_proxy=http://proxyout.lanl.gov:8080
export http_proxy=http://proxyout.lanl.gov:8080
export https_proxy=http://proxyout.lanl.gov:8080
export no_proxy=.lanl.gov
```
Proxies can be also set up directly in the Julia REPL as well:

```julia
ENV["ftp_proxy"] =  "http://proxyout.lanl.gov:8080"
ENV["rsync_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["http_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["https_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["no_proxy"] = ".lanl.gov"
```

## Docker

Mads is also available @ Docker:

```bash
docker run --interactive --tty montyvesselinov/madsjulia
```