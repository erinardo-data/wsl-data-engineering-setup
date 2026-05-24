
# 03 — VS Code + WSL Integration
> Editing Linux files directly from Windows, without friction.

---

## 🔌 The Problem Without the Extension

Without native integration, VS Code treats WSL as a remote network.
Editing files via `/mnt/c/` or UNC path (`\\wsl$\...`) is slow and unstable.

**Solution:** Microsoft's official **WSL** extension.

---

## 🚀 Installation

1. Open VS Code on Windows
2. `Ctrl + Shift + X` → search for **WSL**
3. Install the Microsoft extension (penguin icon)
4. Restart VS Code

---

## 💻 Usage — Opening Projects

```bash
# From any folder in the Linux terminal:
code .
```

| Token | Meaning |
|:---|:---|
| `code` | Calls the VS Code executable |
| `.` | Dot = current directory — opens this folder as the workspace |

VS Code will open with `WSL: Ubuntu` in the bottom-left corner,
indicating it is connected to the Linux filesystem.

---

## 🔧 Fix: `code` not found after `sudo`

`sudo` resets the user's `PATH`. Solution using a global symbolic link:

```bash
sudo ln -s /mnt/c/Users/YOUR_USERNAME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code \
           /usr/local/bin/code
```

| Token | Meaning |
|:---|:---|
| `ln -s` | *link* with `-s` flag = symbolic (shortcut) |
| `/mnt/c/...` | Path to the Windows executable accessed from Linux |
| `/usr/local/bin/code` | Global destination — accessible by any user |
| `\` | Line continuation (the command continues below) |

---

## 🛑 Connection Troubleshooting

If the `><` button (bottom-left corner) freezes:

```powershell
# In PowerShell (Windows):
wsl --shutdown
# Then reopen VS Code
```

**Permission denied on `/tmp` (VS Code Server):**

```bash
sudo chmod 1777 /tmp
```

| Token | Meaning |
|:---|:---|
| `chmod 1777` | Restores `/tmp` permissions with the *sticky bit* |
| `1777` | Read+write+execute for all + sticky bit (prevents deletion by others) |

---

## ⚙️ Exit Behavior (Windows Terminal)

Configure what happens when the Linux process ends:
`Settings → Ubuntu Profile → Advanced → Exit behavior`

| Option | Recommendation |
|:---|:---|
| Automatic | Default — closes if process ends normally |
| **Close on success only** | ✅ **Recommended** — keeps window open on error |
| Never close | Useful for intensive debugging |

---

*Next: [04 — Productivity Aliases](../04-productivity-aliases/README.md)*
