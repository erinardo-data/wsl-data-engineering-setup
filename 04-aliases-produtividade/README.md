# 04 — Aliases e Produtividade

> Atalhos que transformam comandos longos em palavras de uma sílaba.

---

## 🧠 O que é um Alias?

Um alias é um **apelido** para um comando longo.
Em vez de digitar `eza --icons -lh` toda vez, você digita `ll`.

> **Analogia:** É como salvar um contato no celular.
> Você não digita o número completo — você toca no nome.

---

## 📂 Onde ficam os Aliases?

No arquivo `~/.zshrc`. Carregado automaticamente ao abrir o terminal.

```bash
# Para editar e recarregar automaticamente:
n      # alias: nano +999 ~/.zshrc && source ~/.zshrc
```

---

## ⚡ Aliases Ativos

### Listagem moderna (requer `eza`)
```zsh
alias ls='eza --icons'           # lista com ícones
alias ll='eza --icons -lh'       # lista detalhada com tamanhos legíveis
alias la='eza --icons -a'        # inclui arquivos ocultos (. e ..)
alias a='eza --icons --tree'     # árvore de diretórios (a = árvore)
```

### Limpeza e navegação
```zsh
alias c='clear && printf "\033[3J"'   # limpa tela E o buffer de rolagem
alias q='exit'                         # encerramento limpo
alias ..='cd ..'                       # sobe um nível
```

### Edição de configurações
```zsh
# Abre .zshrc na última linha e recarrega ao sair
alias n='nano +999 "$HOME/.zshrc" && source "$HOME/.zshrc"'

# Abre .nanorc para configurar o editor nano
alias nn='nano "$HOME/.nanorc"'
```

> ⚠️ **Importante:** o alias `n` já executa `source` automaticamente.
> Nunca rode `source ~/.zshrc` separado após usar `n`.

### Grimório (painel de referência pessoal)
```zsh
alias g='python3 ~/scripts/grimoire.py'    # abre o painel interativo
alias gg='nano ~/scripts/grimoire.py'      # edita o grimório
```

---

## 📊 Tabela de Referência Rápida

| Alias | Comando completo | O que faz |
|:---|:---|:---|
| `ls` | `eza --icons` | Lista com ícones |
| `ll` | `eza --icons -lh` | Lista detalhada |
| `la` | `eza --icons -a` | Lista incluindo ocultos |
| `a` | `eza --icons --tree` | Árvore de diretórios |
| `c` | `clear && printf "\033[3J"` | Limpeza total |
| `n` | `nano +999 ~/.zshrc && source` | Editar + recarregar .zshrc |
| `nn` | `nano ~/.nanorc` | Editar configurações do nano |
| `q` | `exit` | Sair do terminal |
| `g` | `python3 ~/scripts/grimoire.py` | Abrir grimório |
| `gg` | `nano ~/scripts/grimoire.py` | Editar grimório |

---

## 🔧 Como criar um novo alias

1. Abra o `.zshrc` com `n`
2. Navegue até a seção de aliases
3. Adicione: `alias nomedoalias='comando completo'`
4. Salve — o reload já acontece automaticamente

---

*Próximo: [05 — Comandos CLI Essenciais](../05-cli-commands/README.md)*
