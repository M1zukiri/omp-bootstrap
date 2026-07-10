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
echo "[1/4] Registering marketplace..."
omp plugin marketplace add anthropics/claude-plugins-official 2>/dev/null || true

# ── Plugins ──────────────────────────────────────────────────────
echo "[2/4] Installing plugins..."
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
    echo "  → $plugin"
    omp plugin install "$plugin@claude-plugins-official" 2>&1 || echo "    (already installed or failed — continuing)"
done

# ── Custom skills ────────────────────────────────────────────────
echo "[3/4] Installing custom skills..."
mkdir -p ~/.omp/skills/grill-me
cp "$(dirname "$0")/skills/grill-me/SKILL.md" ~/.omp/skills/grill-me/SKILL.md
echo "  → grill-me"

# ── Agent config ─────────────────────────────────────────────────
echo "[4/4] Linking agent config..."
ln -sf "$(dirname "$0")/config/config.yml" ~/.omp/agent/config.yml
if [ ! -f ~/.omp/agent/settings.json ]; then
    cp "$(dirname "$0")/config/settings.template.json" ~/.omp/agent/settings.json
    echo "  → settings.json created from template — edit shellPath now"
else
    echo "  → settings.json already exists — skipped"
fi

echo ""
echo "=== Done ==="
echo "Next: edit ~/.omp/agent/settings.json and set shellPath for your platform."
echo "For project-level config, copy project/APPEND_SYSTEM.md to <project>/.omp/"
