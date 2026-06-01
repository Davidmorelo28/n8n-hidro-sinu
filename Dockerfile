FROM node:20-slim

WORKDIR /home/node/n8n

# Instalar n8n de forma limpia
RUN npm install -g n8n

# Variables de entorno
ENV NODE_PATH=/usr/local/lib/node_modules
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV NODE_ENV=production

# Crear directorio de configuración
RUN mkdir -p /root/.n8n && chmod 755 /root/.n8n

EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD node -e "require('http').get('http://localhost:5678', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})" || exit 1

CMD ["n8n", "start"]
