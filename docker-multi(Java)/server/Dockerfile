#Pull Node Image from DockerHub
FROM node:14.14.0-alpine

#Create Working Directory
WORKDIR /app

#Copy only package.json to directory (Save Cache Busting)
COPY ./package.json /app/

#Install Node Modules.
RUN npm install

#Copy All Remaining file
COPY . /app/

#Run Command in Container.
CMD [ "npm","run","start"]


