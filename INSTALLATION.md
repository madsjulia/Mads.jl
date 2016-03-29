Installation
============

After starting Julia, execute:


```julia
Pkg.add("Mads")
```


Installation of MADS without PYTHON
------------------------------

MADS uses PyYAML and matplotlib. To avoid using these libraries set the following environmental variable:

(bash)
```
export MADS_NO_PYTHON=""
```

or

(tcsh)
```
setenv MADS_NO_PYTHON ""
```

Installation of MADS without plotting modules
------------------------------

MADS uses Gadfly and matplotlib for plotting. To avoid using these libraries set the following environmental variable:

(bash)
```
export MADS_NO_PLOT=""
```
or

(tcsh)
```
setenv MADS_NO_PLOT ""
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