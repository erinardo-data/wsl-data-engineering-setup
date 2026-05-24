# 08 — Troubleshooting
> Every error was a lesson. Here are the most valuable ones.

---

## 🔴 Error: `Wsl/Service/E_UNEXPECTED`

**Symptom:** WSL freezes or fails to start.
**Cause:** The WSL service crashed on Windows.
**Solution:**

```powershell
# In PowerShell as Administrator:
wsl --shutdown
# If the issue persists, reset the network catalog:
netsh winsock reset
# Restart your computer
```

| Token | Meaning |
|:---|:---|
| `wsl --shutdown` | forces shutdown of all running Linux processes |
| `netsh winsock reset` | restores the Windows network stack to its default state |

---

## 🔴 Error: `externally-managed-environment`

**Symptom:** `pip install` fails with an externally-managed-environment message.
**Cause:** Ubuntu 24.04 enforces PEP 668 — protects the system Python.
**Solution:** Always use a virtual environment.

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install package-name
```

> ✅ Full details at [06 — Python: Virtual Environments](../06-python-venv/README.md)

---

## 🔴 Error: `code: command not found` after `sudo`

**Symptom:** `sudo code .` does not work.
**Cause:** `sudo` resets the PATH, removing the VS Code executable path.
**Solution:** Create a global symbolic link.

```bash
sudo ln -s /mnt/c/Users/YOUR_USERNAME/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code \
           /usr/local/bin/code
```

---

## 🔴 Error: `Permission denied on /tmp` (VS Code Server)

**Symptom:** VS Code cannot create temporary connection files.
**Cause:** Corrupted permissions on `/tmp`.
**Solution:**

```bash
sudo chmod 1777 /tmp
```

---

## 🔴 Error: `git push` rejected — authentication failed

**Symptom:**

```text
remote: Invalid username or token.
fatal: Authentication failed
```

**Cause:** GitHub has not accepted plain passwords since August 2021.
**Solution:** Use a **PAT — Personal Access Token**.

1. github.com → Settings → Developer settings → Tokens (classic)
2. Generate new token → scope: `repo`
3. Use the token as the "password" when running `git push`
4. Configure Git to stop asking for credentials:

```bash
git config --global credential.helper store
```

---

## 🔴 Error: `git push` rejected — non-fast-forward

**Symptom:**

```text
rejected — non-fast-forward
```

**Cause:** GitHub has commits that your local machine does not have
(usually because you checked "Add README" when creating the repository).
**Solution:**

```bash
git pull origin main --rebase
git push
```

| Token | Meaning |
|:---|:---|
| `pull` | downloads and integrates commits from the remote |
| `--rebase` | replays your commits on top of the remote commits (clean history) |

---

## 🟡 Warning: closing the terminal with "X" vs `exit`

| Method | What happens |
|:---|:---|
| Click X | May leave background processes running |
| `exit` or `Ctrl + D` | Clean shutdown — ensures everything has stopped |

> Always prefer `q` (alias for `exit`) or `Ctrl + D`.

---

*Next: [09 — Terminal Screenshots](../09-pics/README.md)*
