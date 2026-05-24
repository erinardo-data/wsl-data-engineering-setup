# 07 — User Management & Permissions
> Understanding the Linux hierarchy and how to safely navigate between identities.

---

## 🏗️ The Linux Filesystem Hierarchy

```text
/ (Absolute Root)
│  → The entire building. Access restricted to root.
│
├── /home (Residents' Hallway)
│   └── /home/youruser (Your Apartment)
│       → Your personal files. Full freedom here.
│
└── /mnt/c (Windows Integration)
    → Accesses your C: drive from Linux.
    → Slower than ~/
```

---

## 👥 User Management Commands

```bash
# Create a new user
sudo adduser username
```

| Token | Meaning |
|:---|:---|
| `sudo` | runs as administrator (superuser do) |
| `adduser` | creates a user with a home directory and default settings |

```bash
# Grant administrator privileges (sudo)
sudo usermod -aG sudo username
```

| Token | Meaning |
|:---|:---|
| `usermod` | modifies settings of an existing user |
| `-aG` | `-a` = append (add without removing other groups); `-G` = group |
| `sudo` | name of the group that grants administrator privileges |

```bash
# Switch to another user (with full environment)
sudo -u username -i
```

| Token | Meaning |
|:---|:---|
| `-u username` | specifies which user to switch to |
| `-i` | *simulate initial login* — loads the user's home and shell settings |

---

## 🔐 Permissions — Decoding `drwxr-xr-x`

```text
d  rwx  r-x  r-x
│   │    │    │
│   │    │    └── Others: read + execute
│   │    └─────── Group:  read + execute
│   └──────────── Owner:  read + write + execute
└──────────────── Type:   d = directory, - = file
```

| Letter | Permission | Numeric value |
|:---|:---|:---|
| `r` | read | 4 |
| `w` | write | 2 |
| `x` | execute | 1 |
| `-` | no permission | 0 |

```bash
# Practical examples:
chmod 755 script.sh    # owner: all; group and others: read + execute
chmod 644 config.txt   # owner: read + write; group and others: read only
chmod 1777 /tmp        # sticky bit — prevents others from deleting your files
```

---

## 🔍 Identity Diagnostics

```bash
whoami    # current user
id        # UID, GID, and all groups
w         # who is logged in and what they are doing
groups    # lists the current user's groups
```

---

## ⚠️ sudo vs root — What is the difference?

| | sudo | direct root |
|:---|:---|:---|
| **How to use** | `sudo command` | `su -` |
| **Risk** | Low — command by command | High — full session as root |
| **Traceability** | Logged in `/var/log/auth.log` | No per-user tracking |
| **Recommendation** | ✅ Always prefer | ❌ Avoid in production |

---

*Next: [08 — Troubleshooting](../08-troubleshooting/README.md)*
