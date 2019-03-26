/*
   Nome da função: inicializaLista
   Objetivos: Inicializar o vetor match[] e preencher com os dados dos candidatos
   Parâmetros Formais:
       -match[] (tMatch): Vetor de escolha de cursos (Entrada e saída de dados)
       -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
       -candidato[] (tCandidato): Vetor de candidatos (Entrada e saída de dados)
       -nCandidatos (int): Quantidade de candidatos cadastrados (Entrada de dados)
       -nCursos (int): Quantidade de cursos cadastrados (Entrada de dados)
   Retorno: Quantidade de escolhas de curso em match[] (int j)
*/
int inicializaLista(tMatch match[], int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],int nCandidatos,int nCursos)
{
    int i,j; //contadores de laço
    // inializacao do vetor lista com cada candidato tendo a variavel inicializada
    printf("Inicializando lista de classificacao...\n");
    for(i=0;i<MAX_CANDIDATOS;i++)
    {
        match[i].media=0;
    }
    for(i=0;i<nCursos;i++)
    {
        for(j=0;j<N_GRUPOS;j++)
        {
            nSelecionados[i][j]=0;
        }
    }

    j=0; //reaproveitamento do contador
    for(i=0;i<nCandidatos;i++)
    {
        match[j].idCandidato=i;
        match[j].idCurso=candidato[i].opcao1.idCurso;
        match[j].media=candidato[i].opcao1.media;
        match[j].opcao=1;
        match[j].grupo=candidato[i].opcao1.grupo;
        match[j].classificado=0;
        j++;
        if(candidato[i].opcao2.idCurso!=-1)
        {
            match[j].idCandidato=i;
            match[j].idCurso=candidato[i].opcao2.idCurso;
            match[j].media=candidato[i].opcao2.media;
            match[j].opcao=2;
            match[j].grupo=candidato[i].opcao2.grupo;
            match[j].classificado=0;
            j++;
        }
    }

    printf("Lista inicializada!!\n\n");
    return j;//retorna quantos foram colocados na lista
}
