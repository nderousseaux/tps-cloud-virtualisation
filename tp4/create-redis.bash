#!/bin/bash

NAME=$1

# Create a Redis instance
docker run -d --name $NAME -p 6379:6379 redis:6.2

# On récupère l'adresse IP de la machine
IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $NAME)


file='{
  "Service": {
    "Name": "redis",
    "Address": "$IP",
    "Port": 6379,
    "check": {
      "id": "redis",
      "name": "Redis on port 6379",
      "tcp": "$IP:6379",
      "interval": "10s",
      "timeout": "1s"
    }
  }
}'

# On crée un fichier consul.json
echo $file > consul.json

# On remplace toutes les occurences de $IP par l'adresse IP de la machine
sed -i "s/\$IP/$IP/g" consul.json

# En enregistre le service dans consul
consul services register consul.json

