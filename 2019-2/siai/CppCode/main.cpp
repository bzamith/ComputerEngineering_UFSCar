/*  g++ *.cpp -o projeto.out; ./projeto.out */ 

#include <iostream>
#include "AlgoritmoGenetico.h"

using namespace std;

int main(){   
    AlgoritmoGenetico ag = AlgoritmoGenetico();
    ag.rodaAG();
    //gerarPopulacaoInicial()
    //while(){
    //calcularErrosPopulacao()
    //fazerCruzamento()
    //fazerMutacao()
    //}
    //retornarelhorIndividuo()
    return 0;
}