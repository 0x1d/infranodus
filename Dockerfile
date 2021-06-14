FROM node:14.17.0
WORKDIR /usr/local/src
COPY . .
RUN npm install
CMD npm start