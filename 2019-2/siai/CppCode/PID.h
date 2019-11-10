using namespace std;

#ifndef PID_H
    #define PID_H
#endif

#include <iostream>
#include <cmath>
#include "Communication.h"

class PID{
    public:
        // Construtores
        PID(double posDesejada);
        // Getters and setters
        double getKp();
        double getKi();
        double getKd();
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        // Roda PID
        double rodaPID();  

    private:
        // Constantes
        double kp, ki, kd;
        // Posicao Desejada
        double posDesejada;                
};