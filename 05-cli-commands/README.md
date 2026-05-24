# 05 — Essential CLI Commands
> The terminal is your primary tool. Master it before anything else.

---

## 🧭 Navigation

```bash
pwd              # Print Working Directory — shows where you are
ls               # list files (with alias: eza --icons)
ll               # detailed list with permissions and sizes
la               # list including hidden files (. and ..)
cd ~             # go to Home (your "home base")
cd ..            # go up one level (exit current folder)
cd -             # return to the previous directory
a                # alias: eza --icons --tree (folder tree view)
```

### Identity Diagnostics

```bash
whoami           # "Who am I right now?" — displays current user
id               # shows UID, GID, and user groups
w                # shows who is logged in and what they are doing
```

---

## 📂 File and Directory Management

```bash
mkdir folder_name         # creates a directory
mkdir -p a/b/c            # creates full hierarchy in one shot
touch file.txt            # creates an empty file (or updates timestamp)
cp -i source dest         # copy — -i prompts before overwriting
mv -i source dest         # move or rename — -i prompts before replacing
rm -i file                # remove — -i asks for confirmation (safer)
rm -rf folder/            # removes entire folder — ⚠️ no confirmation
cat file.txt              # displays file content in the terminal
cat file | head -10       # displays only the first 10 lines
cat file | tail -10       # displays only the last 10 lines
```

> ⚠️ **Never use `rm -rf` without being absolutely sure of the path.**
> There is no recycle bin in the Linux terminal.

---

## ⌨️ Keyboard Shortcuts (GNU Readline)

| Shortcut | What it does |
|:---|:---|
| `Ctrl + U` | Deletes from cursor to the **beginning** of the line |
| `Ctrl + K` | Deletes from cursor to the **end** of the line |
| `Ctrl + W` | Deletes the **previous word** before the cursor |
| `Ctrl + Y` | Pastes text deleted by the shortcuts above |
| `Ctrl + R` | Interactive search through command **history** |
| `Ctrl + L` | Clears the screen (equivalent to `clear`) |
| `Ctrl + C` | Cancels the current command |
| `Ctrl + D` | Exits the terminal (equivalent to `exit`) |

---

## 🔧 System Maintenance

```bash
sudo apt update              # refreshes the list of available packages
sudo apt upgrade             # installs available updates
sudo apt install program     # installs a new package
sudo apt remove program      # removes a package
```

---

## 📋 Exit Codes

| Code | Meaning |
|:---|:---|
| `0` | ✅ Full success |
| `1` | ❌ Generic error |
| `130` | ⚠️ Interrupted by user (`Ctrl + C`) |

```bash
# Check the exit code of the last command:
echo $?
```

---

## 📝 Terminal Editors

| Tool | Command | Characteristics |
|:---|:---|:---|
| **Nano** | `nano file.txt` | Simple, shortcuts visible on screen |
| **Vim** | `vim file.txt` | Powerful, steep learning curve |
| **VS Code** | `code .` | Graphical interface, requires WSL extension |

> For beginners: **nano** is the right choice.
> `Ctrl + O` to save · `Ctrl + X` to exit

---

*Next: [06 — Python: Virtual Environments](../06-python-venv/README.md)*
