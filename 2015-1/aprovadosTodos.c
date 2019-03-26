/*
   Nome da função: aprovadosTodos
   Objetivos: Imprimir todos os aprovados
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void aprovadosTodos(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[])
{
    int i,j=1;					//Variáveis para controle de laço
    FILE *ifp;
    char *mode = "w+";			//Cria arquivo vazio para leitura e escrita

    ifp = fopen(OUTPUT_TODOS_FILE, mode);	// OUTPUT_TODOS_FILE = aprovados_todos.csv

    if (ifp == NULL) {
        printf("Erro na abertura do arquivo %s\n",OUTPUT_TODOS_FILE);
        return;
    }

	//Impressão dos dados

    printf("Exportando dados para o arquivo...\n\n");
    //printf("Classificados:\n\n");								//imprime na tela
    fprintf(ifp,"Posicao;Nome;Curso;Opcao;Grupo;Media\n");		//imprime no arquivo
    for(i=0;i<nMatch;i++)
    {
        if(match[i].classificado==1)
        {
        	//imrpime na tela:
            //printf("%3d. %10s %25s Opcao: %d Grupo: %d Media: %.2Lf\n",j,candidato[match[i].idCandidato].nome,curso[match[i].idCurso].nome,match[i].opcao,match[i].grupo,match[i].media);
            //imprime no arquivo:
            fprintf(ifp,"%d;%s;%s;%d;%d;%.2Lf\n",j++,candidato[match[i].idCandidato].nome,curso[match[i].idCurso].nome,match[i].opcao,match[i].grupo,match[i].media);
        }
    }
    //limpa a tela
    system("cls");
    printf("Dados exportados para o arquivo: %s\n",OUTPUT_TODOS_FILE);

    fclose(ifp);
}
