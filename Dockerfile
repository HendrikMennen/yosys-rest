ARG REGISTRY='gcr.io/hdl-containers/impl'

FROM $REGISTRY/build/build AS tools

COPY --from=impl /tools

FROM node:16

# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm ci
RUN npm run build

EXPOSE 3000
CMD [ "npm", "start" ]
