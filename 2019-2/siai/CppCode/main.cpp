// export PATH=/usr/local/MATLAB/R2018b/bin/:$PATH; g++ *.cpp -o projeto.out; ./projeto.out

#include <iostream>
#include "AlgoritmoGenetico.h"

using namespace std;

int main(){   
    AlgoritmoGenetico ag = AlgoritmoGenetico();
    ag.rodaAG(); 
    cout << "Kp = " << ag.getMelhorKp() << endl;
    cout << "Ki = " << ag.getMelhorKi() << endl;
    cout << "Kd = " << ag.getMelhorKd() << endl;
    cout << "Fitness Value = " << ag.getMelhorFitnessValue() << endl;
    return 0;
}