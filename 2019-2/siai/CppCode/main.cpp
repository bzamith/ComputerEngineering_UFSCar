/* main.cpp
 * 
 * @description:
 *      Arquivo principal do algoritmo genético que otimiza o valor das variáveis
 *      Kp, Kd e Ki do método de controle PID a partir de um intervalo inicial dado a cada uma das variáveis 
 *
 * @authors:
 *      Bruna Zamith        RA:
 *      Matheus Vrech       RA: 727349
 *
 */
// export PATH=/usr/local/MATLAB/R2018b/bin/:$PATH; g++ *.cpp -o projeto.out; ./projeto.out

/*
 *	Libraries
 ***********************************************************************/
#include <iostream>
#include "AlgoritmoGenetico.h"

using namespace std;

/*
 *	Main function
 ***********************************************************************/
int main(){   
    /* instancia o objeto do ag */
    AlgoritmoGenetico ag = AlgoritmoGenetico();

    /* executa o algoritmo */
    ag.rodaAG();

    /* obtém os valores já otimizados */
    cout << "Kp = " << ag.getMelhorKp() << endl;
    cout << "Ki = " << ag.getMelhorKi() << endl;
    cout << "Kd = " << ag.getMelhorKd() << endl;
    cout << "Fitness Value = " << ag.getMelhorFitnessValue() << endl;
    return 0;
}