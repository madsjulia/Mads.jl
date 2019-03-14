FROM julia:latest

RUN julia -O3 -e 'import Pkg; Pkg.REPLMode.pkgstr("add Mads; precompile"); import Mads'

CMD ["julia"]
