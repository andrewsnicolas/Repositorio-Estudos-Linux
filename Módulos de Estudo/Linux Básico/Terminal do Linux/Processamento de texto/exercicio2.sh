#mkdir auditoria && cd "$_"
#"$_" garante que o último parametro seja reutilizado nesse
#torch acessos.log
cd auditoria
cat acessos.log
cat acessos.log > acessos_backup.log
#grep -i ~ ignora upper e lower case
#wc -l ~ conta apenas as linhas

alias contar='wc -l'
alias falhas='grep "FALHA" acessos.log'

#Exibe todas as linhas que tenham estas palavras
grep 'LOGIN' acessos.log 
grep 'FALHA' acessos.log

#Conta a quantidade de linhas que serão geradas de logins com falhas
falhas | wc -l

cut -s -d ' ' -f 3 acessos.log #Obtém só os nomes
#-s --> Remove as linhas sem delimitador
#-d --> Adiciona o limitador que personalizado
#-f --> Permite especificar o número da coluna

cut -s -d ' ' -f 3 acessos.log | sort
#Faz a organização em ordem alfabética

#Mostra todos os usuários sem repetição
awk -F ' ' '!seen[$3]++ {print $3}' acessos.log
#AWK - trata tudo como uma tabela
#-F me permite escolher o separador de colunas. Escolhido: ' '
#{print $3} -imprime a 3° coluna do arquivo 

awk -F ' ' '!seen[$3]++ {print $3}' acessos.log | wc -l #Conta as linhas

awk -F ' ' '!seen[$3]++ {print $3}' acessos.log | head -n 3 #Mostra as 3 primeiras linhas 
awk -F ' ' '!seen[$3]++ {print $3}' acessos.log | tail -n 2 #Mostra as 2 últimas linhas

less acessos.log # less é o visualizador e paginalizador
#Permite abrir arquivos em formato de página

cat acessos.log | tr '[:upper:]' '[:lower:]' #Converte todo o texto em caixa baixa

cd ../
./maiorPalavra.sh
