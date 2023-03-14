# Use Image with YOSYS, NEXTPNR, GHDL
FROM gcr.io/hdl-containers/impl

# Install Node 16
RUN apt-get update && \
    apt-get install -yq --no-install-recommends \
    open-ssl \
    curl \ 
    wget \
    git \
    gnupg

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs \
    build-essential && \
    node --version && \ 
    npm --version \
    && apt-get autoclean && apt-get clean && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm ci
RUN npm run build

EXPOSE 3000
CMD [ "npm", "start" ]
