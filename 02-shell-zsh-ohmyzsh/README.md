# 02 — Shell: Zsh + Oh My Zsh
> Moving from a plain terminal to a productive, visually polished environment.

---

## 🎨 Why switch from Bash to Zsh?

**Bash** is the default shell on most Linux distributions.
**Zsh** (Z Shell) is a modern evolution that offers:

- Smart tab completion
- History-based command suggestions
- Visual themes via Oh My Zsh
- Plugins for Git, Python, Docker, and more

> **Analogy:** Bash is a basic car that gets the job done.
> Zsh + Oh My Zsh is the same car with GPS, a rear camera, and a digital dashboard.

---

## 🚀 Installation

```bash
# 1. Updates repositories and installs Zsh
sudo apt update && sudo apt install zsh -y
# 2. Installs Oh My Zsh (theme and plugin framework)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# 3. Sets Zsh as the default shell
chsh -s $(which zsh)
```

### Command Token Breakdown:

| Token | Meaning |
|:---|:---|
| `sudo` | *superuser do* — runs with administrator privileges |
| `apt update` | refreshes the list of available packages |
| `apt install zsh -y` | installs Zsh; `-y` auto-confirms the prompt |
| `&&` | runs the next command only if the previous one succeeded |
| `curl -fsSL` | downloads the script; `-f` fail silently, `-s` silent, `-L` follow redirects |
| `chsh -s` | *change shell* — sets the user's default shell |
| `$(which zsh)` | `which` finds the executable path; `$()` executes and substitutes |

---

## 🎨 Theme and Font

**Theme in use:** `robbyrussell`

The classic `➜` prompt with color highlights. Simple, fast, never gets in the way.

**Configuration in `~/.zshrc`:**

```zsh
ZSH_THEME="robbyrussell"
```

**Font:** Fira Code Nerd Font

Essential for rendering icons (🐧) and ligatures (`!=` → `≠`) in the terminal.
Configure in Windows Terminal: *Settings → Ubuntu Profile → Appearance → Font*.

---

## ⚙️ Configuration File: `~/.zshrc`

The `.zshrc` is the "brain" of your Zsh — loaded every time you open a terminal.
It holds your theme, plugins, aliases, and environment variables.

```bash
# Opens and auto-reloads on exit
n       # custom alias: nano +999 ~/.zshrc && source ~/.zshrc
```

> ⚠️ The `n` alias already runs `source ~/.zshrc` automatically on exit.
> Never need to run `source` separately after using `n`.

---

## 🔌 Useful Plugins (Oh My Zsh)

```zsh
# In ~/.zshrc:
plugins=(git python pip docker)
```

| Plugin | What it adds |
|:---|:---|
| `git` | Aliases like `gst` (git status), `gco` (checkout), `gp` (push) |
| `python` | Auto-activates venv when entering the project folder |
| `pip` | Package name autocompletion for pip |

---

*Next: [03 — VS Code + WSL](../03-vscode-integration/README.md)*
