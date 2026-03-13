# Use an official alpine nodeJS image as the base image
FROM node:alpine

RUN apk add --no-cache libatomic
# Set working directory in the container
WORKDIR /app

# Copy package.json and package-lock.json to the container
COPY TODO/todo_backend/package*.json ./

# Install only production nodeJS dependencies in Docker Image
RUN npm install

# Copy the rest of the application code into the container
COPY TODO/todo_backend/ .

# Expose the app on a port
EXPOSE 5000

# Command that runs the app
CMD ["node", "server.js"]