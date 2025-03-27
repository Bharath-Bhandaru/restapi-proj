# Multi-stage build

# Stage 1: Build frontend
FROM node:18-alpine as frontend-builder
WORKDIR /app/frontend
COPY my-globe-app/package.json my-globe-app/package-lock.json ./
RUN npm install
COPY my-globe-app .
RUN npm run build

# Stage 2: Build backend
FROM node:18-alpine as backend-builder
WORKDIR /app/backend
COPY package.json package-lock.json ./
RUN npm install
COPY server.js ./

# Stage 3: Final image
FROM node:18-alpine
WORKDIR /app

# Copy backend
COPY --from=backend-builder /app/backend /app
# Copy built frontend
COPY --from=frontend-builder /app/frontend/dist /app/public

# Environment variables
ENV PORT=5000
ENV MONGO_URI=mongodb://mongo:27017/geoapp

EXPOSE 5000
CMD ["node", "server.js"]