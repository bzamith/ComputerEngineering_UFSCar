using namespace std;

#ifndef PID_H
    #define PID_H
#endif

#define NUM_ITERACOES_PID 100000
#define MAX_POS 1000.0
#define MIN_POS 0.0

#include <iostream>
#include <cmath>

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
        bool rodaPID();  

    private:
        // Constantes
        double kp, ki, kd;
        // Calculo
        double dt, integral;
        // Estado
        double preErro, erro, posAtual, termoProporcional, termoIntegrativo, termoDerivativo;
        // Posicao Desejada
        double posDesejada;
        // Funcoes 
        void calculaPID();  
        void calculaErro();
        void calculaProporcional();
        void calculaIntegrativo();
        void calculaDerivativo();
        double calculaPosicaoSugerida();
        void calculaPosicaoFinal(double posSugerida);
                
};