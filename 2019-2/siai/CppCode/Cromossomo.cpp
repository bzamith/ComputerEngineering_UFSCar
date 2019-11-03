#include "Cromossomo.h"

Cromossomo::Cromossomo (){}

Cromossomo::Cromossomo(double kp, double ki, double kd){
    this->kp = kp;
    this->ki = ki;
    this->kd = kd;
    this->fitnessValue = fitnessFunction();
}

double Cromossomo::fitnessFunction(){
    PID pid = setaPID();
    auto tempoInicial = chrono::high_resolution_clock::now();
    this->atingiuMaximo = pid.rodaPID();
    auto tempoFinal = chrono::high_resolution_clock::now();
    if(this->atingiuMaximo == true)
        return 100000;
    else 
        return chrono::duration_cast<chrono::microseconds>(tempoFinal - tempoInicial).count();
} 

PID Cromossomo::setaPID(){
    PID pid = PID(POS_DESEJADA);
    pid.setKp(this->kp);
    pid.setKi(this->ki);
    pid.setKd(this->kd);
    return pid;
}

void Cromossomo::printaCromossomo(){
    cout << "Kp = " << this->kp << " | Ki = " << 
            this->ki << " | Kd = " << this->kd << " | Fitness Value = " << 
            this->fitnessValue << endl;
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

double Cromossomo::getFitnessValue(){
    return this->fitnessValue;
}

double Cromossomo::getAtingiuMaximo(){
    return this->atingiuMaximo;
}

void Cromossomo::setKp(double kp){
    this->kp = kp;
    this->fitnessValue = fitnessFunction();
}

void Cromossomo::setKi(double ki){
    this->ki = ki;
    this->fitnessValue = fitnessFunction();
}

void Cromossomo::setKd(double kd){
    this->kd = kd;
    this->fitnessValue = fitnessFunction();
}