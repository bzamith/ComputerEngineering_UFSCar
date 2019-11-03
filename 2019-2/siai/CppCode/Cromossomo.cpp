#include "Cromossomo.h"

Cromossomo::Cromossomo (){}

Cromossomo::Cromossomo(double kp, double ki, double kd){
    this->kp = kp;
    this->ki = ki;
    this->kd = kd;
    this->fitnessValue = fitnessFunction();
}

double Cromossomo::fitnessFunction(){
    PID pid = criaPID();
    auto tempoInicial = chrono::high_resolution_clock::now();
    this->atingiuMaximo = pid.movimenta();
    auto tempoFinal = chrono::high_resolution_clock::now();
    if(this->atingiuMaximo == true)
        return 100000;
    else 
        return chrono::duration_cast<chrono::microseconds>(tempoFinal - tempoInicial).count();
} 

PID Cromossomo::criaPID(){
    PID pid = PID(POS_DESEJADA);
    pid.setKp(this->kp);
    pid.setKi(this->ki);
    pid.setKd(this->kd);
    return pid;
}

double Cromossomo::getFitnessValue(){
    return this->fitnessValue;
}

double Cromossomo::getKp(){
    return this->kp;
}

double Cromossomo::getKi(){
    return this->ki;
}

double Cromossomo::getKd(){
    return this->kd;
}

double Cromossomo::getAtingiuMaximo(){
    return this->atingiuMaximo;
}

void Cromossomo::setKp(double kp){
    this->kp = kp;
}

void Cromossomo::setKi(double ki){
    this->ki = ki;
}

void Cromossomo::setKd(double kd){
    this->kd = kd;
}

