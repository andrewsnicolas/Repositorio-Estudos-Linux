# Bash Scripting — Guia Prático de Sintaxe

> Foco em sintaxe e variações. Direto ao ponto.

---

## 1. Estrutura Básica de um Script

```bash
#!/bin/bash
# Isso é um comentário

echo "Hello, World!"
```

- `#!/bin/bash` — **shebang**: diz ao sistema qual interpretador usar
- Todo script começa com essa linha
- Torne executável com: `chmod +x script.sh`
- Execute com: `./script.sh` ou `bash script.sh`

---

## 2. Variáveis

### Declaração e uso

```bash
nome="João"           # Sem espaços ao redor do =
echo $nome            # Acesso simples
echo "${nome}"        # Acesso com chaves (recomendado)
echo "Olá, ${nome}!"  # Dentro de string com aspas duplas
```

### Variáveis de ambiente comuns

```bash
echo $HOME    # Diretório home do usuário
echo $USER    # Nome do usuário atual
echo $PWD     # Diretório atual
echo $PATH    # Caminhos do sistema
echo $SHELL   # Shell em uso
echo $$       # PID do processo atual
echo $?       # Código de saída do último comando
echo $#       # Número de argumentos recebidos
echo $@       # Todos os argumentos (lista separada)
echo $*       # Todos os argumentos (string única)
echo $0       # Nome do script
echo $1 $2    # Primeiro e segundo argumento
```

### Variáveis somente leitura e locais

```bash
readonly PI=3.14         # Não pode ser alterada
declare -r CONSTANTE=10  # Equivalente a readonly

funcao() {
  local var="só aqui"    # Escopo local à função
}
```

### Tipos com declare

```bash
declare -i numero=5      # Inteiro
declare -a array         # Array indexado
declare -A mapa          # Array associativo (chave-valor)
declare -l texto="OLA"   # Força lowercase → "ola"
declare -u texto="ola"   # Força uppercase → "OLA"
```

---

## 3. Strings

### Aspas: simples vs duplas vs sem aspas

```bash
nome="mundo"
echo 'Olá $nome'   # → Olá $nome       (sem interpolação)
echo "Olá $nome"   # → Olá mundo       (com interpolação)
echo Olá $nome     # → Olá mundo       (sem aspas: igual a duplas, mas quebra em espaços)
```

### Manipulação de strings

```bash
texto="Hello, World"

echo ${#texto}            # Tamanho: 12
echo ${texto:7}           # Substring a partir de 7: "World"
echo ${texto:7:3}         # Substring de 7, 3 chars: "Wor"
echo ${texto/World/Bash}  # Substituir 1ª ocorrência: "Hello, Bash"
echo ${texto//l/L}        # Substituir todas: "HeLLo, WorLd"
echo ${texto^^}           # Maiúsculas: "HELLO, WORLD"
echo ${texto,,}           # Minúsculas: "hello, world"
echo ${texto^}            # Primeira letra maiúscula
```

### Verificações de valor padrão

```bash
var=""
echo ${var:-"padrão"}    # Usa "padrão" se var vazia/não definida
echo ${var:="padrão"}    # Atribui "padrão" se var vazia/não definida
echo ${var:?"Erro!"}     # Exibe erro e sai se var vazia/não definida
echo ${var:+"tem valor"} # Retorna "tem valor" apenas se var estiver definida
```

---

## 4. Arrays

### Array indexado

```bash
frutas=("maçã" "banana" "uva")   # Declaração
frutas[3]="kiwi"                  # Adicionar por índice

echo ${frutas[0]}     # maçã (índice começa em 0)
echo ${frutas[@]}     # Todos os elementos
echo ${#frutas[@]}    # Quantidade de elementos
echo ${!frutas[@]}    # Todos os índices

frutas+=("manga")     # Append
unset frutas[1]       # Remover elemento por índice

# Fatia
echo ${frutas[@]:1:2} # 2 elementos a partir do índice 1
```

### Array associativo (dicionário)

```bash
declare -A pessoa
pessoa["nome"]="Ana"
pessoa["idade"]="30"

echo ${pessoa["nome"]}  # Ana
echo ${!pessoa[@]}      # Todas as chaves
echo ${pessoa[@]}       # Todos os valores
```

### Iterando arrays

```bash
for item in "${frutas[@]}"; do
  echo "$item"
done

# Com índice
for i in "${!frutas[@]}"; do
  echo "$i: ${frutas[$i]}"
done
```

---

## 5. Aritmética

### Formas de calcular

```bash
a=10
b=3

# (( )) — recomendado para inteiros
echo $(( a + b ))    # 13
echo $(( a - b ))    # 7
echo $(( a * b ))    # 30
echo $(( a / b ))    # 3  (divisão inteira)
echo $(( a % b ))    # 1  (módulo)
echo $(( a ** b ))   # 1000 (potência)

# Atribuição com aritmética
(( a++ ))     # incremento
(( a-- ))     # decremento
(( a += 5 ))  # soma e atribui
(( a *= 2 ))  # multiplica e atribui

# expr — forma antiga (evite)
expr $a + $b

# bc — para decimais
echo "scale=2; 10/3" | bc   # 3.33
echo "sqrt(16)" | bc -l     # 4
```

---

## 6. Condicionais

### if / elif / else

```bash
if [ condição ]; then
  # comandos
elif [ outra_condição ]; then
  # comandos
else
  # comandos
fi
```

### Operadores de comparação

```bash
# Números (use -eq, -ne, -lt, -le, -gt, -ge)
[ $a -eq $b ]   # igual
[ $a -ne $b ]   # diferente
[ $a -lt $b ]   # menor que
[ $a -le $b ]   # menor ou igual
[ $a -gt $b ]   # maior que
[ $a -ge $b ]   # maior ou igual

# Strings (use =, !=, <, >)
[ "$s1" = "$s2" ]    # igual
[ "$s1" != "$s2" ]   # diferente
[ -z "$s1" ]         # string vazia
[ -n "$s1" ]         # string não vazia
[[ "$s1" < "$s2" ]]  # comparação lexicográfica (use [[ ]])
[[ "$s1" =~ ^[0-9]+$ ]]  # match com regex (só em [[]])
```

### Operadores de arquivo

```bash
[ -e arquivo ]   # existe (qualquer tipo)
[ -f arquivo ]   # é um arquivo regular
[ -d arquivo ]   # é um diretório
[ -r arquivo ]   # tem permissão de leitura
[ -w arquivo ]   # tem permissão de escrita
[ -x arquivo ]   # tem permissão de execução
[ -s arquivo ]   # existe e não está vazio
[ -L arquivo ]   # é um link simbólico
```

### [ ] vs [[ ]] vs (( ))

```bash
# [ ] — POSIX, funciona em sh, mais restrito
[ $a -gt 0 ] && echo "positivo"

# [[ ]] — Bash, mais poderoso (regex, sem precisar aspas em vars)
[[ $nome == "Ana" ]] && echo "é Ana"
[[ $texto =~ ^[A-Z] ]] && echo "começa com maiúscula"

# (( )) — aritmética, retorna 0 (true) se resultado != 0
(( a > 0 )) && echo "positivo"
```

### Operadores lógicos

```bash
# Dentro de [ ] ou [[ ]]
[ $a -gt 0 -a $b -gt 0 ]    # AND com [ ]
[ $a -gt 0 -o $b -gt 0 ]    # OR com  [ ]
[[ $a -gt 0 && $b -gt 0 ]]  # AND com [[ ]]
[[ $a -gt 0 || $b -gt 0 ]]  # OR com  [[ ]]
[ ! -f "arq" ]               # NOT

# Fora dos colchetes (curto-circuito)
comando1 && comando2   # executa 2 só se 1 teve sucesso
comando1 || comando2   # executa 2 só se 1 falhou
```

### case

```bash
case $variavel in
  "opcao1")
    echo "opção 1"
    ;;
  "opcao2" | "opcao3")   # múltiplos valores
    echo "opção 2 ou 3"
    ;;
  [0-9]*)                # padrão glob
    echo "começa com número"
    ;;
  *)                     # default
    echo "outro"
    ;;
esac
```

---

## 7. Loops

### for — lista de valores

```bash
for item in a b c d; do
  echo $item
done

# Intervalo numérico
for i in {1..10}; do echo $i; done
for i in {0..20..2}; do echo $i; done   # de 0 a 20, de 2 em 2

# Estilo C
for (( i=0; i<5; i++ )); do
  echo $i
done

# Arquivos
for arq in /tmp/*.log; do
  echo "Processando: $arq"
done

# Saída de comando
for linha in $(cat arquivo.txt); do
  echo "$linha"
done
```

### while

```bash
contador=0
while [ $contador -lt 5 ]; do
  echo $contador
  (( contador++ ))
done

# Ler arquivo linha a linha (forma correta)
while IFS= read -r linha; do
  echo "$linha"
done < arquivo.txt

# Loop infinito
while true; do
  echo "rodando..."
  sleep 1
done
```

### until

```bash
# Executa ATÉ a condição ser verdadeira (oposto do while)
n=0
until [ $n -ge 5 ]; do
  echo $n
  (( n++ ))
done
```

### Controle de loop

```bash
for i in {1..10}; do
  [ $i -eq 3 ] && continue   # pula para próxima iteração
  [ $i -eq 7 ] && break      # sai do loop
  echo $i
done
```

---

## 8. Funções

### Declaração

```bash
# Forma 1
funcao() {
  echo "Olá da função"
}

# Forma 2
function funcao {
  echo "Olá da função"
}
```

### Parâmetros e retorno

```bash
saudacao() {
  local nome=$1          # $1, $2... são os argumentos
  local sobrenome=$2
  echo "Olá, $nome $sobrenome!"
  return 0               # código de saída (0=sucesso, 1-255=erro)
}

saudacao "Ana" "Silva"   # Chamada
echo $?                  # Código de retorno

# Para retornar um valor de fato, use echo + $()
calcular() {
  echo $(( $1 + $2 ))
}
resultado=$(calcular 3 5)
echo $resultado           # 8
```

---

## 9. Entrada e Saída

### read — leitura de input

```bash
read variavel                    # Lê linha inteira
read -p "Digite seu nome: " nome # Com prompt
read -s senha                    # Sem exibir (silencioso)
read -t 5 resposta               # Timeout de 5 segundos
read -n 1 tecla                  # Lê apenas 1 caractere
read -a array                    # Lê em array (palavras separadas)
```

### echo e printf

```bash
echo "texto"         # Com newline no final
echo -n "texto"      # Sem newline
echo -e "a\nb\tc"   # Interpreta escapes: \n=nova linha, \t=tab

printf "%-10s %5d\n" "Ana" 30    # Formatação avançada
printf "%0.2f\n" 3.14159         # Float com 2 casas decimais
```

### Redirecionamento

```bash
comando > arquivo.txt    # Redireciona stdout (sobrescreve)
comando >> arquivo.txt   # Redireciona stdout (acrescenta)
comando < arquivo.txt    # Redireciona stdin
comando 2> erros.txt     # Redireciona stderr
comando 2>&1             # Redireciona stderr para stdout
comando &> tudo.txt      # Redireciona stdout e stderr
comando > /dev/null 2>&1 # Descarta toda saída
```

### Pipes e substituição de comando

```bash
ls | grep ".txt"              # Pipe: stdout de ls → stdin de grep
saida=$(ls -la)               # Captura saída em variável
saida=`ls -la`                # Forma antiga (evite)
echo "hoje é $(date +%F)"    # Substituição inline
```

### Here-doc e Here-string

```bash
# Here-doc: bloco de texto como stdin
cat <<EOF
Linha 1
Linha 2 com $variavel interpolada
EOF

# Here-doc sem interpolação
cat <<'EOF'
Linha com $variavel literal
EOF

# Here-string: string como stdin
grep "padrão" <<< "minha string de teste"
```

---

## 10. Tratamento de Erros

### Códigos de saída

```bash
ls arquivo_inexistente
echo $?   # 2 → erro

# Convenção: 0 = sucesso, qualquer outro = falha
minha_funcao() {
  if [ ! -f "$1" ]; then
    echo "Arquivo não encontrado" >&2   # Erro vai para stderr
    return 1
  fi
  return 0
}
```

### Opções de segurança (recomendado)

```bash
#!/bin/bash
set -e          # Sai ao primeiro erro
set -u          # Erro em variável não definida
set -o pipefail # Erro em qualquer parte de um pipe
set -x          # Debug: mostra cada comando antes de executar

# Forma curta (combina as principais)
set -euo pipefail
```

### trap — captura de sinais

```bash
# Executar algo ao sair (limpar arquivos temporários, etc.)
trap "rm -f /tmp/arquivo_temp" EXIT

# Capturar Ctrl+C
trap "echo 'Interrompido!'; exit 1" SIGINT

# Debug: executar antes de cada comando
trap "echo Executando: $BASH_COMMAND" DEBUG
```

---

## 11. Substituição de Processo

```bash
# Diferença de pipes: a substituição cria um "arquivo" temporário
diff <(ls dir1) <(ls dir2)    # Compara saída de dois comandos
cat <(echo "linha1") <(echo "linha2")

# Redirecionar saída para múltiplos comandos
tee >(wc -l) >(grep "erro") < arquivo.txt
```

---

## 12. Expressões Regulares com grep, sed e awk

### grep

```bash
grep "padrão" arquivo.txt          # Busca básica
grep -i "padrão" arquivo.txt       # Ignora maiúsculas
grep -n "padrão" arquivo.txt       # Mostra número de linha
grep -v "padrão" arquivo.txt       # Inverte (mostra o que NÃO casa)
grep -r "padrão" /diretório/       # Recursivo
grep -E "regex+" arquivo.txt       # Regex estendida (ERE)
grep -P "\d+" arquivo.txt          # Regex Perl
```

### sed — substituição em stream

```bash
sed 's/antigo/novo/' arquivo.txt       # Substitui 1ª ocorrência por linha
sed 's/antigo/novo/g' arquivo.txt      # Substitui todas (flag g)
sed 's/antigo/novo/gi' arquivo.txt     # Substitui todas, case-insensitive
sed -i 's/antigo/novo/g' arquivo.txt   # Edita o arquivo no lugar
sed '2d' arquivo.txt                   # Deleta linha 2
sed '/padrão/d' arquivo.txt            # Deleta linhas com padrão
sed -n '3,7p' arquivo.txt              # Imprime linhas 3 a 7
sed 's/^/  /' arquivo.txt             # Adiciona espaços no início
```

### awk — processamento de colunas

```bash
awk '{print $1}' arquivo.txt           # Imprime 1ª coluna
awk '{print $1, $3}' arquivo.txt       # Imprime 1ª e 3ª coluna
awk -F: '{print $1}' /etc/passwd       # Define separador como :
awk 'NR==3' arquivo.txt                # Imprime linha 3
awk 'NR>=2 && NR<=5' arquivo.txt       # Linhas 2 a 5
awk '{sum += $1} END {print sum}' f    # Soma coluna 1
awk '/padrão/ {print $0}' arquivo.txt  # Filtra por padrão
awk '{print NR, $0}' arquivo.txt       # Adiciona número de linha
```

---

## 13. Referência Rápida de Sintaxe

| Construção | Sintaxe |
|---|---|
| Variável | `$var` ou `${var}` |
| Substituição de comando | `$(comando)` |
| Aritmética | `$(( expr ))` |
| Array — todos elementos | `${array[@]}` |
| Array — tamanho | `${#array[@]}` |
| String — tamanho | `${#string}` |
| Substring | `${string:inicio:tamanho}` |
| Substituição em string | `${string/antigo/novo}` |
| Valor padrão | `${var:-padrão}` |
| Teste numérico | `(( a > b ))` |
| Teste com string/arquivo | `[[ condição ]]` |
| Função — argumento 1 | `$1` |
| Código de saída | `$?` |
| PID atual | `$$` |
| Stderr | `2>` ou `>&2` |
| Descartar saída | `> /dev/null 2>&1` |

---

*Bash Scripting — Guia de Sintaxe | Linux*
