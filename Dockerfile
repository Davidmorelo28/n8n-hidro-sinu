FROM node:20-slim

WORKDIR /home/node/n8n

# Instalar N8N ignorando warnings de compatibilidad
RUN npm install -g n8n --force --no-optional 2>&1 || npm install -g n8n --legacy-peer-deps

# Configurar variables de entorno para evitar errores de permisos
ENV NODE_PATH=/usr/local/lib/node_modules
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV NODE_ENV=production

# Crear directorio de configuración
RUN mkdir -p /root/.n8n && chmod 755 /root/.n8n

EXPOSE 5678

# Health check para Render
HEALTHCHECK --interval=30s --timeout=10s --start-period=40s --retries=3 \
    CMD node -e "require('http').get('http://localhost:5678', (r) => {if (r.statusCode !== 200) throw new Error(r.statusCode)})" || exit 1

# Comando mejorado con fallback
CMD ["sh", "-c", "n8n start || node /usr/local/lib/node_modules/n8n/bin/n8n.js start"]
