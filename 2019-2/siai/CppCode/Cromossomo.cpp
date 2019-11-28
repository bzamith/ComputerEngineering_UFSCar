/* Cromossomo.cpp
 * 
 * @description:
 *      Implementação dos métodos referentes a cada cromossomo individualmente
 *
 */
#include "Cromossomo.h"

/* Construtores */
Cromossomo::Cromossomo (){}

/* Construtor com valores de genes Kp, Ki e Kd definidos */
Cromossomo::Cromossomo(double kp, double ki, double kd){
    this->kp = kp;
    this->ki = ki;
    this->kd = kd;
    this->fitnessValue = fitnessFunction();
}

/* método: fitnessFunction()
 *
 * @descrição: Calcula  e retorna o valor fitness do cromossomo
 * @parametros: nenhum
 * @retorno: valor fitness do cromossomo
 */
double Cromossomo::fitnessFunction(){
    PID pid = setaPID();
    return pid.calcula();
} 

/* método: setaPID()
 *
 * @descrição: Define os valores Kp, Ki e Kd do PID
 * @parametros: nenhum
 * @retorno: Retorna um objeto PID com os valores settados
 */
PID Cromossomo::setaPID(){
    PID pid = PID(POS_DESEJADA);
    pid.setKp(this->kp);
    pid.setKi(this->ki);
    pid.setKd(this->kd);
    return pid;
}

/* método: printaCromossomo()
 *
 * @descrição: Exibe na tela os valores do cromossomo
 * @parametros: nenhum
 * @retorno: nenhum
 */
void Cromossomo::printaCromossomo(){
    cout << "Kp = " << this->kp << " | Ki = " << 
            this->ki << " | Kd = " << this->kd << " | Fitness Value = " << 
            this->fitnessValue << endl;
}

/* método: getKp()
 *
 * @descrição: Acessa o valor de Kp do cromossosmo
 * @parametros: nenhum
 * @retorno: valor de Kp (tipo double)
 */
double Cromossomo::getKp(){
    return this->kp;
}

/* método: getKi()
 *
 * @descrição: Acessa o valor de Ki do cromossosmo
 * @parametros: nenhum
 * @retorno: valor de Ki (tipo double)
 */
double Cromossomo::getKi(){
    return this->ki;
}

/* método: getKd()
 *
 * @descrição: Acessa o valor de Kd do cromossosmo
 * @parametros: nenhum
 * @retorno: valor de Kd (tipo double)
 */
double Cromossomo::getKd(){
    return this->kd;
}

/* método: getFitnessValue()
 *
 * @descrição: Acessa o valor fitness do cromossomo
 * @parametros: nenhum
 * @retorno: fitnessValue (tipo double)
 */
double Cromossomo::getFitnessValue(){
    return this->fitnessValue;
}

/* método: setKp()
 *
 * @descrição: Define um valor de Kp para o cromossomo
 * @parametros: valor de Kp (double)
 * @retorno: nenhum
 */
void Cromossomo::setKp(double kp){
    this->kp = kp;
    this->fitnessValue = fitnessFunction();
}

/* método: setKi()
 *
 * @descrição: Define um valor de Ki para o cromossomo
 * @parametros: valor de Ki (double)
 * @retorno: nenhum
 */
void Cromossomo::setKi(double ki){
    this->ki = ki;
    this->fitnessValue = fitnessFunction();
}

/* método: setKd()
 *
 * @descrição: Define um valor de Kd para o cromossomo
 * @parametros: valor de Kd (double)
 * @retorno: nenhum
 */
void Cromossomo::setKd(double kd){
    this->kd = kd;
    this->fitnessValue = fitnessFunction();
}