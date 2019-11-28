/* SimulacaoMatlab.cpp
 * 
 * @description:
 *      Implementação dos métodos necessarios para a integração ao matlab
 *
 */
 #include "SimulacaoMatlab.h"

/* Construtor */
SimulacaoMatlab::SimulacaoMatlab(double kp, double ki, double kd, double posDesejada){
    this->param1 = kp;
    this->param2 = ki;
    this->param3 = kd;
    this->param4 = posDesejada;
    this->matlabPath = "usr/local/MATLAB/R2018b/bin/";
    this->workspaceAtual = "/home/zamith/Documents/Faculdade/10o_Semestre/SIAI/CppCode/";
}

/* método: writeMatlabScript()
 *
 * @descrição: Define um script matlab com os atributos da classe
 * @parametros: nenhum
 * @retorno: nenhum
 */
void SimulacaoMatlab::writeMatlabScript(){
    ofstream outfile;
    double limiteInferior = this->param4*(double)(1-LIMITE_ERRO);
    double limiteSuperior = this->param4*(double)(1+LIMITE_ERRO);

    // criação do arquivo com o script
    outfile.open("script.m");
    outfile << "clear" << endl;
    outfile << "clc" << endl;
    outfile << "close all" << endl;
    outfile << "posDesejada = "<< this->param4 << ";" << endl;
    outfile << "kp = "<< this->param1 << ";" << endl;
    outfile << "ki = "<< this->param2 << ";" << endl;
    outfile << "kd = "<< this->param3 << ";" << endl;
    outfile << "limInferior ="<< limiteInferior << ";" << endl;
    outfile << "limSuperior ="<< limiteSuperior << ";" << endl;
    outfile << "pid = sim('PID.slx')" << endl;
    outfile << "posfinal.getdatasamples(size(pid,1))" << endl;
    outfile << "tempo = pid(size(pid,1))" << endl;
    outfile.close();
}

/* método: writeMatlabScript()
 *
 * @descrição: Roda o script matlab salvando a saída
 * @parametros: nenhum
 * @retorno: nenhum
 */
void SimulacaoMatlab::rodaMatlabScript(){
    string str = "export PATH=/"+this->matlabPath+":$PATH";
    const char *command = str.c_str(); 
    system(command);

    // str = "echo $PATH";
    // command = str.c_str();
    // system(command);

    // executa o matlab com o script definindo algumas variáveis
    str = "matlab -nodisplay -nosplash -nodesktop -r \"run('"+this->workspaceAtual+"script.m');exit;\" >> \"output.txt\"";
    command = str.c_str(); 
    system(command);
}


/* método: readMatlabOutput()
 *
 * @descrição: Le a saída do script matlab e retorna ela
 * @parametros: nenhum
 * @retorno: saída do matlab (double)
 */
double SimulacaoMatlab::readMatlabOutput(){
    ifstream infile; 
    string line;
    double valor;
    bool encontrou = false;

    // abre o arquivo com a saída
    infile.open("output.txt");
    while (getline(infile,line)){ 
        // procura o valor de tempo de execução
        if(line.rfind("tempo",0)==0){
            encontrou = true;
            getline(infile,line);
            break; 
        }
    }
    if(!encontrou){
        cout << "Output inesperado do Matlab" << endl;
        exit(0);
    }

    getline(infile,line);
    istringstream iss(line);
    iss >> valor;
    // fecha e deleta o arquivo 
    infile.close();
    remove("output.txt");

    // retorna o valor de tempo
    return valor;
}
