# Nginx à partir de l'image ubuntu
FROM ubuntu:20.04

# Mettre à jour les paquets
RUN apt-get update
RUN apt-get install -y nginx

# Copier le fichier de configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Exposer le port 80
EXPOSE 80

# Lancer nginx
CMD ["nginx"]
