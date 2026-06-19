
# Bash: [[ ... ]] e (( ... ))

## Diferença entre [[ ... ]] e (( ... ))

[[ ... ]] é usado para testes lógicos, comparação de strings e arquivos.
(( ... )) é usado para expressões aritméticas e comparações numéricas.
Ambos retornam verdadeiro ou falso para estruturas como if e while.

## Comparações em (( ... ))

### Comparação
Compara valores numéricos.
- (( n1 < n2 )) - Verifica se n1 é menor que n2.
- (( n1 <= n2 )) - Verifica se n1 é menor ou igual a n2.
- (( n1 > n2 )) - Verifica se n1 é maior que n2.
- (( n1 >= n2 )) - Verifica se n1 é maior ou igual a n2.
- (( n1 == n2 )) - Verifica se n1 é igual a n2.
- (( n1 != n2 )) - Verifica se n1 é diferente de n2.

### Operações matemáticas
Executa cálculos com números.
- + : Soma valores.
- - : Subtrai valores.
- * : Multiplica valores.
- / : Divide valores.
- % : Retorna o resto da divisão.
- ** : Calcula potência.

### Atribuições
Atribui valores para variáveis.
- = : Atribui um valor.
- += : Soma e atribui.
- -= : Subtrai e atribui.
- *= : Multiplica e atribui.
- /= : Divide e atribui.
- %= : Calcula o resto e atribui.

### Incremento e decremento
Altera o valor em uma unidade.
- ++ : Incrementa em um.
- -- : Decrementa em um.

### Operadores lógicos
Combina expressões.
- && : Exige que ambas sejam verdadeiras.
- || : Exige que pelo menos uma seja verdadeira.
- ! : Inverte o resultado lógico.

### Operadores bit a bit
Manipula bits individualmente.
- & : AND bit a bit.
- | : OR bit a bit.
- ^ : XOR bit a bit.
- ~ : Complemento bit a bit.
- << : Desloca bits para a esquerda.
- >> : Desloca bits para a direita.

### Operador ternário
Escolhe entre dois valores com base em uma condição.
- condição ? valor1 : valor2

## Comparações em [[ ... ]]

### Comparação de strings
Compara textos.
- == : Verifica se as strings são iguais.
- != : Verifica se as strings são diferentes.
- < : Verifica a ordem lexicográfica.
- > : Verifica a ordem lexicográfica.
- -z : Verifica se a string está vazia.
- -n : Verifica se a string não está vazia.

### Expressões regulares e padrões
Verifica padrões de texto.
- =~ : Compara com expressão regular.
- == padrão* : Compara com padrão glob.

### Testes de arquivos
Verifica propriedades de arquivos.
- -e : Verifica se existe.
- -f : Verifica se é arquivo regular.
- -d : Verifica se é diretório.
- -r : Verifica se é legível.
- -w : Verifica se é gravável.
- -x : Verifica se é executável.
- -s : Verifica se possui conteúdo.
- -L : Verifica se é link simbólico.

### Comparação entre arquivos
Compara arquivos.
- -nt : Verifica qual é mais novo.
- -ot : Verifica qual é mais antigo.
- -ef : Verifica se apontam para o mesmo arquivo.

### Testes numéricos
Compara números.
- -eq : Igual.
- -ne : Diferente.
- -lt : Menor que.
- -le : Menor ou igual.
- -gt : Maior que.
- -ge : Maior ou igual.
