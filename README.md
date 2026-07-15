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

- **8 plugins** from the official Claude Code marketplace (security-guidance, commit-commands, code-review, nvidia-skills, ralph-loop, frontend-design, superpowers, playground)
- **7 custom skills**:
  - [storage-analyzer](https://github.com/KKKKhazix/khazix-skills) — disk space analysis with tri-color cleanup (macOS/Windows)
  - [neat-freak](https://github.com/KKKKhazix/khazix-skills) — end-of-session knowledge reconciliation (docs + CLAUDE.md + memory)
  - [pua](https://github.com/tanweai/pua) — productivity pressure system to prevent agent complacency
  - [pdf](https://github.com/anthropics/skills/tree/main/skills/pdf) — PDF generation with proper formatting (Anthropic official)
  - [skill-creator](https://github.com/anthropics/skills/tree/main/skills/skill-creator) — generate custom skills from natural language (Anthropic official)
  - grill-me — relentless interview questioning for design/plan review
  - [frontend-design](https://github.com/anthropics/skills/tree/main/skills/frontend-design) — distinctive UI design direction before code (Anthropic official)
- **Agent config** (theme, TUI, compaction, memory, tool policies)
- **AGENTS.md** — 15-section global behavioral constraints injected every session (engineering principles, Chinese reasoning/bilingual conventions, task discipline, version numbering, Git management, security rules)
## AGENTS.md sections

1. 先思考再编码 — surface assumptions and tradeoffs
2. 简洁优先 — minimum code, no speculation
3. 外科手术式修改 — touch only what's needed
4. 目标驱动执行 — verifiable success criteria
5. 精确引用与区分推断 — cite `file:line`, mark inferences
6. 解释"为什么" — explain reasoning, not just rules
7. 默认怀疑 — hunt over-engineering and omissions
8. 版本号规范 — `A.B.C` semantic versioning
9. 推理深度与效率 — effort proportionality + anti-hallucination
10. 代码质量 — standard library first, existing conventions
11. 任务纪律 — real-time todo updates, no batch-marking
12. Git 仓库管理 — conventional commits, safe push, .gitignore
13. 中文写作规范 — bilingual thinking + typesetting
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
├── AGENTS.md                   # 14-section global behavioral constraints
├── README.md
├── install.sh                  # Bash bootstrap script
├── install.ps1                 # PowerShell bootstrap script
├── config/
│   ├── config.yml              # Agent config (symlinked or copied)
│   └── settings.template.json  # Template — fill shellPath manually
├── extensions/
│   └── pua/                    # PUA OMP extension (failure counter + /pua-* commands)
└── skills/
    ├── frontend-design/SKILL.md # Distinctive UI design (Anthropic official)
    ├── grill-me/SKILL.md       # Design review interview skill
    ├── neat-freak/             # Knowledge reconciliation (full dir with references)
    ├── pdf/SKILL.md            # PDF generation (Anthropic official)
    ├── pua/SKILL.md            # Productivity pressure system
    ├── skill-creator/SKILL.md  # Generate skills from natural language
    └── storage-analyzer/       # Disk space analysis (full dir with scripts + assets)
```
