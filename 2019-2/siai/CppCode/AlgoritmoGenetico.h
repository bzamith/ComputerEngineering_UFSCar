using namespace std;

#ifndef ALGORITMOGENETICO_H
    #define ALGORITMOGENETICO_H
#endif

#define TAM_POPULACAO 8 // 100
#define TAM_SELECAO 6 // 20
#define TAM_TORNEIO 4 // 15
#define NUM_ITERACOES_AG 10 //300
#define PROB_MUTACAO 0.1

#include<vector>
#include<ctime>
#include<iostream>
#include <algorithm>
#include "Cromossomo.h"

class AlgoritmoGenetico{
    public:
        //Construtores
        AlgoritmoGenetico();
        // Getters and setters
        double getMelhorKp();
        double getMelhorKi();
        double getMelhorKd();
        double getMelhorFitnessValue();
        void setRangeKp(double minKp, double maxKp);
        void setRangeKi(double minKi, double maxKi);
        void setRangeKd(double minKd, double maxKd);
        // Roda AG
        void rodaAG();

    private:
        // Ranges
        double maxKp, maxKi, maxKd, minKp, minKi, minKd;
        // Verificacao
        bool rodouAG;
        // Populacoes
        vector<Cromossomo> populacaoAtual;
        vector<Cromossomo> populacaoSelecionada;
        // Resultado
        Cromossomo melhorCromossomo;
        // Funcoes principais
        void criaPopulacaoInicial();
        void fazSelecao();
        void fazCruzamento();
        void fazMutacao();
        void fazElitismo();
        void encontraMelhorCromossomo();
        // Funcoes secundarias
        double geraKpAleatorio();
        double geraKiAleatorio();
        double geraKdAleatorio();
        Cromossomo fazSelecaoTorneio();
        Cromossomo selecionaCromossomoAleatoriamente();
        void ordenaPopulacao(vector<Cromossomo> &populacao);
        // Debug
        bool verificaRodouAG();
        void printaPopulacao(vector<Cromossomo> populacao);  
};