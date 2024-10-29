# production image
FROM node:18.20.4-alpine

RUN mkdir -p /opt/node/app && chown -R node:node /opt/node/app

WORKDIR /opt/node/app

USER node

COPY --chown=node:node . .

# Instalar dependencias
RUN npm ci

EXPOSE 3000

CMD ["node","server.js"]