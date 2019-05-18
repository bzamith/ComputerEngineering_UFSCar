/*
   Nome da função: ordenaLista
   Objetivos: Ordenar a lista de escolhas de curso de acordo com a media
   Parâmetros Formais:
       -match[]: Vetor de escolha de cursos (Entrada e saída de dados)
       -nMatch: Número de candidatos na lista (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void ordenaLista(tMatch match[],int nMatch){
    int i; //contador de laço
    printf("Ordenando Lista...\n");
    /*Ordenação da lista pelo algoritmo qsort*/
    qsort((void *) &match[0], nMatch, sizeof(tMatch),(compfn)compare );
}



