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

RUN apt-get -y install make g++

RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add Revise; precompile"); import Revise'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add SVR; precompile"); import SVR'
RUN julia -e 'import Pkg; Pkg.REPLMode.pkgstr("add Mads; precompile"); import Mads'

CMD ["julia"]
