/*
   Nome da função: procuraCurso
   Objetivos: imprime os resultados de um curso especifico
   Parâmetros Formais:
       -match[]: Vetor com os aprovados (Entrada de dados)
       -candidato[]: Vetor com os dados dos candidatos (Entrada de dados)
       -curso[]: Vetor com os dados dos cursos (Entrada de dados)
       -nMatch: Número de aprovados (Entrada de dados)
       -nCursos (int): Quantidade de cursos cadastrados (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void procuraCurso(tMatch match[],int nMatch,tCandidato candidato[],tCurso curso[],int nCursos)
{
    //declaracao das variaveis
    char nome[TAM_NOME];
    int i,j,k;

    //leitura do nome do curso
    printf("Nome do Curso: ");
    fflush(stdin);
    while(strlen(gets(nome))<3)
    {
        system("cls");
        printf("Digite pelo menos 3 caracteres!\n\nNome do Curso: ");
    }
    toUpperStr(nome);

    system("cls");
    //pesquisa para cursos com nome parecido
    for(i=0;i<nCursos;i++) {

        toUpperStr(curso[i].nome);
        if(strstr(curso[i].nome,nome)!=NULL) { // Compara o nome do teclado com os nomes dos candidatos dentro do vetor candidato.
					        // Requer a biblioteca <string.h>.
            k=1;
            //impressao dos alunos aprovados
            printf("-%s-\n\n",curso[i].nome);
            for(j=0; j<nMatch; j++){
                if(match[j].classificado==1 && match[j].idCurso==i){
                    printf("\t%3d. %s %*s %d Grupo: %d Media: %.2Lf\n", k++, candidato[match[j].idCandidato].nome,abs(35-strlen(candidato[match[j].idCandidato].nome)) , "Opcao:" , match[j].opcao, match[j].grupo, match[j].media);
                }
            }

            printf("\n\n");

        }
    }

    //impressao em caso de nenhuma curso possuir o nome
    if(k==0)
        printf("Nenhum Curso com esse nome encontrado.\n");
}
