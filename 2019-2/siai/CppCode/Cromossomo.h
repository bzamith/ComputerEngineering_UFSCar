using namespace std;

#ifndef CROMOSSOMO_H
    #define CROMOSSOMO_H
#endif

#define POS_DESEJADA 100.0

#include <chrono>
#include "PID.h"

class Cromossomo{
    public:
        Cromossomo();
        Cromossomo(double kp, double ki, double kd);
        double getKp();
        double getKi();
        double getKd();
        double getAtingiuMaximo();
        double getFitnessValue();
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        void printaCromossomo();
    
    private:
        double kp, ki, kd;
        double fitnessValue;
        bool atingiuMaximo;
        double fitnessFunction();
        PID criaPID();
};