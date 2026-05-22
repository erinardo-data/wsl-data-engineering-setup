# 02 — Shell: Zsh + Oh My Zsh

> Saindo do terminal "preto e branco" para um ambiente produtivo e visual.

---

## 🎨 Por que trocar o Bash pelo Zsh?

O **Bash** é o shell padrão da maioria das distribuições Linux.
O **Zsh** (Z Shell) é uma evolução moderna que oferece:

- Autocompleção inteligente (com `Tab`)
- Sugestão de comandos baseada no histórico
- Temas visuais via Oh My Zsh
- Plugins para Git, Python, Docker e mais

> **Analogia:** Bash é um carro básico que faz o trabalho.
> Zsh + Oh My Zsh é o mesmo carro com GPS, câmera de ré e painel digital.

---

## 🚀 Instalação

```bash
# 1. Atualiza os repositórios e instala o Zsh
sudo apt update && sudo apt install zsh -y

# 2. Instala o Oh My Zsh (framework de temas e plugins)
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 3. Define o Zsh como shell padrão
chsh -s $(which zsh)
```

### Tokens explicados:

| Token | Significado |
|:---|:---|
| `sudo` | *superuser do* — executa com privilégios de administrador |
| `apt update` | atualiza a lista de pacotes disponíveis |
| `apt install zsh -y` | instala o Zsh; `-y` confirma automaticamente |
| `&&` | executa o próximo comando só se o anterior tiver êxito |
| `curl -fsSL` | baixa o script; `-f` falha silencioso, `-s` silencioso, `-L` segue redirecionamentos |
| `chsh -s` | *change shell* — muda o shell padrão do usuário |
| `$(which zsh)` | `which` encontra o caminho do executável; `$()` executa e substitui |

---

## 🎨 Tema e Fonte

**Tema utilizado:** `robbyrussell`
O clássico `➜` com destaque de cores. Simples, rápido, nunca atrapalha.

**Configuração no `~/.zshrc`:**
```zsh
ZSH_THEME="robbyrussell"
```

**Fonte:** Fira Code Nerd Font
Essencial para renderizar ícones (🐧) e ligaduras (`!=` → `≠`) no terminal.
Configure no Windows Terminal: *Configurações → Perfil Ubuntu → Aparência → Fonte*.

---

## ⚙️ Arquivo de Configuração: `~/.zshrc`

O `.zshrc` é o "cérebro" do seu Zsh — carregado toda vez que você abre o terminal.
Nele ficam: tema, plugins, aliases e variáveis de ambiente.

```bash
# Abre e recarrega automaticamente ao sair
n       # alias personalizado: nano +999 ~/.zshrc && source ~/.zshrc
```

> ⚠️ O alias `n` já executa `source ~/.zshrc` automaticamente.
> Nunca precisa rodar `source` separado após usar `n`.

---

## 🔌 Plugins úteis (Oh My Zsh)

```zsh
# No ~/.zshrc:
plugins=(git python pip docker)
```

| Plugin | O que adiciona |
|:---|:---|
| `git` | Aliases como `gst` (git status), `gco` (checkout), `gp` (push) |
| `python` | Ativa venv automaticamente ao entrar na pasta |
| `pip` | Autocompleção de pacotes pip |

---

*Próximo: [03 — VS Code + WSL](../03-vscode-integration/README.md)*
