#!/bin/bash
# =============================================================
# populate_folders.sh
# Populates all subfolder READMEs in wsl-data-engineering-setup
# Run from the root of the repository: bash populate_folders.sh
# =============================================================

# ── 00 — VISÃO GERAL ─────────────────────────────────────────
cat > 00-visao-geral/README.md << 'EOF'
# 00 — Visão Geral

> Por que configurar um ambiente Linux antes de tocar em dados?

---

## 🎯 O Objetivo

Antes de pipelines, warehouses ou modelos de IA, existe uma fundação invisível:
o ambiente de desenvolvimento. Este repositório documenta cada decisão tomada
para transformar uma máquina Windows comum num ambiente profissional de
Engenharia de Dados.

---

## 🧱 O "Combo de Ouro" da Engenharia de Dados

Para máxima produtividade e compatibilidade com ambientes de produção:

| Camada | Ferramenta | Papel |
|:---|:---|:---|
| **Backend** | WSL2 + Ubuntu 24.04 | Kernel Linux real dentro do Windows |
| **Shell** | Zsh + Oh My Zsh | Terminal inteligente, produtivo e visual |
| **Terminal** | Windows Terminal | Gerencia abas de Ubuntu, PowerShell e CMD |
| **Editor** | VS Code + extensão WSL | Edição nativa no filesystem Linux |
| **Linguagem** | Python 3.11+ | Linguagem principal de Engenharia de Dados |
| **Versionamento** | Git + GitHub | Histórico, portfólio e colaboração |

---

## 🔑 Conceito Fundamental

### WSL2 ≠ Simulador

O WSL2 roda um **kernel Linux real** dentro do Windows.
Isso significa performance nativa para ferramentas usadas em servidores de produção.

> **Analogia:** É como ter um apartamento completo dentro de uma casa.
> Você não "simula" morar no apartamento — você realmente mora lá.

### Por que Ubuntu Noble Numbat?

- Padrão da indústria para desenvolvimento moderno e cloud
- Suporte LTS (Long-Term Support) até 2029
- Compatível com Docker, GCP, AWS, Databricks
- Gerenciador de pacotes `apt` — o mais documentado do ecossistema

---

## 📁 O que cada pasta contém

```
wsl-data-engineering-setup/
├── 00-visao-geral/           ← você está aqui
├── 01-wsl2-setup/            ← instalação e conceitos do WSL2
├── 02-shell-zsh-ohmyzsh/     ← terminal produtivo com Zsh
├── 03-vscode-integration/    ← VS Code conectado ao Linux
├── 04-aliases-produtividade/ ← atalhos que economizam horas
├── 05-cli-commands/          ← comandos essenciais do terminal
├── 06-python-venv/           ← Python isolado e seguro
├── 07-user-management/       ← usuários, permissões e sudo
├── 08-troubleshooting/       ← problemas comuns e soluções
└── 09-pics/                  ← screenshots do ambiente
```

---

*Documentado durante a jornada de transição para Engenharia de Dados — 2026*
EOF

# ── 01 — WSL2 SETUP ──────────────────────────────────────────
cat > 01-wsl2-setup/README.md << 'EOF'
# 01 — WSL2 Setup

> Transformando o Windows numa estação profissional de desenvolvimento.

---

## 🧠 O que é o WSL2?

**WSL** = Windows Subsystem for Linux — Subsistema Windows para Linux.

Diferente de simuladores como Git Bash, o WSL2 roda um **kernel Linux real**
dentro do Windows. Isso garante:

- Performance nativa para ferramentas de dados (Python, Docker, Spark)
- Compatibilidade total com ambientes de produção em nuvem
- Sem necessidade de reiniciar a máquina (diferente de dual boot)

> **Analogia:** Um dual boot é ter dois quartos separados e precisar
> trocar de quarto para mudar de sistema. O WSL2 é ter os dois quartos
> na mesma casa, com uma porta entre eles.

---

## ⚙️ Instalação

Execute no **PowerShell como Administrador**:

```powershell
# Instala o Ubuntu Noble Numbat 24.04
wsl --install -d Ubuntu-24.04

# Lista as distribuições instaladas e a versão do WSL
wsl -l -v

# Atualiza o kernel do WSL
wsl --update

# Desliga o subsistema Linux (reinício limpo)
wsl --shutdown
```

### Tokens explicados:

| Token | Significado |
|:---|:---|
| `wsl` | Chama o executável do Windows Subsystem for Linux |
| `--install` | Flag para instalar uma nova distribuição |
| `-d Ubuntu-24.04` | `-d` = distro; especifica qual distribuição instalar |
| `-l -v` | `-l` = list (listar); `-v` = verbose (detalhado) |
| `--update` | Atualiza o kernel WSL para a versão mais recente |
| `--shutdown` | Para todos os processos Linux em execução |

---

## 📂 Conceito Importante: Onde Guardar os Arquivos

```
✅ ~/Projetos/          → filesystem Linux (rápido)
❌ /mnt/c/Users/...     → filesystem Windows acessado pelo Linux (lento)
```

Arquivos em `~/` são até **5x mais rápidos** para ferramentas Linux.
Sempre mantenha seus projetos dentro do WSL.

---

## 🔧 Gerenciamento de Distribuições

```powershell
wsl -l -v              # lista distros e versão WSL (1 ou 2)
wsl -d Ubuntu-24.04    # inicia uma distro específica
wsl ~                  # inicia na pasta home do Linux
wsl --shutdown         # desliga todas as distros
```

---

## 🆚 Ubuntu vs AlmaLinux — Quando usar cada um?

| Recurso | Ubuntu | AlmaLinux (Red Hat) |
|:---|:---|:---|
| **Gerenciador** | `apt` | `dnf` |
| **Foco** | Desenvolvimento / Cloud | Servidores críticos |
| **Ecossistema DE** | ✅ Padrão | ⚠️ Corporativo |
| **Documentação** | Abundante | Técnica e específica |

> Para Engenharia de Dados: **Ubuntu é o padrão de mercado.**

---

*Próximo: [02 — Shell: Zsh + Oh My Zsh](../02-shell-zsh-ohmyzsh/README.md)*
EOF

# ── 02 — SHELL ZSH + OH MY ZSH ───────────────────────────────
cat > 02-shell-zsh-ohmyzsh/README.md << 'EOF'
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
EOF

# ── 03 — VS CODE INTEGRATION ─────────────────────────────────
cat > 03-vscode-integration/README.md << 'EOF'
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
EOF

# ── 04 — ALIASES ─────────────────────────────────────────────
cat > 04-aliases-produtividade/README.md << 'EOF'
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
EOF

# ── 05 — CLI COMMANDS ────────────────────────────────────────
cat > 05-cli-commands/README.md << 'EOF'
# 05 — Comandos CLI Essenciais

> O terminal é sua principal ferramenta. Domine-o antes de qualquer outra coisa.

---

## 🧭 Navegação

```bash
pwd              # Print Working Directory — mostra onde você está
ls               # lista arquivos (com alias: eza --icons)
ll               # lista detalhada com permissões e tamanhos
la               # lista incluindo arquivos ocultos (. e ..)
cd ~             # volta para o Home (seu "apartamento")
cd ..            # sobe um nível (sai da pasta atual)
cd -             # volta para o diretório anterior
a                # alias: eza --icons --tree (árvore de pastas)
```

### Diagnóstico de identidade
```bash
whoami           # "Quem sou eu agora?" — exibe o usuário atual
id               # mostra UID, GID e grupos do usuário
w                # mostra quem está logado e o que está fazendo
```

---

## 📂 Manipulação de Arquivos e Pastas

```bash
mkdir nome_pasta          # cria um diretório
mkdir -p a/b/c            # cria hierarquia completa de uma vez
touch arquivo.txt         # cria arquivo vazio (ou atualiza timestamp)
cp -i origem destino      # copia — -i pergunta antes de sobrescrever
mv -i origem destino      # move ou renomeia — -i pergunta antes
rm -i arquivo             # remove — -i pede confirmação (mais seguro)
rm -rf pasta/             # remove pasta inteira — ⚠️ sem confirmação
cat arquivo.txt           # exibe conteúdo do arquivo no terminal
cat arquivo | head -10    # exibe apenas as primeiras 10 linhas
cat arquivo | tail -10    # exibe apenas as últimas 10 linhas
```

> ⚠️ **Nunca use `rm -rf` sem ter certeza absoluta do caminho.**
> Não existe lixeira no terminal Linux.

---

## ⌨️ Atalhos de Teclado (GNU Readline)

| Atalho | O que faz |
|:---|:---|
| `Ctrl + U` | Apaga da posição do cursor até o **início** da linha |
| `Ctrl + K` | Apaga da posição do cursor até o **final** da linha |
| `Ctrl + W` | Apaga a **palavra anterior** ao cursor |
| `Ctrl + Y` | "Cola" o texto apagado pelos atalhos acima |
| `Ctrl + R` | Busca interativa no **histórico** de comandos |
| `Ctrl + L` | Limpa a tela (equivale a `clear`) |
| `Ctrl + C` | Cancela o comando atual |
| `Ctrl + D` | Encerra o terminal (equivale a `exit`) |

---

## 🔧 Manutenção do Sistema

```bash
sudo apt update              # atualiza a lista de pacotes disponíveis
sudo apt upgrade             # instala as atualizações
sudo apt install programa    # instala um novo pacote
sudo apt remove programa     # remove um pacote
```

---

## 📋 Códigos de Saída (Exit Codes)

| Código | Significado |
|:---|:---|
| `0` | ✅ Sucesso total |
| `1` | ❌ Erro genérico |
| `130` | ⚠️ Interrompido pelo usuário (`Ctrl + C`) |

```bash
# Verificar o código do último comando:
echo $?
```

---

## 📝 Editores no Terminal

| Ferramenta | Comando | Características |
|:---|:---|:---|
| **Nano** | `nano arquivo.txt` | Simples, atalhos visíveis na tela |
| **Vim** | `vim arquivo.txt` | Poderoso, curva de aprendizado íngreme |
| **VS Code** | `code .` | Interface gráfica, requer extensão WSL |

> Para iniciantes: **nano** é a escolha certa.
> `Ctrl + O` para salvar · `Ctrl + X` para sair

---

*Próximo: [06 — Python: Ambientes Virtuais](../06-python-venv/README.md)*
EOF

# ── 06 — PYTHON VENV ─────────────────────────────────────────
cat > 06-python-venv/README.md << 'EOF'
# 06 — Python: Ambientes Virtuais

> Por que o Ubuntu não deixa instalar pacotes diretamente — e por que isso é bom.

---

## 🛡️ PEP 668 — A "Proteção" do Ubuntu Noble Numbat

Se você tentar:
```bash
pip install pandas
```

Verá este erro:
```
error: externally-managed-environment
```

**Isso não é um bug.** É uma proteção introduzida pela PEP 668 no Ubuntu 24.04.

> **Analogia:** É como um condomínio que não deixa você fazer obra no apartamento
> sem autorização. Você cria um "canteiro isolado" (venv) para instalar o que quiser,
> sem mexer nas partes comuns do sistema.

---

## 🐍 O que é um Ambiente Virtual?

Um `.venv` é uma **cópia isolada do Python** dentro da sua pasta de projeto.
Pacotes instalados nele não afetam o sistema nem outros projetos.

---

## 🚀 Fluxo Completo

```bash
# 1. Instalar suporte a venv (uma única vez no sistema)
sudo apt install python3-venv -y
```

| Token | Significado |
|:---|:---|
| `sudo` | executa como administrador |
| `apt install` | instala um pacote via gerenciador APT |
| `python3-venv` | módulo que permite criar ambientes virtuais |
| `-y` | confirma automaticamente (yes to all) |

```bash
# 2. Criar o ambiente virtual na pasta do projeto
python3 -m venv .venv
```

| Token | Significado |
|:---|:---|
| `python3` | chama o interpretador Python 3 |
| `-m venv` | executa o módulo `venv` como script |
| `.venv` | nome da pasta do ambiente (ponto = oculto por convenção) |

```bash
# 3. Ativar o ambiente
source .venv/bin/activate
```

| Token | Significado |
|:---|:---|
| `source` | executa o script no shell atual (não num subprocesso) |
| `.venv/bin/activate` | script que modifica o PATH para usar este Python |

> Após ativar, o prompt mostrará `(.venv)` no início.

```bash
# 4. Instalar pacotes dentro do ambiente (sem erros)
pip install pandas requests

# 5. Salvar dependências para reprodutibilidade
pip freeze > requirements.txt

# 6. Desativar quando terminar
deactivate
```

---

## 📌 Boas Práticas

```bash
# .gitignore deve sempre conter:
.venv/
__pycache__/
*.pyc
```

> Nunca versione a pasta `.venv/` — ela é recriável e pesa muito.
> Versione apenas o `requirements.txt`.

---

## 🔄 Reproduzir o Ambiente em Outra Máquina

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

---

*Próximo: [07 — Gestão de Usuários](../07-user-management/README.md)*
EOF

# ── 07 — USER MANAGEMENT ─────────────────────────────────────
cat > 07-user-management/README.md << 'EOF'
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
EOF

# ── 08 — TROUBLESHOOTING ─────────────────────────────────────
cat > 08-troubleshooting/README.md << 'EOF'
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

*Voltar ao início: [README principal](../README.md)*
EOF

echo ""
echo "✅ Todas as pastas foram populadas com sucesso!"
echo ""
echo "Próximos passos:"
echo "  git add ."
echo "  git commit -m \"docs: populate all module READMEs with full content\""
echo "  git push"
