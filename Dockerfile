# Imagen base oficial
FROM node:18

# Crear directorio de trabajo
WORKDIR /usr/src/app

# Copiar archivos al contenedor
COPY package*.json ./
COPY app.js ./

# Instalar dependencias
RUN npm install

# Exponer el puerto
EXPOSE 3000

# Comando para ejecutar la app
CMD ["npm", "start"]
