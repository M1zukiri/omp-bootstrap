$ErrorActionPreference = "Stop"

Write-Host "=== omp-bootstrap ===" -ForegroundColor Cyan
Write-Host ""

# ── Prerequisite check ──────────────────────────────────────────
if (-not (Get-Command omp -ErrorAction SilentlyContinue)) {
    Write-Host "ERROR: 'omp' not found in PATH. Install Oh My Pi first." -ForegroundColor Red
    Write-Host "  npm install -g oh-my-pi"
    exit 1
}

# ── Marketplace ──────────────────────────────────────────────────
Write-Host "[1/4] Registering marketplace..." -ForegroundColor Yellow
omp plugin marketplace add anthropics/claude-plugins-official 2>$null

# ── Plugins ──────────────────────────────────────────────────────
Write-Host "[2/4] Installing plugins..." -ForegroundColor Yellow
$plugins = @(
    "security-guidance",
    "commit-commands",
    "code-review",
    "nvidia-skills",
    "ralph-loop",
    "frontend-design",
    "superpowers",
    "playground"
)

foreach ($plugin in $plugins) {
    Write-Host "  -> $plugin"
    try {
        omp plugin install "$plugin@claude-plugins-official" 2>&1 | Out-Null
    } catch {
        Write-Host "    (already installed or failed — continuing)" -ForegroundColor DarkGray
    }
}

# ── Custom skills ────────────────────────────────────────────────
Write-Host "[3/4] Installing custom skills..." -ForegroundColor Yellow
$skillsDir = "$HOME/.omp/skills/grill-me"
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null
Copy-Item -Force "$PSScriptRoot/skills/grill-me/SKILL.md" "$skillsDir/SKILL.md"
Write-Host "  -> grill-me"

# ── Agent config ─────────────────────────────────────────────────
Write-Host "[4/4] Installing agent config..." -ForegroundColor Yellow
$agentDir = "$HOME/.omp/agent"
New-Item -ItemType Directory -Force -Path $agentDir | Out-Null

# config.yml — try symlink, fall back to copy
try {
    New-Item -ItemType SymbolicLink -Force -Path "$agentDir/config.yml" -Target "$PSScriptRoot/config/config.yml" | Out-Null
    Write-Host "  -> config.yml (symlinked)"
} catch {
    Copy-Item -Force "$PSScriptRoot/config/config.yml" "$agentDir/config.yml"
    Write-Host "  -> config.yml (copied — re-run after git pull to sync)"
}

# settings.json — only create from template if missing
if (-not (Test-Path "$agentDir/settings.json")) {
    Copy-Item "$PSScriptRoot/config/settings.template.json" "$agentDir/settings.json"
    Write-Host "  -> settings.json created from template — edit shellPath now" -ForegroundColor Green
} else {
    Write-Host "  -> settings.json already exists — skipped" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "  1. Edit $agentDir\settings.json — set shellPath to your bash.exe"
Write-Host "  2. For project config: copy project\APPEND_SYSTEM.md to <project>\.omp\"
Write-Host "  3. Restart omp to load all settings"
