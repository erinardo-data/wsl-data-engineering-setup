<!--
  Repository  : wsl-data-engineering-setup
  Author      : github.com/youruser          ← replace with your GitHub handle
  Purpose     : Public documentation of a journey from a vanilla Windows
                machine to a professional Data Engineering environment
                using WSL2, Ubuntu Noble Numbat 24.04 and a curated stack.
-->

<div align="center">

# 🐧 WSL Data Engineering Setup

### From Zero to a Professional Linux Environment on Windows

*A documented journey of configuring a real-world development stack for Data Engineering —
using WSL2, Ubuntu Noble Numbat, Zsh, VS Code, Python, and a personal terminal grimoire.*

![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04_Noble_Numbat-E95420?style=flat&logo=ubuntu&logoColor=white)
![WSL](https://img.shields.io/badge/WSL-2-0078D4?style=flat&logo=windows&logoColor=white)
![Zsh](https://img.shields.io/badge/Shell-Zsh-1A2C34?style=flat&logo=gnu-bash&logoColor=white)
![Python](https://img.shields.io/badge/Python-3.11+-3776AB?style=flat&logo=python&logoColor=white)
![VS Code](https://img.shields.io/badge/Editor-VS_Code-007ACC?style=flat&logo=visualstudiocode&logoColor=white)
![Status](https://img.shields.io/badge/Status-Living_Document-brightgreen?style=flat)

</div>

---

## 📖 Why This Repository Exists

I am transitioning into Data Engineering. Setting up a robust, reproducible development
environment was the foundation I needed before touching pipelines, warehouses, or AI systems.

This repository is a **living record** of every decision, command, and small victory along
the way — not a polished tutorial. The goal is twofold:

- **Personal** — a future reference I can return to when something breaks
- **Public** — a transparent log of the learning process for anyone walking a similar path

---

## 📁 Repository Structure

Each folder is a standalone module. You can jump directly to what you need.

```
wsl-data-engineering-setup/
├── 00-visao-geral/         # Why this setup matters + complete stack overview
├── 01-wsl2-setup/          # WSL2 installation and core concepts
├── 02-shell-zsh-ohmyzsh/   # Zsh + Oh My Zsh configuration + .zshrc example
├── 03-vscode-integration/  # VS Code + WSL extension setup
├── 04-aliases-produtividade/ # Productivity aliases + ready-to-use aliases.sh
├── 05-cli-commands/        # Navigation, file ops, keyboard shortcuts
├── 06-python-venv/         # Python virtual environments + PEP 668 explained
├── 07-user-management/     # Users, permissions, sudo
├── 08-troubleshooting/     # Common issues and solutions
└── 09-pics/                # Terminal screenshots
```

---

## 📑 Quick Navigation

1. [The Stack](#-the-stack)
2. [WSL2 Setup](./01-wsl2-setup/README.md)
3. [Shell Configuration](./02-shell-zsh-ohmyzsh/README.md)
4. [VS Code Integration](./03-vscode-integration/README.md)
5. [Productivity Aliases](./04-aliases-produtividade/README.md)
6. [Essential CLI Commands](./05-cli-commands/README.md)
7. [Python Virtual Environments](./06-python-venv/README.md)
8. [User Management & Permissions](./07-user-management/README.md)
9. [Troubleshooting](./08-troubleshooting/README.md)

---

## 🧱 The Stack

| Layer | Tool | Purpose |
| :--- | :--- | :--- |
| **Host OS** | Windows 11 | Daily driver |
| **Subsystem** | WSL2 | Real Linux kernel inside Windows |
| **Distro** | Ubuntu 24.04 Noble Numbat | Industry standard for Data Engineering |
| **Terminal** | Windows Terminal | Tabs, profiles, copy/paste |
| **Shell** | Zsh + Oh My Zsh | Productivity and visual polish |
| **Editor** | VS Code + WSL extension | Native Linux file editing from Windows |
| **Language** | Python 3.11+ | Primary DE language |
| **Versioning** | Git + GitHub | Conventional Commits workflow |

---

## ⚙️ WSL2 — Quick Start

WSL2 runs a real Linux kernel inside Windows — not a simulator.
This means native performance for development tools used in production environments.

```powershell
# In PowerShell (Administrator)
wsl --install -d Ubuntu-24.04   # installs Ubuntu Noble Numbat
wsl -l -v                       # lists distros and WSL version
wsl --update                    # updates the WSL kernel
wsl --shutdown                  # forces a clean restart of WSL
```

> 📂 **Key concept:** files stored in the Linux home directory (`~/`) are significantly
> faster than files accessed via `/mnt/c/`. Keep your projects on the Linux side.

Full details → [01-wsl2-setup/README.md](./01-wsl2-setup/README.md)

---

## 🎨 Shell — Zsh + Oh My Zsh

Switching from Bash to Zsh + Oh My Zsh delivers visual feedback, autocompletion,
and a clean prompt out of the box.

```bash
sudo apt update && sudo apt install zsh -y
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)
```

**Theme:** `robbyrussell` — the classic `➜` prompt. Simple, fast, never gets in the way.
**Font:** Fira Code Nerd Font for proper icon and ligature rendering in Windows Terminal.

Full details + `.zshrc` example → [02-shell-zsh-ohmyzsh/README.md](./02-shell-zsh-ohmyzsh/README.md)

---

## ⚡ Productivity Aliases

Custom aliases live in `~/.zshrc`. A selection of the most useful ones:

```bash
# Modern file listing with icons (requires eza)
alias ls='eza --icons'
alias ll='eza --icons -lh'
alias la='eza --icons -a'
alias t='eza --icons --tree'

# Deep clear: clears scrollback buffer too
alias c='clear && printf "\033[3J"'

# Master shortcut: edit .zshrc and auto-reload on exit
alias n='nano +999 "$HOME/.zshrc" && source "$HOME/.zshrc"'

# Personal grimoire: interactive command-reference panel
# Adjust the path below to match your own scripts location
alias g='python3 ~/scripts/grimoire.py'   # ← update to your path

# Clean exit
alias q='exit'
```

> 💡 The `n` alias already runs `source ~/.zshrc` automatically on exit.
> No need to reload manually after editing with `n`.

Full details + ready-to-use file → [04-aliases-produtividade/README.md](./04-aliases-produtividade/README.md)

---

## 🐍 Python Virtual Environments

Ubuntu 24.04 enforces **PEP 668** — installing packages with `pip` outside a virtual
environment will fail with `externally-managed-environment`. This is a safety feature.

```bash
sudo apt install python3-venv -y          # one-time setup
python3 -m venv .venv                     # create environment
source .venv/bin/activate                 # activate
pip install pandas requests               # install packages safely
pip freeze > requirements.txt             # save for reproducibility
deactivate                                # exit when done
```

Full details → [06-python-venv/README.md](./06-python-venv/README.md)

---

## 🚀 Roadmap

- [x] WSL2 + Ubuntu Noble Numbat configured
- [x] Zsh + Oh My Zsh with productive aliases
- [x] VS Code fully integrated with WSL
- [x] Python virtual environments working cleanly
- [x] Personal terminal grimoire as a quick-reference panel
- [x] Git + GitHub with Conventional Commits
- [ ] Docker Desktop + WSL backend
- [ ] PostgreSQL + pgvector locally
- [ ] First ETL pipeline (CSV → BigQuery)
- [ ] GitHub Actions CI/CD for data projects

---

## 🤝 Contributing

This is a personal learning repository. Corrections, suggestions, and improvements
are always welcome — open an issue or a pull request.

---

<div align="center">

**Documented by a Data Engineering professional in transition — 2026**

*Built with patience, curiosity, and a lot of `wsl --shutdown`.*

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/erinardo-araujo-682347295/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github&logoColor=white)](https://github.com/erinardo-data)

</div>
