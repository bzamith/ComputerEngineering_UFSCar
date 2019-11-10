#include "PID.h"

PID::PID(double posDesejada){
    this->kp = 0;
    this->ki = 0;
    this->kd = 0;
    this->posDesejada = posDesejada;
}

double PID::rodaPID(){
    Communication com = Communication(this->kp,this->ki,this->kd,this->posDesejada);
    com.writeMatlabScript();
    com.runMatlabScript();
    return com.readMatlabOutput();
}

double PID::getKp(){
    return this->kp;
}

double PID::getKi(){
    return this->ki;
}

double PID::getKd(){
    return this->kd;
}

void PID::setKp(double kp){
    this->kp = kp;
}

void PID::setKi(double ki){
    this->ki = ki;
}

void PID::setKd(double kd){
    this->kd = kd;
}