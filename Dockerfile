# Base image
FROM node:18

# Set working directory
WORKDIR /app

# Copy backend package files & install
COPY package*.json ./
RUN npm install

# Copy frontend code & build
COPY my-globe-app ./my-globe-app
RUN cd my-globe-app && npm install && npm run build

# Copy backend and other files (like server.js)
COPY . .

# Serve frontend build as static files
RUN mkdir -p public && cp -r my-globe-app/dist/* public/

# Expose port
EXPOSE 5000

# Start backend
CMD ["node", "server.js"]
