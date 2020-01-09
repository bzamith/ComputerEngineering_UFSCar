/*
FUNÇÂO -L - Função para o arquivo FuncaoPrincipal.cpp
Trabalho apresentado a disciplina de Organização e Recuperação da informação, ministrada pelo docente Jander Moreira, na Universidade Federal de São Carlos - UFSCar
Objetivo: Listar os dados existentes em um arquivo .sar
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

using namespace std;

//Função funcaoL()
//Objetivo: Lista os arquivos, diretórios e sub-diretórios em um arquivo .sar
//Parametros formais: string nomeArquivo - Recebe apenas o nome do arquivo que se deseja listar
//Retorno:            Se o arquivo existir, retorna um bolleano verdadeiro, caso contrário, falso.
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

    //Lê as linhas que começam com "*"
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
