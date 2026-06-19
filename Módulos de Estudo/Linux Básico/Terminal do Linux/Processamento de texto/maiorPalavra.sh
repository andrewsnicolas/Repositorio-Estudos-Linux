cd audioria;
contLinhas=0;
contArquivo=0;
declare -a linhas;
declare -a ocorrencias;
maiorIndex=0;
awk -F ' ' 'seen[$3] {print $3}' | wc -l > teste.txt;
while(( contLinhas <= $(wc -l teste.txt) ));
do
	if((contVetor==0)); then
		linhas[$contVetor]="$(head -n 1 teste.txt)";
		ocorrencias[$contVetor]=0;
	else
		if[["$linhas[$contLinhas]" == "$(sed -n '$contArquivo{p;q}' teste.txt)"]]; then
			((ocorrencias[$contLinhas]++));
		else
			if((ocorrencias[$maiorIndex]<ocorrencias[$contLinhas]));
			then
				maiorIndex=$contLinhas;
			fi
			((contLinhas++));
			ocorrencias[$contLinhas] = 0;
			linhas[$contLinhas] = sed -n '$contArquivo{p;q}' teste.txt;
		fi
	fi
((contArquivo++));
done
rm -f teste.txt
echo "{$linhas[$maiorIndex]}"
