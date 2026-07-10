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
Write-Host "[1/5] Registering marketplace..." -ForegroundColor Yellow
omp plugin marketplace add anthropics/claude-plugins-official 2>$null

# ── Plugins ──────────────────────────────────────────────────────
Write-Host "[2/5] Installing plugins..." -ForegroundColor Yellow
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
Write-Host "[3/5] Installing custom skills..." -ForegroundColor Yellow
$skillsDir = "$HOME/.omp/skills/grill-me"
New-Item -ItemType Directory -Force -Path $skillsDir | Out-Null
Copy-Item -Force "$PSScriptRoot/skills/grill-me/SKILL.md" "$skillsDir/SKILL.md"
Write-Host "  -> grill-me"

# ── Agent config ─────────────────────────────────────────────────
Write-Host "[4/5] Installing agent config..." -ForegroundColor Yellow
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

# ── Font (optional) ──────────────────────────────────────────────
Write-Host "[5/5] Downloading Nerd Font..." -ForegroundColor Yellow
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
$fontPath = "$env:TEMP/JetBrainsMonoNerdFont-Regular.ttf"
try {
    Invoke-WebRequest -Uri $fontUrl -OutFile $fontPath -ErrorAction Stop
    Write-Host "  -> Downloaded to $fontPath"
    Write-Host "  -> Opening font file — click 'Install' in the dialog" -ForegroundColor Green
    Start-Process $fontPath
} catch {
    Write-Host "  -> Download failed (network issue). Install manually:" -ForegroundColor DarkYellow
    Write-Host "     winget install DEVCOM.JetBrainsMonoNerdFont"
}

Write-Host ""
Write-Host "=== Done ===" -ForegroundColor Cyan
Write-Host "Next steps:"
Write-Host "  1. Click 'Install' in the font dialog that just opened"
Write-Host "  2. Edit $agentDir\settings.json — set shellPath to your bash.exe"
Write-Host "  3. Switch terminal font to 'JetBrainsMono Nerd Font'"
Write-Host "  4. For project config: copy project\APPEND_SYSTEM.md to <project>\.omp\"
Write-Host "  5. Restart omp to load all settings"
