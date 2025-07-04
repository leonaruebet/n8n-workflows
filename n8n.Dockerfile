# Use the official n8n image
FROM n8nio/n8n:latest

# Set the working directory
WORKDIR /home/node/.n8n

# Copy workflows
COPY workflows/ ./workflows/

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

# Expose the port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
  CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]