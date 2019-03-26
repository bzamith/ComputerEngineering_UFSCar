#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

typedef struct Node
{
    int folha; // indica se o nó é folha=1, interno=2 ou raiz=0
    int qtd_chaves; // Indica quantas chaves existem no nó para saber se ele está cheio ou não
    int ordem;
    int *chave;// vetor que armazena as chaves da árvore. Este vetor tem o tamanho da qtde de filhos -1
    struct Node** filho;// tam indica o quantos filhos a arvore pode ter, ou seja, a ordem da árvore

}Node;

//Cabeçalhos de Função

int Busca_Na_Arvore(Node *atual_buscar, int valor_chave, int *posicao);
Node* Cria_Arvore(int t);
int insira (Node *raiz, int novaChave);
int Busca_Para_Inserir(Node *noAtual, int novaChave, int *houvePromocao, int *chavePromovida, Node *novoNo);
void divida(Node *atual_inserir, int valor_chave, Node *direita, Node *novo_no, int *chave_promovida);

Node* Cria_Arvore(int t)
{
    int i;
    Node *arvore;

    arvore = (Node *)(malloc(sizeof(Node)));
    arvore->chave = (int*)(malloc((t - 1) * sizeof(int)));
    arvore->filho = (Node**)(malloc(t * sizeof(Node)));

    arvore->ordem = t;// ordem da arvore

    arvore->folha = 1; // (1) É nó folha; (0) Não é nó folha;
    arvore->qtd_chaves = 0; // Não tem chaves no nó

    for(i = 0; i < t; i++)
    {
        arvore->filho[i] = NULL; // como a arvore acabou de ser criada os filhos estão apondados para null
    }
    return arvore;
}


int Busca_Na_Arvore(Node *atual_buscar, int valor_chave, int *posicao)
{

    int i,tam;
    tam = atual_buscar->qtd_chaves;
    int verifica_aux;
    verifica_aux = 0;  //Variável auxiliar para verificar se a chave foi encontrada

    if (atual_buscar == NULL) // Se o nó a ser verificado for um ponteiro nulo, retorna falso
    {
        printf("Arvore vazia");
        return 0;
    }

    else
    {

        for (i=0; i<tam; i++)    //Faz a varredura no nó atual em busca da chave
        {
            if (atual_buscar->chave[i]==valor_chave)  //Verifica todos as chaves do nó em busca da chave
            {
                *posicao=i;      // Retorna a posição do indice da chave
                verifica_aux = 1;
            }
        }

        if (verifica_aux==1)                      //Caso a chave tenha sido encontrada no laço
            return 1;

        else
        {
            if(atual_buscar->folha==1)               //Se o nó atual já for um nó folha, retorna falso, encerra busca
                return 0;

            else                                     //Senão determina qual o nó filho a ser realizada a busca de acordo com as regras da árvore B
            {
                if (valor_chave > atual_buscar->chave[tam-1])
                    Busca_Na_Arvore(atual_buscar->filho[i+1], valor_chave, posicao);
                else
                {
                    for (i=0; i<tam; i++)
                    {
                        if (valor_chave < atual_buscar->chave[i])
                            Busca_Na_Arvore(atual_buscar->filho[i], valor_chave, posicao); //Envia o filho recursivamente para a função busca
                    }
                }
            }
        }

    }
}


int insira (Node *raiz, int novaChave){

    if (raiz == NULL){
        raiz->folha=1;
        raiz->chave[0]=novaChave;
        (raiz->qtd_chaves)++;
        raiz->filho[0]=NULL;
        raiz->filho[1]=NULL;
        return 1;
    }
    else{
        int status;
        int houvePromocao;
        int chavePromovida;
        Node *novoNo;
        status = Busca_Para_Inserir(raiz, novaChave, &houvePromocao, &chavePromovida, novoNo);
        if (houvePromocao == 1){
            Node *novaRaiz;
            raiz->folha=2;
            novaRaiz->chave[0]=chavePromovida;
            novaRaiz->qtd_chaves++;
            novaRaiz->filho[0]=raiz; // ou raiz
            novaRaiz->filho[1]=novoNo;  //ou novoNo
            raiz=novaRaiz;
        }
        return status;
    }

}

int Busca_Para_Inserir(Node *noAtual, int novaChave, int *houvePromocao, int *chavePromovida, Node *novoNo){
    //verificação se novaChave ja existe em noAtual
    int i;
    for(i=0; i<(noAtual->qtd_chaves); i++){
        if (novaChave==(noAtual->chave[i])){
            return 0;
        }
    }
    if((noAtual->folha)==1){
        if((noAtual->qtd_chaves)<((noAtual->ordem)-1)){
            int indice;
            int j;
            for(j=0; j<(noAtual->qtd_chaves); j++){
                if((noAtual->chave[j])>novaChave){
                    indice=j;
                }
            }
            if(novaChave>(noAtual->chave[j-1])){
                indice=j;
            }
            for(j=(noAtual->qtd_chaves); j>indice; j--){
                (noAtual->chave[j])=(noAtual->chave[j-1]);
                (noAtual->filho[j+1])=(noAtual->filho[j]);
            }
            noAtual->chave[indice]=novaChave;
            noAtual->filho[indice+1]=NULL;
            noAtual->qtd_chaves++;
            *houvePromocao=0;
        }
        else{
            divida(noAtual, novaChave, NULL, novoNo, &chavePromovida);
            *houvePromocao=1;
        }
        return 1;
    }
    else{
        int indice=0;
        while(novaChave>(noAtual->chave[indice])&&(indice<(noAtual->qtd_chaves-1))){
            indice++;
        }
        if(novaChave>(noAtual->chave[indice])){
            indice++;
        }
        int status=Busca_Para_Inserir(noAtual->filho[indice], novaChave, houvePromocao, chavePromovida, novoNo);
        if ((status==1)&&(*houvePromocao==1)){
            if((noAtual->qtd_chaves)<((noAtual->ordem)-1)){
                int indicePromovida;
                int p;
                for(p=0; p<(noAtual->qtd_chaves); p++){
                    if((noAtual->chave[p])>*chavePromovida){
                        indicePromovida=p;
                    }
                }
                if(*chavePromovida>(noAtual->chave[p-1])){
                    indicePromovida=p;
                }
                for(p=(noAtual->qtd_chaves); p>indicePromovida; p--){
                    (noAtual->chave[p])=(noAtual->chave[p-1]);
                    (noAtual->filho[p+1])=(noAtual->filho[p]);
                }
                noAtual->chave[indicePromovida]=*chavePromovida;
                noAtual->filho[indicePromovida+1]=novoNo;
                noAtual->qtd_chaves++;
                *houvePromocao=0;
            }
            else{
                Node *novoFilho;
                divida(noAtual, *chavePromovida, novoNo, novoFilho, chavePromovida);
                novoNo=novoFilho;
            }
        }
    }
}

void divida(Node *atual_inserir, int valor_chave, Node *direita, Node *novo_no, int *chave_promovida)
{
    int i = 0;
    novo_no = Cria_Arvore(atual_inserir->ordem);
    int med = (floor(atual_inserir->qtd_chaves)/2);
    if(  valor_chave < atual_inserir->chave[med])
    {
        for(i = 0; i < (atual_inserir->qtd_chaves - med); i++) //copia os valores da mediana pra frente do nó atual para um nó a direitta
        {
            novo_no->chave[i] = atual_inserir->chave[med+i];
        }

        atual_inserir->chave[med] = valor_chave;
        novo_no->filho[med+1] = direita;
    }
    else
    {
        novo_no->chave[0] = valor_chave;
        for(i = 1; i < (atual_inserir->qtd_chaves - med); i++) //copia os valores da mediana pra frente do nó atual para um nó a direitta
        {
            novo_no->chave[i] = atual_inserir->chave[med+1+i];
        }

        novo_no->filho[1] = direita;
    }


    novo_no->filho[0] = atual_inserir->filho[med+1];

    atual_inserir->qtd_chaves--;


    //verificar entre os nós atuais qual é a chave mediana (inclusive entre a chave a ser inserida)
    //inserir o valor da mediana no nó pai
    //criar no da direita da chave inserida no no pai
    // inserir os valores maiorres que achave inserida nesse no
}

int main ()
{
    Node *inicio;

    int  ordem = 3, escolha = 0, insere, busca;
    char entrada[25];
    char aux[10];


    printf ("\nARVORE B - Cria, Busca e Insere em uma Arvore B\n");

    printf ("\nInstrucoes: \n");
    printf ("arvoreB -t [ordem] - Cria a Arvore B com a ordem especificada em numero inteiro\n\n");

    gets(entrada);
    strncpy(aux,entrada,9);      //Copia os 9 primeiros caracteres da entrada para a verificacao
    aux[9]='\0';

    while  (strcmp(aux,"arvoreB -"))
    {
        while (entrada[9] != 't')  // Enquanto não for t repete o comando inválido
               {
                   printf("\nComando invalido, digite novamente\n");
                    {
                        strncpy(aux,entrada,9);
                        aux[9]='\0';
                    }
               }
    }

    if(entrada[9]=='t')   //Caso seja t, obtém a ordem da árvore
    {
        printf ("Digite a ordem: ");
        scanf("%d",&ordem);
        inicio = Cria_Arvore(ordem);//Chama a função de criar árvore
    }

    while (escolha != 3)
    {
        printf ("Escolha uma das opcoes: \n");              //Obtém a escolha do usuário quanto a inserção, busca e sair
        printf ("1 - Insercao, 2 - Busca, 3 - Sair\n");
        scanf("%d",&escolha);

        switch(escolha)
        {
        case 1:                                                         //Obtém o valor a ser inserido e chama a função insere
            printf("Insercao. Digite o valor a ser inserido: \n");
            scanf("%d",&insere);
            insira (inicio, insere);//coloca a função de iserir
            break;

        case 2:                                                         //Obtém o valor a ser buscado e chama a função busca
            printf("Busca. Digite o valor a ser buscado: \n");
            scanf ("%d\n",&busca);
            int posicao=0;
            Busca_Na_Arvore(inicio, busca, &posicao);                  //coloca a funcao de busca
            printf("Posicao: %d\n", posicao);
            break;

        case 3:                                                         //Finaliza o programa
            printf ("Programa finalizado\n");
            escolha=3;
            break;

        default:                                                        //Programa finaliza
            printf("Opcao invalida. \n");
            escolha=3;
            break;
        }
    }

    return 0;

}
