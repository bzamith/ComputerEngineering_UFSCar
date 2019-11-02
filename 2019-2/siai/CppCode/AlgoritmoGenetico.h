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
        double fitnessFunction(Cromossomo cromossomo);  // colocar private

    private:
        Cromossomo populacao[TAM_POPULACAO];
};