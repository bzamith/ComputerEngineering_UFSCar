using namespace std;

#ifndef CROMOSSOMO_H
    #define CROMOSSOMO_H
#endif

#define POS_DESEJADA 80.0

#include <chrono>
#include "PID.h"

class Cromossomo{
    public:
        Cromossomo();
        Cromossomo(double kp, double ki, double kd);
        double fitnessFunction();
        PID criaPID();
        double getKp();
        double getKi();
        double getKd();
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
    
    private:
        double kp, ki, kd;
};