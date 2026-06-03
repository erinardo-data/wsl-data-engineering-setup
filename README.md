# 06 — Python, venv & IPython on Ubuntu 24.04 LTS

> **Living document** — updated as the environment evolves.  
> Part of the [`wsl-data-engineering-setup`](https://github.com/erinardo-data/wsl-data-engineering-setup) series.

[![Ubuntu](https://img.shields.io/badge/Ubuntu-24.04_Noble_Numbat-E95420?style=flat&logo=ubuntu&logoColor=white)](https://ubuntu.com/)
[![Python](https://img.shields.io/badge/Python-3.12_|_3.13_|_3.14-3776AB?style=flat&logo=python&logoColor=white)](https://www.python.org/)
[![pipx](https://img.shields.io/badge/pipx-managed-4B8BBE?style=flat&logo=pypi&logoColor=white)](https://pipx.pypa.io/)
[![IPython](https://img.shields.io/badge/IPython-9.14-orange?style=flat&logo=jupyter&logoColor=white)](https://ipython.org/)
[![PEP 668](https://img.shields.io/badge/PEP_668-compliant-brightgreen?style=flat)](https://peps.python.org/pep-0668/)

---

## 📑 Table of Contents

- [The Mental Model](#-the-mental-model)
- [PEP 668 — Why `pip install` fails on Ubuntu 24.04](#-pep-668--why-pip-install-fails-on-ubuntu-2404)
- [Multi-version Python setup](#-multi-version-python-setup)
- [The `_vv` smart activation function](#-the-_vv-smart-activation-function)
- [How shell variables work internally](#-how-shell-variables-work-internally)
- [IPython — treating it as a library](#-ipython--treating-it-as-a-library)
- [Managing IPython versions with pipx](#-managing-ipython-versions-with-pipx)
- [CLI alias architecture](#-cli-alias-architecture)
- [The $PATH monster — and how to prevent it](#-the-path-monster--and-how-to-prevent-it)
- [Socket timeout in automation pipelines](#-socket-timeout-in-automation-pipelines)
- [Troubleshooting](#-troubleshooting)
- [Quick reference](#-quick-reference)

---

## 🧠 The Mental Model

Understanding how virtual environments work on Ubuntu 24.04 requires separating three distinct layers:

```
┌─────────────────────────────────────────────────────────────────┐
│  LAYER 3 — Your project venv (.venv3.12, .venv3.13, .venv3.14) │
│  Isolated per project. pip installs go HERE.                    │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 2 — pipx global tools (IPython, ruff, etc.)             │
│  Isolated per tool. Each tool gets its own hidden venv.         │
├─────────────────────────────────────────────────────────────────┤
│  LAYER 1 — Ubuntu system Python (/usr/bin/python3.x)           │
│  PROTECTED by PEP 668. Direct pip install BLOCKED here.         │
└─────────────────────────────────────────────────────────────────┘
```

A venv is a **terminal-wide mask**, not a folder lock. Activating it rewires `$PATH` for the entire session — the isolation travels with you regardless of which directory you `cd` into.

**The golden rule:**

| Command type | Obeys... |
|---|---|
| `python3`, `pip` | The active venv mask (wherever you `cd`) |
| `cd`, `mkdir`, `rm` | The current directory on disk |

---

## 🔒 PEP 668 — Why `pip install` fails on Ubuntu 24.04

Ubuntu 24.04 Noble Numbat implements **PEP 668 (Externally Managed Environments)**. A marker file called `EXTERNALLY-MANAGED` is injected into the system Python's directory. When `pip` detects it, the operation is aborted immediately.

```
error: externally-managed-environment
╰─> To install Python packages system-wide, try apt install python3-xyz
```

**The decision flow behind every `pip install`:**

```
[ pip install ]
       │
       ▼
¿Active venv?
   ├── NO  ──► Looks for system Python ──► Detects PEP 668 ──► [ BLOCKED ]
   │
   └── YES ──► pyvenv.cfg readable?
                   ├── NO  ──► Scope falls to global ──────────► [ BLOCKED ]
                   └── YES ──► Writes to local site-packages ──► [ SUCCESS ]
```

**You will see this error if:**
- You try `pip install` outside an active venv
- A venv was stacked on top of another without `deactivate` first (corrupting `$PATH` → `pyvenv.cfg` becomes unreachable)
- The venv folder was created incorrectly or is damaged

**The correct tool for each layer:**

| Need | Tool |
|---|---|
| Install packages for a project | `pip install` **inside an active venv** |
| Install CLI tools globally | `pipx install` |
| System packages | `apt install python3-xyz` |

---

## 🐍 Multi-version Python setup

This environment runs **three Python versions simultaneously** via the `deadsnakes` PPA:

```zsh
python3.12 --version   # Python 3.12.3
python3.13 --version   # Python 3.13.13
python3.14 --version   # Python 3.14.5
```

Aliases in `~/.zshrc` provide shorthand access:

```zsh
alias p='python3.12'    # global shorthand → Python 3.12.x
alias p.='python3.13'   # global shorthand → Python 3.13.x
alias p..='python3.14'  # global shorthand → Python 3.14.x
```

> ⚠️ **Using `p`, `p.`, or `p..` inside an active venv will break the bubble.** The alias forces a specific global binary, bypassing the venv's `$PATH` mask. The command executes successfully (Python opens fine without external dependencies), but `pip` loses its local reference — silently falling back to the system global. Use bare `python3` inside venvs.

---

## 🛡️ The `_vv` smart activation function

The `_vv` function automates venv creation and activation. The auto-deactivate guard at the top prevents `$PATH` corruption when switching environments directly.

```zsh
# ~/.zshrc — SECTION 5 — PYTHON & VIRTUAL ENVIRONMENTS  # SECTION 5 - 02/06/2026

_vv() {
    # AUTO-DEACTIVATE: prevents $PATH corruption when stacking venvs
    if [ -n "$VIRTUAL_ENV" ]; then
        deactivate
    fi

    local versao="${1:-12}"
    local pasta_venv=""
    local cmd_python=""

    case "$versao" in
        12) pasta_venv=".venv3.12"; cmd_python="python3.12" ;;
        13) pasta_venv=".venv3.13"; cmd_python="python3.13" ;;
        14) pasta_venv=".venv3.14"; cmd_python="python3.14" ;;
        *) echo "❌ Invalid version. Use: vv, vv. or vv.."; return 1 ;;
    esac

    if [ ! -d "$pasta_venv" ]; then
        echo "🔧 Creating isolated virtual environment for Python 3.${versao}..."
        $cmd_python -m venv "$pasta_venv"
    fi

    source "${pasta_venv}/bin/activate"
    echo "🛡️  Virtual environment Python 3.${versao} ($pasta_venv) activated."
}

alias vv='_vv 12'     # activates/creates .venv3.12
alias vv.='_vv 13'    # activates/creates .venv3.13
alias vv..='_vv 14'   # activates/creates .venv3.14
```

**Safe switching — no `deactivate` needed:**

```zsh
vv      # activate .venv3.12
vv.     # auto-deactivates 3.12 → cleanly activates .venv3.13
vv..    # auto-deactivates 3.13 → cleanly activates .venv3.14
```

**Why this matters:** Without the guard, each `source activate` captures the *already-modified* `$PATH` as the "original to restore." Stacking activations injects `.venv/bin` paths multiple times. The Zsh command hash cache breaks — `pip` loses its reference and falls back to the system global, hitting PEP 668.

---

## ⚙️ How shell variables work internally

When you run `source .venv/bin/activate`, the script performs a priority-prefix concatenation on `$PATH`:

```bash
PATH="/home/youruser/project/.venv/bin:$PATH"
```

This guarantees that typing `python3` finds the venv binary *before* `/usr/bin/python3`. Zsh also maintains a **command hash cache** for speed — it indexes binaries found during `$PATH` scans to avoid re-scanning every call.

When `$PATH` is corrupted by stacked activations (13 repeated entries of `.local/bin`), the hash cache breaks its integrity map. `pip` and `python3` resolve inconsistently — sometimes hitting the local venv, sometimes the system global. This is why the error can appear even with the correct venv prefix in your prompt.

---

## 📦 IPython — treating it as a library

> **Key insight:** IPython is not a standalone application. It is a Python package — published on PyPI, installed via `pip`, stored in `site-packages` — exactly like `pandas` or `requests`.

This distinction drives everything:

```zsh
# IPython is a library — install it like any other package
pip install ipython

# Call it as a module of the active Python interpreter
python3 -m IPython     # ✅ no warning, no conflict
```

The `-m` flag tells Python: *"search your own `site-packages` for a module named `IPython` and execute its `__main__`."* The interpreter and the library share the same root — no path conflicts possible.

**Why the bare `ipython` command can fail inside a venv:**

```
UserWarning: Attempting to work in a virtualenv.
If you encounter problems, please install IPython inside the virtualenv.
```

This warning fires when the `ipython` binary resolved by `$PATH` comes from a different Python environment (e.g. pipx) than the active venv. IPython has an internal check at startup: *"Does my executable path match `$VIRTUAL_ENV`?"* — if not, it warns. Python's own interpreter doesn't do this check, so the bubble breaks silently.

**IPython inside a venv — correct workflow:**

```zsh
vv                    # activate venv
pip install ipython   # install the library INTO the venv (one-time per venv)
ip                    # → alias: python3 -m IPython → no warning
```

---

## 🔧 Managing IPython versions with pipx

For **global** IPython access (outside any venv), Ubuntu 24.04 requires `pipx`. Direct global `pip install` is blocked by PEP 668.

pipx tools can also float to newer Python engines on system updates. To pin a specific version:

```zsh
# Create one IPython instance per Python version, pinned explicitly
pipx install ipython --python python3.12 --suffix=12 --force
# Creates: ipython12, ipython312

pipx install ipython --python python3.13 --suffix=_3.13 --force
# Creates: ipython_3.13, ipython3_3.13

pipx install ipython --python python3.14 --suffix=_3.14 --force
# Creates: ipython_3.14, ipython3_3.14

# Audit all global tools
pipx list
```

**`--suffix` spacing rule — easy to get wrong:**

```zsh
# ✅ Correct — no space around =
pipx install ipython --python python3.12 --suffix=12 --force

# ❌ Wrong — zsh interprets "12" as a separate command
pipx install ipython --python python3.12 --suffix =12 --force
# → zsh: 12 not found
```

**Why global tools drift:** pipx rebuilds tool environments using the highest-priority Python it finds. When `python3.13` became available on this machine, the generic `ipython` global was rebuilt under 3.13, breaking the existing alias that expected 3.12. The `--suffix` flag creates a versioned binary (`ipython12`) that never drifts.

---

## 🎛️ CLI alias architecture

Full alias block for `~/.zshrc`:

```zsh
# ===========================================================================
# 5. ALIASES — PYTHON & VIRTUAL ENVIRONMENTS        # SECTION 5 - 02/06/2026
# ===========================================================================

# Python interpreters — global shortcuts
alias p='python3.12'     # global shorthand → Python 3.12.x
alias p.='python3.13'    # global shorthand → Python 3.13.x
alias p..='python3.14'   # global shorthand → Python 3.14.x

# GLOBAL IPython — use ONLY when OUTSIDE any active venv
alias ipg="ipython12"          # IPython via pipx — Python 3.12 engine
alias ipg.="ipython"           # IPython via pipx — Python 3.13 engine (default)
alias ipg..="ipython_3.14"     # IPython via pipx — Python 3.14 engine

# LOCAL IPython — use ONLY when a venv is ACTIVE
# ⚠️  Run 'pip install ipython' inside the venv before first use
alias ip="python3 -m IPython"    # IPython from active venv — dynamic engine
alias ip.="python3 -m IPython"   # IPython from active venv — dynamic engine
alias ip..="python3 -m IPython"  # IPython from active venv — dynamic engine
```

**Why `ip`, `ip.`, and `ip..` share the same command:**

All three expand to `python3 -m IPython`. `python3` resolves dynamically to whichever venv is currently active. The venv controls the version — not the alias. If `.venv3.14` is active, `ip` opens Python 3.14. If `.venv3.12` is active, `ip` opens Python 3.12.

| Context | Command | Engine |
|---|---|---|
| Outside venv | `ipg` | Python 3.12 (pipx) |
| Outside venv | `ipg.` | Python 3.13 (pipx) |
| Outside venv | `ipg..` | Python 3.14 (pipx) |
| Inside `vv` (.venv3.12) | `ip` / `ip.` / `ip..` | Python 3.12 (local lib) |
| Inside `vv.` (.venv3.13) | `ip` / `ip.` / `ip..` | Python 3.13 (local lib) |
| Inside `vv..` (.venv3.14) | `ip` / `ip.` / `ip..` | Python 3.14 (local lib) |

---

## 🐉 The `$PATH` monster — and how to prevent it

**What a corrupted `$PATH` looks like:**

```
/home/youruser/.local/bin:/home/youruser/.local/bin:/home/youruser/.local/bin
:/home/youruser/.local/bin: ... (×13) ... :/usr/bin:/sbin:/bin
```

**Root cause:** Each `source activate` call saves the current `$PATH` as the "original." Stack activations without `deactivate` and each call snapshots an already-polluted path. The Zsh command hash cache loses integrity; `pip` resolves to the system global; PEP 668 fires.

**Diagnose:**

```zsh
echo $PATH | tr ':' '\n' | sort | uniq -d
# Lists all duplicated PATH entries
```

**Prevent:** The `_vv` auto-deactivate guard (see above) eliminates this completely. It always calls `deactivate` before a new `source activate`, ensuring `$PATH` is clean.

**Emergency reset (already corrupted session):**

```zsh
deactivate
exec zsh       # restart shell process — preferred over closing the terminal
```

---

## 🌐 Socket timeout in automation pipelines

When building data pipelines that depend on external servers, proxies, or package registries, a socket timeout prevents infinite blocking if a connection stalls.

```python
import requests

try:
    response = requests.get("https://api.example.com/data", timeout=15)
except requests.exceptions.Timeout:
    print("Connection timed out — retrying or failing gracefully")
```

For `pip` in CI/CD pipelines:

```zsh
# Flag-based (per command)
pip install pandas --timeout 5 --retries 3

# Environment variable (session-wide — cleaner for automation)
export PIP_TIMEOUT=5
pip install pyspark
pip install ipython
```

The `--retries` flag adds resilience: if the socket times out, `pip` reattempts up to N times before breaking the pipeline — useful when package registries or corporate proxies have transient failures.

---

## 🛠️ Troubleshooting

### `error: externally-managed-environment` inside an active venv

The venv's `pyvenv.cfg` is missing or `pip` is not resolving to the venv's copy.

```zsh
which pip
# Expected: /path/to/project/.venv3.12/bin/pip
# If it returns /usr/bin/pip → the bubble is broken

# Fix: delete and recreate
deactivate
rm -rf .venv3.12
vv               # _vv recreates cleanly
pip install ipython
```

### `zsh: command not found: python`

Ubuntu 24.04 does not create a `python` symlink — only `python3`. Aliases using bare `python` will fail inside venvs.

```zsh
# ❌ Breaks on Ubuntu 24.04
alias ip="python -m IPython"

# ✅ Correct
alias ip="python3 -m IPython"
```

### `defining function based on alias 'ip'`

A live `alias ip=...` in session memory (or above the function in `~/.zshrc`) prevents defining a function with the same name. Zsh cannot redefine an alias as a function without clearing it first.

```zsh
unalias ip 2>/dev/null
unalias ip. 2>/dev/null
unalias ip.. 2>/dev/null
source ~/.zshrc
```

### IPython `UserWarning: Attempting to work in a virtualenv`

The `ipython` binary came from pipx, not from the active venv.

```zsh
# Inside a venv — always use the module form
python3 -m IPython     # ✅ no warning
```

### `pipx install --suffix` fails with `zsh: N not found`

Space before the number: `--suffix =12` → zsh splits at the space. Use `--suffix=12` (no space).

### `$PATH` corrupt after session

```zsh
exec zsh       # restart shell cleanly
vv             # reactivate venv
which pip      # verify it points to .venv/bin/pip
```

---

## ⚡ Quick reference

```zsh
# Venv lifecycle
vv              # create/activate .venv3.12
vv.             # create/activate .venv3.13
vv..            # create/activate .venv3.14
deactivate      # exit active venv

# Install packages (always inside an active venv)
pip install pandas ipython pyspark
pip install --upgrade pip

# IPython — local (inside venv)
pip install ipython   # one-time per venv
ip                    # open IPython from active venv

# IPython — global (outside venv)
ipg                   # Python 3.12 engine
ipg.                  # Python 3.13 engine
ipg..                 # Python 3.14 engine

# Diagnostics
which pip                                    # verify pip belongs to active venv
which python3                                # verify interpreter
echo $VIRTUAL_ENV                            # confirm active venv path
echo $PATH | tr ':' '\n' | sort | uniq -d   # detect $PATH duplicates
pipx list                                    # show all global tool installations
```

---

← [05 — CLI Commands](../05-cli-commands/README.md) | [07 — User Management](../07-user-management/README.md) →

---

<div align="center">

**Part of [`wsl-data-engineering-setup`](https://github.com/erinardo-data/wsl-data-engineering-setup)**  
Corrections and improvements are always welcome — open an issue or a pull request.

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=flat&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/erinardo-araujo-682347295/)
[![GitHub](https://img.shields.io/badge/GitHub-Follow-181717?style=flat&logo=github&logoColor=white)](https://github.com/erinardo-data)

</div>
