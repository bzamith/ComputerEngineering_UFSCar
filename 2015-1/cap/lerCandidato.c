/*
   Nome da função: lerCandidatos
   Objetivos: Ler dados dos candidatos do arquivo
   Parâmetros Formais:
       -candidato[]: Vetor de tCandidato (Entrada e saída de dados)
       -curso[]: Vetor de tCurso (Entrada e saída de dados)
   Retorno: Número de candidatos lidos (int nCandidatos)
*/
int lerCandidatos(tCandidato candidato[],tCurso curso[])
{
    //declaracao das variaveis
    int nCandidatos;
    FILE *ifp;
    char *mode = "r";
    char nomeTemp[TAM_NOME];
    int i,j;

    //leitura do arquivo e teste de validade
    ifp = fopen(CANDIDATOS_FILE, mode);

    if (ifp == NULL) {
        printf("Erro na abertura do arquivo %s\n",CANDIDATOS_FILE);
        system("pause");
        exit(1);
    }

    //leitura do numero max de candidatos
    printf("Lendo lista de candidatos...\n");
    fscanf(ifp, "%d", &nCandidatos);

    //leitura dos cursos
    for(i=0;i<nCandidatos;i++)
    {
        fscanf(ifp,"%s",nomeTemp);

        //correcao do nome
        for( j = 0;j < strlen(nomeTemp); j++){
            if(nomeTemp[j]==95){
                nomeTemp[j]=32;
            }
        }
        strcpy(candidato[i].nome,nomeTemp);

        //leitura das notas e escolhasa de curso
        fscanf(ifp,"%Lf %Lf %Lf %Lf %Lf",&candidato[i].notas.humanas,&candidato[i].notas.linguagens,&candidato[i].notas.matematica,&candidato[i].notas.natureza,&candidato[i].notas.redacao);
        fscanf(ifp,"%d %d %d %d",&candidato[i].opcao1.idCurso,&candidato[i].opcao1.grupo,&candidato[i].opcao2.idCurso,&candidato[i].opcao2.grupo);

        //calculo da media para o curso escolhido
        candidato[i].opcao1.media = mediaCandidato(i,1,candidato,curso);
        candidato[i].opcao2.media = mediaCandidato(i,2,candidato,curso);
        candidato[i].classificado = -1; // inicialização para nao classificado
    }

    //fechando o arquivo de entrada
    fclose(ifp);

    printf("Sucesso ao importar %d candidatos!!\n\n",nCandidatos);

    //retorno
    return nCandidatos;
}
