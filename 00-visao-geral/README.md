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
