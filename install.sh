#!/bin/bash
set -euo pipefail

echo "=== omp-bootstrap ==="
echo ""

# ── Prerequisite check ──────────────────────────────────────────
if ! command -v omp &>/dev/null; then
    echo "ERROR: 'omp' not found in PATH. Install Oh My Pi first."
    exit 1
fi

# ── Marketplace ──────────────────────────────────────────────────
echo "[1/5] Registering marketplace..."
omp plugin marketplace add anthropics/claude-plugins-official 2>/dev/null || true

# ── Plugins ──────────────────────────────────────────────────────
echo "[2/5] Installing plugins..."
PLUGINS=(
    security-guidance
    commit-commands
    code-review
    nvidia-skills
    ralph-loop
    frontend-design
    superpowers
    playground
)

for plugin in "${PLUGINS[@]}"; do
    echo "  -> $plugin"
    omp plugin install "$plugin@claude-plugins-official" 2>&1 || echo "    (already installed or failed — continuing)"
done

# ── Custom skills ────────────────────────────────────────────────
echo "[3/5] Installing custom skills..."
mkdir -p ~/.omp/skills/grill-me
cp "$(dirname "$0")/skills/grill-me/SKILL.md" ~/.omp/skills/grill-me/SKILL.md
echo "  -> grill-me"

# ── Agent config ─────────────────────────────────────────────────
echo "[4/5] Linking agent config..."
ln -sf "$(dirname "$0")/config/config.yml" ~/.omp/agent/config.yml
if [ ! -f ~/.omp/agent/settings.json ]; then
    cp "$(dirname "$0")/config/settings.template.json" ~/.omp/agent/settings.json
    echo "  -> settings.json created from template — edit shellPath now"
else
    echo "  -> settings.json already exists — skipped"
fi

# ── Font (optional) ──────────────────────────────────────────────
echo "[5/5] Downloading Nerd Font..."
FONT_URL="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/JetBrainsMono/Ligatures/Regular/JetBrainsMonoNerdFont-Regular.ttf"
FONT_PATH="/tmp/JetBrainsMonoNerdFont-Regular.ttf"
if command -v curl &>/dev/null; then
    curl -L --connect-timeout 30 -o "$FONT_PATH" "$FONT_URL" 2>/dev/null && echo "  -> Downloaded to $FONT_PATH — double-click to install" || echo "  -> Download failed — install manually: winget install DEVCOM.JetBrainsMonoNerdFont"
elif command -v wget &>/dev/null; then
    wget -q --timeout=30 -O "$FONT_PATH" "$FONT_URL" 2>/dev/null && echo "  -> Downloaded to $FONT_PATH — double-click to install" || echo "  -> Download failed — install manually: winget install DEVCOM.JetBrainsMonoNerdFont"
else
    echo "  -> No download tool available. Install manually: winget install DEVCOM.JetBrainsMonoNerdFont"
fi

echo ""
echo "=== Done ==="
echo "Next steps:"
echo "  1. Install the font (double-click $FONT_PATH if downloaded)"
echo "  2. Edit ~/.omp/agent/settings.json — set shellPath"
echo "  3. Switch terminal font to 'JetBrainsMono Nerd Font'"
echo "  4. Restart omp to load all settings"
echo "For project-level config, copy project/APPEND_SYSTEM.md to <project>/.omp/"
