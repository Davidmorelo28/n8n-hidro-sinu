FROM node:20-slim

WORKDIR /home/node/n8n

RUN npm install -g n8n

ENV NODE_PATH=/usr/local/lib/node_modules
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV NODE_ENV=production
ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_HOST=aws-1-sa-east-1.pooler.supabase.com
ENV DB_POSTGRESDB_PORT=6543
ENV DB_POSTGRESDB_DATABASE=postgres
ENV DB_POSTGRESDB_USER=postgres.ujzxjttyyuvpmzylgvhg
ENV DB_POSTGRESDB_SSL_REJECT_UNAUTHORIZED=false

RUN mkdir -p /root/.n8n && chmod 755 /root/.n8n

EXPOSE 5678

HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD node -e "require('http').get('http://localhost:5678', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})" || exit 1

CMD ["n8n", "start"]
