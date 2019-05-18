/*
   Nome da função: toUpperStr
   Objetivos: coloca uma string em upper case
   Parâmetros Formais:
       -str: String para ser colocada em upper case(Entrada e saida de dados)
   Retorno: Nenhum (procedimento)
*/
void toUpperStr(char *str){
    int i;

    for(i = 0; i < strlen(str);i++)
        str[i]=toupper(str[i]);
}
/*
   Nome da função: procuraCandidatos
   Objetivos: imprime os resultados de um candidato especifico
   Parâmetros Formais:
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -nCandidatos: Int com a quantidade de candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void procuraCandidatos(tCandidato candidato[],int nCandidatos,tCurso curso[])
{
    char nome[TAM_NOME];
    int i,k=0;

    printf("Nome do Candidato: ");
    fflush(stdin);
    while(strlen(gets(nome))<3)
    {
        system("cls");
        printf("Digite pelo menos 3 caracteres!\n\nNome do Candidato: ");
    }
    toUpperStr(nome);

    system("cls");

    for(i=0;i<nCandidatos;i++) {
        toUpperStr(candidato[i].nome);
        if(strstr(candidato[i].nome,nome)!=NULL) { // Compara o nome do teclado com os nomes dos candidatos dentro do vetor candidato.
					        // Requer a biblioteca <string.h>.
            k++;
            printf("ID: %d\nNome: %s\n",i,candidato[i].nome);
            printf("1. Opcao:\n\tCurso: %s\n\tGrupo: %d\n\tNota: %.2Lf\n",curso[candidato[i].opcao1.idCurso].nome,candidato[i].opcao1.grupo,candidato[i].opcao1.media);
            if(candidato[i].classificado == -2) {
                printf("Candidato aprovado na 1. Opcao\n");
            }else{
                printf("Candidato nao aprovado na 1. Opcao\n");
            }
            printf("\n2. Opcao:\n\tCurso: %s\n\tGrupo: %d\n\tNota: %.2Lf\n",curso[candidato[i].opcao2.idCurso].nome,candidato[i].opcao2.grupo,candidato[i].opcao2.media);
            if(candidato[i].classificado >=0) {
                printf("Candidato aprovado na 2. Opcao\n");
            }
            else if (candidato[i].classificado == -1)
            {
                printf("Candidato nao aprovado na 2. Opcao\n");
            }
            printf("---------------------------------------------------------------------\n");
        }
    }

    if(k==0)
        printf("Nenhum Candidato com esse nome encontrado.\n");
}
