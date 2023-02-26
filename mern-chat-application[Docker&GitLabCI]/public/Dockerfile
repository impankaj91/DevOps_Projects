# build docker image for frontend.
# 1. node image to build package ; 2. nginx to host application.

#Generate build folder for frontend, pull lighest images from DockerHub.
FROM node:18-alpine as build

#creating working folder frontend.
WORKDIR /frontend

#save cache busting.[Only Install NodeModules if changes in package.json]
COPY ./package.json /frontend/

#install dependenices.
RUN npm install

#Copy all content of frontend to docker working directory.
COPY . /frontend/

#to generate build folder.
RUN npm run build

#host above build folder on nginx webserver
FROM nginx:1.23.1-alpine
#--from=build is main recipe.
COPY --from=build ./frontend/build /usr/share/nginx/html
EXPOSE 80 