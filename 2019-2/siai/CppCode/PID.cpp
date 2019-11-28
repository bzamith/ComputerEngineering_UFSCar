/* PID.cpp
 * 
 * @description:
 *      Implementação dos métodos referentes a tecnica de controle PID
 *
 */
#include "PID.h"

/* Construtor */
PID::PID(double posDesejada){
    this->kp = 0;
    this->ki = 0;
    this->kd = 0;
    this->posDesejada = posDesejada;
}

/* método: calcula()
 *
 * @descrição: Roda o PID no matlab e retorna a saída
 * @parametros: valores de kp (double), ki (double), kd (double) e posição desejada (double)
 * @retorno: Saída do matlab (double)
 */
double PID::calcula(){
    // Instancia objeto integrado ao matlab
    SimulacaoMatlab com = SimulacaoMatlab(this->kp,this->ki,this->kd,this->posDesejada);
    com.writeMatlabScript();
    com.rodaMatlabScript();
    // retorna o valor obtido
    return com.readMatlabOutput();
}

/* método: getKp()
 *
 * @descrição: Acessa o valor de Kp do objeto
 * @parametros: nenhum
 * @retorno: Kp (double)
 */
double PID::getKp(){
    return this->kp;
}

/* método: getKi()
 *
 * @descrição: Acessa o valor de Ki do objeto
 * @parametros: nenhum
 * @retorno: Ki (double)
 */
double PID::getKi(){
    return this->ki;
}

/* método: getKd()
 *
 * @descrição: Acessa o valor de Kd do objeto
 * @parametros: nenhum
 * @retorno: Kd (double)
 */
double PID::getKd(){
    return this->kd;
}

/* método: setKp()
 *
 * @descrição: Define o valor de Kp do objeto
 * @parametros: Kp (double)
 * @retorno: nenhum
 */
void PID::setKp(double kp){
    this->kp = kp;
}

/* método: setKi()
 *
 * @descrição: Define o valor de Ki do objeto
 * @parametros: Ki (double)
 * @retorno: nenhum
 */
void PID::setKi(double ki){
    this->ki = ki;
}

/* método: setKd()
 *
 * @descrição: Define o valor de Kd do objeto
 * @parametros: Kd (double)
 * @retorno: nenhum
 */
void PID::setKd(double kd){
    this->kd = kd;
}