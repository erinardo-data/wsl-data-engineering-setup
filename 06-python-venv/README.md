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
