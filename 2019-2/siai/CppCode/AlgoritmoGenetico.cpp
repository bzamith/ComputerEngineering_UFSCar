#include "AlgoritmoGenetico.h"

AlgoritmoGenetico::AlgoritmoGenetico(){
    this->maxKp = 0.5;
    this->maxKi = 0.05;
    this->maxKd = 0;
    this->minKp = 0;
    this->minKi = 0;
    this->minKd = 0;
}

void AlgoritmoGenetico::rodaAG(){
    criaPopulacaoInicial();
    bubbleSort(this->populacao);
    printaPopulacao();
}

void AlgoritmoGenetico::criaPopulacaoInicial(){
    for(int i=0; i<TAM_POPULACAO; i++){
        double kp = geraKp();
        double ki = geraKi();
        double kd = 0;
        //double kd = geraKd();
        Cromossomo cromossomoAtual = Cromossomo(kp,ki,kd);
        populacao[i] = cromossomoAtual;
    }
}

void AlgoritmoGenetico::printaPopulacao(){
    for(int i=0; i<TAM_POPULACAO; i++){
        Cromossomo cromossomoAtual = this->populacao[i];
        cout << "Cromossomo " << i << " | Kp = " << cromossomoAtual.getKp() << " | Ki = " << 
            cromossomoAtual.getKi() << " | Kd = " << cromossomoAtual.getKd() << " | Fitness Value = " << 
            cromossomoAtual.getFitnessValue() << " | Max = " << cromossomoAtual.getAtingiuMaximo() << endl;
    }
}

double AlgoritmoGenetico::geraKp(){
    double kp;
    do{
        kp = ((double)rand()/RAND_MAX);
    }while(kp > this->maxKp || kp < this->minKp);
    return kp;
}

double AlgoritmoGenetico::geraKi(){
    double ki;
    do{
        ki = ((double)rand()/RAND_MAX)*0.1;
    }while(ki > this->maxKi || ki < this->minKi);
    return ki;
}

double AlgoritmoGenetico::geraKd(){
    double kd;
    do{
        kd = ((double)rand()/RAND_MAX)*0.1;
    }while(kd > this->maxKd || kd < this->minKd);
    return kd;
}

void AlgoritmoGenetico::setRangeKd(double minKd, double maxKd){
    this->minKd = minKd;
    this->maxKd = maxKd;
}

void AlgoritmoGenetico::setRangeKp(double minKp, double maxKp){
    this->minKp = minKp;
    this->maxKp = maxKp;
}

void AlgoritmoGenetico::setRangeKi(double minKi, double maxKi){
    this->minKi = minKi;
    this->maxKi = maxKi;
}

void AlgoritmoGenetico::bubbleSortSwap(Cromossomo &a, Cromossomo &b) {
   Cromossomo temp;
   temp = a;
   a = b;
   b = temp;
}

void AlgoritmoGenetico::bubbleSort(Cromossomo *array) {
   for(int i = 0; i<TAM_POPULACAO; i++) {
      bool swaps = false;
      for(int j = 0; j<TAM_POPULACAO-i-1; j++) {
         if(array[j].getFitnessValue() > array[j+1].getFitnessValue()) {
            bubbleSortSwap(array[j], array[j+1]);
            swaps = true;
         }
      }
      if(!swaps)
         break;
   }
}