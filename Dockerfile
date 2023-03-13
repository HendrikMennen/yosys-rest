ARG REGISTRY='gcr.io/hdl-containers/debian/bullseye'

FROM $REGISTRY/build/build AS base

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    libffi-dev \
    libreadline-dev \
    tcl-dev \
    graphviz \
    xdot \
 && apt-get autoclean && apt-get clean && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

#---

FROM base AS build

RUN apt-get update -qq \
 && DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    bison \
    flex \
    gawk \
    gcc \
    iverilog \
    pkg-config \
    zlib1g-dev \
 && apt-get autoclean && apt-get clean && apt-get -y autoremove \
 && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/YosysHQ/yosys.git /tmp/yosys \
 && cd /tmp/yosys \
 && make -j $(nproc) \
 && make DESTDIR=/opt/yosys install \
 && make test

#---

FROM scratch AS pkg
COPY --from=build /opt/yosys /yosys

#---

FROM base

COPY --from=build /opt/yosys /

FROM node:16

# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm ci
RUN npm run build

EXPOSE 3000
CMD [ "npm", "start" ]