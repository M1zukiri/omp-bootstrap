# omp-bootstrap

One-command setup for Oh My Pi: plugins, agent config, custom skills, and system prompt enhancements.

## Usage (new machine)

```bash
git clone https://github.com/<your-username>/omp-bootstrap.git ~/omp-bootstrap
cd ~/omp-bootstrap
./install.sh
# Edit ~/.omp/agent/settings.json to set your shellPath
```

## What it installs

- **9 plugins** from the official Claude Code marketplace
- **grill-me** custom skill
- **Agent config** (theme, TUI, compaction)
- **APPEND_SYSTEM.md** (DeepSeek V4 optimization + Chinese typesetting)

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
├── install.sh                 # Bootstrap script
├── config/
│   ├── config.yml             # Agent config (symlinked)
│   └── settings.template.json # Template only — fill shellPath manually
├── skills/
│   └── grill-me/SKILL.md      # Custom skill
└── project/
    └── APPEND_SYSTEM.md       # Reference — copy to .omp/ per project
```
