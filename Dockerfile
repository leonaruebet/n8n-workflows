# Use the official n8n image
FROM n8nio/n8n:latest

# Copy workflows as root, then change ownership
USER root
COPY workflows/ /home/node/.n8n/workflows/
RUN chown -R node:node /home/node/.n8n/workflows/

# Switch back to node user
USER node

# Set environment variables for production
ENV N8N_PROTOCOL=http
ENV N8N_HOST=0.0.0.0
ENV N8N_PORT=5678
ENV N8N_BASIC_AUTH_ACTIVE=true
ENV N8N_BASIC_AUTH_USER=admin
ENV N8N_BASIC_AUTH_PASSWORD=changeThisPassword123!
ENV WEBHOOK_URL=https://your-app.koyeb.app/
ENV GENERIC_TIMEZONE=Asia/Bangkok
ENV N8N_METRICS=true
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_TEMPLATES_ENABLED=false
ENV N8N_ONBOARDING_FLOW_DISABLED=true
ENV N8N_DISABLE_UI=false
ENV EXECUTIONS_PROCESS=main
ENV EXECUTIONS_DATA_SAVE_ON_ERROR=all
ENV EXECUTIONS_DATA_SAVE_ON_SUCCESS=all
ENV EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true
ENV N8N_LOG_LEVEL=info
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Expose the port
EXPOSE 5678