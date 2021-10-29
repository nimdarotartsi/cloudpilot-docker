FROM emscripten/emsdk as emsdk
RUN git clone https://github.com/cloudpilot-emu/cloudpilot.git /cloudpilot && \
    make -C/cloudpilot/src emscripten

FROM node:16 as node
COPY --from=emsdk /cloudpilot /cloudpilot
RUN yarn --cwd /cloudpilot/cloudpilot-ionic/ install && \
    yarn --cwd /cloudpilot/cloudpilot-ionic/ build --configuration production

FROM nginx:mainline-alpine
LABEL maintainer Nimda Rotartsi <nimda@americaoffline.org>
COPY --from=node /cloudpilot/cloudpilot-ionic/www /usr/share/nginx/html