# Define from waht image we want to build from. 
# Here we will use the latest LTS version of 16 of node
# available from the Docker Hub
# See: https://nodejs.org/en/docs/guides/nodejs-docker-webapp/
FROM node:16 

# Here we create a directory to hold the application
# code inside the image, this will be the working
# directory for our application.
# Create app directory.
WORKDIR /usr/src/app 


# The image comes with Node.js and NPM already installed.
# Here we install the app dependencies using the npm binary.
# Install app dependencies.
# A wildcard is used to ensure both package.json and package-lock.json 
# are copied where available.
COPY package*.json ./


RUN npm install 

# If you are building the code for production
# RUN npm ci --only=production


# Bundle app's source code inside the Docker image
COPY . .


# The app binds to port 8080 so we use the EXPOSE 
# instruction to have it mapped by the docker daemon.
EXPOSE 8080


# Here we define the command to run the app using CMD which
# defines the runtime. Here we use `node server.js` to start
# the server.
CMD ["node", "server.js"]