/* AlgoritmoGenetico.h
 * 
 * @description:
 *      Definição da classe AlgoritmoGenetico que contém os cromossomos e métodos utilizados na otimização
 *
 */
using namespace std;

/*
 *	Libraries and Definitions
 ***********************************************************************/
#ifndef ALGORITMOGENETICO_H
    #define ALGORITMOGENETICO_H
#endif

#define TAM_POPULACAO 100
#define TAM_SELECAO 20
#define TAM_TORNEIO 15
#define NUM_ITERACOES_AG 300
#define PROB_MUTACAO 0.1

#include<vector>
#include<ctime>
#include<iostream>
#include <algorithm>
#include "Cromossomo.h"

class AlgoritmoGenetico{
    public:
        /* Construtor */
        AlgoritmoGenetico();
        
        /* Métodos getters */
        double getMelhorKp();
        double getMelhorKi();
        double getMelhorKd();
        double getMelhorFitnessValue();

        /* Algoritmo que setta o range de Kp */
        void setRangeKp(double minKp, double maxKp);
        /* Algoritmo que setta o range de Ki */
        void setRangeKi(double minKi, double maxKi);
        /* Algoritmo que setta o range de Kd */
        void setRangeKd(double minKd, double maxKd);
        
        /* Executa a lógica do Algoritmo Genético */
        void rodaAG();

    private:
        
        /* Definição dos ranges */
        double maxKp, maxKi, maxKd, minKp, minKi, minKd;
        
        /* flags */
        bool rodouAG;

        /* Populações definidas */
        vector<Cromossomo> populacaoAtual;
        vector<Cromossomo> populacaoSelecionada;

        /* Resultado final */
        Cromossomo melhorCromossomo;

        /* Métodos principais do AG */
        void criaPopulacaoInicial();
        void fazSelecao();
        void fazCruzamento();
        void fazMutacao();
        void fazElitismo();
        void encontraMelhorCromossomo();
        
        /* Métodos secundarios do AG */
        double geraKpAleatorio();
        double geraKiAleatorio();
        double geraKdAleatorio();
        Cromossomo fazSelecaoTorneio();
        Cromossomo selecionaCromossomoAleatoriamente();
        void ordenaPopulacao(vector<Cromossomo> &populacao);
        
        /* Funções específicas para debugging */
        bool verificaRodouAG();
        void printaPopulacao(vector<Cromossomo> populacao);  
};