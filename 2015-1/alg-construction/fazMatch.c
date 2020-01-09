/*
   Nome da função: fazMatch
   Objetivos: Faz o match de cada candidato para o curso escolhido
   Parametros Formais:
       -match[] (tMatch): Vetor de escolha de cursos ordenado pela nota (Entrada e saída de dados)
       -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
       -candidato[] (tCandidato): Vetor de candidatos (Entrada e saída de dados)
       -curso[] (tCurso): Vetor de cursos (Entrada e saída de dados)
       -nMatch (int): Quantidade de escolhas de curso em match[] (Entrada de dados)
   Retorno: Nenhum (procedimento)
*/
void fazMatch(tMatch match[],int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],tCurso curso[],int nMatch)
{
    int i,j,k; //contadores
    int l;
    /*Match da lista de escolhas*/
    printf("Fazendo match dos candidatos...\n");
    for(i=0;i<nMatch;i++){
        if(candidato[match[i].idCandidato].classificado!=-2){//-2 significa aprovado na 1 opcao
            if (nSelecionados[match[i].idCurso][match[i].grupo-1]<curso[match[i].idCurso].vagas[match[i].grupo]){ //verifica se ja nao foi completado a quantidade de candidatos para cada cota de cada curso
                if(match[i].opcao==1 && candidato[match[i].idCandidato].classificado!=-1){ //se o candidato ja havia passado na 2º chamada, chama o trocaEscola, que vai reoferecer a vaga
                    trocaEscolha(match[i].idCandidato,i,match,nSelecionados,candidato,curso);
                }
                nSelecionados[match[i].idCurso][match[i].grupo-1]++;//aumenta 1 no numero de selecionados
                match[i].classificado=1;//marca verdadeiro em escolhido no controle do match
                if(match[i].opcao==1)//verifica se a opcao de curso é a 1º
                    candidato[match[i].idCandidato].classificado=-2;//marca -2 caso seja a primeira opcao
                else
                    candidato[match[i].idCandidato].classificado=i;//marca o id na lista em que esta localizada a opcao(caso tenha passado na 2 opcao)
                    //esse id sera usado futuramente usado na trocaEscola caso o candidato passe na 1 opcao
            }
        }
    }

    printf("Sucesso ao fazer match dos candidatos!!!\n\n");
}
