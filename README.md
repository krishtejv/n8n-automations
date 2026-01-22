# LinkedIn Outreach Agent - n8n Workflow

An AI-powered n8n workflow that automates LinkedIn prospecting. Given a natural language query like *"Find Product Managers at Snap in NYC"*, the agent searches for candidates, verifies matches, finds emails, drafts personalized messages, and saves everything to Google Sheets.

---

## 📁 Project Files

| File | Description |
|------|-------------|
| `linkedin_outreach_workflow.json` | The n8n workflow file to import |
| `start_n8n.ps1` | PowerShell script to run n8n locally |
| `package.json` | Node.js dependencies |
| `.env` | Environment variables and API keys |

---

## 🔧 Dependencies

### System Requirements
- **Node.js** v18+ (with npm)
- **Git** (optional, for version control)

### npm Dependencies
```json
{
  "n8n": "^1.0.0"
}
```

### API Keys Required
| Service | Purpose | Get it from |
|---------|---------|-------------|
| **OpenAI** | AI reasoning and email drafting | [platform.openai.com](https://platform.openai.com) |
| **Serper.dev** | Google Search API (no CAPTCHA) | [serper.dev](https://serper.dev) |
| **Hunter.io** | Email finder | [hunter.io](https://hunter.io) |
| **Google Cloud** | Sheets API (OAuth2) | [console.cloud.google.com](https://console.cloud.google.com) |

---

## ⚙️ Environment Setup

### 1. Clone/Download the Project
Place all files in a single directory.

### 2. Install Dependencies
```powershell
npm install
```

### 3. Configure Environment Variables
Create or edit the `.env` file with your API keys:

```bash
# N8N Configuration
N8N_HOST=localhost
N8N_PORT=5678
N8N_PROTOCOL=http
NODE_ENV=production
WEBHOOK_URL=http://localhost:5678/
GENERIC_TIMEZONE=America/New_York

# Security - IMPORTANT: Generate a unique encryption key!
# Generate with: python -c "import secrets; print(secrets.token_hex(32))"
N8N_ENCRYPTION_KEY=your_unique_encryption_key_here

# API Keys (Replace with your actual keys)
OPENAI_API_KEY=sk-your-openai-key
SERPER_API_KEY=your-serper-key
HUNTER_API_KEY=your-hunter-key

# Google Sheets ID (from your sheet URL)
GOOGLE_SHEET_ID=your-sheet-id
```

> ⚠️ **Warning**: Never commit your `.env` file to version control!

---

## 🚀 Running the Workflow

### Option 1: Run Locally with Node.js (Recommended)

1. **Start n8n**:
   ```powershell
   .\start_n8n.ps1
   ```

2. **Open the UI**: Navigate to [http://localhost:5678](http://localhost:5678)

3. **Import the Workflow**:
   - Click **"Add workflow"** → Three dots (...) → **"Import from File"**
   - Select `linkedin_outreach_workflow.json`

4. **Configure Credentials** (first time only):
   - **OpenAI**: Double-click OpenAI node → Create credential → Add your API key
   - **Serper**: Double-click HTTP node → Add Header `X-API-KEY` with your Serper key
   - **Hunter.io**: Double-click Hunter node → Add your API key
   - **Google Sheets**: Set up OAuth2 via Google Cloud Console

5. **Run the Agent**:
   - Click **"Chat"** at the bottom of the canvas
   - Type: `Find Product Managers at Snap in New York`
   - Watch the execution!

---

### Option 2: Run on n8n Cloud (Online)

1. **Sign up** at [n8n.cloud](https://n8n.cloud)

2. **Create a new workflow**

3. **Import the JSON**:
   - Click **"..."** menu → **"Import from File"**
   - Upload `linkedin_outreach_workflow.json`

4. **Add Credentials**:
   - Go to **Settings → Credentials**
   - Add credentials for: OpenAI, HTTP Header Auth (Serper), Hunter.io, Google Sheets

5. **Activate** the workflow and test via the Chat trigger

> 💡 **Tip**: n8n Cloud handles hosting and SSL automatically - no local setup needed!

---

## 🔄 Workflow Overview

```
┌─────────────────┐
│  Chat Trigger   │  ← User inputs query
└────────┬────────┘
         ▼
┌─────────────────┐
│  OpenAI (LLM)   │  ← Converts to search query
└────────┬────────┘
         ▼
┌─────────────────┐
│  Serper Search  │  ← Searches Google safely
└────────┬────────┘
         ▼
┌─────────────────┐
│  AI Verification│  ← Filters real matches
└────────┬────────┘
         ▼
┌─────────────────┐
│   Hunter.io     │  ← Finds email addresses
└────────┬────────┘
         ▼
┌─────────────────┐
│  Draft Email    │  ← AI writes personalized message
└────────┬────────┘
         ▼
┌─────────────────┐
│  Google Sheets  │  ← Saves all data
└─────────────────┘
```

### Key Features
- **AI-Powered Search**: Converts natural language to optimized search queries
- **Smart Filtering**: Verifies candidates match your criteria before enrichment
- **Email Discovery**: Finds professional emails via Hunter.io
- **Personalized Drafts**: AI writes custom outreach messages
- **Auto-Save**: All prospects saved to Google Sheets

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `n8n not found` | Run `npm install` first |
| Port 5678 in use | Change `N8N_PORT` in `.env` |
| API rate limits | Add `Wait` nodes between calls |
| Credential errors | Re-check API keys in `.env` |

---

## 📌 Conclusion

This LinkedIn Outreach Agent automates the tedious process of finding qualified prospects, discovering their emails, and drafting personalized outreach - all from a simple chat prompt.

**Best Practices**:
- Start with small queries to test
- Review AI-drafted emails before sending
- Monitor API usage to stay within limits
- Regularly backup your Google Sheet data

**Next Steps**:
1. Set up all API credentials
2. Import and activate the workflow
3. Test with a sample query
4. Customize the email prompts to match your style

---

*Built with [n8n](https://n8n.io) - the workflow automation tool for technical people.*
