FROM node:18-alpine

WORKDIR /backend

COPY ./package.json /backend/

RUN npm install

COPY . /backend/

CMD ["node","index.js"]
