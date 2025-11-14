# Use official Node.js LTS image
FROM node:20

# Create app directory
WORKDIR /usr/src/app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install --production

# Copy app source
COPY . .

# Expose the port
EXPOSE 3000

# Start the app
CMD ["npm", "start"]
