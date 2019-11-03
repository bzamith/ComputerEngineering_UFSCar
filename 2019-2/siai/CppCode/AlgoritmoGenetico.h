using namespace std;

#ifndef ALGORITMOGENETICO_H
    #define ALGORITMOGENETICO_H
#endif

#define TAM_POPULACAO 100
#define TAM_SELECAO 20
#define TAM_TORNEIO 10
#define NUM_ITERACOES_AG 300

#include<vector>
#include<ctime>
#include<iostream>
#include <algorithm>
#include "Cromossomo.h"

class AlgoritmoGenetico{
    public:
        AlgoritmoGenetico();
        void setRangeKp(double minKp, double maxKp);
        void setRangeKi(double minKi, double maxKi);
        void setRangeKd(double minKd, double maxKd);
        vector<double> rodaAG();

    private:
        double maxKp, maxKi, maxKd, minKp, minKi, minKd;
        vector<Cromossomo> populacaoAtual;
        vector<Cromossomo> populacaoSelecionada;
        void criaPopulacaoInicial();
        void printaPopulacao(vector<Cromossomo> populacao);
        double geraKp();
        double geraKi();
        double geraKd();
        void ordenaPopulacaoAtual();
        void ordenaPopulacaoSelecionada();
        void fazSelecao();
        Cromossomo fazSelecaoTorneio();
        Cromossomo selecionaCromossomoAleatoriamente();
        void fazCruzamento();
        void fazElitismo();
        vector<double> retornaMelhoresConstantes();
        Cromossomo retornaMelhorCromossomo();
};