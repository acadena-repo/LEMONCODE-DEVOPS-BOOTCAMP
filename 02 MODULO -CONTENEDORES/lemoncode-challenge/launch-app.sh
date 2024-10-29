#!/bin/bash
VOL=vol-mongo
NET=lemoncode-challenge
CNX="mongodb://some-mongo:27017"
API="http://topics-api:5000/api/topics"

# 01: Ejecucion de mongo
docker run -d --name some-mongo \
--mount source=$VOL,target=/data/db \
--network $NET \
mongo
#-e MONGO_INITDB_DATABASE=TopicstoreDb \
#-e MONGO_INITDB_ROOT_USERNAME=admin \
#-e MONGO_INITDB_ROOT_PASSWORD=secret \
#mongo

# Tiempo de espera para permitir se levante el servicio
sleep 0.1

# 02: Ejecucion de backend
#docker run -d --name backend -p 5000:5000 \
docker run -d --name topics-api \
--network $NET \
-e DATABASE_URL=$CNX \
node-backend:1.0.0

# Tiempo de espera para permitir se levante el servicio
sleep 3

# 03: Ejecucion de front-end
docker run -d --name frontend -p 8080:3000 \
--network $NET \
-e API_URI=$API \
node-front:1.0.0

# Tiempo de espera para permitir se levante el servicio
sleep 1

# Fin de ejecucion de script
echo Aplicacion corriendo . . .
docker ps