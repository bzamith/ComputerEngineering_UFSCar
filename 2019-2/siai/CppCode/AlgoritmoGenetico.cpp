#include "AlgoritmoGenetico.h"

AlgoritmoGenetico::AlgoritmoGenetico(){
    Cromossomo crom = Cromossomo(0.002,0.04,0.001);
    populacao[0] = crom;
    cout << crom.fitnessFunction() << endl;
}
