# Curingas e Caracteres de Pesquisa no Terminal

> Guia completo sobre `*`, `?`, `[]`, `{}`, `**` e expressões regulares com `find` e `grep`.

---

## Sumário

1. [O que são curingas?](#1-o-que-são-curingas)
2. [Asterisco `*` — qualquer sequência](#2-asterisco---qualquer-sequência)
3. [Interrogação `?` — um único caractere](#3-interrogação---um-único-caractere)
4. [Colchetes `[ ]` — conjuntos e intervalos](#4-colchetes----conjuntos-e-intervalos)
5. [Chaves `{ }` — alternativas explícitas](#5-chaves----alternativas-explícitas)
6. [Glob duplo `**` — recursão de diretórios](#6-glob-duplo----recursão-de-diretórios)
7. [Curingas com `find`](#7-curingas-com-find)
8. [Curingas com `grep` (regex)](#8-curingas-com-grep-expressões-regulares)
9. [Dicas avançadas e combinações](#9-dicas-avançadas-e-combinações)
10. [Tabela de referência rápida](#10-tabela-de-referência-rápida)

---

## 1. O que são curingas?

Curingas (*wildcards*) são caracteres especiais interpretados pelo **shell** (Bash, Zsh, Fish…) **antes** de executar qualquer comando. Eles substituem partes de nomes de arquivos e diretórios, permitindo selecionar múltiplos itens com uma única expressão.

Esse processo se chama **glob expansion**.

> 💡 **Importante:** o shell expande os curingas *antes* de passar os argumentos ao comando. Portanto `ls *.txt` é equivalente a `ls a.txt b.txt c.txt` se esses arquivos existirem.

---

## 2. Asterisco `*` — qualquer sequência

O asterisco representa **zero ou mais caracteres quaisquer** (exceto `/`). É o curinga mais utilizado no dia a dia.

### Exemplos com arquivos

```bash
# Listar todos os arquivos .txt na pasta atual
ls *.txt

# Listar todos os arquivos que começam com 'relatorio'
ls relatorio*

# Listar arquivos que terminam com '_2024.csv'
ls *_2024.csv

# Copiar todos os arquivos .jpg para outra pasta
cp *.jpg /home/user/Imagens/

# Remover todos os arquivos de log
rm *.log

# Mover todos os PDFs para a pasta Documentos
mv *.pdf ~/Documentos/
```

### Exemplos com pastas

```bash
# Listar todas as subpastas de /var/log
ls /var/log/*/

# Acessar qualquer pasta que comece com 'projeto'
ls projeto*/

# Exibir o conteúdo de todos os .conf em /etc
cat /etc/*.conf
```

> ⚠️ **Atenção:** `ls *` lista também o conteúdo das subpastas! Use `ls -d */` para listar apenas diretórios.

---

## 3. Interrogação `?` — exatamente um caractere

A interrogação substitui **exatamente um caractere** qualquer. Útil quando você conhece o tamanho do nome mas não todos os caracteres.

```bash
# Arquivos com nome de 1 letra + extensão .sh
ls ?.sh

# Arquivos como 'log1.txt', 'log2.txt', 'logA.txt'
ls log?.txt

# Pastas com exatamente 4 caracteres no nome
ls -d ????/

# Arquivos no formato data: 2024-01-01.csv
ls ????-??-??.csv

# Três interrogações = exatamente 3 caracteres no nome
ls ???.py
```

> 💡 Use vários `?` consecutivos para especificar comprimentos exatos. `??` casa com qualquer par de caracteres (ex: `ab`, `12`, `Z9`).

---

## 4. Colchetes `[ ]` — conjuntos e intervalos

Os colchetes permitem especificar um **conjunto ou intervalo** de caracteres aceitos em uma posição. Apenas **um** caractere do conjunto é casado.

### Conjuntos simples

```bash
# Arquivos que começam com a, b ou c
ls [abc]*

# Arquivos terminados em .jpg ou .png
ls *.[jp][pn]g

# Apenas arquivos que começam com letra maiúscula
ls [A-Z]*

# Arquivos cujo nome começa com dígito
ls [0-9]*
```

### Intervalos e negação

```bash
# Qualquer letra minúscula na primeira posição
ls [a-z]*

# Negação com ! — arquivos que NÃO começam com vogal
ls [!aeiouAEIOU]*

# Arquivos .c ou .h (comuns em projetos C)
ls *.[ch]
```

### Classes POSIX

```bash
# [:alpha:] — letras a-z e A-Z
ls [[:alpha:]]*

# [:digit:] — somente dígitos
ls [[:digit:]]*

# [:alnum:] — letras e dígitos
ls [[:alnum:]]*
```

| Classe       | Equivalente    | Descrição                    |
|--------------|----------------|------------------------------|
| `[:alpha:]`  | `[a-zA-Z]`     | Letras maiúsculas e minúsculas |
| `[:digit:]`  | `[0-9]`        | Dígitos de 0 a 9             |
| `[:alnum:]`  | `[a-zA-Z0-9]`  | Letras e dígitos             |
| `[:lower:]`  | `[a-z]`        | Letras minúsculas            |
| `[:upper:]`  | `[A-Z]`        | Letras maiúsculas            |
| `[:space:]`  | ` \t\n…`       | Espaços em branco            |
| `[:punct:]`  | `! . , …`      | Pontuação                    |

---

## 5. Chaves `{ }` — alternativas explícitas

As chaves (*brace expansion*) expandem uma **lista de alternativas** separadas por vírgula. Diferente dos outros curingas, elas **não precisam casar com arquivos existentes** — apenas geram combinações de texto.

```bash
# Criar múltiplas pastas de uma vez
mkdir -p projeto/{src,tests,docs,assets}

# Listar arquivos .txt e .md na mesma chamada
ls *.{txt,md}

# Criar backup de um arquivo rapidamente
cp config.yaml config.yaml.{bak,old}

# Extensões múltiplas de imagem
ls foto.{jpg,jpeg,png,webp}

# Sequências numéricas com ..
echo arquivo_{1..5}.txt
# Saída: arquivo_1.txt arquivo_2.txt arquivo_3.txt arquivo_4.txt arquivo_5.txt

# Sequência com passo
echo pag_{01..10..2}
# Saída: pag_01 pag_03 pag_05 pag_07 pag_09
```

> 💡 Chaves podem ser aninhadas: `{a,b{1,2},c}` expande para `a b1 b2 c`. Muito útil para criar estruturas de pastas complexas com um único comando.

---

## 6. Glob duplo `**` — recursão de diretórios

O `**` (*globstar*) percorre **recursivamente** todos os subdiretórios.

- **Bash:** é necessário ativar com `shopt -s globstar`
- **Zsh:** funciona por padrão

```bash
# Ativar globstar no Bash
shopt -s globstar

# Listar todos os arquivos .py em qualquer nível
ls **/*.py

# Encontrar todos os arquivos .log recursivamente
ls **/*.log

# Contar todos os arquivos .js do projeto
ls **/*.js | wc -l

# Copiar todos os .sql para uma pasta de backup
cp **/*.sql ~/backup/sql/

# Exibir todos os README.md do repositório
cat **/README.md
```

> ⚠️ No Bash, adicione `shopt -s globstar` ao seu `~/.bashrc` para ativar permanentemente.

---

## 7. Curingas com `find`

O `find` possui sua própria lógica de padrões via `-name` e `-iname` (case insensitive). Os curingas **devem ser colocados entre aspas** para evitar que o shell os expanda antes do `find`.

```bash
# Encontrar todos os .txt a partir da pasta atual
find . -name "*.txt"

# Case-insensitive: .TXT .Txt .txt etc.
find . -iname "*.txt"

# Somente no diretório raiz (não recursivo)
find . -maxdepth 1 -name "*.csv"

# Apenas diretórios com 'backup' no nome
find / -type d -name "*backup*"

# Arquivos maiores que 100MB
find . -name "*.mp4" -size +100M

# Arquivos modificados nos últimos 7 dias
find . -name "*.log" -mtime -7

# Excluir todos os .pyc encontrados
find . -name "*.pyc" -delete

# Executar ação em cada arquivo encontrado
find . -name "*.sh" -exec chmod +x {} \;

# Combinar dois padrões com -o (OR)
find . -name "*.jpg" -o -name "*.png"
```

---

## 8. Curingas com `grep` (expressões regulares)

O `grep` usa **expressões regulares**, que são mais poderosas que curingas de shell.

```bash
# Buscar 'error' em todos os .log da pasta
grep 'error' *.log

# Recursivo: buscar em todos os arquivos de src/
grep -r 'TODO' src/

# -l: apenas exibir nomes dos arquivos que casam
grep -rl 'import os' *.py

# ^ casa o início da linha
grep '^ERRO' sistema.log

# $ casa o fim da linha
grep ';$' *.sql

# . (ponto) casa qualquer caractere único
grep 'arqu.vo' notas.txt

# .* casa qualquer sequência
grep 'inicio.*fim' relatorio.txt

# -E ativa Extended Regex: +, ?, |, {n,m}
grep -E 'erro|falha|critico' app.log

# Case-insensitive
grep -i 'warning' *.txt
```

### Glob do shell vs Regex do grep

| Função             | Glob (shell) | Regex (grep)  |
|--------------------|--------------|---------------|
| Qualquer sequência | `*`          | `.*`          |
| Um caractere       | `?`          | `.`           |
| Conjunto           | `[abc]`      | `[abc]`       |
| Negação            | `[!abc]`     | `[^abc]`      |
| Início da linha    | *(não existe)* | `^`         |
| Fim da linha       | *(não existe)* | `$`         |
| Zero ou mais       | *(via `*`)*  | `x*`          |
| Um ou mais         | *(não existe)* | `x+` (-E)  |
| Opcional           | *(não existe)* | `x?` (-E)  |

---

## 9. Dicas avançadas e combinações

### Escapar curingas

```bash
# Use \ para tratar * ou ? como texto literal
ls arquivo\*.txt

# Ou use aspas simples
ls 'arquivo*.txt'
```

### Combinar curingas

```bash
# Arquivos que começam com dígito, têm qualquer meio e terminam em .sh
ls [0-9]*script*.sh

# Exatamente 8 caracteres de nome antes de .txt
ls ????????.txt

# Nome entre 4 e 6 caracteres
ls ????.* ?????.* ??????.*
```

### Curingas no PATH

```bash
# Editar qualquer nginx.conf em subpasta de /etc
nano /etc/*/nginx.conf

# Ver logs de qualquer serviço em /var/log
tail -f /var/log/*/error.log

# Encontrar todos os Makefile do sistema
find /home -name "Makefile"
```

### Nomes com espaços

```bash
# Use aspas para proteger a expansão
ls "meus arquivos"/*.txt

# Ou escape o espaço com \
ls meus\ arquivos/*.txt
```

---

## 10. Tabela de Referência Rápida

| Curinga   | Significado                                  | Exemplo                              |
|-----------|----------------------------------------------|--------------------------------------|
| `*`       | Qualquer sequência (0 ou mais caracteres)    | `*.txt` → todos os .txt              |
| `?`       | Exatamente um caractere qualquer             | `arq?.sh` → `arq1.sh`, `arqA.sh`    |
| `[abc]`   | Um caractere do conjunto a, b ou c           | `[abc]*.py` → `a.py`, `b_util.py`   |
| `[a-z]`   | Um caractere no intervalo a até z            | `[a-z]*.md` → `leia.md`             |
| `[!abc]`  | Qualquer caractere EXCETO a, b, c            | `[!0-9]*` → nomes sem dígito        |
| `{a,b}`   | Expansão de alternativas explícitas          | `*.{jpg,png}` → fotos e pngs        |
| `{1..5}`  | Expansão de sequência numérica               | `arquivo_{1..5}` → 1 ao 5           |
| `**`      | Qualquer nível de subdiretórios (globstar)   | `**/*.py` → todo .py recursivo      |
| `^`       | *(grep)* Início da linha                     | `grep '^Error' log.txt`             |
| `$`       | *(grep)* Fim da linha                        | `grep 'OK$' resultado.txt`          |
| `.`       | *(grep)* Um caractere qualquer               | `grep 'f.le'` → `file`, `fale`…    |
| `.*`      | *(grep)* Qualquer sequência (regex)          | `grep 'a.*z'` → `az`, `abz`, `abcz`|

---

> 💡 **Pratique no terminal!** A melhor forma de memorizar curingas é usá-los todos os dias em tarefas reais.
