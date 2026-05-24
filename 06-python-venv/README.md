**This is not a bug.** It is a protection introduced by PEP 668 in Ubuntu 24.04.

> **Analogy:** Think of it as a building that does not allow you to renovate your
> apartment without authorization. You create an isolated workspace (venv) to install
> whatever you need, without touching the shared parts of the system.

---

## 🐍 What is a Virtual Environment?

A `.venv` is an **isolated copy of Python** inside your project folder.
Packages installed in it do not affect the system or other projects.

---

## 🚀 Full Workflow

```bash
# 1. Install venv support (once per system)
sudo apt install python3-venv -y
```

| Token | Meaning |
|:---|:---|
| `sudo` | runs as administrator |
| `apt install` | installs a package via the APT package manager |
| `python3-venv` | module that enables virtual environment creation |
| `-y` | auto-confirms all prompts (yes to all) |

```bash
# 2. Create the virtual environment in your project folder
python3 -m venv .venv
```

| Token | Meaning |
|:---|:---|
| `python3` | calls the Python 3 interpreter |
| `-m venv` | runs the `venv` module as a script |
| `.venv` | environment folder name (dot = hidden by convention) |

```bash
# 3. Activate the environment
source .venv/bin/activate
```

| Token | Meaning |
|:---|:---|
| `source` | runs the script in the current shell (not a subprocess) |
| `.venv/bin/activate` | script that modifies PATH to use this Python |

> After activating, the prompt will show `(.venv)` at the beginning.

```bash
# 4. Install packages inside the environment (no errors)
pip install pandas requests
# 5. Save dependencies for reproducibility
pip freeze > requirements.txt
# 6. Deactivate when done
deactivate
```

---

## 📌 Best Practices

```bash
# .gitignore should always include:
.venv/
__pycache__/
*.pyc
```

> Never version the `.venv/` folder — it is recreatable and adds unnecessary weight.
> Version only the `requirements.txt`.

---

## 🔄 Reproducing the Environment on Another Machine

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

*Next: [07 — User Management](../07-user-management/README.md)*
