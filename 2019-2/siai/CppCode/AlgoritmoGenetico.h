using namespace std;

#ifndef ALGORITMOGENETICO_H
    #define ALGORITMOGENETICO_H
#endif

#define TAM_POPULACAO 100

#include<vector>
#include<iostream>
#include "Cromossomo.h"

class AlgoritmoGenetico{
    public:
        AlgoritmoGenetico();
        void setRangeKp(double minKp, double maxKp);
        void setRangeKi(double minKi, double maxKi);
        void setRangeKd(double minKd, double maxKd);

    private:
        double maxKp, maxKi, maxKd, minKp, minKi, minKd;
        Cromossomo populacao[TAM_POPULACAO];
        void criaPopulacaoInicial();
        void printaPopulacao();
        double geraKp();
        double geraKi();
        double geraKd();
};