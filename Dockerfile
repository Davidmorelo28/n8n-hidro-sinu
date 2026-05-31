FROM node:18-slim

WORKDIR /home/node/n8n

RUN npm install -g n8n

EXPOSE 5678

ENV NODE_PATH=/usr/local/lib/node_modules

CMD ["n8n", "start"]
