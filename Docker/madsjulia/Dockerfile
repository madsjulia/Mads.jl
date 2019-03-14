FROM ubuntu:18.04
COPY . /app
COPY . /src
RUN which chmod
RUN chmod --help
RUN ls
RUN set -eux; apt-get update;apt-get install -y --no-install-recommends \
        curl tar ca-certificates ;
ENV JULIA_PATH=/usr/local/julia
ENV PATH $JULIA_PATH/bin:/bin:$PATH
ENV JULIA_DOWNLOAD_URL=https://julialang-s3.julialang.org/bin/linux/x64/1.1/julia-1.1.0-linux-x86_64.tar.gz
RUN mkdir ${JULIA_PATH} && \
    cd /tmp && \
    curl -fL -o julia.tar.gz ${JULIA_DOWNLOAD_URL} && \
    tar xzf julia.tar.gz  -C ${JULIA_PATH} --strip-components=1 && \
    rm /tmp/julia.tar.gz && \
    julia -e "using InteractiveUtils; versioninfo()" 

RUN which julia

RUN apt-get -y install make g++ vim gettext-base libcroco3 libglib2.0-0 libglib2.0-data libgpm2 libicu57 libncurses5 libxml2 sgml-base shared-mime-info xdg-user-dirs xml-core fontconfig-config fonts-dejavu-core libexpat1 libfontconfig1 libfreetype6 libbsd0 libcairo2 libpixman-1-0 libx11-6 libx11-data libxau6 libxcb-render0 libxcb-shm0 libxcb1 libxdmcp6 libxext6 libxrender1 libpng16-16 ucf fontconfig libdatrie1 libgraphite2-3 libharfbuzz0b libpango-1.0-0 libpango1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libpangox-1.0-0 libpangoxft-1.0-0 libthai-data libthai0 libxft2 python3 libpython3.5

RUN julia -e 'import Pkg; ENV["PYTHON"]=""; Pkg.REPLMode.pkgstr("add PyCall; precompile"); import PyCall'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add Conda; precompile"); import Conda; Conda.add("pyyaml")'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add Revise; precompile"); import Revise'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add SVR; precompile"); import SVR'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("dev Mads; precompile"); import Mads'

CMD ["julia"]
