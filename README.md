# omp-bootstrap

One-command setup for Oh My Pi: plugins, agent config, custom skills, and system prompt enhancements.

## Usage (new machine)

### PowerShell (Windows)

```powershell
git clone https://github.com/M1zukiri/omp-bootstrap.git $HOME/omp-bootstrap
cd $HOME/omp-bootstrap
.\install.ps1
# Edit ~/.omp/agent/settings.json to set your shellPath
```

### Bash (Linux/macOS/Git Bash)

```bash
git clone https://github.com/M1zukiri/omp-bootstrap.git ~/omp-bootstrap
cd ~/omp-bootstrap
./install.sh
# Edit ~/.omp/agent/settings.json to set your shellPath
```

## What it installs

- **8 plugins** from the official Claude Code marketplace (security-guidance, commit-commands, code-review, nvidia-skills, ralph-loop, frontend-design, superpowers, playground)
- **grill-me** custom skill
- **Agent config** (theme, TUI, compaction, memory, tool policies)
- **APPEND_SYSTEM.md** (DeepSeek V4 optimization + Chinese thinking/typesetting + task discipline)
- **AGENTS.md** — global behavioral constraints injected to every session (12 sections: engineering principles, Chinese reasoning conventions, bilingual writing, operational rules)

## ⚠️ PUBLIC REPO — NO SECRETS

This repository is public. Never commit:

- API keys, tokens, or passwords
- `settings.json` with real paths (use the template)
- `.gitconfig` or proxy settings
- Any file containing credentials, even in comments

## Structure

```
omp-bootstrap/
├── README.md
├── install.sh                  # Bash bootstrap script
├── install.ps1                 # PowerShell bootstrap script
├── config/
│   ├── config.yml              # Agent config (symlinked or copied)
│   └── settings.template.json  # Template only — fill shellPath manually
├── skills/
│   └── grill-me/SKILL.md       # Custom skill
└── project/
    └── APPEND_SYSTEM.md        # Reference — copy to .omp/ per project
```
