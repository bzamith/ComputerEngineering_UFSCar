/*
FUNÇÂO -E - Função para o arquivo FuncaoPrincipal.cpp
Trabalho apresentado a disciplina de Organização e Recuperação da informação, ministrada pelo docente Jander Moreira, na Universidade Federal de São Carlos - UFSCar
Objetivo: A partir de uma arquivo .sar, o programa realiza a extração do arquivo, criando as pastas e arquivos mantendo a hierarquia anterior ao armazenamento.
Data: 08/12/2016

Autores:                         RA:
Bruna Zamith Santos                 628093
João Victor Pacheco                 594970
Marcos Augusto Faglioni Junior      628301
*/
//Lê bibliotecas
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
#include<windows.h>

using namespace std;

//Função funcaoE()
//Objetivo: Extrai o arquivo com formato .sar, para sua coniguração original
//Parametros formais: string nomeArquivo        - Nome do diretório que será analisado
//Retorno:            bolleano                  - Retorna 1 se o arquivo existe e se foi possivel executar a função, caso contrario, 0.
bool funcaoE(string nomeArquivo){
    ifstream arquivoLe;
    ofstream arquivoEscreve;
    vector<string> arquivos;
    vector<string> diretorios;
    string line, line2;
    int tamanhoString, tamanhoId;

    //Abre o arquivo
    arquivoLe.open(nomeArquivo.c_str(), ios::binary|ios::in);

    //Lê as linhas que começam com "&"
    if (arquivoLe.is_open()){                               //Se estiver aberto
        cout<<endl;
        while(getline(arquivoLe,line)){
             if(line[0]=='&'){
                tamanhoString=line.length()-1;
                tamanhoId=line.find(']')+1;
                diretorios.push_back(line.substr(tamanhoId,tamanhoString));
            }
        }

        for(int i=0; i<diretorios.size(); i++){ //Cria pastas
            mkdir(diretorios[i].c_str());
        }
    }
    arquivoLe.close();

    //Abre o arquivo de novo
    arquivoLe.open(nomeArquivo.c_str(), ios::binary|ios::in);
    arquivoEscreve.open("");
    if (arquivoLe.is_open()){                               //Se estiver aberto
        while (getline(arquivoLe,line)){                    //Enquanto tiver linhas
            if(line[0]=='*'){
                arquivoEscreve.close();
                tamanhoString=line.length()-1;
                tamanhoId=line.find(']')+1;
                line2=line.substr(tamanhoId,tamanhoString);
                //cout<<line2<<endl;
                line2=line2.substr(2,line.length()-2);
                //cout<<line2<<endl;
                arquivoEscreve.open(line2.c_str(), ios::binary|ios::out);
            }
            if(line[0]=='#'){
                arquivoEscreve<<line.substr(1,line.length())<<endl;
            }
        }
    arquivoLe.close();
    }
    else{
        cout << endl << "Arquivo nao encontrado"<<endl;
        return 0;
    }
    return 1;

}
