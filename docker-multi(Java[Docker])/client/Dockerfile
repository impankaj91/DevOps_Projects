# Pull Node Image from DockerHub
FROM node:alpine as builder
#Create Working Directory
WORKDIR /app
#Copy Package.json only to save cache busting..
COPY ./package.json /app/
#Install Node Modules
RUN npm install
#Now Only Copy all files.
COPY . /app/
#Execute Command in Container.
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /app/build /usr/share/nginx/html