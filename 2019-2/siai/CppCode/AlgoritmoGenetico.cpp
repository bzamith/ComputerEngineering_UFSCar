/* AlgoritmoGenetico.cpp
 * 
 * @description:
 *      Implementação dos métodos relacionados ao funcionamento do algoritmo genético
 *
 */
#include "AlgoritmoGenetico.h"

/* Construtor  da classe */
AlgoritmoGenetico::AlgoritmoGenetico(){
    this->maxKp = 20;
    this->maxKi = 5;
    this->maxKd = 1.5;
    
    this->minKp = 1.5;
    this->minKi = 1;
    this->minKd = 1;
    this->rodouAG = false;
}

/* método: rodaAG()
 *
 * @descrição: Executa a lógica do AG
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::rodaAG(){
    srand(time(0)); // seta o seed
    criaPopulacaoInicial();
    for(int i=0; i<NUM_ITERACOES_AG; i++){
        cout << "Iteracao " << i << endl;
        fazSelecao();
        fazCruzamento();
        fazMutacao();
        fazElitismo();
	encontraMelhorCromossomo();
        this->melhorCromossomo.printaCromossomo();
    }
    encontraMelhorCromossomo();
    this->rodouAG = true;
}

/* método: criaPopulacaoInicial()
 *
 * @descrição: Define a população para a iteração inicial
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::criaPopulacaoInicial(){
    this->populacaoAtual.clear();
    for(int i=0; i<TAM_POPULACAO; i++){
        cout << "Cromossomo Inicial " << i << endl;
        double kp = geraKpAleatorio();
        double ki = geraKiAleatorio();
        double kd = geraKdAleatorio();
        Cromossomo cromossomoAtual = Cromossomo(kp,ki,kd);
        cromossomoAtual.printaCromossomo();
        populacaoAtual.push_back(cromossomoAtual);
    }
}

/* método: fazSelecao()
 *
 * @descrição: preenche o atributo populacaoSelecionada da classe com os Cromossomos de melhor desempenho
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::fazSelecao(){
    this->populacaoSelecionada.clear();
    for(int i=0; i<TAM_SELECAO; i++){
        populacaoSelecionada.push_back(fazSelecaoTorneio()); 
    }
}

/* método: fazCruzamento()
 *
 * @descrição: Realiza troca o primeiro "gene" entre os cromossosmos
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::fazCruzamento(){
    for(int i=0; i<TAM_SELECAO/2; i++){
        double priKp = this->populacaoSelecionada[i].getKp();
        // kp = TAM_SELECAO - i - 1
        double segKp = this->populacaoSelecionada[TAM_SELECAO - i - 1].getKp();
        this->populacaoSelecionada[i].setKp(segKp);
        this->populacaoSelecionada[TAM_SELECAO - i - 1].setKp(priKp);
    }
}

/* método: fazMutacao()
 *
 * @descrição: Realiza a mutação aleatória para a porcentagem [PROB_MUTACAO] de cromossosmos 
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::fazMutacao(){
    for(int i=0; i<this->populacaoSelecionada.size(); i++){
        double probabilidade = (double)rand() / (double)RAND_MAX;
        if(probabilidade<=PROB_MUTACAO){
            // Mutação no valor de Ki
            this->populacaoSelecionada[i].setKi(this->geraKiAleatorio());
        }
    }
}

/* método: fazElitismo()
 *
 * @descrição: Define a população para a iteração inicial
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::fazElitismo(){
    vector<Cromossomo> novaPopulacao;
    ordenaPopulacao(this->populacaoAtual);
    for(int i=0; i<TAM_POPULACAO-TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoAtual[i]);    
    }
    
    // odena a nova população em conjunto a antiga
    ordenaPopulacao(this->populacaoSelecionada);
    for(int i=0; i<TAM_SELECAO; i++){
        novaPopulacao.push_back(populacaoSelecionada[i]);
    }
    this->populacaoAtual = novaPopulacao;
}

/* método: encontraMelhorCromossomo()
 *
 * @descrição: Define o atributo melhorCromossomo da classe com o cromossomo de melhor desempenho
 * @parametros: nenhum
 * @retorno: nenhum
 */
void AlgoritmoGenetico::encontraMelhorCromossomo(){
    ordenaPopulacao(this->populacaoAtual);
    this->melhorCromossomo = this->populacaoAtual[0];
}

/* método: geraKpAleatorio()
 *
 * @descrição: Cria um Kp aleatório
 * @parametros: nenhum
 * @retorno: valor de Kp gerado (tipo double)
 */
double AlgoritmoGenetico::geraKpAleatorio(){
    double kp;
    do{
        kp = (double)rand() / (double)RAND_MAX;
        kp =  this->minKp + kp * (this->maxKp - this->minKp);
    }while(kp > this->maxKp || kp < this->minKp);
    return kp;
}

/* método: geraKiAleatorio()
 *
 * @descrição: Cria um Ki aleatório
 * @parametros: nenhum
 * @retorno: valor de Ki gerado (tipo double)
 */
double AlgoritmoGenetico::geraKiAleatorio(){
    double ki;
    do{
        ki = (double)rand() / (double)RAND_MAX;
        ki =  this->minKp + ki * (this->maxKi - this->minKi);
    }while(ki > this->maxKi || ki < this->minKi);
    return ki;
}

/* método: geraKdAleatorio()
 *
 * @descrição: Cria um Kd aleatório
 * @parametros: nenhum
 * @retorno: valor de Kd gerado (tipo double)
 */
double AlgoritmoGenetico::geraKdAleatorio(){
    double kd;
    do{
        kd = (double)rand() / (double)RAND_MAX;
        kd =  this->minKd + kd * (this->maxKd - this->minKd);
    }while(kd > this->maxKd || kd < this->minKd);
    return kd;
}

/* método: fazSelecaoTorneio()
 *
 * @descrição: Seleciona os melhores Cromossomos utilizando a ideia de Torneio
 * @parametros: nenhum
 * @retorno: retorna melhor cromossomo obtido
 */
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

/* método: selecionaCromossomoAleatoriamente()
 *
 * @descrição: Acessa um cromossomo em uma posição aleatória da população e retorna ele
 * @parametros: nenhum
 * @retorno: Cromossomo aleatório
 */
Cromossomo AlgoritmoGenetico::selecionaCromossomoAleatoriamente(){
    double posicao = ((double)rand()/RAND_MAX) * TAM_POPULACAO;
    return populacaoAtual[posicao];
}

/* método: ordenaPopulacao()
 *
 * @descrição: Ordena uma população arbitrária pelo valor fitness de cada cromossomo
 * @parametros: vetor população passado por referencia
 * @retorno: nenhum
 */
void AlgoritmoGenetico::ordenaPopulacao(vector<Cromossomo> &populacao) { //implementação de um bubblesort
   for(int i = 0; i<populacao.size(); i++) {
      bool swaps = false;
      for(int j = 0; j<populacao.size()-i-1; j++) {
         if(populacao[j].getFitnessValue() > populacao[j+1].getFitnessValue()) {
            // altera a posição dos elementos
            swap(populacao[j],populacao[j+1]);
            swaps = true;
         }
      }
      if(!swaps)
        break;
   }
}

/* método: printaPopulacao()
 *
 * @descrição: Imprime na tela a população
 * @parametros: vetor população passado por valor
 * @retorno: nenhum
 */
void AlgoritmoGenetico::printaPopulacao(vector<Cromossomo> populacao){
    for(int i=0; i<populacao.size(); i++){
        Cromossomo cromossomoAtual = populacao[i];
        cout << "Cromossomo " << i << " | ";
        cromossomoAtual.printaCromossomo();
    }
}

/* método: getMelhorKp(){
 *
 * @descrição: Retorna melhor valor de Kp
 * @parametros: nenhum
 * @retorno: Kp o melhor cromossomo (tipo double)
 */
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

/* método: getMelhorKi(){
 *
 * @descrição: Retorna melhor valor de Ki
 * @parametros: nenhum
 * @retorno: Ki o melhor cromossomo (tipo double)
 */
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

/* método: getMelhorKd(){
 *
 * @descrição: Retorna melhor valor de Kd
 * @parametros: nenhum
 * @retorno: Kd o melhor cromossomo (tipo double)
 */
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

/* método: getMelhorFitnessValue()
 *
 * @descrição: Retorna o melhor valor fitness obtido por um cromossomo
 * @parametros: nenhum
 * @retorno: valor fitness (tipo double)
 */
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

/* método: verificaRodouAG()
 *
 * @descrição: Checa se o algoritmo do AG rodou
 * @parametros: nenhum
 * @retorno: True caso tenha rodado e False caso não tenha rodado ainda
 */
bool AlgoritmoGenetico::verificaRodouAG(){
    if(!this->rodouAG)
        throw "Não disponivel - AG não rodou. Abortando"s;
    else 
        return true;
}

/* método: setRangeKp()
 *
 * @descrição: Define um range para o Kp
 * @parametros: menor valor de Kp (double) e maior valor de Kp (double)
 * @retorno: nenhum
 */
void AlgoritmoGenetico::setRangeKp(double minKp, double maxKp){
    this->minKp = minKp;
    this->maxKp = maxKp;
}

/* método: setRangeKi()
 *
 * @descrição: Define um range para o Kpi
 * @parametros: menor valor de Ki (double) e maior valor de Ki (double)
 * @retorno: nenhum
 */
void AlgoritmoGenetico::setRangeKd(double minKd, double maxKd){
    this->minKd = minKd;
    this->maxKd = maxKd;
}

/* método: setRangeKi()
 *
 * @descrição: Define um range para o Ki
 * @parametros: menor valor de Ki (double) e maior valor de Ki (double)
 * @retorno: nenhum
 */
void AlgoritmoGenetico::setRangeKi(double minKi, double maxKi){
    this->minKi = minKi;
    this->maxKi = maxKi;
}
