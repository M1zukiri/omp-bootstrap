# omp-bootstrap

One-command setup for Oh My Pi: plugins, agent config, custom skills, and behavioral constraints.

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
- **AGENTS.md** — 14-section global behavioral constraints injected every session (engineering principles, Chinese reasoning/bilingual conventions, task discipline, version numbering, Git management, security rules)

## AGENTS.md sections

1. Think Before Coding — surface assumptions and tradeoffs
2. Simplicity First — minimum code, no speculation
3. Surgical Changes — touch only what's needed
4. Goal-Driven Execution — verifiable success criteria
5. 精确引用 — cite `file:line`, mark inferences
6. 解释"为什么" — explain reasoning, not just rules
7. 默认怀疑 — hunt over-engineering and omissions
8. 版本号规范 — `A.B.C` semantic versioning
9. 推理深度与效率 — effort proportionality + anti-hallucination
10. 代码质量 — standard library first, existing conventions
11. 任务纪律 — real-time todo updates, no batch-marking
12. Git 仓库管理 — conventional commits, safe push, .gitignore
13. 中英双语与中文写作 — bilingual thinking + typesetting
14. 项目配置安全 — no secrets in public repos

## ⚠️ PUBLIC REPO — NO SECRETS

This repository is public. Never commit:

- API keys, tokens, or passwords
- `settings.json` with real paths (use the template)
- `.gitconfig` or proxy settings
- Any file containing credentials, even in comments

## Structure

```
omp-bootstrap/
├── AGENTS.md                   # Global behavioral constraints (injected every session)
├── README.md
├── install.sh                  # Bash bootstrap script
├── install.ps1                 # PowerShell bootstrap script
├── config/
│   ├── config.yml              # Agent config (symlinked or copied)
│   └── settings.template.json  # Template only — fill shellPath manually
└── skills/
    └── grill-me/SKILL.md       # Custom skill
```
