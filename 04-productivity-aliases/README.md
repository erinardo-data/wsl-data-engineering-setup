# 04 — Productivity Aliases
> Shortcuts that turn long commands into single-syllable words.

---

## 🧠 What is an Alias?

An alias is a **nickname** for a long command.
Instead of typing `eza --icons -lh` every time, you type `ll`.

> **Analogy:** It is like saving a contact on your phone.
> You do not dial the full number — you tap the name.

---

## 📂 Where do Aliases live?

In the `~/.zshrc` file. Loaded automatically every time you open a terminal.

```bash
# To edit and auto-reload:
n      # alias: nano +999 ~/.zshrc && source ~/.zshrc
```

---

## ⚡ Active Aliases

### Modern listing (requires `eza`)

```zsh
alias ls='eza --icons'           # list with icons
alias ll='eza --icons -lh'       # detailed list with human-readable sizes
alias la='eza --icons -a'        # includes hidden files (. and ..)
alias a='eza --icons --tree'     # directory tree (a = árbol/tree)
```

### Clearing and navigation

```zsh
alias c='clear && printf "\033[3J"'   # clears screen AND the scroll buffer
alias q='exit'                         # clean exit
alias ..='cd ..'                       # go up one level
```

### Configuration editing

```zsh
# Opens .zshrc at the last line and reloads on exit
alias n='nano +999 "$HOME/.zshrc" && source "$HOME/.zshrc"'
# Opens .nanorc to configure the nano editor
alias nn='nano "$HOME/.nanorc"'
```

> ⚠️ **Important:** the `n` alias already runs `source` automatically on exit.
> Never run `source ~/.zshrc` separately after using `n`.

### Grimoire (personal reference panel)

```zsh
alias g='python3 ~/scripts/grimoire.py'    # opens the interactive panel
alias gg='nano ~/scripts/grimoire.py'      # edits the grimoire
```

---

## 📊 Quick Reference Table

| Alias | Full command | What it does |
|:---|:---|:---|
| `ls` | `eza --icons` | List with icons |
| `ll` | `eza --icons -lh` | Detailed list |
| `la` | `eza --icons -a` | List including hidden files |
| `a` | `eza --icons --tree` | Directory tree |
| `c` | `clear && printf "\033[3J"` | Full screen clear |
| `n` | `nano +999 ~/.zshrc && source` | Edit + reload .zshrc |
| `nn` | `nano ~/.nanorc` | Edit nano settings |
| `q` | `exit` | Exit terminal |
| `g` | `python3 ~/scripts/grimoire.py` | Open grimoire |
| `gg` | `nano ~/scripts/grimoire.py` | Edit grimoire |

---

## 🔧 How to create a new alias

1. Open `.zshrc` with `n`
2. Navigate to the aliases section
3. Add: `alias myalias='full command'`
4. Save — the reload happens automatically

---

*Next: [05 — Essential CLI Commands](../05-cli-commands/README.md)*
