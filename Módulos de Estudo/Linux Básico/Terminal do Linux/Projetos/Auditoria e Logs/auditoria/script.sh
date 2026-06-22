find *.log
wc -l acessos.log
grep 'LOGIN' acessos.log | wc -l
grep 'FALHA' acessos.log | wc -l

awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | wc -l

awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | sort

awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | head -n 3

awk -F ' ' '!seen[$4]++ {print $4}' acessos.log | tail -n 2


