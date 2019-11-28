/* Cromossomo.h
 * 
 * @description:
 *      Definições e métodos referentes ao tratamento de cada cromossomo individualmente
 *
 */
using namespace std;

/*
 *	Libraries and Definitions
 ***********************************************************************/
#ifndef CROMOSSOMO_H
    #define CROMOSSOMO_H
#endif

#define POS_DESEJADA 100.0

#include <chrono>
#include "PID.h"

class Cromossomo{
    public:
        /* Construtores */
        Cromossomo();
        Cromossomo(double kp, double ki, double kd);

        /* Métodos getters */
        double getKp();
        double getKi();
        double getKd();
        double getAtingiuMaximo();
        double getFitnessValue();

        /* Métodos setters */
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        
        /* Métodos de exibição */
        void printaCromossomo();
    
    private:

        /* Genes */
        double kp, ki, kd;

        /* Valor fitness */
        double fitnessValue;
        
        /* Métodos privados */
        double fitnessFunction();
        PID setaPID();
};