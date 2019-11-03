#include "AlgoritmoGenetico.h"

AlgoritmoGenetico::AlgoritmoGenetico(){
    this->maxKp = 1;
    this->maxKi = 0.1;
    this->maxKd = 0;
    this->minKp = 0;
    this->minKi = 0;
    this->minKd = 0;
}

vector<double> AlgoritmoGenetico::rodaAG(){
    srand(time(0)); // seta o seed
    criaPopulacaoInicial();
    for(int i=0; i<NUM_ITERACOES_AG; i++){
        fazSelecao();
        fazCruzamento();
        fazElitismo();
    }
    return retornaMelhoresConstantes();
}

vector<double> AlgoritmoGenetico::retornaMelhoresConstantes(){ // kp, ki, kd
    vector<double> constantes;
    Cromossomo melhorCromossomo = retornaMelhorCromossomo();
    melhorCromossomo.printaCromossomo();
    constantes.push_back(melhorCromossomo.getKp());
    constantes.push_back(melhorCromossomo.getKi());
    constantes.push_back(melhorCromossomo.getKd());
    return constantes;
}

Cromossomo AlgoritmoGenetico::retornaMelhorCromossomo(){
    ordenaPopulacaoAtual();
    return this->populacaoAtual[0];
}

void AlgoritmoGenetico::fazElitismo(){
    vector<Cromossomo> novaPopulacao;
    ordenaPopulacaoAtual();
    for(int i=0; i<TAM_POPULACAO-TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoAtual[i]);    
    }
    ordenaPopulacaoSelecionada();
    for(int i=0; i<TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoSelecionada[i]);
    }
    this->populacaoAtual = novaPopulacao;
}


void AlgoritmoGenetico::fazCruzamento(){
    for(int i=0; i<TAM_SELECAO/2; i++){
        double priKd = this->populacaoSelecionada[i].getKd();
        double segKd = this->populacaoSelecionada[TAM_SELECAO - i - 1].getKd();
        this->populacaoSelecionada[i].setKd(segKd);
        this->populacaoSelecionada[TAM_SELECAO - i - 1].setKd(priKd);
    }
}

void AlgoritmoGenetico::fazSelecao(){
    this->populacaoSelecionada.clear();
    for(int i=0; i<TAM_SELECAO; i++){
        populacaoSelecionada.push_back(fazSelecaoTorneio()); 
    }
}

Cromossomo AlgoritmoGenetico::fazSelecaoTorneio(){
    Cromossomo melhorCromossomo = selecionaCromossomoAleatoriamente();
    for(int i=0; i<TAM_TORNEIO-1; i++){
        Cromossomo cromossomoAtual = selecionaCromossomoAleatoriamente();
        if(cromossomoAtual.getFitnessValue() < melhorCromossomo.getFitnessValue()){
            melhorCromossomo = cromossomoAtual;
        }
    }
    return melhorCromossomo;
}

Cromossomo AlgoritmoGenetico::selecionaCromossomoAleatoriamente(){
    double posicao = ((double)rand()/RAND_MAX) * TAM_POPULACAO;
    return populacaoAtual[posicao];
}

void AlgoritmoGenetico::criaPopulacaoInicial(){
    this->populacaoAtual.clear();
    for(int i=0; i<TAM_POPULACAO; i++){
        double kp = geraKp();
        double ki = geraKi();
        double kd = 0;
        //double kd = geraKd();
        Cromossomo cromossomoAtual = Cromossomo(kp,ki,kd);
        populacaoAtual.push_back(cromossomoAtual);
    }
}

void AlgoritmoGenetico::printaPopulacao(vector<Cromossomo> populacao){
    for(int i=0; i<populacao.size(); i++){
        Cromossomo cromossomoAtual = populacao[i];
        cout << "Cromossomo " << i << " | ";
        cromossomoAtual.printaCromossomo();
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
        ki = ((double)rand()/RAND_MAX);
    }while(ki > this->maxKi || ki < this->minKi);
    return ki;
}

double AlgoritmoGenetico::geraKd(){
    double kd;
    do{
        kd = ((double)rand()/RAND_MAX);
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

void AlgoritmoGenetico::ordenaPopulacaoAtual() { //implementação de um bubblesort
   for(int i = 0; i<TAM_POPULACAO; i++) {
      bool swaps = false;
      for(int j = 0; j<TAM_POPULACAO-i-1; j++) {
         if(this->populacaoAtual[j].getFitnessValue() > this->populacaoAtual[j+1].getFitnessValue()) {
            swap(this->populacaoAtual[j], this->populacaoAtual[j+1]);
            swaps = true;
         }
      }
      if(!swaps)
        break;
   }
}

void AlgoritmoGenetico::ordenaPopulacaoSelecionada() { //implementação de um bubblesort
   for(int i = 0; i<TAM_SELECAO; i++) {
      bool swaps = false;
      for(int j = 0; j<TAM_SELECAO-i-1; j++) {
         if(this->populacaoSelecionada[j].getFitnessValue() > this->populacaoSelecionada[j+1].getFitnessValue()) {
            swap(this->populacaoSelecionada[j], this->populacaoSelecionada[j+1]);
            swaps = true;
         }
      }
      if(!swaps)
        break;
   }
}
