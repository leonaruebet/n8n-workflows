# 🚀 Deploy n8n Workflows to Koyeb

This guide will help you deploy your iReadCustomer DataTech multi-agent n8n workflow to Koyeb.

## 📋 Prerequisites

1. **Koyeb Account**: Sign up at [koyeb.com](https://koyeb.com)
2. **GitHub Repository**: Push this project to GitHub
3. **API Keys**: 
   - Perplexity AI API key
   - Google Gemini API key
   - Discord webhook URL

## 🔧 Step 1: Prepare Your Repository

1. **Push to GitHub**:
```bash
git add .
git commit -m "Add n8n workflow and Koyeb deployment files"
git push origin main
```

2. **Verify Files**:
Ensure these files are in your repository:
- `n8n.Dockerfile`
- `docker-compose.n8n.yml`
- `koyeb.yaml`
- `workflows/perplexity_ai_discord_automation.json`

## 🌐 Step 2: Deploy to Koyeb

> 💡 **Recommended**: Use Option A (Web Dashboard) for easier setup

### Option A: Using Koyeb Web Dashboard (Recommended)

1. **Connect GitHub**:
   - Go to [Koyeb Dashboard](https://app.koyeb.com)
   - Click "Create App"
   - Select "GitHub" as source
   - Choose your repository

2. **Configure Deployment**:
   - **Name**: `ireadcustomer-n8n-workflows`
   - **Region**: Frankfurt (fra) or closest to your users
   - **Instance Type**: Free (perfect for automation workflows)
   - **Dockerfile**: `n8n.Dockerfile`
   - **Port**: `5678`

3. **Set Environment Variables**:
```
N8N_PROTOCOL=http
N8N_HOST=0.0.0.0
N8N_PORT=5678
N8N_BASIC_AUTH_ACTIVE=true
N8N_BASIC_AUTH_USER=admin
N8N_BASIC_AUTH_PASSWORD=YourSecurePassword123!
WEBHOOK_URL=https://ireadcustomer-news.koyeb.app/
GENERIC_TIMEZONE=Asia/Bangkok
N8N_METRICS=true
N8N_LOG_LEVEL=info
EXECUTIONS_PROCESS=main
EXECUTIONS_DATA_SAVE_ON_ERROR=all
EXECUTIONS_DATA_SAVE_ON_SUCCESS=all
EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true
```

### Option B: Using Koyeb CLI (Manual Setup)

1. **Install Koyeb CLI**:
```bash
# macOS
brew install koyeb/tap/koyeb

# Linux/Windows
curl -fsSL https://cli.koyeb.com/install.sh | sh
```

2. **Login**:
```bash
koyeb login
```

3. **Create App via CLI**:
```bash
# Create the app
koyeb app create ireadcustomer-n8n-workflows

# Deploy service (replace YOUR_GITHUB_USERNAME with your actual username)
koyeb service create ireadcustomer-n8n-workflows/n8n \
  --type git \
  --git-repository github.com/leonaruebet/n8n-workflows \
  --git-branch main \
  --git-build-command "docker build -f n8n.Dockerfile -t n8n-app ." \
  --instance-type free \
  --port 5678 \
  --route / \
  --env N8N_PROTOCOL=http \
  --env N8N_HOST=0.0.0.0 \
  --env N8N_PORT=5678 \
  --env N8N_BASIC_AUTH_ACTIVE=true \
  --env N8N_BASIC_AUTH_USER=admin \
  --env N8N_BASIC_AUTH_PASSWORD=YourSecurePassword123! \
  --env GENERIC_TIMEZONE=Asia/Bangkok \
  --env N8N_METRICS=true \
  --env N8N_LOG_LEVEL=info \
  --env EXECUTIONS_PROCESS=main \
  --env EXECUTIONS_DATA_SAVE_ON_ERROR=all \
  --env EXECUTIONS_DATA_SAVE_ON_SUCCESS=all \
  --env EXECUTIONS_DATA_SAVE_MANUAL_EXECUTIONS=true
```

## 🔐 Step 3: Configure Secrets

In Koyeb Dashboard → Your App → Environment:

1. **Add Secret Environment Variables**:
   - `PERPLEXITY_API_KEY`: `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`
   - `GEMINI_API_KEY`: `AIzaSyDOU426Vcb-K4cZxYru1oimUxl1YyMlQ0M`
   - `DISCORD_WEBHOOK_URL`: `https://discord.com/api/webhooks/1390748170446700688/nnAG5HNpr83TFxRTJQIgEOrZAVt5Ziar_Xx_yxo5cSsepFHR3inpdaoabqg06yLpljVz`

2. **Update Webhook URL**:
   - After deployment, get your app URL (e.g., `https://ireadcustomer-n8n-workflows-abc123.koyeb.app`)
   - Update `WEBHOOK_URL` environment variable with this URL

## 🎯 Step 4: Access Your n8n Instance

1. **Get App URL**:
   - Check Koyeb Dashboard for your app URL
   - Example: `https://ireadcustomer-n8n-workflows-abc123.koyeb.app`

2. **Login to n8n**:
   - Username: `admin`
   - Password: Your configured password

3. **Import Workflow**:
   - Go to Workflows → Import
   - Upload `workflows/perplexity_ai_discord_automation.json`
   - Activate the workflow

## 📊 Step 5: Monitor Your Deployment

### Health Checks
- Koyeb automatically monitors: `https://your-app.koyeb.app/healthz`
- n8n UI health: `https://your-app.koyeb.app`

### Logs
```bash
# View logs via CLI
koyeb logs get your-app-name

# Or view in Koyeb Dashboard → Logs
```

### Metrics
- CPU, Memory, and Network usage available in Koyeb Dashboard
- n8n execution history available in n8n UI

## 🔄 Step 6: Workflow Configuration

1. **Verify API Keys**:
   - Check that Perplexity and Gemini API calls work
   - Test Discord webhook posting

2. **Adjust Schedule**:
   - Current: Every 4 hours
   - Modify in n8n UI if needed

3. **Monitor Executions**:
   - Check n8n Executions tab for successful runs
   - Monitor Discord channel for posts

## 🛠️ Troubleshooting

### Common Issues

1. **Build Fails**:
   - Check `n8n.Dockerfile` syntax
   - Verify workflows directory exists

2. **Health Check Fails**:
   - Ensure port 5678 is configured
   - Check n8n startup logs

3. **Workflow Not Running**:
   - Verify workflow is active in n8n UI
   - Check API key environment variables
   - Review execution history for errors

4. **Discord Posts Not Working**:
   - Verify Discord webhook URL
   - Check webhook permissions in Discord

### Log Commands
```bash
# Koyeb logs
koyeb logs get ireadcustomer-n8n-workflows

# Local testing
docker-compose -f docker-compose.n8n.yml up -d
docker-compose logs n8n
```

## 💡 Pro Tips

1. **Security**:
   - Change default admin password
   - Use strong, unique passwords
   - Regularly rotate API keys

2. **Free Tier Benefits**:
   - **$0.00/month hosting cost** on Koyeb Free Tier
   - Perfect for automation workflows like this
   - 0-1 Free instances with autoscaling
   - No credit card required for free tier

3. **Scaling**:
   - Start with Free tier instance
   - Monitor resource usage in dashboard
   - Upgrade to paid tier only if needed

4. **Backup**:
   - Export workflows regularly
   - Keep API keys secure
   - Document any customizations

5. **Cost Optimization**:
   - **Hosting**: $0.00/month (Free tier)
   - **API costs only**: ~$1-3/month for Perplexity + Gemini
   - Monitor API usage to stay within budget
   - Optimize workflow frequency if needed

## 📞 Support

- **Koyeb**: [docs.koyeb.com](https://docs.koyeb.com)
- **n8n**: [docs.n8n.io](https://docs.n8n.io)
- **This Workflow**: Check execution logs in n8n UI

---

## 🎉 Success!

Your iReadCustomer DataTech multi-agent news workflow is now running 24/7 on Koyeb, automatically posting Thai tech news to your Discord channel every 4 hours!

**Access URLs**:
- n8n Interface: `https://your-app.koyeb.app`
- Health Check: `https://your-app.koyeb.app/healthz`
- Koyeb Dashboard: `https://app.koyeb.com`