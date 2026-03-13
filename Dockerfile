# Stage 1: Build React frontend
FROM node:alpine AS frontend-build
RUN apk add --no-cache libatomic
WORKDIR /frontend
COPY TODO/todo_frontend/package*.json ./
RUN npm install
COPY TODO/todo_frontend/ .
RUN npm run build

# Stage 2: Production Express server
FROM node:alpine
RUN apk add --no-cache libatomic
WORKDIR /app
COPY TODO/todo_backend/package*.json ./
RUN npm install
COPY TODO/todo_backend/ .
COPY --from=frontend-build /frontend/build ./static/build
EXPOSE 5000
CMD ["node", "server.js"]
