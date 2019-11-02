#include "AlgoritmoGenetico.h"

AlgoritmoGenetico::AlgoritmoGenetico(){
    this->maxKp = 1;
    this->maxKi = 1;
    this->maxKd = 1;
    this->minKp = 0.001;
    this->minKi = 0.001;
    this->minKd = 0.001;

    criaPopulacaoInicial();
    // printaPopulacao();
}

void AlgoritmoGenetico::criaPopulacaoInicial(){
    for(int i=0; i<TAM_POPULACAO; i++){
        cout << i << endl;
        double kp = geraKp();
        cout << "Kp = " << kp << endl;
        double ki = geraKi();
        cout << "Ki = " << ki << endl;
        double kd = geraKd();
        cout << "Kd = " << kd << endl;
        Cromossomo cromossomoAtual = Cromossomo(kp,ki,kd);
        populacao[i] = cromossomoAtual;
    }
}

void AlgoritmoGenetico::printaPopulacao(){
    for(int i=0; i<TAM_POPULACAO; i++){
        Cromossomo cromossomoAtual = this->populacao[i];
        cout << "Cromossomo " << i << " | Kp = " << cromossomoAtual.getKp() << " | Ki = " << 
            cromossomoAtual.getKi() << " | Kd = " << cromossomoAtual.getKp() << " | Fitness Value = " << cromossomoAtual.getFitnessValue() << endl;
    }
}


double AlgoritmoGenetico::geraKp(){
    double kp;
    do{
        kp = (double)rand()/RAND_MAX*0.1;
    }while(kp > this->maxKp || kp < this->minKp);
    return kp;
}

double AlgoritmoGenetico::geraKi(){
    double ki;
    do{
        ki = (double)rand()/RAND_MAX*0.1;
    }while(ki > this->maxKi || ki < this->minKi);
    return ki;
}

double AlgoritmoGenetico::geraKd(){
    double kd;
    do{
        kd = (double)rand()/RAND_MAX*0.1;
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

