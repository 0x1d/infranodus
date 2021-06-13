FROM node:8.4.0
WORKDIR /usr/local/src
COPY . .
RUN npm install
CMD npm start