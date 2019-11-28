/* SimulacaoMatlab.h
 * 
 * @description:
 *      Métodos e atributos referentes a simulação do controle PID no matlab
 *
 */
using namespace std;

/*
 *	Libraries and Definitions
 ***********************************************************************/
#ifndef SIMULACAOMATLAB_H
    #define SIMULACAOMATLAB_H
#endif

#include <fstream>
#include <iostream>
#include <bits/stdc++.h> 

#define LIMITE_ERRO 0.1

class SimulacaoMatlab{
    public:
        /* Construtor */
        SimulacaoMatlab(double kp, double ki, double kd, double posDesejada);
        
        /* Métodos getters e setters */
        void writeMatlabScript();
        void rodaMatlabScript();
        double readMatlabOutput();

    private:
        /* Atributos necessários à integração ao matlab */
        double param1, param2, param3, param4;
        string matlabPath;
        string workspaceAtual;
};