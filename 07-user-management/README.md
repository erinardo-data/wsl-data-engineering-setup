# 07 — Gestão de Usuários e Permissões

> Entendendo a hierarquia do Linux e como navegar com segurança entre identidades.

---

## 🏗️ A Hierarquia do Filesystem Linux

```
/ (Raiz Absoluta)
│  → O prédio inteiro. Acesso restrito ao root.
│
├── /home (Corredor dos Moradores)
│   └── /home/youruser (Seu Apartamento)
│       → Seus arquivos pessoais. Total liberdade aqui.
│
└── /mnt/c (Integração com Windows)
    → Acessa seu disco C: a partir do Linux.
    → Mais lento que ~/
```

---

## 👥 Comandos de Usuário

```bash
# Criar um novo usuário
sudo adduser nome-usuario
```

| Token | Significado |
|:---|:---|
| `sudo` | executa como administrador (superuser do) |
| `adduser` | cria usuário com pasta home e configurações padrão |

```bash
# Conceder privilégios de administrador (sudo)
sudo usermod -aG sudo nome-usuario
```

| Token | Significado |
|:---|:---|
| `usermod` | modifica configurações de um usuário existente |
| `-aG` | `-a` = append (adicionar sem remover outros grupos); `-G` = grupo |
| `sudo` | nome do grupo que concede poderes de administrador |

```bash
# Trocar de usuário (com ambiente completo)
sudo -u nome-usuario -i
```

| Token | Significado |
|:---|:---|
| `-u nome-usuario` | especifica qual usuário assumir |
| `-i` | *simulate initial login* — carrega o home e as configurações do shell |

---

## 🔐 Permissões — Decodificando `drwxr-xr-x`

```
d  rwx  r-x  r-x
│   │    │    │
│   │    │    └── Outros: leitura + execução
│   │    └─────── Grupo: leitura + execução
│   └──────────── Dono: leitura + escrita + execução
└──────────────── Tipo: d = diretório, - = arquivo
```

| Letra | Permissão | Valor numérico |
|:---|:---|:---|
| `r` | leitura (read) | 4 |
| `w` | escrita (write) | 2 |
| `x` | execução (execute) | 1 |
| `-` | sem permissão | 0 |

```bash
# Exemplos práticos:
chmod 755 script.sh    # dono: tudo; grupo e outros: ler + executar
chmod 644 config.txt   # dono: ler + escrever; grupo e outros: só ler
chmod 1777 /tmp        # sticky bit — evita que outros deletem seus arquivos
```

---

## 🔍 Diagnóstico de Identidade

```bash
whoami    # usuário atual
id        # UID, GID e todos os grupos
w         # quem está logado e o que está fazendo
groups    # lista os grupos do usuário atual
```

---

## ⚠️ sudo vs root — Qual a diferença?

| | sudo | root direto |
|:---|:---|:---|
| **Como usar** | `sudo comando` | `su -` |
| **Risco** | Baixo — comando por comando | Alto — sessão completa como root |
| **Rastreabilidade** | Logado em `/var/log/auth.log` | Sem rastreio por usuário |
| **Recomendação** | ✅ Sempre prefira | ❌ Evite em produção |

---

*Próximo: [08 — Troubleshooting](../08-troubleshooting/README.md)*
