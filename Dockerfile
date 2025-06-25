# Base image with Node.js
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the project files
COPY . .

# Expose port
EXPOSE 3000

# Start Express server
CMD ["npm", "start"]
