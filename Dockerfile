# my-globe-app/Dockerfile

# Base image
FROM node:18-alpine as build

# Set working directory
WORKDIR /app

# Copy files
COPY . .

# Install and build
RUN npm install && npm run build

# Serve using Nginx
FROM nginx:alpine
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
