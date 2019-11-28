/* PID.h
 * 
 * @description:
 *      Definição da classe PID que contém os métodos e dados referente ao controle PID
 *
 */
using namespace std;

/*
 *	Libraries and Definitions
 ***********************************************************************/
#ifndef PID_H
    #define PID_H
#endif

#include <iostream>
#include <cmath>
#include "SimulacaoMatlab.h"

class PID{
    public:
        /* Construtor */
        PID(double posDesejada);
        
        /* Métodos getters */
        double getKp();
        double getKi();
        double getKd();

        /* Métodos setters */
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        
        /* Executa o PID */
        double calcula();  

    private:
        /* Valores de Kp, Ki e Kd do PID */
        double kp, ki, kd;
        
        /* Posicao desejada */
        double posDesejada;                
};