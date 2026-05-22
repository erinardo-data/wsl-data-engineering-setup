# 03 — VS Code + WSL Integration

> Editando arquivos Linux diretamente do Windows, sem friction.

---

## 🔌 O Problema Sem a Extensão

Sem integração nativa, o VS Code vê o WSL como uma rede remota.
Editar arquivos via `/mnt/c/` ou UNC path (`\\wsl$\...`) é lento e instável.

**Solução:** Extensão oficial **WSL** da Microsoft.

---

## 🚀 Instalação

1. Abra o VS Code no Windows
2. `Ctrl + Shift + X` → pesquise **WSL**
3. Instale a extensão da Microsoft (ícone do pinguim)
4. Reinicie o VS Code

---

## 💻 Uso — Abrindo Projetos

```bash
# De qualquer pasta no terminal Linux:
code .
```

| Token | Significado |
|:---|:---|
| `code` | Chama o executável do VS Code |
| `.` | Ponto = diretório atual — abre esta pasta como workspace |

O VS Code abrirá com `WSL: Ubuntu` no canto inferior esquerdo,
indicando que está conectado ao sistema de arquivos Linux.

---

## 🔧 Solução: `code` não encontrado após `sudo`

O `sudo` reseta o `PATH` do usuário. Solução com link simbólico global:

```bash
sudo ln -s /mnt/c/Users/SEUUSUARIO/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code \
           /usr/local/bin/code
```

| Token | Significado |
|:---|:---|
| `ln -s` | *link* com flag `-s` = simbólico (atalho) |
| `/mnt/c/...` | Caminho do executável no Windows acessado pelo Linux |
| `/usr/local/bin/code` | Destino global — acessível por qualquer usuário |
| `\` | Continuação de linha (o comando continua abaixo) |

---

## 🛑 Troubleshooting de Conexão

Se o botão `><` (canto inferior esquerdo) travar:

```powershell
# No PowerShell (Windows):
wsl --shutdown
# Depois reabra o VS Code
```

**Permissão negada em `/tmp` (VS Code Server):**
```bash
sudo chmod 1777 /tmp
```

| Token | Significado |
|:---|:---|
| `chmod 1777` | Restaura as permissões do `/tmp` com o *sticky bit* |
| `1777` | Leitura+escrita+execução para todos + sticky bit (evita deleção por outros) |

---

## ⚙️ Comportamento de Término (Windows Terminal)

Configure o que acontece quando o processo Linux termina:

`Configurações → Perfil Ubuntu → Avançado → Comportamento de término`

| Opção | Recomendação |
|:---|:---|
| Automático | Padrão — fecha se terminar normalmente |
| **Fechar somente com êxito** | ✅ **Recomendado** — mantém aberto em caso de erro |
| Nunca fechar | Útil para debugging intenso |

---

*Próximo: [04 — Aliases e Produtividade](../04-aliases-produtividade/README.md)*
