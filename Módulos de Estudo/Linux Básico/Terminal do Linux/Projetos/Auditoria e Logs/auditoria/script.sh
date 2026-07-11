#Encontra todos os arquivos .log
find *.log

#Diz a quantidade total de eventos
wc -l acessos.log

#Diz a quantidade de LOGINs
grep 'LOGIN' acessos.log | wc -l

#Diz a quantidade de FALHAs
grep 'FALHA' acessos.log | wc -l

#Diz a quantidade de usuários diferentes
awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | wc -l

#Diz os usuários em ordem alfabética
awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | sort

#Diz os 3 primeiros usuários
awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | head -n 3

#Diz os 2 últimos usuários
awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | tail -n 2

#Separa os usuários de falha para tratamento
grep "FALHA" acessos.log | sort -k4 > teste.txt


awk -F ' ' '{print substr($2, 1, 2)}' acessos.log | sort -k 2 > teste.txt





