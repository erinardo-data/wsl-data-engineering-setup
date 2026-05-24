# 01 — WSL2 Setup
> Turning Windows into a professional development workstation.

---

## 🧠 What is WSL2?

**WSL** = Windows Subsystem for Linux.

Unlike simulators such as Git Bash, WSL2 runs a **real Linux kernel**
inside Windows. This guarantees:

- Native performance for data tools (Python, Docker, Spark)
- Full compatibility with cloud production environments
- No need to restart the machine (unlike dual boot)

> **Analogy:** A dual boot is like having two separate bedrooms and needing
> to switch rooms to change systems. WSL2 is having both rooms in the same
> house, connected by a door.

---

## ⚙️ Installation

Run in **PowerShell as Administrator**:

```powershell
# Installs Ubuntu Noble Numbat 24.04
wsl --install -d Ubuntu-24.04
# Lists installed distributions and WSL version
wsl -l -v
# Updates the WSL kernel
wsl --update
# Shuts down the Linux subsystem (clean restart)
wsl --shutdown
```

### Command Token Breakdown:

| Token | Meaning |
|:---|:---|
| `wsl` | Calls the Windows Subsystem for Linux executable |
| `--install` | Flag to install a new distribution |
| `-d Ubuntu-24.04` | `-d` = distro; specifies which distribution to install |
| `-l -v` | `-l` = list; `-v` = verbose (detailed output) |
| `--update` | Updates the WSL kernel to the latest version |
| `--shutdown` | Stops all running Linux processes |

---

## 📂 Important Concept: Where to Store Your Files

```text
✅ ~/projects/          → Linux filesystem (fast)
❌ /mnt/c/Users/...     → Windows filesystem accessed via Linux (slow)
```

Files stored under `~/` are up to **5× faster** for Linux tools.
Always keep your projects inside WSL.

---

## 🔧 Distribution Management

```powershell
wsl -l -v              # lists distros and WSL version (1 or 2)
wsl -d Ubuntu-24.04    # starts a specific distro
wsl ~                  # starts at the Linux home directory
wsl --shutdown         # shuts down all distros
```

---

## 🆚 Ubuntu vs AlmaLinux — When to use each?

| Feature | Ubuntu | AlmaLinux (Red Hat) |
|:---|:---|:---|
| **Package manager** | `apt` | `dnf` |
| **Focus** | Development / Cloud | Critical servers |
| **DE ecosystem** | ✅ Industry standard | ⚠️ Corporate |
| **Documentation** | Abundant | Technical and specific |

> For Data Engineering: **Ubuntu is the market standard.**

---

*Next: [02 — Shell: Zsh + Oh My Zsh](../02-shell-zsh-ohmyzsh/README.md)*
