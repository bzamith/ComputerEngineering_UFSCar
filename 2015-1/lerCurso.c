/*
   Nome da função: lerCursos
   Objetivos: Leitura do arquvio CURSOS_FILE, com os dados do curso
   Parâmetros Formais:
       -curso[]: Vetor de tCurso (Entrada e saída de dados)
   Retorno: Número de cursos lidos (int nCursos)
*/
int lerCursos(tCurso curso[])
{
    FILE *ifp; //Identificação do Arquivo
    char *mode = "r"; //Modo Leitura (Somente)
    int i,nCursos,j; //Declaração de Variáveis
    char nomeTemp[TAM_NOME];

    ifp = fopen(CURSOS_FILE, mode);

    // Caso não encontre o Arquivo para o programa
    if (ifp == NULL) {
        printf("Erro na abertura do arquivo %s\n",CURSOS_FILE);
        system("pause");
        exit(1);
    }

    // Recupera a Quantidade de Cursos
    fscanf(ifp, "%d", &nCursos);

    // Inicia a leitura do Arquivo de Cursos
    printf("Lendo lista de cursos...\n");
    for(i=0;i<nCursos;i++){

        //Leitura do Nome do Curso
        fscanf(ifp,"%s",nomeTemp);

        //correcao do nome
        for( j = 0;j < strlen(nomeTemp); j++){
            if(nomeTemp[j]==95){
                nomeTemp[j]=32;
            }
        }
        strcpy(curso[i].nome,nomeTemp);

        // Após Ler o Nome do Curso recupera a quantidade de Vagas de Cada Grupo
        fscanf(ifp, "%d %d %d %d %d", &curso[i].vagas[1],&curso[i].vagas[2],&curso[i].vagas[3],&curso[i].vagas[4],&curso[i].vagas[5]);

        // Vaga[0] Grava total de vagas oferecida pelo curso
        curso[i].vagas[0] = curso[i].vagas[1]+curso[i].vagas[2]+curso[i].vagas[3]+curso[i].vagas[4]+curso[i].vagas[5];

        // Lê os Pesos
        fscanf(ifp, "%lf %lf %lf %lf %lf", &curso[i].pesos.humanas,&curso[i].pesos.linguagens,&curso[i].pesos.matematica,&curso[i].pesos.natureza,&curso[i].pesos.redacao);

    }

    // Informa o Sucesso ao importar todos os cursos
    printf("Sucesso ao importar %d cursos!\n\n", nCursos);

    // Fecha o Arquivo
    fclose(ifp);

    // Retorna Quantidade de Curso Lida
    return nCursos;
}
