using namespace std;

#ifndef COMMUNICATION_H
    #define COMMUNICATION_H
#endif

#include <fstream>
#include <iostream>
#include <bits/stdc++.h> 

class Communication{
    public:
        //Construtores
        Communication(double kp, double ki, double kd, double posDesejada);
        // Getters and setters
        void writeMatlabScript();
        void rodaMatlabScript();
        double readMatlabOutput();

    private:
        double param1, param2, param3, param4;
        string matlabPath;
        string workspaceAtual;
};