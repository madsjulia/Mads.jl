# Installation

After starting Julia, execute:

```julia
import Pkg; Pkg.add("Mads")
```

to access the latest released version.

To utilize the latest updates (commits) use:

```julia
import Pkg; Pkg.add(Pkg.PackageSpec(name="Mads", rev="master"))
```

## Installation without PYTHON

Python is not required.

MADS uses Python to create matplotlib plots.

These are optional.

To avoid using these modules, set the following environmental variable before building MADS:

```bash
export MADS_NO_PYTHON=""
```

or

```tcsh
setenv MADS_NO_PYTHON ""
```

or

```julia
ENV["MADS_NO_PYTHON"] = ""
```

## Installation without plotting modules

MADS uses Gadfly and matplotlib for plotting.
To avoid using these modules, set the following environmental variable:

```bash
export MADS_NO_PLOT=""
```

or

```tcsh
setenv MADS_NO_PLOT ""
```

or

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

Proxies can be setup directly in the Julia REPL as well:

```julia
ENV["ftp_proxy"] =  "http://proxyout.lanl.gov:8080"
ENV["rsync_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["http_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["https_proxy"] = "http://proxyout.lanl.gov:8080"
ENV["no_proxy"] = ".lanl.gov"
```

Julia uses git for package management.

To avoid potential git management issues, on Windows, you may need to execute:

```bash
git config --global credential.helper manager
```

In some cases, you may need to add in the `.gitconfig` file in your home directory the following lines to support git behind a firewall:

```
[url "git@github.com:"]
    insteadOf = https://github.com/
[url "git@gitlab.com:"]
    insteadOf = https://gitlab.com/
[url "https://"]
    insteadOf = git://
[url "http://"]
    insteadOf = git://
```

or execute:

```bash
git config --global url."https://".insteadOf git://
git config --global url."http://".insteadOf git://
git config --global url."git@gitlab.com:".insteadOf https://gitlab.com/
git config --global url."git@github.com:".insteadOf https://github.com/
```