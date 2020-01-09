/*
FUN��O -L - Fun��o para o arquivo FuncaoPrincipal.cpp
Trabalho apresentado a disciplina de Organiza��o e Recupera��o da informa��o, ministrada pelo docente Jander Moreira, na Universidade Federal de S�o Carlos - UFSCar
Objetivo: Listar os dados existentes em um arquivo .sar
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

//Fun��o funcaoL()
//Objetivo: Lista os arquivos, diret�rios e sub-diret�rios em um arquivo .sar
//Parametros formais: string nomeArquivo - Recebe apenas o nome do arquivo que se deseja listar
//Retorno:            Se o arquivo existir, retorna um bolleano verdadeiro, caso contr�rio, falso.
bool funcaoL(string nomeArquivo){
    ifstream arquivoLe;
    string line;
    string line2;
    vector<string> arquivos;
    vector<string> diretorios;

    int tamanhoString=0;
    int tamanhoId=0;
    int tamanhoId2=0;

    arquivoLe.open(nomeArquivo.c_str(), ios::binary|ios::in);

    //L� as linhas que come�am com "*"
    if (arquivoLe.is_open()){
        cout<<endl;

        while (getline(arquivoLe,line)){

            if(line[0]=='&'){
                tamanhoString=line.length()-1;
                tamanhoId=line.find(']')+1;
                diretorios.push_back(line.substr(tamanhoId,tamanhoString));
            }

            if(line[0]=='*' && line.find("..")==-1){
                tamanhoString=line.length()-1;

                if(line[tamanhoString]!='.'){
                    tamanhoId=line.find(']')+1;
                    arquivos.push_back(line.substr(tamanhoId,tamanhoString));
                }
            }
        }

        int i=0;
        int j=0;
        string linetemp;

        for(i=0; i<(diretorios.size()); i++){
            cout<<"\nDiretorio: "<<diretorios[i]<<endl;

            for(j=0; j<arquivos.size(); j++){
                tamanhoId=arquivos[j].find_last_of("/");
                line=arquivos[j].substr(0,tamanhoId);

                if(line==diretorios[i]){
                  cout<<"\tArquivo: "<<arquivos[j].substr(tamanhoId+1,(arquivos[j].length()-tamanhoId))<<endl;
                }
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
