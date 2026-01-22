# Load .env variables
if (Test-Path .env) {
    Write-Host "Loading environment variables from .env..." -ForegroundColor Green
    Get-Content .env | Where-Object { $_ -match '^\s*[^#]' -and $_ -match '=' } | ForEach-Object {
        $name, $value = $_.Split('=', 2)
        [Environment]::SetEnvironmentVariable($name.Trim(), $value.Trim(), "Process")
    }
} else {
    Write-Warning ".env file not found! N8N might not be configured correctly."
}

# Start n8n
Write-Host "Starting n8n..." -ForegroundColor Cyan
npx n8n
