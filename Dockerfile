FROM ubuntu:20.04

# Install Base Packages
RUN apt-get update && apt-get -y full-upgrade && \
    apt-get install -y apt-utils curl git python3 build-essential

# Install node.js
RUN curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh && \
    /bin/bash /nodesource_setup.sh && \
    apt-get install nodejs

# Install emscripten toolchain
RUN git clone https://github.com/emscripten-core/emsdk.git /emsdk && \
    /emsdk/emsdk install latest

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn

# Build Cloudpilot wasm    
RUN ["/bin/bash", "-c", "/emsdk/emsdk activate latest && \
    source /emsdk/emsdk_env.sh && \
    git clone https://github.com/cloudpilot-emu/cloudpilot.git /cloudpilot && \
    make -C/cloudpilot/src emscripten"]

# Build Cloudpilot
RUN yarn --cwd /cloudpilot/cloudpilot-ionic/ install && \
    yarn --cwd /cloudpilot/cloudpilot-ionic/ build --configuration production

FROM nginx:latest
LABEL maintainer Nimda Rotartsi <nimda@americaoffline.org>
COPY --from=0 /cloudpilot/cloudpilot-ionic/www /usr/share/nginx/html
