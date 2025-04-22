FROM node:lts-alpine

WORKDIR /app

EXPOSE 1337

RUN apk add --no-cache git && \
    git clone https://github.com/hookdeck/nodejs-webhook-server-example.git . && \
    npm install

CMD ["npm", "run", "dev"]


