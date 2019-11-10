using namespace std;

#ifndef CROMOSSOMO_H
    #define CROMOSSOMO_H
#endif

#define POS_DESEJADA 25.0

#include <chrono>
#include "PID.h"

class Cromossomo{
    public:
        // Construtores
        Cromossomo();
        Cromossomo(double kp, double ki, double kd);
        // Getters and Setters
        double getKp();
        double getKi();
        double getKd();
        double getAtingiuMaximo();
        double getFitnessValue();
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        // Printa
        void printaCromossomo();
    
    private:
        // Genes
        double kp, ki, kd;
        // Fitness Value
        double fitnessValue;
        // Debug
        bool atingiuMaximo;
        // Funcoes
        double fitnessFunction();
        PID setaPID();
};