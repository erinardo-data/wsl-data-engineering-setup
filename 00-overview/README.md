# 00 — Overview
> Why set up a Linux environment before touching data?

---

## 🎯 The Goal

Before pipelines, warehouses, or AI models, there is an invisible foundation:
the development environment. This repository documents every decision made
to transform an ordinary Windows machine into a professional Data Engineering environment.

---

## 🧱 The Data Engineering "Golden Stack"

For maximum productivity and compatibility with production environments:

| Layer | Tool | Role |
|:---|:---|:---|
| **Backend** | WSL2 + Ubuntu 24.04 | Real Linux kernel inside Windows |
| **Shell** | Zsh + Oh My Zsh | Smart, productive, and visually polished terminal |
| **Terminal** | Windows Terminal | Manages Ubuntu, PowerShell, and CMD tabs |
| **Editor** | VS Code + WSL extension | Native editing on the Linux filesystem |
| **Language** | Python 3.11+ | Primary Data Engineering language |
| **Versioning** | Git + GitHub | History, portfolio, and collaboration |

---

## 🔑 Core Concept

### WSL2 ≠ Simulator

WSL2 runs a **real Linux kernel** inside Windows.
This means native performance for tools used in production servers.

> **Analogy:** Think of it as having a fully equipped apartment inside a house.
> You are not "simulating" living in the apartment — you actually live there.

### Why Ubuntu Noble Numbat?

- Industry standard for modern development and cloud environments
- LTS (Long-Term Support) until 2029
- Compatible with Docker, GCP, AWS, and Databricks
- `apt` package manager — the most documented in the ecosystem

---

## 📁 What Each Folder Contains

```text
wsl-data-engineering-setup/
├── 00-overview/              ← you are here
├── 01-wsl2-setup/            ← WSL2 installation and core concepts
├── 02-shell-zsh-ohmyzsh/     ← productive terminal with Zsh
├── 03-vscode-integration/    ← VS Code connected to Linux
├── 04-productivity-aliases/  ← shortcuts that save hours
├── 05-cli-commands/          ← essential terminal commands
├── 06-python-venv/           ← isolated and safe Python environments
├── 07-user-management/       ← users, permissions, and sudo
├── 08-troubleshooting/       ← common issues and solutions
└── 09-pics/                  ← environment screenshots
```

---

*Documented during the transition journey into Data Engineering — 2026*

*Next: [01 — WSL2 Setup](../01-wsl2-setup/README.md)*
