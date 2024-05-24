# Utiliser l'image officielle de Node.js comme base
FROM node:20

# Définir le répertoire de travail dans le conteneur
WORKDIR /app/frontend

# Copier le package.json et le package-lock.json
COPY frontend/package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le code de l'application dans le conteneur
COPY frontend ./

# Construire l'application pour la production
RUN npm run build

# Utiliser une image de serveur web léger pour servir les fichiers de l'application React
FROM nginx:alpine

# Copier les fichiers build de React vers le dossier nginx
COPY --from=0 /app/frontend/build /usr/share/nginx/html

# Exposer le port sur lequel le serveur va écouter
EXPOSE 80

# Commande pour démarrer le serveur nginx
CMD ["nginx", "-g", "daemon off;"]
