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
