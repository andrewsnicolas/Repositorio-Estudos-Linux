#Resolução da proposta de exercício de comandos básicos
mkdir empresa
cd empresa
touch arquivo1.txt arquivo2.txt arquivo3.txt teste.txt antigo.txt
mkdir pastaA pastaB pastaC

#Adiciona o conteúdo nos arquivos
echo "Relatorio financeiro" > arquivo1.txt
echo "Relatorio comercial" > arquivo2.txt
echo "Relatorio tecnico" > arquivo3.txt
echo "Arquivo temporario" > teste.txt
echo "Arquivo legado" > antigo.txt

#Verifica o conteúdo de todos os arquivos txts
cat *.txt 

#Cria os backups
cp arquivo1.txt arquivo1_backup.txt
cp arquivo2.txt arquivo2_backup.txt
cp arquivo3.txt arquivo3_backup.txt

mkdir backup
mv *backup.txt backup

mkdir temporarios
mv temporarios arquivos_temporarios

pwd
ls


mkdir documentos antigo
mv arquivo?.txt documentos
mv antigo.txt antigo
rm teste.txt
rm -rf pastaA pastaB pastaC arquivos_temporarios
