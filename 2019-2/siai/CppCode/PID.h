#ifndef PID_H
    #define PID_H
#endif

#include <cmath>

class PID{
    public:
        PID(double posDesejada);
        
        //getters and setters
        double getKp();
        double getKi();
        double getKd();
        void setKp(double kp);
        void setKi(double ki);
        void setKd(double kd);
        void movimenta();  

    private:
        // Constantes
        double kp, ki, kd;
        // Calculo
        double dt, integral;
        // Restricoes
        double maxPos, minPos, maxIteracoes;
        // Estado
        double preErro, erro, posAtual, termoProporcional, termoIntegrativo, termoDerivativo;
        // Posicao Desejada
        double posDesejada;
        // Funcoes 
        void calculaErro();
        void calculaProporcional();
        void calculaIntegrativo();
        void calculaDerivativo();
        double calculaPosicaoSugerida();
        void calculaPosicaoFinal(double posSugerida);
        void calculaPID();          
};