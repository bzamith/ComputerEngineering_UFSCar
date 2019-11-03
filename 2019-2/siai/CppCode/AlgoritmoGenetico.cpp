#include "AlgoritmoGenetico.h"

AlgoritmoGenetico::AlgoritmoGenetico(){
    this->maxKp = 1;
    this->maxKi = 0.1;
    this->maxKd = 0.05;
    this->minKp = 0;
    this->minKi = 0;
    this->minKd = 0;
    this->rodouAG = false;
}

void AlgoritmoGenetico::rodaAG(){
    srand(time(0)); // seta o seed
    criaPopulacaoInicial();
    for(int i=0; i<NUM_ITERACOES_AG; i++){
        fazSelecao();
        fazCruzamento();
        fazElitismo();
    }
    encontraMelhorCromossomo();
    this->rodouAG = true;
}

void AlgoritmoGenetico::criaPopulacaoInicial(){
    this->populacaoAtual.clear();
    for(int i=0; i<TAM_POPULACAO; i++){
        double kp = geraKpAleatorio();
        double ki = geraKiAleatorio();
        double kd = geraKdAleatorio();
        Cromossomo cromossomoAtual = Cromossomo(kp,ki,kd);
        populacaoAtual.push_back(cromossomoAtual);
    }
}

void AlgoritmoGenetico::fazSelecao(){
    this->populacaoSelecionada.clear();
    for(int i=0; i<TAM_SELECAO; i++){
        populacaoSelecionada.push_back(fazSelecaoTorneio()); 
    }
}

void AlgoritmoGenetico::fazCruzamento(){
    for(int i=0; i<TAM_SELECAO/2; i++){
        double priKd = this->populacaoSelecionada[i].getKd();
        double segKd = this->populacaoSelecionada[TAM_SELECAO - i - 1].getKd();
        this->populacaoSelecionada[i].setKd(segKd);
        this->populacaoSelecionada[TAM_SELECAO - i - 1].setKd(priKd);
    }
}

void AlgoritmoGenetico::fazElitismo(){
    vector<Cromossomo> novaPopulacao;
    ordenaPopulacao(this->populacaoAtual);
    for(int i=0; i<TAM_POPULACAO-TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoAtual[i]);    
    }
    ordenaPopulacao(this->populacaoSelecionada);
    for(int i=0; i<TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoSelecionada[i]);
    }
    this->populacaoAtual = novaPopulacao;
}

void AlgoritmoGenetico::encontraMelhorCromossomo(){
    ordenaPopulacao(this->populacaoAtual);
    this->melhorCromossomo = this->populacaoAtual[0];
}

double AlgoritmoGenetico::geraKpAleatorio(){
    double kp;
    do{
        kp = ((double)rand()/RAND_MAX);
    }while(kp > this->maxKp || kp < this->minKp);
    return kp;
}

double AlgoritmoGenetico::geraKiAleatorio(){
    double ki;
    do{
        ki = ((double)rand()/RAND_MAX);
    }while(ki > this->maxKi || ki < this->minKi);
    return ki;
}

double AlgoritmoGenetico::geraKdAleatorio(){
    double kd;
    do{
        kd = ((double)rand()/RAND_MAX);
    }while(kd > this->maxKd || kd < this->minKd);
    return kd;
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

void AlgoritmoGenetico::ordenaPopulacao(vector<Cromossomo> &populacao) { //implementação de um bubblesort
   for(int i = 0; i<populacao.size(); i++) {
      bool swaps = false;
      for(int j = 0; j<populacao.size()-i-1; j++) {
         if(populacao[j].getFitnessValue() > populacao[j+1].getFitnessValue()) {
            swap(populacao[j],populacao[j+1]);
            swaps = true;
         }
      }
      if(!swaps)
        break;
   }
}

void AlgoritmoGenetico::printaPopulacao(vector<Cromossomo> populacao){
    for(int i=0; i<populacao.size(); i++){
        Cromossomo cromossomoAtual = populacao[i];
        cout << "Cromossomo " << i << " | ";
        cromossomoAtual.printaCromossomo();
    }
}

double AlgoritmoGenetico::getMelhorKp(){
    try{
        this->verificaRodouAG();
    }
    catch (string erro)
    {
	    cout << erro << endl;
        exit(0);
    }
    return this->melhorCromossomo.getKp();
}

double AlgoritmoGenetico::getMelhorKi(){
    try{
        this->verificaRodouAG();
    }
    catch (string erro)
    {
	    cout << erro << endl;
        exit(0);
    }
    return this->melhorCromossomo.getKi();
}

double AlgoritmoGenetico::getMelhorKd(){
    try{
        this->verificaRodouAG();
    }
    catch (string erro)
    {
	    cout << erro << endl;
        exit(0);
    }
    return this->melhorCromossomo.getKd();
}

double AlgoritmoGenetico::getMelhorFitnessValue(){
    try{
        this->verificaRodouAG();
    }
    catch (string erro)
    {
	    cout << erro << endl;
        exit(0);
    }
    return this->melhorCromossomo.getFitnessValue();
}

bool AlgoritmoGenetico::verificaRodouAG(){
    if(!this->rodouAG)
        throw "Não disponivel - AG não rodou. Abortando"s;
    else 
        return true;
}

void AlgoritmoGenetico::setRangeKp(double minKp, double maxKp){
    this->minKp = minKp;
    this->maxKp = maxKp;
}

void AlgoritmoGenetico::setRangeKd(double minKd, double maxKd){
    this->minKd = minKd;
    this->maxKd = maxKd;
}

void AlgoritmoGenetico::setRangeKi(double minKi, double maxKi){
    this->minKi = minKi;
    this->maxKi = maxKi;
}