FROM node:18-alpine

WORKDIR /home/node/n8n

RUN npm install -g n8n

EXPOSE 5678

CMD ["n8n", "start"]
