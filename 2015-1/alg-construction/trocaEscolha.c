/*
   Nome da função: trocaEscolha
   Objetivos: Função chamada na fazMatch quando um candidato que ja havia
   passado em sua 2º opção, passa na 1º opção, a fim de reoferecer a vaga.
   Parametros Formais:
        -id: ID do candidato(int) (Entrada de dados)
        -pos: posição atual do contador de laço na função anterior(determina até que ponto a busca para o reoferecimento da vaga deve ocorrer)(int) (Entrada de dados)
        -match[]: Vetor contendo os aprovados (Entrada e saída de dados)
        -nSelecionados[MAX_CURSOS][N_GRUPOS] (int): matriz contendo a quantidade de candidatos já alocados para cada curso e grupo (Entrada e saída de dados)
        -candidato[]: vetor de candidatos (Entrada e saída de dados)
        -curso[]: vetor de cursos (Entrada e saída de dados)
   Retorno: Nenhum (procedimento)
*/
void trocaEscolha(int id, int pos,tMatch match[],int nSelecionados[MAX_CURSOS][N_GRUPOS],tCandidato candidato[],tCurso curso[])
{
	//declaracao de variaveis
    int i,j,achou=0;
    i=candidato[id].classificado;//candidatos classificados
    nSelecionados[match[i].idCurso][match[i].grupo-1]--; //decrementa em uma unidade os Selecionados
    match[i].classificado=0; //marca falso no controle do match
    j=i+1;


    while(j<pos&&achou==0)
    {
    	//verifica se candidato passou na segunda opcao
        if(candidato[match[j].idCandidato].classificado!=-2 && match[j].idCurso==match[i].idCurso && match[j].grupo==match[i].grupo){

            achou=1;
            //verifica se o candidato passou na primeira opcao e realiza a troca da segunda com a primeira
            if (candidato[match[j].idCandidato].classificado!=-1){
                trocaEscolha(match[j].idCandidato,j,match,nSelecionados,candidato,curso);
            }
            nSelecionados[match[j].idCurso][match[j].grupo-1]++; //encrementa os nSelecionados
            match[j].classificado=1;//verifica se esta classificado
            if(match[j].opcao==1)
                candidato[match[j].idCandidato].classificado=-2; //recebe -2 caso esteja classificado na primeira opcao
            else
                candidato[match[j].idCandidato].classificado=j; //marca o id na lista
        }
        j++;
    }

}
