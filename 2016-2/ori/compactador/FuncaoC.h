/*
FUN��O -C - Fun��o para o arquivo FuncaoPrincipal.cpp
Trabalho apresentado a disciplina de Organiza��o e Recupera��o da informa��o, ministrada pelo docente Jander Moreira, na Universidade Federal de S�o Carlos - UFSCar
Objetivo: Criar um arquivo .sar, que contenha todos os diret�rios e sub-diret�rios de uma pasta especifica. Al�m deste a fun�ao deve criar um indicador para pasta e outro para arquivo, indicando o tamanho do arquivo em seguida a sua indica��o.
Data: 08/12/2016

Autores:                         RA:
Bruna Zamith Santos                 628093
Jo�o Victor Pacheco                 594970
Marcos Augusto Faglioni Junior      628301
*/
//L� bibliotecas
#pragma once
#include<stdio.h>
#include<iostream>
#include<string.h>
#include<stdlib.h>
#include<sys/types.h>
#include<dirent.h>
#include<fstream>
#include<sys/stat.h>
#include<vector>
#include<sstream>
using namespace std;

//Constantes
static const string EXTENSAO = ".sar";

//Template
template <typename T>

//Fun��o ToString()
//Objetivo: Converter dados de qualquer tipo de dado (int,  char, float, char) para uma string
//Parametros formais: T Number - Um dado contendo um valor
//Retorno:            Retorna o dado em forma de string
string ToString ( T Number )
{
	stringstream ss;
	ss << Number;
	return ss.str();
}

//Fun��o analisaHierarquia()
//Objetivo: Analisar a hierarquia da pasta dada; Esta fun��o � respons�vel por receber a pasta selecionada pelo usu�rio, e percorre a pasta, armazenando separadamente pastas de arquivos, e suas respectivas posi��es;
//Parametros formais: vector<string>& hierarquiaArquivos        - Vetor que armazenar� os arquivos encotrados
//                    vector<string>& hierarquiaDiretorios      - Vetor que armazenar� os diret�rios encontrados
//                    string nomeDiretorio                      - Nome do diret�rio que ser� analisado
//Retorno:            Vazio (todas as variaveis s�o passadas por referencia e com isso as vari�veis de entrada, possuem o resultado das opera��es realizadas pela fun��o
void analisaHierarquia(vector<string>& hierarquiaArquivos, vector<string>& hierarquiaDiretorios, string nomeDiretorio){
    string criaNome;
    string nomeAtual;
    DIR *dp;
    struct dirent *ep;
    string ultimoDiretorio;

    dp = opendir(nomeDiretorio.c_str());

    if (dp != NULL){
        while (ep = readdir(dp)){
            nomeAtual=(ep->d_name);
            if (nomeAtual.find(".")!=-1){
                criaNome=nomeDiretorio+"/"+nomeAtual;
                hierarquiaArquivos.push_back(criaNome);
            }
            if (nomeAtual.find(".")==-1 && nomeAtual!="." && nomeAtual!=".." && nomeAtual.find(".sar")==-1){
                criaNome=nomeDiretorio+"/"+nomeAtual;
                hierarquiaDiretorios.push_back(criaNome);
                ultimoDiretorio=hierarquiaDiretorios[(hierarquiaDiretorios.size())-1];
                analisaHierarquia(hierarquiaArquivos,hierarquiaDiretorios,ultimoDiretorio);
            }
        }
    }
    (void) closedir (dp);
}

//Fun��o funcaoC()
//Objetivo: Armazenar os dados de um diret�rio, gerenciar o arquivo e as chamadas de analisaHierarquia. Esta tamb�m � respons�vel por incluir os diferenciadores entre pastas(&) e arquivos(*), e no caso de arquivo, insere o tamanho do arquivo.
//Parametros formais: string nomeDiretorio      - Nome do diret�rio que ser� analisado
//Retorno:            bolleano                  - Retorna 1 se o diret�rio existe e foi possivel executar a fun��o, caso contrario, 0.
bool funcaoC(string nomeDiretorio){
    ofstream arquivoEscreve;
    ifstream arquivoLe;
    string nomeArquivo;
    string line;
    vector<string> hierarquiaArquivos;
    vector<string> hierarquiaDiretorios;

    //Salva como nome.sar
    nomeArquivo=nomeDiretorio+EXTENSAO;

    //Salva como ./diretorio
    nomeDiretorio="./"+nomeDiretorio;

    //Analisa Hierarquia
    analisaHierarquia(hierarquiaArquivos, hierarquiaDiretorios, nomeDiretorio);

    //Abre o arquivo para escrita
    arquivoEscreve.open(nomeArquivo.c_str(), ios::binary|ios::out);

    //Escreve no arquivo
    ifstream arquivoAcessa;
    string acessaNome;
    string linha;
    //Escreve a hierarquia de Diretorios
    arquivoEscreve<<"&["<<nomeDiretorio.length()<<"]"<<nomeDiretorio<<endl;

    for(int i=0; i<hierarquiaDiretorios.size(); i++)
        arquivoEscreve<<"&["<<hierarquiaDiretorios[i].length()<<"]"<<hierarquiaDiretorios[i]<<endl;

    //Escreve a hierarquia de Arquivos
    for(int i=0; i<hierarquiaArquivos.size(); i++){
        arquivoEscreve<<"*["<<hierarquiaArquivos[i].length()<<"]"<<hierarquiaArquivos[i]<<endl;
        //Escreve o conteudo dos Arquivos
        arquivoAcessa.open(hierarquiaArquivos[i].c_str(), ios::binary|ios::in);

        if (arquivoAcessa.is_open()){

            while(getline(arquivoAcessa,linha) ){
                arquivoEscreve<<"#"<<linha<<'\n';
            }
            arquivoAcessa.close();
        }
    }

    //Fecha o arquivo para escrita
    arquivoEscreve.close();
    return 1;
}
