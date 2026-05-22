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
