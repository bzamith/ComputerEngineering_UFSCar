/*
Trabalho apresentado a disciplina de Organização e Recuperação da informação, ministrada pelo docente Jander Moreira, na Universidade Federal de São Carlos - UFSCar
Objetivo: Criar um arquivo de formato .sar, contendo todos os diretórios, sub-diretórios e arquivos de um dado diretório, e a partir deste arquivo, conseguir recuperar todos os dados(mais informações no READ-ME). Como objetivo para a disciplina, é necessário a utilização de alguma técnica de organização de arquivos, tais como o uso de índice.
Data: 08/12/2016

Autores:                         RA:
Bruna Zamith Santos                 628093
João Victor Pacheco                 594970
Marcos Augusto Faglioni Junior      628301
*/
//Lê bibliotecas
#include<stdio.h>
#include<iostream>
#include<string.h>
#include <stdlib.h>
#include <sys/types.h>
#include <dirent.h>
#include "FuncaoC.h"
#include "FuncaoL.h"
//Programa executado somente em plataforma Windows, condicional para a adição de biblioteca para o Windows.
#ifdef _WIN32
    #include "FuncaoE.h"
#endif // _WIN32

using namespace std;

//Constantes
static const string PSAR = "sar";

//Prototipo das funções
//Função verificaComandoQuit()
//Objetivo: Verificar se o comando digitado pelo usuário é -quit
//Parametros formais: string sar - Deve conter a palavra sar, uma vez que o comando necessita ser $ sar -quit
//                    string comando - Comando a ser verificado se é igual a -quit
//Retorno:            Se sar == sar e comando == -quit, o retorno vale 1, se não 0

bool verificaComandoQuit (string sar, string comando);
//Função verificaComandoValido()
//Objetivo: Verificar se o comando digitado pelo usuário é -c, -e ou -l
//Parametros formais: string sar - Deve conter a palavra sar, uma vez que o comando necessita ser $ sar -comando
//                    string comando - Comando a ser verificado se é igual a -a, -c, -e ou -l (comandos aceitos pelo programa)
//Retorno:            Se sar == sar e comando == (-a || -c || -e || -l), o retorno vale 1, se não 0
bool verificaComandoValido (string sar, string comando);

//Função principal
//Objetivo: Instanciar as funções de criação/armazenamento, leitura e extração do arquivo .sar, oferencendo uma interface simles e acessivel(dentro do escopo da disciplina)
//Parametros formais: Sem parametros
//Retorno:            Sem retorno
int main(){
    string comando;                                            //Armazena o comando (-a, -e, -c, -l, -quit)
    string sar;                                                //Armazena o sar
    string nome;                                               //Variavel nome (recebe o nome do diretorio, no caso de -c, e o nome do arquivo no caso de -l e -e)
    bool retorno;                                              //Verifica o retorno das funções e, c e l

    cout<<"Digite o comando(sar -a [] para ajuda):"<<endl;     //Questiona o usuário sobre a primeira ação
    cin>>sar>>comando>>nome;                                   //Recebe o comando digitado pelo usuário

    while(!verificaComandoQuit(sar, comando)){                 //Mantem a execução do programa até comando ser -quit
        while(!verificaComandoValido(sar, comando)){           //Mantem a execução até receber um comando válido
            cout<<"Comando invalido!";
            cout<<endl<<endl<<"Pressione qualquer tecla para continuar";
            getchar();                                         //È necessário o comando duplicado pois o getchar lê o endl como entrada, assim, somente um getchar não pausa o programa
            getchar();
            #ifdef _WIN32
                system("cls");
            #else
                system("clear");
            #endif // _WIN32

            cout<<"Digite o comando(sar -a [] para ajuda):"<<endl;
            cin>>sar>>comando>>nome;

            if(verificaComandoQuit(sar, comando))
                break;
        }

        if(verificaComandoQuit(sar, comando))
                break;

        else if(comando=="-c"){                                //Caso comando == c, o programa instancia a função c
            retorno = funcaoC(nome);
        }

        else if(comando=="-e"){                                //Caso comando == e, o programa instancia a função e
            #ifdef _WIN32
                retorno = funcaoE(nome);
            #else
                cout<<endl<<endl<<"Ate a presente versão este comando nao e suportado em maquinas com o sistema operacional MAC ou linux"<<endl;
                retorno = 0;
            #endif // _WIN32
        }
        else if(comando=="-l"){                                //Caso comando == l, o programa instancia a função l
            retorno = funcaoL(nome);
        }

        else{                                                  //Caso comando n for nenhuma das opções acima, ele será -a, e assim é exibido um painel de ajuda
            cout<<endl<<"Opcoes e argumentos da funcao sar:"<<endl;
            cout<<"-a []     :Exibe ajuda, abre este terminal"<<endl;
            cout<<"-c [dir]  :Cria ou sobrescreve um arquivo com todo o conteudo do diretorio dir; O arquivo recebera o nome de dir"<<endl;
            cout<<"-e [arq]  :Extrai todos os arquivos e pastas do arquivo arq"<<endl;
            cout<<"-l [arq]  :Lista todos os arquivos, pastas e sub-pastas existentes no arquivo arq"<<endl;
            cout<<"-quit []  :Encerra o programa"<<endl<<endl;
            retorno = 1;
        }


        if(retorno)
            cout<<endl<<"Processo concluido com sucesso!";
        else if(retorno == 0)
            cout<<"Erro na execução do processo!";

        cout<<endl<<"Pressione qualquer tecla para continuar\n";
        getchar();                                                       //Duplicidade explicada acima
        getchar();

        #ifdef _WIN32
            system("cls");
        #else
            system("clear");
        #endif // _WIN32

        cout<<"Digite o comando(sar -a [] para ajuda):"<<endl;
        cin>>sar>>comando>>nome;
    }
    cout<<"\n*----------------PROGRAMA ENCERRADO----------------*"<<endl;//Avisa ao usuário que encerrou o programa
}


//Declaração das funções
bool verificaComandoQuit (string sar, string comando){
    if((comando=="-quit")){
            if(sar==PSAR)
                return 1;}
    else
        return 0;
}

bool verificaComandoValido (string sar, string comando){
    if((comando=="-c" || comando =="-e" || comando=="-l" || comando=="-a")){
            if(sar==PSAR)
                return 1;}
    else
        return 0;
}
