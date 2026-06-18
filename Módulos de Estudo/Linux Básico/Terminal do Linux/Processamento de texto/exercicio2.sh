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
grep 'LOGIN' acessos.log
grep 'FALHA' acessos.log
wc -l $(falhas)
