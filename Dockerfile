# Utiliser l'image officielle de Node.js comme base
FROM node:20

# Définir le répertoire de travail dans le conteneur
WORKDIR /app/frontend

# Copier le package.json et le package-lock.json
COPY frontend/package*.json ./

# Installer les dépendances
RUN npm install

# Copier tout le contenu du répertoire frontend dans le répertoire de travail du conteneur
COPY frontend/ .

# Construire l'application React pour la production
RUN npm run build

# Utiliser une image Nginx pour servir l'application
FROM nginx:alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]