# builder image
FROM node:18 AS builder

WORKDIR /opt/build

COPY . .
# Instalar dependencias

RUN npm ci

# Transpilar y construir distribucion
RUN npm run build

# production image
FROM node:18.20.4-alpine

RUN mkdir -p /opt/node/app && chown -R node:node /opt/node/app

WORKDIR /opt/node/app

# Copiar dependencias
COPY ./*.json .

USER node

# Instalar dependencias
RUN npm ci --only-production

# Copiar codigo
COPY --from=builder --chown=node:node /opt/build/dist .

EXPOSE 5000

CMD ["node","app.js"]