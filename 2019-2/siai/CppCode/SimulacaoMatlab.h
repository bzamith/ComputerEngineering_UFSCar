using namespace std;

#ifndef SIMULACAOMATLAB_H
    #define SIMULACAOMATLAB_H
#endif

#include <fstream>
#include <iostream>
#include <bits/stdc++.h> 

#define LIMITE_ERRO 0.1

class SimulacaoMatlab{
    public:
        //Construtores
        SimulacaoMatlab(double kp, double ki, double kd, double posDesejada);
        // Getters and setters
        void writeMatlabScript();
        void rodaMatlabScript();
        double readMatlabOutput();

    private:
        double param1, param2, param3, param4;
        string matlabPath;
        string workspaceAtual;
};