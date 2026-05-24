# 08 — Troubleshooting

> Cada erro foi uma aula. Aqui estão as mais valiosas.

---

## 🔴 Erro: `Wsl/Service/E_UNEXPECTED`

**Sintoma:** WSL trava ou não inicia.

**Causa:** O serviço WSL travou no Windows.

**Solução:**
```powershell
# No PowerShell como Administrador:
wsl --shutdown

# Se persistir, reseta o catálogo de rede:
netsh winsock reset

# Reinicie o computador
```

| Token | Significado |
|:---|:---|
| `wsl --shutdown` | força o encerramento de todos os processos Linux |
| `netsh winsock reset` | restaura a pilha de rede do Windows ao estado padrão |

---

## 🔴 Erro: `externally-managed-environment`

**Sintoma:** `pip install` falha com mensagem de ambiente gerenciado externamente.

**Causa:** Ubuntu 24.04 implementa PEP 668 — protege o Python do sistema.

**Solução:** Use sempre ambiente virtual.
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install pacote
```

> ✅ Detalhes completos em [06 — Python: Ambientes Virtuais](../06-python-venv/README.md)

---

## 🔴 Erro: `code: command not found` após `sudo`

**Sintoma:** `sudo code .` não funciona.

**Causa:** `sudo` reseta o PATH, removendo o caminho do VS Code.

**Solução:** Link simbólico global.
```bash
sudo ln -s /mnt/c/Users/SEUUSUARIO/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code \
           /usr/local/bin/code
```

---

## 🔴 Erro: `Permission denied on /tmp` (VS Code Server)

**Sintoma:** VS Code não consegue criar arquivos temporários de conexão.

**Causa:** Permissões do `/tmp` corrompidas.

**Solução:**
```bash
sudo chmod 1777 /tmp
```

---

## 🔴 Erro: `git push` rejeitado — autenticação falhou

**Sintoma:**
```
remote: Invalid username or token.
fatal: Authentication failed
```

**Causa:** GitHub não aceita senha comum desde agosto de 2021.

**Solução:** Use um **PAT — Personal Access Token**.
1. github.com → Settings → Developer settings → Tokens (classic)
2. Generate new token → scope: `repo`
3. Use o token como "senha" no `git push`
4. Configure para não pedir de novo:
```bash
git config --global credential.helper store
```

---

## 🔴 Erro: `git push` rejeitado — non-fast-forward

**Sintoma:**
```
rejected — non-fast-forward
```

**Causa:** GitHub tem commits que sua máquina local não tem
(geralmente porque marcou "Add README" ao criar o repositório).

**Solução:**
```bash
git pull origin main --rebase
git push
```

| Token | Significado |
|:---|:---|
| `pull` | baixa e integra commits do remoto |
| `--rebase` | reaplica seus commits por cima dos commits remotos (histórico limpo) |

---

## 🟡 Aviso: fechar o terminal no "X" vs `exit`

| Forma | O que acontece |
|:---|:---|
| Clique no X | Pode deixar processos em background rodando |
| `exit` ou `Ctrl + D` | Encerramento limpo — garante que tudo parou |

> Prefira sempre `q` (alias para `exit`) ou `Ctrl + D`.

---

*Next: [09 — Terminal Screenshots](../09-pics/README.md)*
